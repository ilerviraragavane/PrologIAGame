%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Module permettant de retourner la liste des coups possibles et d'effectuer un mouvement
% en modifiant la base de faits du jeu
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:- [manger].
:- [move].


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% canPlayList : retourne la liste L qui contient tous les coups
%		qui sont jouables

canPlayList( L, Color ) :- 
		( Color == b, canPlayWhiteList( L ) );
		( Color == n, canPlayBlackList( L ) ).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% canEatBlack : retourne une action manger possible avec l état actuel du jeu noir
canEatBlack( ( Dx, Dy, Ax, Ay ) ) :- 
	eatBlack( [ Dx, Dy ] , [ _, _ ] , [ Ax, Ay ] ).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% canMoveBlack : retourne une action déplacer possible avec l état actuel du jeu noir
canMoveBlack( ( Dx, Dy, Ax, Ay ) ) :- 
	checkMoveB([Dx,Dy],[Ax,Ay]).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% canEatWhite : retourne une action manger possible avec l état actuel du jeu blanc
canEatWhite( ( Dx, Dy, Ax, Ay ) ) :- 
	eatWhite( [ Dx, Dy ] , [ _, _ ] , [ Ax, Ay ] ).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% canMoveWhite : retourne une action déplacer possible avec l état actuel du jeu lanc
canMoveWhite( ( Dx, Dy, Ax, Ay ) ) :- 
	checkMoveW( [ Dx, Dy ] , [ Ax, Ay ] ).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% canPlayWhiteList : retourne une liste des actions possible avec l état actuel du jeu blanc,
%		Si on peut manger, alors on retourne que les coups manger
%		Sinon on retourne les coups de déplacement
canPlayWhiteList( L ) :- 
	setof( K, canEatWhite( K ), L ),
	!.

canPlayWhiteList( L ) :- 
	setof( K, canMoveWhite( K ), L ).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% canPlayBlackList : de même que ci-dessus pour le jeu noir
canPlayBlackList( L ) :- 
	setof( K, canEatBlack( K ), L ),
	!.

canPlayBlackList( L ) :- 
	setof( K, canMoveBlack( K ), L ).





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% faireAction : permet d appliquer un coup (passé en paramètre)
% 	Dx/Dy : Position de départ
% 	Ax/Ay : Position d arrivée

% Dans le cas où on mange un autre pion
faireAction( ( Dx, Dy, Ax, Ay ) ) :- 
	Mx is ( Ax + Dx ) / 2, 
	My is ( Ay + Dy ) / 2,
	( 	
		( 
			pion( Cm, Mx, My ),
			retract( pion( Cm, Mx, My ) ) 
		) ; (
			dame( Cm, Mx, My ), 
			retract( dame( Cm, Mx, My ) )
		)  
	) ,
	(
		deplacerPion( C, Dx, Dy, Ax, Ay );
		deplacerDame( C, Dx, Dy, Ax, Ay )
	),nb_setval(n_tours,0).

% Dans le cas où on déplace seulement un pion
faireAction( ( Dx, Dy, Ax, Ay ) ) :- 
	Mx is ( Ax + Dx ) / 2, 
	My is ( Ay + Dy ) / 2, 
	not( pion( Cm, Mx, My ) ),
	not( dame( Cm, Mx, My ) ), 
	( 
		(deplacerPion( C, Dx, Dy, Ax, Ay ), nb_setval(n_tours,0));
		(deplacerDame( C, Dx, Dy, Ax, Ay ),nb_getval(n_tours,N),N1 is N+1,nb_setval(n_tours,N1))
	). 




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% deplacerPion : déplace un pion, et le transforme
% 		en dame s il le faut.
% deplacerDame : deplace une dame

deplacerPion( C, Dx, Dy, Ax, Ay ) :-
	pion( C, Dx, Dy ),
	retract( pion( C, Dx, Dy ) ),
	nb_getval(grid_size,GridSize),
	(
		( 
			( C = n , Ay = 1 );
			( C = b , Ay = GridSize )
		) ->
		(
			% le pion passe en dame
			assert( dame( C, Ax, Ay ) )
		);
		(
			% le pion reste pion
			assert( pion( C, Ax, Ay ) )
		)
	).

deplacerDame( C, Dx, Dy, Ax, Ay ) :-
	dame( C, Dx, Dy ),
	retract( dame( C, Dx, Dy ) ),
	assert( dame( C, Ax, Ay) ).
