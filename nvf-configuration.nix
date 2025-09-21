{pkgs, ...}: {
  vim = {
    theme = {
      enable = true;
      name = "catppuccin"; # onedark
      style = "mocha"; # darker
    };
    syntaxHighlighting = true;
    lsp = {
      enable = true;
      formatOnSave = true;
      lspconfig.enable = true;
      servers = {
        "tinymist" = {
          filetypes = ["typ" "typst"];
          settings = {
            exportPdf = "onType";
            formatterMode = "typestyle";
            semanticTokens = "enable";
          };
        };
      };
    };
    globals = {
      haskell_enable_quantification = 1; #enable highlighting of `forall`
      haskell_enable_recursivedo = 1; #enable highlighting of `mdo` and `rec`
      haskell_enable_arrowsyntax = 1; #enable highlighting of `proc`
      haskell_enable_pattern_synonyms = 1; #enable highlighting of `pattern`
      haskell_enable_typeroles = 1; #enable highlighting of type roles
      haskell_enable_static_pointers = 1; #enable highlighting of `static`
      haskell_backpack = 1; #enable highlighting of backpack keywords
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

    treesitter = {
      # enable = false;
      highlight.enable = true;
      indent.enable = true;
      addDefaultGrammars = true;
      highlight.disable = [];
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
        lsp.enable = true;
        treesitter.enable = true;
      };
      ts.enable = true;
      rust.enable = true;
      haskell = {
        enable = true;
        lsp.enable = true;
        lsp.package = pkgs.haskell-language-server;
        treesitter.enable = true;
        dap.enable = true;
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
      nvim-scrollbar.enable = true;
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
    extraPlugins = {
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
    };

    debugger.nvim-dap.enable = true;

    lazy.enable = true;
    lazy.plugins = {
      "typst.vim" = {
        package = pkgs.vimPlugins.typst-vim;
        ft = ["typst"];
      };
      #"haskell-scope-highlighting.nvim" = {
      #package = pkgs.vimPlugins.haskell-scope-highlighting-nvim;
      #ft = [ "haskell" ];
      #};
    };
    extraPackages = with pkgs; [
      haskellPackages.hlint
    ];
    luaConfigPost = ''
      vim.keymap.set("n", "<leader>d", function()
        vim.diagnostic.open_float(nil, { focus = false, border = "rounded" })
      end, { desc = "Show diagnostics at cursor" })
    '';
  };
}
