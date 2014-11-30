% Author:
% Date: 02/01/2011

% Get the '-BottomLeftPosition' of a '+Position' for a '+Player' on a given '+Board'
% PAIR
getNeighbor(Board,Position,Player,State,BottomLeftPosition) :-
    Player,
    \+ member(Position,[6,16,26,36,46]),   % WEST   BORDER
    \+ member(Position,[46,47,48,49,50]),  % SOUTH  BORDER
    member(Position,[6,7,8,9,10,16,17,18,19,20,26,27,28,29,30,36,37,38,39,40,46,47,48,49,50]), %PAIR-LINE POSITION
    getBoxByPosition(Board,Position,_Box),
    BottomLeftPosition is Position + 4,
    getBoxByPosition(Board,BottomLeftPosition,CheckNewBox),
    nth1(1,CheckNewBox,State).

% Get the '-BottomLeftPosition' of a '+Position' for a '+Player' on a given '+Board'
% IMPAIR
getNeighbor(Board,Position,Player,State,BottomLeftPosition) :-
    Player,
    \+ member(Position,[6,16,26,36,46]),   % WEST   BORDER
    \+ member(Position,[46,47,48,49,50]),  % SOUTH  BORDER
    member(Position,[1,2,3,4,5,11,12,13,14,15,21,22,23,24,25,31,32,33,34,35,41,42,43,44,45]), %IMPAIR-LINE POSITION
    getBoxByPosition(Board,Position,_Box),
    BottomLeftPosition is Position + 5,
    getBoxByPosition(Board,BottomLeftPosition,CheckNewBox),
    nth1(1,CheckNewBox,State).

% Get the '-BottomRightPosition' of a '+Position' for a '+Player' on a given '+Board'
% PAIR
getNeighbor(Board,Position,Player,State,BottomRightPosition) :-
    Player,
    \+ member(Position,[5,15,25,35,45]),   % EAST  BORDER
    \+ member(Position,[46,47,48,49,50]),  % SOUTH BORDER
    member(Position,[6,7,8,9,10,16,17,18,19,20,26,27,28,29,30,36,37,38,39,40,46,47,48,49,50]), %PAIR-LINE POSITION
    getBoxByPosition(Board,Position,_Box),            %ensure given position  exists on this board
    BottomRightPosition is Position + 5,
    getBoxByPosition(Board,BottomRightPosition,CheckNewBox), %ensure generated position exists on this board
    nth1(1,CheckNewBox,State).

% Get the '-BottomRightPosition' of a '+Position' for a '+Player' on a given '+Board'
% IMPAIR
getNeighbor(Board,Position,Player,State,BottomRightPosition) :-
    Player,
    \+ member(Position,[5,15,25,35,45]),   % EAST  BORDER
    \+ member(Position,[46,47,48,49,50]),  % SOUTH BORDER
    member(Position,[1,2,3,4,5,11,12,13,14,15,21,22,23,24,25,31,32,33,34,35,41,42,43,44,45]), %IMPAIR-LINE POSITION
    getBoxByPosition(Board,Position,_Box),            %ensure given position  exists on this board
    BottomRightPosition is Position + 6,
    getBoxByPosition(Board,BottomRightPosition,CheckNewBox), %ensure generated position exists on this board
    nth1(1,CheckNewBox,State).

% Get the '-TopRightPosition' of a '+Position' for a '+Player' on a given '+Board'
% PAIR
getNeighbor(Board,Position,Player,State,TopRightPosition) :-
    \+ Player,
    \+ member(Position,[5,15,25,35,45]),   % EAST  BORDER
    \+ member(Position,[1,2,3,4,5]),       % NORTH BORDER
    member(Position,[6,7,8,9,10,16,17,18,19,20,26,27,28,29,30,36,37,38,39,40,46,47,48,49,50]), %PAIR-LINE POSITION
    getBoxByPosition(Board,Position,_Box),
    TopRightPosition is Position - 5,
    getBoxByPosition(Board,TopRightPosition,CheckNewBox),
    nth1(1,CheckNewBox,State).

