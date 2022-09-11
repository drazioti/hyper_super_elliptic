'''
Author : K.A.Draziotis (email : drazioti at gmail dot com), August 2022

We are going to find the integer points (x,y) on curve y^2=(x^4-1)*g(x), g(1),g(-1),g(i),g(-i) non zero.
sage:for k in range(1,100):
...      g = x*k+3
...      A = pell_type(g)
...      if A!=[]:
...          print(A,k)
[[2, 15]] 6
[[3, 60]] 14
[[7, 600]] 21
[[3, 120]] 59
[[4, 255]] 63
[[2, 45]] 66
[[7, 1080]] 69
[[26, 30465]] 78
    
'''

def pell_type(g):
    
    def fundamental_sol(N):
        if N==1:
            return [],[]
        cf = continued_fraction(sqrt(N))
        i=1
        while true:
            denominator = cf.denominator (i)
            numerator = cf.numerator (i)
            i+=1
            if numerator^2 - N*denominator^2 == 1:
                return numerator , denominator
        
    def sf_divisors(N):
        if is_prime(N):
            return [1,N]
        L = []
        div = divisors(N)
        for x in div:
            if is_squarefree(x):
                L.append(x)
        return L
    
    L = []
    N = g.subs(x=1)*g.subs(x=-1)*g.subs(x=I)*g.subs(x=-I)
    if N==0:
        return "N=0"
    else:            
        SF = sf_divisors(int(N))
        for d in SF:
            u,v=fundamental_sol(d)
            if u!=[]:
                a=sqrt(u)
                if a.is_integer():
                    b=sqrt(g.subs(x=a)*(a^4-1))
                    if b.is_integer() and b>0:
                        L.append([a,b])
                    b=sqrt(g.subs(x=-a)*(a^4-1))
                    if b.is_integer() and b>0:
                        L.append([-a,b]) 
                a=sqrt(2*u^2-1)
                if a.is_integer():
                    b=sqrt(g.subs(x=a)*(a^4-1))
                    if b.is_integer() and b>0:
                        L.append([a,b])
                    b=sqrt(g.subs(x=-a)*(a^4-1))
                    if b.is_integer() and b>0:
                        L.append([-a,b])
    return L
