listlength([],0).
listlength([_|Rest],Length) :-
    listlength(Rest,LengthRest),
    Length is LengthRest + 1.

listlength2(List,Length) :-
    listlength2(List,0,Length).

% listlength2(List,Accumulator,Length).
listlength2([],A,A).
listlength2([_|T],A,R):-
    AN is A + 1,
    listlength2(T,AN,R).

last([X],X) :- !.

last([_|R],X) :- 
    last(R,X).

next_to([A,B|_],A,B):- !.
next_to([_|R],A,B):-
    next_to(R,A,B).

vector_sum([],[],[]).
vector_sum([X|T1],[Y|T2],[R|V]) :-
    vector_sum(T1,T2,V),
    R is X + Y.
    

look_up([pair(P,G)|_],P,G).
look_up([_|R],P,G):-
    look_up(R,P,G).