% Get the '-TopRightPosition' of a '+Position' for a '+Player' on a given '+Board'
% IMPAIR
getNeighbor(Board,Position,Player,State,TopRightPosition) :-
    \+ Player,
    \+ member(Position,[5,15,25,35,45]),   % EAST  BORDER
    \+ member(Position,[1,2,3,4,5]),       % NORTH BORDER
    member(Position,[1,2,3,4,5,11,12,13,14,15,21,22,23,24,25,31,32,33,34,35,41,42,43,44,45]), %IMPAIR-LINE POSITION
    getBoxByPosition(Board,Position,_Box),
    TopRightPosition is Position - 4,
    getBoxByPosition(Board,TopRightPosition,CheckNewBox),
    nth1(1,CheckNewBox,State).

% Get the '-TopLeftPosition' of a '+Position' for a '+Player' on a given '+Board'
% PAIR
getNeighbor(Board,Position,Player,State,TopLeftPosition) :-
    \+ Player,
    \+ member(Position,[6,16,26,36,46]),   % WEST  BORDER
    \+ member(Position,[1,2,3,4,5]),       % NORTH BORDER
    member(Position,[6,7,8,9,10,16,17,18,19,20,26,27,28,29,30,36,37,38,39,40,46,47,48,49,50]), %PAIR-LINE POSITION
    getBoxByPosition(Board,Position,_Box),
    TopLeftPosition is Position - 6,
    getBoxByPosition(Board,TopLeftPosition,CheckNewBox),
    nth1(1,CheckNewBox,State).

% Get the '-TopLeftPosition' of a '+Position' for a '+Player' on a given '+Board'
% IMPAIR
getNeighbor(Board,Position,Player,State,TopLeftPosition) :-
    \+ Player,
    \+ member(Position,[6,16,26,36,46]),   % WEST  BORDER
    \+ member(Position,[1,2,3,4,5]),       % NORTH BORDER
    member(Position,[1,2,3,4,5,11,12,13,14,15,21,22,23,24,25,31,32,33,34,35,41,42,43,44,45]), %IMPAIR-LINE POSITION
    getBoxByPosition(Board,Position,_Box),
    TopLeftPosition is Position - 5,
    getBoxByPosition(Board,TopLeftPosition,CheckNewBox),
    nth1(1,CheckNewBox,State).
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Get the '-TopLeftJumpPosition' and '-RivalPosition' from '+SourcePosition' for a given '+Player' on a given '+Board'
% PAIR
getJumpPosition(Board,SourcePosition,Player,[TopLeftJumpPosition,RivalPosition]) :-
    Player,
    \+ member(SourcePosition,[6,16,26,36,46]),   % WEST  BORDER
    \+ member(SourcePosition,[1,2,3,4,5]),       % NORTH BORDER
    member(SourcePosition,[6,7,8,9,10,16,17,18,19,20,26,27,28,29,30,36,37,38,39,40,46,47,48,49,50]),    %PAIR-LINE POSITION
    getBoxByPosition(Board,SourcePosition,_FooBox),            %ensure given position  exists on this board
    RivalPosition is SourcePosition - 6,
    \+ member(RivalPosition,[6,16,26,36,46]),   % WEST  BORDER
    \+ member(RivalPosition,[1,2,3,4,5]),       % NORTH BORDER
    member(RivalPosition,[1,2,3,4,5,11,12,13,14,15,21,22,23,24,25,31,32,33,34,35,41,42,43,44,45]), %IMPAIR-LINE POSITION
    getBoxByPosition(Board,RivalPosition,RivalBox),   %ensure generated position is a rival position
    nth1(1,RivalBox,'x'),                                   %TODO Handle super pawn case
    TopLeftJumpPosition is RivalPosition - 5,
    getBoxByPosition(Board,TopLeftJumpPosition,EmptyBox),   %ensure generated position is an empty position
    nth1(1,EmptyBox,' ').
    
