" Vim syntax file
" Language: TenPlate Templating
" Maintainer: Frankie Baffa
" Version: 0.1.3

" Configures the syntax highlighting for tenplate files.
" Copyright (C) 2025  Frankie Baffa (frankiebaffa@gmail.com)
"
" This program is free software: you can redistribute it and/or modify
" it under the terms of the GNU General Public License as published by
" the Free Software Foundation, either version 3 of the License, or
" (at your option) any later version.
"
" This program is distributed in the hope that it will be useful,
" but WITHOUT ANY WARRANTY; without even the implied warranty of
" MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
" GNU General Public License for more details.
"
" You should have received a copy of the GNU General Public License
" along with this program.  If not, see <http://www.gnu.org/licenses/>.

if exists("b:current_syntax")
	finish
endif

" Highlight links

hi def link TenPlateKeyword Keyword
hi def link TenPlateSymbol Macro
hi def link TenPlateEscape Macro
hi def link TenPlateTag Constant
hi def link TenPlateVariable Label
hi def link TenPlateString String

syn match TenPlateEscapeWhitespace /\\\%($\|\s\)/
hi def link TenPlateEscapeWhitespace TenPlateEscape

syn cluster TenPlateTopLevel contains=TenPlateEscapeWhitespace

syn match TenPlatePathEscapeQuote /\\"/ contained
hi def link TenPlatePathEscapeQuote TenPlateEscape

syn match TenPlateEndTagSlash /\// contained
hi def link TenPlateEndTagSlash TenPlateSymbol

" Tag match-groups

syn match TenPlateTagStart '{%\s*' contained
hi def link TenPlateTagStart TenPlateTag

syn match TenPlateSelfCloseTagEnd '\s*/%}' contained
hi def link TenPlateSelfCloseTagEnd TenPlateTag

syn match TenPlateBlockTagEnd '\s*%}' contained
hi def link TenPlateBlockTagEnd TenPlateTag

" Add tag
" ex: {% add id %}0{% /add %}

syn match TenPlateAddVariable /\s*[a-zA-Z]\%([a-zA-Z0-9_\-]\)*\s*/ contained
			\ nextgroup=TenPlateAddEquals
hi def link TenPlateAddVariable TenPlateVariable

syn keyword TenPlateAdd add contained
hi def link TenPlateAdd TenPlateKeyword

syn region TenPlateAddTag start=/{%\s*add\s*/ end=/\s*%}/
			\ contains=TenPlateTagStart,TenPlateBlockTagEnd,TenPlateAdd,TenPlateAddVariable
			\ keepend

syn match TenPlateAddEndTag /{%\s*\/add\s*%}/
			\ contains=TenPlateAdd,TenPlateEndTagSlash
hi def link TenPlateAddEndTag TenPlateTag

syntax cluster TenPlateTopLevel add=TenPlateAddTag,TenPlateAddEndTag

" Assert tag
" ex: {% assert :id == 0 || :name == "Somebody" /%}

syn match TenPlateAssertAnd /&&/ contained
hi def link TenPlateAssertAnd TenPlateSymbol

syn match TenPlateAssertOr /||/ contained
hi def link TenPlateAssertOr TenPlateSymbol

syn match TenPlateAssertEq /==/ contained
hi def link TenPlateAssertEq TenPlateSymbol

syn match TenPlateAssertNe /!=/ contained
hi def link TenPlateAssertNe TenPlateSymbol

syn match TenPlateAssertGt />/ contained
hi def link TenPlateAssertGt TenPlateSymbol

syn match TenPlateAssertGe />=/ contained
hi def link TenPlateAssertGe TenPlateSymbol

syn match TenPlateAssertLt /</ contained
hi def link TenPlateAssertLt TenPlateSymbol

syn match TenPlateAssertLe /<=/ contained
hi def link TenPlateAssertLe TenPlateSymbol

