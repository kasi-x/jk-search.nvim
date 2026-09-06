if exists("g:loaded_jksearch")
  finish
endif
let g:loaded_jksearch = 1

" vim.g.jksearch_configuration を config.DATA にマージする。
" redirector / proxy は所属機関固有のため、ユーザー設定が必須。
lua require("jksearch.config").setup(vim.g.jksearch_configuration)

command! -nargs=* -bar JKSearch lua require("jksearch").command({ <f-args> })
command! -nargs=0 -bar -bang JKSearchInit lua require("jksearch").init({ visible = <bang>1 })