% Get the '-TopLeftJumpPosition' and '-RivalPosition' from '+SourcePosition' for a given '+Player' on a given '+Board'
% IMPAIR
getJumpPosition(Board,SourcePosition,Player,[TopLeftJumpPosition,RivalPosition]) :-
    Player,
    \+ member(SourcePosition,[6,16,26,36,46]),   % WEST  BORDER
    \+ member(SourcePosition,[1,2,3,4,5]),       % NORTH BORDER
    member(SourcePosition,[1,2,3,4,5,11,12,13,14,15,21,22,23,24,25,31,32,33,34,35,41,42,43,44,45]),    %IMPAIR-LINE POSITION
    getBoxByPosition(Board,SourcePosition,_FooBox),            %ensure given position  exists on this board
    RivalPosition is SourcePosition - 5,
    \+ member(RivalPosition,[6,16,26,36,46]),   % WEST  BORDER
    \+ member(RivalPosition,[1,2,3,4,5]),       % NORTH BORDER
    member(RivalPosition,[6,7,8,9,10,16,17,18,19,20,26,27,28,29,30,36,37,38,39,40,46,47,48,49,50]), %PAIR-LINE POSITION
    getBoxByPosition(Board,RivalPosition,RivalBox),   %ensure generated position is a rival position
    nth1(1,RivalBox,'x'),                                   %TODO Handle super pawn case
    TopLeftJumpPosition is RivalPosition - 6,
    getBoxByPosition(Board,TopLeftJumpPosition,EmptyBox),   %ensure generated position is an empty position
    nth1(1,EmptyBox,' ').
    
% Get the '-TopLeftJumpPosition' and '-RivalPosition' from '+SourcePosition' for a given '+Player' on a given '+Board'
% PAIR
getJumpPosition(Board,SourcePosition,Player,[TopLeftJumpPosition,RivalPosition]) :-
    \+ Player,
    \+ member(SourcePosition,[6,16,26,36,46]),   % WEST  BORDER
    \+ member(SourcePosition,[1,2,3,4,5]),       % NORTH BORDER
    member(SourcePosition,[6,7,8,9,10,16,17,18,19,20,26,27,28,29,30,36,37,38,39,40,46,47,48,49,50]),    %PAIR-LINE POSITION
    getBoxByPosition(Board,SourcePosition,_FooBox),            %ensure given position  exists on this board
    RivalPosition is SourcePosition - 6,
    \+ member(RivalPosition,[6,16,26,36,46]),   % WEST  BORDER
    \+ member(RivalPosition,[1,2,3,4,5]),       % NORTH BORDER
    member(RivalPosition,[1,2,3,4,5,11,12,13,14,15,21,22,23,24,25,31,32,33,34,35,41,42,43,44,45]), %IMPAIR-LINE POSITION
    getBoxByPosition(Board,RivalPosition,RivalBox),   %ensure generated position is a rival position
    nth1(1,RivalBox,'o'),                                   %TODO Handle super pawn case
    TopLeftJumpPosition is RivalPosition - 5,
    getBoxByPosition(Board,TopLeftJumpPosition,EmptyBox),   %ensure generated position is an empty position
    nth1(1,EmptyBox,' ').

% Get the '-TopLeftJumpPosition' and '-RivalPosition' from '+SourcePosition' for a given '+Player' on a given '+Board'
% IMPAIR
getJumpPosition(Board,SourcePosition,Player,[TopLeftJumpPosition,RivalPosition]) :-
    \+ Player,
    \+ member(SourcePosition,[6,16,26,36,46]),   % WEST  BORDER
    \+ member(SourcePosition,[1,2,3,4,5]),       % NORTH BORDER
    member(SourcePosition,[1,2,3,4,5,11,12,13,14,15,21,22,23,24,25,31,32,33,34,35,41,42,43,44,45]),    %IMPAIR-LINE POSITION
    getBoxByPosition(Board,SourcePosition,_FooBox),            %ensure given position  exists on this board
    RivalPosition is SourcePosition - 5,
    \+ member(RivalPosition,[6,16,26,36,46]),   % WEST  BORDER
    \+ member(RivalPosition,[1,2,3,4,5]),       % NORTH BORDER
    member(RivalPosition,[6,7,8,9,10,16,17,18,19,20,26,27,28,29,30,36,37,38,39,40,46,47,48,49,50]), %PAIR-LINE POSITION
    getBoxByPosition(Board,RivalPosition,RivalBox),   %ensure generated position is a rival position
    nth1(1,RivalBox,'o'),                                   %TODO Handle super pawn case
    TopLeftJumpPosition is RivalPosition - 6,
    getBoxByPosition(Board,TopLeftJumpPosition,EmptyBox),   %ensure generated position is an empty position
    nth1(1,EmptyBox,' ').

