vim.api.nvim_create_autocmd({ "UIEnter", "ColorScheme" }, {
  callback = function()
    local normal = vim.api.nvim_get_hl(0, { name = "Normal" })
    if not normal.bg then return end
    io.write(string.format("\027]11;#%06x\027\\", normal.bg))
  end,
})

vim.api.nvim_create_autocmd("UILeave", {
  callback = function() io.write("\027]111\027\\") end,
})

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt) vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
	spec = {
	  {
	    "2giosangmitom/nightfall.nvim",
	    lazy = false,
	    priority = 1000,
	    opts = {}, -- Add custom configuration here
	    config = function(_, opts)
	      require("nightfall").setup(opts)
	      vim.cmd("colorscheme nord") -- Choose from: nightfall, deeper-night, maron, nord
	    end,
	  },
	  {
	    "akinsho/bufferline.nvim",
	    version = "*",
	    dependencies = "nvim-tree/nvim-web-devicons",
	    config = function()
        local normal_bg = vim.api.nvim_get_hl_by_name("Normal", true).background
	      require("bufferline").setup {
          options = {
            numbers = "ordinal", -- shows buffer numbers
            diagnostics = "nvim_lsp",
            show_buffer_close_icons = false,
            show_close_icon = false,
            always_show_bufferline = true,
          },
          highlights = {
              fill = { bg = normal_bg },
              background = { bg = normal_bg },
              buffer_visible = { bg = normal_bg },
              buffer_selected = { bg = normal_bg },
              tab = { bg = normal_bg },
              tab_selected = { bg = normal_bg },
              tab_separator = { bg = normal_bg },
              tab_separator_selected = { bg = normal_bg },
              tab_close = { bg = normal_bg },
              close_button = { bg = normal_bg },
              close_button_visible = { bg = normal_bg },
              close_button_selected = { bg = normal_bg },
              separator = { fg = normal_bg, bg = normal_bg },
              separator_selected = { fg = normal_bg, bg = normal_bg },
              separator_visible = { fg = normal_bg, bg = normal_bg },
              modified = { bg = normal_bg },
              modified_visible = { bg = normal_bg },
              modified_selected = { bg = normal_bg },
              duplicate = { bg = normal_bg },
              duplicate_selected = { bg = normal_bg },
              duplicate_visible = { bg = normal_bg },
              indicator_selected = { bg = normal_bg },
              pick = { bg = normal_bg },
              pick_selected = { bg = normal_bg },
              pick_visible = { bg = normal_bg },
              numbers = { bg = normal_bg },
              numbers_visible = { bg = normal_bg },
              numbers_selected = { bg = normal_bg },
          }
	      }
	    end
	  }, {
      "windwp/nvim-autopairs",
      event = "InsertEnter",
      config = function()
        require("nvim-autopairs").setup({})
      end
    }, {
      "nvim-tree/nvim-tree.lua",
      dependencies = { "nvim-tree/nvim-web-devicons" },
      config = function()
        require("nvim-tree").setup()
      end
    }, {
      "nvim-treesitter/nvim-treesitter",
      run = ":TSUpdate",
      config = function()
        require("nvim-treesitter").setup({
          highlight = {
            enable = true,
          },
        })
      end
    }, {
      "neovim/nvim-lspconfig"
    }
  }, 
	


  rocks = {
    hererocks = false,
    enabled = true,
  },
  checker = { enabled = true },
})

-- ALT+[1,2,3,4,5,6,7,8,9] to switch tabs
for i = 1, 9 do
  vim.keymap.set('n', '<A-' .. i .. '>', function()
    local bufs = vim.fn.getbufinfo({ buflisted = 1 })
    local target = bufs[i]
    if target then
      vim.api.nvim_set_current_buf(target.bufnr)
    end
  end, { desc = 'Go to buffer ' .. i })
end

-- ALT+j to cycle through buffer
vim.keymap.set('n', '<A-j>', function()
  local bufs = vim.fn.getbufinfo({ buflisted = 1 })
  local curr = vim.api.nvim_get_current_buf()
  local i = 1
  for idx, buf in ipairs(bufs) do
    if buf.bufnr == curr then i = idx break end
  end
  local next_idx = (i % #bufs) + 1
  vim.api.nvim_set_current_buf(bufs[next_idx].bufnr)
end, { desc = "Next buffer" })

-- ALT+k to cycle through buffer
vim.keymap.set('n', '<A-k>', function()
  local bufs = vim.fn.getbufinfo({ buflisted = 1 })
  local curr = vim.api.nvim_get_current_buf()
  local i = 1
  for idx, buf in ipairs(bufs) do
    if buf.bufnr == curr then i = idx break end
  end
  -- go to previous buffer or wrap around
  local prev_idx = (i - 2) % #bufs + 1
  vim.api.nvim_set_current_buf(bufs[prev_idx].bufnr)
end, { desc = "Previous buffer" })

vim.keymap.set({ "n", "i", "v" }, "<Up>", "<Nop>", { noremap = true, silent = true })
vim.keymap.set({ "n", "i", "v" }, "<Down>", "<Nop>", { noremap = true, silent = true })
vim.keymap.set({ "n", "i", "v" }, "<Left>", "<Nop>", { noremap = true, silent = true })
vim.keymap.set({ "n", "i", "v" }, "<Right>", "<Nop>", { noremap = true, silent = true })

vim.keymap.set("i", "<C-h>", "<Left>")
vim.keymap.set("i", "<C-l>", "<Right>")
vim.keymap.set("i", "<C-j>", "<Down>")
vim.keymap.set("i", "<C-k>", "<Up>")

vim.keymap.set('n', '<C-n>', ':NvimTreeToggle<CR>', { noremap = true, silent = true })

vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
  callback = function()
    vim.opt_local.formatoptions:remove({'r', 'o'})
  end,
})

local function my_on_attach(bufnr)
  local api = require("nvim-tree.api")

  local function opts(desc)
    return {
      desc = "nvim-tree: " .. desc,
      buffer = bufnr,
      noremap = true,
      silent = true,
      nowait = true
    }
  end

  -- load default mappings
  api.config.mappings.default_on_attach(bufnr)

  -- Open file with space bar
  vim.keymap.set("n", "<Space>", api.node.open.edit, opts("Open File"))
end

vim.api.nvim_set_keymap('t', '<Esc>', [[<C-\><C-n><CR>]], { noremap = true, silent = true })

require("nvim-tree").setup({
  on_attach = my_on_attach,
})

require('lspconfig').rust_analyzer.setup{
    settings = {
        ["rust-analyzer"] = {
            cargo = { allFeatures = true },
            checkOnSave = {
                command = "clippy"
            }
        }
    }
}

vim.opt.laststatus = 0
vim.opt.tabstop = 2    
vim.opt.shiftwidth = 2    
vim.opt.expandtab = true 
vim.opt.number = true
vim.opt.termguicolors = true
vim.opt.ruler = false
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.wrap = false
