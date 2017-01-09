all_primes(N,R) :-
    N > 1,
    generate_list(N,[],L),
    remove(L,R).

generate_list(1,L,L):- !.
generate_list(N,L,R):-
    NN is N -1,
    generate_list(NN,[N|L],R).

remove([],[]).
remove([V|T],[V|NL]):-
    delete(V,T,NT),
    remove(NT,NL).

delete(_,[],[]):- !.
delete(V,[E|L],R):-
    E mod V =:= 0,
    delete(V,L,R),
    !.
delete(V,[E|L],[E|R]):-
    delete(V,L,R).

