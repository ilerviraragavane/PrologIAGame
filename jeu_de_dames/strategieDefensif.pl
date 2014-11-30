%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Module de la stratégie defensive
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

copyContext :- 
	% ------ On utilise tpion( , , ) et tdame( , , ) pour simuler l etat apres un movement
	% ------ On cherche les pion et dame à sauvegarder
	findall(tpion(Cp,Xp,Yp),pion(Cp,Xp,Yp),L1),
	findall(tdame(Cd,Xd,Yd),dame(Cd,Xd,Yd),L2),
	% ------- On sauvegarde les pions et dames dans tpions et tdames
	forall(member(S1,L1),assert(S1)), forall(member(S2,L2),assert(S2)).
	
clean :-
	% ----- Prédicat pour d¨¦truire tous les tpion et tdame
	retractall(tpion(_,_,_)),
	retractall(tdame(_,_,_)).
	
% ----- Predicat pour detruire l'objet mange
detruireObjetMange(Dx,_,Ax,_) :- abs(Dx-Ax) =:= 1.
detruireObjetMange(Dx,Dy,Ax,Ay) :- abs(Dx-Ax) =:= 2, Tx is (Dx+Ax)/2, Ty is (Dy+Ay)/2, retract(tdame(_,Tx,Ty)).
detruireObjetMange(Dx,Dy,Ax,Ay) :- abs(Dx-Ax) =:= 2, Tx is (Dx+Ax)/2, Ty is (Dy+Ay)/2, retract(tpion(_,Tx,Ty)).

% ----- Predicat pour verifier si une position est au board ou au coin ou ni l'un ni l'autre.
etreACote(Ax,Ay) :- Ax=1;Ax=8;Ay=1;Ay=8.

% ----- Predicat principal qui, selon la philosophie defensif, retourne une valeur pour chaque possibilite de movement.
value_defensif(Player, Value, (Dx,Dy,Ax,Ay)) :- 
	
	% ----- Nous d¨¦truissions tous les tpion/3 et tdams/3
	clean,
	
	% ----- Nous copier tous les pion/3 dans tpio/3 et tous les dame/3 dans tdame/3
	copyContext,
	
	% ------- Nous simulons le movement
	% ---- Nous d¨¦truissons l'Objet mang¨¦ au cas o¨´ ce movement est un manger
	detruireObjetMange(Dx,Dy,Ax,Ay),	
	
	% ---- Nous changeons la position de notre tpion ou tdame
	(tpion(Player,Dx,Dy) -> 
	
		(assert(tpion(Player,Ax,Ay)),retract(tpion(Player,Dx,Dy)))
		;
		(assert(tdame(Player,Ax,Ay)),retract(tdame(Player,Dx,Dy)))
							
	),
	
	% ------ Nous trouvons tous les possibilite de ¨ºtre mang¨¦
	findall(position(Xt,Yt),(tpion(Player,Xt,Yt),t_manger( [ _, _ ] , [ Xt, Yt ] , [ _, _ ] )),L_dangerous_tpion),
	findall(position(Xt,Yt),(tdame(Player,Xt,Yt),t_manger( [ _, _ ] , [ Xt, Yt ] , [ _, _ ] )),L_dangerous_tdame),	
	
	length(L_dangerous_tpion, N1),
	length(L_dangerous_tdame, N2),
	
	% ------- On regarde si le pion va vers un bord. Si c'est le cas, on ajoute 20 pour la valeur finale, sinon on n'ajoute rien.
	(etreACote(Ax,Ay) -> Value2 is 20; Value2 is 0),
	
	% ----- Pour la valeur, si ce movement est un manger, nous ajoutons 3 points
	% ----- Si ce movement est d'aller au board ou coin, nous ajoutons 20 points
	% ----- Pour chaque possibilit¨¦ d'un poin d'¨ºtre mang¨¦, nous soustrayons 1 point
	% ----- Pour chaque possibilit¨¦ d'une dame d'¨ºtre mang¨¦, nous soustrayons 1 point
	Value is ((abs(Dx-Ax)-1)*3 + N1 * (-1) + N2 * (-2)) + Value2,
	
	% ----- On d¨¦truit tous les tpions et les tdames
	clean.
	
	
	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ----- copie de code de manger pour les tpion et tdame %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Droits de t_manger

t_adversaire(b, n).
t_adversaire(n, b).

t_estVide( X, Y ) :- 
	not( tpion( _, X, Y ) ),
	not( tdame( _, X, Y ) ).


t_mangerGaucheHaut( Dx, Dy, Tx, Ty, Ax, Ay ) :- 
	(
		tdame( C, Dx, Dy );
		tpion( C, Dx, Dy )
	), 
	t_adversaire(C, AdvC),
	Ty is Dy - 1, 
	Tx is Dx - 1, 
	(
		tpion( AdvC, Tx, Ty );
		tdame( AdvC, Tx, Ty )
	), 
	Ax is Tx - 1, 
	Ay is Ty - 1, 
	t_estVide( Ax, Ay ), 
	Ax > 0,
	Ay > 0.

