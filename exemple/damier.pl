% Author: Dream Team
% Date: 08/12/2010
% Checkerboard predicates.
    
% Initialize a empty checkboard for test purpose
% case are encoded like [Character,GridPosition,ManouryPosition]
% 0 are used for non-Manoury position
initializeEmptyCheckerBoard(CheckerBoard) :-
    CheckerBoard = [
    [[' ', 1, 0],[' ', 2, 1],[' ', 3, 0],[' ', 4, 2],[' ', 5, 0],[' ', 6, 3],[' ', 7, 0],[' ', 8, 4],[' ', 9, 0],[' ',10, 5]],
    [[' ',11, 6],[' ',12, 0],[' ',13, 7],[' ',14, 0],[' ',15, 8],[' ',16, 0],[' ',17, 9],[' ',18, 0],[' ',19,10],[' ',20, 0]],
    [[' ',21, 0],[' ',22,11],[' ',23, 0],[' ',24,12],[' ',25, 0],[' ',26,13],[' ',27, 0],[' ',28,14],[' ',29, 0],[' ',30,15]],
    [[' ',31,16],[' ',32, 0],[' ',33,17],[' ',34, 0],[' ',35,18],[' ',36, 0],[' ',37,19],[' ',38, 0],[' ',39,20],[' ',40, 0]],
    [[' ',41, 0],[' ',42,21],[' ',43, 0],[' ',44,22],[' ',45, 0],[' ',46,23],[' ',47, 0],[' ',48,24],[' ',49, 0],[' ',50,25]],
    [[' ',51,26],[' ',52, 0],[' ',53,27],[' ',54, 0],[' ',55,28],[' ',56, 0],[' ',57,29],[' ',58, 0],[' ',59,30],[' ',60, 0]],
    [[' ',61, 0],[' ',62,31],[' ',63, 0],[' ',64,32],[' ',65, 0],[' ',66,33],[' ',67, 0],[' ',68,34],[' ',69, 0],[' ',70,35]],
    [[' ',71,36],[' ',72, 0],[' ',73,37],[' ',74, 0],[' ',75,38],[' ',76, 0],[' ',77,39],[' ',78, 0],[' ',79,40],[' ',80, 0]],
    [[' ',81, 0],[' ',82,41],[' ',83, 0],[' ',84,42],[' ',85, 0],[' ',86,43],[' ',87, 0],[' ',88,44],[' ',89, 0],[' ',90,45]],
    [[' ',91,46],[' ',92, 0],[' ',93,47],[' ',94, 0],[' ',95,48],[' ',96, 0],[' ',97,49],[' ',98, 0],[' ',99,50],[' ',100,0]]
    ].

% Initialize a checkboard where white can won for test purpose
% case are encoded like [Character,GridPosition,ManouryPosition]
% 0 are used for non-Manoury position
initializeWhiteWonCheckerBoard(CheckerBoard) :-
    CheckerBoard = [
    [[' ', 1, 0],[' ', 2, 1],[' ', 3, 0],[' ', 4, 2],[' ', 5, 0],[' ', 6, 3],[' ', 7, 0],[' ', 8, 4],[' ', 9, 0],[' ',10, 5]],
    [[' ',11, 6],[' ',12, 0],[' ',13, 7],[' ',14, 0],[' ',15, 8],[' ',16, 0],[' ',17, 9],[' ',18, 0],[' ',19,10],[' ',20, 0]],
    [[' ',21, 0],[' ',22,11],[' ',23, 0],[' ',24,12],[' ',25, 0],[' ',26,13],[' ',27, 0],[' ',28,14],[' ',29, 0],[' ',30,15]],
    [[' ',31,16],[' ',32, 0],[' ',33,17],[' ',34, 0],[' ',35,18],[' ',36, 0],[' ',37,19],[' ',38, 0],[' ',39,20],[' ',40, 0]],
    [[' ',41, 0],[' ',42,21],[' ',43, 0],[' ',44,22],[' ',45, 0],[' ',46,23],[' ',47, 0],[' ',48,24],[' ',49, 0],[' ',50,25]],
    [[' ',51,26],[' ',52, 0],['o',53,27],[' ',54, 0],[' ',55,28],[' ',56, 0],[' ',57,29],[' ',58, 0],[' ',59,30],[' ',60, 0]],
    [[' ',61, 0],[' ',62,31],[' ',63, 0],['x',64,32],[' ',65, 0],[' ',66,33],[' ',67, 0],[' ',68,34],[' ',69, 0],[' ',70,35]],
    [[' ',71,36],[' ',72, 0],[' ',73,37],[' ',74, 0],[' ',75,38],[' ',76, 0],[' ',77,39],[' ',78, 0],[' ',79,40],[' ',80, 0]],
    [[' ',81, 0],[' ',82,41],[' ',83, 0],[' ',84,42],[' ',85, 0],[' ',86,43],[' ',87, 0],[' ',88,44],[' ',89, 0],[' ',90,45]],
    [[' ',91,46],[' ',92, 0],[' ',93,47],[' ',94, 0],[' ',95,48],[' ',96, 0],[' ',97,49],[' ',98, 0],[' ',99,50],[' ',100,0]]
    ].

