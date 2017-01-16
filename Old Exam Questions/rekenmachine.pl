relevantNumber(Numbers, Max, R):-
    member(Y,Numbers),
    helper_relNumber(Numbers,Max,Y,R).
    
helper_relNumber(_,Max,Acc,Acc):-
    Acc =< Max.

helper_relNumber(Numbers,Max,Acc,X):-
    Acc > 0,
    member(Y,Numbers),
    New is Acc * 10 + Y,
    New =< Max,
    helper_relNumber(Numbers,Max,New,X).

%Oef 2

calcul(_,Needed,Needed,[]):- !.
calcul(Numbers,Needed,Current,["*",X|Res]):-
    relevantNumber(Numbers,Needed,X),
    Current > 0,
    X > 1,
    New is Current * X,
    New =< Needed,
    calcul(Numbers,Needed,New,Res).

calcul(Numbers,Needed,Current,["+",X|Res]):-
    relevantNumber(Numbers,Needed,X),
    X > 0,
    New is Current + X,
    New =< Needed,
    calcul(Numbers,Needed,New,Res).

calculCost(Numbers,Needed,Current,L,Res):-
    calcul(Numbers,Needed,Current,Res),
    findall(C,(member(X,Res),atom_length(X,C)),Costs),
    sum_list(Costs,L).

sortedCalcul(Numbers,Needed,Res):-
    MaxCost is Needed * 2,
    numlist(1,MaxCost,Costs),
    member(X,Costs),
    calculCost(Numbers,Needed,0,X,Res).

unreachable(Numbers,R):-
    numlist(1,30,List),
    findall(V,(member(V,List),calcul(Numbers,V,0,_)),Reachable),
    subtract(List,Reachable,R).
