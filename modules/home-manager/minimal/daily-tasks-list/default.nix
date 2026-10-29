{ pkgs, ... }:
let
  template = pkgs.writeText "today-template.md" ''
    # Today
    - [ ] 
    - [ ] 
    - [ ] 

    # Stopped at / tomorrow's first task
    - 
  '';

  # Opens the most recent daily file (creates one if none exist yet)
  today = pkgs.writeShellScriptBin "today" ''
    dir="$HOME/notes/daily"
    mkdir -p "$dir"
    f="$(ls -1 "$dir"/*.md 2>/dev/null | tail -n 1)"
    if [ -z "$f" ]; then
      f="$dir/$(date +%F).md"
      install -m 644 ${template} "$f"
    fi
    exec nvim "$f"
  '';

  # Creates a new file dated today and opens it
  today-new = pkgs.writeShellScriptBin "today-new" ''
    dir="$HOME/notes/daily"
    mkdir -p "$dir"
    f="$dir/$(date +%F).md"
    if [ -f "$f" ]; then
      echo "Today's file already exists, opening it." >&2
    else
      install -m 644 ${template} "$f"
    fi
    exec nvim "$f"
  '';
in
{
  home.packages = [ today today-new ];
}
