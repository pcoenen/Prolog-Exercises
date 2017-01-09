sumtree(nil,0) :- !.
sumtree(node(X,V,Y),R):-
    sumtree(X,V1),
    sumtree(Y,V2),
    R is V + V1 + V2.