% Get the '-TopRightJumpPosition' and '-RivalPosition' from '+SourcePosition' for a given '+Player' on a given '+Board'
% PAIR
getJumpPosition(Board,SourcePosition,Player,[TopRighJumpPosition,RivalPosition]) :-
    Player,
    \+ member(SourcePosition,[5,15,25,35,45]),   % EAST  BORDER
    \+ member(SourcePosition,[1,2,3,4,5]),       % NORTH BORDER
    member(SourcePosition,[6,7,8,9,10,16,17,18,19,20,26,27,28,29,30,36,37,38,39,40,46,47,48,49,50]), %PAIR-LINE POSITION
    getBoxByPosition(Board,SourcePosition,_FooBox),            %ensure given position  exists on this board
    RivalPosition is SourcePosition - 5,
    \+ member(RivalPosition,[5,15,25,35,45]),   % EAST  BORDER
    \+ member(RivalPosition,[1,2,3,4,5]),       % NORTH BORDER
    member(RivalPosition,[1,2,3,4,5,11,12,13,14,15,21,22,23,24,25,31,32,33,34,35,41,42,43,44,45]), %IMPAIR-LINE POSITION
    getBoxByPosition(Board,RivalPosition,RivalBox),   %ensure generated position is a rival position
    nth1(1,RivalBox,'x'),                                   %TODO Handle super pawn case
    TopRighJumpPosition is RivalPosition - 4,
    getBoxByPosition(Board,TopRighJumpPosition,EmptyBox),   %ensure generated position is an empty position
    nth1(1,EmptyBox,' ').

% Get the '-TopRightJumpPosition' and '-RivalPosition' from '+SourcePosition' for a given '+Player' on a given '+Board'
% IMPAIR
getJumpPosition(Board,SourcePosition,Player,[TopRighJumpPosition,RivalPosition]) :-
    Player,
    \+ member(SourcePosition,[5,15,25,35,45]),   % EAST  BORDER
    \+ member(SourcePosition,[1,2,3,4,5]),       % NORTH BORDER
    member(SourcePosition,[1,2,3,4,5,11,12,13,14,15,21,22,23,24,25,31,32,33,34,35,41,42,43,44,45]), %IMPAIR-LINE POSITION
    getBoxByPosition(Board,SourcePosition,_FooBox),            %ensure given position  exists on this board
    RivalPosition is SourcePosition - 4,
    \+ member(RivalPosition,[5,15,25,35,45]),   % EAST  BORDER
    \+ member(RivalPosition,[1,2,3,4,5]),       % NORTH BORDER
    member(RivalPosition,[6,7,8,9,10,16,17,18,19,20,26,27,28,29,30,36,37,38,39,40,46,47,48,49,50]), %PAIR-LINE POSITION
    getBoxByPosition(Board,RivalPosition,RivalBox),   %ensure generated position is a rival position
    nth1(1,RivalBox,'x'),                                   %TODO Handle super pawn case
    TopRighJumpPosition is RivalPosition - 5,
    getBoxByPosition(Board,TopRighJumpPosition,EmptyBox),   %ensure generated position is an empty position
    nth1(1,EmptyBox,' ').

