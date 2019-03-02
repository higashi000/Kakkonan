let s:save_cpo = &cpo
set cpo&vim

function! GetCursorChar(diff)
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

function! Kakkonan#NotCompletion(inputObject)
  return a:inputObject[1]
endfunction

function! Kakkonan#InputEnter()
  let cursorChar = GetCursorChar(-2)
  let cursorRightChar = GetCursorChar(-1)

  if (cursorChar == '{' && cursorRightChar == '}')
    return "\<CR>\<C-o>\<S-o>"
  elseif (cursorChar == '(' && cursorRightChar == ')')
    return "\<CR>\<C-o>\<S-o>"
  elseif (cursorChar == '[' && cursorRightChar == ']')
    return "\<CR>\<C-o>\<S-o>"
  elseif (cursorChar == '"' && cursorRightChar == '"')
    return "\<CR>\<C-o>\<S-o>"
  elseif (cursorChar == "'" && cursorRightChar == "'")
    return "\<CR>\<C-o>\<S-o>"
  endif

  return "\<CR>"
endfunction

function! Kakkonan#DeleteChar()
  let leftDelete = ['(', '{', '[', "'", '"']
  let rightDelete = [')', '}', ']', "'", '"']

  let nowCursorChar = GetCursorChar(-1)

  let tmp = 0

  if nowCursorChar == " "
    let cursorLeftChar = GetCursorChar(-1)
    let cursorRightChar = GetCursorChar(0)

    for i in leftDelete
      if i == cursorLeftChar
        if cursorRightChar == rightDelete[tmp]
          return "\<BS>\<right>\<BS>"
        endif
      endif
    endfor
  else
    let cursorLeftChar = GetCursorChar(-2)
    let cursorRightChar = GetCursorChar(-1)

    for i in leftDelete
      if i == cursorLeftChar
        if cursorRightChar == rightDelete[tmp]
          return "\<BS>\<right>\<BS>"
        endif
      endif
      let tmp += 1
    endfor
  endif

  return "\<BS>"
endfunction

function! Kakkonan#InputSpace()
  let leftChar = ['(', '{', '[', '"', "'"]
  let rightChar = [')', '}', ']', '"', "'"]

  let cursorLeftChar = GetCursorChar(-2)
  let cursorRightChar = GetCursorChar(-1)

  let tmp = 0
  for i in leftChar
    if i == cursorLeftChar
      if cursorRightChar == rightChar[tmp]
        return "  \<left>"
      endif
    endif
    let tmp += 1
  endfor

  return " "
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
