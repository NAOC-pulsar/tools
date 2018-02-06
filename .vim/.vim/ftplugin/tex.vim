imap \bg \begin{}<CR><CR>\end{}<UP>
imap \eq \begin{equation}<CR><CR>\end{equation}<UP>
imap \gr \includegraphics[width=6cm]{}<left>
imap \frac \frac{}{}
imap \du \begin{document}<CR><CR>\end{document}<UP>
imap \hl \hline
:ab $$ $ $<left>
:ab #l %---------------------------------------------%
map <F8> :CompTex<CR>
map <C-i> :SpellCheck<CR>
map , ::SpellProposeAlternatives<CR>


function! <SID>table(lin,col) 
	let flag = 0
	let str = '.'
	let lnum = line(".")
	let k = append(lnum,'\begin{tabular}{}')
	let lnum = lnum + 1
	let i = 1
	while i <= a:lin
		let j = 1
		let string = "	\\\\"
		while j < a:col
			let string = substitute(string,'\\\\','\&	\\\\',flag)
			let j = j + 1
		endwhile
		let k = append(lnum,string)
		let i = i + 1
		let lnum = lnum + 1
	endwhile
	let k = append(lnum,'\end{tabular}')
	let lnum = lnum + 1
	let lnum = lnum - a:lin
	let k = cursor(lnum,1)
endf

fu! <SID>CompTex()
	let flag = 0
	let string = 'latex fn'
	let filename = bufname("%")
	let string = substitute(string,'fn',filename,flag)
	echo system(string)
	echo system(string)
	let filename = substitute(filename,'tex','dvi',flag)
	let psfile = substitute(filename,'dvi','ps',flag)
	let string = 'dvips dvifile -o psfile'
	let string = substitute(string,'dvifile',filename,flag)
	let string = substitute(string,'psfile',psfile,flag)
	echo system(string)

endf

fu! <SID>tableread(file)
	let flag = 0
	let cmdstr = '/home/zhuww/bin/preparetextable fn'
	let cmdstr = substitute(cmdstr,'fn',a:file,flag)
	echoh system(cmdstr)
	let lnum = line(".")
	let k = append(lnum,'\end{tabular}')
	let k = append(lnum,'\begin{tabular}{}')
	let lnum = line(".")
	let lnum = lnum + 1
	let col = 1
	let k = cursor( lnum,col)
	read readingtmp.tmp1
	let cmdstr = 'rm readingtmp.tmp1'
	echoh system(cmdstr)
endf

fu! <SID>TableForm() range
silent!	execute a:firstline . "," . a:lastline . 's/$/\\\\'
silent!	execute a:firstline . "," . a:lastline . 's/\ \ /\ '
silent!	execute a:firstline . "," . a:lastline . 's/\ \ /\ '
silent!	execute a:firstline . "," . a:lastline . 's/\ \ /\ '
silent!	execute a:firstline . "," . a:lastline . 's/\ \ /\ '
silent!	execute a:firstline . "," . a:lastline . 's/\ /\&\t'
endfunction



command! -nargs=* Tab call <SID>table(<f-args>)
command! -nargs=* -complete=file Tr call <SID>tableread(<f-args>)
command! -nargs=0 CompTex call <SID>CompTex()
command! -nargs=0 -range TF <line1>,<line2>call <SID>TableForm()
command! -nargs=0 Prosper r /home/zhuww/lib/TeX/prosper/example.tex
