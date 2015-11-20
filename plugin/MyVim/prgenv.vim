function! prgenv#TagMake()
    if &ft == 'python'
        !ctags --languages=python -R
    else
        !ctags -R
    endif
    set tags+=./tags
endfun
let $DRIVE2 = "D:/"
let $LATEXBINDIR = $DRIVE2 . "usr/texlive/2011/bin/win32/"
" let $LATEXBINDIR = $DRIVE . "usr/texlive/2011/bin/win32/"
function! prgenv#Execute(arg) range
    let option = a:arg
	w!
    if &filetype is 'make'

        
        !mingw32-make clean
        !mingw32-make

    elseif expand('%:e') is "vim" || expand('%') =~ 'vimrc'
        
        so %

    elseif expand('%:e') is "java"
        
        
        !java %:h
  
    elseif expand('%:e') is "avl"

        
        !Chrome.exe --args --allow-file-access-from-files %:p
        " !chrome.exe %:p
        " !"C:\Documents and Settings\GCS\Local Settings\Application Data\Google\Chrome\Application\chrome.exe" %:p
        " !C:\WINDOWS\Microsoft.NET\Framework\v4.0.30319\vbc.exe %:p

    elseif &filetype is 'vbnet'

        
        !C:\WINDOWS\Microsoft.NET\Framework\v4.0.30319\vbc.exe %:p

    elseif &filetype is 'ruby'

        
		!ruby %
		" call asynccommand#run("ruby %:p")

    elseif &filetype is 'python'

        " NeoCompleteDisable
        " NeoCompleteEnable

        
        let choose_num = input("[default enter : output in vim] / [+0] Python27(shadow) / [+1] Python27(pending shell) / [+2] Panda3D (v1.3.2) / [+3] python33 / [+4] python27-64bit : ",27)
        " let choose_num = input("0. Default (python27) 1. Panda3D game engine (v1.81) 2. python33  (Enter = Default(0)) : ")
        if choose_num == 27
            let @a = '' 
            let @a = system("c:/Python27/python -W ignore " . expand('%:p'))
            if @a != ''
                rightbelow vnew
                setlocal syntax=vim
                nmap <buffer>q :q!<CR>
                normal "ap
                " setlocal nowrap
                " setlocal nomodifiable
                let @a = '' 
            endif
            " !c:/Python27/python -W ignore %:p
        elseif choose_num == 270
            call asynccommand#run("c:/Python27/python -W ignore %:p")
        elseif choose_num == 271
            !c:/Python27/python -W ignore %:p
            " !c:/Panda3D-1.8.1/python/ppython %:p
        elseif choose_num == 272
            !c:/Panda3D-1.3.2/python/ppython %:p
        elseif choose_num == 273
            !c:/Python33/python %:p
        elseif choose_num == 274
            !c:/Python27-64/python %:p
        else
            echo 'Bye~'
            return
        endif

    elseif &filetype is 'matlab'

        
        silent !matlab -nodesktop -nosplash -r "run '%:p'"
        " !"C:\Program Files\MATLAB\R2012b\bin\matlab" -nodesktop -nosplash -r "run '%:p'"
        " silent !"C:\Program Files\MATLAB\R2012b\bin\matlab" -nodesktop -nosplash -r "run '%:p'"
        " !matlab -nodesktop -nosplash -r "run '%:p'"

    elseif expand('%:t') is "_vimrc"

        " nmap <leader>re :w<CR>:source $MYVIMRC<CR>
        " silent normal! ,re

        echo 'ok'
        silent source $MYVIMRC

    elseif &filetype is 'progress'

        
        !swig -python %
        !python setup.py build_ext --inplace -cmingw32

    elseif &filetype is 'cpp'
        
        let choose_num = input("Choose : 0. general(default) 1. opengl 2. matlab(mex) ... ")
        redraws!
        " if choose_num == '1. general'
        if choose_num == 1
            !g++ -g -Wall % -IGL -lopengl32 -lglu32 -lfreeglut -o %<
        elseif choose_num == 2
            !g++ % --save-temps -I"C:\Program Files\MATLAB\R2012b\stateflow\c\mex\include" -I"C:\Program Files\MATLAB\R2012b\extern\include" -I"C:\Program Files\MATLAB\R2012b\simulink\include" -I"C:\Program Files\MATLAB\R2012b\rtw\c\src" -LC:/MinGW/lib -o %< -ggdb
        else
            !g++ % --save-temps -IC:/MinGW/include -LC:/MinGW/lib -o %< -ggdb
        endif
    elseif &filetype is 'c'

        let choose_num = input("1. General(default) / 2. Matlab(mex) ... / 3. OpenGL / 4. GNU Scientific Library | Choose : ",1)
        " let choose_num = input("1. General(default) / 2. Matlab(mex) ... / 3. OpenGL / 4. Make Shared Library(.so) / 5. GNU Scientific Library | Choose : ",1)
        " let choose_num = input("Choose : 1. General(default) / 2. Matlab(mex) ... / 3. OpenGL / 4. make shared library(.so) / 5. using GNU Scientific Library")
        redraws!
        let generatedfile = expand('%:p:r') . ".exe"
        
        if filereadable(generatedfile)
            silent !del %:p:r.exe
            " if choose_num == 4
            " silent !del %:s//lib/:r.so
            " end
        endif
        " if choose_num == '1. general'
        if choose_num == 13
            !mingw32-gcc -g -Wall % -IGL -lopengl32 -lglu32 -lfreeglut -o %<
            " !gcc -g -Wall % -IGL -lopengl32 -lglu32 -lfreeglut -o %<
        elseif choose_num == 12
            !gcc % --save-temps -I"C:\Program Files\MATLAB\R2012b\stateflow\c\mex\include" -I"C:\Program Files\MATLAB\R2012b\extern\include" -I"C:\Program Files\MATLAB\R2012b\simulink\include" -I"C:\Program Files\MATLAB\R2012b\rtw\c\src" -LC:/MinGW/lib -o %< -ggdb
        elseif choose_num == 1
            !gcc % --save-temps -IC:/MinGW/include -LC:/MinGW/lib -o %< -ggdb
        elseif choose_num == 14
            !gcc -g -Wall % -lgsl -o %<
        else
            redraw!
            echo 'Bye~'
            return
        endif

        if filereadable(generatedfile)
            if choose_num == 13
                " silent !%<.exe
                silent !%:r/%<.exe
            else
                !%:r/%<.exe
            endif
        else
            echo 'File generating failed!'
        endif

    elseif &filetype is 'tex'
        if g:MyEnvironment
            redraws!
            let filename_pdf = expand("%:p:r") .  '.pdf'
            let filename_aux = expand("%:p:r") .  '.aux'
            if filereadable(filename_pdf)
                echo filename_pdf . ' exists'
            endif
            let choose_num = inputlist(['Select compile process : ', '1. pdflatex(default)', '2. tikz (for drawing)', '3. xelatex', '4. lualatex', '5. pdflatex(--shell-escape)', '6. pdflatex(--enable-write18)'])
            " let choose_num = inputlist(['Select compile process : ', '1. pdflatex(default)', '2. tikz (for drawing)', '3. xelatex', '4. lualatex', '5. pdflatex(--shell-escape)'])
            if choose_num
                " ---------------------------------------------------------------------------------
                let filename = expand("%:t")
                
                w
                call system('taskkill /f /fi "Windowtitle eq ' . expand("%:t:r") . '.pdf - Foxit Reader" /im Foxit*')
                " !taskkill /f /fi "Windowtitle eq %:t:r.pdf - Foxit Reader" /im Foxit*
                if filereadable(filename)
                    call system('del ' . expand("%:p:r") . '.pdf')
                    " !del %:p:r.pdf
                endif
                " if filereadable(filename_aux)
                " silent !del %:p:r.aux
                " endif
                " ---------------------------------------------------------------------------------
            else
                return 0
            endif
            if choose_num == 2
                silent !C:\Users\Administrator\texlive\2012\bin\win32\latex.exe %:t:r.tex
                silent !C:\Users\Administrator\texlive\2012\bin\win32\dvips.exe %:t:r.dvi
                silent !C:\Users\Administrator\texlive\2012\bin\win32\ps2pdf.exe %:t:r.ps
            elseif choose_num == 3
                silent !C:\Users\Administrator\texlive\2012\bin\win32\xelatex.exe %:t:r.tex
            elseif choose_num == 4
                silent !C:\Users\Administrator\texlive\2012\bin\win32\lualatex.exe %:t:r.tex
            elseif choose_num == 5
                silent !C:\Users\Administrator\texlive\2012\bin\win32\pdflatex.exe --shell-escape %:p
            elseif choose_num == 6
                silent !C:\Users\Administrator\texlive\2012\bin\win32\pdflatex.exe --enable-write18 %:p
                " silent !C:\Users\Administrator\texlive\2012\bin\win32\pdflatex.exe --enable-write18 %:p
            elseif choose_num == 1
                " let exe = system($LATEXBINDIR . "pdflatex.exe " . shellescape(expand("%:p")) . " >NUL" )
                " silent !D:\Users\Administrator\texlive\2011\bin\win32\pdflatex.exe %:p
                " silent call asynccommand#run("!C:\Users\Administrator\texlive\2012\bin\win32\pdflatex.exe %:p")
                silent !C:\Users\Administrator\texlive\2012\bin\win32\pdflatex.exe %:p
            endif

            if filereadable(filename_pdf)
                " call system('"C:\Program Files (x86)\Foxit Software\Foxit Reader\Foxit Reader.exe" ' . expand("%:p:r.pdf"))

                " rightbelow vnew
                " normal "pp
                let run_cmd = '"C:\Program Files (x86)\Foxit Software\Foxit Reader\Foxit Reader.exe" ' . expand("%:p:r") . '.pdf'
                call asynccommand#run(run_cmd)
                " silent !"C:\Program Files (x86)\Foxit Software\Foxit Reader\Foxit Reader.exe" %:p:r.pdf
                " silent call asynccommand#run("!C:\Users\Administrator\texlive\2012\bin\win32\pdflatex.exe %:p")
            endif
        else
            silent !C:\Users\Administrator\texlive\2012\bin\win32\pdflatex.exe -shell-escape %:p
            silent !"C:\Program Files (x86)\Foxit Software\Foxit Reader\Foxit Reader.exe" %:p:r.pdf
        endif
    endif
    redraw!
