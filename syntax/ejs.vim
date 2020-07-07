runtime! syntax/html.vim
unlet b:current_syntax

" Include JavaScript syntax
syn include @ejsJavaScript syntax/javascript.vim

syn region ejsScriptlet matchgroup=ejsTag start=/<%/  keepend end=/%>/ contains=@ejsJavaScript
syn region ejsExpr      matchgroup=ejsTag start=/<%[=-]/ keepend end=/%>/ contains=@ejsJavaScript
syn region htmlComment start=/<%#/ end=/%>/ contains=@Spell

" Redefine htmlTag and htmlString so that they can contain ejsExpr and
" ejsScriptlet
syn clear htmlTag
syn region htmlTag start=+<[^/%]+ end=+>+ fold contains=htmlTagN,htmlString,htmlArg,htmlValue,htmlTagError,htmlEvent,htmlCssDefinition,@htmlPreproc,@htmlArgCluster,ejsExpr,ejsScriptlet,javaScript
syn clear htmlString
syn region  htmlString   contained start=+"+ end=+"+ contains=htmlSpecialChar,javaScriptExpression,@htmlPreproc,ejsExpr,ejsScriptlet,javaScript
syn region  htmlString   contained start=+'+ end=+'+ contains=htmlSpecialChar,javaScriptExpression,@htmlPreproc,ejsExpr,ejsScriptlet,javaScript

" Allow { or } to appear in an expression alone (do not treat the contents of
" the block as JS)
syn clear jsFuncBlock
syn clear jsIfElseBlock
syn clear jsTryCatchBlock
syn clear jsFinallyBlock
syn clear jsSwitchBlock
syn clear jsRepeatBlock
syn clear jsBlock
syn clear jsParensError

" syn keyword ejsPrint contained print
syn match javaScriptType        /\<\zsvars\ze\./
syn match javaScriptSpecial     /\<\zsexports\ze\./
syn match javaScriptFunction    /\<\zsprint\ze(/
syn match javaScriptFunction    /\<\zsinclude\ze(/
syn match javaScriptFunction    /\<\zsincludeObject\ze(/
syn match javaScriptFunction    /\<\zsfetch\ze(/
syn match javaScriptFunction    /\<\zsfetchObject\ze(/

command -nargs=+ HiLink hi def link <args>
HiLink  ejsTag      htmlTag
delcommand HiLink

let b:current_syntax = "ejs"

