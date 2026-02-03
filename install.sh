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

echo "Done! Restart your terminal to see changes."
