alpha_beta(max(L,R),Alpha,Beta,Score,max(TL,TR)):-
    alpha_beta(L,Alpha,Beta,SL,TL),
    (
    Beta =< SL ->
        TR = nil,
        Score = SL
    ;
        alpha_beta(R,SL,Beta,SR,TR),
        Score is max(SL,SR)
    ).
  
alpha_beta(min(L,R),Alpha,Beta,Score,min(TL,TR)) :-
    alpha_beta(L,Alpha,Beta,SL,TL),
    (
    SL =< Alpha ->
        TR = nil,
        Score = SL
    ;
        alpha_beta(R,Alpha,SL,SR,TR),
        Score is min(SL,SR)
    ).

alpha_beta(leaf(V,T),_,_,V,leaf(V,T)).
