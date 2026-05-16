#!/bin/bash

# 1. Ensure the script is run as root
if [ "$EUID" -ne 0 ]; then
  echo "❌ Please run this script as root (e.g., sudo ./install-vscode.sh)"
  exit 1
fi

echo "🚀 Starting Visual Studio Code Installation..."

# 2. Debian / Ubuntu / Linux Mint (APT)
if command -v apt &> /dev/null; then
    echo "📦 Detected APT package manager (Debian/Ubuntu-based system)..."
    
    # Install dependencies
    apt-get update
    apt-get install -y wget gpg apt-transport-https

    # Download Microsoft GPG key and add repository
    wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
    install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
    echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" | tee /etc/apt/sources.list.d/vscode.list > /dev/null
    rm -f packages.microsoft.gpg

    # Update package list and install VS Code
    apt-get update
    apt-get install -y code
    
    echo "✅ Visual Studio Code installed successfully!"

# 3. Fedora / CentOS / RHEL (DNF)
elif command -v dnf &> /dev/null; then
    echo "📦 Detected DNF package manager (Fedora/RHEL-based system)..."
    
    # Import Microsoft GPG key and add repository
    rpm --import https://packages.microsoft.com/keys/microsoft.asc
    echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" | tee /etc/yum.repos.d/vscode.repo > /dev/null

    # Update package list and install VS Code
    dnf check-update
    dnf install -y code
    
    echo "✅ Visual Studio Code installed successfully!"

# 4. Universal Snap Fallback
elif command -v snap &> /dev/null; then
    echo "📦 APT/DNF not found. Falling back to Snap package manager..."
    snap install --classic code
    echo "✅ Visual Studio Code installed successfully via Snap!"

# 5. Unsupported OS
else
    echo "❌ Unsupported package manager. Please install VS Code manually."
    exit 1
fi