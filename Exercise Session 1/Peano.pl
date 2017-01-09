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
