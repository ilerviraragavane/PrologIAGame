%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Module de l'interface graphique du jeu de dames
% 	Affiche une grille, et place les éventuels pions de la base de faits
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Affiche les pions sur le damier
% Il suffit de rappeler cette fonction pour actualiser les pions sur le damier

afficher :- 
        nb_getval(window,Window),
        nb_getval(pions,Pawns),
        nb_getval(dames,Checkers),
        clear_pawns(Pawns),
        clear_checkers(Checkers),
        send_pawns(Window,New_pawns),
        send_checkers(Window,New_checkers),
        nb_setval(pions,New_pawns),
        nb_setval(dames,New_checkers).




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Initialise la fenêtre et les varaibles nécéssaires à la vue
%       Affiche le damier

init_afficher(Game) :-
        nb_setval(block_size,50),
        nb_setval(diameter,40),

        nb_getval(grid_size,GridSize),
        nb_getval(block_size,BlockSize),

        % On initialise le nom de la fenêtre et la liste des pions affichés
        nb_setval(window,@window),
        nb_setval(pions,[]),
        nb_setval(dames,[]),

        nb_getval(window,Window),
        new(Window, dialog('Jeu de dames')),

        Size is GridSize*BlockSize+100,
        send(Window, size, size(Size,Size)),

        send_boxes(Window,1,1,brown),

        send_graduation(Window,1),

        I is Size - 100,
        J is Size - 30,
        send(Window, display, button('Quitter', message(Window, destroy)), point(I,J)),

        I2 is I - 100,
        send(Window, display, button('Jouer', message(@prolog, Game)), point(I2,J)),

        send(Window, open(point(100,100))),

        afficher.





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Permet d afficher la graduation du damier

% Condition d arret
send_graduation(_, 9).
        
% Affiche la Nième graduation
send_graduation(Window, N) :-
        nb_getval(block_size,BlockSize),
        PosH is BlockSize * N + 20,
        PosV is 35,
        send(Window, display,
                new(_, text(N)), point(PosH, PosV)),
        send(Window, display,
                new(_, text(N)), point(PosV, PosH)),
        N2 is N + 1,
        send_graduation(Window, N2).




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Permet d afficher le damier

% X != 8 et peu importe Y
send_boxes(Window, X, Y, Color) :-
        nb_getval(grid_size,GridSize),
        nb_getval(block_size,BlockSize),
        X \= GridSize,
        I is BlockSize*(X),
        J is BlockSize*(Y),
        send(Window, display, new(A, box(BlockSize,BlockSize)), point(I,J)),
        send(A, fill_pattern, colour(Color)),
        (Color = brown -> NextColor = beige ; NextColor = brown),
        X2 is X+1,
        send_boxes(Window, X2, Y, NextColor).


% X=8 , alors on passe a la ligne suivante
send_boxes(Window, X, Y, Color ) :-
        nb_getval(grid_size,GridSize),
        nb_getval(block_size,BlockSize),
        X = GridSize,
        Y \= GridSize,
        I is BlockSize*(X),
        J is BlockSize*(Y),
        send(Window, display, new(A, box(BlockSize,BlockSize)), point(I,J)),
        send(A, fill_pattern, colour(Color)),
        Y2 is Y+1,
        send_boxes(Window, 1, Y2, Color).


% X=8 & Y=8 , alors on arrête
send_boxes(Window, X, Y, Color ) :-
        nb_getval(grid_size,GridSize),
        nb_getval(block_size,BlockSize),
        X = GridSize,
        Y = GridSize,
        I is BlockSize*(X),
        J is BlockSize*(Y),
        send(Window, display, new(A, box(BlockSize,BlockSize)), point(I,J)),
        send(A, fill_pattern, colour(Color)).







%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Affiche les pions/dames, retourne une liste qui contient toutes les ids des éléments
%       créés afin de pouvoir les supprimers

send_pawns(Window,Pawns) :-
        findall([X,Y],pion(_,X,Y),Pions),
        display_pawns(Window, Pions, Pawns).


send_checkers(Window,Checkers) :-
        findall([X2,Y2],dame(_,X2,Y2),Dames),
        display_checkers(Window, Dames, Checkers).



% Condition d arret

display_pawns(_,[],[]).


% Affiche le premier pion qui est dans la liste.
%       * Window : Fenetre dans laquelle afficher le pion
%       * [[X,Y]|Q] : Liste contenant les coordonnées des pions ; On affiche seulement le premier (X,Y)
%       * [[Circle,Circle2]|R]) : Liste contenant l id du cercle créé

display_pawns(Window, [[X,Y]|Q],[Circle|R]) :-
        nb_getval(block_size,BlockSize),
        nb_getval(diameter,Diameter),
        pion(C,X,Y),
        I is BlockSize*(X)+(BlockSize-Diameter)/2,
        J is BlockSize*(Y)+(BlockSize-Diameter)/2,
        send(Window, display,
                        new(Circle, circle(Diameter)), point(I,J)),
        ( C = b -> Color = white ; Color = black ),
        send(Circle, fill_pattern, colour(Color)),
        display_pawns(Window,Q,R).




% Condition d arret

display_checkers(_,[],[]).


% Affiche la première dame qui est dans la liste.
%       * Window : Fenetre dans laquelle afficher la dame
%       * [[X,Y]|Q] : Liste contenant les coordonnées des dames ; On affiche seulement la première (X,Y)
%       * [[Circle,Circle2]|R]) : Liste contenant les ids dans cercles créés

display_checkers(Window, [[X,Y]|Q], [[Circle,Circle2]|R]) :-
        nb_getval(block_size,BlockSize),
        nb_getval(diameter,D),
        D2 is D/3,
        dame(C,X,Y),
        I is BlockSize*(X)+(BlockSize-D)/2,
        J is BlockSize*(Y)+(BlockSize-D)/2,
        I2 is BlockSize*(X)+(BlockSize-D2)/2,
        J2 is BlockSize*(Y)+(BlockSize-D2)/2,
        send(Window, display,
                new(Circle, circle(D)), point(I,J)),
        ( C = b -> Color = white, Color2 = black; Color = black, Color2 = white ),
        send(Circle, fill_pattern, colour(Color)),
        
        send(Window, display,
                new(Circle2, circle(D2)), point(I2,J2)),
        send(Circle2, fill_pattern, colour(Color2)),
        display_checkers(Window,Q,R).








%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% clear_pawns(checkers) : Supprime tous les pions(dames) affiché(e)s
%       * pion : Liste contenant l id du cercle créé
%       * dame : Liste contenant une liste des deux ids des deux cercles créés

% Condition d arret
clear_pawns([]).

% Supprime un pion (1 cercle)
clear_pawns([PH|PQ]) :- 
        free(PH),
        clear_pawns(PQ).

% Condition d arret
clear_checkers([]).

% Supprime une dame (2 cercles)
clear_checkers([[PH1,PH2]|PQ]) :-
        free(PH1),
        free(PH2),
        clear_checkers(PQ).
                



