%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Permet de faire évoluer les stratégies mises en oeuvers en fonction de l'état du jeu
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Détermine quelle stratégie adopter pour le prochain coup
% Liste des stratégies :
% random,  defensive, avancement_max, evolutive
%
% chooseStrategy devra être appelée avant le choix de l'action à faire par un joueur 
% dans le cas de l'utilisation de la stratégie évolutive

/*Predicat principal du module*/
chooseStrategy(S) :- nb_getval(player, Player), countNbPionsTotal(Player, NbP), 
						adversaire(Player,Adv), countNbPionsTotal(Adv, NbAdv),
						evaluateBestStrategy(NbP, NbAdv, S).

/*Décompte des pions en donnant un poids supplémentaires pour les dames*/
countNbPionsTotal(C, Nb) :- state(C, NbPions, NbDames), Nb is NbPions+NbDames*2.


%--------------
%/*Si il y au moins 2 pions de plus chez le joueur adverse,
% on passe en stratégie defensif	*/
evaluateBestStrategy(NbP, NbAdv, S) :- NbP < NbAdv - 1 , 
										S = defensif.
/*Sinon
% on passe en stratégie avancement_max*/
evaluateBestStrategy(NbP, NbAdv, S) :- 
										NbP >= NbAdv - 1 , 
										S = avancement_max.	
	

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Tests
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
testCount :- assert(state(n,8,1)) , assert(state(b,4,5)),
				countNbPionsTotal(n, NbN), write('nb pions n : '), write(NbN),nl,
				countNbPionsTotal(b, NbB), write('nb pions b : '), write(NbB),nl.

setContext :- retractall(adversaire(_,_)), retractall(state(_,_,_)), 
				assert(adversaire(n,b)), assert(adversaire(b,n)), 
				nb_setval(player, n).	
testEgalite(S) :- setContext, assert(state(n,8,1)) , assert(state(b,4,5)),chooseStrategy(S).

testOffensive(S) :- setContext,assert(state(n,8,1)) , assert(state(b,2,0)),chooseStrategy(S).

testDefensive1(S) :- setContext, assert(state(n,1,0)) , assert(state(b,2,0)),chooseStrategy(S).

testDefensive2(S) :- setContext, assert(state(n,2,0)) , assert(state(b,6,0)),chooseStrategy(S).