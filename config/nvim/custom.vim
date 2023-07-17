lua require('gnfisher.metals')

" Easier than "+
nmap cp "+y
nmap cv "+p
nmap cV "+P
vmap cp "+y
vmap cv "+p
vmap cV "+P

cnoremap <expr> %% expand('%:h').'/'

nnoremap <C-Space> <Esc>:noh<cr>
" Esc exits imode in terminal
tnoremap <Esc> <C-\><C-n>

" Terminal helpers
map <leader>gg :terminal gitsh<CR>
map <leader>ru :TSCall irb<CR>
map <leader>rf :TSCall irb -r %:p<CR>
map <leader>oo :TSOpen<CR>

" Personal lazy things
nnoremap <leader>; :
map <M-j> :cnext<CR>
map <M-k> :cprev<CR>

" Stuff
nnoremap <leader>fG :call <SID>ToggleGstatus()<CR>
" nnoremap g] <cmd>lua require('telescope').extensions.ctags_plus.jump_to_tag()<cr>

" Terminal
command! -nargs=0 TSOpen exec winheight(0)/3."split" | terminal
command! -nargs=* TSCall exec winheight(0)/3."split" | terminal <args>

" Magic trick
map <F6> :call ToggleBackground()<CR>
function! ToggleBackground()
    if &background == "light"
        set background=dark
    else
        set background=light
    endif
endfunction

function! s:ToggleGstatus() abort
  for l:winnr in range(1, winnr('$'))
    if !empty(getwinvar(l:winnr, 'fugitive_status'))
      execute l:winnr.'close'
    else
      Git
    endif
  endfor
endfunction

" Doom One colorscheme
lua require('gnfisher.doom')

" barbar
" Move to previous/next
nnoremap <silent>    <A-,> <Cmd>BufferPrevious<CR>
nnoremap <silent>    <A-.> <Cmd>BufferNext<CR>

" Re-order to previous/next
nnoremap <silent>    <A-<> <Cmd>BufferMovePrevious<CR>
nnoremap <silent>    <A->> <Cmd>BufferMoveNext<CR>

" Goto buffer in position...
nnoremap <silent>    <A-1> <Cmd>BufferGoto 1<CR>
nnoremap <silent>    <A-2> <Cmd>BufferGoto 2<CR>
nnoremap <silent>    <A-3> <Cmd>BufferGoto 3<CR>
nnoremap <silent>    <A-4> <Cmd>BufferGoto 4<CR>
nnoremap <silent>    <A-5> <Cmd>BufferGoto 5<CR>
nnoremap <silent>    <A-6> <Cmd>BufferGoto 6<CR>
nnoremap <silent>    <A-7> <Cmd>BufferGoto 7<CR>
nnoremap <silent>    <A-8> <Cmd>BufferGoto 8<CR>
nnoremap <silent>    <A-9> <Cmd>BufferGoto 9<CR>
nnoremap <silent>    <A-0> <Cmd>BufferLast<CR>
