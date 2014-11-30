% Author:  Dream Team
% Date: 08/12/2010
% Rules

% Check if a '+Position' for a given '+Player' on a '+Board' is allowed
isPositionAllowed(Board,Position,Player) :-
    Player, !,
    getBoxByPosition(Board,Position,Box),
    nth1(1,Box,'o').

% Check if a '+Position' for a given '+Player' on a '+Board' is allowed
isPositionAllowed(Board,Position,Player) :-
    \+ Player, !,
    getBoxByPosition(Board,Position,Box),
    nth1(1,Box,'x').

% Check if a '+Position' for a given '+Player' on a '+Board' is allowed
% Error case
isPositionAllowed(_Board,Position,_Player)  :-
    write('Position '),display(Position),write(' is illegal'),nl,
    fail.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check if a '+Player' can still play (or we can also say that he lose) by checking a '+Board'
canStillPlay(Board,Player) :-
    Player,
    existsOnBoard(Board,'o').

% Check if a '+Player' can still play (or we can also say that he lose) by checking a '+Board'
canStillPlay(Board,Player) :-
    \+ Player,
    existsOnBoard(Board,'x').

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Generate -Moves from +StartPosition on a +Board and for a given +Player
% CUTTED
generateAllowedMove(Board,StartPosition,Player,Moves) :-
    isPositionAllowed(Board,StartPosition,Player),
    getJump(Board,StartPosition,Player,Moves),
    length(Moves,JumpMoveSize),
    JumpMoveSize > 0, !.                                                         % We MUST jump if we can

% Generate -Moves from +StartPosition on a +Board and for a given +Player
% CUTTED
generateAllowedMove(Board,StartPosition,Player,Moves) :-
    isPositionAllowed(Board,StartPosition,Player),
    findall(ObservedPosition,getNeighbor(Board,StartPosition,Player,' ',ObservedPosition),Moves), % Otherwise normal moves
    length(Moves,MoveSize),
    MoveSize > 0, !.                                                                              % Don't select a pawn who can't move

% Generate -Moves from +StartPosition on a +Board and for a given +Player
% ENDPOINT
generateAllowedMove(Board,StartPosition,Player,_Moves) :-
    isPositionAllowed(Board,StartPosition,Player),
    %write('Pawn at position '),write(StartPosition),write(' cant move'),nl,     %DEBUG
    fail.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Generate -RefinedStartPositions on a +Board for a given +Player
% briefly, show us allowed start positions for the player for a given board
getStartPositions(Board,Player,RefinedStartPositions) :-
    generateAllowedStartPosition(Board,Board,Player,StartPositions),
    findLongestSize(StartPositions,LongestSize),
    filterStartPositions(StartPositions,LongestSize,RefinedStartPositions).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Generate -StartPositions on a +Board for a given +Player, exploring '+[Line | OtherLines]'
generateAllowedStartPosition(Board,[Line | OtherLines],Player,StartPositions) :-
    generateAllowedPositionWithinLines(Board,Line,Player,LineStartPositions),
    generateAllowedStartPosition(Board,OtherLines,Player,OtherStartPositions),
    append(LineStartPositions,OtherStartPositions,StartPositions).

% Generate -StartPositions on a +Board for a given +Player, exploring '+[Line | OtherLines]'
% ENDPOINT
generateAllowedStartPosition(_Board,[],_Player,[]).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Generate raw start positions (-[[StartPosition,JumpSize] | OtherStartPosition]) from +Box on a given +Board for a given +Player
% And it keep exploring +OtherBox
% JUMP DETECTED CASE
% CUTTED
generateAllowedPositionWithinLines(Board,[Box | OtherBox],Player,[[StartPosition,JumpSize] | OtherStartPosition]) :-
    nth1(3,Box,StartPosition),
    isPositionAllowed(Board,StartPosition,Player),
    generateAllowedMove(Board,StartPosition,Player,Moves),
    length(Moves,MovesSize),
    MovesSize >0,
    nth1(1,Moves,FirstJump),
    is_list(FirstJump), !,
    length(FirstJump,JumpSize),
    JumpSize > 1,                                                                % Jump dectection give list with size > 1
    generateAllowedPositionWithinLines(Board,OtherBox,Player,OtherStartPosition).

% Generate raw start positions (-[[StartPosition,1] | OtherStartPosition]) from +Box on a given +Board for a given +Player
% And it keep exploring +OtherBox
% MOVE DETECTED CASE
% CUTTED
generateAllowedPositionWithinLines(Board,[Box | OtherBox],Player,[[ StartPosition, 1 ] | OtherStartPosition]) :-
    nth1(3,Box,StartPosition),
    isPositionAllowed(Board,StartPosition,Player),
    generateAllowedMove(Board,StartPosition,Player,Moves),
    length(Moves,MovesSize),
    MovesSize >0, !,
    generateAllowedPositionWithinLines(Board,OtherBox,Player,OtherStartPosition).

