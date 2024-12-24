-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

_G._packer = _G._packer or {}
_G._packer.inside_compile = true

local time
local profile_info
local should_profile = false
if should_profile then
  local hrtime = vim.loop.hrtime
  profile_info = {}
  time = function(chunk, start)
    if start then
      profile_info[chunk] = hrtime()
    else
      profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
    end
  end
else
  time = function(chunk, start) end
end

local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end
  if threshold then
    table.insert(results, '(Only showing plugins that took longer than ' .. threshold .. ' ms ' .. 'to load)')
  end

  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/home/kris/.cache/nvim/packer_hererocks/2.1.1703358377/share/lua/5.1/?.lua;/home/kris/.cache/nvim/packer_hererocks/2.1.1703358377/share/lua/5.1/?/init.lua;/home/kris/.cache/nvim/packer_hererocks/2.1.1703358377/lib/luarocks/rocks-5.1/?.lua;/home/kris/.cache/nvim/packer_hererocks/2.1.1703358377/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/kris/.cache/nvim/packer_hererocks/2.1.1703358377/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/home/kris/.local/share/nvim/site/pack/packer/start/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-treesitter"] = {
    loaded = true,
    path = "/home/kris/.local/share/nvim/site/pack/packer/start/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/home/kris/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/kris/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["telescope.nvim"] = {
    loaded = true,
    path = "/home/kris/.local/share/nvim/site/pack/packer/start/telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  ["typescript-tools.nvim"] = {
    config = { "\27LJ\2\n’\1\0\2\n\0\t\0\0205\2\0\0006\3\1\0009\3\2\0039\3\3\3\18\5\1\0'\6\4\0'\a\5\0'\b\6\0\18\t\2\0B\3\6\0016\3\1\0009\3\2\0039\3\3\3\18\5\1\0'\6\4\0'\a\a\0'\b\b\0\18\t\2\0B\3\6\1K\0\1\0%<Cmd>lua vim.lsp.buf.hover()<CR>\6K*<Cmd>lua vim.lsp.buf.definition()<CR>\agd\6n\24nvim_buf_set_keymap\bapi\bvim\1\0\2\fnoremap\2\vsilent\2é\4\1\0\6\0\16\0\0236\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0003\3\3\0=\3\5\0025\3\6\0004\4\0\0=\4\a\0034\4\0\0=\4\b\0034\4\0\0=\4\t\0034\4\0\0=\4\n\0035\4\v\0005\5\f\0=\5\r\4=\4\14\3=\3\15\2B\0\2\1K\0\1\0\rsettings\18jsx_close_tag\14filetypes\1\3\0\0\20javascriptreact\20typescriptreact\1\0\1\venable\1\30tsserver_file_preferences\28tsserver_format_options\21tsserver_plugins\26expose_as_code_action\1\0\b)include_completions_with_insert_text\2\20tsserver_locale\aen\14code_lens\boff\24tsserver_max_memory\tauto\29disable_member_code_lens\2\26publish_diagnostic_on\17insert_leave\31separate_diagnostic_server\2\28complete_function_calls\1\14on_attach\1\0\0\0\nsetup\21typescript-tools\frequire\0" },
    loaded = true,
    path = "/home/kris/.local/share/nvim/site/pack/packer/start/typescript-tools.nvim",
    url = "https://github.com/pmizio/typescript-tools.nvim"
  },
  ["vim-easymotion"] = {
    loaded = true,
    path = "/home/kris/.local/share/nvim/site/pack/packer/start/vim-easymotion",
    url = "https://github.com/easymotion/vim-easymotion"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: typescript-tools.nvim
time([[Config for typescript-tools.nvim]], true)
try_loadstring("\27LJ\2\n’\1\0\2\n\0\t\0\0205\2\0\0006\3\1\0009\3\2\0039\3\3\3\18\5\1\0'\6\4\0'\a\5\0'\b\6\0\18\t\2\0B\3\6\0016\3\1\0009\3\2\0039\3\3\3\18\5\1\0'\6\4\0'\a\a\0'\b\b\0\18\t\2\0B\3\6\1K\0\1\0%<Cmd>lua vim.lsp.buf.hover()<CR>\6K*<Cmd>lua vim.lsp.buf.definition()<CR>\agd\6n\24nvim_buf_set_keymap\bapi\bvim\1\0\2\fnoremap\2\vsilent\2é\4\1\0\6\0\16\0\0236\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0003\3\3\0=\3\5\0025\3\6\0004\4\0\0=\4\a\0034\4\0\0=\4\b\0034\4\0\0=\4\t\0034\4\0\0=\4\n\0035\4\v\0005\5\f\0=\5\r\4=\4\14\3=\3\15\2B\0\2\1K\0\1\0\rsettings\18jsx_close_tag\14filetypes\1\3\0\0\20javascriptreact\20typescriptreact\1\0\1\venable\1\30tsserver_file_preferences\28tsserver_format_options\21tsserver_plugins\26expose_as_code_action\1\0\b)include_completions_with_insert_text\2\20tsserver_locale\aen\14code_lens\boff\24tsserver_max_memory\tauto\29disable_member_code_lens\2\26publish_diagnostic_on\17insert_leave\31separate_diagnostic_server\2\28complete_function_calls\1\14on_attach\1\0\0\0\nsetup\21typescript-tools\frequire\0", "config", "typescript-tools.nvim")
time([[Config for typescript-tools.nvim]], false)

_G._packer.inside_compile = false
if _G._packer.needs_bufread == true then
  vim.cmd("doautocmd BufRead")
end
_G._packer.needs_bufread = false

if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
