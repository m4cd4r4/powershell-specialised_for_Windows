<#
.SYNOPSIS
  Generates test files and runs robocopy with multiple threads to test NIC teaming performance.

.DESCRIPTION
  Creates a test folder with large files, ensures destination share is reachable,
  and initiates robocopy with configurable parallelism.

.NOTES
  Requires administrative access to write to network share.
  Run on the source machine.
#>

param (
    [string]$SourceFolder = "C:\RobocopyTestData",
    [string]$DestinationUNC = "\\<destination-machine-hostname.\C$\Temp\robocopy_destination",
    [int]$FileCount =   10,
    [int]$FileSizeMB = 1000,
    [int]$ThreadCount = 32,
    [string]$LogPath = "C:\RobocopyTestLog.txt"
)

function Create-TestFiles {
    Write-Host "Creating $FileCount files of $FileSizeMB MB in $SourceFolder..." -ForegroundColor Cyan
    if (-not (Test-Path $SourceFolder)) {
        New-Item -ItemType Directory -Path $SourceFolder | Out-Null
    }

    for ($i = 1; $i -le $FileCount; $i++) {
        $file = Join-Path $SourceFolder "file$i.test"
        fsutil file createnew $file ($FileSizeMB * 1MB) | Out-Null
    }

    Write-Host "✅ File generation complete." -ForegroundColor Green
}

function Test-DestinationShare {
    Write-Host "Testing access to destination share: $DestinationUNC" -ForegroundColor Cyan
    if (-not (Test-Path $DestinationUNC)) {
        Write-Error "❌ Cannot access destination: $DestinationUNC"
        exit 1
    }
}

function Run-Robocopy {
    Write-Host "Starting robocopy with $ThreadCount threads..." -ForegroundColor Yellow
    $args = @(
        "`"$SourceFolder`"",
        "`"$DestinationUNC`"",
        "/MT:$ThreadCount",
        "/E", "/Z", "/R:0", "/W:0",
        "/NP", "/NFL", "/NDL",
        "/LOG:$LogPath"
    )

    robocopy @args | Out-Null
    Write-Host "✅ Robocopy completed. See log at: $LogPath" -ForegroundColor Green
}

# Main Execution
Create-TestFiles
Test-DestinationShare
Run-Robocopy
