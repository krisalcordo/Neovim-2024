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
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "lua", "typescript", "javascript", "php", "vim", "vimdoc", "markdown", "markdown_inline", "html", "css", "json", "yaml", "bash" },
        auto_install = true,
        highlight = {
          enable = true,
        },
        indent = {
          enable = true,
        },
      })
    end,
  },

  -- Easy Motion
  { "easymotion/vim-easymotion" },

  -- Git Fugitive 
  { "tpope/vim-fugitive" },

  -- LSP
  { "neovim/nvim-lspconfig" },
  { "williamboman/mason.nvim" },
  { "williamboman/mason-lspconfig.nvim"},
  { "mfussenegger/nvim-dap"},
  { "rcarriga/nvim-dap-ui", dependencies = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"} },
{
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
},
{
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    require("toggleterm").setup({
      direction = "float",
      shell = "powershell",  -- or "cmd.exe"
    })
  end
},
  {
      "otavioschwanck/arrow.nvim",
      dependencies = {
        { "nvim-tree/nvim-web-devicons" },
        -- or if using `mini.icons`
        -- { "echasnovski/mini.icons" },
      },
      opts = {
        show_icons = true,
        leader_key = ';', -- Recommended to be a single key
        buffer_leader_key = "'", -- Per-buffer mappings; free up `m` for native marks
      }
    },
  {
    "chentoast/marks.nvim",
    event = "VeryLazy",
    opts = {},
  },
  -- Telescope
    {
      "nvim-telescope/telescope.nvim",
      tag = "0.1.8",
      dependencies = { { "nvim-lua/plenary.nvim" } },
      config = function()
        require("telescope").setup {
          defaults = {
         vimgrep_arguments = {
          "rg",
          "--hidden",
          "--no-ignore", -- Ensures all files are searched
          "--glob", "!.git/*", -- Excludes .git directory
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case"
        },
            find_command = { "fd", "--type", "f", "--hidden", "--exclude", ".git" },
            file_ignore_patterns = { 
              ".git", "node_modules", "dist", "build", "vendor", 
              "%.lock", "%.png", "%.jpg", "%.jpeg", "%.gif", "%.bmp", "%.svg", "%.ico" 
            },
            hidden = true,
            no_ignore = true,
          },
          pickers = {
            live_grep = {
              additional_args = function() return { "--hidden", "--glob", "!.git/*" } end
            }
          }
        }
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
    },
    {
      'stevearc/oil.nvim',
      ---@module 'oil'
      ---@type oil.SetupOpts
      opts = {},
      -- Optional dependencies
      dependencies = { { "echasnovski/mini.icons", opts = {} } },
      -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
    }
})

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
    command_palette = true, -- position the cmdline=  and popupmenu together
    long_message_to_split = true, -- long messages will be sent to a split
    inc_rename = false, -- enables an input dialog for inc-rename.nvim
    lsp_doc_border = false, -- add a border to hover docs and signature help
  },
  messages = {
    enabled = true,
    view = "mini"
  },
  views = {
    messages = {
        position = {
            row = 2, -- Adjust vertical placement
            col = "50%", -- Center horizontally
        },
        size = {
            width = 80,
            height = 10,
        },
    },
  }
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

require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "ts_ls", "lua_ls", "phpactor", "jdtls", "sourcekit" },
  automatic_installation = true,
})

-- Shared on_attach function for all LSPs
local on_attach = function(client, bufnr)
  local opts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
  vim.keymap.set('n', '<leader>d', vim.lsp.buf.definition, opts)
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
  vim.keymap.set('n', '<leader>r', '<cmd>Telescope lsp_references<CR>', opts)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
  vim.keymap.set('n', 'gI', vim.lsp.buf.implementation, opts)
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
  vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
end

-- Set up LSP handlers
require("mason-lspconfig").setup_handlers({
  -- Default handler for all servers
  function(server_name)
    require("lspconfig")[server_name].setup({
      on_attach = on_attach,
      capabilities = require('cmp_nvim_lsp').default_capabilities(),
    })
  end,
  
  -- Special handler for lua_ls
  ["lua_ls"] = function()
    require("lspconfig").lua_ls.setup({
      on_attach = on_attach,
      capabilities = require('cmp_nvim_lsp').default_capabilities(),
      on_init = function(client)
        if client.workspace_folders then
          local path = client.workspace_folders[1].name
          if vim.loop.fs_stat(path..'/.luarc.json') or vim.loop.fs_stat(path..'/.luarc.jsonc') then
            return
          end
        end

        client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
          runtime = {
            version = 'LuaJIT'
          },
          workspace = {
            checkThirdParty = false,
            library = {
              vim.env.VIMRUNTIME
            }
          }
        })
      end,
      settings = {
        Lua = {}
      }
    })
  end,
})

