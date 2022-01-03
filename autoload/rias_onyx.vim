

let s:colors = {
      \ "comments": { "gui": "#694f4d", "cterm": "239", "cterm16": "1" },
      \ "constantColor": { "gui": "#E356A7", "cterm": "169", "cterm16": "1" },
      \ "foregroundColorEditor": { "gui": "#F8F8F2", "cterm": "255", "cterm16": "1" },
      \ "htmlTagColor": { "gui": "#6297a2", "cterm": "67", "cterm16": "1" },
      \ "editorAccentColor": { "gui": "#C04750", "cterm": "131", "cterm16": "1" },
      \ "classNameColor": { "gui": "#5a84dd", "cterm": "68", "cterm16": "1" },
      \ "keywordColor": { "gui": "#27c0b4", "cterm": "37", "cterm16": "1" },
      \ "keyColor": { "gui": "#b2dbe3", "cterm": "152", "cterm16": "1" },
      \ "errorColor": { "gui": "#ff5555", "cterm": "203", "cterm16": "1" },
      \ "headerColor": { "gui": "#100000", "cterm": "16", "cterm16": "1" },
      \ "accentColor": { "gui": "#7C171F", "cterm": "88", "cterm16": "1" },
      \ "caretRow": { "gui": "#1e0607", "cterm": "232", "cterm16": "1" },
      \ "lineNumberColor": { "gui": "#97706f", "cterm": "243", "cterm16": "1" },
      \ "lightEditorColor": { "gui": "#180404", "cterm": "232", "cterm16": "1" },
      \ "searchForeground": { "gui": "#fbfbfb", "cterm": "231", "cterm16": "1" },
      \ "searchBackground": { "gui": "#0F625A", "cterm": "23", "cterm16": "1" },
      \ "selectionForeground": { "gui": "#fbfbfb", "cterm": "231", "cterm16": "1" },
      \ "selectionBackground": { "gui": "#390c10", "cterm": "233", "cterm16": "1" },
      \ "foldedTextBackground": { "gui": "#280a0b", "cterm": "232", "cterm16": "1" },
      \ "stringColor": { "gui": "#F6E3CC", "cterm": "224", "cterm16": "1" }
      \}

function! rias_onyx#GetColors()
  return s:colors
endfunction