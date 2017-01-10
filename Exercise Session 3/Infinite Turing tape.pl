% move/3: Moves the head in a certain direction.
move(right,pair(L,[]),pair([#|L],[])).
move(left,pair([],R),pair([],[#|R])).
move(right,pair(L,[X|R]),pair([X|L],R)).
move(left,pair([X|L],R),pair(L,[X|R])).

% read/2: Reads the symbol under the head.
read_tape(pair(_,[]),#).
read_tape(pair(_,[X|_]),X).

% write/3: Writes a symbol under the head.
write_tape(X,pair(L,[_|R]),pair(L,[X|R])).
