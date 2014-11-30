%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Positionne les pions du jeu à leur position initiale
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% --------- Pour connaitre la stratégie des joueurs 
% --------- joueur(Couleur, Stratégie, Depth) 
% -----Depth correspond à la profondeur de l arbre dans la recherche des coups suivants
% -----  Stratégie = default | defensif | avancement_max | evolutif | iaUP
joueur(n,iaUP,1).
joueur(b,defensif,0).



% --- Pour dire que ça existe et éviter des erreurs
:- dynamic(tpion/3).
:- dynamic(tdame/3).


% La couleur C est celle des pions du bas de la grille
init_pions(C):- 
	nb_getval( grid_size, Size ), 
	adversaire( C, Cadv ), 
	ajouter_haut( Cadv, Size ), 
	ajouter_bas( C, Size ).

	%on ajoute une dame pour eviter un plantage au debut du jeu
	% ---assert( dame( b, 100, 100 ) ),

	%on ajoute un pion pour eviter un plantage en fin du jeu


% Permet de déterminer l adversaire des pions noirs et des pions blancs
adversaire(n,b).
adversaire(b,n).


% On remplit la grille en mettant le 1er pion du haut dans le coin
% Donc toutes les lignes impaires doivent avoir leur 1er pion dans la 1ere case
% Donc toutes les lignes paires doivent avoir leur 1er pion dans la 2eme case
premier_pion( I, 1 ) :- 
	not( paire( I ) ).

premier_pion( I, 2 ) :- 
	paire( I ).

paire( I ) :- 
 0 is mod( I, 2 ).


% On laise un espace de 2 lignes entre les pions du haut et du bas
ajouter_haut( C, Size ) :- 
	premier_pion( 1, Ji ),
	Imax is ( Size - 2 ) / 2, 
	ajouter_pion( C, 1, Ji, Imax, Size ).

ajouter_bas( C, Size ) :- 
	Ii is ( Size - 2 ) / 2 + 3, 
	premier_pion( Ii, Ji ), 
	ajouter_pion( C, Ii, Ji, Size, Size ).


%On n ajoute plus de pions si on dépasse le nombre de lignes maximum
ajouter_pion( _, I, _, Imax, _ ) :- 
	I > Imax.


%Si le point est dans les bornes, on l'insère et on demande l'insertion du suivant sur la meme ligne
ajouter_pion( C, I, J, Imax, Jmax ) :- 
	I =< Imax, 
	J =< Jmax, 
	assert( pion( C, J, I ) ), 
	J1 is J + 2,
	ajouter_pion( C, I, J1, Imax, Jmax ).


%Si le pion n'est pas contenu dans les bornes, on l'ajoute sur  la ligne suivante
ajouter_pion( C, I, J, Imax, Jmax ) :- 
	I =< Imax, 
	J > Jmax, 
	Ii is I + 1, 
	premier_pion( Ii, Ji ),
	ajouter_pion( C, Ii, Ji, Imax, Jmax ).