syn match TenPlateAssertNestStart /(/ contained
hi def link TenPlateAssertNestStart TenPlateSymbol

syn match TenPlateAssertNestEnd /)/ contained
hi def link TenPlateAssertNestEnd TenPlateSymbol

syn region TenPlateAssertText start=/"/ skip=/\\"/ end=/"/ contained
			\ contains=TenPlatePathEscapeQuote
hi def link TenPlateAssertText TenPlateString

syn match TenPlateAssertVariable /[a-zA-Z_0-9.]\+/ contained
hi def link TenPlateAssertVariable TenPlateVariable

syn keyword TenPlateAssert assert contained
hi def link TenPlateAssert TenPlateKeyword

syn region TenPlateAssertTag start=/{%\s*assert\s*/ end=/\s*\/%}/
			\ contains=TenPlateTagStart,TenPlateSelfCloseTagEnd,
				\ TenPlateAssert,TenPlateAssertNestStart,TenPlateAssertNestEnd,
				\ TenPlateAssertVariable,TenPlateAssertText,TenPlateAssertAnd,
				\ TenPlateAssertOr,TenPlateAssertEq,
				\ TenPlateAssertNe,TenPlateAssertGt,TenPlateAssertGe,
				\ TenPlateAssertLt,TenPlateAssertLe
			\ keepend

syntax cluster TenPlateTopLevel add=TenPlateAssertTag

" Call tag
" ex: {% call "./prepare.tenplate" /%}

syn region TenPlateCallPath start=/\s*"/ skip=/\\"/ end=/"\s*/ oneline keepend
			\ contained
			\ contains=TenPlatePathEscapeQuote
hi def link TenPlateCallPath TenPlateString

syn match TenPlateCallVariable /[a-zA-Z_0-9.]\+/ contained
hi def link TenPlateCallVariable TenPlateVariable

syn keyword TenPlateCall call contained
hi def link TenPlateCall TenPlateKeyword

syn region TenPlateCallTag start=/{%\s*call\s*/ end=/\s*\/%}/
			\ contains=TenPlateTagStart,TenPlateSelfCloseTagEnd,
				\ TenPlateCall,TenPlateCallPath,TenPlateCallVariable
			\ keepend

syntax cluster TenPlateTopLevel add=TenPlateCallTag

" comment tag
" ex: {# this is a comment #}

syn region TenPlateCommentTag start=/{#/ skip=/\\#}/ end=/#}/ keepend
hi def link TenPlateCommentTag Comment

syntax cluster TenPlateTopLevel add=TenPlateCommentTag

" Compile tag
" ex: {% compile "./include-template.tenplate" /%}

syn region TenPlateCompilePath start=/\s*"/ skip=/\\"/ end=/"\s*/ oneline keepend
			\ contained
			\ contains=TenPlatePathEscapeQuote
hi def link TenPlateCompilePath TenPlateString

syn match TenPlateCompileVariable /[a-zA-Z_0-9.]\+/ contained
hi def link TenPlateCompileVariable TenPlateVariable

syn keyword TenPlateCompile compile contained
hi def link TenPlateCompile TenPlateKeyword

syn region TenPlateCompileTag start=/{%\s*compile\s*/ end=/\s*\/%}/
			\ contains=TenPlateTagStart,TenPlateSelfCloseTagEnd,
				\ TenPlateCompile,TenPlateCompilePath,TenPlateCompileVariable
			\ keepend

syntax cluster TenPlateTopLevel add=TenPlateCompileTag

" Div tag
" ex: {% sub id %}0{% /sub %}

syn match TenPlateDivVariable /\s*[a-zA-Z]\%([a-zA-Z0-9_\-]\)*\s*/ contained
			\ nextgroup=TenPlateDivEquals
hi def link TenPlateDivVariable TenPlateVariable

syn keyword TenPlateDiv div contained
hi def link TenPlateDiv TenPlateKeyword

syn region TenPlateDivTag start=/{%\s*div\s*/ end=/\s*%}/
			\ contains=TenPlateTagStart,TenPlateBlockTagEnd,TenPlateDiv,TenPlateDivVariable
			\ keepend

syn match TenPlateDivEndTag /{%\s*\/div\s*%}/
			\ contains=TenPlateDiv,TenPlateEndTagSlash
hi def link TenPlateDivEndTag TenPlateTag

syntax cluster TenPlateTopLevel add=TenPlateDivTag,TenPlateDivEndTag

" Exec tag
" ex: {% exec `insert into db.tbl ( id, name ) values ( 1, 'Somebody' );` /%}
" ex: {% exec "./do-insert.sql" /%}

syn match TenPlateExecArgEnd /)/ contained
hi def link TenPlateExecArgEnd TenPlateSymbol

