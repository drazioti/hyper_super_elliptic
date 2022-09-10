![GPLv2][]

[GPLv2]: https://img.shields.io/badge/license-GPLv2-lightgrey.svg

The repository contains sagemath files for solving specific quartic hyperelliptic equations.<br/>
The algorithms based on the paper https://arxiv.org/pdf/2207.10754.pdf

**1.py** concerns y^2=(x+a)(x+a+k)(x+b)(x+b+k)<br/>
**2.py** concerns y^2=c^2x^4+ax^2+b<br/>
**3.py** concerns cy^2 = cx^4+ax^2+b<br/>
**4.txt** it contains the integer points of y^2=x^4-2^{ell}x^2+1,  ell=80,...,120<br/>
**general_quartic.py** it contains code for solving <br/>y^2=x^4+ax^3+bx^2+cx+d<br/>y^2=c^2x^4+ax^2+b and <br/>cy^2 = cx^4+ax^2+b.<br/><br/>
You can try the code in https://sagecell.sagemath.org/
