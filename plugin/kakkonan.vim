if exists('g:loaded_noachat')
    finish
endif
let g:loaded_kakkonan = 1

let s:save_cpo = &cpo
set cpo&vim

inoremap <expr> ( kakkonan#Completion('(')
inoremap <expr> { kakkonan#Completion('{')
inoremap <expr> [ kakkonan#Completion('[')
inoremap <expr> " kakkonan#Completion('"')
inoremap <expr> ' kakkonan#Completion("'")
inoremap <expr> ` kakkonan#Completion("`")
inoremap <expr> ) kakkonan#escapeBrackets(')')
inoremap <expr> } kakkonan#escapeBrackets('}')
inoremap <expr> ] kakkonan#escapeBrackets(']')

inoremap <expr> <CR> kakkonan#InputEnter()
inoremap <expr> <BS> kakkonan#DeleteChar()

vnoremap <expr> ( kakkonan#surround#brackets()

command! -range -nargs=1 KakkonanSurround :call kakkonan#surround#brackets(<f-args>)

let &cpo = s:save_cpo
unlet s:save_cpo
