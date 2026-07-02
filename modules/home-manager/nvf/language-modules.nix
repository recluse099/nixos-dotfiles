{ pkgs, ... }:
{
  languages = {
    enableTreesitter = true;

    nix = {
      enable = true;
      format.enable = true;
      format.type = [ "nixfmt" ];
      lsp.enable = true;
      lsp.servers = [
        "nixd"
        "nil"
      ];
      treesitter.enable = true;
    };

    typescript.enable = true;

    lua = {
      enable = false;
      #format.enable = true;
      #lsp.enable = true;
      #treesitter.enable = true;
    };

    rust.enable = true;
    rust.lsp.enable = true;

    haskell = {
      enable = true;
      treesitter.enable = true;
      lsp.enable = true;
    };
    ocaml = {
      enable = true;
      treesitter.enable = true;
      lsp.enable = true;
    };
    clang = {
      enable = true;
      treesitter.enable = true;
      lsp.enable = true;
    };
    bash = {
      enable = true;
      treesitter.enable = true;
      lsp.enable = true;
    };
    python = {
      enable = true;
      treesitter.enable = true;
      lsp.enable = true;
      lsp.servers = [ "basedpyright" ];
    };
    markdown = {
      enable = true;
      treesitter.enable = true;
      lsp.enable = true;
      lsp.servers = [ "markdown-oxide" "marksman" ];
      format.enable = true;
      format.type = [ "deno_fmt" ];
      extensions = {
        render-markdown-nvim.enable = true;
      };
    };
    json = {
      enable = true;
      treesitter.enable = true;
      lsp.enable = true;
    };
    tex = {
      enable = true;
      treesitter.enable = false;
      lsp.enable = true;
    };
  };
}
