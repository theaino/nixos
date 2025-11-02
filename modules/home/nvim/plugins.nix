{ pkgs, lua , ... }:

with pkgs; [
  {
    plugin = vimPlugins.nvim-lspconfig;
    config = lua ''
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
  }
  {
    plugin = vimPlugins.mason-nvim;
    config = lua ''
      require("mason").setup()
    '';
  }
  {
    plugin = vimPlugins.mason-lspconfig-nvim;
    config = lua ''
      require("mason-lspconfig").setup({
        ensure_installed = {
          "clangd",
          "gopls",
          "pylsp",
          "rust_analyzer",
          "texlab",
          "openscad_lsp"
        },
        automatic_installation = true
      })
      require("mason-lspconfig").setup_handlers({
        function(server_name)
          require("lspconfig")[server_name].setup({})
        end,
      })
    '';
  }

  {
    plugin = vimPlugins.vimtex;
    config = lua ''
      vim.g.vimtex_view_method = "zathura"
    '';
  }

  vimPlugins.cmp-nvim-lsp
  vimPlugins.cmp-path
  vimPlugins.cmp-cmdline
  vimPlugins.cmp-vimtex
  vimPlugins.lspkind-nvim
  {
    plugin = vimPlugins.nvim-cmp;
    config = lua ''
      local cmp = require("cmp")

      cmp.setup({
        view = {
          entries = { name = "custom", selection_order = "near_cursor" }
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered()
        },
        mapping = {
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-d>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.close(),
          ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          }),
          ["<Tab>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "s" })
        },
        formatting = {
          format = require("lspkind").cmp_format({})
        },
        sources = {
          { name = "nvim_lsp" },
          { name = "vimtex" }
        }
      })
    '';
  }
  vimPlugins.nvim-treesitter-parsers.gdscript
  vimPlugins.nvim-treesitter-parsers.c
  vimPlugins.nvim-treesitter-parsers.go
  vimPlugins.nvim-treesitter-parsers.gomod
  vimPlugins.nvim-treesitter-parsers.gosum
  vimPlugins.nvim-treesitter-parsers.templ
  vimPlugins.nvim-treesitter-parsers.python
  vimPlugins.nvim-treesitter-parsers.bash
  vimPlugins.nvim-treesitter-parsers.vim
  vimPlugins.nvim-treesitter-parsers.nix
  vimPlugins.nvim-treesitter-parsers.rust
  vimPlugins.nvim-treesitter-parsers.latex
  {
    plugin = vimPlugins.nvim-treesitter;
    config = lua ''
      require("nvim-treesitter").setup({})

      vim.api.nvim_create_autocmd('FileType', {
        callback = function(args)
          local lang = vim.bo[args.buf].filetype
          local parser_config = require("nvim-treesitter.parsers").get_parser_configs()[lang]

          if not (parser_config and require("nvim-treesitter.parsers").has_parser(lang)) then
            return
          end

          vim.treesitter.start()
          vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
        end,
      })
    '';
  }

  vimPlugins.plenary-nvim
  vimPlugins.telescope-nvim

  {
    plugin = vimPlugins.gbprod-nord;
    config = lua ''
      require("nord").setup({
        transparent = true,
      })
      vim.cmd.colorscheme("nord")
    '';
  }
]
