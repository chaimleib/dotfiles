" Vim syntax file
" Language: CS164-Grammar
" Maintainer: Raymond Halbert <rhalbert@berkeley.edu>
" Latest Revision: 18 November 2010

if exists("b:current_syntax")
	finish
endif

syn	match	cs164GrmRegex		'/\([^/]\|\/\)\+/' contains=NONE
syn	keyword	cs164GrmTodo		TODO	contained
syn	match	cs164GrmComment		'//.*'	contains=cs164GrmTodo
syn	match	cs164GrmInteger		'\d\+'
syn	region	cs164GrmString		start="'" end="'"
syn	match	cs164GrmId		'[A-Z][A-Za-z_0-9]*'

syn	match	cs164GrmDirectives	/%ignore/
syn	match	cs164GrmDirectives	/%import/
syn	match	cs164GrmDirectives	/%optional/
syn	match	cs164GrmDirectives	/%left/
syn	match	cs164GrmDirectives	/%right/
syn	match	cs164GrmDirectives	/%prec/
syn	match	cs164GrmDirectives	/%dprec/

syn	match	cs164GrmStructure	/%%/

syn	include @Python syntax/python.vim
syn	region	cs164GrmAction		start="%{" end="%}" contains=@Python

let	b:current_syntax = "cs164grammar"
hi def	link cs164GrmInteger	Constant
hi def	link cs164GrmRegex	Constant
hi def	link cs164GrmString	Constant
hi def	link cs164GrmId		Identifier
hi def	link cs164GrmComment	Comment

hi	cs164GrmStructure	ctermfg=yellow ctermbg=magenta cterm=bold
hi	cs164GrmDirectives	ctermfg=cyan
hi	Constant	ctermfg=red
hi	Comment		ctermfg=magenta cterm=none
hi	Identifier	ctermfg=green
