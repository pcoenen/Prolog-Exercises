father(anton,bart).
father(anton,daan).
father(anton,elisa).
father(fabian,anton).
mother(celine,bart).
mother(celine,daan).
mother(celine,gerda).
mother(gerda,hendrik).

ancestor(X,Y) :- father(X,Y).

ancestor(X,Y) :-
    father(Z,Y),
    ancestor(X,Z).
