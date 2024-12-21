vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.clipboard:append { "unnamedplus" }
vim.g.mapleader = " "
-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Plugins
require("lazy").setup({
    { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  -- lazy.nvim manages itself
  { "folke/lazy.nvim" },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
  },

  -- Easy Motion
  { "easymotion/vim-easymotion" },

  -- Git Fugitive 
  { "tpope/vim-fugitive" },

  -- LSP
  { "neovim/nvim-lspconfig" },
 
  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = { { "nvim-lua/plenary.nvim" } },
    config = function()
      require("telescope").setup {
        defaults = {
          file_ignore_patterns = { "node_modules", "%.png", "%.jpg", "%.jpeg", "%.gif", "%.bmp", "%.svg", "%.ico" },
        },
      }
      -- Telescope keybindings
      vim.api.nvim_set_keymap("n", "<leader><leader>ff", "<Cmd>Telescope git_files<CR>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("n", "<leader><leader>fg", "<Cmd>Telescope live_grep<CR>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("n", "<leader><leader>fb", "<Cmd>Telescope buffers<CR>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("n", "<leader><leader>fh", "<Cmd>Telescope help_tags<CR>", { noremap = true, silent = true })
      -- LSP keybindings
      vim.api.nvim_set_keymap('n', '<Leader>d', '<cmd>lua vim.lsp.buf.definition()<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<Leader>r', '<cmd>lua vim.lsp.buf.references()<CR>', { noremap = true, silent = true })
    end,
  },
    {
      "hrsh7th/nvim-cmp",
      dependencies = {
        "hrsh7th/cmp-nvim-lsp", -- LSP completion source
        "hrsh7th/cmp-buffer",   -- Buffer completion source
        "hrsh7th/cmp-path",     -- Path completion source
        "hrsh7th/cmp-cmdline",  -- Command-line completion
        "hrsh7th/cmp-vsnip",    -- Snippet completion source
        "hrsh7th/vim-vsnip",    -- Snippet engine
      },
      config = function()
        local cmp = require("cmp")
        cmp.setup {
          snippet = {
            expand = function(args)
              vim.fn["vsnip#anonymous"](args.body) -- Use VSnip for snippets
            end,
          },
          mapping = cmp.mapping.preset.insert({
            ["<C-b>"] = cmp.mapping.scroll_docs(-4),
            ["<C-f>"] = cmp.mapping.scroll_docs(4),
            ["<C-Space>"] = cmp.mapping.complete(),
            ["<C-e>"] = cmp.mapping.abort(),
            ["<CR>"] = cmp.mapping.confirm({ select = true }),
          }),
          sources = cmp.config.sources({
            { name = "nvim_lsp" },
            { name = "buffer" },
            { name = "path" },
          }),
        }
      end,
    },
    {
      "folke/noice.nvim",
      event = "VeryLazy",
      opts = {
        -- add any options here
      },
      dependencies = {
        -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
        "MunifTanjim/nui.nvim",
        -- OPTIONAL:
        --   `nvim-notify` is only needed, if you want to use the notification view.
        --   If not available, we use `mini` as the fallback
        "rcarriga/nvim-notify",
        }
    }
})

-- LSP Configurations
require'lspconfig'.phpactor.setup{}
require'lspconfig'.ts_ls.setup{}


require("noice").setup({
  lsp = {
    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
    },
  },
  -- you can enable a preset for easier configuration
  presets = {
    bottom_search = true, -- use a classic bottom cmdline for search
    command_palette = true, -- position the cmdline and popupmenu together
    long_message_to_split = true, -- long messages will be sent to a split
    inc_rename = false, -- enables an input dialog for inc-rename.nvim
    lsp_doc_border = false, -- add a border to hover docs and signature help
  },
})


vim.cmd.colorscheme "catppuccin"

require("catppuccin").setup({
    integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        treesitter = true,
        notify = true,
        mini = {
            enabled = true,
            indentscope_color = "",
        },
    }
})
