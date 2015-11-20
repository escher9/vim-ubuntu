fun! QuitAll(dir)
    let current_window_nr = winbufnr(0) 
    let cmd_dir = 'wincmd ' . a:dir
    let starting_window_rel_nr = winnr() 

    " init movement
    exe cmd_dir
    let other_window_nr = winbufnr(0) 

    while current_window_nr == other_window_nr
        if starting_window_rel_nr != winnr() && winnr() != 1
            exe 'q!'
            exe cmd_dir
        else
            break
        endif
        let other_window_nr = winbufnr(0) 
    endwhile
    " while current_window_nr != other_window_nr || winnr() != 1
    " if a:dir == 'h'
        " let condition = (current_window_nr != other_window_nr || winnr() != 1)
    " else
        " let condition = (current_window_nr != other_window_nr && winnr() != 1)
    " endif
    " while condition
	while current_window_nr != other_window_nr || winnr() != 1
        exe 'q!'
        exe cmd_dir
        let other_window_nr = winbufnr(0) 
    endwhile
    exe 'wincmd p'
endfun
nmap <C-w><C-l> :call QuitAll('l')<CR>
nmap <C-w><C-h> :call QuitAll('h')<CR>
nmap <C-w><C-j> :call QuitAll('j')<CR>
nmap <C-w><C-k> :call QuitAll('k')<CR>
