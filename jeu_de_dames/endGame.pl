% GameOver est a utilisé au debut du tour de chaque joueur. Si il retourne vrai , le joueur courant a perdu
% DrawGame est a utilisé a la fin du tour juste avant que l on passe la main au joueur adverse. si cela retourne vrai MATCH NULL
% il faut donc utiliser not(GameOver()) et not(drawGame() )

gameOver( Couleur ) :- 
	(
		not( pion( Couleur ,_,_) ; dame( Couleur ,_,_) );
		not(canPlayList( _, Couleur ))
	),
	adversaire(Couleur, CouleurAdv),
	( 
		(CouleurAdv == n, C = noir ) ;
		(CouleurAdv == b, C = blanc )
	),
	string_concat( 'Le joueur ', C, Temp ),
	string_concat( Temp, ' a gagne.', Text ),
	displayResultGame( Text ).

	
% Affichage de la fin du jeu pour les statistiques
gameOverStats( Couleur ) :- 
	(
		not( pion( Couleur ,_,_) ; dame( Couleur ,_,_) );
		not(canPlayList( _, Couleur ))
	),
	adversaire(Couleur, CouleurAdv),
	( 
		(CouleurAdv == n, C = noir ) ;
		(CouleurAdv == b, C = blanc )
	),
	(
		CouleurAdv == n ->
		(
			write('1\t0')
		);(
			write('0\t1')
		)
	),
	nl.


% Affiche le résultat (Message) du jeu dans une fenêtre
displayResultGame( Message ) :-
	nb_getval( window, Window ),
	free( Window ),

	new(Window, dialog('Jeu de dames - resultat')),
	send(Window, size, size(300,100)),

	send(Window, display, new(_, text(Message)), point(50,5)),
	send(Window, display, button('Rejouer', message(@prolog, restart)), point(100,50)),
	send(Window, display, button('Quitter', message(Window, destroy)), point(200,50)),
	send(Window, open(point(100,100))).

			
% Affiche le résultat en cas de match nul
drawGame :- 
	nb_getval( n_tours, N ), 
	N >= 25, 
	dameVSdame,
	displayResultGame( 'MATCH NUL' ), 
	nl.


% Affiche le résultat en cas de match nul pour les statistiques		
drawGameStats :- 
	nb_getval( n_tours, N ), 
	N >= 25, 
	dameVSdame,
	write('1\t1'), 
	nl.		

% Teste si le jeu compte uniquement des dames
dameVSdame :- 
	nbDame( n, A ),
	nbDame( b, B ), 
	A >= 1, 
	B >= 1.

% Compte le nombre de dames d une couleur C
nbDame( C, R ) :- 
	findall( dame(C,X,Y), dame(C,X,Y), L ),
	length( L, R ).


% Action du bouton rejouer présent sur la fenêtre affichant le résultat du jeu
restart :- 
	nb_getval( start, Start ),
	nb_getval( window, WindowTemp ),
	free( WindowTemp ),
	Start.