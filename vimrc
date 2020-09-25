set encoding=utf-8

" remove all existing autcmd
autocmd! 

" load plugs
if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

filetype plugin indent on

" set leader
let mapleader = " "


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" BASIC CONFIGURATION
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Backspace deletes like most programs in insert mode
set backspace=2
" allow unsaced backgroudn buffers and remember their undo/marks
set hidden 
set undofile
set undodir=~/.vim/undodir
set nowritebackup
" http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287
set noswapfile
set history=10000
set autoread
" Automatically :write before running commands
set autowrite
" display incomplete commands
set showcmd
set incsearch
" ignore case unless  there are capital
set ignorecase smartcase
set laststatus=2
" Disable modelines as a security precaution
set modelines=0
set nomodeline
set noeb vb t_vb=
set complete=.,w,b,u,t,i
set completeopt=menu,preview
"  no folding
set nofoldenable
set foldmethod=manual
" insert only one space when joining lines ending with punctuation '.', etc.
set nojoinspaces
set scrolloff=3
set sidescrolloff=3
set relativenumber
set signcolumn=yes
highlight clear SignColumn
set tabstop=2
set shiftwidth=2
set shiftround
set expandtab
set list listchars=tab:»·,trail:·,nbsp:·
" Make it obvious where 80 characters is
set colorcolumn=81
set number
" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright
" Set spellfile to location that is guaranteed to exist, can be symlinked to
set spellfile=$HOME/.vim-spell-en.utf-8.add
" Autocomplete with dictionary words when spell check is on
set complete+=kspell
" Always use vertical diffs
set diffopt+=vertical


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" APPEARANCE SETTINGS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" only show the parent folder in tabline if nested deeper.
function! TabLabel(n)
  let buflist = tabpagebuflist(a:n)
  let winnr = tabpagewinnr(a:n)
  let currentBuffPath = bufname(buflist[winnr - 1])
  return fnamemodify(currentBuffPath, ":h:t") . "/" . fnamemodify(currentBuffPath, ":t")
endfunction

function! TabLine()
  let s = ''
  for i in range(tabpagenr('$'))
    if i + 1 == tabpagenr()
      let s .= '%#TabLineSel#'
    else
      let s .= '%#TabLine#'
    endif
    let s .= ' %{TabLabel(' . (i + 1) . ')} '
  endfor
  let s .= '%#TabLineFill#%T'
  return s
endfunction

set tabline=%!TabLine()
syntax enable
set t_Co=256 " 256 colors
" a better pattern for drawing vertical borders.
set fillchars+=vert:\|
colorscheme lucius
set background=dark
let g:lucius_contrast_bg = 1
let g:lucius_use_bold = 1
" When the type of shell script is /bin/sh, assume a POSIX-compatible
" shell for syntax highlighting purposes.
let g:is_posix = 1


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" EXTENDED SETTINGS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

