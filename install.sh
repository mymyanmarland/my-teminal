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



#!/bin/bash
# ~/dotfiles/install.sh

# --- 1. အရောင်များ သတ်မှတ်ခြင်း (လှအောင်လို့ပါ) ---
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}🚀 Starting Ultimate Terminal Setup...${NC}"

# --- 2. System Update & Basic Tools ---
echo -e "${GREEN}📦 Updating System & Installing Basics...${NC}"
sudo apt update && sudo apt upgrade -y
# Web Dev နဲ့ Python အတွက် လိုအပ်တဲ့ အခြေခံ Package များ
sudo apt install -y git curl wget unzip zip build-essential jq \
    python3 python3-pip python3-venv \
    software-properties-common

# --- 3. Web Development Setup (Node.js) ---
echo -e "${GREEN}🌐 Setting up Web Development Environment...${NC}"

# Node.js (LTS Version) ကို တရားဝင် Source ကနေ ဆွဲတင်မယ်
if ! command -v node &> /dev/null; then
    curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
    sudo apt install -y nodejs
fi

# Essential Global NPM Packages (Web Dev အတွက် လိုကိုလိုတာတွေ)
# - typescript: TS ရေးဖို့
# - nodemon: Backend ရေးရင် Server auto restart လုပ်ဖို့
# - yarn & pnpm: Package Manager တွေ
# - serve: Web file တွေကို ချက်ချင်း run ကြည့်ဖို့
echo "Installing Global NPM Packages..."
sudo npm install -g typescript ts-node nodemon yarn pnpm serve @anthropic-ai/claude-code

# --- 4. Python & AI Development Setup ---
echo -e "${GREEN}🐍 Setting up Python & AI Environment...${NC}"

# Pip ကို update အရင်လုပ်မယ်
python3 -m pip install --upgrade pip

# Python Library အစုံအလင် (Web, Data, AI)
# - requests, httpx: API ခေါ်ဖို့
# - flask, fastapi, uvicorn: Python Web Server ရေးဖို့
# - pandas, numpy: Data တွက်ချက်ဖို့
# - python-dotenv: .env ဖိုင်တွေ ဖတ်ဖို့
# - openai, anthropic, langchain: AI သုံးဖို့
echo "Installing Python Libraries..."
pip3 install --user \
    requests httpx \
    flask django fastapi uvicorn \
    pandas numpy matplotlib \
    python-dotenv \
    black flake8 \
    openai anthropic langchain

# Claude/AI Tools (User request: ClawdBot, Claude Code etc.)
# မှတ်ချက် - ဒီနေရာမှာ Package နာမည် အတိအကျမသိရင် Error တက်နိုင်လို့ Generic ထည့်ပေးထားပါတယ်
# pip3 install --user clawdbot  <-- (ဒါက PyPI မှာရှိမှ အလုပ်လုပ်ပါမယ်)

# --- 5. Terminal Appearance (Starship) ---
# Terminal ကို Hacker ဆန်ဆန် လှသွားအောင် Starship ထည့်မယ်
if ! command -v starship &> /dev/null; then
    echo -e "${GREEN}✨ Installing Starship Prompt...${NC}"
    curl -sS https://starship.rs/install.sh | sh -s -- -y
    # Bashrc မှာ Starship ကို လှမ်းချိတ်မယ်
    if ! grep -q "starship init bash" ~/.bashrc; then
        echo 'eval "$(starship init bash)"' >> ~/.bashrc
    fi
fi

# --- 6. Dotfiles Linking (Setting ချိတ်ခြင်း) ---
echo -e "${GREEN}🔗 Linking Dotfiles...${NC}"

DOTFILES_DIR=~/dotfiles
BACKUP_DIR=~/dotfiles_old
mkdir -p $BACKUP_DIR

# ချိတ်မယ့် ဖိုင်စာရင်း
files="bashrc bash_aliases"

for file in $files; do
    # ဖိုင်အဟောင်းရှိရင် Backup လုပ်
    if [ -f ~/.$file ] && [ ! -L ~/.$file ]; then
        mv ~/.$file $BACKUP_DIR/
    fi
    # Link မရှိသေးရင် Link ချိတ်
    if [ ! -L ~/.$file ]; then
        ln -s $DOTFILES_DIR/$file ~/.$file
        echo "Linked ~/.$file"
    fi
done

echo -e "${BLUE}🎉 Setup Complete! Please restart your terminal or run 'source ~/.bashrc'${NC}"
