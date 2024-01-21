'''
Author:K.A.Draziotis

Examples:
>p,B,C=5,-72,-162;alpha=3; # y^5=(x^3-72)(x^3-162)
>super(p,alpha,B,C)
[6,6]

>p,B,C=3,-88,-108;alpha=3; # y^3=(x^3-88)(x^3-108)
>super(p,alpha,B,C)
[[6, 24], [2, 20]]
'''
def super(p,alpha,B,C):
    
    def sf_divisors(N):
        if is_prime(N):
            return [1,N]
        L = []
        div = divisors(N)
        for x in div:
            if is_squarefree(x):
                L.append(x)
        return L
    
    def solver_thue(thue_eq,cons):
        var('x,y')
        f = thue_eq.subs(y=1)
        return gp.thue(gp.thueinit(f,1),cons)
    
    def p_free(N,p):
        # input an integer N and a prime p
        # returns all the p-free integers formed by the prime divisors of N
        import itertools
        T = []
        M = []
        lst = prime_divisors(N)
        a = (prod(lst))^(p-1)
        lst_=divisors(a)
        return lst_
    
    def rad(n):
        SF = sf_divisors(n)
        l=len(SF)
        return SF[l-1]
    
    def all_pairs(lst):
        return [(lst[i],lst[j]) for i in range(len(lst)) for j in range(i+1, len(lst))]

    M=[]
    L=[]
    n=abs((B-C)^alpha)
    A=p_free(n,p) # d1 \in A
    var('y')
    for d1 in A:
        #print(d1,rad(d1)^p/d1)
        if d1>1:
            d2=rad(d1)^p/d1
            M.append(d2) # de \in B
            L.append([d1,d2])
    T = []
    for d in L:
        #print(d)
        Th=solver_thue(d[0]*x^p - d[1]*y^p,B-C) 
        if list(Th)!=[]:
            T.append([Th,d])    
             
    for d in L:
        Th=solver_thue(-d[0]*x^p + d[1]*y^p,B-C) 
        if list(Th)!=[]:
            T.append([Th,d])

    T1 = []
    reset('x')
    f=(x^alpha+B)*(x^alpha+C)
    for z in T:
        no_of_solutions_thue=len(z[0])
        #print(len(z[0]),z)
        if no_of_solutions_thue==1:
            x_=list(list(z[0])[0])[0]
            s=(z[1][0]*x_^p-B)^(1/alpha)
            s=s.sage()
            #print(z[0],x_,z[1][0],s)
            if s.is_integer():
                t = (f.subs(x=s))^(1/p)
                if t.is_integer() and [s,t] not in T1:
                    T1.append([s,t])
            s=(-z[1][0]*x_^p-B)^(1/alpha)
            s=s.sage()
            s=s.real()
            #print(z[0],x_,-z[1][0],s)
            if s.is_integer():
                t = (f.subs(x=s))^(1/p)
                if t.is_integer() and [s,t] not in T1:
                    T1.append([s,t])
                

        if no_of_solutions_thue>1:
            for j in range(no_of_solutions_thue):
                x_=list(list(list(z)[0])[j])[0]
                s=((z[1][0]*x_^p-B)^(1/alpha))
                s=s.sage()
                #print(z[0],x_,z[1][0],s)
                if s.is_integer():
                    #print(s)
                    t = (f.subs(x=s))^(1/p)
                    if t.is_integer() and [s,t] not in T1:
                        T1.append([s,t])
            for j in range(no_of_solutions_thue):
                x_=list(list(list(z)[0])[j])[0]
                s=(-z[1][0]*x_^p-B)^(1/alpha)
                s=s.sage()
                #print(z[0],x_,z[1][0],s)
                if s.is_integer():
                    t = (f.subs(x=s))^(1/p)
                    if t.is_integer() and [s,t] not in T1:
                        T1.append([s,t])
                
            
    return T1
