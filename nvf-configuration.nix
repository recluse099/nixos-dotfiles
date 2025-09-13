{pkgs, ...}:

{
  vim = {
    theme = {
      enable = true;
      name = "catppuccin"; # onedark
      style = "mocha"; # darker
    };
    syntaxHighlighting = true;
    lsp = {
      enable = true;
      lspconfig.enable = true;
      servers = {
        "tinymist" = {
          filetypes = [ "typ" "typst" ];
          settings = {
            exportPdf = "onType";
            formatterMode = "typestyle";
            semanticTokens = "enable";
          };
        };
      };
    };
    globals = {
      haskell_enable_quantification = 1;   #enable highlighting of `forall`
      haskell_enable_recursivedo = 1;      #enable highlighting of `mdo` and `rec`
      haskell_enable_arrowsyntax = 1;      #enable highlighting of `proc`
      haskell_enable_pattern_synonyms = 1; #enable highlighting of `pattern`
      haskell_enable_typeroles = 1;        #enable highlighting of type roles
      haskell_enable_static_pointers = 1;  #enable highlighting of `static`
      haskell_backpack = 1;                #enable highlighting of backpack keywords
      # typst-vim settings
      # typst_pdf_viewer = "zathura";
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
    treesitter= {
      indent.enable = false;
      addDefaultGrammars = true;                  
    };
      
    diagnostics = {
      enable = true;
      config = {
        float = true;
        Float.scope = "buffer";
      };
    };
    languages = {
      enableTreesitter = true;

      nix = {
        enable = true;
        format.enable = true;
        format.type = "alejandra";
      };                          
      ts.enable = true;
      rust.enable = true;
      haskell = {
        enable = true;
        lsp.enable = true;
        lsp.package = pkgs.haskellPackages.haskell-language-server;
        treesitter.enable = true;
      };
    };
    clipboard = {
      enable = true;
      providers = {
        wl-copy.enable = true;
        wl-copy.package = pkgs.wl-clipboard-rs;
      };
    };
    options = {
      autoindent = true;
      shiftwidth = 2;
      tabstop = 2;
      expandtab = true;
    };
    filetree.nvimTree.setupOpts.view.number = true;
    # Plugins
    extraPlugins = {
      yuck = {
        package = pkgs.vimPlugins.yuck-vim;
        };
     stylish-haskell = {
        package = pkgs.vimPlugins.stylish-haskell;
      };
     haskell-vim = {
       package = pkgs.vimPlugins.haskell-vim;
     };
    };
    lazy.enable = true;
    lazy.plugins = {
      "typst.vim" = {
        package = pkgs.vimPlugins.typst-vim;
        ft = [ "typst" ];
      };
    };
    extraPackages = with pkgs;[ 
      haskellPackages.hlint
    ];
    luaConfigPost = ''
      vim.keymap.set("n", "<leader>d", function()
        vim.diagnostic.open_float(nil, { focus = false, border = "rounded" })
      end, { desc = "Show diagnostics at cursor" })
    ''; 
  };
}
