" nilsvimfzf - fzf commands
" Maintainer:  nilsvim
" Version:     0.1.0
" License:     MIT

if exists("g:loaded_nilsvimfzf") || &compatible
    finish
endif
let g:loaded_nilsvimfzf = 1

let s:save_cpo = &cpo
set cpo&vim

let g:fzf_layout = { 'down': 16 }

command! MRU
            \ call fzf#run(extend({
            \ 'source': nilsvimfzf#get_mru(),
            \ 'options': '--prompt "MRU > " ',
            \ }, g:fzf_layout))

let &cpo = s:save_cpo
