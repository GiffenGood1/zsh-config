# top of your .zshrc file

export ZIT_MODULES_PATH="${ZDOTDIR}/zit"
export PATH=$HOME/.local/bin:$PATH

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# UNCOMMENT TO ENABLE AUTO NODE VERSION SWITCHING 

# autoload -U add-zsh-hook
# load-nvmrc() {
#   local node_version="$(nvm version)"
#   local nvmrc_path="$(nvm_find_nvmrc)"

#   if [ -n "$nvmrc_path" ]; then
#     local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

#     if [ "$nvmrc_node_version" = "N/A" ]; then
#       nvm install
#     elif [ "$nvmrc_node_version" != "$node_version" ]; then
#       nvm use
#     fi
#   elif [ "$node_version" != "$(nvm version default)" ]; then
#     echo "Reverting to nvm default version"
#     nvm use default
#   fi
# }
# add-zsh-hook chpwd load-nvmrc
# load-nvmrc

# Options
zle_highlight=('paste:none')
unsetopt BEEP

#############################################################################
# History Configuration
##############################################################################
HISTSIZE=5000               #How many lines of history to keep in memory
HISTFILE=${ZDOTDIR}/.zsh_history     #Where to save history to disk
SAVEHIST=5000               #Number of history entries to save to disk
# HISTDUP=erase               #Erase duplicates in the history file
unsetopt EXTENDED_HISTORY
setopt    appendhistory     #Append history to the history file (no overwriting)
setopt    sharehistory      #Share history across terminals
setopt    incappendhistory  #Immediately append to the history file, not just when a term is killed

# Source Zit file
source "${ZIT_MODULES_PATH}/zit.zsh"

# Install and loads plugins
zit-il "https://github.com/hlissner/zsh-autopair" "plugins/zsh-autopair" "autopair.zsh"
zit-il "https://github.com/zsh-users/zsh-autosuggestions" "plugins/zsh-autosuggestions" "zsh-autosuggestions.zsh"
zit-il "https://github.com/dashixiong91/zsh-vscode" "plugins/zsh-vscode" "zsh-vscode.plugin.zsh"
zit-il "https://github.com/zsh-users/zsh-completions" "plugins/zsh-completions" "zsh-completions.plugin.zsh"
zit-il "https://github.com/hcgraf/zsh-sudo" "plugins/sudo" "sudo.plugin.zsh"

eval "$(zoxide init zsh)"

# ALIAS
# alias ls="ls -lhaG --color=always | sed -re 's/^[^ ]* //'"
alias ls="ls -lhaG --color=always"
# alias la = "!git config -l | grep alias | cut -c 7-"
alias code="vs"
alias reload="exec $SHELL"

# BINDS

# Basic auto/tab complete:

zstyle ':completion:*' menu select
zmodload zsh/complist
_comp_options+=(globdots) # Include hidden files.

autoload -Uz compinit

for dump in ~/.zcompdump(N.mh+24); do
  compinit
done

compinit -C

# Prompt theme
eval "$(starship init zsh)"


# Needs to be at end of file
zit-il "https://github.com/zsh-users/zsh-syntax-highlighting" "plugins/zsh-syntax-highlighting" "zsh-syntax-highlighting.zsh"

sync_zshrc() {
  git -C "${ZDOTDIR}" pull
  git -C "${ZDOTDIR}" add .zshrc
  git -C "${ZDOTDIR}" commit -m "Sync .zshrc"
  git -C "${ZDOTDIR}" push
}


# script to compile ZSH files and speed-up loading
# should be called last
zit-lo "/" "compile-zsh-files.zsh"


# zprof # bottom of .zshrc