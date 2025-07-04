" Vim ftdetect file
" Language: TenPlate Templating
" Maintainer: Frankie Baffa
" Version: 0.1.3

" Automatically sets the filetype to tenplate when the file extension is
" detected.
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

augroup tenplate_ft
	au!
	autocmd BufNew,BufNewFile,BufRead *.tenplate setlocal filetype=tenplate
augroup END
