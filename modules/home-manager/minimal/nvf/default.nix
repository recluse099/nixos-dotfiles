{ pkgs, lib, ... }:
{
  programs.nvf = {
    enableManpages = true;
    enable = true;
    settings.vim = {
      withPython3 = true;
      python3Packages = [ "pynvim" ];
      tabline.nvimBufferline = {
        enable = true;
        setupOpts.options.always_show_bufferline = false;
      };
      utility = import ./utilities.nix;
      keymaps = import ./keymaps.nix;
      assistant = (import ./assistants.nix).assistant;
      theme = {
        enable = true;
        name = "catppuccin"; # onedark
        style = "mocha"; # darker
      };
      syntaxHighlighting = true;
      lsp = {
        enable = true;
        formatOnSave = false;
        lspconfig.enable = true;
        servers = {
          "tinymist" = {
            enable = true;
            filetypes = [
              "typ"
              "typst"
            ];
            settings = {
              exportPdf = "onType";
              formatterMode = "typestyle";
              semanticTokens = "enable";
            };
          };
          "lua_ls" = {
            enable = true;
            filetypes = [ "lua" ];
          };
          "coq-lsp" = {
            enable = false;
            filetypes = [ "v" ];
          };
          "tombi" = {
            enable = true;
            filetypes = [ "toml" ];
          };
          "ocaml-lsp" = {
            # nixpkgs only builds ocaml-lsp-server against stock OCaml, which can't
            # read .cmi files from OxCaml's 5.2.0+ox compiler. Use the opam-built
            # binary from that switch instead of the preset's nixpkgs one.
            cmd = lib.mkForce [ "/home/recluse/.opam/5.2.0+ox/bin/ocamllsp" ];
          };
          nixd.autoArchive = true;
        };
      };
      languages =
        let
          language-module = import ./language-modules.nix { inherit pkgs; };
        in
        language-module.languages;
      globals = {
        haskell_enable_quantification = 1; # enable highlighting of `forall`
        haskell_enable_recursivedo = 1; # enable highlighting of `mdo` and `rec`
        haskell_enable_arrowsyntax = 1; # enable highlighting of `proc`
        haskell_enable_pattern_synonyms = 1; # enable highlighting of `pattern`
        haskell_enable_typeroles = 1; # enable highlighting of type roles
        haskell_enable_static_pointers = 1; # enable highlighting of `static`
        haskell_backpack = 1; # enable highlighting of backpack keywords
        #typst-vim settings
        #typst_pdf_viewer = "zathura";
        coqtail_build_system = "coqproject";
        coqtail_dune_compile_deps = 1;
        coqtail_noimap = 1;
      };
      enableLuaLoader = true;
      statusline.lualine = {
        enable = true;
        # activeSection.b was removed upstream (nvf now warns "no longer has
        # any effect"). Its built-in setupOpts.sections.lualine_b default
        # already renders filetype icon + filename + spacer, matching what
        # this used to hand-configure.
      };
      telescope.enable = true;
      autocomplete.blink-cmp.enable = true;

      treesitter = {
        enable = true;
        highlight.enable = true;
        indent.enable = true;
        addDefaultGrammars = true;
      };

      diagnostics = {
        enable = true;
        config = {
          float = true;
          Float.scope = "buffer";
        };
      };
      clipboard = {
        enable = true;
        providers = {
          wl-copy.enable = true;
          wl-copy.package = pkgs.wl-clipboard-rs;
        };
        registers = "unnamedplus";
      };
      options = {
        autoindent = false;
        shiftwidth = 2;
        tabstop = 2;
        expandtab = true;
      };
      visuals = {
        nvim-scrollbar.enable = false;
        indent-blankline = {
          enable = true;
          setupOpts = {
            scope.enabled = true;
            whitespace.remove_blankline_trail = true;
          };
        };
        rainbow-delimiters.enable = true;
      };

      filetree.nvimTree.setupOpts.view.number = true;
      # Plugins
      extraPlugins =
        let
          coqtail = pkgs.vimUtils.buildVimPlugin {
            name = "coqtail";
            src = pkgs.fetchFromGitHub {
              owner = "whonore";
              repo = "Coqtail";
              rev = "240c8f20700160edc13975d4a2bba70180a05ea8";
              sha256 = "sha256-RqC1xBrVSjNL8xX8xaXeYIRjLObM+voVTryQ9lsNfBA=";
            };
          };
        in
        {
          yuck = {
            package = pkgs.vimPlugins.yuck-vim;
          };
          vim-stylish-haskell = {
            # formatter, not syntax highlighter
            package = pkgs.vimPlugins.vim-stylish-haskell;
          };
          haskell-vim = {
            package = pkgs.vimPlugins.haskell-vim;
          };
          coqtail = {
            package = coqtail;
          };
          /*
            coq-lsp-nvim = {
              package = pkgs.vimPlugins.coq-lsp-nvim;
              #setup = ''
              #  require('coq-lsp').setup {}
              #'';
            };
          */
          vimtex = {
            package = pkgs.vimPlugins.vimtex;
            #ft = [ "tex" ];
          };
          claudecode-nvim = {
            package = pkgs.vimPlugins.claudecode-nvim;
            setup = ''require("claudecode").setup({})'';
          };
        };

      debugger.nvim-dap.enable = true;

      lazy.enable = true;
      lazy.plugins = {
        "typst.vim" = {
          package = pkgs.vimPlugins.typst-vim;
          ft = [ "typst" ];
        };
        "knap" = {
          package = pkgs.vimPlugins.knap;
          ft = [ "tex" ];
        };
        /*
          "vimtex" = {
          package = pkgs.vimPlugins.vimtex;
          ft = [ "tex" ];
          };
        */
      };
      extraPackages = with pkgs; [
        haskellPackages.hlint
        tombi
        coqPackages.stdlib
        coqPackages.coq-lsp
        ocamlformat
      ];
    };
  };
}
