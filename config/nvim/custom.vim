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
nnoremap g] <cmd>lua require('telescope').extensions.ctags_plus.jump_to_tag()<cr>

" Terminal
command! -nargs=0 TSOpen exec winheight(0)/3."split" | terminal
command! -nargs=* TSCall exec winheight(0)/3."split" | terminal <args>

" Magic trick
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

