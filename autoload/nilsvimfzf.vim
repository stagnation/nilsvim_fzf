function! nilsvimfzf#MRU() abort
endfunction

let s:mru_blacklist = "v:val !~ '" . join([
            \ 'fugitive',
            \ '^/tmp',
            \ '.git/',
            \ '\[.*\]',
            \ 'vim/runtime/doc',
            \ ], '\|') . "'"

function! nilsvimfzf#get_mru() abort
    return get(s:, 'mru_cache', nilsvimfzf#RefreshMru())
endfunction

function! nilsvimfzf#RefreshMru() abort
    let s:mru_cache = nilsvimfzf#filter_paths(filter(copy(v:oldfiles), s:mru_blacklist))
    return s:mru_cache
endfunction

function! nilsvimfzf#filter_paths(pathlist, ...) abort
    let l:pathlist = a:pathlist

    " prepend base path
    if isdirectory(get(a:, 1, ''))
        call map(l:pathlist, "a:1 . '/' . v:val")
    endif

    " filter out non-existing files
    call filter(l:pathlist, 'filereadable(expand(v:val))')

    " shorten
    call map(l:pathlist, "fnamemodify(v:val, ':~:.')")

    return l:pathlist
endfunction

augroup nilsvim_mru
    autocmd! nilsvim_mru BufAdd,BufNew,BufFilePost * call nilsvimfzf#RefreshMru()
augroup END