syn match TenPlateExecComma /\s*,\s*/ contained
			\ nextgroup=TenPlateExecArg,TenPlateExecLiteral
hi def link TenPlateExecComma TenPlateSymbol

syn region TenPlateExecLiteral start=/\s*"/ skip=/\\"/ end=/"\s*/ oneline keepend
			\ contained
			\ contains=TenPlatePathEscapeQuote
			\ nextgroup=TenPlateExecComma,TenPlateExecArgEnd
hi def link TenPlateExecLiteral TenPlateString

syn match TenPlateExecArg /\s*[a-zA-Z_0-9.]\+\s*/ contained
			\ nextgroup=TenPlateExecComma,TenPlateExecArgEnd
hi def link TenPlateExecArg TenPlateVariable

syn match TenPlateExecArgStart /(/ contained
			\ nextgroup=TenPlateExecArg,TenPlateExecLiteral,TenPlateExecArgEnd
hi def link TenPlateExecArgStart TenPlateSymbol

syn match TenPlateExecFnName /[a-zA-Z_0-9.]\+/ contained nextgroup=TenPlateExecArgStart
hi def link TenPlateExecFnName TenPlateVariable

syn keyword TenPlateExec exec contained
hi def link TenPlateExec TenPlateKeyword

syn region TenPlateExecTag start=/{%\s*exec\s*/ end=/\s*\/%}/
			\ contains=TenPlateTagStart,TenPlateSelfCloseTagEnd,
				\ TenPlateExec,TenPlateExecFnName
			\ keepend

syntax cluster TenPlateTopLevel add=TenPlateExecTag

" Extend tag
" ex: {% extend "./template.tenplate" /%}

syn region TenPlateExtendPath start=/"/ skip=/\\"/ end=/"/ oneline keepend
			\ contained
			\ contains=TenPlatePathEscapeQuote
hi def link TenPlateExtendPath TenPlateString

syn match TenPlateExtendVariable /[a-zA-Z_0-9.]\+/ contained
hi def link TenPlateExtendVariable TenPlateVariable

syn keyword TenPlateExtend extend contained
hi def link TenPlateExtend TenPlateKeyword

syn region TenPlateExtendTag start=/{%\s*extend\s*/ end=/\s*\/%}/
			\ contains=TenPlateTagStart,TenPlateSelfCloseTagEnd,
				\ TenPlateExtend,TenPlateExtendPath,TenPlateExtendVariable
			\ keepend

syntax cluster TenPlateTopLevel add=TenPlateExtendTag

" Mod tag
" ex: {% sub id %}0{% /sub %}

syn match TenPlateModVariable /\s*[a-zA-Z]\%([a-zA-Z0-9_\-]\)*\s*/ contained
			\ nextgroup=TenPlateModEquals
hi def link TenPlateModVariable TenPlateVariable

syn keyword TenPlateMod mod contained
hi def link TenPlateMod TenPlateKeyword

syn region TenPlateModTag start=/{%\s*mod\s*/ end=/\s*%}/
			\ contains=TenPlateTagStart,TenPlateBlockTagEnd,TenPlateMod,TenPlateModVariable
			\ keepend

syn match TenPlateModEndTag /{%\s*\/mod\s*%}/
			\ contains=TenPlateMod,TenPlateEndTagSlash
hi def link TenPlateModEndTag TenPlateTag

syntax cluster TenPlateTopLevel add=TenPlateModTag,TenPlateModEndTag

" Nth tag
" ex: {% sub id %}0{% /sub %}

syn match TenPlateNthVariable /\s*[a-zA-Z]\%([a-zA-Z0-9_\-]\)*\s*/ contained
			\ nextgroup=TenPlateNthEquals
hi def link TenPlateNthVariable TenPlateVariable

syn keyword TenPlateNth nth contained
hi def link TenPlateNth TenPlateKeyword

syn region TenPlateNthTag start=/{%\s*nth\s*/ end=/\s*%}/
			\ contains=TenPlateTagStart,TenPlateBlockTagEnd,TenPlateNth,TenPlateNthVariable
			\ keepend

syn match TenPlateNthEndTag /{%\s*\/nth\s*%}/
			\ contains=TenPlateNth,TenPlateEndTagSlash
hi def link TenPlateNthEndTag TenPlateTag

syntax cluster TenPlateTopLevel add=TenPlateNthTag,TenPlateNthEndTag

" Path tag
" ex: {% path "./file.tenplate" in directory /%}

syn region TenPlatePathDirectoryLiteral start=/\s*"/ skip=/\\"/ end=/"\s*/ oneline keepend
			\ contained
			\ contains=TenPlatePathEscapeQuote
hi def link TenPlatePathDirectoryLiteral TenPlateString

syn match TenPlatePathDirectoryVariable /\s*[a-zA-Z_0-9.]\+\s*/ contained
hi def link TenPlatePathDirectoryVariable TenPlateVariable


syn keyword TenPlatePathIn in contained
			\ nextgroup=TenPlatePathDirectoryVariable,TenPlatePathDirectoryLiteral
hi def link TenPlatePathIn TenPlateKeyword

syn region TenPlatePathLiteral start=/\s*"/ skip=/\\"/ end=/"\s*/ oneline keepend
			\ contained
			\ contains=TenPlatePathEscapeQuote
			\ nextgroup=TenPlatePathIn
hi def link TenPlatePathLiteral TenPlateString

syn match TenPlatePathVariable /\s*[a-zA-Z_0-9.]\+\s*/ contained nextgroup=TenPlatePathIn
hi def link TenPlatePathVariable TenPlateVariable

syn keyword TenPlatePath path contained nextgroup=TenPlatePathVariable,TenPlatePathLiteral
hi def link TenPlatePath TenPlateKeyword

syn region TenPlatePathTag start=/{%\s*path\s*/ end=/\s*\/%}/
			\ contains=TenPlateTagStart,TenPlateSelfCloseTagEnd,TenPlatePath
			\ keepend

syntax cluster TenPlateTopLevel add=TenPlatePathTag

" Pow tag
" ex: {% sub id %}0{% /sub %}

syn match TenPlatePowVariable /\s*[a-zA-Z]\%([a-zA-Z0-9_\-]\)*\s*/ contained
			\ nextgroup=TenPlatePowEquals
hi def link TenPlatePowVariable TenPlateVariable

syn keyword TenPlatePow pow contained
hi def link TenPlatePow TenPlateKeyword

syn region TenPlatePowTag start=/{%\s*pow\s*/ end=/\s*%}/
			\ contains=TenPlateTagStart,TenPlateBlockTagEnd,TenPlatePow,TenPlatePowVariable
			\ keepend

syn match TenPlatePowEndTag /{%\s*\/pow\s*%}/
			\ contains=TenPlatePow,TenPlateEndTagSlash
hi def link TenPlatePowEndTag TenPlateTag

syntax cluster TenPlateTopLevel add=TenPlatePowTag,TenPlatePowEndTag

" Fordir tag
" ex: {% fordir d in "./people" as d_loop %}{% include "./name.txt" /%}{% else %}Nobody{% /fordir %}

syn match TenPlateFordirAsVariable /\s*[a-zA-Z0-9_\-.]\+\s*/ contained
hi def link TenPlateFordirAsVariable TenPlateVariable

syn keyword TenPlateFordirAs as contained nextgrouyp=TenPlateFordirAsVariable
hi def link TenPlateFordirAs TenPlateKeyword

syn match TenPlateFordirInVariable /\s*[a-zA-Z0-9_\-.]\+\s*/ contained
			\ nextgroup=TenPlateFordirAs
hi def link TenPlateFordirInVariable TenPlateVariable

syn region TenPlateFordirInPath start=/\s*"/ skip=/\\"/ end=/"\s*/ oneline keepend
			\ contained
			\ contains=TenPlatePathEscapeQuote
			\ nextgroup=TenPlateFordirAs
hi def link TenPlateFordirInPath TenPlateString

syn keyword TenPlateFordirIn in contained nextgroup=TenPlateFordirInPath,TenPlateFordirInVariable
hi def link TenPlateFordirIn TenPlateKeyword

syn match TenPlateFordirVariable /\s*[a-zA-Z0-9_\-.]\+\s*/ contained
			\ nextgroup=TenPlateFordirIn
hi def link TenPlateFordirVariable TenPlateVariable

syn keyword TenPlateFordir fordir contained
hi def link TenPlateFordir TenPlateKeyword

syn region TenPlateFordirTag start=/{%\s*fordir\s*/ end=/\s*%}/
			\ contains=TenPlateTagStart,TenPlateBlockTagEnd,
				\ TenPlateFordir,TenPlateFordirVariable
			\ keepend

syn match TenPlateFordirEndTag /{%\s*\/fordir\s*%}/
			\ contains=TenPlateFordir,TenPlateEndTagSlash
hi def link TenPlateFordirEndTag TenPlateTag

syntax cluster TenPlateTopLevel add=TenPlateFordirTag,TenPlateFordirEndTag

" Foreach tag
" ex: {% foreach d in "./people" as d_loop %}{% include "./name.txt" /%}{% else %}Nobody{% /foreach %}

syn match TenPlateForeachAsVariable /\s*[a-zA-Z0-9_\-.]\+\s*/ contained
hi def link TenPlateForeachAsVariable TenPlateVariable

syn keyword TenPlateForeachAs as contained nextgrouyp=TenPlateForeachAsVariable
hi def link TenPlateForeachAs TenPlateKeyword

syn match TenPlateForeachInVariable /\s*[a-zA-Z0-9_\-.]\+\s*/ contained
			\ nextgroup=TenPlateForeachAs
hi def link TenPlateForeachInVariable TenPlateVariable

syn keyword TenPlateForeachIn in contained nextgroup=TenPlateForeachInVariable
hi def link TenPlateForeachIn TenPlateKeyword

syn match TenPlateForeachVariable /\s*[a-zA-Z0-9_\-.]\+\s*/ contained
			\ nextgroup=TenPlateForeachIn
hi def link TenPlateForeachVariable TenPlateVariable

syn keyword TenPlateForeach foreach contained
hi def link TenPlateForeach TenPlateKeyword

syn region TenPlateForeachTag start=/{%\s*foreach\s*/ end=/\s*%}/
			\ contains=TenPlateTagStart,TenPlateBlockTagEnd,
				\ TenPlateForeach,TenPlateForeachVariable
			\ keepend

syn match TenPlateForeachEndTag /{%\s*\/foreach\s*%}/
			\ contains=TenPlateForeach,TenPlateEndTagSlash
hi def link TenPlateForeachEndTag TenPlateTag

syntax cluster TenPlateTopLevel add=TenPlateForeachTag,TenPlateForeachEndTag

" Forfile tag
" ex: {% forfile f in "./people" as f_loop %}{% include "./name.txt" /%}{% else %}Nobody{% /forfile %}

syn match TenPlateForfileAsVariable /\s*[a-zA-Z0-9_\-.]\+\s*/ contained
hi def link TenPlateForfileAsVariable TenPlateVariable

syn keyword TenPlateForfileAs as contained nextgrouyp=TenPlateForfileAsVariable
hi def link TenPlateForfileAs TenPlateKeyword

syn match TenPlateForfileInVariable /\s*[a-zA-Z0-9_\-.]\+\s*/ contained
			\ nextgroup=TenPlateForfileAs
hi def link TenPlateForfileInVariable TenPlateVariable

syn region TenPlateForfileInPath start=/\s*"/ skip=/\\"/ end=/"\s*/ oneline keepend
			\ contained
			\ contains=TenPlatePathEscapeQuote
			\ nextgroup=TenPlateForfileAs
hi def link TenPlateForfileInPath TenPlateString

syn keyword TenPlateForfileIn in contained nextgroup=TenPlateForfileInPath,TenPlateForfileInVariable
hi def link TenPlateForfileIn TenPlateKeyword

syn match TenPlateForfileVariable /\s*[a-zA-Z0-9_\-.]\+\s*/ contained
			\ nextgroup=TenPlateForfileIn
hi def link TenPlateForfileVariable TenPlateVariable

syn keyword TenPlateForfile forfile contained
hi def link TenPlateForfile TenPlateKeyword

syn region TenPlateForfileTag start=/{%\s*forfile\s*/ end=/\s*%}/
			\ contains=TenPlateTagStart,TenPlateBlockTagEnd,
				\ TenPlateForfile,TenPlateForfileVariable
			\ keepend

syn match TenPlateForfileEndTag /{%\s*\/forfile\s*%}/
			\ contains=TenPlateForfile,TenPlateEndTagSlash
hi def link TenPlateForfileEndTag TenPlateTag

syntax cluster TenPlateTopLevel add=TenPlateForfileTag,TenPlateForfileEndTag

" Else tag
" ex: {% else %}

syn keyword TenPlateElse else contained
hi def link TenPlateElse TenPlateKeyword

syn region TenPlateElseTag start=/{%\s*else\s*/ end=/\s*%}/
			\ contains=TenPlateTagStart,TenPlateBlockTagEnd,
				\ TenPlateElse
			\ keepend

syntax cluster TenPlateTopLevel add=TenPlateElseTag

" Fn tag
" ex: {% fn a_function(one, two, three) %}{{ one }}, {{ two }}, {{ three }}{% /fn %}

syn match TenPlateFnArgEnd /)/ contained
hi def link TenPlateFnArgEnd TenPlateSymbol