% Get the '-TopRightJumpPosition' and '-RivalPosition' from '+SourcePosition' for a given '+Player' on a given '+Board'
% PAIR
getJumpPosition(Board,SourcePosition,Player,[TopRighJumpPosition,RivalPosition]) :-
    \+ Player,
    \+ member(SourcePosition,[5,15,25,35,45]),   % EAST  BORDER
    \+ member(SourcePosition,[1,2,3,4,5]),       % NORTH BORDER
    member(SourcePosition,[6,7,8,9,10,16,17,18,19,20,26,27,28,29,30,36,37,38,39,40,46,47,48,49,50]), %PAIR-LINE POSITION
    getBoxByPosition(Board,SourcePosition,_FooBox),            %ensure given position  exists on this board
    RivalPosition is SourcePosition - 5,
    \+ member(RivalPosition,[5,15,25,35,45]),   % EAST  BORDER
    \+ member(RivalPosition,[1,2,3,4,5]),       % NORTH BORDER
    member(RivalPosition,[1,2,3,4,5,11,12,13,14,15,21,22,23,24,25,31,32,33,34,35,41,42,43,44,45]), %IMPAIR-LINE POSITION
    getBoxByPosition(Board,RivalPosition,RivalBox),   %ensure generated position is a rival position
    nth1(1,RivalBox,'o'),                                   %TODO Handle super pawn case
    TopRighJumpPosition is RivalPosition - 4,
    getBoxByPosition(Board,TopRighJumpPosition,EmptyBox),   %ensure generated position is an empty position
    nth1(1,EmptyBox,' ').

% Get the '-TopRightJumpPosition' and '-RivalPosition' from '+SourcePosition' for a given '+Player' on a given '+Board'
% IMPAIR
getJumpPosition(Board,SourcePosition,Player,[TopRighJumpPosition,RivalPosition]) :-
    \+ Player,
    \+ member(SourcePosition,[5,15,25,35,45]),   % EAST  BORDER
    \+ member(SourcePosition,[1,2,3,4,5]),       % NORTH BORDER
    member(SourcePosition,[1,2,3,4,5,11,12,13,14,15,21,22,23,24,25,31,32,33,34,35,41,42,43,44,45]), %IMPAIR-LINE POSITION
    getBoxByPosition(Board,SourcePosition,_FooBox),            %ensure given position  exists on this board
    RivalPosition is SourcePosition - 4,
    \+ member(RivalPosition,[5,15,25,35,45]),   % EAST  BORDER
    \+ member(RivalPosition,[1,2,3,4,5]),       % NORTH BORDER
    member(RivalPosition,[6,7,8,9,10,16,17,18,19,20,26,27,28,29,30,36,37,38,39,40,46,47,48,49,50]), %PAIR-LINE POSITION
    getBoxByPosition(Board,RivalPosition,RivalBox),   %ensure generated position is a rival position
    nth1(1,RivalBox,'o'),                                   %TODO Handle super pawn case
    TopRighJumpPosition is RivalPosition - 5,
    getBoxByPosition(Board,TopRighJumpPosition,EmptyBox),   %ensure generated position is an empty position
    nth1(1,EmptyBox,' ').

% Get the '-BottomRightJumpPosition' and '-RivalPosition' from '+SourcePosition' for a given '+Player' on a given '+Board'
% PAIR
getJumpPosition(Board,SourcePosition,Player,[BottomRighJumpPosition,RivalPosition]) :-
    Player,
    \+ member(SourcePosition,[5,15,25,35,45]),   % EAST  BORDER
    \+ member(SourcePosition,[46,47,48,49,50]),  % SOUTH BORDER
    member(SourcePosition,[6,7,8,9,10,16,17,18,19,20,26,27,28,29,30,36,37,38,39,40,46,47,48,49,50]), %PAIR-LINE POSITION
    getBoxByPosition(Board,SourcePosition,_FooBox),            %ensure given position  exists on this board
    RivalPosition is SourcePosition + 5,
    \+ member(RivalPosition,[5,15,25,35,45]),   % EAST  BORDER
    \+ member(RivalPosition,[46,47,48,49,50]),  % SOUTH BORDER
    member(RivalPosition,[1,2,3,4,5,11,12,13,14,15,21,22,23,24,25,31,32,33,34,35,41,42,43,44,45]), %IMPAIR-LINE POSITION
    getBoxByPosition(Board,RivalPosition,RivalBox),   %ensure generated position is a rival position
    nth1(1,RivalBox,'x'),                                   %TODO Handle super pawn case
    BottomRighJumpPosition is RivalPosition + 6,
    getBoxByPosition(Board,BottomRighJumpPosition,EmptyBox),   %ensure generated position is an empty position
    nth1(1,EmptyBox,' ').

