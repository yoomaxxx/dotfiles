export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

zstyle ':omz:update' mode reminder

plugins=(
  git git-escape-magic fzf gh gitignore kubectl
  minikube docker docker-compose pip python node nvm mise
  tmux zsh-autosuggestions zsh-vi-mode
)

source $ZSH/oh-my-zsh.sh

export DOCKER_HOST="unix:///run/user/1000/docker.sock"
export VISUAL="nvim"
export EDITOR="nvim"
export PAGER="less -R"
export BAT_THEME="ansi"
export BROWSER="/usr/bin/brave-browser"
export GALLIUM_DRIVER="d3d12"

path=(
  $HOME/.local/share/nvim/mason/bin
  $HOME/.local/bin
  $HOME/.cargo/bin
  $HOME/bin
  $HOME/.npm/bin
  $path
)

export PATH

# fzf

export FZF_DEFAULT_OPTS="
--color=fg:#c0caf5,bg:#24283b,hl:#ff9e64
--color=fg+:#c0caf5,bg+:#292e42,hl+:#ff9e64
--color=info:#7aa2f7,prompt:#7dcfff,pointer:#7dcfff
--color=marker:#9ece6a,spinner:#9ece6a,header:#9ece6a"

# kubectl completion

source <(kubectl completion zsh)

# wsl

keep_current_path() {
  printf "\e]9;9;%s\e\\" "$(wslpath -w "$PWD")"
}

precmd_functions+=(keep_current_path)

# zoxide

eval "$(zoxide init zsh)"

# rye

eval "$(rye self completion -s zsh)"

# nvm

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# mise

eval "$(mise activate zsh)"

# venv

activate_venv_on_cd() {
  local venv_dir=".venv"
  if [[ -d "$PWD/$venv_dir" ]]; then
    source "$PWD/$venv_dir/bin/activate"
  fi
}

autoload -U add-zsh-hook
add-zsh-hook chpwd activate_venv_on_cd

# yamlfix

export YAMLFIX_EXPLICIT_START="false"

# tmux

if [ -n "$PS1" ] && [ -z "$TMUX" ]; then
  tmux new-session -A -s main
fi
