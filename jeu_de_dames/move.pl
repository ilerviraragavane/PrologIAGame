%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%	Module permettant de chercher tous les déplacements simples possibles 
%		pour un pion ou une dame
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Retourne la liste L des déplacements possibles pour le joueur Noir
checkMoveBlack( L ) :- 
	setof( Dy, checkMoveB( Dx, Dy ), T ),
	append( [ Dx ], [ T ], L ).

% Teste si le déplacement est valide (joueur noir)
checkMoveB( [ Dx, Dy ] , [ Ax, Ay ] ) :- 
	(
		pion( n, Dx, Dy ), 
		moveB( Dx, Dy, Ax, Ay )
	);
	(
		dame( n, Dx, Dy ), 
		moveDame( Dx, Dy, Ax, Ay )
	).


% Retourne la liste L des déplacements possibles pour le joueur Noir
checkMoveWhite( L ) :- 
	setof( Dy, checkMoveW( Dx, Dy ), T ),
	append( [ Dx ] , [ T ] , L ).


% Teste si le déplacement est valide (joueur noir)
checkMoveW( [ Dx, Dy ] , [ Ax, Ay ] ) :- 
	(
		pion( b, Dx, Dy ), 
		moveW( Dx, Dy, Ax, Ay )
	);
	(
		dame( b, Dx, Dy ), 
		moveDame( Dx, Dy, Ax, Ay )
	).

% Retourne Ax, Ay les coordonnées où le point noir situé en Dx, Dy peut se déplacer
moveB( Dx, Dy, Ax, Ay ) :- 
	(
		Ax is Dx - 1;
		Ax is Dx + 1
	),
	Ay is Dy - 1,
	Ax > 0, 
	Ay > 0, 
	Ax < 9, 
	Ay < 9,  
	not( pion( _, Ax, Ay ) ), 
	not( dame( _, Ax, Ay ) ).

% Retourne Ax, Ay les coordonnées où le point blanc situé en Dx, Dy peut se déplacer
moveW( Dx, Dy, Ax, Ay ) :- 
	(
		Ax is Dx - 1;
		Ax is Dx + 1
	),
	Ay is Dy + 1,
	Ax > 0, 
	Ay > 0, 
	Ax < 9, 
	Ay < 9,  
	not( pion( _, Ax, Ay ) ), 
	not( dame( _, Ax, Ay ) ).

% Retourne Ax, Ay les coordonnées où la dame située en Dx, Dy peut se déplacer (peu importe la couleur)
moveDame( Dx, Dy, Ax, Ay ) :- 
	(
		Ax is Dx - 1;
		Ax is Dx + 1
	),
	(
		Ay is Dy - 1;
		Ay is Dy + 1
	),
	Ax > 0, 
	Ay > 0, 
	Ax < 9, 
	Ay < 9, 
	not( pion( _, Ax, Ay ) ), 
	not( dame( _, Ax, Ay ) ).