% Get the '-BottomRightJumpPosition' and '-RivalPosition' from '+SourcePosition' for a given '+Player' on a given '+Board'
% IMPAIR
getJumpPosition(Board,SourcePosition,Player,[BottomRighJumpPosition,RivalPosition]) :-
    Player,
    \+ member(SourcePosition,[5,15,25,35,45]),   % EAST  BORDER
    \+ member(SourcePosition,[46,47,48,49,50]),  % SOUTH BORDER
    member(SourcePosition,[1,2,3,4,5,11,12,13,14,15,21,22,23,24,25,31,32,33,34,35,41,42,43,44,45]), %IMPAIR-LINE POSITION
    getBoxByPosition(Board,SourcePosition,_FooBox),            %ensure given position  exists on this board
    RivalPosition is SourcePosition + 6,
    \+ member(RivalPosition,[5,15,25,35,45]),   % EAST  BORDER
    \+ member(RivalPosition,[46,47,48,49,50]),  % SOUTH BORDER
    member(RivalPosition,[6,7,8,9,10,16,17,18,19,20,26,27,28,29,30,36,37,38,39,40,46,47,48,49,50]), %PAIR-LINE POSITION
    getBoxByPosition(Board,RivalPosition,RivalBox),   %ensure generated position is a rival position
    nth1(1,RivalBox,'x'),                                   %TODO Handle super pawn case
    BottomRighJumpPosition is RivalPosition + 5,
    getBoxByPosition(Board,BottomRighJumpPosition,EmptyBox),   %ensure generated position is an empty position
    nth1(1,EmptyBox,' ').

% Get the '-BottomRightJumpPosition' and '-RivalPosition' from '+SourcePosition' for a given '+Player' on a given '+Board'
% PAIR
getJumpPosition(Board,SourcePosition,Player,[BottomRighJumpPosition,RivalPosition]) :-
    \+ Player,
    \+ member(SourcePosition,[5,15,25,35,45]),   % EAST  BORDER
    \+ member(SourcePosition,[46,47,48,49,50]),  % SOUTH BORDER
    member(SourcePosition,[6,7,8,9,10,16,17,18,19,20,26,27,28,29,30,36,37,38,39,40,46,47,48,49,50]), %PAIR-LINE POSITION
    getBoxByPosition(Board,SourcePosition,_FooBox),            %ensure given position  exists on this board
    RivalPosition is SourcePosition + 5,
    \+ member(Position,[5,15,25,35,45]),   % EAST  BORDER
    \+ member(Position,[46,47,48,49,50]),  % SOUTH BORDER
    member(RivalPosition,[1,2,3,4,5,11,12,13,14,15,21,22,23,24,25,31,32,33,34,35,41,42,43,44,45]), %IMPAIR-LINE POSITION
    getBoxByPosition(Board,RivalPosition,RivalBox),   %ensure generated position is a rival position
    nth1(1,RivalBox,'o'),                                   %TODO Handle super pawn case
    BottomRighJumpPosition is RivalPosition + 6,
    getBoxByPosition(Board,BottomRighJumpPosition,EmptyBox),   %ensure generated position is an empty position
    nth1(1,EmptyBox,' ').

