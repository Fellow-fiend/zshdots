# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Set the directory we want to store a zsh plugin manager Zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
CONFIG_PATH="${XDG_CONFIG_HOME}:-${HOME/.config}/zsh"

# Download Zinit, it it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
	mkdir -p "$(dirname $ZINIT_HOME)"
	git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"


# Plugins
# Powerline
zinit ice depth=1; zinit light romkatv/powerlevel10k
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh".
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# syntax highlighting
#zinit light zsh-users/zsh-syntax-highlighting
zinit light zdharma-continuum/fast-syntax-highlighting
fast-theme -q q-jmnemonic

# snippets
zinit snippet "https://github.com/ohmyzsh/ohmyzsh/blob/master/lib/git.zsh"
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::cp
# completions
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit ice lucid nocompile
zinit load MenkeTechnologies/zsh-expand

autoload -U compinit && compinit
zinit cdreplay -q

bindkey -v
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward


# History
HISTSIZE=10000
HISTFILE="${XDG_CACHE_HOME:-$HOME/.cache}/.zsh_history"
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt histignorespace
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

setopt auto_menu
setopt list_packed
setopt list_types
setopt complete_in_word
setopt always_to_end
setopt globdots

# Completion styling
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|=*' 'l:|=* r:|=*' 'r:|?=**'
zstyle ':completion:*' list-colors '${(s.:.)LS_COLORS}'
zstyle ':completion:*' special-dirs true

# Exports
export PATH="$PATH"
export QT_QPA_PLATFORM=wayland
export XDG_CURRENT_DESKTOP=wlr


#dircolors -b > /dev/null

# Alias
alias ls="ls --color"
alias la="ls -a"
alias l="ls -AF --group-directories-first"
alias ll="l -lh"
alias v="nvim"
alias cp="cpv"
alias ff="fastfetch"
alias icat="kitten icat"
alias gsb="git status --short --branch --untracked-files=all"

# Shell integrations
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"

