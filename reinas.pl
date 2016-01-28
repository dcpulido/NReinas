
%posibles soluciones al problema de las nreinas
%primero generamos un tablero
nreinas(N,Sol):-tablero(N,Tab),
				per(Tab,Sol),
				fin(Sol).

tablero(0,[]).
tablero(N,[N|R]):-N1 is N-1,
			  N1 > 0,
			  tablero(N1,R).

per([],[]).
per(X,[C|Cdr]):-selec(X,C,R),
				per(R,Cdr).


selec([X|Cdr],X,Cdr).
selec([C|Cdr],X,[C|R]):-selec(Cdr,X,R).