% Get the '-BottomRightJumpPosition' and '-RivalPosition' from '+SourcePosition' for a given '+Player' on a given '+Board'
% IMPAIR
getJumpPosition(Board,SourcePosition,Player,[BottomRighJumpPosition,RivalPosition]) :-
    \+ Player,
    \+ member(SourcePosition,[5,15,25,35,45]),   % EAST  BORDER
    \+ member(SourcePosition,[46,47,48,49,50]),  % SOUTH BORDER
    \+ member(SourcePosition,[6,7,8,9,10,16,17,18,19,20,26,27,28,29,30,36,37,38,39,40,46,47,48,49,50]), %PAIR-LINE POSITION
    getBoxByPosition(Board,SourcePosition,_FooBox),            %ensure given position  exists on this board
    RivalPosition is SourcePosition + 6,
    \+ member(RivalPosition,[5,15,25,35,45]),   % EAST  BORDER
    \+ member(RivalPosition,[46,47,48,49,50]),  % SOUTH BORDER
    member(RivalPosition,[6,7,8,9,10,16,17,18,19,20,26,27,28,29,30,36,37,38,39,40,46,47,48,49,50]), %IMPAIR-LINE POSITION
    getBoxByPosition(Board,RivalPosition,RivalBox),   %ensure generated position is a rival position
    nth1(1,RivalBox,'o'),                                   %TODO Handle super pawn case
    BottomRighJumpPosition is RivalPosition + 5,
    getBoxByPosition(Board,BottomRighJumpPosition,EmptyBox),   %ensure generated position is an empty position
    nth1(1,EmptyBox,' ').

% Get the '-BottomLeftJumpPosition' and '-RivalPosition' from '+SourcePosition' for a given '+Player' on a given '+Board'
% PAIR
getJumpPosition(Board,SourcePosition,Player,[BottomLeftJumpPosition,RivalPosition]) :-
    Player,
    \+ member(SourcePosition,[6,16,26,36,46]),   % WEST   BORDER
    \+ member(SourcePosition,[46,47,48,49,50]),  % SOUTH  BORDER
    member(SourcePosition,[6,7,8,9,10,16,17,18,19,20,26,27,28,29,30,36,37,38,39,40,46,47,48,49,50]), %PAIR-LINE POSITION
    getBoxByPosition(Board,SourcePosition,_FooBox),            %ensure given position  exists on this board
    RivalPosition is SourcePosition + 4,
    \+ member(RivalPosition,[6,16,26,36,46]),   % WEST   BORDER
    \+ member(RivalPosition,[46,47,48,49,50]),  % SOUTH  BORDER
    \+ member(RivalPosition,[6,7,8,9,10,16,17,18,19,20,26,27,28,29,30,36,37,38,39,40,46,47,48,49,50]), %PAIR-LINE POSITION
    getBoxByPosition(Board,RivalPosition,RivalBox),   %ensure generated position is a rival position
    nth1(1,RivalBox,'x'),                                   %TODO Handle super pawn case
    BottomLeftJumpPosition is RivalPosition + 5,
    getBoxByPosition(Board,BottomLeftJumpPosition,EmptyBox),   %ensure generated position is an empty position
    nth1(1,EmptyBox,' ').

% Get the '-BottomLeftJumpPosition' and '-RivalPosition' from '+SourcePosition' for a given '+Player' on a given '+Board'
% IMPAIR
getJumpPosition(Board,SourcePosition,Player,[BottomLeftJumpPosition,RivalPosition]) :-
    Player,
    \+ member(SourcePosition,[6,16,26,36,46]),   % WEST   BORDER
    \+ member(SourcePosition,[46,47,48,49,50]),  % SOUTH  BORDER
    \+ member(SourcePosition,[6,7,8,9,10,16,17,18,19,20,26,27,28,29,30,36,37,38,39,40,46,47,48,49,50]), %PAIR-LINE POSITION
    getBoxByPosition(Board,SourcePosition,_FooBox),            %ensure given position  exists on this board
    RivalPosition is SourcePosition + 5,
    \+ member(RivalPosition,[6,16,26,36,46]),   % WEST   BORDER
    \+ member(RivalPosition,[46,47,48,49,50]),  % SOUTH  BORDER
    member(RivalPosition,[6,7,8,9,10,16,17,18,19,20,26,27,28,29,30,36,37,38,39,40,46,47,48,49,50]), %PAIR-LINE POSITION
    getBoxByPosition(Board,RivalPosition,RivalBox),   %ensure generated position is a rival position
    nth1(1,RivalBox,'x'),                                   %TODO Handle super pawn case
    BottomLeftJumpPosition is RivalPosition + 4,
    getBoxByPosition(Board,BottomLeftJumpPosition,EmptyBox),   %ensure generated position is an empty position
    nth1(1,EmptyBox,' ').

