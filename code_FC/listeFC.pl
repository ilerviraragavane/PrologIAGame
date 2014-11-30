/*Supprime toutes les occurences d'une liste*/

element3(X,[],[]).
element3(X,[X|Q],R) :- element3(X,Q,R).
element3(X,[T|Q],[T|R]) :- T \= X, element3(X,Q,R).

/*
 ?- element3(b,[b,a,c,b],L).
   Call: (8) element3(b, [b, a, c, b], _G530) ? creep
   Call: (9) element3(b, [a, c, b], _G530) ? creep
   Call: (10) a\=b ? creep
   Exit: (10) a\=b ? creep
   Call: (10) element3(b, [c, b], _G596) ? creep
   Call: (11) c\=b ? creep
   Exit: (11) c\=b ? creep
   Call: (11) element3(b, [b], _G599) ? creep
   Call: (12) element3(b, [], _G599) ? creep
   Exit: (12) element3(b, [], []) ? creep
   Exit: (11) element3(b, [b], []) ? creep
   Exit: (10) element3(b, [c, b], [c]) ? creep
   Exit: (9) element3(b, [a, c, b], [a, c]) ? creep
   Exit: (8) element3(b, [b, a, c, b], [a, c]) ? creep

L = [a, c] ;
*/

% une version de subsAll
subsAll(A,X,[],[]).
subsAll(A,X,[A|Q],[X|R]) :- subsAll(A,X,Q,R).
subsAll(A,X,[T|Q],[T|R]) :- T \= A, subsAll(A,X,Q,R).
