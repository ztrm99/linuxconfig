# Fix Java Problem
export _JAVA_AWT_WM_NONREPARENTING=1

source ~/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Manual Config
#PATH=

# Manual Aliases
alias ll='lsd -lh --group-dirs=first'
alias la='lsd -a --group-dirs=first'
alias l='lsd --group-dirs=first'
alias lla='lsd -lha --group-dirs=first'
alias ls='lsd --group-dirs=first'
alias cat='/usr/bin/bat --paging=never'
alias catl='/usr/bin/bat'
alias catn='/usr/bin/cat'


# Function

function extractPorts(){
	ports="$(cat $1 | grep -oP '\d{1,5}/open' | awk '{print $1}' FS='/' | xargs | tr ' ' ',' )"
	ip_address="$(cat $1 | grep -oP '\d(1,3)\.\d(1,3)\.\d(1,3)' | sort -u | head -n 1)"
	echo -e "\n[*] Extracting information...\n" > extractPorts.tmp
	echo -e "\t[*] IP Address: $ip_address" >> extractPorts.tmp
	echo -e "\t[*] Open Ports $ports\n" >> extractPorts.tmp
	#echo $ports | tr -d '\n' | xclip -selection clipboard
	echo $ports | tr -d '\n' | xclip
	echo -e "[*] Ports copied to clipboard\n" >> extractPorts.tmp
	cat extractPorts.tmp; rm extractPorts.tmp
}

function mkt(){
	mkdir {nmap,content,scripts,exploits}
}

function rmk(){
	scrub -p dod $1; shred -zun 10 -v $1
}
# fzf improvement
function fzf-lovely(){
        if [ "$1" = "h" ]; then
                fzf -m --reverse --preview-window down:20 --preview '[[ $(file --mime {}) =~ binary ]] &&
                        echo {} is a binary file ||
                         (bat --style=numbers --color=always {} ||
                          highlight -O ansi -l {} ||
                          coderay {} ||
                          rougify {} ||
                          cat {}) 2> /dev/null | head -500'
        else
                fzf -m --preview '[[ $(file --mime {}) =~ binary ]] &&
                                 echo {} is a binary file ||
                                 (bat --style=numbers --color=always {} ||
                                  highlight -O ansi -l {} ||
                                  coderay {} ||
                                  rougify {} ||
                                  cat {}) 2> /dev/null | head -500'
        fi
}

# Set 'man' colors
function man() {
    env \
    LESS_TERMCAP_mb=$'\e[01;31m' \
    LESS_TERMCAP_md=$'\e[01;31m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_se=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[01;44;33m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[01;32m' \
    man "$@"
}



SAVEHIST=1500
HISTFILE=~/.zsh_history

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Manual Plugins

source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh-nmap/zsh-nmap.zsh
source /usr/share/zsh-cd/zsh-cd.zsh