endf

function! prgenv#TagsMake()
    redraws!
    cd %:h
    if &ft is 'python'
        !ctags *.py --python-kinds=-i --list-kinds=python -R
        " !ctags *.py -R
    elseif &ft is 'c'
        !ctags *.c -R
    endif
    set tags=./tags
endf

" set tags+=C:/Python27/Lib/site-packages/cocos2d-0.5.5-py2.7.egg/cocos/tags
" set tags+=C:/Python27/Lib/site-packages/pyglet/tags
" set tags+=C:/python27/lib/site-packages/pygame/tags
" set tags+=C:/python27/lib/site-packages/pyqt4/tags
fun! TagSelection()
    set tags
    let allkill = input('Clear legacy? (say {c} if you want)')
    let base = 'C:/Python27/Lib/site-packages/' 
    redraw!
    if allkill == 'c'
        echo 'Current tag set will be cleared!'
    else
        echo 'New tags will be added to current set...'
    endif
    let sel = inputlist(['Select tag you want to be tagged!','1. pyglet','2. cocos2d','3. pyqt4','4. pygame','5. all']) 
    if sel == 1 
        let name = 'pyglet' 
    elseif sel  == 2 
        let name = 'cocos2d-0.5.5-py2.7.egg/cocos' 
    elseif sel  == 3 
        let name = 'pyqt4' 
    elseif sel  == 4 
        let name = 'pygame' 
    elseif sel  == 5 
        set tags+=C:/Python27/Lib/site-packages/cocos2d-0.5.5-py2.7.egg/cocos/tags
        set tags+=C:/Python27/Lib/site-packages/pyglet/tags
        set tags+=C:/python27/lib/site-packages/pygame/tags
        set tags+=C:/python27/lib/site-packages/pyqt4/tags
        set tags
        return
    else
        redraw!
        echo 'No change, bye~'
        return
    endif
    let cmd = base . name . '/tags' 
    if allkill == 'c'
        exe 'set tags=' . cmd
    else
        exe 'set tags+=' . cmd
    endif
    redraws!
    set tags
