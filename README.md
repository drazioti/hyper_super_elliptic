<p float="left">
<img src="https://img.shields.io/badge/license-GPLv2-lightgrey.svg" width="80" height="25">
<img src="https://github.com/sagemath/artwork/blob/master/sage-logo-2018.svg" width="80" height="25"> 
</p>

The repository contains sagemath files for solving hyperelliptic and superelliptic diophantine equations.<br/>
The algorithms are based on the paper Descent methods for studying integer points on $y^n=f(x)g(x), n\ge 2$
<br>
https://arxiv.org/abs/2209.07909

**hyperelliptic.sage** concerns $y^2=f(x)g(x)$ where $f(x)$ is a cubic or quartic polynomial<br/>
**superelliptic.sage** concerns $y^p=(Ax^p+B)g(x)$ where $g(x)$ does not have common roots with $Ax^p+B, p$ prime<br/>
**special_case_hyperelliptic_1.sage** concerns $y^2=(x^4-1)g(x)$ where $g(x)$ does not have common roots with $x^4-1$<br/>

