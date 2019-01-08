let s:save_cpo = &cpo
set cpo&vim

inoremap <expr> ( Completion('(')
inoremap <expr> { Completion('{')
inoremap <expr> [ Completion('[')
inoremap <expr> " Completion('"')
inoremap <expr> ' Completion("'")
""inoremap <expr> <space> Completion(' ')

function! Completion(compObject)
  if (a:compObject == '(')
    return "()\<left>"
  elseif (a:compObject == '{')
    return "{}\<left>"
  elseif (a:compObject == '[')
    return "[]\<left>"
  elseif (a:compObject == '"')
    return a:compObject.a:compObject."\<left>"
  elseif (a:compObject == "'")
    return "''\<left>"
  endif
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
