domains
    l = integer*
    
predicates
    printlist(l)
    
clauses
    printlist([]).
    
    printlist([X|List]) :-
        write(X),nl,
        printlist(List).

Goal: printlist([1,2,3,4,5,6,7,8,9,0]).