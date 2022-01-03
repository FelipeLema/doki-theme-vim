

let s:colors = {
      \ "comments": { "gui": "#806872", "cterm": "243", "cterm16": "1" },
      \ "constantColor": { "gui": "#96b7fb", "cterm": "111", "cterm16": "1" },
      \ "foregroundColorEditor": { "gui": "#F8F8F2", "cterm": "255", "cterm16": "1" },
      \ "htmlTagColor": { "gui": "#ff6b75", "cterm": "204", "cterm16": "1" },
      \ "editorAccentColor": { "gui": "#f689f6", "cterm": "213", "cterm16": "1" },
      \ "classNameColor": { "gui": "#f8835f", "cterm": "209", "cterm16": "1" },
      \ "keywordColor": { "gui": "#FF357C", "cterm": "204", "cterm16": "1" },
      \ "keyColor": { "gui": "#48eae4", "cterm": "80", "cterm16": "1" },
      \ "stringColor": { "gui": "#F6E9CB", "cterm": "224", "cterm16": "1" }
      \}

function! chocola#GetColors()
  return s:colors
endfunction