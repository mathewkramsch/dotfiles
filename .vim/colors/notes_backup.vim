" notes.vim - matches gruvbox color scheme
" syntax highlighting for school notes/ todo lists

let g:colors_name='notes'

if !(has('termguicolors') && &termguicolors) && !has('gui_running') && &t_Co != 256
  finish
endif

hi Normal guifg=#a89984
hi FoldColumn guibg=NONE ctermbg=NONE
hi Visual guibg=#000000 guifg=#b8bb26
hi CursorLine guibg=#111111 guifg=NONE

" for marking tasks (for todo lists)
syn match noteDash '^- ' nextgroup=note skipwhite
syn match noteListStar '^* '
syn match noteListClosed '^x ' nextgroup=done skipwhite

syn match note '.*$' contained
syn match done '.*$' contained
hi note	guifg=#a89984
hi done	cterm=italic guifg=#665c54

hi noteDash	guifg=#665c54
hi noteListStar	guifg=#fabd2f
hi noteListClosed guifg=#fb4934

" for titles/ headers
syn match noteHeader '# ' nextgroup=header skipwhite
syn match header '.*$' contained
hi noteHeader guifg=#000000
hi header cterm=bold guifg=#b16286

syn match noteTitle '## ' nextgroup=title skipwhite
syn match title '.*$' contained
hi noteTitle guifg=#000000
hi title cterm=bold guifg=#8ec07c

" for key words
syn match keywordstart '<' nextgroup=keyword skipwhite
syn match keyword '.*:' contained
"hi keyword guifg=#fadb2f guibg=#000000
hi keyword guibg=#6f6117 guifg=#000000 cterm=bold
hi keywordstart guifg=#000000

" for comments
syn match comment '//.*$'
hi comment cterm=italic guifg=#665c54
