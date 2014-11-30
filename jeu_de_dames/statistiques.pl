%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 				  STATISTIQUE				%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Prédicat d importation
:- [main].

%Prédicat de lancement des statistiques pour les 2 IAs renseignées dans le fichier initPions.pl avec un nombre de parties 
goStats :- 
	Nombre_de_parties = 1,
	tell('stats.txt'), 
	write('n\tb'),
	nl,
	statistique(Nombre_de_parties),
	told. 

%Lorsque le nombre de partie a été atteint
statistique(0):-!.

%Prédicat principal de statistique
statistique(NombrePartie) :- 
	startStats, 
	NewNombrePartie is NombrePartie - 1, 
	statistique( NewNombrePartie ).