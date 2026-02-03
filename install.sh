#!/bin/bash
# ~/dotfiles/install.sh

# သိမ်းထားမယ့် ဖိုဒါလမ်းကြောင်းများ
DOTFILES_DIR=~/dotfiles
BACKUP_DIR=~/dotfiles_old

# Backup ဖိုဒါ အရင်ဆောက်မယ်
echo "Creating backup directory at $BACKUP_DIR..."
mkdir -p $BACKUP_DIR

# ချိတ်ဆက်မယ့် ဖိုင်စာရင်း
files="bashrc bash_aliases"

for file in $files; do
    # ၁။ ဖိုင်အဟောင်းရှိရင် Backup လုပ်မယ်
    if [ -f ~/.$file ]; then
        echo "Moving existing .$file to $BACKUP_DIR"
        mv ~/.$file $BACKUP_DIR/
    fi

    # ၂။ ဖိုင်အသစ်ကို Link ချိတ်မယ်
    echo "Creating symlink to $file in home directory."
    ln -s $DOTFILES_DIR/$file ~/.$file
done


echo "Installing Software..."

# 1. Python ပါမပါ စစ်မယ်၊ မပါရင် သွင်းမယ်
if ! command -v python3 &> /dev/null; then
    echo "Python not found. Installing..."
    sudo apt update && sudo apt install -y python3 python3-pip
fi

# 2. Claude Code (သို့) Python Tools တွေ သွင်းမယ်
echo "Installing Python Tools..."
pip3 install --user clawdbot  # (ဥပမာ)
# pip3 install --user claude-code (တကယ်လို့ Python package ဖြစ်ခဲ့ရင်)

# 3. Node.js နဲ့ NPM Tools တွေ သွင်းမယ် (Claude Code က Node နဲ့ဆိုရင်)
if ! command -v npm &> /dev/null; then
    sudo apt install -y nodejs npm
fi
# npm install -g @anthropic-ai/claude-code

echo "All softwares installed!"

echo "Done! Restart your terminal to see changes."
