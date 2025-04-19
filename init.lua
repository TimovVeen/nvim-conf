-- https://learnxinyminutes.com/docs/lua/
-- :help lua-guide
-- (or HTML version): https://neovim.io/doc/user/lua-guide.html

vim.g.mapleader = ' '
vim.g.maplocalleader = ','
vim.g.have_nerd_font = true

vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

-- [[ Setting options ]]
-- See `:help vim.opt`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

vim.opt.number = true
vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

vim.opt.clipboard = 'unnamedplus'

-- Enable break indent
vim.opt.breakindent = false

vim.opt.autochdir = false

-- Save undo history
vim.opt.undofile = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 7

vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.smartindent = true

-- vim.opt.spelllang = 'en'
-- vim.opt.spell = true

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

local keyopts = { noremap = true, silent = true }

-- Move to previous/next
vim.keymap.set('n', '<A-,>', '<Cmd>BufferPrevious<CR>', keyopts)
vim.keymap.set('n', '<A-.>', '<Cmd>BufferNext<CR>', keyopts)

-- Re-order to previous/next
vim.keymap.set('n', '<A-<>', '<Cmd>BufferMovePrevious<CR>', keyopts)
vim.keymap.set('n', '<A->>', '<Cmd>BufferMoveNext<CR>', keyopts)

-- Goto buffer in position...
vim.keymap.set('n', '<A-1>', '<Cmd>BufferGoto 1<CR>', keyopts)
vim.keymap.set('n', '<A-2>', '<Cmd>BufferGoto 2<CR>', keyopts)
vim.keymap.set('n', '<A-3>', '<Cmd>BufferGoto 3<CR>', keyopts)
vim.keymap.set('n', '<A-4>', '<Cmd>BufferGoto 4<CR>', keyopts)
vim.keymap.set('n', '<A-5>', '<Cmd>BufferGoto 5<CR>', keyopts)
vim.keymap.set('n', '<A-6>', '<Cmd>BufferGoto 6<CR>', keyopts)
vim.keymap.set('n', '<A-7>', '<Cmd>BufferGoto 7<CR>', keyopts)
vim.keymap.set('n', '<A-8>', '<Cmd>BufferGoto 8<CR>', keyopts)
vim.keymap.set('n', '<A-9>', '<Cmd>BufferGoto 9<CR>', keyopts)
vim.keymap.set('n', '<A-0>', '<Cmd>BufferLast<CR>', keyopts)

vim.keymap.set('n', '<A-c>', '<Cmd>BufferClose<CR>', keyopts)

vim.api.nvim_create_user_command("OpenPdf", function()
  local filepath = vim.api.nvim_buf_get_name(0)
  if filepath:match("%.typ$") then
    os.execute("zathura --fork " ..
      vim.fn.shellescape(filepath:gsub("%.typ$", ".pdf"):gsub("(.*/)", "%1out/")) .. " > /dev/null 2>&1 &")
  end
end, {})

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd('BufEnter', {
  command = 'syntax sync fromstart',
  pattern = { '*.ly', '*.ily', '*.tex' },
})

vim.diagnostic.config({
  virtual_text = { current_line = true }
})

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.uv.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require('lazy').setup {
  { import = 'plugins' },
  { 'numToStr/Comment.nvim',                   opts = {} },
  { 'nvim-treesitter/nvim-treesitter-context', opts = {} },

  -- Highlight todo, notes, etc in comments
  { 'folke/todo-comments.nvim',                event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = true } },

  ui = {
    icons = {}
  }
}

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
