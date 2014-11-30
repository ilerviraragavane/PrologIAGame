% Author:
% Date: 29/12/2010
% Describe jump algorithm

% Fetch all -JumpPositions possibles from +Position on +Board for +Player
getJump(Board,Position,Player,JumpPositions) :-
    findall(ObservedPosition,getJumpPosition(Board,Position,Player,ObservedPosition),FirstJumpPositions),  %first generation of "jumper" :)
    %write('Jump Positions : '),write(FirstJumpPositions), nl,                                              %DEBUG
    exploreDeeperJumps(Board,Player,Position,FirstJumpPositions,AllJumpPositions),
    getBestJump(AllJumpPositions,BestJump),                                                             %select the best jump to compare with the other
    select(BestJump,AllJumpPositions,JumpPositionsReversedTail),                                      %delete it from main list,
    selectBestMoves(JumpPositionsReversedTail,BestJump,JumpPositions).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Try to explore more jump from +Board, +Player and +FromPosition
% From a +[[ToPosition, FirstRivalPosition | RivalPositions] | OtherJumps ] (Jump positions list)
% Fill a -FinalJumpPositions to get refined list of jump positions list
% We keep exploring if we have generated new jump position
exploreDeeperJumps(Board,Player,FromPosition,[[ToPosition, FirstRivalPosition | RivalPositions] | OtherJumps ],FinalJumpPosition) :-
    %Determine player : 'o'
    Player,
    %Simulate a new board
    setBoxStateByPosition(Board         ,BoardModified1,FromPosition      ,'o',' '),
    setBoxStateByPosition(BoardModified1,BoardModified2,FirstRivalPosition,'x',' '),
    setBoxStateByPosition(BoardModified2,FinalBoard    ,ToPosition        ,' ','o'),
    %write('Simulated checker board :'),nl,printCheckerBoard(FinalBoard),%DEBUG
    %Determine new jumps
    findall(ObservedPosition,getJumpPosition(FinalBoard,ToPosition,Player,ObservedPosition),NextGenerationJumpPositions),
    %write('Jump Positions from '),write(ToPosition),write(' : '),write(NextGenerationJumpPositions), nl, %DEBUG
    %Stop if there is no more
    length(NextGenerationJumpPositions,JumpPositionsSize),
    JumpPositionsSize > 0, !,                                                                                 %JumpSize
    saveJumpSize(NextGenerationJumpPositions,[FirstRivalPosition | RivalPositions],RefinedJumpPositions),
    %write('Saved Jumps : '),write(RefinedJumpPositions), nl, %DEBUG
    %Keep Exploring !
    exploreDeeperJumps(FinalBoard,Player,ToPosition,RefinedJumpPositions,FoundPositions),
    %write('Deeper Jump : '),write(FoundPositions),nl,
    exploreDeeperJumps(Board,Player,FromPosition,OtherJumps,OtherJumpPositions),
    append(FoundPositions,OtherJumpPositions,FinalJumpPosition).

% Try to explore more jump from +Board, +Player and +FromPosition
% From a +[[ToPosition, FirstRivalPosition | RivalPositions] | OtherJumps ] (Jump positions list)
% Fill a -FinalJumpPositions to get refined list of jump positions list
% We keep exploring if we have generated new jump position
exploreDeeperJumps(Board,Player,FromPosition,[[ToPosition, FirstRivalPosition | RivalPositions] | OtherJumps ],FinalJumpPosition) :-
    %Determine player : 'x'
    \+ Player,
    %Simulate a new board
    setBoxStateByPosition(Board         ,BoardModified1,FromPosition      ,'x',' '),
    setBoxStateByPosition(BoardModified1,BoardModified2,FirstRivalPosition,'o',' '),
    setBoxStateByPosition(BoardModified2,FinalBoard    ,ToPosition        ,' ','x'),
    %write('Simulated checker board :'),nl,printCheckerBoard(FinalBoard),
    %Determine new jumps
    findall(ObservedPosition,getJumpPosition(FinalBoard,ToPosition,Player,ObservedPosition),NextGenerationJumpPositions),
    %write('Jump Positions from '),write(ToPosition),write(' : '),write(NextGenerationJumpPositions), nl, %DEBUG
    %Stop if there is no more
    length(NextGenerationJumpPositions,JumpPositionsSize),
    JumpPositionsSize > 0, !,                                                                                 %JumpSize
    saveJumpSize(NextGenerationJumpPositions,[FirstRivalPosition | RivalPositions],RefinedJumpPositions),
    %write('Saved Jumps : '),write(RefinedJumpPositions), nl, %DEBUG
    %Keep Exploring !
    exploreDeeperJumps(FinalBoard,Player,ToPosition,RefinedJumpPositions,FoundPositions),
    %write('Deeper Jump : '),write(FoundPositions),nl,
    exploreDeeperJumps(Board,Player,FromPosition,OtherJumps,OtherJumpPositions),
    append(FoundPositions,OtherJumpPositions,FinalJumpPosition).

