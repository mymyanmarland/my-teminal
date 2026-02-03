# ~/dotfiles/bashrc

# 1. Alias ဖိုင်ရှိရင် လှမ်းချိတ်မယ်
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# 2. History (အရင်ရိုက်ခဲ့တဲ့ command) တွေကို များများမှတ်ထားမယ်
HISTSIZE=1000
HISTFILESIZE=2000

# 3. Terminal Prompt အရောင် ပြောင်းမယ် (User ကို အစိမ်းရောင်၊ Path ကို အပြာရောင်)
PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

# 4. Default Editor ကို nano (သို့) vim ထားမယ်
export EDITOR='nano'
