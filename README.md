# 🚀 Robocopy Throughput Benchmarking Scripts

[![PowerShell](https://img.shields.io/badge/Language-PowerShell-blue.svg)](https://docs.microsoft.com/powershell/)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)
[![Platform](https://img.shields.io/badge/platform-Windows-lightgrey.svg)](https://microsoft.com/windows)

This repository contains specialized **PowerShell scripts** for high-performance testing and benchmarking of **network throughput** using `robocopy`. Designed for Windows environments, these scripts are ideal for verifying **NIC teaming performance**, testing **SMB bandwidth**, and simulating **multi-threaded file transfer workloads**.

---

## 📌 Features

- ✅ Automatically benchmarks `robocopy` performance across multiple `/MT` thread counts
- ✅ Reports optimal configuration based on measured throughput (Mb/s and MB/s)
- ✅ Uses large synthetic files to simulate real-world data movement
- ✅ Clean logging and optional cleanup of test data
- ✅ No external dependencies (uses native tools)

---

## 📁 Scripts

### `Robocopy-AutoTune.ps1`

Benchmarks file transfer performance by:
1. Generating large test files
2. Copying them to a specified UNC path with varying `/MT` values
3. Parsing and ranking the results

---

## 🖥️ Requirements

- Windows 10/11 or Server 2016+
- Administrator privileges
- Sufficient disk space on both source and destination
- SMB file share access

---

## 📦 Installation

```bash
git clone https://github.com/your-username/robocopy-benchmarking.git
cd robocopy-benchmarking
