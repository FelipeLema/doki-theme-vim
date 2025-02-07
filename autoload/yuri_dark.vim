

let s:colors = {
      \ "comments": { "gui": "#8B79B4", "cterm": "103", "cterm16": "1" },
      \ "constantColor": { "gui": "#86dbfd", "cterm": "117", "cterm16": "1" },
      \ "foregroundColorEditor": { "gui": "#F8F8F2", "cterm": "255", "cterm16": "1" },
      \ "htmlTagColor": { "gui": "#bca3aa", "cterm": "248", "cterm16": "1" },
      \ "editorAccentColor": { "gui": "#BC60CB", "cterm": "134", "cterm16": "1" },
      \ "classNameColor": { "gui": "#FF9CD6", "cterm": "218", "cterm16": "1" },
      \ "keywordColor": { "gui": "#bca3aa", "cterm": "248", "cterm16": "1" },
      \ "keyColor": { "gui": "#7C75EF", "cterm": "105", "cterm16": "1" },
      \ "errorColor": { "gui": "#ff5555", "cterm": "203", "cterm16": "1" },
      \ "headerColor": { "gui": "#442e5c", "cterm": "238", "cterm16": "1" },
      \ "accentColor": { "gui": "#AB47BC", "cterm": "133", "cterm16": "1" },
      \ "infoForeground": { "gui": "#9d52ab", "cterm": "133", "cterm16": "1" },
      \ "unusedColor": { "gui": "#72737A", "cterm": "243", "cterm16": "1" },
      \ "diffModified": { "gui": "#203952", "cterm": "237", "cterm16": "1" },
      \ "diffInserted": { "gui": "#204b21", "cterm": "235", "cterm16": "1" },
      \ "diffDeleted": { "gui": "#453C4A", "cterm": "238", "cterm16": "1" },
      \ "codeBlock": { "gui": "#3e2955", "cterm": "237", "cterm16": "1" },
      \ "caretRow": { "gui": "#473466", "cterm": "238", "cterm16": "1" },
      \ "textEditorBackground": { "gui": "#422D5A", "cterm": "238", "cterm16": "1" },
      \ "terminalAnsiRed": { "gui": "#E356A7", "cterm": "169", "cterm16": "1" },
      \ "terminalAnsiBlue": { "gui": "#9B6BDF", "cterm": "98", "cterm16": "1" },
      \ "terminalAnsiCyan": { "gui": "#75D7EC", "cterm": "117", "cterm16": "1" },
      \ "terminalAnsiGreen": { "gui": "#42E66C", "cterm": "77", "cterm16": "1" },
      \ "terminalAnsiMagenta": { "gui": "#E64747", "cterm": "167", "cterm16": "1" },
      \ "terminalAnsiYellow": { "gui": "#EFA554", "cterm": "215", "cterm16": "1" },
      \ "lineNumberColor": { "gui": "#6f6679", "cterm": "242", "cterm16": "1" },
      \ "lightEditorColor": { "gui": "#453161", "cterm": "238", "cterm16": "1" },
      \ "searchForeground": { "gui": "#e7e5f3", "cterm": "254", "cterm16": "1" },
      \ "searchBackground": { "gui": "#7749b2", "cterm": "97", "cterm16": "1" },
      \ "selectionForeground": { "gui": "#B39EFF", "cterm": "147", "cterm16": "1" },
      \ "selectionBackground": { "gui": "#4c2a70", "cterm": "239", "cterm16": "1" },
      \ "foldedTextBackground": { "gui": "#3C1D55", "cterm": "237", "cterm16": "1" },
      \ "stringColor": { "gui": "#f1fa8c", "cterm": "228", "cterm16": "1" }
      \}

function! yuri_dark#GetColors()
  return s:colors
endfunction