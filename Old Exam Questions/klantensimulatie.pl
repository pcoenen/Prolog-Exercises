width(8).
height(6).
storechain(red).
storechain(blue).
storechain(yellow).
store(red, pos(1,1), [sells(chocolate,65), sells(water,12), sells(bread,25)]).
store(red, pos(7,4), [sells(chocolate,50), sells(water,13), sells(bread,28)]).
store(blue, pos(3,3), [sells(chocolate,80), sells(water,10), sells(bread,30)]).
store(yellow, pos(6,0), [sells(chocolate,60), sells(water,13), sells(bread,28)]).
customer(cust1, pos(3,2), 5, [needs(chocolate,2), needs(water,15), needs(bread,10)]).
customer(cust2, pos(2,4), 3, [needs(chocolate,5), needs(water,20), needs(bread,13)]).
customer(cust3, pos(6,3), 3, [needs(chocolate,1), needs(water,50), needs(bread,15)]).
customer(cust4, pos(6,2), 6, [needs(chocolate,2), needs(water,10), needs(bread,8)]).
customer(cust5, pos(5,1), 2, [needs(chocolate,3), needs(water,35), needs(bread,12)]).

cust_buys(CustomerID,Product,purchase(CustomerID,Amount,Product,MinPrice,SC,StorePos)):-
    customer(CustomerID,Pos1,CustStamina,NL),
    findall([Price,Dis,Pos2,SC],(store(SC,Pos2,LP),member(sells(Product,Price),LP),distance(Pos1,Pos2,Dis),Dis =< CustStamina),ShopList),
    sort(ShopList,[[MinPrice,_,StorePos,SC]|_]),
    member(needs(Product,Amount),NL).

distance(pos(X1,Y1),pos(X2,Y2),Distance):-
    Distance is abs(X2-X1) + abs(Y2-Y1).

get_revenue_for_transactions(SC,[],revenue(SC,0)).
get_revenue_for_transactions(SC,[purchase(_,Amount,_,Price,SC,_)|R],revenue(SC,Revenue)):-
    !,
    get_revenue_for_transactions(SC,R,revenue(SC,R2)),
    Revenue is Amount * Price + R2.

get_revenue_for_transactions(SC,[_|R],Revenue):-
    get_revenue_for_transactions(SC,R,Revenue).
    
red_place_store(NewPos, NewRevenues):-
    findall(Purs,(customer(Cust,_, _, Needs), member(needs(Prod,_),Needs), calc_buy(Cust,Prod,Purs,NewPos)),PursList),
    findall(Rev,(storechain(Shop),get_revenue_for_transactions(Shop,PursList,Rev)),NewRevenues).

calc_buy(C,P,purchase(C,Amount,Product,PriceC,StoreC,PosC),NewPos):-
    cust_buys(C,P,purchase(C,Amount,Product,Price,Store,StorePos)),
    customer(C,CPos,CustStamina,_),
    distance(CPos,NewPos,DisN),
    distance(CPos,StorePos,DisO),
    DisN =< CustStamina,
    !,
    new_price(NewPos,P,NP),
    (    
    NP < Price ->
        PriceC = NP,
        StoreC = red,
        PosC = NewPos
    ;
        (
        (NP == Price, DisN < DisO) ->
            PriceC = NP,
            StoreC = red,
            PosC = NewPos
        ;
            PriceC = Price,
            StoreC = Store,
            PosC = StorePos
        )
    ).

calc_buy(C,P,purchase(C,Amount,Product,Price,Store,StorePos),_):-
    cust_buys(C,P,purchase(C,Amount,Product,Price,Store,StorePos)).


new_price(Pos,Product,Price):-
    findall(P,(store(_, PosStore, SL),member(sells(Product,P),SL),distance(Pos,PosStore,D),D<3),List),
    length(List,L),
    (
    L =:= 0 ->
        Price = 100
    ;
        sort(List,[Price|_])
    ).
