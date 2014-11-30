/* Theme arithmétique TP prolog */

element(1,X,[X|_]).
element(N,X,[_|T]) :- nonvar(N),N1 is N-1, element(N1,X,T).
element(N,X,[_|T]) :- var(N),element(N1,X,T),N is N1+1.

% ce programme peut etre ecrit plus simplement (2 lignes)

element2(1,X,[X|_]).
element2(N,X,[_|T]) :- nonvar(N) -> N1 is N-1, element2(N1,X,T); element2(N1,X,T),N is N1+1.

/*  Exemples de requetes
 ?- element2(I,a,[a,b,a]).
I = 1 ;
I = 3 ;

 ?- element2(I,X,[a,b,a]).

I = 1
X = a ;

I = 2
X = b ;

I = 3
X = a ;

 ?- element2(1,a,[]).
	
No
*/