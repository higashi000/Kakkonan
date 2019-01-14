let s:save_cpo = &cpo
set cpo&vim

inoremap <expr> ( Completion('(')
inoremap <expr> { Completion('{')
inoremap <expr> \{ Completion('\{')
inoremap <expr> [ Completion('[')
inoremap <expr> " Completion('"')
inoremap <expr> ' Completion("'")

function! Completion()
  let canComp = ['(', '{', '[', '"', "'",]
  let compObject = [')', '}', ']', '"', "'"]
  let nowArrayPos = 0

  for e in canComp
    if e == inputObject
      return inputObject.compObject[nowArrayPos]."\<left>"
    endif
    let nowArrayPos += 1
  endfor
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
