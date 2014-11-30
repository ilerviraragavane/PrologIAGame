%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Fichier d initialisation du jeu
%% Module principale du jeu de dames
%% H4103 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2 constantes sont définies :
%	- grid_size = taille de la grille
%	- player = le joueur courant
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:- [initPions].
:- [display].
:- [keyboard].
:- [state].
:- [endGame].

:- dynamic(dame/3).
:- dynamic(sdame/4).

%------------------
% On définit la taille de la grille, et on génère les pions, puis on initialise les variables
% de l\état de jeu
initBoard :- 
	nb_setval(grid_size,8),
	nb_setval(n_tours,0),
    retractall(pion(_,_,_)), 
    retractall(dame(_,_,_)),
	init_pions(n), 
	majState.	
%------------------

% Initialisation d un joueur (pion blanc)
% Initialisation du nomnbre de pions de chaque joueur
initPlayer :- nb_setval(player,b).

% On change de joueur
nextTurn :- nb_getval(player,Player), 
			adversaire(Player, Adv), 
			nb_setval(player,Adv).


start :- 	
	nb_setval(start,start),
	% On crée les pions
	initBoard,

	% On définit un joueur 
	initPlayer,


	% On initialise la vue
	init_afficher(run).


run :- 
	% Affiche qui est en train de jouer
	afficher_joueur,

	% Demande une position de départ
	askStartPosition(D), %D est le couple de coordonnées de départ

	% Demande une position d arrivée
	askEndPosition(A), %A est le couple de coordonnées d arrivée

	% On vérifie si le coup est possible, et on redemande la saisie si le coup était invalide
	nb_getval(player, C), 
	canPlayList(L,C),
	checkHit(D,A,L,R), 
	
	% On applique le coup
	write('Le coup est faisable'),
	nl,
	faireAction(R),
	majState,

	%Mise à jour de la grille 
	afficher,

	% On change de joueur
	nextTurn.



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Jeu entre deux IA
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
:- [ia_actions].
:- [strategie2].

startIA :- 
	nb_setval(start,startIA),
	initBoard, 
	initPlayer,
	init_afficher(runIA).


runIA :-

	% Affiche qui est en train de jouer
	afficher_joueur,
	
	% On cherche le coup à jouer
	nb_getval(player, C), 
	not(gameOver(C)),
	(joueur(C,random,_) -> choose_move(random,Move);choose_move(C, Move)),
	
	faireAction(Move),
	majState,

	% On affiche la grille
	afficher,
	
	not(drawGame),
	
	% On change de joueur
	nextTurn.



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Jeu pour les statistiques
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

startStats :- 
	nb_setval(start,startIA),
	initBoard, 
	initPlayer,
	%init_afficher(runStats),
	runStats.
	%nl.


runStats :-
	nb_getval(player, C), 
	(
		gameOverStats(C) ; 
		drawGameStats
	),
	!.

runStats :-
	nb_getval(player, C), 
	(joueur(C,random,_) -> choose_move(random,Move);choose_move(C, Move)),
	

	faireAction(Move),
	majState,
	
	% On change de joueur
	nextTurn,

	runStats.



