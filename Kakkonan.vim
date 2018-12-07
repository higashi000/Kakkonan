let s:save_cpo = &cpo
set cpo&vim

let parentheses = '('
let brace = '{'
let bracket = '['
let dQuotation = '"'
let sQuotation = "'"
let spaces = ' '

inoremap <expr> ( Completion(parentheses)
inoremap <expr> { Completion(brace)
inoremap <expr> [ Completion(bracket)
inoremap <expr> " Completion(dQuotation)
inoremap <expr> ' Completion(sQuotation)
inoremap <expr> <space> Completion(spaces)

let &cpo = s:save_cpo
unlet s:save_cpo
