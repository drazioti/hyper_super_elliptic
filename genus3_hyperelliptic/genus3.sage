R.<x> = PolynomialRing(ZZ)  # Define a polynomial ring over the rationals
# Below we insert all the polynomials from the list : list.txt
# This list contains all the genus three hyperelliptic curves with absolute discriminant <10^7 and
# Jacobian of rank zero.
L=[]
with open('list.txt', 'r') as file:
    content = file.read()

# Strip out 'L = ' to get the actual list part
content = content.strip().split('=', 1)[-1].strip()

# Replace ^ with ** for exponentiation
content = content.replace('^', '**')

# Use eval to evaluate the list of polynomials
L = eval(content)


d=[]
i=0;
for f in L:
    flag=[]
    factors = f.factor()  # Factor the polynomial
    degrees = [g.degree() for g, _ in factors]  # Get degrees of each factor
    for h,_ in factors:
        if h.degree() == 3 and h.leading_coefficient()==1 and all(c.denominator() == 1 for c in h.coefficients()):
            flag.append(['check'])
            i+=1
            d.append([h,f/h,flag])
            break

def C(L,g): # L=[A,B,C] : y^2=x^3+Ax^2+Bx+C
    A,B,C=L[0],L[1],L[2]
    
    def sf_divisors(N):
        if is_prime(abs(N)):
            return [1,N]
        L = []
        div = divisors(abs(N))
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
    SF_d = sf_divisors(int(R0))
    #print(SF_d)
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
        if is_square(int(S)) and S!=0:
            SOLS.append([z,sqrt(S)])
    return SOLS,f*g


for i in range(len(d)):
    if i!=216 and i!=454 and i!=616 and i!=621 and i!=742 and i!=763: # For six curves sagemath failed to compute the integer points
        f=d[i][0]
        a,b,c=f.coefficient(2),f.coefficient(1),f.coefficient(0)
        print(i,"",C( [a,b,c], d[i][1] ))