augroup vimrcEx
  autocmd!

  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  autocmd BufNewFile,BufRead * if expand('%:t') !~ '\.' | setlocal textwidth=80 | endif

  " Set syntax highlighting for specific file types
  autocmd BufRead,BufNewFile *.md set filetype=markdown
  autocmd BufRead,BufNewFile .{jscs,jshint,eslint}rc set filetype=json
  autocmd BufRead,BufNewFile aliases.local,zshrc.local,*/zsh/configs/* set filetype=sh
  autocmd BufRead,BufNewFile gitconfig.local set filetype=gitconfig
  autocmd BufRead,BufNewFile tmux.conf.local set filetype=tmux
  autocmd BufRead,BufNewFile vimrc.local set filetype=vim
  autocmd! FileType json set sw=2 sts=2 expandtab
  autocmd! FileType scss set sw=2 sts=2 expandtab
  autocmd! FileType elm set sw=4 sts=4 expandtab autoindent smartindent nocindent
  autocmd BufRead,BufNewFile *.sbt set filetype=scala

  " Spell check gitcommits and Markdown
  autocmd FileType gitcommit setlocal spell
  autocmd BufRead,BufNewFile *.md setlocal spell

  " Only wrap md and text
  autocmd BufRead,BufNewFile *.md,*.txt setlocal textwidth=80

  " Remove whitespace at end of lines
  autocmd BufWritePre *.erb,*.scss,*.rb,*.js,*.c,*.py,*.php,*.coffee :%s/\s\+$//e
augroup END

" Load matchit.vim, but only if the user hasn't installed a newer version.
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif

" use Ag over Grep
set grepprg=ag\ --nogroup\ --nocolor

" Tab completion
" will insert tab at beginning of line,
" will use completion if not at beginning
set wildmode=list:longest,list:full
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<Tab>"
    else
        return "\<C-p>"
    endif
endfunction
inoremap <Tab> <C-r>=InsertTabWrapper()<CR>
inoremap <S-Tab> <C-n>

" statusline
set statusline=%<%f\ (%{&ft})\ %-4(%m%)%=%-19(%3l,%02c%03V%)
" hi statusline ctermbg=15 ctermfg=8
" set statusline=%<%f\ (%{&ft})\ %-4(%m%)%=%-19(%3l,%02c%03V%)


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VIM-TEST MAPPINGS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

nnoremap <silent> <Leader>tf :TestFile<CR>
nnoremap <silent> <Leader>tn :TestNearest<CR>
nnoremap <silent> <Leader>tl :TestLast<CR>
nnoremap <silent> <Leader>ta :TestSuite<CR>
nnoremap <silent> <Leader>tv :TestVisit<CR>
let test#strategy = "dispatch"
let test#scala#runner = 'blooptest'
let g:test#scala#blooptest#executable = 'heroku local:run -- bloop'


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" HTML IS ANNOYING
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" FUGITIVE SETTINGS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set tags^=.git/tags
set statusline+=%{FugitiveStatusline()}


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" QUICKER MOVEMENT
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
" move between wrapped lines
nnoremap j gj
nnoremap k gk


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ESCAPE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" treat C-c as Esc in insert mode
inoremap <c-c> <esc>
" use C-Space to Esc any mode
nnoremap <C-Space> <Esc>:noh<CR>
vnoremap <C-Space> <Esc>gV
onoremap <C-Space> <Esc>
cnoremap <C-Space> <C-c>
inoremap <C-Space> <Esc>
" terminal sees <C-@> as <C-space>
nnoremap <C-@> <Esc>:noh<CR>
vnoremap <C-@> <Esc>gV
onoremap <C-@> <Esc>
cnoremap <C-@> <C-c>
inoremap <C-@> <Esc>

" convenience
nnoremap <leader>; :


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SEARCH
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

nnoremap <leader>sub :%s///g<left><left>
vnoremap <leader>sub :s///g<left><left>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ALE CONFIG
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" let g:ale_linters = {'scala': ['metals-vim'], 'ruby': ['ruby'], 'javascript': [], 'typescript': ['tsserver', 'eslint'], 'typescript.tsx': ['tsserver', 'eslint']}
" let g:ale_fixers = {'javascript': [], 'typescript': ['prettier'], 'typescript.tsx': ['prettier']}
" let g:ale_linters_explicit = 1
" let g:ale_lint_on_text_changed = 'normal'
" let g:ale_lint_on_insert_leave = 1
" let g:ale_lint_delay = 0
" let g:ale_set_quickfix = 0
" let g:ale_set_loclist = 0
" let g:ale_javascript_eslint_executable = 'eslint --cache'
" nnoremap gj :ALENextWrap<cr>
" nnoremap gk :ALEPreviousWrap<cr>
" nnoremap g1 :ALEFirst<cr>
" " This mapping will kill all ALE-related processes (including tsserver). It's
" " necessary when those processes get confused. E.g., tsserver will sometimes
" " show type errors that don't actually exist. I don't know exactly why that
" " happens yet, but I think that it's related to renaming files.
" nnoremap g0 :ALEStopAllLSPs<cr>

" autocmd BufNew,BufEnter *.vim,*.rb,*.erb execute "silent! CocDisable"
" autocmd BufLeave *.vim,*.rb,*.erb execute "silent! CocEnable"


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" COC CONFIG
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set updatetime=300
set shortmess+=c
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-tag> to trigger completion.
inoremap <silent><expr> <c-tab> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" noremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

nmap <silent> gj <Plug>(coc-diagnostic-prev)
nmap <silent> gk <Plug>(coc-diagnostic-next)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)

nmap <leader>rn <Plug>(coc-rename)

nnoremap <expr><C-f> coc#util#has_float() ? coc#util#float_scroll(1) : "\<C-f>"
nnoremap <expr><C-b> coc#util#has_float() ? coc#util#float_scroll(0) : "\<C-b>"

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
nnoremap <silent> <leader>F :call CocAction('format')<CR>

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline+=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>d  :<C-u>CocList diagnostics<cr>

" Notify coc.nvim that <enter> has been pressed.
" Currently used for the formatOnType feature.
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
      \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" " Toggle panel with Tree Views
" nnoremap <silent> <space>t :<C-u>CocCommand metals.tvp<CR>
" " Toggle Tree View 'metalsBuild'
" nnoremap <silent> <space>tb :<C-u>CocCommand metals.tvp metalsBuild<CR>
" " Toggle Tree View 'metalsCompile'
" nnoremap <silent> <space>tc :<C-u>CocCommand metals.tvp metalsCompile<CR>
" " Reveal current current class (trait or object) in Tree View 'metalsBuild'
" nnoremap <silent> <space>tf :<C-u>CocCommand metals.revealInTreeView metalsBuild<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" FZF CONFIG
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Use ag in fzf for listing files. Lightning fast and respects .gitignore
let $FZF_DEFAULT_COMMAND = 'ag --literal --files-with-matches --hidden -g ""'
nnoremap <C-p> :Files<CR>
nnoremap <C-a> :Ag<space>
nnoremap <leader>fp :Files<cr>
nnoremap <leader>fb :Buffers<CR>
nnoremap <leader>ft :Tag<cr>
nnoremap <leader>fo :BTag<cr>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" QUICKLY CREATE FILES
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>
map <Leader>te :tabe <C-R>=expand("%:p:h") . "/" <CR>
map <Leader>se :sp <C-R>=expand("%:p:h") . "/" <CR>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" EASIER COPY PASTE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap cp "+y
xnoremap cp "+y
nmap cv "+p
nmap cV "+P


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" COPY FOR RICH TEXT EDITORS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function CopyToBasecamp() range
  echo system('echo '.shellescape(join(getline(a:firstline, a:lastline), "\n")).' | pandoc -f markdown | textutil -stdin -format html -convert rtf -stdout | pbcopy')
endfunction
com -range=% -nargs=0 CopyToBasecamp :<line1>,<line2>call CopyToBasecamp()
xnoremap <Leader>b <esc>:'<,'>CopyToBasecamp<CR>
