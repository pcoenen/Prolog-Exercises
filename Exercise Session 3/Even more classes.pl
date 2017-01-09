% Knowledge base
teaches(holvoet,bvp).
teaches(moens,bvp).
teaches(demoen,fi).
teaches(dedecker,socs).
teaches(holvoet,swop).
teaches(jacobs,swop).
teaches(demoen,ai).
teaches(deschreye,ai).

takes(joachim,bvp).
takes(joachim,fi).
takes(joachim,ai).
takes(matthias,bvp).
takes(matthias,ai).
takes(thomas,socs).
takes(thomas,swop).
takes(ingmar,swop).


% Predicates
takes_same_course(X,Y) :-   
    findall(pair(S1,S2),(takes(S1,C),takes(S2,C),S1 \== S2),L),
    list_to_set(L,S),
    member(pair(X,Y),S).

teach_same_course(X,Y) :-
    findall(pair(P1,P2),(teaches(P1,C),teaches(P2,C), P1 \== P2),L),
    list_to_set(L,S),
    member(pair(X,Y),S).

teaches_multiple_courses(X) :-
    findall(P,(teaches(P,C1), teaches(P,C2), C1 \== C2),L),
    list_to_set(L,S),
    member(X,S).
