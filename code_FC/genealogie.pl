/*Humain Homme ou femme, de nom 'paul'*/
humain(h,paul). 
humain(f,pauline).
humain(h,jack).
humain(f,jackie).
humain(f,julie).
humain(f,cindy).
humain(f,jane).
humain(h,pierre).

/*Liens de parenté (parent,enfant)*/
parent(paul,pauline). 
parent(paul,jackie).
parent(jack,paul).
parent(cindy,paul).
parent(jack,jane).
parent(cindy,jane).
parent(jack,pierre).
/*parent(cindy,pierre).*/
parent(julie,pauline).

/*Test des liens de parentés existants*/
est_parent(X,Y) :- parent(X,Y).

% ?- parent(X,Y).
% ?- est_parent(X,Y).  	
% ?- est_parent(X,paul).		
% ?- est_parent(paul,X).		

/* Anctre directs et indirects*/
est_ancetre(X,Y) :- est_parent(X,Y).
est_ancetre(X,Y) :- est_parent(X,Z), est_ancetre(Z,Y).

% ?- est_ancetre(X,jack).
% ?- est_ancetre(X,paul).
% ?- est_ancetre(paul,X).
% ?- est_ancetre(X,pauline).
% ?- est_ancetre(X,Y).

/* Pere et mere*/
est_pere(X,Y) :- est_parent(X,Y), humain(h,X).
est_mere(X,Y) :- est_parent(X,Y), humain(f,X).

% ?- est_mere(X,pauline).
% ?- est_pere(X,pauline).
% ?- est_mere(X,paul).

/*Freres et soeurs*/
/**Version avec couples (X,Y) et (Y,X) et (X,X)*/
sont_frere_soeur(X,Y) :- est_parent(Z,X), est_parent(Z,Y).
/*Version avec couples (X,Y) et (Y,X) */
sont_frere_soeur2(X,Y) :- est_parent(Z,X), est_parent(Z,Y), not(X==Y).

/*Version avec couples (X,Y) et (Y,X) et qui exclut les demi-frres et demi-soeurs */
sont_frere_soeur_complet(X,Y) :- est_pere(H,X), est_pere(H,Y), est_mere(F,X), est_mere(F,Y), not(X==Y).

% ?- sont_frere_soeur_complet(X,Y).
% ?- sont_frere_soeur_complet(jane,paul).
% ?- sont_frere_soeur_complet(pauline,jackie).

/*Version avec unicit des tuples (X,Y) */
couple(cindy,jack).
couple(paul,julie).

/* pour eviter la redondance du resultat lorsque les parents des freres-soeurs sont en couple
- la 1ere ligne ne valide la relation pour un couple que si le parent test est l'homme
- la 2me ligne valide le parent test qui n'est pas en couple*/
sont_frere_soeur3(X,Y) :- not(X==Y),est_parent(C1,X),est_parent(C1,Y),humain(h,C1),couple(C1,C2).
sont_frere_soeur3(X,Y) :- not(X==Y),est_parent(C1,X),est_parent(C1,Y), not(couple(C1,C2)).


/*Tatie tonton*/
est_tatie(T,Y) :- humain(f,T), est_parent(P,Y), sont_frere_soeur3(T,P).
est_tonton(T,Y) :- humain(h,T), est_parent(P,Y), sont_frere_soeur3(T,P).

% ?- est_tatie(X,Y).
% ?- est_tatie(X,jackie).
% ?- est_tatie(jane,Y).
% ?- est_tonton(X,Y).
% ?- est_tonton(X,jackie).