eval(number(X),X):- !.
eval(plus(E1,E2),R):-
    eval(E1,R1),
    eval(E2,R2),
    R is R1 + R2,
    !.
eval(min(E1,E2),R):-
    eval(E1,R1),
    eval(E2,R2),
    R is R1 - R2,
    !.
eval(neg(E),R):-
    eval(E,V),
    R is V * (-1),
    !.

%Extra
eval(tru,tru):- !.
eval(fal,fal):- !.

eval(or(E1,E2),tru):-
    eval(E1,X),
    eval(E2,Y),
    (X == 'tru';
    Y == 'tru'),
    !.
eval(or(_,_),fal).

eval(and(E1,E2),tru):-
    eval(E1,X),
    eval(E2,Y),
    X == 'tru',
    Y == 'tru',
    !.
eval(and(_,_),fal).

eval(not(E),tru):-
    eval(E,fal),
    !.
eval(not(_),fal).

eval(=(E1,E2),tru):-
    eval(E1,V1),
    eval(E2,V2),
    V1 == V2,
    !.
eval(=(_,_),fal).
