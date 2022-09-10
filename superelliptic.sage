def superelliptic(f,g):
    def p_free(lst,p):
        import itertools
        T = []
        M = []
        a = (prod(lst))^(p-1)
        lst_=divisors(a)
        return lst_
    
    def solver_thue(thue_eq,cons):
        var('x,y')
        f = thue_eq.subs(y=1)
        return gp.thue(gp.thueinit(f,1),cons)
    
    p=f.degree(x)
    T = []
    var('u,v,y')
    R0 = (u^p-f).resultant(v^p-g,x).subs(u=0,v=0).expand().factor() 
    lst = prime_divisors(int(R0))
    print lst
    lst = p_free(lst,p)
    for d in lst:
        Th=solver_thue(d*y^p - f.leading_coeff(x)*x^p,f.subs(x=0)) 
        if list(Th)!=[]:
            T.append(Th)
            
    for d in lst:
        Th=solver_thue(-d*y^p - f.leading_coeff(x)*x^p,f.subs(x=0)) 
        if list(Th)!=[]:
            T.append(Th)
    T1 = []
    for z in list(T):
        if len(z)==1:
            a = int(list(list(z)[0])[0]) # this is x
            b = int(list(list(z)[0])[1]) # this is y
            temp=(f.subs(x=a)*g.subs(x=a))^(1/p)
            if temp.is_integer() and [a,temp] not in T1:            
                T1.append([a,temp])
        if len(z)>1:
            for j in range(len(z)):
                a = int(list(list(z)[j])[0]) # this is x
                b = int(list(list(z)[j])[1]) # this is y
                #if b^p==f.subs(x=a)*g.subs(x=a):
                temp = (f.subs(x=a)*g.subs(x=a))^(1/p)
                if temp.is_integer() and [a,temp] not in T1:
                    T1.append([a,temp])    
    print T1

    
