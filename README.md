# Retraction based Direct Search Methods for Derivative Free Riemannian Optimization
We consider derivative free algorithms for the solution of the following problem

         min f(x)
    s.t. x in M,
    
with M Riemannian manifold. The algorithms we consider are direct search and direct search with extrapolation variants for smooth and non smooth objectives, as well as 
a zeroth order method analyzed in the previous work [2] for smooth objectives. The instances we consider are a standard set of Riemannian optimization problems (see the
main paper [1] for details). The direct search methods we consider are provably convergent to first order stationary points. 

## Reference papers

[1] V. Kungurtsev, F. Rinaldi, D. Zeffiro (2022). _Retraction based Direct Search Methods for Derivative Free Riemannian Optimization_. Pre-print available at <https://arxiv.org/abs/2202.11052>.

[2] J. Li, K. Balasubramanian, S. Ma (2020). _Zeroth-order optimization on Riemannian manifolds_. Pre-print available at <https://arXiv.ord/abs/2003.11238>.

## Authors

* Vyacheslav Kungurtsev  (e-mail: [kunguvya@fel.cvut.cz](mailto:kunguvya@fel.cvut.cz)
* Francesco Rinaldi (e-mail: [rinaldi@math.unipd.it](mailto:rinaldi@math.unipd.it))
* Damiano Zeffiro (e-mail: [zeffiro@math.unipd.it](mailto:zeffiro@math.unipd.it))

## Licensing

riemannian-direct-search is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.
s_defective_fw is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU General Public License for more details.
You should have received a copy of the GNU General Public License
along with s_defective_fw. If not, see <http://www.gnu.org/licenses/>.

## How to use the algorithms

1. The codes require the MANOPT <https://www.manopt.org/> library 

2. This directory should contain the following elements:
    * `smooth`,
    * `non smooth`,
    * `README.md`
3. In the "smooth" and "non smooth" folders the algorithms for the smooth and the non smooth case can be found respectively, together with detailed instrunctions on how to use them. 
  

