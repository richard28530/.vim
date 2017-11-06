" Vim syntax file
" Language: 	YANG
" Remark:		RFC 6020 http://tools.ietf.org/html/rfc6020
" Version: 		1
" Last Change:	2011 Sep 28
" Maintainer: 	Matt Parker <mparker@computer.org>
"------------------------------------------------------------------

if version < 600
	syntax clear
elseif exists("b:current_syntax")
	finish
endif

" yang has keywords with a '-' in them
setlocal iskeyword+=-

" keywords are case-sensitive
syn case match

" enable block folding
syn region yangBlock start="{" end="}" fold transparent


" built-in types (section 4.2.4)
syn keyword yangType decimal64 int8 int16 int32 int64 uint8 uint16 uint32 uint64
syn keyword yangType string boolean enumeration bits binary leafref identityref empty instance-identifier

syn match yangIdentifier /\c\<\h\+[A-Za-z0-9_-]*\>/

" identifiers must not begin with 'xml'. this rule must be defined after the previous yangIdentifier to work properly.
syn match yangBadIdentifier /\c\<xml\(\h\+[A-Za-z0-9_-]\)*\>/

" statement keywords
syn keyword yangStatement argument augment base belongs-to
syn keyword yangStatement config contact default description error-app-tag error-message
syn keyword yangStatement extension deviation deviate fraction-digits
syn keyword yangStatement include input key length
syn keyword yangStatement list mandatory max-elements min-elements module must namespace
syn keyword yangStatement ordered-by organization output path pattern position
syn keyword yangStatement presence range reference refine require-instance revision
syn keyword yangStatement revision-date status submodule type
syn keyword yangStatement units value when yang-version yin-element
syn keyword yangStatement anyxml bit case choice container enum feature grouping identity import nextgroup=yangIdentifier skipwhite
syn keyword yangStatement leaf leaf-list list notification prefix rpc typedef unique uses nextgroup=yangIdentifier skipwhite

" other keywords
syn keyword yangOther add current delete deprecated max min not-supported
syn keyword yangOther obsolete replace system unbounded user

" boolean constants (separated from the 'other keywords' for vim syntax purpose)
syn keyword yangBoolean true false

" if-feature (separated from 'statement keywords' for vim syntax purposes)
syn keyword yangConditional if-feature

" comments
syn region yangComment start=/\/\*/ end=/\*\//
syn region yangComment start="//" end="$" 

" strings
syn region yangString start=+"+ skip=+\\\\\|\\"+ end=+"+
syn region yangString start=+'+ skip=+\\\\\|\\'+ end=+'+

" dates
syn match yangDateArg /"\=\<\d\{4}-\d\{2}-\d\{2}\>"\=/

" length-arg TODO: this needs to also include the pipe and individual numbers (i.e. fixed length)
syn match yangLengthArg /"\(\d\+\|min\)\s*\.\.\s*\(\d\+\|max\)"/

" numbers
syn match yangNumber /\<[+-]\=\d\+\>/
syn match yangNumber	"\<0x\x\+\>"


"-------------------------------------
" and now for the highlighting

" things with one-to-one mapping
hi def link yangBadIdentifier Error
hi def link yangIdentifier Identifier
hi def link yangString String
hi def link yangComment Comment
hi def link yangNumber Number
hi def link yangBoolean Boolean
hi def link yangConditional Conditional
hi def link yangType Type

" arbitrary mappings
hi def link yangKeyword Keyword
hi def link yangStatement Statement
hi def link yangModule Type
hi def link yangDateArg Special
hi def link yangLengthArg Special

let b:current_syntax = "yang"