endfun
nmap <leader><C-s> :call TagSelection()<cr>

nmap ,,d Opdb<TAB><ESC>,e

function! prgenv#Debug()
    if &ft is 'python'
        " norm ,,d
        Pyclewn pdb %
        " Cmapkeys
    elseif &ft is 'c'
        silent! Pyclewn
        Cfile %:t:r
        " silent! Cmapkeys
    else
        Pyclewn
    endif

    " nnoremap ++ :call CmapkeysToggle()<CR>
    " nnoremap FF :call ReloadFile()<CR>
    "
    " command -narg=1 W Cdbgvar <args>  " (W)atch
    " command -narg=1 R Cdelvar <args>  " e(R)ase (Delete)
    " command -narg=1 F Cfile <args>        " (F)ile
    " command -narg=1 D Cdisplay <args>     " (D)isplay
    "
    " command RR execute 'Cfile %:r' | execute ":echo 'Reload current file'"
    " command KK execute 'Cmapkeys' | execute ":echo 'mapkeys'"
    " command UU execute 'Cunmapkeys' | execute ":echo 'unmapkeys'"

endf

let g:toggle = 0
fun! CmapkeysToggle()
    if has("netbeans_enabled") && g:toggle == 1
        Cunmapkeys
        echo 'unmap'
        let g:toggle = 0
    elseif has("netbeans_enabled") && g:toggle == 0
        Cmapkeys
        echo 'map'
        let g:toggle += 1
    else
        echo "First, you should start pyclewn! (type :Pyclewn<CR>)"
    endif
