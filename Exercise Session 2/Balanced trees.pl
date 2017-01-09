depth(empty,0).
depth(node(X,_,Y),D):-
    depth(X,DX),
    depth(Y,DY),
    D is max(DX,DY) + 1.

balanced(empty) :- !.

balanced(node(X,_,Y)):-
    balanced(X),
    balanced(Y),
    depth(X,XD),
    depth(Y,YD),
    (XD =:= YD;
    XD+1 =:= YD;
    XD =:= YD+1),
    !.

add_to(empty,V,node(empty,V,empty)) :- !.
add_to(node(L,Q,R),V,node(NL,Q,R)):-
    add_to(L,V,NL),
    balanced(node(NL,Q,R)).
add_to(node(L,Q,R),V,node(L,Q,NR)):-
    add_to(R,V,NR),
    balanced(node(L,Q,NR)).
