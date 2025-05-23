export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="xiong-chiamiov-plus"

plugins=(git zsh-syntax-highlighting)

fastfetch -c void

alias xi="doas /usr/bin/xbps-install"
alias xr="doas /usr/bin/xbps-remove"
alias xq="doas /usr/bin/xbps-query"

export GTK_THEME="catppuccin-mocha-pink-standard+default"

export XCURSOR_THEME="Bibata-Modern-Ice"
export XCURSOR_SIZE=24

export XDG_DATA_DIRS="/usr/share:/usr/local/share:/var/lib/flatpak/exports/share:$HOME/.local/share/flatpak/exports/share"
export PATH="$HOME/.local/bin:$PATH"

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source $ZSH/oh-my-zsh.sh