endf

" netbeans_enabled  Compiled with support for |netbeans| and connected.
fun! ReloadFile()
    if has("netbeans_enabled")
        echo "Going on... has been launched."
        Cfile %:t:r
    else
        echo "First, you should start pyclewn! (type :Pyclewn<CR>)"
        " " echo "First, you should type :Pyclewn<CR>"
    endif
endf

fun! PyclewnLaunch()
    Pyclewn
    redraws!
endf
command! CC call PyclewnLaunch()

nmap ,E :!C:/Panda3D-1.7.2/python/python %<CR>

" DLL making process"
" function MakeDLLsilent(arg) range
" " redraws!
" let option = a:arg
" 
" if &ft is 'c'
" if option == 1
" echo 'Making DLL...(only using gcc)'
" silent !gcc -c %
" silent !gcc -shared %:r.o -o %:r.dll
" elseif option == 2
" echo 'Making DLL...(dlltool.exe)'
" echo "step 1. compile without link"
" silent!gcc -c % -o %:r.o
" redraw!
" 
" echo "step 2. after creating object file, create def-file"
" silent!dlltool --output-def %:r.def --kill-at --dllname %:r.dll %:r.o
" 
" echo "step 3. after creating def-file, create library. This is not DLL, but just library to refer to code needed for creating DLL"
" silent!dlltool --output-lib lib%:r.a --input-def %:r.def --kill-at --dllname %:r.dll %:r.o
" 
" echo "step 4. remain stuff, bunch created files into one DLL. This will be done by gcc"
" silent!gcc %:r.o -o %:r.dll -mwindows -Wall -L. -l%:r -shared
" endif
" else
" echo 'Only C-file available!'
" endif
" endf
function! MakeDLL(arg)

    if &ft is 'c' 

        if a:arg == 2
            echo 'Making DLL...(using dlltool.exe)'
            " sleep

            echo "step 1. compile without link"
            !gcc -c % -o %:r.o

            echo "step 2. after creating object file, create def-file"
            !dlltool --output-def %:r.def --kill-at --dllname %:s//lib/:r.dll %:r.o

            echo "step 3. after creating def-file, create library. This is not DLL, but just library to refer to code needed for creating DLL"
            !dlltool --output-lib lib%:r.a --input-def %:r.def --kill-at --dllname %:s//lib/:r.dll %:r.o

            echo "step 4. remain stuff, bunch created files into one DLL. This will be done by gcc"
            !gcc %:r.o -o %:s//lib/:r.dll -mwindows -Wall -L. -l%:r -shared
        elseif a:arg == 1
            echo 'Making DLL...(only using gcc)'
            !gcc -c %
            !gcc -shared %:r.o -o %:s//lib/:r.dll
        elseif a:arg == 3
            "two step"
            !gcc -c -fPIC % -o %:r.o
            !gcc %:r.o -shared -o %:s//lib/:r.so
        elseif a:arg == 4
            "one step"
            !gcc -shared -o %:s//lib/:r.so -fPIC %
        elseif a:arg == 5
            "one step"
            " !gcc -shared -o %:s//lib/:r.so -fPIC %:r.c
            !gcc -Wall -fPIC -O3 -shared -o %:s//lib/:r.so -lm % -lgsl
        endif
    elseif &ft is 'cpp'
        if a:arg == 2
            echo 'Making DLL...(using dlltool.exe)'
            " sleep

            echo "step 1. compile without link"
            !g++ -c % -o %:r.o

            echo "step 2. after creating object file, create def-file"
            !dlltool --output-def %:r.def --kill-at --dllname %:s//lib/:r.dll %:r.o

            echo "step 3. after creating def-file, create library. This is not DLL, but just library to refer to code needed for creating DLL"
            !dlltool --output-lib lib%:r.a --input-def %:r.def --kill-at --dllname %:s//lib/:r.dll %:r.o

            echo "step 4. remain stuff, bunch created files into one DLL. This will be done by g++"
            !g++ %:r.o -o %:s//lib/:r.dll -mwindows -Wall -L. -l%:r -shared
        elseif a:arg == 1
            echo 'Making DLL...(only using g++)'
            !g++ -c %
            !g++ -shared %:r.o -o %:s//lib/:r.dll
        elseif a:arg == 3
            "two step"
            !g++ -c -fPIC % -o %:r.o
            !g++ %:r.o -shared -o %:s//lib/:r.so
        elseif a:arg == 4
            "one step"
            !g++ -shared -o %:s//lib/:r.so -fPIC %
        elseif a:arg == 5
            "one step"
            " !g++ -shared -o %:s//lib/:r.so -fPIC %:r.c
            !g++ -Wall -fPIC -O3 -shared -o %:s//lib/:r.so -lm % -lgsl
        endif
    else
        echo 'This is not C/C++ file!'
        " echo 'Only C-file available!'
    endif