% Can't generate jump positions from +ToPosition, so we simply add it to the final jump positions list
% We explore next possibility
exploreDeeperJumps(Board,Player,FromPosition,[[ToPosition, FirstRivalPosition | RivalPositions] | OtherJumps ],[[ToPosition, FirstRivalPosition | RivalPositions] | FinalJumpPositionTail]) :-
    % We haven't been cutted so there is no more solution with 'ToPosition'
    %write('No more jump solution for '),write(ToPosition),write(' position.'),nl,
    exploreDeeperJumps(Board,Player,FromPosition,OtherJumps,FinalJumpPositionTail).

% No more positions to explore
% ENDPOINT
exploreDeeperJumps(_Board,_Player,_FromPosition,[],[]).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Filter +[[JumpPosition | RivalPawnsPositions]|OtherJumps] (JumpPositionsList) with a +[BestJumpPosition | LongestRivalPawnsPositions]
% we keep best solutions in -[[JumpPosition | RivalPawnsPositions]|Tail] (RefinedJumpPositions)
selectBestMoves([[JumpPosition | RivalPawnsPositions]|OtherJumps],[BestJumpPosition | LongestRivalPawnsPositions],[[JumpPosition | RivalPawnsPositions]|Tail]) :-
    length(RivalPawnsPositions,ChallengerSize),
    length(LongestRivalPawnsPositions,BestSize),
    ChallengerSize = BestSize, !,
    selectBestMoves(OtherJumps,[BestJumpPosition | LongestRivalPawnsPositions],Tail).

% Filter +[[JumpPosition | RivalPawnsPositions]|OtherJumps] (JumpPositionsList) with a +[BestJumpPosition | LongestRivalPawnsPositions]
% we keep best solutions in -[[JumpPosition | RivalPawnsPositions]|Tail] (RefinedJumpPositions)
% WorstPosition than the filter
selectBestMoves([_BadJump|OtherJumps],[BestJumpPosition | LongestRivalPawnsPositions],BestJumps) :-
    selectBestMoves(OtherJumps,[BestJumpPosition | LongestRivalPawnsPositions],BestJumps).

% Filter +[[JumpPosition | RivalPawnsPositions]|OtherJumps] (JumpPositionsList) with a +[BestJumpPosition | LongestRivalPawnsPositions]
% ENDPOINT, we finally add the filter, which is one among the best solutions
selectBestMoves([],[BestJumpPosition | LongestRivalPawnsPositions],[[BestJumpPosition | LongestRivalPawnsPositions]]).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Save a jump size, by saving a jump streak
% We simply add the last position crossed on corresponding list
saveJumpSize([ [JumpPosition,RivalPosition] | NextJumpPosition ],[FirstRivalPosition | RivalPositions],[RefinedJump | OthersJump]) :-
    append([JumpPosition,RivalPosition],[FirstRivalPosition | RivalPositions],RefinedJump),
    saveJumpSize(NextJumpPosition,[FirstRivalPosition | RivalPositions],OthersJump).

% ENDPOINT
saveJumpSize([],_CurrentJump,[]).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%