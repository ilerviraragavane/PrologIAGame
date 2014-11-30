%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Ce fichier contient les predicats 
% concernant le choix du prochain mouvement de l'IA avec amélioration dans le parcours de l'arbre
% Au lieu d'évaluer uniquement les feuilles de l'arbre à une certaine profondeur, on calcule la somme 
% des evaluations des noeuds visités pour garder la pire valeur pour un mouvement
% A la fin on regarde quel mouvement à la meilleur valeur pour maximiser au mieux le gain
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:- [canPlay].

	
choose_moveUP(Player, Move) :-

	% -------- sauvegarde du nombre de tours sans manger pour la fin du jeu
	nb_getval(n_tours,N_tours), nb_setval(s_n_tours, N_tours),
	canPlayList(Moves, Player),
	joueur(Player,iaUP,Depth),
	evaluate_and_chooseUP(Player,Moves,Depth,1,((0,0,0,0),-1000),(Move,_), 0, _, Depth),
	
	% -------- restauration du nombre de tours sans manger pour la fin du jeu
	nb_getval(s_n_tours,SN_tours), nb_setval(n_tours, SN_tours),!.		
	


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Evalue tous les mouvements possibles (Moves) de Player en simulant jusqu'a une profondeur Depth
% Best sera le meilleur coup retenu et sera retenu en gardant la meilleur somme trouvé
evaluate_and_chooseUP(Player,Moves1, Depth, Maxmin, Record, Best,Value, PireSomme,DStart) :-
	Moves1 \= [],
	selectAlea(Move, Moves1), element3(Move,Moves1,Moves2),
	init_simulation(Depth), 
	minimaxUP(Player,Depth, Maxmin, Move, Value,PireSomme,DStart),
	updateUP(Move, PireSomme, Record, Newrecord,Depth, DStart),
	restore_base(Depth),
	evaluate_and_chooseUP(Player,Moves2, Depth, Maxmin, Newrecord, Best, 0, _,DStart).

evaluate_and_chooseUP(_,[], _, _, (M,S), (M,S),_, S,_).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Permet de donner une ponderation au feuille à la profondeur donnée 
% dans evaluate_and_choose
% Maxmin permettra de savoir si c'est un coup de l'adversaire ou notre coup qui est joué
% PireSomme sera la pire somme de tous les noeuds evalués jusqu'à une profondeur donnée pour un chemin
minimaxUP(Player,0, Maxmin, Move, Value, PireSomme,_) :-
	valueUP(Player, V,Move),	
	V2 is Maxmin*V,
	SommeRes is V2 + Value,
	nonvar(PireSomme),
	((PireSomme > SommeRes, PireSomme is SommeRes);(PireSomme =< SommeRes)).
	
minimaxUP(Player,0, Maxmin, Move, Value, PireSomme,_) :-
	valueUP(Player, V,Move),	
	V2 is Maxmin*V,
	SommeRes is V2 + Value,
	var(PireSomme), PireSomme is SommeRes.

/* Maxmin permettra de savoir si c'est un coup de l'adversaire ou notre coup qui est joué */
minimaxUP(Player,Depth, Maxmin, Move, Value, PireSomme,DStart) :-
	Depth > 0, 
	% -------on  évalue le mouvement a ce noeud et on ajoute cette valeur à la somme en cours (Value)
	valueUP(Player,  V, Move), Somme is Maxmin*V + Value,
	faireAction(Move), 
	next_turn_simul(Player, Maxmin, NPlayer),
	Depth2 is Depth-1,
	Minmax is -Maxmin,
	% --------on est obligé de faire un test car canPlayList retourne 'false' si pas de mouvement possible
	(canPlayList(Moves, NPlayer) -> 
		evaluate_and_chooseUP(Player,Moves, Depth2, Minmax, ((0,0,0,0),-1000), _, Somme, PireSomme,DStart);
		evaluate_and_chooseUP(Player,[], Depth2, Minmax, (Move,Somme), _, Somme, PireSomme,DStart)).
	

updateUP(_, _, _, _, D, DStart) :-
	not(D =:= DStart).
/* On ne met pas à jour*/
updateUP(_, PireSomme, (Move1,Value1),(Move1,Value1),D, DStart) :-
	D =:= DStart,
	PireSomme =< Value1.
/* On met à jour */
updateUP(Move, PireSomme, (_,Value1),(Move,PireSomme),D, DStart) :-
	D =:= DStart,
	PireSomme > Value1.
	
	
	
% ----valueUP utilisé par défaut
valueUP(_, V,(Ax,Ay,Dx,Dy)) :- 
	(Mx is ( Ax + Dx ) / 2, 
	My is ( Ay + Dy ) / 2),
	((pion(C,Mx,My) -> V is 1; V is 0) ;
	(dame(C,Mx,My) -> V is 2; V is 0)). 

	