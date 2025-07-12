#!/bin/bash

echo """
📄----------Start Action: Install Homebrew on Ubuntu with mirror settings----------
"""

echo "🍾Step 1: Installing dependencies..."
if sudo apt-get update && sudo apt-get install -y git curl; then
    echo "✅Dependencies installed successfully"
else
    echo "❌Failed: Installing dependencies"
    exit 1
fi

echo "🍾Step 2: Setting temporary mirror variables..."
export HOMEBREW_BREW_GIT_REMOTE="http://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git"
export HOMEBREW_CORE_GIT_REMOTE="http://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git"
export HOMEBREW_API_DOMAIN="https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles/api"
export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles"
echo "✅Mirror variables set temporarily"

echo "🍾Step 3: Installing from mirror..."
if git clone --depth=1 http://mirrors.tuna.tsinghua.edu.cn/git/homebrew/install.git brew-install && \
   /bin/bash brew-install/install.sh && \
   rm -rf brew-install; then
    echo "✅Homebrew installed from mirror"
else
    echo "❌Failed: Installing from mirror"
    exit 1
fi

echo "🍾Step 4: Initializing Homebrew..."
if eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)" && \
   echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> ~/.bashrc && \
   source ~/.bashrc; then
    echo "✅Homebrew initialized"
else
    echo "❌Failed: Initializing Homebrew"
    exit 1
fi

echo "🍾Step 5: Persisting mirror configuration..."
if cat << EOF >> ~/.bashrc
export HOMEBREW_BREW_GIT_REMOTE="http://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git"
export HOMEBREW_CORE_GIT_REMOTE="http://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git"
export HOMEBREW_API_DOMAIN="https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles/api"
export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles"
EOF
then
    source ~/.bashrc
    echo "✅Mirror configuration persisted"
else
    echo "❌Failed: Persisting mirror configuration"
    exit 1
fi

echo """
✅Done: Homebrew successfully installed with mirror settings
📄----------Finish Action: Install Homebrew on Ubuntu with mirror settings----------
"""

