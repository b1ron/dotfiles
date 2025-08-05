--- theme and stuff
--- vim.cmd.colorscheme('mine')

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
  {
    "sainnhe/gruvbox-material",
    priority = 1000,
    config = function()
      vim.g.gruvbox_material_better_performance = 1
      vim.g.gruvbox_material_disable_italic_comment = 1
      vim.cmd.colorscheme("gruvbox-material")

      vim.cmd([[
        highlight FloatShadow gui=NONE
        highlight MatchParen guibg=#504945 gui=NONE guisp=NONE

        highlight Normal guibg=#121212
        highlight StatusLine guibg=#0D0D0D

        highlight TelescopeNormal guibg=#0F0F0F
        highlight TelescopeBorder guibg=#0F0F0F

        highlight Pmenu guibg=#0D0D0D
        highlight NormalFloat guibg=#0D0D0D
        highlight CursorLine guibg=#0D0D0D

        highlight FloatBorder guibg=#0B0B0B
      ]])
    end,
  },
  -- telescope
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
  },

  -- treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
  },

  -- autopairs (auto-close brackets, etc.)
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup()
    end,
  },

  -- basic autocompletion
  {
    'hrsh7th/nvim-cmp',
    event = "InsertEnter",
    dependencies = {
      'hrsh7th/cmp-buffer', -- words from current buffer
      'hrsh7th/cmp-path',   -- file paths
    },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        mapping = cmp.mapping.preset.insert({
          ['<Tab>'] = cmp.mapping.confirm({ select = true }),
        }),
        sources = {
          { name = 'buffer' },
          { name = 'path' },
        },
      })
    end,
  },
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

local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')

require('telescope').setup{
  defaults = {
    mappings = {
      i = {
        ["<C-y>"] = function(prompt_bufnr)
          local entry = action_state.get_selected_entry()
          local filename = entry.path or entry.filename or entry.value
          vim.fn.setreg('+', filename)  -- copy to system clipboard
          print("Copied to clipboard: " .. filename)
          actions.close(prompt_bufnr)
        end,
      },
    },
  },
}