% Initialize a checkboard where black can won for test purpose
% case are encoded like [Character,GridPosition,ManouryPosition]
% 0 are used for non-Manoury position
initializeBlackWonCheckerBoard(CheckerBoard) :-
    CheckerBoard = [
    [[' ', 1, 0],[' ', 2, 1],[' ', 3, 0],[' ', 4, 2],[' ', 5, 0],[' ', 6, 3],[' ', 7, 0],[' ', 8, 4],[' ', 9, 0],[' ',10, 5]],
    [[' ',11, 6],[' ',12, 0],[' ',13, 7],[' ',14, 0],[' ',15, 8],[' ',16, 0],[' ',17, 9],[' ',18, 0],[' ',19,10],[' ',20, 0]],
    [[' ',21, 0],[' ',22,11],[' ',23, 0],[' ',24,12],[' ',25, 0],[' ',26,13],[' ',27, 0],[' ',28,14],[' ',29, 0],[' ',30,15]],
    [[' ',31,16],[' ',32, 0],[' ',33,17],[' ',34, 0],[' ',35,18],[' ',36, 0],[' ',37,19],[' ',38, 0],[' ',39,20],[' ',40, 0]],
    [[' ',41, 0],[' ',42,21],[' ',43, 0],[' ',44,22],[' ',45, 0],[' ',46,23],[' ',47, 0],[' ',48,24],[' ',49, 0],[' ',50,25]],
    [[' ',51,26],[' ',52, 0],['o',53,27],[' ',54, 0],[' ',55,28],[' ',56, 0],[' ',57,29],[' ',58, 0],[' ',59,30],[' ',60, 0]],
    [[' ',61, 0],[' ',62,31],[' ',63, 0],[' ',64,32],[' ',65, 0],[' ',66,33],[' ',67, 0],[' ',68,34],[' ',69, 0],[' ',70,35]],
    [['x',71,36],[' ',72, 0],[' ',73,37],[' ',74, 0],[' ',75,38],[' ',76, 0],[' ',77,39],[' ',78, 0],[' ',79,40],[' ',80, 0]],
    [[' ',81, 0],[' ',82,41],[' ',83, 0],[' ',84,42],[' ',85, 0],[' ',86,43],[' ',87, 0],[' ',88,44],[' ',89, 0],[' ',90,45]],
    [[' ',91,46],[' ',92, 0],[' ',93,47],[' ',94, 0],[' ',95,48],[' ',96, 0],[' ',97,49],[' ',98, 0],[' ',99,50],[' ',100,0]]
    ].

