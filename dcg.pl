:- consult('./familytree.pl').
:- consult('./readsentence.pl').

start :-
	writeln('Frage eingeben:'),
	read_sentence(Satz),
  question(Satz, []).

question -->
  interrogativpronomen,
  verbalphrase(Numerus, Funktion),
  nominalphrase(Name, _, _),
	[?],
	{
		write('Aufruf an: '),
		writeln(Funktion),
		call(Funktion, Result, Name),
		write('Ergebnis ist: '),
		writeln(Result)
	}.

verbalphrase(Numerus, Funktion) -->
  verb(Numerus),
	nominalphrase(_, Numerus, Funktion).

nominalphrase(_, Numerus, Funktion) -->
  artikel(Numerus),
  nomen(Numerus, Funktion).

nominalphrase(Name, singular, _) -->
  praeposition,
	name(Name).

nominalphrase(Name, singular, _) -->
  name(Name).

interrogativpronomen     --> [X]   , {lex(X, interrogativpronomen, _, _)}.
praeposition						 --> [X]   , {lex(X, praeposition, _, _)}.
verb(Numerus)				     --> [X]   , {lex(X, verb, Numerus, _)}.
artikel(Numerus)         --> [X]   , {lex(X, artikel, Numerus, _)}.
nomen(Numerus, Funktion) --> [X]   , {lex(X, nomen, Numerus, Funktion)}.
name(Name)               --> [Name], {lex(Name, name, singular, _)}.

lex(wer, interrogativpronomen, _, _).
lex(ist, verb, singular, _).
lex(sind, verb, plural, _).
lex(der, artikel, singular, _).
lex(die, artikel, singular, _).
lex(die, artikel, plural, _).
lex(das, artikel, singular, _).
lex(mutter, nomen, singular, mother).
lex(vater, nomen, singular, father).
lex(schwester, nomen, singular, sister).
lex(bruder, nomen, singular, brother).
lex(von, praeposition, _, _).

lex(Name, name, singular, _) :- gender(Name, male).
lex(Name, name, singular, _) :- gender(Name, female).
