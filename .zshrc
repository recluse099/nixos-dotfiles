eval "$(starship init zsh)"

typeset -U path cdpath fpath manpath
for profile in ${(z)NIX_PROFILES}; do
  fpath+=($profile/share/zsh/site-functions $profile/share/zsh/$ZSH_VERSION/functions $profile/share/zsh/vendor-completions)
done

HELPDIR="/nix/store/dk84c93annbbyrclhy691ajcyydycw35-zsh-5.9/share/zsh/$ZSH_VERSION/help"

eval $(/nix/store/8ksax0a2mxglr5hlkj2dzl556jx7xqn5-coreutils-9.7/bin/dircolors -b ~/.dir_colors)

autoload -U compinit && compinit
source /nix/store/9zcs7pmk8n7d0ss1k43fqpl13apa1sdb-zsh-autosuggestions-0.7.1/share/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_STRATEGY=(match_prev_cmd)


eval "$(/nix/store/7lh4ina0b99aql433h56iq3fvp1d8znn-zoxide-0.9.8/bin/zoxide init zsh )"

# History options should be set in .zshrc and after oh-my-zsh sourcing.
# See https://github.com/nix-community/home-manager/issues/177.
HISTSIZE="10000"
SAVEHIST="10000"

HISTFILE="/home/recluse/.zsh_history"
mkdir -p "$(dirname "$HISTFILE")"

setopt HIST_FCNTL_LOCK
unsetopt APPEND_HISTORY
setopt HIST_IGNORE_DUPS
unsetopt HIST_IGNORE_ALL_DUPS
unsetopt HIST_SAVE_NO_DUPS
unsetopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_SPACE
unsetopt HIST_EXPIRE_DUPS_FIRST
setopt SHARE_HISTORY
unsetopt EXTENDED_HISTORY


function yy() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXX")"
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    builtin cd -- "$cwd"
  fi
  rm -f -- "$tmp"
}

source "/nix/store/xjwdhfjffw92n5zjgkbsric4mmfh3566-wezterm-0-unstable-2025-08-14/etc/profile.d/wezterm.sh"

if [[ $TERM != "dumb" ]]; then
  eval "$(/nix/store/9fnhax88khgd917p1mnnb649a1fpr0jq-starship-1.23.0/bin/starship init zsh)"
fi

if test -n "$KITTY_INSTALLATION_DIR"; then
  export KITTY_SHELL_INTEGRATION="no-rc "
  autoload -Uz -- "$KITTY_INSTALLATION_DIR"/shell-integration/zsh/kitty-integration
  kitty-integration
  unfunction kitty-integration
fi

if [[ -n $GHOSTTY_RESOURCES_DIR ]]; then
  source "$GHOSTTY_RESOURCES_DIR"/shell-integration/zsh/ghostty-integration
fi

alias -- clr=clear
alias -- eza='eza --icons always --git --header'
alias -- ga='git add'
alias -- la='eza -a'
alias -- ll='ls -la'
alias -- lla='eza -la'
alias -- ls=eza
alias -- lt='eza --tree'
alias -- nhhs='nh home switch /home/recluse/dotfiles'
alias -- nhos='nh os switch /home/recluse/dotfiles'
alias -- ze=zellij
source /nix/store/rpmyx2sayv345q1axkym35dpf6gndf9c-zsh-syntax-highlighting-0.8.0/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
ZSH_HIGHLIGHT_HIGHLIGHTERS+=()


