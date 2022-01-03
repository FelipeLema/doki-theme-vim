

let s:colors = {
      \ "comments": { "gui": "#2E2E57", "cterm": "236", "cterm16": "1" },
      \ "constantColor": { "gui": "#005CC5", "cterm": "26", "cterm16": "1" },
      \ "foregroundColorEditor": { "gui": "#4D4D4A", "cterm": "239", "cterm16": "1" },
      \ "htmlTagColor": { "gui": "#2811B9", "cterm": "19", "cterm16": "1" },
      \ "editorAccentColor": { "gui": "#C209A9", "cterm": "127", "cterm16": "1" },
      \ "classNameColor": { "gui": "#7748B7", "cterm": "97", "cterm16": "1" },
      \ "keywordColor": { "gui": "#410cb2", "cterm": "55", "cterm16": "1" },
      \ "keyColor": { "gui": "#5E037E", "cterm": "54", "cterm16": "1" },
      \ "errorColor": { "gui": "#FF0707", "cterm": "196", "cterm16": "1" },
      \ "caretRow": { "gui": "#d4d2ff", "cterm": "189", "cterm16": "1" },
      \ "lineNumberColor": { "gui": "#38336b", "cterm": "237", "cterm16": "1" },
      \ "lightEditorColor": { "gui": "#dcdbff", "cterm": "189", "cterm16": "1" },
      \ "searchForeground": { "gui": "#323232", "cterm": "236", "cterm16": "1" },
      \ "searchBackground": { "gui": "#F39AE9", "cterm": "212", "cterm16": "1" },
      \ "selectionForeground": { "gui": "#d3dcfd", "cterm": "189", "cterm16": "1" },
      \ "selectionBackground": { "gui": "#5756a2", "cterm": "61", "cterm16": "1" },
      \ "foldedTextBackground": { "gui": "#ddddff", "cterm": "189", "cterm16": "1" },
      \ "stringColor": { "gui": "#208D3B", "cterm": "29", "cterm16": "1" }
      \}

function! shigure#GetColors()
  return s:colors
endfunction