% Initialize a checkboard where a rafle is possibnle for test purpose
% case are encoded like [Character,GridPosition,ManouryPosition]
% 0 are used for non-Manoury position
initializeRafleCheckerBoard(CheckerBoard) :-
    CheckerBoard = [
    [[' ', 1, 0],[' ', 2, 1],[' ', 3, 0],[' ', 4, 2],[' ', 5, 0],[' ', 6, 3],[' ', 7, 0],[' ', 8, 4],[' ', 9, 0],[' ',10, 5]],
    [[' ',11, 6],[' ',12, 0],[' ',13, 7],[' ',14, 0],[' ',15, 8],[' ',16, 0],[' ',17, 9],[' ',18, 0],[' ',19,10],[' ',20, 0]],
    [[' ',21, 0],[' ',22,11],[' ',23, 0],['x',24,12],[' ',25, 0],['x',26,13],[' ',27, 0],[' ',28,14],[' ',29, 0],[' ',30,15]],
    [[' ',31,16],[' ',32, 0],['o',33,17],[' ',34, 0],['o',35,18],[' ',36, 0],[' ',37,19],[' ',38, 0],[' ',39,20],[' ',40, 0]],
    [[' ',41, 0],[' ',42,21],[' ',43, 0],[' ',44,22],[' ',45, 0],['x',46,23],[' ',47, 0],[' ',48,24],[' ',49, 0],[' ',50,25]],
    [[' ',51,26],[' ',52, 0],[' ',53,27],[' ',54, 0],[' ',55,28],[' ',56, 0],[' ',57,29],[' ',58, 0],[' ',59,30],[' ',60, 0]],
    [[' ',61, 0],[' ',62,31],[' ',63, 0],['x',64,32],[' ',65, 0],['x',66,33],[' ',67, 0],['x',68,34],[' ',69, 0],[' ',70,35]],
    [[' ',71,36],[' ',72, 0],[' ',73,37],[' ',74, 0],[' ',75,38],[' ',76, 0],[' ',77,39],[' ',78, 0],[' ',79,40],[' ',80, 0]],
    [[' ',81, 0],[' ',82,41],[' ',83, 0],[' ',84,42],[' ',85, 0],['x',86,43],[' ',87, 0],[' ',88,44],[' ',89, 0],[' ',90,45]],
    [[' ',91,46],[' ',92, 0],[' ',93,47],[' ',94, 0],[' ',95,48],[' ',96, 0],[' ',97,49],[' ',98, 0],[' ',99,50],[' ',100,0]]
    ].

% Initialize a checkboard for a game
% case are encoded like [Character,GridPosition,ManouryPosition]
% 0 are used for non-Manoury position
initializeCheckerBoard(CheckerBoard) :-
    CheckerBoard = [
    [[' ', 1, 0],['o', 2, 1],[' ', 3, 0],['o', 4, 2],[' ', 5, 0],['o', 6, 3],[' ', 7, 0],['o', 8, 4],[' ', 9, 0],['o',10, 5]],
    [['o',11, 6],[' ',12, 0],['o',13, 7],[' ',14, 0],['o',15, 8],[' ',16, 0],['o',17, 9],[' ',18, 0],['o',19,10],[' ',20, 0]],
    [[' ',21, 0],['o',22,11],[' ',23, 0],['o',24,12],[' ',25, 0],['o',26,13],[' ',27, 0],['o',28,14],[' ',29, 0],['o',30,15]],
    [['o',31,16],[' ',32, 0],['o',33,17],[' ',34, 0],['o',35,18],[' ',36, 0],['o',37,19],[' ',38, 0],['o',39,20],[' ',40, 0]],
    [[' ',41, 0],[' ',42,21],[' ',43, 0],[' ',44,22],[' ',45, 0],[' ',46,23],[' ',47, 0],[' ',48,24],[' ',49, 0],[' ',50,25]],
    [[' ',51,26],[' ',52, 0],[' ',53,27],[' ',54, 0],[' ',55,28],[' ',56, 0],[' ',57,29],[' ',58, 0],[' ',59,30],[' ',60, 0]],
    [[' ',61, 0],['x',62,31],[' ',63, 0],['x',64,32],[' ',65, 0],['x',66,33],[' ',67, 0],['x',68,34],[' ',69, 0],['x',70,35]],
    [['x',71,36],[' ',72, 0],['x',73,37],[' ',74, 0],['x',75,38],[' ',76, 0],['x',77,39],[' ',78, 0],['x',79,40],[' ',80, 0]],
    [[' ',81, 0],['x',82,41],[' ',83, 0],['x',84,42],[' ',85, 0],['x',86,43],[' ',87, 0],['x',88,44],[' ',89, 0],['x',90,45]],
    [['x',91,46],[' ',92, 0],['x',93,47],[' ',94, 0],['x',95,48],[' ',96, 0],['x',97,49],[' ',98, 0],['x',99,50],[' ',100,0]]
    ].
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
getChar([Char,_GridPosition,_ManouryPosition],Char).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% MANOURY POSITION

% Search for a given -Box within a +Board located at given +Position
getBoxByPosition([Line | Tail],Position,Box) :-
    searchBoxInLineByPosition(Line,Position,Box);
    getBoxByPosition(Tail,Position,Box).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Search for a given -Box within a +Line located at given +Position
