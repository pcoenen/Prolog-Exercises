translate(I, O):-
    translate(I,O,[],0).

translate([],[],_,_):- !.

translate([def(X)|R],[asgn(X, CN)|O],L,C):-
    CN is C + 1,
    (
    member(pair(X,CN),L) ->
        translate(R,O,L,CN)
    ;
        translate(R,O,[pair(X,CN)|L],CN)
    ).

translate([use(X)|R],[use(Y)|O],L,C):-
    (
    member(pair(X,Y),L) ->
        translate(R,O,L,C)
    ;
        translate(R,O,[pair(X,Y)|L],C)
    ).
        

