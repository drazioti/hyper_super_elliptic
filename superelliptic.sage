'''
initial author : K.A.Draziotis (email : drazioti at gmail dot com), August 2022

We are going to find the integer points (x,y) on curve y^p=(Ax^p+B)*g(x), with p odd prime
sage:superelliptic(1,-625,x-1,3) # we solve y^3=(x^3-625)(x-1)
     [[10, 15], [-15, 40], [1, 0]]


'''


def superelliptic(A,B,g,p):
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
    
    f = A*x^p+B
    T = []
    var('u,v,y')
    R0 = (u^p-f).resultant(v^p-g,x).subs(u=0,v=0).expand().factor() 
    lst = prime_divisors(int(R0))
    #print lst
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
