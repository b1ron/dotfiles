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
vim.opt.hlsearch = false

-- TODO add reload for lazy

vim.api.nvim_create_autocmd("FileType", {
  pattern = "c",
  callback = function()
    vim.bo.commentstring = "/* %s */"
  end
})

local term_buf = nil

local function compile_and_run_c(flags)
  local file = vim.fn.expand("%")
  local out = vim.fn.expand("%:r")
  return "gcc " .. flags .. " " .. file .. " -o " .. out .. " && ./" .. out
end

vim.keymap.set("t", "<F5>", [[<C-\><C-n>:bd!<CR>]], { silent = true })

vim.keymap.set("n", "<F5>", function()
  local cmd = compile_and_run_c("-Wall -std=c89")
  if term_buf and vim.api.nvim_buf_is_valid(term_buf) then
    vim.api.nvim_set_current_buf(term_buf)

    vim.cmd("split | terminal")
    vim.cmd("startinsert")
    vim.fn.chansend(vim.b.terminal_job_id, cmd .. "\n")
  else
    term_buf = vim.api.nvim_get_current_buf()
    vim.cmd("split | terminal")
    vim.cmd("startinsert")
    vim.fn.chansend(vim.b.terminal_job_id, cmd .. "\n")
  end
end, { silent = true })

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

  -- vim-commentary (comment out stuff)
  {
    "tpope/vim-commentary",
    event = "VeryLazy", -- loads it lazily, e.g., after startup
  },

  -- formatter
  {
    "mhartington/formatter.nvim",
    config = function()
      require("formatter").setup({
        logging = true,
        filetype = {
          c = {
            require("formatter.filetypes.c").clangformat,
          },
          cpp = {
            require("formatter.filetypes.cpp").clangformat,
          },
          lua = {
            require("formatter.filetypes.lua").stylua,
          },
        },
      })
    end,
  }
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

