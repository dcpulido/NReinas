%
posibles soluciones al problema de las nreinas
%primero generamos un tablero
nreinas(N,Sol):-tablero(N,Tab),
				per(Tab,Sol),
				fin(Sol).
%la localizacion de las reinas sobre el tablero se indica de manera 
%que la fila viene dada por la posicion en la lista y la columna por el valor dado en la posicion 
tablero(0,[]).
tablero(N,[N|R]):-N1 is N-1,
			  N1 >= 0,
			  tablero(N1,R).

%permutaciones sobre el tablero
per([],[]).
per(X,[C|Cdr]):-selec(X,C,R),
				per(R,Cdr).

%selec devuelve la lista sin el elemento X
selec([X|Cdr],X,Cdr).
selec([C|Cdr],X,[C|R]):-selec(Cdr,X,R).

%Compueba si ninguna reina puede comerse a otra
fin([]).
fin([X|Cdr]):-not(jaque(X,Cdr)),
			  fin(Cdr).

%Comprueba si una reina puede comerse a otra es necesario jaque/2 y jaque/3
jaque3(X,P,[C|_]):-X is C+P;
				  X is C-P;
				  X=C.
jaque3(X,P,[_|R]):- P1 is P + 1,
				   jaque3(X,P1,R).

jaque(_,[]):-fail.
jaque(X,Y):-jaque3(X,1,Y).