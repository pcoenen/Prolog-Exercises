eval(int(X),_,X).

eval(var(X),[pair(X,V)|_],V):- !.
eval(var(X),[_|T],V):-
    eval(var(X),T,V).

eval(plus(E1,E2),L,V):-
    eval(E1,L,R1),
    eval(E2,L,R2),
    V is R1 + R2.

eval(times(E1,E2),L,V):-
    eval(E1,L,R1),
    eval(E2,L,R2),
    V is R1 * R2.

eval(pow(E1,E2),L,V):-
    eval(E1,L,R1),
    eval(E2,L,R2),
    V is R1 ** R2.

eval(min(E),L,V):-
    eval(E,L,R),
    V is (-1) * R.


