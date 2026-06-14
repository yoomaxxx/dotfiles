# PATH
$env.PATH = ($env.PATH | split row (char esep) | prepend [
  $"($env.HOME)/.local/share/nvim/mason/bin"
  $"($env.HOME)/.local/bin"
  $"($env.HOME)/.cargo/bin"
  $"($env.HOME)/bin"
  $"($env.HOME)/.npm/bin"
  $"($env.HOME)/.bun/bin"
  $"($env.HOME)/.aisessions/bin"
  $"($env.HOME)/go/bin"
  /usr/local/cuda-13/bin
  $"($env.HOME)/lib"
])

# Disable startup banner
$env.config.show_banner = false

# WSL: keep terminal path in sync with Windows
$env.config.hooks.pre_prompt = [
  {||
    if (which wslpath | is-not-empty) {
      printf "\e]9;9;%s\e\\" (^wslpath -w $env.PWD)
    }
  }
]

if ('~/.cache/mise/activate.nu' | path exists) {
  source ~/.cache/mise/activate.nu
}

# Aliases

alias bat = batcat

# Vi mode

$env.config.edit_mode = 'vi'

# zellij-tabula

source ~/.config/zellij/zellij-tabula.nu

# zoxide

source ~/.zoxide.nu

