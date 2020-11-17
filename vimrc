" This is what I added to my ~/.vimrc to make editing Inform sane.
" Though you can work around it in many cases, Inform seems to want very long
" lines and tabs for indentation.  

" Jump to where we left off in .ni story files and .i7x extensions
autocmd BufReadPost *.ni if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
autocmd BufReadPost *.i7x if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" tw=0 - Undo my usual default of wrapping text at 80 columns
" colorcolumn=0 - Undo my usual default of a colored column at 80 where I wrap
" noexpandtab - Undo my usual default of expanding tabs into spaces
" ts=8 - Tabs occupy 8 spaces
" smartindent - New lines are automatically indented to the same as the previous
" wrap - Wrap lines visually when they are longer than the terminal is wide
" linebreak - Break those wrapped lines at word boundaries
" breakindent - Indent those wrapped lines visually to the same level
" breakindentopt=shift:4 - Then add 4 spaces visually to the wrap indentation
" Apply these settings to both .ni story files and .i7x extensions
autocmd BufRead,BufNewFile *.ni set ts=8 noexpandtab smartindent colorcolumn=0 wrap linebreak breakindent breakindentopt=shift:4 tw=0
autocmd BufRead,BufNewFile *.i7x set ts=8 noexpandtab smartindent colorcolumn=0 wrap linebreak breakindent breakindentopt=shift:4 tw=0
