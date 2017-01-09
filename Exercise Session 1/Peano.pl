peano_plus(zero,X,X).
peano_plus(s(X),Y,s(Z)) :- peano_plus(X,Y,Z).

min(X,zero,X).
min(s(X),s(Y),Z) :-
    min(X,Y,Z).

greater_than(X,Y) :- 
    X \== Y,
    min(X,Y,_).

maximum(X,X,X).
maximum(X,Y,X):-
    greater_than(X,Y).
maximum(X,Y,Y):-
    greater_than(Y,X).

%Extra

min2(X,Y,Z):-
    peano_plus(Y,Z,X).

div(X,Y,zero,X):-
    greater_than(Y,X),
    !.
div(zero,_,zero,zero):- !.
div(X,Y,s(D),Z):-
    min(X,Y,XN),
    div(XN,Y,D,Z).