endf

fun! MakeDLLcall()
    redraws!

    let steptype  = inputlist(["Build Dynamic Linked Library", "1. gcc only","2. with dlltool","3. libfoo.so (2-step)","4. libfoo.so (1-step)","5. libfoo.so (with GSL)"])

    let fileroot = expand('%:r')
    if steptype == 1 || steptype == 2
        let generatedfile = 'lib' . fileroot . '.dll'
    else
        let generatedfile = 'lib' . fileroot . '.so'
    end

    if filereadable(generatedfile)
        let del = system("del " . generatedfile )
    endif

    " let steptype  = inputlist(["gcc only [vs] using dlltool : ", "1. gcc only","2. with dlltool","3. lib*.so"])
    if !steptype
        redraws!
        echo "Bye~"
        return
    endif
    redraws!
    let showing  = inputlist(["Do you want to see [step by step] process? ", "1. Yes","2. No, I wanna quick one"])
    redraws!
    if showing == 1
        call MakeDLL(steptype)
    elseif showing == 2
        silent call MakeDLL(steptype)
    endif

    if filereadable(generatedfile)
        echo 'New library is generated successfully!'
        let g = system("dir " . generatedfile)
        echo g
    else
        echo 'Sorry, it`s failed!'
    endif

endfun

nmap <silent>mkso :call MakeDLLcall()<CR>
" nmap mkdll :call MakeDLL1($buf.count)<CR>
" imap <silent>mkdll <C-[>:call MakeDLLcall()<CR>
" imap <silent>mkdll <C-[>:call MakeDLL1(1)<CR>

