% Example knowledge base
highway(1,2,c).
highway(2,3,a).
highway(1,3,b).
highway(3,5,a).
highway(3,4,c).
highway(5,4,d).

check :-
    getnodes([E|N]),
    checkconn([E|N]),
    checkcolors(N).

checkcolors([_]):- !.
checkcolors([E|R]):-
    getcolors(E,C),
    checkcolor(E,C),
    checkcolors(R).

checkcolor(_,[]).
checkcolor(N,[C|R]):-
    findall(E,(highway(N,_,E);highway(_,N,E)),L),
    length(L,A),
    delete(L,C,ZC),
    length(ZC,O),
    A-O =< O,
    checkcolor(N,R).
    
   
checkconn([]).
checkconn([N|R]):-
    findall(C,(highway(N,C,_);highway(C,N,_)),L),
    length(L,Len),
    Len mod 2 =:= 0,
    checkconn(R).
    
getnodes(R):-
    findall(N,(highway(N,_,_);highway(_,N,_)),L),
    list_to_set(L,S),
    sort(S,R).

getcolors(N,S):-
    findall(C,(highway(N,_,C);highway(_,N,C)),L),
    list_to_set(L,S).

tour(S):-
    check,
    calctrip(1,[],S),
    findall(C,highway(_,_,C),L),
    length(L,HL),
    length(S,HL),
    checkcolors2(S),
    !.

checkcolors2([_]).
checkcolors2([_-C1,Y2-C2|R]):-
    C1 \= C2,
    checkcolors2([Y2-C2|R]).

calctrip(1,U,[]):-
    length(U,L),
    L > 0,
    !.

calctrip(N,U,[V-C|S]):-
    (
        highway(N,V,C),
        \+ member(highway(N,V,C),U),
        calctrip(V,[highway(N,V,C)|U],S)
    ;
        highway(V,N,C),
        \+ member(highway(V,N,C),U),
        calctrip(V,[highway(V,N,C)|U],S)
    ).    
