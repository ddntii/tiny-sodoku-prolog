:- use_module(library(clpfd)).

solve_sudoku(Puzzle) :-
    append(Puzzle, Vars),
    Vars ins 1..9,
    maplist(all_distinct, Puzzle),
    transpose(Puzzle, Columns),
    maplist(all_distinct, Columns),
    constrain_boxes(Puzzle),
    labeling([], Vars),
    maplist(writeln, Puzzle).

constrain_boxes([R1,R2,R3,R4,R5,R6,R7,R8,R9]) :-
    get_box(R1,R2,R3,0,3,Box1), all_distinct(Box1),
    get_box(R1,R2,R3,3,6,Box2), all_distinct(Box2), 
    get_box(R1,R2,R3,6,9,Box3), all_distinct(Box3),
    get_box(R4,R5,R6,0,3,Box4), all_distinct(Box4),
    get_box(R4,R5,R6,3,6,Box5), all_distinct(Box5),
    get_box(R4,R5,R6,6,9,Box6), all_distinct(Box6),
    get_box(R7,R8,R9,0,3,Box7), all_distinct(Box7),
    get_box(R7,R8,R9,3,6,Box8), all_distinct(Box8),
    get_box(R7,R8,R9,6,9,Box9), all_distinct(Box9).

get_box(R1,R2,R3,Start,End,Box) :-
    End1 is End - 1,
    sublist(R1,Start,End1,S1),
    sublist(R2,Start,End1,S2), 
    sublist(R3,Start,End1,S3),
    append([S1,S2,S3],Box).

sublist([H|T],0,0,[H]) :- !.
sublist([H|T],0,N,[H|R]) :- N > 0, N1 is N-1, sublist(T,0,N1,R).
sublist([_|T],S,E,R) :- S > 0, S1 is S-1, E1 is E-1, sublist(T,S1,E1,R).

test :-
    Puzzle = [[5,3,_,_,7,_,_,_,_],
              [6,_,_,1,9,5,_,_,_], 
              [_,9,8,_,_,_,_,6,_],
              [8,_,_,_,6,_,_,_,3],
              [4,_,_,8,_,3,_,_,1],
              [7,_,_,_,2,_,_,_,6],
              [_,6,_,_,_,_,2,8,_],
              [_,_,_,4,1,9,_,_,5],
              [_,_,_,_,8,_,_,7,9]],
    solve_sudoku(Puzzle).
