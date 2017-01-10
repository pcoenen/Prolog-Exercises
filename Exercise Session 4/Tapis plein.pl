% Example knowledge base
house(5,4).
wall(v,2,3,4).
wall(v,3,0,1).
wall(v,4,0,1).
wall(h,2,3,5).
color(1,1,green).
color(1,2,red).
color(3,1,red).
color(4,0,blue).

wall_in_part(part(Xco1,Yco1,Xco2,Yco2),wall(v,X,Y1,Y2)):-
    wall(v,X,Y1,Y2),
    Xco1 < X,
    Xco2 > X,
    Yco1 =< Y1,
    Yco2 >= Y2.

wall_in_part(part(Xco1,Yco1,Xco2,Yco2),wall(h,Y,X1,X2)):-
    wall(h,Y,X1,X2),
    Xco1 =< X1,
    Xco2 >= X2,
    Yco1 < Y,
    Yco2 > Y.

color_in_part(part(Xco1,Yco1,Xco2,Yco2),color(X,Y,C)):-
    color(X,Y,C),
    Xco1 =< X,
    Xco2 > X,
    Yco1 =< Y,
    Yco2 > Y.

single_color_present(Part):-
    findall(C,color_in_part(Part,C),L),
    length(L,Len),
    Len =< 1.

part_has_wall(Part):-
    findall(W,wall_in_part(Part,W),L),
    length(L,Len),
    Len > 0.

cut_plan(Plan,Parts):-
    house(MaxX,MaxY),
    cut(part(0,0,MaxX,MaxY),Plan,P),
    sort(P,Parts).

cut(Part,[],[Part]):-
    single_color_present(Part),
    \+ part_has_wall(Part).

cut(part(Xco1,Yco1,Xco2,Yco2),[cut(h,Y,Xco1,Xco2)|Plan],Parts):-
    wall_in_part(part(Xco1,Yco1,Xco2,Yco2),wall(h,Y,_,_)),
    cut(part(Xco1,Yco1,Xco2,Y),Plan1,Parts1),
    cut(part(Xco1,Y,Xco2,Yco2),Plan2,Parts2),
    append(Plan1,Plan2,Plan),
    append(Parts1,Parts2,Parts),
    !.

cut(part(Xco1,Yco1,Xco2,Yco2),[cut(v,X,Yco1,Yco2)|Plan],Parts):-
    wall_in_part(part(Xco1,Yco1,Xco2,Yco2),wall(v,X,_,_)),
    cut(part(Xco1,Yco1,X,Yco2),Plan1,Parts1),
    cut(part(X,Yco1,Xco2,Yco2),Plan2,Parts2),
    append(Plan1,Plan2,Plan),
    append(Parts1,Parts2,Parts),
    !.
    
    
