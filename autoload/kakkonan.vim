let s:save_cpo = &cpo
set cpo&vim

function! s:getCursorChar(diff)
  let cursorStr = getline('.')
  let cursorCol = col('.')

  return cursorStr[cursorCol + a:diff]
endfunction

function! kakkonan#Completion(inputObject)
  let canComp = ['(', '{', '[', '"', "'", "`"]
  let compObject = [')', '}', ']', '"', "'", "`"]
  let nowArrayPos = 0

  for i in canComp
    if i == a:inputObject
      return a:inputObject.compObject[nowArrayPos]."\<left>"
    endif
    let nowArrayPos += 1
  endfor

endfunction

function! kakkonan#NotCompletion(inputObject)
  return a:inputObject[1]
endfunction

function! kakkonan#InputEnter()
  let cursorChar = s:getCursorChar(-2)
  let cursorRightChar = s:getCursorChar(-1)

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
  elseif (cursorChar == "`" && cursorRightChar == "`")
    return "\<CR>\<C-o>\<S-o>"
  endif

  return "\<CR>"
endfunction

function! kakkonan#DeleteChar()
  let leftDelete = ['(', '{', '[', "'", '"', "`"]
  let rightDelete = [')', '}', ']', "'", '"', "`"]

  let nowCursorChar = s:getCursorChar(-1)

  let tmp = 0

  if nowCursorChar == " "
    let cursorLeftChar = s:getCursorChar(-1)
    let cursorRightChar = s:getCursorChar(0)

    for i in leftDelete
      if i == cursorLeftChar
        if cursorRightChar == rightDelete[tmp]
          return "\<BS>\<right>\<BS>"
        endif
      endif
    endfor
  else
    let cursorLeftChar = s:getCursorChar(-2)
    let cursorRightChar = s:getCursorChar(-1)

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

function! kakkonan#InputSpace()
  let leftChar = ['(', '{', '[', '"', "'", "`"]
  let rightChar = [')', '}', ']', '"', "'", "`"]

  let cursorLeftChar = s:getCursorChar(-2)
  let cursorRightChar = s:getCursorChar(-1)

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
