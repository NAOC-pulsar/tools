imap /** /**<CR><CR>/<UP><UP><right>
imap \io #include <iostream> <CR>#include <string><CR>using namespace std;<CR>
imap \std using namespace std;
imap \fu (){<CR><CR>}<UP>
:ab main int main(){<CR><CR><CR>}<UP><UP>
:ab {} {<CR><CR>}<UP>
:ab for for( ; ; ){<CR><CR>}<UP>
:ab if if()<left>
:ab else else    ;<left><left>
:ab elseif else<space>if()	;<left><left>
:ab while while(){<CR><CR>}<UP><UP><END><left><left>
:ab cin cin >>	;<left>
:ab cout cout <<	<<endl;<left><left><left><left><left><left><left><left>
:ab #d #define
:ab #i #include
:ab #b /************************************************
:ab #e ************************************************/
:ab #l /*----------------------------------------------*/
:set sw=4

map <F8> :CompCpp<CR>


fu! <SID>CompCpp()
	let flag = 0
	let string = 'g++ -Wall -O3 fin -o fout'
	let filename = bufname("%")
	let string = substitute(string,'fin',filename,flag)
	let fileout = substitute(filename,'cpp','exe',flag)
	let string = substitute(string,'fout',fileout,flag)
	echo string
	echo system(string)
endf

command! -nargs=0 CompCpp call <SID>CompCpp()