syn match TenPlateFnComma /\s*,\s*/ contained
			\ nextgroup=TenPlateFnArg
hi def link TenPlateFnComma TenPlateSymbol

syn match TenPlateFnArg /\s*[a-zA-Z_0-9.]\+\s*/ contained
			\ nextgroup=TenPlateFnComma,TenPlateFnArgEnd
hi def link TenPlateFnArg TenPlateVariable

syn match TenPlateFnArgStart /(/ contained
			\ nextgroup=TenPlateFnArg,TenPlateFnArgEnd
hi def link TenPlateFnArgStart TenPlateSymbol

syn match TenPlateFnFnName /[a-zA-Z_0-9.]\+/ contained nextgroup=TenPlateFnArgStart
hi def link TenPlateFnFnName TenPlateVariable

syn keyword TenPlateFn fn contained
hi def link TenPlateFn TenPlateKeyword

syn region TenPlateFnTag start=/{%\s*fn\s*/ end=/\s*%}/
			\ contains=TenPlateTagStart,TenPlateBlockTagEnd,
				\ TenPlateFn,TenPlateFnFnName
			\ keepend

syn match TenPlateFnEndTag /{%\s*\/fn\s*%}/
			\ contains=TenPlateFn,TenPlateEndTagSlash
hi def link TenPlateFnEndTag TenPlateTag

syntax cluster TenPlateTopLevel add=TenPlateFnTag,TenPlateFnEndTag

" Get

syn match TenPlateGetContent /CONTENT/ contained
hi def link TenPlateGetContent TenPlateKeyword

syn match TenPlateGetVariable /[a-zA-Z_0-9.]\+/ contained contains=TenPlateGetContent
hi def link TenPlateGetVariable TenPlateVariable

syn region TenPlateGetTag start=/{{/ skip=/\\}}/ end=/}}/
			\ contains=TenPlateGetVariable
