--- theme and stuff
vim.cmd.colorscheme('mine')

vim.opt.number = true                              
vim.opt.relativenumber = true                      
vim.opt.cursorline = true                          
vim.opt.wrap = false                               
vim.opt.scrolloff = 10                             
vim.opt.sidescrolloff = 8

vim.opt.tabstop = 2                                
vim.opt.shiftwidth = 2                             
vim.opt.softtabstop = 2                            
vim.opt.expandtab = true                           
vim.opt.smartindent = true                         
vim.opt.autoindent = true

vim.g.mapleader = ' '

-- Load lazy.nvim
vim.opt.rtp:prepend("~/.config/nvim/lazy/lazy.nvim")

-- Load plugins
require("lazy").setup({
  -- Example theme
  --- { "ellisonleao/gruvbox.nvim" },
  'nvim-telescope/telescope.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  'nvim-treesitter/nvim-treesitter', 
  build = ':TSUpdate',
})

require('nvim-treesitter.configs').setup {
  ensure_installed = { "c", "lua", "python", "javascript" }, -- add languages you want
  highlight = {
    enable = true,              -- enable Treesitter-based syntax highlighting
    additional_vim_regex_highlighting = false, -- disable traditional syntax if you want
  },
}

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fc', builtin.commands, {})

