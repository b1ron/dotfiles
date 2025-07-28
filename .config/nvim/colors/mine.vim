" Vim color file modified by ME
" Maintainer:	The Vim Project <https://github.com/vim/vim>
" Last Change:	2023 Aug 10
" Former Maintainer:	Bram Moolenaar <Bram@vim.org>

" This is the default color scheme.  It doesn't define the Normal
" highlighting, it uses whatever the colors used to be.

" Set 'background' back to the default.  The value can't always be estimated
" and is then guessed.
" hi clear Normal
" set bg&
" hi Normal ctermbg=none guibg=none
" hi Normal guibg=

" Custom
hi Number guifg=#d8a0f0 "Purple for numbers
hi String guifg=#d8a0f0 "Purple for strings
hi Comment guifg=#4e9f3d  " Green for comments
hi Keyword guifg=#FF9E3D  " Orange for statement keywords
hi Type guifg=#90e090  " Light green for built-in types
hi Structure guifg=#90e090  " Light green for built-in methods
hi Function guifg=#5fa8d3  " Light blue for functions 
hi Special guifg=#5fa8d3  " Light blue for special functions 

hi Function guifg=#5fa8d3

" Link Treesitter groups to Function
hi! link @function Function
hi! link @function.call Function
hi! link @method Function
hi! link @method.call Function

let colors_name = "mine"

" vim: sw=2
