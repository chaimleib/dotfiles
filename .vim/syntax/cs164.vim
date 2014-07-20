" Vim syntax file
" Language: CS164
" Maintainer: Raymond Halbert <rhalbert@berkeley.edu>
" Latest Revision: 18 November 2010

if exists("b:current_syntax")
	finish
endif

syn 	keyword	cs164Keywords 		def lambda print error ite in isTable
syn 	keyword	cs164CoroutineKeywords	coroutine resume yield
syn	keyword cs164EvalKeywords	eval import

syn 	keyword	cs164SugaringKeywords 	if else while for
syn 	keyword	cs164SugaringKeywords 	len append isTable isList listIter

syn 	keyword	cs164Constant 		null 
syn 	match	cs164Integer 		'\d\+'
syn 	region	cs164String 		start="'" end="'"
syn	region	cs164String		start='"' end='"'
syn 	match	cs164Id 		"[a-zA-Z_][a-zA-Z_0-9]*"

syn 	match	cs164Comment 		"#.*$"

syn 	region	cs164StatementBlock start="{" end="}" fold transparent

let 	b:current_syntax = "cs164"
hi def 	link cs164Keywords Statement
hi def 	link cs164SugaringKeywords Statement
hi def	link cs164EvalKeywords Statement
hi def 	link cs164String Constant
hi def 	link cs164Integer Constant
hi def 	link cs164Constant Constant
hi def 	link cs164Comment Comment
hi def 	link cs164Id Identifier

hi	cs164StatementBlock	ctermbg=grey
hi	cs164CoroutineKeywords	ctermfg=yellow
hi 	Constant 	ctermfg=red
hi 	Comment 	ctermfg=magenta cterm=none
hi	Statement	ctermfg=cyan
hi 	Identifier 	ctermfg=green
"hi	Identifier	ctermfg=green cterm=none
