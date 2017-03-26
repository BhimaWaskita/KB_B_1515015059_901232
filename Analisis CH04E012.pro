/*****************************************************************************

		Copyright (c) 1984 - 2000 Prolog Development Center A/S

 Project:  
 FileName: CH04E12.PRO
 Purpose: 
 Written by: PDC
 Modifyed by: Eugene Akimov
 Comments: 
******************************************************************************/

trace %Data yang tidak penting , jika dihapus tidak membuat program error atau tidak menyebabkan masalah pada program
domains
  name,sex,occupation,object,vice,substance = symbol		%deklarasi variabel-variabel yang dipakai yang tidak ada pada bahasa prolog menjadi bahasa prolog
  age=integer

predicates
  person(name,age,sex,occupation) - nondeterm (o,o,o,o), nondeterm (i,o,o,i), nondeterm (i,o,i,o)		%pendeklarasian pola-pola atau predikat yang dipakai dalam program 
  had_affair(name,name) - nondeterm (i,i), nondeterm (i,o)
  killed_with(name,object) - determ (i,o)
  killed(name) - procedure (o)
  killer(name) - nondeterm (o)
  motive(vice) - nondeterm (i)
  smeared_in(name,substance) - nondeterm (i,o), nondeterm (i,i)
  owns(name,object) - nondeterm (i,i)
  operates_identically(object,object) - nondeterm (o,i)
  owns_probably(name,object) - nondeterm (i,i)
  suspect(name) - nondeterm (i)

/* * * Facts about the murder * * */
clauses
  person(bert,55,m,carpenter).					%pendeklarasian isi dari sebuah predikat-predikat yang sudah di inisialisasikan pada section diatas dengan sesuai polanya
  person(allan,25,m,football_player).
  person(allan,25,m,butcher).
  person(john,25,m,pickpocket).

  had_affair(barbara,john).
  had_affair(barbara,bert).
  had_affair(susan,john).

  killed_with(susan,club).
  killed(susan).

  motive(money).
  motive(jealousy).
  motive(righteousness).

  smeared_in(bert,blood).
  smeared_in(susan,blood).
  smeared_in(allan,mud).
  smeared_in(john,chocolate).
  smeared_in(barbara,chocolate).

  owns(bert,wooden_leg).
  owns(john,pistol).

/* * * Background knowledge * * */

  operates_identically(wooden_leg, club).
  operates_identically(bar, club).
  operates_identically(pair_of_scissors, knife).
  operates_identically(football_boot, club).

  owns_probably(X,football_boot):-		%X = Jika orang/person memiliki football boot maka X merupakan football player , Underscore berarti data yang ada tidak ditampilkan atau dilewati
	person(X,_,_,football_player).
  owns_probably(X,pair_of_scissors):-		%X = Jika orang/person memiliki sepasang gunting maka X merupakan penata rambut , Keterangan tentang underscore dapat dilihat pada bagian diatas
	person(X,_,_,hairdresser).
  owns_probably(X,Object):-			%Jika si X kemungkinan memiliki Object maka X memiliki Object , Ini merupakan bentuk dari backtracking
	owns(X,Object).

/* * * * * * * * * * * * * * * * * * * * * * *
 * Suspect all those who own a weapon with   *
 * which Susan could have been killed.       *
 * * * * * * * * * * * * * * * * * * * * * * */

  suspect(X):-					%Suspect dengan parameter X adalah Susan dibunuh dengan senjata lalu Object Diidentifikasi dengan senjata yang berkemungkinan X memiliki Object senjata
  
	killed_with(susan,Weapon) ,
	operates_identically(Object,Weapon) ,
	owns_probably(X,Object).

/* * * * * * * * * * * * * * * * * * * * * * * * * *
 * Suspect men who have had an affair with Susan.  *
 * * * * * * * * * * * * * * * * * * * * * * * * * */

  suspect(X):-					%Suspect dengan parameter X adalah dengan motif jealousy yang dengan person X yang pada pola itu adalah nama dan susan pernah terkait dengan nama tersebut
	motive(jealousy),
	person(X,_,m,_),
	had_affair(susan,X).

/* * * * * * * * * * * * * * * * * * * * *
 * Suspect females who have had an       *
 * affair with someone that Susan knew.  *
 * * * * * * * * * * * * * * * * * * * * */

  suspect(X):-					%Suspect dengan parameter X adalah motif jealousy yang dengan person X yang pada pola adalah nama orang yang terkait dengan Man yang disini adalah nama juga.
	motive(jealousy),
	person(X,_,f,_),
	had_affair(X,Man),
	had_affair(susan,Man).

/* * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Suspect pickpockets whose motive could be money.  *
 * * * * * * * * * * * * * * * * * * * * * * * * * * */

  suspect(X):-					%Suspect dengan parameter X adalah dengan motif money yang dimana person X = nama yang memiliki pekerjaan sebagai pickpocket
	motive(money),
	person(X,_,_,pickpocket).

  killer(Killer):-				%Killer dengan parameter Killer ini adalah dimana person Nama Killer dengan nama Killed . Apabila Killed dan Killer adalah nama yang berbeda maka itu tidak suicide dengan suspect Killer .
	person(Killer,_,_,_),
	killed(Killed),
	Killed <> Killer, /* It is not a suicide */
	suspect(Killer),
	smeared_in(Killer,Goo),
	smeared_in(Killed,Goo).

goal
  killer(X).					%Memanggil predikat killer dengan parameter X sebagai hasil dari Procedure diatas