'''
Author : K.A.Draziotis (email : drazioti at gmail dot com), August 2022

We are going to find the integer points (x,y) on curve y^2=(x^4-1)*(kx+3), 1<=k<=1000.

sage:for k in range(1,1000):
...      g = x*k+3
...      A = pell_type(g)
...      if A!=[]:
...          print(A,k)
[[2, 15]] 7
[[5, 312]] 31
[[2, 45]] 67
[[5, 468]] 70
[[10, 3333]] 111
[[2, 75]] 187
[[17, 20880]] 307
[[2, 105]] 367
[[5, 1092]] 382
[[5, 1248]] 499
[[2, 135]] 607
[[26, 91395]] 703
[[2, 165]] 907     
'''

def pell_type(g):
    def solve_pell (N , numTry = 100):
        cf = continued_fraction( sqrt ( N ))
        for i in range ( numTry ):
            denom = cf . denominator ( i )
            numer = cf . numerator ( i )
            if numer ^2 - N * denom ^2 == 1:
                return numer , denom
        return None , None
        
    def sf_divisors(N):
        if is_prime(N):
            return [1,N]
        L = []
        div = divisors(N)
        for x in div:
            if is_squarefree(x):
                L.append(x)
        return L
    
    if g.subs(x=1)==0 or g.subs(x=-1)==0 or g.subs(x=I)==0 or g.subs(x=-I)==0:
        return "Choose new g"
    
    L = []
    N = g.subs(x=1)*g.subs(x=-1)*g.subs(x=I)*g.subs(x=-I)
    if N!=0:            
        SF = sf_divisors(int(N))
        for d in SF:
            u,v=solve_pell(d)
            if u!=None:
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
