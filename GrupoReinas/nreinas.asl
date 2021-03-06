/* Initial beliefs */

qfor(Y,Y,L,R):- mirafila(Y,Y,L,R,Y).

qfor(X,Y,L,K):-	X1=X+1 &
						concat(MF,R,K)&
						mirafila(X,Y,L,MF,Y) &
						qfor(X1,Y,L,R).

mirafila(X,0,L,[],S):-	ataca([X,0],L,S).
mirafila(X,0,_,[[X,0]],_).
mirafila(X,Y,L,MF,S):-	Y1=Y-1 &
						ataca([X,Y],L,S) &
						mirafila(X,Y1,L,MF,S).
mirafila(X,Y,L,[[X,Y]|MF],S):-	Y1=Y-1 &
								mirafila(X,Y1,L,MF,S).

ataca([],[],_).
ataca([X,_],[[X,_]|_],_).
ataca([_,Y],[[_,Y]|_],_).

ataca(Q,[Car|Cdr],P):-	ataca(Q,Cdr,P)|
						atacaDiag(Q,P,[Car|Cdr]).

atacaDiag([X1,X2],P,[[C1,C2]|R]):-	comprueba(X1,X2,P,[[C1,C2]|R])|
								    nextlvl([X1,X2],P,[[C1,C2]|R]).

nextlvl([X1,X2],P,[[C1,C2]|R]):-P>0 &
								P1=P-1 & 
								atacaDiag([X1,X2],P1,[[C1,C2]|R]).



comprueba(X1,X2,P,[[C1,C2]|R]):-comprueba1(X1,X2,P,C1,C2)|
						  		comprueba2(X1,X2,P,C1,C2)|
						  		comprueba3(X1,X2,P,C1,C2)|
			   			  		comprueba4(X1,X2,P,C1,C2)|
						  		comprueba5(X1,X2,P,C1,C2)|
						  		comprueba(X1,X2,P,R).


comprueba1(X1,X2,P,C1,C2):-	X1=C1+P & X2=C2+P.
comprueba2(X1,X2,P,C1,C2):-	X1=C1-P & X2=C2+P.
comprueba3(X1,X2,P,C1,C2):-	X1=C1+P & X2=C2-P.
comprueba4(X1,X2,P,C1,C2):-	X1=C1-P & X2=C2-P.
comprueba5(X1,X2,_,C1,C2):-	X1=C1 & X2=C2.						

monta([],[]).
monta([Car|Cdr],[[X,Y]|L]):- despieza(Car,X,Y) &
							 monta(Cdr,L).
						   
despieza([],[],[]).
despieza(q(X,Y),X,Y).

//limpiar(X, [X|Xs], Xs).
//limpiar(X, [Y|Ys], [Y|Zs]):- limpiar(X, Ys, Zs).


concat([], Cs, Cs).

concat([A|As],Bs,[A|Cs]):-
          concat(As, Bs, Cs).

elemrandom(L,N,E):-//rdn(L,N)&
				get(L,N,E).
				
//rdn(L,N):- longitud(L,X)&
//		N=random(X).
		
get([Car|Cdr],0,Car).
get([Car|Cdr],N,X):- N1=N-1 &
				get(Cdr,N1,X).
		  
longitud([],0).
longitud([_|T],N):-longitud(T,N0) & N=N0 + 1.

parset([X,Y],X,Y).

/* Initial goal */
!start.
/* Plans */

+!start:true <-
	.findall(q(C,D),queen(C,D),L);
	?monta(L,Lista);
	!tablero(X,Y);
	?qfor(X,Y,Lista,ListaPosibles);
	.print("Sin Limpiar: ",ListaPosibles);
	?longitud(ListaPosibles,Long);
	!aleatorio(Long-1,Num);
	?elemrandom(ListaPosibles,Num,Ele);
	?parset(Ele,Elx,Ely);
	move_towards(Ely,Elx);
	put(queen).
	
+!aleatorio(Long,Num)<-
.random(X);
Y = X*Long;
Num= math.round(Y).

	
+!tablero(X,Y):size(N)<-
	X=0;
	Y=N-1.

	
	


	


