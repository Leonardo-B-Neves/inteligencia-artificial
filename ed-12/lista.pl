is_repete(_ ,[]):-
    false.

is_repete(A ,[A|_]).

is_repete(A, [_|V]):-
    is_repete(A, V).


elem_repetidos([], []).

elem_repetidos([T|V], [T|J]):- 
    elem_repetidos(V, J),
    not(is_repete(T, J)),
    is_repete(T, V),
    !.

elem_repetidos([_|V], Z):-
    elem_repetidos(V, Z),
    !.

esquerda([T|V], Z, [T|K]):-
    direita(V, Z, K).

esquerda([], Z, P):-
    intercalada([], Z, P).

direita(Z, [T|V], [T|K]):-
    esquerda(Z, V, K).

direita(Z, [], P):-
    intercalada(Z, [], P).

intercalada([], [], []).

intercalada([], [T|V], [T|K]):-
    intercalada([], V, K).

intercalada([T|V], [], [T|K]):-
    intercalada(V, [], K).

intercalada(P, K, G):-
    esquerda(P, K, G).

tem_menor(_, []):-false.

tem_menor(Z, [T|_]):-
    Z > T.

insere_tudo([], []).

insere_tudo([A|S], [A|D]):-
    insere_tudo(S, D).

insercao_ord(Z, [], [Z]).

insercao_ord(Z, [Y|U], [Y|T]):-
    tem_menor(Z, [Y|U]),
    insercao_ord(Z, U, T).

insercao_ord(Z, T, [Z|K]):-
    insere_tudo(T, K).


% distribui(L,A,B) : distribui itens de L entre A e B
distribui([],[],[]).
distribui([X],[X],[]).
distribui([X,Y|Z],[X|A],[Y|B]) :- distribui(Z,A,B).

% intercala(A,B,L) : intercala A e B gerando L
intercala([],B,B).
intercala(A,[],A).
intercala([X|A],[Y|B],[X|C]) :-
X =< Y,
intercala(A,[Y|B],C).
intercala([X|A],[Y|B],[Y|C]) :-
X > Y,
intercala([X|A],B,C).

% ordena(L,S) : ordena a lista L obtendo S
ordenada([],[]).
ordenada([X],[X]).
ordenada([X,Y|Z],S) :-
distribui([X,Y|Z],A,B),
ordenada(A,As),
ordenada(B,Bs),
intercala(As,Bs,S).