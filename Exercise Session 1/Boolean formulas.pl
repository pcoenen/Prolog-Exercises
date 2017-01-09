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
    eval(E,fal).
eval(not(E),fal):-
    eval(E,tru).