command! Mkdll call MakeDLLcall()

fun! prgenv#CscopePythonSettingOrigin()
    redraws!
    " cs reset
    cs reset
    if input("[Cscope Batch Process]\n This will take several processes, are you sure? ( do ) ") == "do"
        cd %:p:h
        if filereadable('cscope.files') 
            silent !del *.files 
        endif
        if filereadable('cscope.out')   
            silent !taskkill /im cscope.exe
            silent !del *.out   
        endif
        redraws!

        " redraw
        let lang = input("Which language do you want? (just enter : default to this file extension) : ")
        redraws!
        if lang == "c"
            echo '[C]'
            sleep 500ms
            silent !dir /b /s *.c > cscope.files
        elseif lang == 'py'
            echo '[python]'
            sleep 500ms
            silent !dir /b /s *.py > cscope.files
        elseif lang == 'm' 
            echo '[matlab]'
            sleep 500ms
            silent !dir /b /s *.m > cscope.files
        elseif lang == '.' 
            echo '[all]'
            sleep 500ms
            silent !dir /b /s *.* > cscope.files
        else
            echo '[' . &ft . ']' . ' (default as your wish)'
            sleep 500ms

            let current_ext = expand('%:e')
            silent exec '!dir /b /s *.' . current_ext . ' > cscope.files'
        endif
        silent !cscope -b -i cscope.files
        silent !ctags -L cscope.files

        sleep 500ms
        redraws!
        cs add cscope.out
    else
        redraws!
        echo "Bye~"
    endif
endfun
fun! prgenv#CscopePythonSettingVariation()
    cd %:p:h
    cs kill 0
    !del *.files *.out

    !pycscope
    cs add cscope.out
endfun
fun! FileDetectPysmell()
    if filereadable("./PYSMELLTAGS")
        let pyglet  = 0
        let pygame  = 0
        let vpython = 0
        let numpy   = 0
        let panda3d = 0
        let scipy   = 0
        let sympy   = 0
        let ipython = 0
        let cocos2d = 0
        let pyqt4   = 0
        if filereadable("./PYSMELLTAGS.pyglet")  | let pyglet  = 1 | endif
        if filereadable("./PYSMELLTAGS.pygame")  | let pygame  = 1 | endif
        if filereadable("./PYSMELLTAGS.visual")  | let vpython = 1 | endif
        if filereadable("./PYSMELLTAGS.numpy")   | let numpy   = 1 | endif
        if filereadable("./PYSMELLTAGS.panda3d") | let panda3d = 1 | endif
        if filereadable("./PYSMELLTAGS.scipy")   | let scipy   = 1 | endif
        if filereadable("./PYSMELLTAGS.sympy")   | let sympy   = 1 | endif
        if filereadable("./PYSMELLTAGS.ipython") | let ipython = 1 | endif
        if filereadable("./PYSMELLTAGS.cocos2d") | let cocos2d = 1 | endif
        if filereadable("./PYSMELLTAGS.pyqt4")   | let pyqt4   = 1 | endif
        let msg = 'Already have PYSMELLTAGS including ~ '
        if pyglet  | let msg = msg .' '. '[ pyglet ]'  | endif
        if pygame  | let msg = msg .' '. '[ pygame ]'  | endif
        if vpython | let msg = msg .' '. '[ vpython ]' | endif
        if numpy   | let msg = msg .' '. '[ numpy ]'   | endif
        if panda3d | let msg = msg .' '. '[ Panda3D ]' | endif
        if scipy   | let msg = msg .' '. '[ scipy ]'   | endif
        if sympy   | let msg = msg .' '. '[ sympy ]'   | endif
        if ipython | let msg = msg .' '. '[ IPython ]' | endif
        if cocos2d | let msg = msg .' '. '[ cocos2d ]' | endif
        if pyqt4   | let msg = msg .' '. '[ pyqt4 ]'   | endif
        " let msg = msg . '!'
        echo msg
    else
        echo "No PYSMELLTAGS in current space"
    endif
