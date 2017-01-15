guest("bruno").
guest("sandra").
guest("stephen").

drinks("bruno","margarita").
drinks("sandra","bloody_mary").
drinks("stephen","bloody_mary").

drinks_minimum("bruno",1).
drinks_minimum("sandra",1).
drinks_minimum("stephen",1).
drinks_maximum("bruno",4).
drinks_maximum("sandra",2).
drinks_maximum("stephen",1).

ingredient("margarita","limes").
ingredient("margarita","tequilla").
ingredient("bloody_mary","tomatoes").
ingredient("bloody_mary","vodka").

guest_carry_capacity("sandra",1).
guest_carry_capacity("bruno",2).
guest_carry_capacity("stephen",1).

dislikes("bruno","sandra").

store("carefour").
store("aldi").
store("delhaize").

sells("carefour","limes").
sells("carefour","tequilla").
sells("aldi","tomatoes").
sells("delhaize","vodka").

drink_order(OL):-
    findall(G,guest(G),GuestList),
    get_orders(GuestList,OL),
    check_constr(OL).

check_constr(OL):-
    findall(G,dislikes(G,_),DislikeList),
    check_dislike(DislikeList,OL),
    check_carry(OL).


check_carry(OL):-
    needed_ingredients(OL,IS),
    findall(A,guest_carry_capacity(_,A),Carry),
    sum_list(Carry,Max),
    length(IS,L),
    L =< Max.   
    
check_dislike([],_).
check_dislike([G|GL],OL):-
    dislikes(G,D),
    member(order(G,OL1),OL),
    member(order(D,OL2),OL),
    length(OL1,L1),
    length(OL2,L2),
    L1 > L2,
    check_dislike(GL,OL).

  
get_orders([],[]).  
get_orders([G|GL],OL):-
    getorder(G,[],O1),
    get_orders(GL,O2),
    OL = [order(G, O1)|O2].
 
getorder(G,Acc,Acc):-
    length(Acc,L),
    drinks_minimum(G,Min),
    L >= Min.

getorder(G,Acc,O):-
    length(Acc,L),
    drinks_maximum(G,Max),
    L < Max,
    drinks(G,C),
    getorder(G,[C|Acc],O).

needed_ingredients(OL,IS):-
    findall(C,member(order(_,C),OL),CocktailList),
    append(CocktailList,Cocktails),
    list_to_set(Cocktails,Set),
    findall(I,(member(C,Set),ingredient(C,I)),IL),
    list_to_set(IL,IS).

shopping_list(OL,R):-
    needed_ingredients(OL,IL),
    findall(G,guest(G),GuestList),
    shopping_lists(GuestList,IL,R),
    findall(G,dislikes(G,_),DislikeList),
    check_list(DislikeList,OL,R).

check_list([],_,_).
check_list([G|GL],OL,R):-
    dislikes(G,DP),
    member(order(G,GO),OL),
    member(order(DP,DO),OL),
    findall(I,(member(C,GO),ingredient(C,I)),GI),
    findall(I,(member(C,DO),ingredient(C,I)),DI),
    subtract(GI,DI,NotBuy),
    member(shopat(G,_,BL),R),
    length(BL,L1),
    subtract(BL,NotBuy,BL2),
    length(BL2,L2),
    L1 =\= L2,
    check_list(GL,OL,R).

shopping_lists([],[],[]).
shopping_lists([G|GL],IL,R):-
    store(W),
    shoplist(G,IL,W,[],R1),
    subtract(IL,R1,Rest),
    shopping_lists(GL,Rest,R2),
    R = [shopat(G, W, R1)|R2].

shoplist(_,_,_,Acc,Acc):-
    length(Acc,L),
    L >= 1.

shoplist(G,IL,W,Acc,R):-
    length(Acc,L),
    guest_carry_capacity(G,Max),
    L =< Max,
    member(P,IL),
    sells(W,P),
    delete(IL,P,IN),
    shoplist(G,IN,W,[P|Acc],R).

    
