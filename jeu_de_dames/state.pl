%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Permet de surveiller l'état du jeu  à travers le nombre de pions et de dames de chaque 
% joueur
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% On est obligé de recalculer à chaque fois le nombre de pions et dames 
% plutôt que de modifier le nombre à chaque action, car les IA réutilisent faireAction 
% pour simuler les coups futurs


%%%%%%%
% Actualise les compteurs du nombre de pions et dames pour chaque joueur
majState :-  majNbPionsEtDames(b), majNbPionsEtDames(n).

%%%%%%%
% Efface l état du jeu
cleanState :- retractall(state(_,_,_)).

%%%%%%%
% Lance le calcul du nombre de pions et de dames pour une couleur
majNbPionsEtDames(C) :- compter_pions(C, NbPions), compter_dames(C, NbDames),
							retractall(state(C,_,_)),assert(state(C,NbPions,NbDames)).

%%%%%%% 
% Compte les pions pour une couleur
compter_pions(C, Nb) :- findall(C, pion(C,_,_), L),
						length(L, Nb).
compter_dames(C, Nb) :- findall(C, dame(C,_,_), L),
						length(L, Nb).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Test
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

addPions :- assert(pion(b,2,3)), assert(pion(b,3,3)), assert(pion(n,6,7)), assert(dame(n,3,4)).
cleanPions :- retractall(pion(_,_,_)), retractall(dame(_,_,_)).
testMajState :-	cleanPions, addPions, 
				majState, 
				listing(state),
				%write('supprime un pion blanc et une dame noire'),nl,
				retract(pion(b,2,3)),
				retract(dame(n,3,4)),
				majState,
				listing(state).