hi def link TenPlateGetTag TenPlateSymbol

syntax cluster TenPlateTopLevel add=TenPlateGetTag

" If tag
" ex: {% if :id == 0 || :name == "Somebody" %}True{% else %}False{% /if %}

syn match TenPlateIfAnd /&&/ contained
hi def link TenPlateIfAnd TenPlateSymbol

syn match TenPlateIfOr /||/ contained
hi def link TenPlateIfOr TenPlateSymbol

syn match TenPlateIfEq /==/ contained
hi def link TenPlateIfEq TenPlateSymbol

syn match TenPlateIfNe /!=/ contained
hi def link TenPlateIfNe TenPlateSymbol

syn match TenPlateIfGt />/ contained
hi def link TenPlateIfGt TenPlateSymbol

syn match TenPlateIfGe />=/ contained
hi def link TenPlateIfGe TenPlateSymbol

syn match TenPlateIfLt /</ contained
hi def link TenPlateIfLt TenPlateSymbol

syn match TenPlateIfLe /<=/ contained
hi def link TenPlateIfLe TenPlateSymbol

syn match TenPlateIfNestStart /(/ contained
hi def link TenPlateIfNestStart TenPlateSymbol

syn match TenPlateIfNestEnd /)/ contained
hi def link TenPlateIfNestEnd TenPlateSymbol