vim.api.nvim_set_keymap('n', '<leader>o', ':Oil<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>ff", "<Cmd>Telescope find_files<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>fg", "<Cmd>Telescope live_grep<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>fb", "<Cmd>Telescope buffers<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>m", "<Cmd>Telescope marks<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>sl", "<Cmd>SessionList<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>ss", "<Cmd>SessionSave<CR>", { noremap = true, silent = true })

-- Auto-save per-project sessions + list/restore picker
local sessions_dir = vim.fn.stdpath("state") .. "/sessions"
local current_session_file = nil
local function session_origin()
  if vim.fn.argc() > 0 then
    local arg = vim.fn.argv(0)
    if arg and arg ~= "" then
      local stat = vim.loop.fs_stat(arg)
      if stat and (stat.type == "file" or stat.type == "directory") then
        return vim.fn.fnamemodify(arg, ":p")
      end
    end
  end
  return vim.fn.getcwd()
end

local function session_origin_key()
  local origin = session_origin()
  return origin:gsub("[/\\:]", "%%")
end

local function session_path()
  local safe = session_origin_key()
  local ts = os.date("%Y%m%d-%H%M%S")
  return sessions_dir .. "/" .. safe .. "__" .. ts .. ".vim"
end

local function latest_session_for_origin()
  local safe = session_origin_key()
  local matches = vim.fn.glob(sessions_dir .. "/" .. safe .. "__*.vim", false, true)
  if #matches == 0 then
    return nil
  end
  table.sort(matches, function(a, b)
    return vim.fn.getftime(a) < vim.fn.getftime(b)
  end)
  return matches[#matches]
end

vim.api.nvim_create_autocmd("VimLeavePre", {
  callback = function()
    vim.fn.mkdir(sessions_dir, "p")
    local session_file = current_session_file or latest_session_for_origin() or session_path()
    vim.cmd("silent! mksession! " .. vim.fn.fnameescape(session_file))
  end,
})

vim.api.nvim_create_user_command("SessionSave", function()
  vim.fn.mkdir(sessions_dir, "p")
  local session_file = current_session_file or latest_session_for_origin() or session_path()
  vim.cmd("silent! mksession! " .. vim.fn.fnameescape(session_file))
  current_session_file = session_file
  vim.notify("Session saved: " .. session_file)
end, {})

vim.api.nvim_create_user_command("SessionList", function()
  vim.fn.mkdir(sessions_dir, "p")
  local files = vim.fn.glob(sessions_dir .. "/*.vim", false, true)
  table.sort(files, function(a, b)
    return vim.fn.getftime(a) < vim.fn.getftime(b)
  end)
  if #files == 0 then
    vim.notify("No saved sessions found.", vim.log.levels.INFO)
    return
  end
  local ok, pickers = pcall(require, "telescope.pickers")
  if not ok then
    vim.notify("Telescope not available.", vim.log.levels.WARN)
    return
  end
  local finders = require("telescope.finders")
  local conf = require("telescope.config").values
  pickers.new({}, {
    prompt_title = "Load session",
    finder = finders.new_table({
      results = files,
      entry_maker = function(path)
        local base = vim.fn.fnamemodify(path, ":t:r")
        local origin, ts = base:match("^(.*)__([0-9]+%-[0-9]+)$")
        local name = (origin or base):gsub("%%", "/")
        local ts_disp
        if ts then
          ts_disp = ts:gsub("(%d%d%d%d)(%d%d)(%d%d)%-(%d%d)(%d%d)(%d%d)", "%1-%2-%3 %4:%5:%6")
        end
        local display = ts_disp and (name .. "  [" .. ts_disp .. "]") or name
        return {
          value = path,
          display = display,
          ordinal = display,
        }
      end,
    }),
    sorter = conf.generic_sorter({}),
    attach_mappings = function(_, map)
      map("i", "<CR>", function(bufnr)
        local entry = require("telescope.actions.state").get_selected_entry()
        require("telescope.actions").close(bufnr)
        if entry and entry.value then
          current_session_file = entry.value
          vim.cmd("silent! source " .. vim.fn.fnameescape(entry.value))
        end
      end)
      map("n", "<CR>", function(bufnr)
        local entry = require("telescope.actions.state").get_selected_entry()
        require("telescope.actions").close(bufnr)
        if entry and entry.value then
          current_session_file = entry.value
          vim.cmd("silent! source " .. vim.fn.fnameescape(entry.value))
        end
      end)
      return true
    end,
  }):find()
end, {})

vim.api.nvim_create_user_command("SessionClear", function()
  local files = vim.fn.glob(sessions_dir .. "/*.vim", false, true)
  if #files == 0 then
    vim.notify("No saved sessions to clear.", vim.log.levels.INFO)
    return
  end
  for _, path in ipairs(files) do
    vim.fn.delete(path)
  end
  current_session_file = nil
  vim.notify("All saved sessions cleared.")
end, {})
vim.api.nvim_create_user_command("Br", function()
  require("toggleterm.terminal").Terminal
    :new({
      direction = "float",
    float_opts = {
        border = "single",
        width = math.floor(vim.o.columns * 0.4),  -- 40% of screen width
        height = math.floor(vim.o.lines * 0.3),   -- 30% of screen height
        row = math.floor(vim.o.lines * 0.7),      -- Position near the bottom
        col = math.floor(vim.o.columns * 0.6),    -- Position near the right
      },
      shade_terminals = true,
      shading_factor = 2,
      cmd = "cd /d C:\\code\\tb-extension\\TubeBuddy.Web && yarn dev:react",
    })
    :toggle()
end, {})
vim.api.nvim_create_user_command("Be", function()
  require("toggleterm.terminal").Terminal
    :new({
      direction = "float",
    float_opts = {
        border = "single",
        width = math.floor(vim.o.columns * 0.4),  -- 40% of screen width
        height = math.floor(vim.o.lines * 0.3),   -- 30% of screen height
        row = math.floor(vim.o.lines * 0.7),      -- Position near the bottom
        col = math.floor(vim.o.columns * 0.6),    -- Position near the right
      },
      shade_terminals = true,
      shading_factor = 2,
      cmd = "cd /d C:\\code\\tb-extension\\TubeBuddy.Web && yarn dev:extension",
    })
    :toggle()
end, {})
