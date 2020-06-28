" Palette: 

let g:ram#palette           = {}
let g:ram#palette.fg        = ['#bbbbbb', 250]

let g:ram#palette.bglighter = ['#302930', 236]
let g:ram#palette.bglight   = ['#302930', 236]
let g:ram#palette.bg        = ['#302930', 236]
let g:ram#palette.bgdark    = ['#302930', 236]
let g:ram#palette.bgdarker  = ['#302930', 236]

let g:ram#palette.comment   = ['#6272a4',  61]
let g:ram#palette.selection = ['#7a546f', 95]
let g:ram#palette.subtle    = ['#353139', 236]

let g:ram#palette.key_color      = ['#F375C8', 212]
let g:ram#palette.class_name     = ['#EF9FD8', 218]
let g:ram#palette.parameter_color    = ['#FFB86C', 215]
let g:ram#palette.keyword_color      = ['#988F9A', 246]
let g:ram#palette.constants_color    = ['#BD93F9', 141]
let g:ram#palette.red       = ['#FF5555', 203]
let g:ram#palette.string_color    = ['#f4fa8c', 228]

"
" Terminal Colors
"
let g:ram#palette.color_0  = '#21222C'
let g:ram#palette.color_1  = '#FF5555'
let g:ram#palette.color_2  = '#50FA7B'
let g:ram#palette.color_3  = '#F1FA8C'
let g:ram#palette.color_4  = '#BD93F9'
let g:ram#palette.color_5  = '#FF79C6'
let g:ram#palette.color_6  = '#8BE9FD'
let g:ram#palette.color_7  = '#F8F8F2'
let g:ram#palette.color_8  = '#6272A4'
let g:ram#palette.color_9  = '#FF6E6E'
let g:ram#palette.color_10 = '#69FF94'
let g:ram#palette.color_11 = '#FFFFA5'
let g:ram#palette.color_12 = '#D6ACFF'
let g:ram#palette.color_13 = '#FF92DF'
let g:ram#palette.color_14 = '#A4FFFF'
let g:ram#palette.color_15 = '#FFFFFF'

" }}}

" Helper function that takes a variadic list of filetypes as args and returns
" whether or not the execution of the ftplugin should be aborted.
func! ram#should_abort(...)
    if ! exists('g:colors_name') || g:colors_name !=# 'ram'
        return 1
    elseif a:0 > 0 && (! exists('b:current_syntax') || index(a:000, b:current_syntax) == -1)
        return 1
    endif
    return 0
endfunction

" vim: fdm=marker ts=2 sts=2 sw=2 fdl=0:
