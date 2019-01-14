let s:save_cpo = &cpo
set cpo&vim

inoremap <expr> ( Completion('(')
inoremap <expr> { Completion('{')
inoremap <expr> \{ Completion('\{')
inoremap <expr> [ Completion('[')
inoremap <expr> " Completion('"')
inoremap <expr> ' Completion("'")
inoremap <expr> <CR> InputEnter()

function! Completion(inputObject)
  let canComp = ['(', '{', '[', '"', "'",]
  let compObject = [')', '}', ']', '"', "'"]
  let nowArrayPos = 0

  for i in canComp
    if i == a:inputObject
      return a:inputObject.compObject[nowArrayPos]."\<left>"
    endif
    let nowArrayPos += 1
  endfor
endfunction

function! InputEnter()
  let cursorStr = getline('.')
  let cursorCol = col('.')

  if (cursorStr[cursorCol - 2] == '{')
    return "\<CR>\<C-o>\<S-o>"
  endif

  return "\<CR>"
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
