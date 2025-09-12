{lib, ...}:
{
  importDirExcept = {dir, exclude}: 
  map 
    (name: dir + "/${name}") 
    (builtins.attrNames 
      (lib.filterAttrs 
        (name: type: 
          !(builtins.elem name exclude) && (type == "directory" || lib.hasSuffix ".nix" name)) 
        (builtins.readDir dir)
      )
    );

  importDirAll = dir: 
    map 
      (x: dir + "/${x}") 
      (builtins.filter 
        (name: name != "default.nix")  
        (builtins.attrNames (builtins.readDir dir)));
}
