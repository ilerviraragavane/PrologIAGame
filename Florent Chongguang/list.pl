element(Obj,[Obj|R],R).
element(Obj,[X|Q],[X|R]) :- element(Obj,Q,R).

%expliquer ce qu on prend
extract(U,[X,Y]) :- nth1(PX,U,X),nth1(PY,U,Y), PX+1=:=PY.


append([ ], L1, L1).
append([A|L1],L2,[A|L3]) :- append(L1,L2,L3).


inv([],[]).
inv(L1,L2) :- 
	(var(L2)) 
	-> 
		reverse(L1,L2)
	; 
		((var(L1))
		->
			reverse(L2,L1)
		;
			length(L1,I1),length(L2,I2),I1=I2,reverse(L1,[H1|Q1]),L2=[H2|Q2],H1=H2,reverse(Q1,L),inv(L,Q2)
		)
	.

	
subsOne(A,B,[],[]).
subsOne(A,B,[A|Q],[B|Q]).
subsOne(A,B,[T|Q],[T|Q_subs]) :- subsOne(A,B,Q,Q_subs).