% Get the '-BottomLeftJumpPosition' and '-RivalPosition' from '+SourcePosition' for a given '+Player' on a given '+Board'
% PAIR
getJumpPosition(Board,SourcePosition,Player,[BottomLeftJumpPosition,RivalPosition]) :-
    \+ Player,
    \+ member(SourcePosition,[6,16,26,36,46]),   % WEST   BORDER
    \+ member(SourcePosition,[46,47,48,49,50]),  % SOUTH  BORDER
    member(SourcePosition,[6,7,8,9,10,16,17,18,19,20,26,27,28,29,30,36,37,38,39,40,46,47,48,49,50]), %PAIR-LINE POSITION
    getBoxByPosition(Board,SourcePosition,_FooBox),            %ensure given position  exists on this board
    RivalPosition is SourcePosition + 4,
    \+ member(RivalPosition,[6,16,26,36,46]),   % WEST   BORDER
    \+ member(RivalPosition,[46,47,48,49,50]),  % SOUTH  BORDER
    \+ member(RivalPosition,[6,7,8,9,10,16,17,18,19,20,26,27,28,29,30,36,37,38,39,40,46,47,48,49,50]), %PAIR-LINE POSITION
    getBoxByPosition(Board,RivalPosition,RivalBox),   %ensure generated position is a rival position
    nth1(1,RivalBox,'o'),                                   %TODO Handle super pawn case
    BottomLeftJumpPosition is RivalPosition + 5,
    getBoxByPosition(Board,BottomLeftJumpPosition,EmptyBox),   %ensure generated position is an empty position
    nth1(1,EmptyBox,' ').

% Get the '-BottomLeftJumpPosition' and '-RivalPosition' from '+SourcePosition' for a given '+Player' on a given '+Board'
% IMPAIR
getJumpPosition(Board,SourcePosition,Player,[BottomLeftJumpPosition,RivalPosition]) :-
    \+ Player,
    \+ member(SourcePosition,[6,16,26,36,46]),   % WEST   BORDER
    \+ member(SourcePosition,[46,47,48,49,50]),  % SOUTH  BORDER
    \+ member(SourcePosition,[6,7,8,9,10,16,17,18,19,20,26,27,28,29,30,36,37,38,39,40,46,47,48,49,50]), %PAIR-LINE POSITION
    getBoxByPosition(Board,SourcePosition,_FooBox),            %ensure given position  exists on this board
    RivalPosition is SourcePosition + 5,
    \+ member(RivalPosition,[6,16,26,36,46]),   % WEST   BORDER
    \+ member(RivalPosition,[46,47,48,49,50]),  % SOUTH  BORDER
    member(RivalPosition,[6,7,8,9,10,16,17,18,19,20,26,27,28,29,30,36,37,38,39,40,46,47,48,49,50]), %PAIR-LINE POSITION
    getBoxByPosition(Board,RivalPosition,RivalBox),   %ensure generated position is a rival position
    nth1(1,RivalBox,'o'),                                   %TODO Handle super pawn case
    BottomLeftJumpPosition is RivalPosition + 4,
    getBoxByPosition(Board,BottomLeftJumpPosition,EmptyBox),   %ensure generated position is an empty position
    nth1(1,EmptyBox,' ').