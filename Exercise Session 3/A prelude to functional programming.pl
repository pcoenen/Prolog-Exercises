increment(X,Y) :- Y is X + 1.

decrement(X,Y) :- Y is X - 1.


map(_,[],[]) :- !. 

map(F,[X|L],[V|R]):-
    UF =.. [F,X,V],
    call(UF),
    map(F,L,R).