% CUTTED
searchBoxInLineByPosition([[State,GridPosition,Position] |_Tail],Position,[State,GridPosition,Position]) :-
    !.

% Search for a given -Box within a +Line located at given +Position
searchBoxInLineByPosition([_FooBox | Tail],Position,Box) :-
    searchBoxInLineByPosition(Tail,Position,Box).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Search within a '+Board' if the given '+State' exists
existsOnBoard([Line | Tail],State) :-
    existsOnLine(Line,State);
    existsOnBoard(Tail,State).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Search on given '+Line' if the given '+State' exists
% CUTTED
existsOnLine([[State,_Position,_ManouryPosition] | _Tail], State) :-
    !.

% Search on given '+Line' if the given '+State' exists
existsOnLine([_WrongBox | Tail], State) :-
        existsOnLine(Tail,State).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% MANOURY POSITION

%From a '+Board', change box state from '+SourcePosition' to '+Destination' box and print it on '-NewBoard'
setBoxByPosition(Board,NewBoard,SourcePosition,DestinationPosition,NewState) :-
    setBoxStateByPosition(Board,IntermediateBoard,SourcePosition,NewState,' '),
    setBoxStateByPosition(IntermediateBoard,NewBoard,DestinationPosition,' ',NewState).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Change box state within a +Line at +Position from +OldState to +NewState and print it -ModifiedLine
% CUTTED
setBoxStateByPosition([Line | Tail],[ModifiedLine | Tail],Position,OldState,NewState) :-
    setBoxStateInLineByPosition(Line,ModifiedLine,Position,OldState,NewState) , !.
    
%Change box state within a +Line at +Position from +OldState to +NewState and print it -ModifiedLine
setBoxStateByPosition([Line | OldTail],[Line | ModifiedTail],Position,OldState,NewState) :-
    setBoxStateByPosition(OldTail,ModifiedTail,Position,OldState,NewState).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Change +OldState to +NewState if given box is at +ManouryPosition
%CUTTED
setBoxStateInLineByPosition(
    [[OldState,GridPosition,ManouryPosition] | Tail],
    [[NewState,GridPosition,ManouryPosition] | Tail],
    ManouryPosition,
    OldState,
    NewState) :-
    !.

%Change +OldState to +NewState if given box is at +ManouryPosition
setBoxStateInLineByPosition(
    [ Box | OldTail],
    [ Box | ModifiedTail],
    Position,
    OldState,
    NewState) :-
    setBoxStateInLineByPosition(
        OldTail,
        ModifiedTail,
        Position,
        OldState,
        NewState).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% GRID POSITION
% DEPRECATED
    
%From a '+Board', change box state from '+SourcePosition' to '+Destination' box and print it on '-NewBoard'
setBoxFromGridPosition(Board,NewBoard,SourcePosition,DestinationPosition,NewState) :-
    setBoxStateFromGridPosition(Board,IntermediateBoard,SourcePosition,NewState,' '),
    setBoxStateFromGridPosition(IntermediateBoard,NewBoard,DestinationPosition,' ',NewState).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Analysis line per line
% *CUTTED*
setBoxStateFromGridPosition([Line | Tail],[ModifiedLine | Tail],Position,OldState,NewState) :-
    setBoxstateInLineFromGridPosition(Line,ModifiedLine,Position,OldState,NewState), !.

% Analysis line per line
% -> Analyse next line
setBoxStateFromGridPosition([Line | OldTail],[Line | ModifiedTail],Position,OldState,NewState) :-
    setBoxStateFromGridPosition(OldTail,ModifiedTail,Position,OldState,NewState).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Analysis box per box
% box found
% *CUTTED*
setBoxstateInLineFromGridPosition(
    [[OldState,Position,ManouryPosition] | Tail],
    [[NewState,Position,ManouryPosition] | Tail],
    Position,
    OldState,
    NewState) :-
    !.

% Analysis box per box
% box not found
% -> Analyse next line
setBoxstateInLineFromGridPosition(
    [ Box | OldTail],
    [ Box | ModifiedTail],
    Position,
    OldState,
    NewState) :-
  setBoxstateInLineFromGridPosition(
    OldTail,
    ModifiedTail,
    Position,
    OldState,
    NewState).
    