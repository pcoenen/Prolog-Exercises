edge(a,b).
edge(b,c).
edge(b,d).
edge(c,d).

neighbor(A,B) :-
    edge(A,B);
    edge(B,A).

path(A,B) :-
    neighbor(A,B).
path(A,B):-
    neighbor(A,C),
    path(C,B).

path2(X,Y) :-
    path2(X,Y,[X]).

%path2(X,Y,Visited).
path2(X,Y,L) :-
    neighbor(X,Y),
    \+ member(Y,L).
path2(X,Y,L) :-
    neighbor(X,Z),
    \+ member(Z,L),
    path2(Z,Y,[Z|L]).
