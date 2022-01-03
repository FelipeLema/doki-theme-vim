

let s:colors = {
      \ "comments": { "gui": "#6C888D", "cterm": "66", "cterm16": "1" },
      \ "constantColor": { "gui": "#da8d97", "cterm": "174", "cterm16": "1" },
      \ "foregroundColorEditor": { "gui": "#F8F8F2", "cterm": "255", "cterm16": "1" },
      \ "htmlTagColor": { "gui": "#cda8fa", "cterm": "183", "cterm16": "1" },
      \ "editorAccentColor": { "gui": "#fc9ee6", "cterm": "218", "cterm16": "1" },
      \ "classNameColor": { "gui": "#ba92f3", "cterm": "141", "cterm16": "1" },
      \ "keywordColor": { "gui": "#60ff62", "cterm": "83", "cterm16": "1" },
      \ "keyColor": { "gui": "#3394dd", "cterm": "68", "cterm16": "1" },
      \ "errorColor": { "gui": "#ff5555", "cterm": "203", "cterm16": "1" },
      \ "stringColor": { "gui": "#fffeaf", "cterm": "229", "cterm16": "1" }
      \}

function! nakano_miku#GetColors()
  return s:colors
endfunction