syn region TenPlateIfText start=/"/ skip=/\\"/ end=/"/ contained
			\ contains=TenPlatePathEscapeQuote
hi def link TenPlateIfText TenPlateString

syn match TenPlateIfVariable /\s*[a-zA-Z_0-9.]\+\s*/ contained
hi def link TenPlateIfVariable TenPlateVariable

syn keyword TenPlateIf if contained
hi def link TenPlateIf TenPlateKeyword

syn region TenPlateIfTag start=/{%\s*if\s*/ end=/\s*%}/
			\ contains=TenPlateTagStart,TenPlateBlockTagEnd,
				\ TenPlateIf,TenPlateIfNestStart,TenPlateIfNestEnd,
				\ TenPlateIfVariable,TenPlateIfText,TenPlateIfInteger,
				\ TenPlateIfReal,TenPlateIfAnd,TenPlateIfOr,TenPlateIfEq,
				\ TenPlateIfNe,TenPlateIfGt,TenPlateIfGe,TenPlateIfLt,
				\ TenPlateIfLe
			\ keepend

syn match TenPlateIfEndTag /{%\s*\/if\s*%}/
			\ contains=TenPlateIf,TenPlateEndTagSlash
hi def link TenPlateIfEndTag TenPlateTag

syntax cluster TenPlateTopLevel add=TenPlateIfTag,TenPlateIfEndTag

" Include tag
" ex: {% include "./file.tenplate" /%}

syn region TenPlateIncludePath start=/"/ skip=/\\"/ end=/"/ oneline keepend
			\ contained
			\ contains=TenPlatePathEscapeQuote
hi def link TenPlateIncludePath TenPlateString

syn match TenPlateIncludeVariable /[a-zA-Z_0-9.]\+/ contained
hi def link TenPlateIncludeVariable TenPlateVariable

syn keyword TenPlateInclude include contained
hi def link TenPlateInclude TenPlateKeyword

syn region TenPlateIncludeTag start=/{%\s*include\s*/ end=/\s*\/%}/
			\ contains=TenPlateTagStart,TenPlateSelfCloseTagEnd,
				\ TenPlateInclude,TenPlateIncludePath,TenPlateIncludeVariable
			\ keepend

syntax cluster TenPlateTopLevel add=TenPlateIncludeTag

" Mul tag
" ex: {% sub id %}0{% /sub %}

syn match TenPlateMulVariable /\s*[a-zA-Z]\%([a-zA-Z0-9_\-]\)*\s*/ contained
			\ nextgroup=TenPlateMulEquals
hi def link TenPlateMulVariable TenPlateVariable

syn keyword TenPlateMul mul contained
hi def link TenPlateMul TenPlateKeyword

