scriptencoding utf-8
" EasyMotion - Vim motions on speed!
"
" Author: Kim Silkebækken <kim.silkebaekken+vim@gmail.com>
"         haya14busa <hayabusa1419@gmail.com>
" Source: https://github.com/easymotion/vim-easymotion
" == Script initialization {{{
if expand("%:p") ==# expand("<sfile>:p")
  unlet! g:EasyMotion_loaded
endif
if exists('g:EasyMotion_loaded') || &compatible || version < 703
    finish
endif

let g:EasyMotion_loaded = 1
" }}}

" == Saving 'cpoptions' {{{
let s:save_cpo = &cpo
set cpo&vim
" }}}

" == Default configuration {{{
" -- Option ------------------------------ {{{
let g:EasyMotion_keys               = 'asdghklqwertyuiopzxcvbnmfj'
let g:EasyMotion_do_mapping         = 1
let g:EasyMotion_do_shade           = 1
let g:EasyMotion_grouping           = 1
let g:EasyMotion_startofline        = 1
let g:EasyMotion_smartcase          = 0
let g:EasyMotion_skipfoldedline     = 1
let g:EasyMotion_use_migemo         = 0
let g:EasyMotion_use_upper          = 0
let g:EasyMotion_enter_jump_first   = 0
let g:EasyMotion_space_jump_first   = 0
let g:EasyMotion_inc_highlight      = 1
let g:EasyMotion_move_highlight     = 1
let g:EasyMotion_landing_highlight  = 0
let g:EasyMotion_cursor_highlight   = 1
let g:EasyMotion_use_regexp         = 1
let g:EasyMotion_add_search_history = 1
let g:EasyMotion_off_screen_search  = 1
let g:EasyMotion_force_csapprox     = 0
let g:EasyMotion_show_prompt        = 1
let g:EasyMotion_verbose            = 1
let g:EasyMotion_prompt             = 'Search for {n} character(s): '
let g:EasyMotion_command_line_key_mappings = {}
let g:EasyMotion_disable_two_key_combo     = 0

"}}}

" }}}

" == <Plug> Mapping {{{
" Note: bd is short for bidirectional
"       l is short for (within) line

function! s:motion_map_helper(motions) "{{{
    for [name, dict] in items(a:motions)
        let mapargs = []
        let xmapargs = []
        if dict.fnc ==# 'S' || dict.fnc ==# 'SL' || dict.fnc ==# 'T' || dict.fnc ==# 'TL'
            let mapargs  += [dict.cnt, 0, dict.direction]
            let xmapargs += [dict.cnt, 1, dict.direction]
        elseif dict.fnc ==# 'Search'
            let mapargs  += [0, dict.direction, dict.respect_direction]
            let xmapargs += [1, dict.direction, dict.respect_direction]
        else
            let mapargs  += [0, dict.direction]
            let xmapargs += [1, dict.direction]
        endif

        silent exec 'noremap  <silent><Plug>(easymotion-'.name.')' .
            \ '      :<C-u>call EasyMotion#' . dict.fnc . '('. join(mapargs, ',') . ')<CR>'
        silent exec 'xnoremap <silent><Plug>(easymotion-'.name.')' .
            \ ' <Esc>:<C-u>call EasyMotion#' . dict.fnc . '('. join(xmapargs, ',') . ')<CR>'
    " Example:
    " noremap  <silent><Plug>(easymotion-f2) :<C-u>call EasyMotion#S(2,1,0)<CR>
    " xnoremap <silent><Plug>(easymotion-f2) <Esc>:<C-u>call EasyMotion#S(2,1,0)<CR>
    endfor
endfunction "}}}

" Find Motion: {{{
nnoremap <silent> <Plug>(easymotion-overwin-w) :<C-u>call EasyMotion#overwin#w()<CR>
"}}}

" -- Word Motion {{{
call s:motion_map_helper({
    \ 'bd-W'            : {'fnc' : 'WBW', 'direction' : 2},
    \ })
"}}}

" }}}

" == Restore 'cpoptions' {{{
let &cpo = s:save_cpo
unlet s:save_cpo
" }}}
" vim: fdm=marker:et:ts=4:sw=4:sts=4
