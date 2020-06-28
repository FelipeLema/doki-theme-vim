" Palette: 

let g:satsuki#palette           = {}
let g:satsuki#palette.fg        = ['#252427', 235]

let g:satsuki#palette.bglighter = ['#eae9ee', 255]
let g:satsuki#palette.bglight   = ['#eae9ee', 255]
let g:satsuki#palette.bg        = ['#eae9ee', 255]
let g:satsuki#palette.bgdark    = ['#eae9ee', 255]
let g:satsuki#palette.bgdarker  = ['#eae9ee', 255]

let g:satsuki#palette.comment   = ['#6a737d',  243]
let g:satsuki#palette.selection = ['#a0a9d2', 146]
let g:satsuki#palette.subtle    = ['#e0dfe6', 254]

let g:satsuki#palette.key_color      = ['#cd862f', 172]
let g:satsuki#palette.class_name     = ['#757881', 243]
let g:satsuki#palette.parameter_color    = ['#275AB3', 25]
let g:satsuki#palette.keyword_color      = ['#275AB3', 25]
let g:satsuki#palette.constants_color    = ['#4C94D6', 68]
let g:satsuki#palette.red       = ['#FF5555', 203]
let g:satsuki#palette.string_color    = ['#b8397e', 132]

"
" Terminal Colors
"
let g:satsuki#palette.color_0  = '#21222C'
let g:satsuki#palette.color_1  = '#FF5555'
let g:satsuki#palette.color_2  = '#50FA7B'
let g:satsuki#palette.color_3  = '#F1FA8C'
let g:satsuki#palette.color_4  = '#BD93F9'
let g:satsuki#palette.color_5  = '#FF79C6'
let g:satsuki#palette.color_6  = '#8BE9FD'
let g:satsuki#palette.color_7  = '#F8F8F2'
let g:satsuki#palette.color_8  = '#6272A4'
let g:satsuki#palette.color_9  = '#FF6E6E'
let g:satsuki#palette.color_10 = '#69FF94'
let g:satsuki#palette.color_11 = '#FFFFA5'
let g:satsuki#palette.color_12 = '#D6ACFF'
let g:satsuki#palette.color_13 = '#FF92DF'
let g:satsuki#palette.color_14 = '#A4FFFF'
let g:satsuki#palette.color_15 = '#FFFFFF'

" }}}

" Helper function that takes a variadic list of filetypes as args and returns
" whether or not the execution of the ftplugin should be aborted.
func! satsuki#should_abort(...)
    if ! exists('g:colors_name') || g:colors_name !=# 'satsuki'
        return 1
    elseif a:0 > 0 && (! exists('b:current_syntax') || index(a:000, b:current_syntax) == -1)
        return 1
    endif
    return 0
endfunction

" vim: fdm=marker ts=2 sts=2 sw=2 fdl=0:
