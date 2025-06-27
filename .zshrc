export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

zstyle ':omz:update' mode reminder

plugins=(
  git fzf gh docker docker-compose pip python node nvm
  tmux zsh-autosuggestions uv zsh-vi-mode
)

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

export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS"\
" --color=bg+:#3c3836,bg:#282828,spinner:#689d6a,hl:#458588"\
" --color=fg:#928374,header:#458588,info:#d79921,pointer:#689d6a"\
" --color=marker:#689d6a,fg+:#fbf1c7,prompt:#d79921,hl+:#458588"

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

# zellij

zellij_tab_name_update() {
    if [[ -n $ZELLIJ ]]; then
        local current_dir=$PWD
        if [[ $current_dir == $HOME ]]; then
            current_dir="~"
        else
            current_dir=${current_dir##*/}
        fi
        command nohup zellij action rename-tab $current_dir >/dev/null 2>&1
    fi
}

zellij_tab_name_update
chpwd_functions+=(zellij_tab_name_update)

# bun completions
[ -s "/home/maksim/.bun/_bun" ] && source "/home/maksim/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
