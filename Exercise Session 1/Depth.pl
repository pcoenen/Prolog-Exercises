depth(nil,0) :- !.
depth(node(X,_,Y),V):-
    depth(X,V1),
    depth(Y,V2),
    V is max(V1,V2) + 1.
