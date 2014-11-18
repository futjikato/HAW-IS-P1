gender(alice,                 female).
gender(bob,                   male  ).
gender(carola,                female).
gender(dave,                  male  ).
gender(eve,                   female).
gender(mallory,               male  ).
gender(peggy,                 female).
gender(trent,                 male  ).
gender(trudy,                 female).
gender(victor,                male  ).
gender(ford,                  male  ).
gender(vp1_mother_bob_carola, female).
gender(vp2_father_bob_carola, male  ).
gender(vp1_mother_dave_ford,  female).
gender(vp2_father_dave_ford,  male  ).

virtual(vp2_father_bob_carola).
virtual(vp1_mother_bob_carola).
virtual(vp1_mother_dave_ford).
virtual(vp2_father_dave_ford).

married_directed(alice,  bob ).
married_directed(carola, dave).

parent(bob,    vp2_father_bob_carola).
parent(bob,    vp1_mother_bob_carola).
parent(carola, vp2_father_bob_carola).
parent(carola, vp1_mother_bob_carola).
parent(oscar,  trudy                ).
parent(peggy,  alice                ).
parent(peggy,  bob                  ).
parent(trudy,  alice                ).
parent(trudy,  mallory              ).
parent(trent,  carola               ).
parent(trent,  dave                 ).
parent(victor, alice                ).
parent(victor, bob                  ).
parent(dave,   vp2_father_dave_ford ).
parent(dave,   vp1_mother_dave_ford ).
parent(ford,   vp2_father_dave_ford ).
parent(ford,   vp1_mother_dave_ford ).



married(X, Y) :- married_directed(Y, X).
married(X, Y) :- married_directed(X, Y).

mother(M, C) :- gender(M, female), parent(C, M).
father(F, C) :- gender(F, male), parent(C, F).

daugther(X, D) :- not(gender(D, male)), parent(D, X).
son(X, S) :- gender(X, male), parent(S, X).

halfsibling(X, S) :- parent(X, P), parent(S, P), X \= S.

sibling(X, S) :- X \== S, parent(X, M), parent(S, M), gender(M, female), parent(X, F), parent(S, F), gender(F, male).

halfsister(X, S) :- gender(S, female), halfsibling(X, S), X \= S.
halfbrother(X, B) :- gender(B, male), halfsibling(X, B), X \= B.

sister(S, X) :- gender(S, female), sibling(X, S), X \= S.
brother(B, X) :- gender(B, male), sibling(X, B), X \= B.

aunt(X, A) :-  gender(A, female), sister(P, A),  parent(X, P).
uncle(X, U) :- gender(U, male),   brother(P, U), parent(X, P).

ancestor(X, A) :- parent(X, A).
ancestor(X, A) :- parent(X, P), ancestor(P, A).

anysibling(X, S) :- halfsibling(X, S).
anysibling(X, S) :- sibling(X, S).

sibling_in_law(X, L) :- anysibling(X, M), married(M, L).
sibling_in_law(X, L) :- married(X, M),    anysibling(M, L).
sibling_in_law(X, L) :- sibling_in_law(X, M), married(M, L), X \= L.
sibling_in_law(X, L) :- sibling_in_law(X, M), anysibling(M, L), X \= L.

sister_in_law(X, L) :-  gender(L, female), sibling_in_law(X, L).
brother_in_law(X, L) :- gender(L, male),   sibling_in_law(X, L).
