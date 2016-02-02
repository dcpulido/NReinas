
%posibles soluciones al problema de las nreinas
%primero generamos un tablero
nreinas(N,Sol):-tablero(N,Tab),
				per(Tab,Sol),
				fin(Sol).

%la fila la señala la posicion en el vector y la columna el valor 
tablero(0,[]).
tablero(N,[N|R]):-N1 is N-1,
			  N1 >= 0,
			  tablero(N1,R).

%permutaciones sobre el tablero
per([],[]).
per(X,[C|Cdr]):-selec(X,C,R),
				per(R,Cdr).

%
selec([X|Cdr],X,Cdr).
selec([C|Cdr],X,[C|R]):-selec(Cdr,X,R).

%Compueba si ninguna reina puede comerse a otra
fin([]).
fin([X|Cdr]):-not(jaque(X,Cdr)),
			  fin(Cdr).

%Comprueba si una reina puede comerse a otra es necesario jaque/2 y jaque/3
jaque(X,P,[C|_]):-X is C+P;
				  X is C-P;
				  X=C.
jaque(X,P,[_|R]):- P1 is P + 1,
				   jaque(X,P1,R).

jaque(_,[]):-fail.
jaque(X,Y):-jaque3(X,1,Y).