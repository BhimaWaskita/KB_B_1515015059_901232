	predicates 
	
	nondeterm
	id(long,symbol)
	nondeterm
	semua(long,symbol)	
	nondeterm
	motif(symbol,symbol)
	
	clauses

	id(2012021915,yuda).
	id(2012021916,ndra).
	id(2012021919,black).
	id(2012021918,panther).
	id(2012021919,rocon).
	
	semua(Info,Suspect):-
	id(Info,Suspect).
			
	motif(blacklist,teror).
	motif(kriminal,virus).
	motif(penipuan,teror).
	motif(dendam,racun).	
	
	goal

	id(Info,Suspect),
	Info=2012021919,
	motif(Kasus,Bukti),
	Kasus=kriminal,
	Bukti=virus.