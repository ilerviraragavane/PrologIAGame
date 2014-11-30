%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Gère l interaction avec un utilisateur humain
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

afficher_joueur :- nb_getval(player,Player), nl,
				write('Joueur '), write(Player), write(', à vous !').


%Demande la saisie des pions de départ et d arrivée									
askStartPosition( Position ) :- 
	nl,
	write('Choisissez un pion à deplacer'),
	nl, 
	read( Position ).

askEndPosition( Position ) :- 
	nl,
	write('Choisissez la case d\'arrivée'),
	nl, 
	read( Position ).		



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% checkHit : test si le coup demandé est dans la liste des coups possible (L),
%		Si ce n est pas le cas, on redemande de rentrer un coup,
%		On retourne le coup possible dans R.

checkHit( ( Dx, Dy ) , ( Ax, Ay ), L, R ) :- 
	member( ( Dx, Dy, Ax, Ay ), L ), 
	R = ( Dx, Dy, Ax, Ay ).

checkHit( ( Dx, Dy ) , ( Ax, Ay ), L, R ) :- 
	not( member( ( Dx, Dy, Ax, Ay ), L ) ), 
	write('Ce coup n est pas valide'),
	askStartPosition( S ), 
	askEndPosition( E ),
	checkHit( S, E, L, R ).

% Permet d éviter le plantage en cas de données non valides
checkHit(C1,C2,L,R) :- 
	C1 \= (_,_),
	C2 \= (_,_),
	write('Ce coup n est pas valide'),
	askStartPosition(S), askEndPosition(E),
	checkHit(S,E, L, R).