endfun
fun! prgenv#MakePYSMELLSbeReady()
    redraws!
    cd %:p:h
    call FileDetectPysmell()
    let choose_name = input('What module do you want? PYSMELLTAGS.(pyglet,pygame,cocos2d,pyqt) : ')
    redraws!
    if choose_name == ''
        redraws!
        echo 'Bye~'
        return
    endif
    " let working = 1
    let PYSMELLTAGS_DIR = 'C:\pysmelltags'
    exe '!copy ' . PYSMELLTAGS_DIR . '\PYSMELLTAGS.' . choose_name . '*'
    silent !pysmell .
    " endif
endfun
fun! prgenv#SelectOmnifuncPython()
    redraws!
    if len(&omnifunc) > 0
        echo 'Current omnifunc is [ ' . &omnifunc . ' ]'
    else
        echo 'No omnifunc set now'
    endif
    let choose_num = inputlist(['Wanna set to? : ', '1. RopeOmni', '2. pysmell#Complete', '3. pythoncomplete#Complete','4. jedi#completions'])
    if choose_num == 1
        " set omnifunc=RopeOmni
        set omnifunc=RopeCompleteFunc
    elseif choose_num == 2
        set omnifunc=pysmell#Complete
    elseif choose_num == 3
        set omnifunc=pythoncomplete#Complete
    elseif choose_num == 4
        set omnifunc=jedi#completions
    endif
endfun


function! prgenv#GetFoo()
    call inputsave()
    let g:Foo = input("Enter search pattern: ")
    call inputrestore()
endfunction
" nmap <silent>\g :call VimgrepFoo()<CR>:exe ":vimgrep " . Foo ." *.*"<CR>
function! prgenv#VimgrepFoo(ext)
    redraw!
    call inputsave()
    let g:Foo = input("In .".a:ext." -> Search Pattern: ")
    call inputrestore()
endfunction
function! prgenv#VimgrepEXE()
    redraws!
    echo '[vimgrep]'
    let recur = inputlist(["Do you want recursive?","1. Yes, recursively.","2. No, in current directory."])
    if recur == 1
        let recursive = 1
    elseif recur == 2
        let recursive = 0
    else
        redraws!
        echo 'Bye~'
        return
    endif
    redraws!
    let ext   = input("For what extent? ")
    if len(ext) == 0
        let ext = expand("%:e")
        " redraws!
        " echo "Set to current(this) file extent!"
        " sleep 200m
        " sleep 570m
    endif
    redraws!
    call prgenv#VimgrepFoo(ext)
    if len(g:Foo) > 0
        if len(ext) > 0 
            if recursive
                exe "vimgrep " . g:Foo . " **/*" . '.' . ext
            else
                exe "vimgrep " . g:Foo . " *" . '.' . ext 
            endif
        else
            if recursive
                exe "vimgrep " . g:Foo . " **/*"
            else
                exe "vimgrep " . g:Foo . " *"
            endif
        endif
    else
        redraws!
        echo 'Bye~'
    endif
endfun
