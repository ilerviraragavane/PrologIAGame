% Author:
% Date: 02/01/2011

% Move +[PawnPosition | OtherPositions] (RivalPawns) on +Board accorded to +Player turn
% and apply change on -NewBoard
moveRivalPawns(Board,NewBoard,[PawnPosition |OtherPositions],Player) :-
    Player, !,
    setBoxStateByPosition(Board,IntermediateBoard,PawnPosition,'x',' '),
    moveRivalPawns(IntermediateBoard,NewBoard,OtherPositions,Player).

% Move +[PawnPosition | OtherPositions] (RivalPawns) on +Board accorded to +Player turn
% and apply change on -NewBoard
moveRivalPawns(Board,NewBoard,[PawnPosition |OtherPositions],Player) :-
    \+ Player, !,
    setBoxStateByPosition(Board,IntermediateBoard,PawnPosition,'o',' '),
    moveRivalPawns(IntermediateBoard,NewBoard,OtherPositions,Player).

% Move +[PawnPosition | OtherPositions] (RivalPawns) on +Board accorded to +Player turn
% and apply change on -NewBoard
% ENDPOINT
moveRivalPawns(FinalBoard,FinalBoard,[],_Player).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Find the longest streak from [Position, Size]-type list and unify it with -LongestSize
findLongestSize(Positions,LongestSize) :-
    exploreSizes(Positions,0,LongestSize).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check +Size again +CurrentMax and update +NewMax with the best value
exploreSizes([[_Position, Size] | OtherPositions],CurrentMax,NewMax) :-
    Size > CurrentMax,
    NewCurrentMax is Size,
    exploreSizes(OtherPositions,NewCurrentMax,NewMax).

exploreSizes([ _WeakPosition | OtherPositions],CurrentMax,NewMax) :-
    exploreSizes(OtherPositions,CurrentMax,NewMax).

exploreSizes([],Max,Max).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Transform a [Position,Size]-type list to a Position-type list
filterStartPositions([ [Position,Size] |OtherPositions],LongestSize,[ Position | Tail ]) :-
    Size >= LongestSize,
    filterStartPositions(OtherPositions,LongestSize,Tail).

filterStartPositions([ _WeakPosition |OtherPositions],LongestSize,Tail) :-
    filterStartPositions(OtherPositions,LongestSize,Tail).

filterStartPositions([],_Size,[]).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Fetch -BestJump from +[FirstJump | OtherJump] list
getBestJump([FirstJump | OtherJump],BestJump) :-
    exploreBestJump([FirstJump | OtherJump],FirstJump,BestJump).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check if +[JumpPosition | RivalPawnsPositions] if better than +[_CurrentBestJumpPosition | CurrentBestRivalStreak] and unify the best with -BestJump
exploreBestJump([[JumpPosition | RivalPawnsPositions] | OtherJump],[_CurrentBestJumpPosition | CurrentBestRivalStreak],BestJump) :-
    length(RivalPawnsPositions,ChallengerSize),
    length(CurrentBestRivalStreak,BestSize),
    ChallengerSize > BestSize, !,
    exploreBestJump(OtherJump,[JumpPosition | RivalPawnsPositions],BestJump).

exploreBestJump([_WeakPosition | OtherJump],[CurrentBestJumpPosition | CurrentBestRivalStreak],BestJump) :-
    exploreBestJump(OtherJump,[CurrentBestJumpPosition | CurrentBestRivalStreak],BestJump).
    
exploreBestJump([],BestJump,BestJump).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
