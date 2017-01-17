decode(N,List, Res):-
    helper(N,List,Res),
    findall(Q,(member(N1-L1,Res),member(N2-L2,Res),N1 =\= N2,append(L1,Q,L2)),F),
    length(F,0).

helper(0,[],[]):- !.
helper(N,List,Res):-
    append(X,Y,List),
    length(Y,L),
    L > 0,
    Number is N - 1,
    helper(Number,X,R1),
    append(R1,[Number-Y],Res).

best(N,Codes,Freqs,Res):-
    findall(R,decode(N,Codes, R),ResList),
    helper_best(ResList,Freqs,Res).

helper_best([X],_,X):- !.
helper_best(List,[],Res):-
    member(Res,List).
helper_best(ResList,Freqs,Res):-
    getMax(Freqs,Max,NewFreqs),
    getMinCosts(Max,ResList,NewRes),
    helper_best(NewRes,NewFreqs,Res).

getMax(Freqs,ListMax,Rest):-
    findall(F-X,member(X-F,Freqs),FreqR),
    sort(FreqR,SFreqR),
    reverse(SFreqR,[Max-_|_]),
    findall(X,member(X-Max,Freqs),ListMax),
    findall(X-F,(member(X-F,Freqs),F < Max),Rest).

calcCost(Min,Res,Cost):-
    findall(L,(member(X-List,Res),member(X,Min),length(List,L)),CosList),
    sum_list(CosList,Cost).

getMinCosts(Min,ResList,Res):-
    findall(C,(member(List,ResList),calcCost(Min,List,C)),ListCosts),
    sort(ListCosts,[MinC|_]),
    findall(List,(member(List,ResList),calcCost(Min,List,MinC)),Res).
    
    
    
    
