<<<<<<< HEAD
# neon

A sleek, intelligent, and minimalist frontend wrapper for the XBPS package manager on Void Linux. It provides a customized command-line interface with silent background operations, progress animations, safety confirmation prompts, and built-in Levenshtein typo protection.

## Features

- **Silent Operations:** Intercepts messy standard outputs and package download bars, keeping your terminal uncluttered.
- **Visual Progress Feedback:** Provides a clean, minimalist filling progress bar while background operations execute.
- **Transaction Layout Preview:** Intercepts and parses native XBPS layouts to present human-readable installations, removals, or system updates before execution.
- **Smart Typo Protection:** Automatically calculates edit distances to suggest the correct core command if a mistyped string is provided.
- **User Configuration Profiles:** Automatically deploys and reads configurations from a local dotfile to easily customize visual themes.
- **Safe Cache and Dependency Purging:** Implements unified cache scrubbing and orphan removal routines in a single streamlined interface.

## System Prerequisites

- Void Linux operating system
- XBPS package manager (`xbps-install`, `xbps-query`, `xbps-remove`)
- Standard Unix utilities (`bash`, `sed`, `awk`, `ping`, `getent`)

## Installation

### 1. Clone the Repository
```bash
git clone https://github.com/lair-creator/neon-pkg.git
cd neon-pkg

sudo ./install.sh

