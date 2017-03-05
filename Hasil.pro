predicates
nondeterm
 hasil(symbol,long,symbol,long,symbol) 
  track(symbol,long,symbol,long,symbol) 
  notasi(symbol,long,symbol,long,symbol)

clauses
  hasil(bhima,1919019090,acer,28111997,rsudhospital).
  hasil(bob,1919019023,asus,19011997,rsudhospital).
  hasil(kuy,1919019055,rog,12011997,galaxycafe).

  track(bro,1919019090,ioi,28111997,galaxycafe).
  track(kriss,1919019023,sps,19011997,kriptoncafe).
  track(logan,1919019022,rog,12011997,idmmarket).

  notasi(User,Ip,Type,Date,Range):-
	hasil(User,Ip,Type,Date,Range);
	track(User,Ip,Type,Date,Range).

goal
  hasil(User,Ip,Models,Date,X),X=rsudhospital.
  
  
  /* kata-kata dari disusun dari susunan symbol yang artinya user, long yang artinya ip , symbol yang artinya type , long yang artinya tanggal , dan X yang artinya sesuai dengan yang di ingin dicarikan  */
