let s:save_cpo = &cpo
set cpo&vim

let s:brackets = {
\ '(': ')',
\ '{': '}',
\ '[': ']',
\ '"': '"',
\ "'": "'",
\ '`': '`',
\ }

function! s:getCursorChar(diff) abort
  let cursorStr = getline('.')
  let cursorCol = col('.')

  return cursorStr[cursorCol + a:diff]
endfunction

function! kakkonan#Completion(inputObject) abort
  if a:inputObject == '"' || a:inputObject == "'" || a:inputObject == "`"
      if s:getCursorChar(-1) == a:inputObject
          return "\<right>"
      endif
  endif

  if has_key(s:brackets, a:inputObject)
      return a:inputObject.s:brackets[a:inputObject]."\<left>"
  endif
endfunction

function! kakkonan#escapeBrackets(inputObject) abort
    if s:getCursorChar(-1) == a:inputObject
        return "\<right>"
    endif

    return a:inputObject
endfunction

function! kakkonan#InputEnter() abort
  let cursorChar = s:getCursorChar(-2)
  let cursorRightChar = s:getCursorChar(-1)

  if has_key(s:brackets, cursorChar) && s:brackets[cursorChar] == cursorRightChar
    return "\<CR>\<C-o>\<S-o>"
  endif

  return "\<CR>"
endfunction

function! kakkonan#DeleteChar() abort
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

let &cpo = s:save_cpo
unlet s:save_cpo
