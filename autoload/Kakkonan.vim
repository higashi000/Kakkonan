let s:save_cpo = &cpo
set cpo&vim

function! Kakkonan#GetCursorChar(diff)
  let cursorStr = getline('.')
  let cursorCol = col('.')

  return cursorStr[cursorCol + a:diff]
endfunction

function! Kakkonan#Completion(inputObject)
  let canComp = ['(', '{', '[', '"', "'"]
  let compObject = [')', '}', ']', '"', "'"]
  let nowArrayPos = 0

  for i in canComp
    if i == a:inputObject
      return a:inputObject.compObject[nowArrayPos]."\<left>"
    endif
    let nowArrayPos += 1
  endfor

endfunction

function! Kakkonan#InputEnter()
  let cursorChar = GetCursorChar(-2)

  if (cursorChar == '{')
    return "\<CR>\<C-o>\<S-o>"
  endif

  return "\<CR>"
endfunction

function! Kakkonan#DeleteChar()
  let leftDelete = ['(', '{', '[', "'", '"']
  let rightDelete = [')', '}', ']', "'", '"']

  let cursorLeftChar = GetCursorChar(-2)
  let cursorRightChar = GetCursorChar(-1)

  let tmp = 0
  for i in leftDelete
    if i == cursorLeftChar
      if cursorRightChar == rightDelete[tmp]
        return "\<BS>\<right>\<BS>"
      endif
    endif
    let tmp += 1
  endfor

  return "\<BS>"
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
