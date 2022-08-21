'''
initial author : K.A.Draziotis (email : drazioti at gmail dot com), August 2022

sage:C([0,1,1],x^4+2*x^3-3*x^2+4*x+4)
# we are going to find the integer points (x,y) on curve y^2=(x^3+x+1)*(x^4+2*x^3-3*x^2+4*x+4), with y>0
...[[0, 2], [3, 62], [-1, 2], [-2, 12]]

'''


def C(L,g): # L=[A,B,C] : y^2=x^3+Ax^2+Bx+C
    A,B,C=L[0],L[1],L[2]
    
    def sf_divisors(N):
        if is_prime(N):
            return [1,N]
        L = []
        div = divisors(N)
        for x in div:
            if is_squarefree(x):
                L.append(x)
        return L
    
    f = x^3 + A*x^2 + B*x + C
    var('u,v')
    f1 = u^2 - f
    g1 = v^2 - g
    R0 = f1.resultant(g1,x).subs(u=0,v=0)
    #print("Resultant:", R0)
    SF_d = sf_divisors(R0)
    sols = []

    for d in SF_d:
        d = int(d)
        E = EllipticCurve([0,A*int(d),0,B*int(d)^2,C*int(d)^3])
        L = E.integral_points()
        L1 = []
        for P in L: 
            if P[1]!=0: # if y!=0
                L1.append(P)
        for Q in L1: # Q are integer points on E with y!=0
            if int(Q[0])%d==0:
                sols.append(Q[0]/d)        
    for d1 in SF_d:
        d = -d1
        E = EllipticCurve([0,A*int(d),0,B*int(d)^2,C*int(d)^3])
        L = E.integral_points()
        L1 = []
        for P in L:
            if P[1]!=0:
                L1.append(P)
        for Q in L1:
            if int(Q[0])%d==0:
                sols.append(Q[0]/d)
                
    H =  f * g
    SOLS = []
    for z in sols:
        S = H.subs(x=z)
        if is_square(S) and S!=0::
            SOLS.append([z,sqrt(S)])
    print SOLS
        
'''
We are going to find the integer points on 
the hyperelliptic curve, defined by the equation 
y^2=x*(x-1)*(x-2)*(x + 40)*(x + 4)*(x - 4)*(x - 7)
This curve is fo genus 3.
sage: x,y,z = PolynomialRing(QQ, 3, names='x,y,z').gens()
sage: F = y^2*z^5 - x*(x-z)*(x-2*z)*(x + 40*z)*(x + 4*z)*(x - 4*z)*(x - 7*z)
sage: C = Curve(F)
sage: C.genus()
      3
To find the integer points we execute,
sage:C([0,1,2],(x + 40)*(x + 4)*(x - 4)*(x - 7))
     [[16, 20160], [-7, 2772]]
'''

def C_(L,g): # L=[a1,a2,a3] : y^2=(x-a1)(x-a2)(x-a3)
    a1,a2,a3=L[0],L[1],L[2]
    f = (x-a1)*(x-a2)*(x-a3)
    f=f.expand()
    A,B,C=f.coefficient(x,2),f.coefficient(x,1),f.coefficient(x,0)
    
    def sf_divisors(N):
        if is_prime(N):
            return [1,N]
        L = []
        div = divisors(N)
        for x in div:
            if is_squarefree(x):
                L.append(x)
        return L
    
    f = x^3 + A*x^2 + B*x + C
    var('u,v')
    f1 = u^2 - f
    g1 = v^2 - g
    R0 = f1.resultant(g1,x).subs(u=0,v=0)
    SF_d = sf_divisors(abs(int(R0)))
    sols = []
    for d in SF_d:
        d = int(d)
        E = EllipticCurve([0,int(A)*int(d),0,int(B)*int(d)^2,int(C)*int(d)^3]) # y^2 = x^3 + A*d*x^2 + B*d^2*x + d^3*C
        L = E.integral_points()
        L1 = []
        for P in L: 
            if P[1]!=0: # if y!=0
                L1.append(P)
        for Q in L1: # Q are integer points on E with y!=0
            if int(Q[0])%d==0:
                sols.append(Q[0]/d)        
    for d1 in SF_d:
        d = -d1
        E = EllipticCurve([0,int(A)*int(d),0,int(B)*int(d)^2,int(C)*int(d)^3])
        L = E.integral_points()
        L1 = []
        for P in L:
            if P[1]!=0:
                L1.append(P)
        for Q in L1:
            if int(Q[0])%d==0:
                sols.append(Q[0]/d)
                
    H =  f * g
    SOLS = []
    for z in sols:
        S = H.subs(x=z)
        if is_square(S) and S!=0:
            SOLS.append([z,sqrt(S)])
    print SOLS 
