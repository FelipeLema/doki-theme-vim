

let s:colors = {
      \ "comments": { "gui": "#6272a4", "cterm": "61", "cterm16": "1" },
      \ "constantColor": { "gui": "#86dbfd", "cterm": "117", "cterm16": "1" },
      \ "foregroundColorEditor": { "gui": "#F8F8F2", "cterm": "255", "cterm16": "1" },
      \ "htmlTagColor": { "gui": "#a28a92", "cterm": "246", "cterm16": "1" },
      \ "editorAccentColor": { "gui": "#578CDA", "cterm": "68", "cterm16": "1" },
      \ "classNameColor": { "gui": "#8dc6ef", "cterm": "117", "cterm16": "1" },
      \ "keywordColor": { "gui": "#988F9A", "cterm": "246", "cterm16": "1" },
      \ "keyColor": { "gui": "#6893f3", "cterm": "69", "cterm16": "1" },
      \ "stringColor": { "gui": "#f4fa8c", "cterm": "228", "cterm16": "1" }
      \}

function! aqua#GetColors()
  return s:colors
endfunction