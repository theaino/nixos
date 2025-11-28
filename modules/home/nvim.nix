{ config, pkgs, ... }:

{
  home.sessionVariables.EDITOR = "nvim";

  programs.nixvim = {
    enable = true;
    viAlias = true;
    vimAlias = true;

    opts = {
      number = true;
      relativenumber = true;
      scrolloff = 8;
      signcolumn = "yes";

      tabstop = 2;
      shiftwidth = 2;

      syntax = "on";
    };
    globals = {
      mapleader = " ";

      netrw_banner = 1;
      netrw_liststyle = 3;
    };
    plugins = {
      lsp = {
        enable = true;
        servers = {
          clangd.enable = true;
          gopls.enable = true;
          openscad_lsp.enable = true;
          pylsp.enable = true;
          rust_analyzer = {
            enable = true;
            installCargo = true;
            installRustc = true;
          };
          texlab.enable = true;
        };
        luaConfig.post = ''
          vim.lsp.config("godot", {
            cmd = {"nc", "127.0.0.1", "6005"},
            filetypes = {"gdscript"},
            settings = {}
          })
          vim.lsp.enable("godot")

          vim.lsp.config("go-templ", {
            cmd = {"go", "tool", "templ", "lsp"},
            filetypes = {"templ"},
            settings = {}
          })
          vim.lsp.enable("go-templ")
        '';
      };
      cmp = {
        enable = true;
        autoEnableSources = true;
        settings.sources = [
          { name = "nvim_lsp"; }
          { name = "path"; }
          { name = "buffer"; }
        ];
	settings = {
	  mapping = {
	    __raw = ''
	      cmp.mapping.preset.insert({
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-y>'] = cmp.mapping.confirm({ select = tru }),
	      })
	    '';
	  };
	};
      };
      treesitter = {
        enable = true;
        grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
          bash
          c
          gdscript
          go
          gomod
          gosum
          latex
          nix
          python
          rust
          templ
          vim
        ];
      };
      web-devicons.enable = true;
      telescope.enable = true;
      vimtex.enable = true;
    };
    keymaps = [
      { mode = "n"; key = "<leader>h"; action = "<cmd>noh<cr>"; }

      { mode = "n"; key = "<leader>e"; action = "<cmd>lua vim.diagnostic.open_float()<cr>"; }
      { mode = "n"; key = "<leader>a"; action = "<cmd>lua vim.lsp.buf.code_action()<cr>"; }

      { mode = "n"; key = "<leader>y"; action = "\"+y"; }
      { mode = "n"; key = "<leader>d"; action = "\"+d"; }
      { mode = "n"; key = "<leader>p"; action = "\"+p"; }
      { mode = "v"; key = "<leader>y"; action = "\"+y"; }
      { mode = "v"; key = "<leader>d"; action = "\"+d"; }
      { mode = "v"; key = "<leader>p"; action = "\"+p"; }

      { mode = "n"; key = "<leader>n"; action = "<cmd>bn<cr>"; }
      { mode = "n"; key = "<leader>l"; action = "<cmd>bl<cr>"; }
      { mode = "n"; key = "<leader>c"; action = "<cmd>bd<cr>"; }

      { mode = "n"; key = "<leader>f"; action = "<cmd>Telescope find_files<cr>"; }
      { mode = "n"; key = "<leader>/"; action = "<cmd>Telescope live_grep<cr>"; }
      { mode = "n"; key = "<leader>b"; action = "<cmd>Telescope buffers<cr>"; }
      { mode = "n"; key = "<leader>r"; action = "<cmd>lua require(\"telescope.builtin\").lsp_references()<cr>"; }
      { mode = "n"; key = "<leader>0"; action = "<cmd>lua require(\"telescope.builtin\").lsp_definitions()<cr>"; }
    ];
  };
}
