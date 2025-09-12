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
}
