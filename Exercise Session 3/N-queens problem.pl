queens(N,R) :-
    numlist(1,N,L),
    permutation(L,R),
    valid(N,R).

valid(_,[]).
valid(N,[X|R]):-
    check(N,X,1,R),
    valid(N,R).

check(_,_,_,[]).
check(N,X,P,[E|R]):-
    E =\= X + P,
    E =\= X - P,
    PN is P + 1,
    check(N,X,PN,R).
