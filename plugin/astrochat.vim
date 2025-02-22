" plugin/astrochat.vim
if exists('g:loaded_astrochat')
  finish
endif
let g:loaded_astrochat = 1
lua require("astrochat").setup()
