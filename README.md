![GPLv2][]

[GPLv2]: https://img.shields.io/badge/license-GPLv2-lightgrey.svg

The repository contains sagemath files for solving hyperelliptic and superelliptic diophantine equations.<br/>
The algorithms are based on the paper https://arxiv.org/pdf/2207.10754.pdf

**hyperelliptic.sage** concerns y^2=f(x)g(x) where f(x) is a cubic or quartic polynomial<br/>
**superelliptic.sage** concerns y^p=(Ax^p+B)g(x) where g(x) does not have common roots with Ax^p+B, p prime<br/>
**special_case_hyperelliptic_I.sage** concerns y^2=(x^4-1)g(x) where g(x) does not have common roots with x^4-1<br/>

