

let s:colors = {
      \ "comments": { "gui": "#6272a4", "cterm": "61", "cterm16": "1" },
      \ "constantColor": { "gui": "#86dbfd", "cterm": "117", "cterm16": "1" },
      \ "foregroundColorEditor": { "gui": "#F8F8F2", "cterm": "255", "cterm16": "1" },
      \ "htmlTagColor": { "gui": "#89c0d9", "cterm": "110", "cterm16": "1" },
      \ "editorAccentColor": { "gui": "#ef596f", "cterm": "203", "cterm16": "1" },
      \ "classNameColor": { "gui": "#6AADFF", "cterm": "75", "cterm16": "1" },
      \ "keywordColor": { "gui": "#788a8b", "cterm": "245", "cterm16": "1" },
      \ "keyColor": { "gui": "#45e68a", "cterm": "78", "cterm16": "1" },
      \ "stringColor": { "gui": "#F6E3CC", "cterm": "224", "cterm16": "1" }
      \}

function! rei#GetColors()
  return s:colors
endfunction