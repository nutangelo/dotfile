#!/bin/bash

echo "📄----------Start Action: Install neovim by homebrew ----------"

echo "🍾 Installing neovim..."
if brew install neovim; then
    echo "✅ neovim installed successfully"
else
    echo "❌Failed: brew install neovim"
    echo "📄----------Finish Action: Install neovim by homebrew ----------"
    exit 1
fi

echo "🍾 Backing up existing nvim configs..."
mv ~/.config/nvim{,.bak} 2>/dev/null && echo "✅ ~/.config/nvim backed up"
mv ~/.local/share/nvim{,.bak} 2>/dev/null && echo "✅ ~/.local/share/nvim backed up"
mv ~/.local/state/nvim{,.bak} 2>/dev/null && echo "✅ ~/.local/state/nvim backed up"
mv ~/.cache/nvim{,.bak} 2>/dev/null && echo "✅ ~/.cache/nvim backed up"

echo "🍾 Cloning LazyVim starter config..."
if git clone https://github.com/LazyVim/starter ~/.config/nvim; then
    echo "✅ LazyVim config cloned successfully"
else
    echo "❌Failed: git clone LazyVim starter"
    echo "📄----------Finish Action: Install neovim by homebrew ----------"
    exit 1
fi

echo "🍾 Cleaning up git repository..."
if rm -rf ~/.config/nvim/.git; then
    echo "✅ .git directory removed successfully"
else
    echo "❌Failed: rm -rf ~/.config/nvim/.git"
    echo "📄----------Finish Action: Install neovim by homebrew ----------"
    exit 1
fi

echo "✅Done"
echo "📄----------Finish Action: Install neovim by homebrew ----------"

