code([a,b], 1).
code([b,e], 2).
code([b,c,d,e], 3).
code([b,c], 4).
code([c,d],5).
code([a,b,c],6).

decompress([],[]).
decompress([X|XS],R):-
    integer(X),
    !,
    code(D1,X),
    decompress(XS,D2),
    append(D1,D2,R).
decompress([X|XS],[X|R]):-
  decompress(XS,R).  

compress(I,O):-
    compress1(I,O),
    I \== O.
compress1([],[]).
compress1([I|IS],R):-
    helper([I],IS,R).

helper(I,IR,[R1|R2]):-
    code(I,R1),
    compress1(IR,R2).

helper(I1,[I2|IS],R):-
    append(I1,[I2],I),
    helper(I,IS,R).

helper(L,[],L).


optcompression(U, C):-
    findall(pair(L,R),(compress(U,R),length(R,L)),All),
    sort(All,[pair(Min,_)|_]),
    member(pair(Min,C),All).
