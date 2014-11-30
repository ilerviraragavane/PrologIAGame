% Author: Dream Team
% Date: 08/12/2010
% Referee

%[imports]
:- [display].
:- [damier].
:- [positions].
:- [jumps].
:- [rules].
:- [utilities].

% Initialize -Player to 'true' (aka White)
initializePlayers(Player) :-
    Player = true.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Print +Player turn
printPlayerTurn(Player) :-
    Player, !,
    write('A Blanc de jouer.'),nl.

% Print +Player turn
printPlayerTurn(_Player) :-
    write('A Noir de jouer.'),nl.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Change player's turn from +Player to -NewPlayer
nextTurn(Player,NewPlayer) :-
    Player, !,
    NewPlayer = false.

% Change player's turn from +Player to -NewPlayer
nextTurn(Player,NewPlayer) :-
    not(Player),
    NewPlayer = true.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Game predicate to enjoy some play :)
start :-
    initializeRafleCheckerBoard(Board),
    initializePlayers(Player),
    run(Board,Player),
    nl.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Rule's steps
% Run the game for a +Board and a +Player
run(Board,Player) :-
    canStillPlay(Board,Player),
    printCheckerBoard(Board),
    printPlayerTurn(Player),
    getStartPositions(Board,Player,StartPositions),
    write('Allowed start positions : '),printPositions(StartPositions),nl,
    write('Select the pawn you want to move'),nl,
    read(StartPosition),
    checkValidPosition(StartPosition,StartPositions),
    generateAllowedMove(Board,StartPosition,Player,Moves),
    write('Allowed Moves : '),printPositions(Moves),nl,
    write('Select where you want to go'),nl,
    read(MovePosition),nl,
    movePawn(Board,NewBoard,StartPosition,MovePosition,Moves,Player),
    nextTurn(Player,NewPlayer),
    run(NewBoard,NewPlayer).

% Rule's steps
% Error has happened
run(Board,Player) :-
    canStillPlay(Board,Player),
    write('Reselect a correct the pawn you want to move'),nl,
    run(Board,Player).
    
% Player has won
run(Board,Player) :-
    Player, !,
    printCheckerBoard(Board),
    write('Noir a gagné.').

% Player has won
run(Board,_Player) :-
    printCheckerBoard(Board),
    write('Blanc a gagné.').

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
