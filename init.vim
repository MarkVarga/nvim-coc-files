if exists('g:vscode')
    " VSCode extension
    set nocompatible

    let mapleader=' '
    
    map <leader>h :noh<CR>
else
    " ordinary Neovim
  set encoding=UTF-8 
	call plug#begin('/home/vml/.local/share/nvim/plugged')
	
	" below are some vim plugins for demonstration purpose.
	" add the plugin you want to use here.
	Plug 'sainnhe/gruvbox-material'
	Plug 'neoclide/coc.nvim'
	Plug 'preservim/nerdtree'
	"Plug 'nvim-treesitter/nvim-treesitter'
	Plug 'ryanoasis/vim-devicons'
	Plug 'tpope/vim-fugitive'
	"Plug 'junegunn/vim-easy-align'
	"Plug 'https://github.com/junegunn/vim-github-dashboard.git'
	"Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
	"Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }
	"Plug 'fatih/vim-go', { 'tag': '*' }
	"Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }
	Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'
	Plug 'mlaursen/vim-react-snippets'
	Plug 'alvan/vim-closetag'
	Plug 'jiangmiao/auto-pairs'
	Plug 'yuezk/vim-js'
	Plug 'maxmellon/vim-jsx-pretty'

	call plug#end()
	
" Colorscheme
	if has('termguicolors')
	set termguicolors
	endif
	set background=dark
	let g:gruvbox_material_background='dark'
	let g:gruvbox_material_better_performance=1
	colorscheme gruvbox-material
"	let g:airline_theme='gruvbox-material'
	hi! CocErrorLine guifg=#c94036 guibg=#4f1814
	
" Basic settings
	set nocompatible
	set clipboard=unnamedplus
	set completeopt=noinsert,menuone,noselect
	set hidden
	set inccommand=split
	set number 
	augroup numbertoggle
  autocmd!
		autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
		autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
	augroup END
	set mouse=v
	set splitbelow splitright
	set title
	set wildmenu
	set autoindent
	set showmatch
	autocmd CursorHold * silent call CocActionAsync('highlight')

" Formatting
	set tabstop=2
	set shiftwidth=2


" Keymappings
	let mapleader=' '

	map <leader>h :noh<CR>
	nnoremap <leader>n :NERDTreeToggle<CR>
	nnoremap <leader>e :NERDTreeFocus<CR>
	" Start NERDTree and leave the cursor in it.
	autocmd VimEnter * NERDTree | wincmd p
	" Stat Fuzzy Finder
	nnoremap <leader>f :FZF<CR>
	" FZF key bindings
	" nnoremap <C-f> :FZF<CR>
	let g:fzf_action = {
		\ 'ctrl-t': 'tab split',
		\ 'ctrl-i': 'split',
		\ 'ctrl-v': 'vsplit' }


	inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
	inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

	" Make <CR> to accept selected completion item or notify coc.nvim to format
	" <C-g>u breaks current undo, please make your own choice.
	inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
				      \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

	function! CheckBackspace() abort
	  let col = col('.') - 1
	  return !col || getline('.')[col - 1]  =~# '\s'
	endfunction

	" Use <c-space> to trigger completion.
	if has('nvim')
	  inoremap <silent><expr> <c-space> coc#refresh()
	else
	  inoremap <silent><expr> <c-@> coc#refresh()
	endif

	" Use `[g` and `]g` to navigate diagnostics
	" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
	nmap <silent> [g <Plug>(coc-diagnostic-prev)
	nmap <silent> ]g <Plug>(coc-diagnostic-next)

	" GoTo code navigation.
	nmap <silent> gd <Plug>(coc-definition)
	nmap <silent> gy <Plug>(coc-type-definition)
	nmap <silent> gi <Plug>(coc-implementation)
	nmap <silent> gr <Plug>(coc-references)

	" Use K to show documentation in preview window.
	nnoremap <silent> K :call ShowDocumentation()<CR>

	function! ShowDocumentation()
	  if CocAction('hasProvider', 'hover')
	    call CocActionAsync('doHover')
	  else
	    call feedkeys('K', 'in')
	  endif
	endfunction

	" Highlight the symbol and its references when holding the cursor.
	autocmd CursorHold * silent call CocActionAsync('highlight')

	" Symbol renaming.
	nmap <leader>rn <Plug>(coc-rename)

	" Formatting selected code.
	xmap <leader>cf  <Plug>(coc-format-selected)
	nmap <leader>cf  <Plug>(coc-format-selected)

	augroup mygroup
	  autocmd!
	  " Setup formatexpr specified filetype(s).
	  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
	  " Update signature help on jump placeholder.
	  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
	augroup end

	" Applying codeAction to the selected region.
	" Example: `<leader>aap` for current paragraph
	xmap <leader>a  <Plug>(coc-codeaction-selected)
	nmap <leader>a  <Plug>(coc-codeaction-selected)

	" Remap keys for applying codeAction to the current buffer.
	nmap <leader>ac  <Plug>(coc-codeaction)
	" Apply AutoFix to problem on the current line.
	nmap <leader>qf  <Plug>(coc-fix-current)

	" Run the Code Lens action on the current line.
	nmap <leader>cl  <Plug>(coc-codelens-action)

	" Map function and class text objects
	" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
	xmap if <Plug>(coc-funcobj-i)
	omap if <Plug>(coc-funcobj-i)
	xmap af <Plug>(coc-funcobj-a)
	omap af <Plug>(coc-funcobj-a)
	xmap ic <Plug>(coc-classobj-i)
	omap ic <Plug>(coc-classobj-i)
	xmap ac <Plug>(coc-classobj-a)
	omap ac <Plug>(coc-classobj-a)

	" Remap <C-f> and <C-b> for scroll float windows/popups.
	if has('nvim-0.4.0') || has('patch-8.2.0750')
	  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
	  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
	  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
	  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
	  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
	  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
	endif

	" Use CTRL-S for selections ranges.
	" Requires 'textDocument/selectionRange' support of language server.
	nmap <silent> <C-s> <Plug>(coc-range-select)
	xmap <silent> <C-s> <Plug>(coc-range-select)

	" Add `:Format` command to format current buffer.
	command! -nargs=0 Format :call CocActionAsync('format')

	" Add `:Fold` command to fold current buffer.
	command! -nargs=? Fold :call     CocAction('fold', <f-args>)

	" Add `:OR` command for organize imports of the current buffer.
	command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

	" Add (Neo)Vim's native statusline support.
	" NOTE: Please see `:h coc-status` for integrations with external plugins that
	" provide custom statusline: lightline.vim, vim-airline.
	set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

	" Mappings for CoCList
	" Show all diagnostics.
"	nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
	" Manage extensions.
"	nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
	" Show commands.
"	nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
	" Find symbol of current document.
"	nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
	" Search workspace symbols.
"	nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
	" Do default action for next item.
"	nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
"	" Do default action for previous item.
"	nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
	" Resume latest coc list.
"	nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
	command! -nargs=0 Prettier :CocCommand prettier.forceFormatDocument
"	command! -nargs=0 Prettier :CocCommand prettier.formatFile

endif
