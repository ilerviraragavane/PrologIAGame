%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Module permettant de trouver les coups "manger" possibles pour un joueur
%
% ----- commentaire: la methode principale ici est manger(Dx,Dy,Tx,Ty,Ax,Ay). 
%		Dx et Dy representent le point de depart, 
%		Ax et Ay representent le point d arrivee, 
%		Tx et Ty representent le point qui est mange.


% ----- Predicat pour v¨¦rifier si la position est vide ou pas
estVide( X, Y ) :- 
	not( pion( _, X, Y ) ),
	not( dame( _, X, Y ) ).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Droits de manger

mangerGaucheHaut( Dx, Dy, Tx, Ty, Ax, Ay ) :- 
	(
		dame( C, Dx, Dy );
		pion( C, Dx, Dy )
	), 
	adversaire(C, AdvC),
	Tx is Dx - 1, 
	Ty is Dy - 1, 
	(
		pion( AdvC, Tx, Ty );
		dame( AdvC, Tx, Ty )
	), 
	Ax is Tx - 1, 
	Ay is Ty - 1, 
	estVide( Ax, Ay ), 
	Ax > 0,
	Ay > 0.

mangerDroitHaut( Dx, Dy, Tx, Ty, Ax, Ay ) :- 
	(
		dame( C, Dx, Dy );
		pion( C, Dx, Dy )
	), 
	adversaire(C, AdvC),
	Tx is Dx + 1, 
	Ty is Dy - 1, 
	(
		pion( AdvC, Tx, Ty );
		dame( AdvC, Tx, Ty )
	), 
	Ax is Tx + 1, 
	Ay is Ty - 1, 
	estVide( Ax, Ay ), 
	Ax < 9,
	Ay > 0.

mangerGaucheBas( Dx, Dy, Tx, Ty, Ax, Ay ) :- 
	(
		dame( C, Dx, Dy );
		pion( C, Dx, Dy )
	), 
	adversaire(C, AdvC),
	Tx is Dx - 1, 
	Ty is Dy + 1, 
	(
		pion( AdvC, Tx, Ty );
		dame( AdvC, Tx, Ty )
	), 
	Ax is Tx - 1, 
	Ay is Ty + 1, 
	estVide( Ax, Ay ), 
	Ax > 0,
	Ay < 9.

mangerDroitBas( Dx, Dy, Tx, Ty, Ax, Ay ) :- 
	(
		dame( C, Dx, Dy );
		pion( C, Dx, Dy )
	), 
	adversaire(C, AdvC),
	Tx is Dx + 1, 
	Ty is Dy + 1, 
	(
		pion( AdvC, Tx, Ty );
		dame( AdvC, Tx, Ty )
	), 
	Ax is Tx + 1, 
	Ay is Ty + 1, 
	estVide( Ax, Ay ), 
	Ax < 9,
	Ay < 9.





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% noir


% Attribution des droits pour les pions noirs
noirPionManger( Dx, Dy, Tx, Ty, Ax, Ay ) :- 
	pion( n, Dx, Dy ), 
	(
		mangerGaucheHaut( Dx, Dy, Tx, Ty, Ax, Ay ); 
		mangerDroitHaut( Dx, Dy, Tx, Ty, Ax, Ay )
	).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

noirManger( Dx, Dy, Tx, Ty, Ax, Ay ) :- 
	(
		pion( n, Dx, Dy ),
		noirPionManger( Dx, Dy, Tx, Ty, Ax, Ay )
	);
	(
		dame( n, Dx, Dy ),
		dameManger( Dx, Dy, Tx, Ty, Ax, Ay )
	).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% blanc

% Attribution des droits pour les pions blancs
blancPionManger( Dx, Dy, Tx, Ty, Ax, Ay ) :- 
	pion( b, Dx, Dy ), 
	(
		mangerGaucheBas( Dx, Dy, Tx, Ty, Ax, Ay ); 
		mangerDroitBas( Dx, Dy, Tx, Ty, Ax, Ay )
	).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

blancManger( Dx, Dy, Tx, Ty, Ax, Ay ) :- 
	(
		pion( b, Dx, Dy ),
		blancPionManger( Dx, Dy, Tx, Ty, Ax, Ay )
	);
	(
		dame( b, Dx, Dy ),
		dameManger( Dx, Dy, Tx, Ty, Ax, Ay )
	).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Attribution des droits pour les dames noires ou blanches
dameManger( Dx, Dy, Tx, Ty, Ax, Ay) :- 
	dame( _, Dx, Dy ), 
	(
		mangerGaucheHaut( Dx, Dy, Tx, Ty, Ax, Ay ); 
		mangerDroitHaut( Dx, Dy, Tx, Ty, Ax, Ay );
		mangerGaucheBas( Dx, Dy, Tx, Ty, Ax, Ay );
		mangerDroitBas( Dx, Dy, Tx, Ty, Ax, Ay )
	).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ensemble

eatWhite( [ Dx, Dy ] , [ Tx, Ty ] , [ Ax, Ay ] ) :- 
	blancManger( Dx, Dy, Tx, Ty, Ax, Ay ).

checkMangerWhite( M ) :- 
	setof( Y, eatWhite( X, Y, A ), L ),
	setof( A, eatWhite( X, Y, A ), P ),
	append( L, P, T ),
	append( [ X ] , [ T ] , M ).

eatBlack( [ Dx, Dy ] , [ Tx, Ty ] , [ Ax, Ay ] ) :- 
	noirManger( Dx, Dy, Tx, Ty, Ax, Ay ).

checkMangerBlack( M ) :- 
	setof( Y, eatBlack( X, Y, A ), L ),
	setof( A, eatBlack( X, Y, A ), P ),
	append( L, P, T ),
	append( [ X ] , [ T ] , M ).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

manger( [ Dx, Dy ] , [ Tx, Ty ] , [ Ax, Ay ] ) :- 
	(
		(
			pion( n, Dx, Dy );
			dame( n, Dx, Dy)
		),
		noirManger( Dx, Dy, Tx, Ty, Ax, Ay ) 
	);
	(
		(
			pion( b, Dx, Dy );
			dame( b, Dx, Dy )
		),
		blancManger( Dx, Dy, Tx, Ty, Ax, Ay )
	).




