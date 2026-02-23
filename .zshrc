export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

zstyle ':omz:update' mode reminder

plugins=(
  git fzf gh docker docker-compose doctl emoji extract git-auto-fetch git-commit
  git-extras gitfast gitignore github pip python node nvm
  zsh-autosuggestions uv zsh-vi-mode tmux branch bun celery colored-man-pages
  colorize copybuffer copyfile copypath dirpersist zoxide zellij-tabula dirpersist
)

export ZSH_TMUX_AUTOSTART=true

source $ZSH/oh-my-zsh.sh

export DOCKER_HOST=unix:///run/user/1000//docker.sock
export VISUAL="nvim"
export EDITOR="nvim"
export PAGER="less -R"
export BAT_THEME="ansi"
export GALLIUM_DRIVER="d3d12"

path=(
  $HOME/.local/share/nvim/mason/bin
  $HOME/.local/bin
  $HOME/.cargo/bin
  $HOME/bin
  $HOME/.npm/bin
  $path
  /usr/local/cuda-13/bin
  $HOME/lib/
  $HOME/go/bin
)

export PATH

# fzf

export FZF_DEFAULT_OPTS="
  --color=bg+:#ebdbb2,bg:#fbf1c7,spinner:#8ec07c,hl:#83a598
  --color=fg:#3c3836,header:#83a598,info:#fabd2f,pointer:#8ec07c
  --color=marker:#8ec07c,fg+:#504945,prompt:#fabd2f,hl+:#83a598
"

# wsl

keep_current_path() {
  printf "\e]9;9;%s\e\\" "$(wslpath -w "$PWD")"
}

precmd_functions+=(keep_current_path)

# zoxide

eval "$(zoxide init zsh)"

# nvm

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

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

export OPENCODE_CONFIG="$HOME/.config/opencode/opencode.json"
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/usr/local/cuda-13.1/lib64
export PATH="/home/maksim/.aisessions/bin:$PATH"

# bun completions
[ -s "/home/maksim/.bun/_bun" ] && source "/home/maksim/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
