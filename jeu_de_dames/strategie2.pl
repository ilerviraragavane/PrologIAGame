%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%			Stratégie 2 :
%
%
%	on cherche à avancer au maximum.
%	
%	Plus un pion est loin d être une dame 
%		(nombre de coups à jouer en cas de plateau vide)
%		plus il est prioritaire 
%	



% Point d entrée
value_avancement(Player,Value,(Dx,Dy,Ax,Ay)) :-
	adversaire(Player, Adv),
	findall( [X1,Y1] , pion( Adv, X1, Y1) , L1),
	findall( [X1,Y1] , dame( Adv, X1, Y1) , L2),
	append( L1, L2, L),
	distance( Player, L, Dx, Dy, Ax, Ay, V1 ),

	% Bloque le fait d aller se faire manger
	trouverDistancePlusProcheAdversaire([Ax,Ay], L, T),
	(
		T == 1 ->
		(
			nb_getval( grid_size, Size ),
			Value is V1 - 2*Size
		);(
			Value = V1
		)
	).


% Prédicat qui retourne la distance D d un pion positionné en (X,Y) du Player par rapport à la Stratégie (nombre de coups pour être une dame)

% Pour un pion
distance( Player, L, X, Y, _ ,_ ,  D ) :-
	pion( Player, X, Y ),
	nb_getval( grid_size, Size ),
	(
		(
			Player == b,
			DTemp is Size - Y
		);
		(
			Player == n,
			DTemp is Y - 1
		)
	),

	% Permet de fuir un pion ennemi
	trouverDistancePlusProcheAdversaire([X,Y], L, T),
	(
		T == 1 ->
		(
			nb_getval( grid_size, Size ),
			D is Size + 1
		);(
			D = DTemp
		)
	).

% Pour une dame, la stratégie est différente, on se dirige vers le pion le plus proche.
distance( Player, L, X, Y, Ax, Ay, D ) :-
	dame( Player, X, Y),
	nb_getval( grid_size, Size ),
	trouverDistancePlusProcheAdversaire([Ax,Ay], L, TA),
	trouverDistancePlusProcheAdversaire([X,Y], L, T),
	(
		T = 2 ->
		(
			D is Size - T - 3
		);
		(
			TA < T ->
			D is Size - T + 6;
			D is Size - T + 1
		)
	).


% Retourne la distance Min du plus proche adversaire parmis la liste (3eme paramètre) pour un pion placé en [X1,Y1]

trouverDistancePlusProcheAdversaire( [X1, Y1], [[X2,Y2]|Q], Min ) :- 
	trouverDistancePlusProcheAdversaire( [X1, Y1], Q, D2 ),
	D1 is (abs( X2 - X1 ) + abs( Y2 - Y1 ))/2,
	Min is min(D1, D2).

trouverDistancePlusProcheAdversaire( [X1, Y1], [[X2,Y2]], Min ) :- 
	Min is (abs( X2 - X1 ) + abs( Y2 - Y1 ))/2.

