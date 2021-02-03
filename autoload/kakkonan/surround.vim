let s:brackets = {
    \ '(': ')',
    \ '{': '}',
    \ '[': ']',
    \ '"': '"',
    \ "'": "'",
    \ '`': '`',
    \ }

func kakkonan#surround#brackets(bracket) range
    let pos = getpos('.')

    normal `<

    let startLineNo = line(".")
    let startColNo = col(".")

    normal `>
    let finishLineNo = line(".")
    let finishColNo = col(".")

    let lineStr = getline('.')

    if (startLineNo != finishLineNo)
        return
    endif

    call setline(startLineNo, lineStr[0 : startColNo - 2] . a:bracket . lineStr[startColNo - 1 : finishColNo - 1] . s:brackets[a:bracket] . lineStr[finishColNo:])
endfunction
