let s:save_cpo = &cpo
set cpo&vim

inoremap <expr> ( Kakkonan#Completion('(')
inoremap <expr> { Kakkonan#Completion('{')
inoremap <expr> [ Kakkonan#Completion('[')
inoremap <expr> " Kakkonan#Completion('"')
inoremap <expr> ' Kakkonan#Completion("'")
inoremap <expr> ' Kakkonan#Completion("`")
inoremap <expr> \( Kakkonan#NotCompletion('\(')
inoremap <expr> \{ Kakkonan#NotCompletion('\{')
inoremap <expr> \[ Kakkonan#NotCompletion('\[')
inoremap <expr> \' Kakkonan#NotCompletion("\'")
inoremap <expr> \" Kakkonan#NotCompletion('\"')
inoremap <expr> \" Kakkonan#NotCompletion('\`')
inoremap <expr> <space> Kakkonan#InputSpace()
inoremap <expr> <CR> Kakkonan#InputEnter()
inoremap <expr> <BS> Kakkonan#DeleteChar()

let &cpo = s:save_cpo
unlet s:save_cpo
