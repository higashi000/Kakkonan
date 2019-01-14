let s:save_cpo = &cpo
set cpo&vim

inoremap <expr> ( Completion('(')
inoremap <expr> { Completion('{')
inoremap <expr> \{ Completion('\{')
inoremap <expr> [ Completion('[')
inoremap <expr> " Completion('"')
inoremap <expr> ' Completion("'")
"inoremap <CR> <CR><C-o><S-o><TAB>

function! Completion(inputObject)
  let canComp = ['(', '{', '[', '"', "'",]
  let compObject = [')', '}', ']', '"', "'"]
  let nowArrayPos = 0

  for e in canComp
    if e == a:inputObject
      return a:inputObject.compObject[nowArrayPos]."\<left>"
    endif
    let nowArrayPos += 1
  endfor
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
