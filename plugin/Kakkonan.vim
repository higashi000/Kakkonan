let s:save_cpo = &cpo
set cpo&vim

inoremap <expr> ( Completion('(')
inoremap <expr> { Completion('{')
inoremap <expr> \{ Completion('\{')
inoremap <expr> [ Completion('[')
inoremap <expr> " Completion('"')
inoremap <expr> ' Completion("'")
inoremap <expr> <CR> InputEnter()
inoremap <expr> <BS> DeleteChar()

let &cpo = s:save_cpo
unlet s:save_cpo