t_mangerDroitHaut( Dx, Dy, Tx, Ty, Ax, Ay ) :- 
	(
		tdame( C, Dx, Dy );
		tpion( C, Dx, Dy )
	), 
	t_adversaire(C, AdvC),
	Tx is Dx + 1, 
	Ty is Dy - 1, 
	(
		tpion( AdvC, Tx, Ty );
		tdame( AdvC, Tx, Ty )
	), 
	Ax is Tx + 1, 
	Ay is Ty - 1, 
	t_estVide( Ax, Ay ), 
	Ax < 9,
	Ay > 0.

t_mangerGaucheBas( Dx, Dy, Tx, Ty, Ax, Ay ) :- 
	(
		tdame( C, Dx, Dy );
		tpion( C, Dx, Dy )
	), 
	t_adversaire(C, AdvC),
	Tx is Dx - 1, 
	Ty is Dy + 1, 
	(
		tpion( AdvC, Tx, Ty );
		tdame( AdvC, Tx, Ty )
	), 
	Ax is Tx - 1, 
	Ay is Ty + 1, 
	t_estVide( Ax, Ay ), 
	Ax > 0,
	Ay < 9.

t_mangerDroitBas( Dx, Dy, Tx, Ty, Ax, Ay ) :- 
	(
		tdame( C, Dx, Dy );
		tpion( C, Dx, Dy )
	), 
	t_adversaire(C, AdvC),
	Tx is Dx + 1, 
	Ty is Dy + 1, 
	(
		tpion( AdvC, Tx, Ty );
		tdame( AdvC, Tx, Ty )
	), 
	Ax is Tx + 1, 
	Ay is Ty + 1, 
	t_estVide( Ax, Ay ), 
	Ax < 9,
	Ay < 9.





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% noir


% Attribution des droits pour les pions noirs
t_noirPionManger( Dx, Dy, Tx, Ty, Ax, Ay ) :- 
	tpion( n, Dx, Dy ), 
	(
		t_mangerGaucheHaut( Dx, Dy, Tx, Ty, Ax, Ay ); 
		t_mangerDroitHaut( Dx, Dy, Tx, Ty, Ax, Ay )
	).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

t_noirManger( Dx, Dy, Tx, Ty, Ax, Ay ) :- 
	(
		tpion( n, Dx, Dy ),
		t_noirPionManger( Dx, Dy, Tx, Ty, Ax, Ay )
	);
	(
		tdame( n, Dx, Dy ),
		t_dameManger( Dx, Dy, Tx, Ty, Ax, Ay )
	).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% blanc

% Attribution des droits pour les pions blancs
t_blancPionManger( Dx, Dy, Tx, Ty, Ax, Ay ) :- 
	tpion( b, Dx, Dy ), 
	(
		t_mangerGaucheBas( Dx, Dy, Tx, Ty, Ax, Ay ); 
		t_mangerDroitBas( Dx, Dy, Tx, Ty, Ax, Ay )
	).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

t_blancManger( Dx, Dy, Tx, Ty, Ax, Ay ) :- 
	(
		tpion( b, Dx, Dy ),
		t_blancPionManger( Dx, Dy, Tx, Ty, Ax, Ay )
	);
	(
		tdame( b, Dx, Dy ),
		t_dameManger( Dx, Dy, Tx, Ty, Ax, Ay )
	).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Attribution des droits pour les dames noires ou blanches
t_dameManger( Dx, Dy, Tx, Ty, Ax, Ay) :- 
	tdame( _, Dx, Dy ), 
	(
		t_mangerGaucheHaut( Dx, Dy, Tx, Ty, Ax, Ay ); 
		t_mangerDroitHaut( Dx, Dy, Tx, Ty, Ax, Ay );
		t_mangerGaucheBas( Dx, Dy, Tx, Ty, Ax, Ay );
		t_mangerDroitBas( Dx, Dy, Tx, Ty, Ax, Ay )
	).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%ensemble

t_eatWhite( [ Dx, Dy ] , [ Tx, Ty ] , [ Ax, Ay ] ) :- 
	t_blancManger( Dx, Dy, Tx, Ty, Ax, Ay ).

t_checkMangerWhite( M ) :- 
	setof( Y, t_eatWhite( X, Y, A ), L ),
	setof( A, t_eatWhite( X, Y, A ), P ),
	append( L, P, T ),
	append( [ X ] , [ T ] , M ).

t_eatBlack( [ Dx, Dy ] , [ Tx, Ty ] , [ Ax, Ay ] ) :- 
	t_noirManger( Dx, Dy, Tx, Ty, Ax, Ay ).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

t_manger( [ Dx, Dy ] , [ Tx, Ty ] , [ Ax, Ay ] ) :- 
	(
		(
			tpion( n, Dx, Dy );
			tdame( n, Dx, Dy)
		),
		t_noirManger( Dx, Dy, Tx, Ty, Ax, Ay ) 
	);
	(
		(
			tpion( b, Dx, Dy );
			tdame( b, Dx, Dy )
		),
		t_blancManger( Dx, Dy, Tx, Ty, Ax, Ay )
	).