% Can't generate moves from +'_UnacceptableBox' so it keep exploring +OtherBox
generateAllowedPositionWithinLines(Board,[_UnacceptableBox | OtherBox],Player,OtherStartPosition) :-
    generateAllowedPositionWithinLines(Board,OtherBox,Player,OtherStartPosition).
    
% ENDPOINT
generateAllowedPositionWithinLines(_Board,[],_Player,[]).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check if +ChallengerPosition is allowed within +[ChallengerPosition | _OtherPosition] list
% CUTTED
checkValidPosition(ChallengerPosition,[ChallengerPosition | _OtherPosition]) :-
    !.

% Check if +ChallengerPosition is allowed within +[_Position | OtherPosition] list
checkValidPosition(ChallengerPosition,[_Position | OtherPosition]) :-
    checkValidPosition(ChallengerPosition,OtherPosition).

% ENDPOINT
checkValidPosition(_ChallengerPosition,[]) :-
    write('Given position is not allowed !'), nl, fail.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Move a pawn from +SourcePosition to +MovePosition from +Board and apply change to -NewBoard
% It is +Player turn, and +[MovePosition | _OtherMoves] are all allowed moves
% MOVE CASE
movePawn(Board,NewBoard,SourcePosition,MovePosition,[MovePosition | _OtherMoves],Player) :-
    Player,
    \+ is_list(MovePosition), !,
    setBoxStateByPosition(Board,IntermediateBoard,SourcePosition,'o',' '),
    setBoxStateByPosition(IntermediateBoard,NewBoard,MovePosition  ,' ','o').

% Move a pawn from +SourcePosition to +MovePosition from +Board and apply change to -NewBoard
% It is +Player turn, and +[MovePosition | _OtherMoves] are all allowed moves
% MOVE CASE
movePawn(Board,NewBoard,SourcePosition,MovePosition,[MovePosition | _OtherMoves],Player) :-
    \+ Player,
    \+ is_list(MovePosition), !,
    setBoxStateByPosition(Board,IntermediateBoard,SourcePosition,'x',' '),
    setBoxStateByPosition(IntermediateBoard,NewBoard,MovePosition  ,' ','x').

% Move a pawn from +SourcePosition to +MovePosition from +Board and apply change to -NewBoard
% It is +Player turn, and +[MovePosition | _OtherMoves] are all allowed moves
% JUMP CASE
movePawn(Board,NewBoard,SourcePosition,MovePosition,[ Move | _OtherAvailableMoves],Player) :-
    Player,
    is_list(Move),
    nth1(1,Move,Head),
    Head = MovePosition, !,
    setBoxStateByPosition(Board,IntermediateBoard1,SourcePosition,'o',' '),
    setBoxStateByPosition(IntermediateBoard1,IntermediateBoard2,MovePosition  ,' ','o'),
    select(Head,Move,RivalPawnsPosition),
    moveRivalPawns(IntermediateBoard2,NewBoard,RivalPawnsPosition,Player).

% Move a pawn from +SourcePosition to +MovePosition from +Board and apply change to -NewBoard
% It is +Player turn, and +[MovePosition | _OtherMoves] are all allowed moves
% JUMP CASE
movePawn(Board,NewBoard,SourcePosition,MovePosition,[Move | _OtherAvailableMoves],Player) :-
    \+ Player,
    is_list(Move),
    nth1(1,Move,Head),
    Head = MovePosition,  !,
    setBoxStateByPosition(Board,IntermediateBoard1,SourcePosition,'x',' '),
    setBoxStateByPosition(IntermediateBoard1,IntermediateBoard2,MovePosition  ,' ','x'),
    select(Head,Move,RivalPawnsPosition),
    moveRivalPawns(IntermediateBoard2,NewBoard,RivalPawnsPosition,Player).

% Move a pawn from +SourcePosition to +MovePosition from +Board and apply change to -NewBoard
% It is +Player turn, and +[MovePosition | _OtherMoves] are all allowed moves
% Continue to check if +MovePosition is allowed
movePawn(Board,NewBoard,SourcePosition,MovePosition,[_MovePosition | OtherMoves],Player) :-
    movePawn(Board,NewBoard,SourcePosition,MovePosition,OtherMoves,Player), !.

% ENDPOINT, Movement not allowed
movePawn(_Board,_NewBoard,_SourcePosition,_MovePosition,[],_Player) :-
    write('Move position is not allowed !'), nl, fail.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


