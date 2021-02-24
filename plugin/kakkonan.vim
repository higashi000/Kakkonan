if exists('g:loaded_noachat')
    finish
endif
let g:loaded_kakkonan = 1

let s:save_cpo = &cpo
set cpo&vim

noremap <expr> ) kakkonan#escapeBrackets(')')
inoremap <expr> } kakkonan#escapeBrackets('}')
inoremap <expr> ] kakkonan#escapeBrackets(']')

inoremap <expr> <CR> kakkonan#InputEnter()
inoremap <expr> <BS> kakkonan#DeleteChar()

command! -range -nargs=1 KakkonanSurround :call kakkonan#surround#brackets(<f-args>)

function! kakkonan#completion(inputBrackets) abort
    let bracket = denops#request("kakkonan", "kakkonanCompletion", [a:inputBrackets])

    return bracket + "\<left>"
endfunction



let &cpo = s:save_cpo
unlet s:save_cpo
