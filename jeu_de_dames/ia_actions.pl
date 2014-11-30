%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Ce fichier contient les predicats 
% concernant le choix du prochain mouvement de l'IA
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:- [canPlay].
:- [strategieDefensif].
:- [strategieEvolutive].
:- [ia_actionsUP].


choose_move(random, Move) :-
	randomMove(Move).
choose_move(Player, Move) :-
	% -------- sauvegarde du nombre de tours sans manger pour la fin du jeu
	nb_getval(n_tours,N_tours), nb_setval(s_n_tours, N_tours),
	canPlayList(Moves, Player),
	joueur(Player,Strategy,Depth),Strategy \= random,
	(joueur(Player, iaUP,Depth) -> 
			evaluate_and_chooseUP(Player,Moves,Depth,1,((0,0,0,0),-1000),(Move,_), 0, _, Depth);
			evaluate_and_choose(Player,Moves,Depth,1,((0,0,0,0),-1000),(Move,_),_)), 
	% -------- restauration du nombre de tours sans manger pour la fin du jeu
	nb_getval(s_n_tours,SN_tours), nb_setval(n_tours, SN_tours),
	!.		
	

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Evalue tous les mouvements possibles (Moves) de Player en simulant jusqu'a une profondeur Depth
% Best sera le meilleur coup retenu
evaluate_and_choose(Player,Moves1, Depth, Maxmin, Record, Best,Value) :-
	Moves1 \= [],
	selectAlea(Move, Moves1), element3(Move,Moves1,Moves2),
	init_simulation(Depth),
	minimax(Player,Depth, Maxmin, Move, Value), 
	update(Move, Value, Record, Newrecord),
	restore_base(Depth),									
	evaluate_and_choose(Player,Moves2, Depth, Maxmin, Newrecord, Best, _).

evaluate_and_choose(_,[], _, _, Record, Record,_).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Permet de donner une ponderation au feuille à la profondeur donnée 
% dans evaluate_and_choose
% Maxmin permettra de savoir si c'est un coup de l'adversaire ou notre coup qui est joué
minimax(Player,0, Maxmin, Move, Value) :-
	joueur(Player,evolutif,_),
	(Maxmin =:= 1 ->
			chooseStrategy(S), value(Player,S, V,Move);
			value(Player,default,V,Move)
	),
	Value is Maxmin*V.
	
minimax(Player,0, Maxmin, Move, Value) :-
	joueur(Player,Strategy,_), Strategy \= evolutif,
	(Maxmin =:= 1 ->
		value(Player,Strategy, V,Move);
		value(Player,default,V,Move)
	),
	Value is Maxmin*V.

minimax(Player,Depth, Maxmin, Move, Value) :-
	Depth > 0, 
	faireAction(Move),
	next_turn_simul(Player, Maxmin, NPlayer),
	Depth2 is Depth-1,
	Minmax is -Maxmin,
	(canPlayList(Moves, NPlayer) -> 
		evaluate_and_choose(Player,Moves, Depth2, Minmax, ((0,0,0,0),-1000), _, Value);
		(var(Value)-> 
				value(Player,default,Value,Move),
				evaluate_and_choose(Player,[], Depth2, Minmax, (Move,Value), _, Value);
				evaluate_and_choose(Player,[], Depth2, Minmax, (Move,Value), _, Value))).
	
update(_, Value, (Move1,Value1),(Move1,Value1)) :-
	Value =< Value1.
update(Move, Value, (_,Value1),(Move,Value)) :-
	Value > Value1.
	
% --- strategie defensive
value(Player,defensif, V,(Dx,Dy,Ax,Ay)) :- 
	value_defensif(Player,V,(Dx,Dy,Ax,Ay)).
	
% --- strategie avancement max
value(Player,avancement_max, V,(Dx,Dy,Ax,Ay)) :-
	value_avancement(Player,V,(Dx,Dy,Ax,Ay)).

% ----value utilisé par défaut
value(_, default,V,(Dx,Dy,Ax,Ay)) :- 
	(Mx is ( Ax + Dx ) / 2, 
	My is ( Ay + Dy ) / 2),
	((pion(C,Mx,My) -> V is 1; V is 0) ;
	(dame(C,Mx,My) -> V is 2; V is 0)). 

	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Outils pour le fonctionnement des différents IA
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

selectAlea(Element,Liste) :- length(Liste,X),X2 is X+1, ( X2 \= 1 -> random(1,X2,Alea) ; Alea = 1 ), nth1(Alea,Liste,Element).

% -------- sauvegarde de l'état du jeu en cours dans spion
init_simulation(Depth) :- 
	% ------- on nettoie d'abord la base
	retractall(spion(_,_,_,Depth)), 
	retractall(sdame(_,_,_,Depth)),
	% ------ on cherche les pion et dame à sauvegarder pour le niveau Depth
	findall(spion(N,X,Y,Depth),pion(N,X,Y),L1),
	findall(sdame(DN,DX,DY,Depth),dame(DN,DX,DY),L2),
	% ------- on sauvegarde les pions et dames dans spion et sdame
	forall(member(S1,L1),assert(S1)), forall(member(S2,L2),assert(S2)).
	
% ------- Restauration de l'état du jeu après la calcul
restore_base(Depth) :- 
	% ------- on nettoie d'abord la base
	retractall(pion(_,_,_)), 
	retractall(dame(_,_,_)), 
	% ------ on cherche les spion et sdame sauvegardé pour le niveau Depth
	findall(pion(N,X,Y),spion(N,X,Y,Depth),L1),
	findall(dame(DN,DX,DY),sdame(DN,DX,DY,Depth),L2), 
	% ------- on restore les pions et dames
	forall(member(S1,L1),assert(S1)), forall(member(S2,L2),assert(S2)).
	
randomMove(Move) :- nb_getval( player, Color), canPlayList(L, Color), selectAlea(Move,L).


% -- Simulation du next turn pour le parcours de l'arbre
next_turn_simul(Player, Maxmin, NextPlayer) :- (
				(((Player == n, Maxmin == 1);(Player == b, Maxmin == -1)), NextPlayer = b);
				(((Player == b, Maxmin == 1);(Player == n, Maxmin == -1)), NextPlayer = n)),!.
				

/*Supprime toutes les occurences X d'une liste*/
element3(_,[],[]).
element3(X,[X|Q],R) :- element3(X,Q,R).
element3(X,[T|Q],[T|R]) :- T \= X, element3(X,Q,R).
