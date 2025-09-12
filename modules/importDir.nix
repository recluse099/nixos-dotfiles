dir: map (x: dir + "/${x}") (builtins.filter (name: name != "default.nix") (builtins.attrNames (builtins.readDir dir)))