syn region TenPlateMulTag start=/{%\s*mul\s*/ end=/\s*%}/
			\ contains=TenPlateTagStart,TenPlateBlockTagEnd,TenPlateMul,TenPlateMulVariable
			\ keepend

syn match TenPlateMulEndTag /{%\s*\/mul\s*%}/
			\ contains=TenPlateMul,TenPlateEndTagSlash
hi def link TenPlateMulEndTag TenPlateTag

syntax cluster TenPlateTopLevel add=TenPlateMulTag,TenPlateMulEndTag

" Set tag
" ex: {% set id %}0{% /set %}

syn match TenPlateSetVariable /\s*[a-zA-Z]\%([a-zA-Z0-9_\-]\)*\s*/ contained
			\ nextgroup=TenPlateSetEquals
hi def link TenPlateSetVariable TenPlateVariable

syn keyword TenPlateSet set contained
hi def link TenPlateSet TenPlateKeyword

syn region TenPlateSetTag start=/{%\s*set\s*/ end=/\s*%}/
			\ contains=TenPlateTagStart,TenPlateBlockTagEnd,TenPlateSet,TenPlateSetVariable
			\ keepend

syn match TenPlateSetEndTag /{%\s*\/set\s*%}/
			\ contains=TenPlateSet,TenPlateEndTagSlash
hi def link TenPlateSetEndTag TenPlateTag

syntax cluster TenPlateTopLevel add=TenPlateSetTag,TenPlateSetEndTag

" Sub tag
" ex: {% sub id %}0{% /sub %}

syn match TenPlateSubVariable /\s*[a-zA-Z]\%([a-zA-Z0-9_\-]\)*\s*/ contained
			\ nextgroup=TenPlateSubEquals
hi def link TenPlateSubVariable TenPlateVariable

syn keyword TenPlateSub sub contained
hi def link TenPlateSub TenPlateKeyword

syn region TenPlateSubTag start=/{%\s*sub\s*/ end=/\s*%}/
			\ contains=TenPlateTagStart,TenPlateBlockTagEnd,TenPlateSub,TenPlateSubVariable
			\ keepend

syn match TenPlateSubEndTag /{%\s*\/sub\s*%}/
			\ contains=TenPlateSub,TenPlateEndTagSlash
hi def link TenPlateSubEndTag TenPlateTag

syntax cluster TenPlateTopLevel add=TenPlateSubTag,TenPlateSubEndTag

" Handle supplemental file types

function GetSupplementalFiletype(file)
	let full_extension = matchstr(a:file, '\..\+\.tenplate$')
	if full_extension == ''
		return ''
	endif

	return matchstr(full_extension, '\(\.\)\@<=.\+\(\.tenplate\)\@=')
endfunction

let filename = expand('%:t')

let supp_filetype = GetSupplementalFiletype(filename)
if supp_filetype != ''
	let main_syntax = 'tenplate'

	if supp_filetype == 'html'
		let html_no_rendering = 1
		let html_my_rendering = 1

		syn cluster htmlPreproc contains=@TenPlateTopLevel
	endif

	exec 'runtime! syntax/' . supp_filetype . '.vim'
	exec 'syntax include @Supplemental syntax/' . supp_filetype . '.vim'

	if exists("b:current_syntax")
		unlet b:current_syntax
	endif

	if main_syntax == 'tenplate'
		unlet main_syntax
	endif

	if supp_filetype == 'html'
		unlet html_no_rendering
		unlet html_my_rendering
	endif
endif

" Set current syntax

let b:current_syntax = "tenplate"
