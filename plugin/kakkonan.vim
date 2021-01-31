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
inoremap <expr> \( kakkonan#NotCompletion('\(')
inoremap <expr> \{ kakkonan#NotCompletion('\{')
inoremap <expr> \[ kakkonan#NotCompletion('\[')
inoremap <expr> \' kakkonan#NotCompletion("\'")
inoremap <expr> \" kakkonan#NotCompletion('\"')
inoremap <expr> \` kakkonan#NotCompletion('\`')
inoremap <expr> <space> kakkonan#InputSpace()
inoremap <expr> <CR> kakkonan#InputEnter()
inoremap <expr> <BS> kakkonan#DeleteChar()

let &cpo = s:save_cpo
unlet s:save_cpo
