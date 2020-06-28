" Palette: 

let g:sayori_light#palette           = {}
let g:sayori_light#palette.fg        = ['#252427', 235]

let g:sayori_light#palette.bglighter = ['#f3faff', 231]
let g:sayori_light#palette.bglight   = ['#f3faff', 231]
let g:sayori_light#palette.bg        = ['#f3faff', 231]
let g:sayori_light#palette.bgdark    = ['#f3faff', 231]
let g:sayori_light#palette.bgdarker  = ['#f3faff', 231]

let g:sayori_light#palette.comment   = ['#6a737d',  243]
let g:sayori_light#palette.selection = ['#a9c8ec', 153]
let g:sayori_light#palette.subtle    = ['#dceef7', 255]

let g:sayori_light#palette.key_color      = ['#3F77EF', 69]
let g:sayori_light#palette.class_name     = ['#FF3889', 204]
let g:sayori_light#palette.parameter_color    = ['#00bcd4', 38]
let g:sayori_light#palette.keyword_color      = ['#9D868D', 138]
let g:sayori_light#palette.constants_color    = ['#4C94D6', 68]
let g:sayori_light#palette.red       = ['#FF5555', 203]
let g:sayori_light#palette.string_color    = ['#DC872E', 172]

"
" Terminal Colors
"
let g:sayori_light#palette.color_0  = '#21222C'
let g:sayori_light#palette.color_1  = '#FF5555'
let g:sayori_light#palette.color_2  = '#50FA7B'
let g:sayori_light#palette.color_3  = '#F1FA8C'
let g:sayori_light#palette.color_4  = '#BD93F9'
let g:sayori_light#palette.color_5  = '#FF79C6'
let g:sayori_light#palette.color_6  = '#8BE9FD'
let g:sayori_light#palette.color_7  = '#F8F8F2'
let g:sayori_light#palette.color_8  = '#6272A4'
let g:sayori_light#palette.color_9  = '#FF6E6E'
let g:sayori_light#palette.color_10 = '#69FF94'
let g:sayori_light#palette.color_11 = '#FFFFA5'
let g:sayori_light#palette.color_12 = '#D6ACFF'
let g:sayori_light#palette.color_13 = '#FF92DF'
let g:sayori_light#palette.color_14 = '#A4FFFF'
let g:sayori_light#palette.color_15 = '#FFFFFF'

" }}}

" Helper function that takes a variadic list of filetypes as args and returns
" whether or not the execution of the ftplugin should be aborted.
func! sayori_light#should_abort(...)
    if ! exists('g:colors_name') || g:colors_name !=# 'sayori_light'
        return 1
    elseif a:0 > 0 && (! exists('b:current_syntax') || index(a:000, b:current_syntax) == -1)
        return 1
    endif
    return 0
endfunction

" vim: fdm=marker ts=2 sts=2 sw=2 fdl=0:
