{ pkgs, lib, ... }:
{
  programs.nvf = {
    enableManpages = true;
    enable = true;
    settings.vim = {
      withPython3 = true;
      tabline.nvimBufferline = {
        enable = true;
        setupOpts.options.always_show_bufferline = false;
      };
      utility = import ./utilities.nix;
      keymaps = import ./keymaps.nix;
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
      };
      enableLuaLoader = true;
      statusline.lualine = {
        enable = true;
        activeSection.b = [
          ''
            {
              "filetype",
              colored = true,
              icon_only = true,
              icon = { align = 'left' }
            }
          ''
          ''
            {
              "filename",
              path = 4,
              symbols = {modified = ' ', readonly = ' '},
              separator = {right = ''}
            }
          ''
          ''
            {
              "",
              draw_empty = true,
              separator = { left = '', right = '' }
            }
          ''
        ];
      };
      telescope.enable = true;
      autocomplete.blink-cmp.enable = true;

      /*
        treesitter = {
          enable = true;
          highlight.enable = true;
          indent.enable = true;
          addDefaultGrammars = true;
          highlight.disable = [ ];
        };
      */

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
        registers = "unnamed,unnamedplus";
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

        };

      debugger.nvim-dap.enable = true;

      lazy.enable = true;
      lazy.plugins = {
        "typst.vim" = {
          package = pkgs.vimPlugins.typst-vim;
          ft = [ "typst" ];
        };

        #"haskell-scope-highlighting.nvim" = {
        #package = pkgs.vimPlugins.haskell-scope-highlighting-nvim;
        #ft = [ "haskell" ];
        #};
      };
      extraPackages = with pkgs; [
        haskellPackages.hlint
        tombi
      ];
      /*luaConfigPre = ''
        vim.g["coqtail#supported"] = 1
      '';*/
    };
  };
}
