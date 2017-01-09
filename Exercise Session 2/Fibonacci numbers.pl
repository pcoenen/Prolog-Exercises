fib(1,0):- !.
fib(2,1):- !.
fib(X,Y):-
    X1 is X-1,
    X2 is X-2,
    fib(X1,Y1),
    fib(X2,Y2),
    Y is Y1 + Y2.

fib2(1,0) :- !.
fib2(2,1) :- !.
fib2(X,N) :-
    XN is X - 2,
    fib2(XN,N,0,1),
    !.

fib2(1,N,E1,E2):-
    N is E1 + E2,
    !.
fib2(X,N,E1,E2):-
    XN is X - 1,
    E3 is E1 + E2,
    fib2(XN,N,E2,E3),
    !.
