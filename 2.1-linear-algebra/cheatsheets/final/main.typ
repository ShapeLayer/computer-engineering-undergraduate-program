#import "@preview/cetz:0.2.2"
#import "@preview/fletcher:0.5.0" as fletcher: diagram, node, edge
#import cetz.draw: *

#let subtext(content) = {
  text(size: .5em, fill: luma(40%))[#content]
}
#set page("a4",
  flipped: true,
  columns: 3,
  margin: (x: 10pt, y: 10pt),
  header: subtext([선형대수학 기말고사 대응]),
  footer: subtext(align(right)[by Park, Jonghyeon])
)
#let serif = ("Noto Serif CJK KR", )
#let sans = ("Noto Sans CJK KR", "Gothic A1", )
#set text(
  font: serif,
  size: 5.7pt
)
#set table(
  stroke: .05em,
  align: horizon,
  inset: 3pt
)
#let c(content) = {
  table.cell(align: center + horizon)[#content]
}

== Real Vector Space
=== Axioms
1. #super("s") Closed under vector addiction \
  $bold(u)$ and $bold(v)$ are objects in V, then $bold(u) + bold(v)$ is in $V$.
2. Comutating under vector addiction \
  $bold(u) + bold(v) = bold(v) + bold(u)$
3. Associativity under vector addiction \
  $bold(u) + (bold(v) + bold(w)) = (bold(v) + bold(u)) + bold(w)$
4. Identity for vector addiction \
  $bold(u) + bold(0) = bold(0) + bold(u)$
5. Inverse of $bold(u)$ for vector addiction \
  $bold(u) + (-bold(u)) = (-bold(u)) + bold(u)$
6. #super("s") Closed under scalar multiplication \
  About scalar $k$ and $bold(u)$ that any object in $V$, $k bold(u)$ is in $V$.
7. #super("d") $k(bold(u) + bold(v)) = k bold(u) + k bold(v)$
8. #super("d") $(k + m) bold(u) = k bold(u) + m bold(u)$
9. #super("d") Associativity for scalar multiplication \
  $k(m bold(u)) = (k m)(bold(u))$
10. #super("d") Identity for scalar multiplication \
  $1bold(u) = bold(u)$

== Subspaces

$W$, subset of vector space $V$ is vector space too?
- Subspace test: check axiom 1 and 6.

$W_1, W_2, ..., W_r subset V$ ($W_i$ are subspaces of $V$) \
then $W_1 sect W_2 sect ... sect W_r subset V$ (is subspace of $V$)

$W = {bold(x) | A bold(x) = bold(0)}$
- $W$ = Solutiuon space
- Subspace of $RR^n$

Kernel \
$A$ is $m times n$ matrix \
$T_A: RR^n arrow.r RR^m$
- 공역의 $bold(0)$(trivial solution)으로 매핑되는 정의역의 집합을 Kernel, 핵으로 칭한다.
- Kernel = Solution space, Subspace of $RR$

== Spanning Sets

$S = {bold(v_1), bold(v_2), ..., bold(v_r)} subset V$ \
$W = {k_1 bold(v_1) + k_2 bold(v_2) + ... + k_r bold(v_r) | k_1, k_2, ... , k_r in R}$ \
- $W$는 $V$의 Subspace
- $V$에서 $r$개의 벡터 뽑아서 선형 결합한 것은 $V$의 subspace
- $S$로부터 만들어낼 수 있는 모든 $W$는 $V$의 Subspace
- $W$는 만들 수 있는 가장 작은 subspace $V$ (= 만들 수 있는 다른 모든 $V$의 subspace는 $W$를 포함한다.)
Statements \#1
- $S$ spans $W$
- $W$ is spanned by $S$
- $W = "span" {bold(v_1), bold(v_2), ... bold(v_r)} = "span"(S)$
Statements \#2  
- $"span"(bold(V))$: $bold(V)$로 만들 수 있는 모든 선형결합 \
  $"span"(bold(V)) = ("any scalar")bold(V)$
- $"span"(bold(V_1) + bold(V_2)) = ("any scalar #1")bold(V_1) + ("any scalar #2")bold(V_2)$
Theorem
- $S = "span" {bold(v_1), bold(v_2), ..., bold(v_r)}; S' = "span" {bold(s_1), bold(s_2), ..., bold(s_r)}$가 공집합이 아닌 $V$ 내의 Vector space일때\
  $"span" {bold(v_1), bold(v_2), ..., bold(v_r)} = "span"{bold(s_1), bold(s_2), ..., bold(s_r)}$

== Linear Independence
- Linearly Independent #sym.arrow.r.l.double $k_1bold(v_1) + k_2bold(v_2) + ... + k_r bold(v_r) = bold(0)$ \
  for only $k_1=k_2=..=k_r=0$ \
  (계수 모두가 0일 때 0벡터가 되는 경우를 제외하면 0벡터가 되는 경우가 없어야 함)
- 어떤 구성 요소 한 개가 다른 구성 요소로 표현될 수 없음
Extension
- $bold(f_1)=sin^2 x; bold(f_2)=cos^2 x; bold(f_3)=5$ \ 
  #sym.arrow.r.double $5(bold(f_1)+bold(f_2)) = bold(f_3)$ 
  #sym.arrow.r.double Linearly dependent

== Coordinates and Basis

- Finite dimensional vector space can be spanned by a finite set of vector.
- Infinite dimensional vector space cannot be spanned by a finite set of vector.

Definition
- Finite dimensional vector $V$ ($supset S = {bold(V_1), bold(V_2), ..., bold(V_n)}$)
- $S$ is basis if
  1. $S$ spans $V$
  2. $S$ is linearly independent \
  ($arrow.double$ $S$ = basis of vector space $V$)

Examples
- $RR^n$ = standard basis vector: $e_1, e_2, ..., e_n$
- $P_n supset S = {1, x, ..., x^n}$
  - $a_0 + a_1x + a_2x^2 + ... + a_n x^n$ \
    - $P_n$을 span
    - Linearly independent
- How to check $v_1=(1, 2, 1), v_2=(2, 9, 0), v_3=(3, 3, 4)$ form a basis for $RR^3$
  - Spans $RR^3$?
  - Linearly independent?

Theorem
- $S$: Basis of vector space $V$
- $bold(v) = c_1 bold(v_1) + c_2 bold(v_2) + ... + c_n bold(v_n)$ \
  $bold(V)$ is uniquely expressed by $S(= bold(v_1), bold(v_2), ..., bold(v_n))$
- $bold(V) = c_1 bold(v_1) + c_2 bold(v_2) + ... + c_n bold(v_n)$

Definition
- $S = {bold(v_1), bold(v_2), ..., bold(v_n)}$: Basis of vector space $V$ and \
  $bold(v) = c_1 bold(v_1) + c_2 bold(v_2) + ... + c_n bold(v_n)$
- then $c_1, c_2, ..., c_n$ is coordinates of $bold(v)$ relative to $S$

Definition and Example
- $(bold(P))_s=(C_0, C_1, ..., C_n)$: $(bold(P))_s$ = 
 Relative from P to s

== Dimension
Theorems
- All bases for a (each) finite dimensional vector space have same number of vectors
- Let $V$: finite dimensional vector space; ${bold(v_1), bold(v_2), ..., bold(v_n)}$: basis of $V$ then \
  - linearly dependent ($"len"(bold(V)) > n$)
  - not spans $V$ ($"len"(bold(V)) < n$)

Definition and Examples
- Dimension of a finite dimensional vector space = $dim(V)$ = Number of vectors in a basis
- $dim(RR^n) = n$;  $dim(P_n) = n + 1$; $dim(M_(m n)) = m n$

Theorems
- $S subset V$
  1. $S$ is linearly independent set and $bold(v) in.not "span"(S)$ then \
    $S union {bold(v)}$ is linearly independent
  2. $bold(v) in S$ and $bold(v) in "span"(S - {bold(v)})$ then \
    $"span"(S) = "span"(S - {bold(v)})$
- $V$: n-dimensional vector space; $|S| = n$; $S subset V$ \
  $S$: basis #sym.arrow.double.r.l (1) $S$ spans $V$ (2) $S$: linearly independent \
  \* (1) (2) 둘 중 한 개가 보장되면 나머지 한 개도 보장됨
- $S$: finite set in finite dimensional vector space $V$
  1. $S$ spans $V$ but is not a basis \
    #sym.arrow.double $S$ can be reduced to a basis by remaining some vectors from $S$
  2. $S$ is linearly independent, not span $V$(= not a basis for $V$) \
    #sym.arrow.double $S$ can be enlarged to a basis by adding some independent vectors
- $W$ is subspace of a finite-dimensional vector space $V$ then
  1. $W$ is finite-dimensional
  2. $dim(W) <= dim(V)$
  3. $W = V$ only if $dim(W) = dim(V)$

== Change of Basis
- $(bold(V))_s != (bold(V'))s$ \
  $(bold(V))_s = (C_1, C_2, ..., C_n) in RR^n$ \
  how to $S arrow S'; (bold(V))_s arrow (bold(V'))_s$ ?
- $B(=(bold(u_1), bold(u_2), ..., bold(u_n))) arrow B'(=(bold(u'_1), bold(u'_2), ..., bold(u'_n))) arrow.double [bold(v)]_B arrow [bold(v)]_B'$ \
  $[bold(v)]_B' = P[bold(V)]_B$ where $P=[[bold(u_1)]_B', [bold(u_2)]_B', ..., [bold(u_n)]_B']$ \
  \* P is transition matrix from $B$ to $B'$

Invertibility
- $(P_(B'arrow B))(P_(B arrow B')) = (P_(B'arrow B')) = I$

Efficient Method for Computing Transition Matrices
1. $[B'^("new") | B ^("old")]$
2. Elementary Row operation
3. $[I | P_(B->B')]$

Theorem
- $B = {bold(u_1), bold(u_2), ..., bold(u_n)}$ \
  $S = {"standard matrices"}$ \
  then $P_(B->S) = [bold(u_1), bold(u_2), ..., bold(u_n)]$

== Row Space, Column Space, and Null Space
Definitions
1. $A_(m times n) = mat(delim: "[", bold(r_1); bold(r_2); dots.v; bold(r_m)) = mat(delim: "[", bold(c_1), bold(c_2), ..., bold(c_n))$ \
  $bold(r_i)$: row vectors, $bold(c_i)$: column vectors
2. Row space of $A$: $"row"(A) = "span"{bold(r_1), bold(r_2), ..., bold(r_m)}$ \
  Column space of $A$: $"col"(A) = "span"{bold(c_1), bold(c_2), ..., bold(c_n)}$ \
  Null space of $A$: $"null"(A) = "Solution Space" = {bold(x)|A bold(x) = bold(0)}$

Theorem
- $A bold(x) = bold(b)$: Consistent $<=>$ $b in "col"(A)$ \
  $-> A bold(x) = mat(delim: "[", bold(c_1), bold(c_2), ..., bold(c_n))mat(delim: "[", bold(x_1); bold(x_2); dots.v; bold(x_n))$ \
  $= x_1 bold(c_1) + x_2 bold(c_2) + ... + x_n bold(c_n) = bold(b) in "col(A)" = "span"{bold(c_1), bold(c_2), ..., bold(c_n)}$

Example
- $A mat(delim: "[", x_1; x_2; dots.v; x_6) = mat(delim: "[", 0; 0; dots.v; 0)$ \

  $-> mat(delim: "[", x_1; x_2; dots.v; x_6) = r mat(delim: "[", a_1; a_2; dots.v; a_6) + s mat(delim: "[", b_1; b_2; dots.v; b_6) + t mat(delim: "[", c_1; c_2; dots.v; c_6) + mat(delim: "[", d_1; d_2; dots.v; d_6)$ \
  
  - $r[" "] + s[" "] + t[" "]$ : General solution of homogeneous system
  - $[" "]$ : Constant; particular solution of non-homogeneous system

Theorem
- Row equivalent matrices have the same row space, null space \
  - (참조) Elementary row operation을 해도 null space(= solution space)는 변화가 없다. $=>$ 해가 유지된다. \
- But not about column space \

  $A = mat(delim: "[", 1, 3; 2, 6)$ and $B = mat(delim: "[", 1, 3; 0 0)$ then $"col"(A) = mat(delim: "[", 1; 2)$ and $"col"(B) = mat(delim: "[", 1; 0)$

Theorem
- Elementary row operation do not change dependency relationships between column vectors
  - Elementary row operations $!=$ column operation

Why null space is null space? \

- $A bold(x) = bold(0) => mat(delim: "[", bold(c_1), bold(c_2), ..., bold(c_n)) mat(delim: "[", x_1; x_2; dots.v; x_n) = mat(delim: "[", bold(r_1) " " dot " " bold(x); bold(r_2) " " dot " " bold(x); dots.v; bold(r_n) " " dot " " bold(x)) = mat(delim: "[", 0; 0; dots.v; 0)$ \

  - 두 벡터의 도트곱이 0이다. $<=>$ 두 벡터가 수직이다.

== Rank, Nullity and Fundamental Spaces
Theorems and Definitions
- $dim("row"(A)) = dim("col"(A))$
- $"rank"(A) = dim("row"(A)) = dim("col"(A))$
- $"nullity"(A) = dim("null"(A))$
- $A$: $n$ columns $=>$ rank($A$) + nullity($A$) = $n$ \
  rank($A$): \#leading variables \
  nullity($A$): \#free variables (= all zero row, number of params)

Example
- $R = mat(delim: "[",
    1, 0, -4, -28, -37, 13;
    0, 1, -2 ,-12, -16, 5;
    0, 0, 0, 0, 0, 0;
    0, 0, 0, 0, 0, 0
  )$
  - $dim("row"(R)) = 2; dim("col"(R)) = 2; "rank" = 2$ \
    \* rank는 reduced row echelon form에서 확인 \
    
  - $bold(x) = r mat(delim: "[", 4; 2; 1; 0; 0; 0) + s mat(delim: "[", 28; 12; 0; 1; 0; 0) + t mat(delim: "[", 37; 16; 0; 0; 1; 0) + u mat(delim: "[", -13; -5; 0; 0; 0; 1) => "basis"$ \
    Basis of null space; Nullity = 4

Theorem
- $(A bold(x))_(m times n) = bold(b)$ : consistent, rank($A$) = $r$ \
  $=>$ general solution contains $(n - r)$ parameters. \
    $bold(x) = bold(x)_n + bold(x)_p$

Fundamental Spaces
- $"row"(A) " " (="col"(A^T))$
- $"col"(A) " " (="row"(A^T))$
- $"null"(A); " " "null"(A^T) = "left null space of A"$
- $dim("row"(A)) = r$ \
  $dim("col"(A)) = r$ \
  $dim("null"(A)) = n - r$ \
  $dim("null"(A^T)) = n - r$
- $"rank"(A) = "rank"(A^T)$
- $A^T$: $m$ column \
  $=>$ $"rank"(A^T) + "nullity"(A^T)$ = $"rank"(A) + "rank"(A^T)$ = $m$

Bases for Fundamental Spaces
- $m times n$ size $A$ \
  $[A|I] ->^("GJE") ["RREF"|E]$ $arrow.t.b m-r$ row
- Basis for left null space is found from the #underline()[bottom $m -r$ rows] of $E$ \
  \* $A^T$에 대해 별도 처리 없이도 처리할 수 있다.

Definition:
A Geometric Link Between the Fundamental Spaces
- $W$: Subspace of $RR^n$
- Orthogonal Complement of $W$: Set of all vectors in $RR^n$ \
  that are orthogonal to every vector in $W$
  1. $W^ℒ = "subspace of" RR^n$
  2. $W sect W^ℒ = {bold(0)}$
  3. $(W^ℒ)^ℒ=W$


== Equivalent Statements
Theorem 1.6.4 (Page 64)

a. $A$ is invertible. \
b. $A bold(x) = bold(0)$ has only the trivial solution. \
c. The reduced row echelon form of $A$ is $I_n$. \
d. $A$ is expressible as a product of elementary matrices. \
e. $A bold(x) = bold(b)$ is consistent for every $n times 1$ matrix $bold(b)$. \
f. $A bold(x) = bold(b)$ has exactly one solution for every $n times 1$ matrix $bold(b)$.

Theorem 2.3.8 (Page 141)

g. $det(A) != 0$

Theorem 4.9.8 (Page 283)

h. The column vectors of $A$ are linearly independent. \
$" "$ $" "$ $A ->^"GJE" [I]$ ... Identity이므로 linearly independent. \
i. The row vectors of $A$ are linearly independent. \
j. The column vectors of $A$ span $RR^n$. \
$" "$ $" "$ $RR^n$의 벡터들인데 linearly independent하므로 $RR^n$을 span한다 할 수 있다. \
k. The row vectors of $A$ span $RR^n$. \
l. The column vectors of $A$ form a basis for $RR^n$. \
m. The row vectors of $A$ form a basis for $RR^n$. \
n. $A$ has rank $n$. \
o. $A$ has nullity $0$. \
$" "$ $" "$ (has no all-zero row) \
p. The orthogonal complement of the null space of $A$ is $RR^n$. \
$" "$ $" "$ null($A$) 공간은 ${bold(0)}$ 하나이므로. \
q. The orthogonal complement of the row space of $A$ is $bold(0)$. \
$" "$ $" "$ null($A$) 공간은 ${bold(0)}$ 하나이므로. \

== Eigenvalues and Eigen Vectors

- $A$: $n times n$ matrix ($A$: Standard matrix of an operation)
- $bold(x) != 0; bold(x) in RR^n; bold(x): "eigenvector"$ ($lambda$에 상응) \
  if $A bold(x) = lambda bold(x)$ for some $lambda$ $=>$ $lambda: "eigenvalue"$

Computing

- $A bold(x) = lambda bold(x) -> lambda bold(x) - A bold(x) = bold(0)$ \
  $(lambda I - A) bold(x) = bold(0)$ $->$ Consistent

Theorem
- $det(lambda I - A) = 0$: Characteristic equation of $A$.
- Diagonal values are eigenvalues \
  when $A$ is triangular / diagonal matrix.

Theorem

$A: n times n "matrix"$
1. $lambda$ : eigenvalue of $A$
2. $lambda$ : solution of $det(lambda I - A) = 0$
3. $(lambda I - A) bold(x) = bold(0)$ has non trivial solution
4. $exists bold(x) != bold(0)$ such that $A bold(x) = lambda bold(x)$.

Theorem: Finding Eigenvectors and Bases for Eigenspaces

${bold(x) != bold(0) | (lambda I - A) bold(x) = bold(0)}$
1. Null space of $lambda I - A$.
2. The kernel of $T_(lambda I - A): RR^n -> RR^n$
3. Set vectors for which $A bold(x) = lambda bold(x)$

Theorem: Eigenvalues and Invertibility

$A: "invertible" <=> lambda = 0 "is not an eigenvalue of " A$
- 행렬 $A$가 eigenvalue를 가지면 가역할 수 없다.\
  가역하면 eigenvalue를 갖지 못한다.

== Diagonalization
Matrix Diagonalization Problem

$P^(-1) A P$
- $det(A) = det(P^(-1)A P) = det(P^(-1) det(A) det(P))$

Definitions and Theorems
1. If $A$, $B$: square matrices \
  $=>$ $B$ is similar to $A$ if $exists "invertible matrix" P$ such that $B=P^(-1)A P$.
2. $A$: diagonalizable \
  if it is similar to some diagonal($P^(-1)A P$) matrix. \
  $P$ is said to diagonalize $A$.
3. $A$: $n times n$ matrix \
  (a) diagonalizable \
  (b) $A$ has n linearly independent eigenvectors. \
4. (a) $lambda_1, lambda_2, ..., lambda_k$: distinct eigenvalues of $A$ \
  (b) $bold(v_1), bold(v_2), ..., bold(v_k)$: corresponding eigenvalues is diagonalizable.

Procedure for Diagonalizing a Matrix

Step 1. Check if $exists n$ linearly independent eigenvalues. \
 $" "$ $" "$ $" "$ $" "$ $" "$ $" "$
$lambda I - A bold(x) = bold(0)$: Solution space $=>$ $bold(P_1), bold(P_2), ..., bold(P_n)$. \
Step 2. $P = [bold(P_1) | bold(P_2) | ... | bold(P_n)]$ $<-$ $n times n$ size \
Step 3. $D = P^(-1)A P$ where $D$ = $mat(delim: "[", lambda_1, , , ; , lambda_2, , ; , , dots.down, ; , , , lambda_n)$.

Theorem: Eigenvalue of Power of a Matrix
- $A bold(x) = lambda bold(x)$ \
  $A^2 bold(x) = k^"scalar" bold(x) = A A bold(x) = A (lambda bold(x)) = lambda A bold(x) = lambda ^2 bold(x)$ \
  \* eigenvector: stayed same

Computing Powers of a Matrix
- $D = P^(-1) A P$; $A$ 행렬 Diagonalization $=>$ 대각행렬 $D$ 획득
- $A^10 = ?$ \
  $D^10 = P^(-1) A P dot P^(-1) A P ... P^(-1) A P $ \
  $" " " " " " " " " "= P^(-1)A^10P$ $=>$ $A^10 = P D^10 P^(-1)$

Theorem: Geomatric and Algebric Multiplicity#super()[중복도]
#table(
  columns: (3fr, 1.2fr, 3fr),
  stroke: none,
  inset: (x: 0%, y: 0%),
  [
    using example 1 \
    #table(
      columns: 3,
      [], [$lambda = 1$], [$lambda = 2$ \
      (double root)],
      [multiplicity], [1], [2],
      [dimension], [1], [2]
    )
  ],[
    \
    #table(
      columns: 1fr,
      stroke: none,
      [\
      \
      ],
      table.cell(align: center, inset: (y: 0%))[$<->^"algebraic multiplicity"$],
      table.cell(align: center, inset: (y: 0%))[$<->^"geometric multiplicity"$],
    )
  ], [
    using example 2 \
    #table(
      columns: 3,
      [], [$lambda = 1$], [$lambda = 2$ \
      (double root)],
      [multiplicity], [1], [2],
      [dimension], [1], [1]
    )
  ]
)

1. Geometric multiplicity $<=$ Algebraic multiplicity
2. diagonalizable $<=>$ geo.mul. = alg.mul. (같아야 linearly independent)

== Inner Product Spaces
Definition
- $V$: real vector space \
  $<bold(u), bold(v)>$: inner product $=>$ $V$: inner product space

4가지 조건 만족 시 연산자 사용 가능
1. $<bold(u), bold(v)> = <bold(v), bold(u)>$
2. $<bold(u) + bold(v), bold(w)> = <bold(u), bold(w)> + <bold(v), bold(w)>$
3. $<k bold(u), bold(v)> = k<bold(u), bold(v)>$
4. $<bold(u), bold(v)> >= 0$; Equality $<=>$ $bold(v) = 0$

- $RR^n; <bold(u), bold(v)> = bold(u) dot bold(v) = u_1 v_1 + u_2 v_2 + ... + u_n v_n$
- Dot product is inner product in Euclidean space (= Standard inner product)

- $V$가 $<bold(u), bold(v)>$에 의해 정의 혹은 $<bold(u), bold(v)>$의 inner product space = $V$

Definition
- $V$: real inner product space

- $||bold(v)|| = root(, (<bold(u), bold(v)>))$
- $d(bold(u), bold(v)) = ||bold(u) - bold(v)|| = root(, (<bold(u) - bold(v), bold(u) - bold(v)>)))$
- $||bold(u)|| = 1$ $=>$ $bold(u)$: unit vector

Theorem
1. $|| bold(v) || >= 0$; Equality $<=>$ $bold(v) = bold(0)$
2. $|| k bold(v)|| = k || bold(v) ||$
3. $d(bold(u), bold(v)) = d(bold(v), bold(u))$
4. $d(bold(u), bold(v)) >= 0$; Equality $<=>$ $bold(u) = bold(v)$

- $RR^n$; $<bold(u), bold(v)> = w_1 u_1 v_1 + w_2 u_2 v_2 + ... + w_n u_n v_n$ \
  $->$ Weighted Euclidean inner product

Inner Products Generated by Matrices
- Matrix inner product $<bold(u), bold(v)> = A bold(u) dot A bold(v) = (A bold(v))^T A bold(u) = bold(v)^T A^T A bold(u)$
- dot product\
  $->$ inner product\
  $->$ weighted inner product\
  $->$ inner product generated by matrix

Theorem: Dot곱 Axiom의 Inner Product로의 확장
1. $<bold(0), bold(v)> = <bold(v), bold(0)> = 0$
2. $<bold(u), bold(v) + bold(w)> = <bold(u), bold(v)> + <bold(u), bold(w)>$
3. $<bold(u), bold(v) - bold(w)> = <bold(u), bold(v)> - <bold(u), bold(w)>$
4. $<bold(u) - bold(v), bold(w)> = <bold(u), bold(w)> - <bold(v), bold(w)>$
5. $k <bold(u), bold(v)> = <bold(u), k bold(v)>$

== Gram-Schmidt Process

Orthogonal and Orthonormal Sets

$S = {bold(v_1), bold(v_2), ..., bold(v_n)}$; $mat(n; 2)$ ... $n$개 중 2개 뽑아서 orthogonal 체크 필요
- $<bold(v_i), bold(v_j)> = 0$ $=>$ $S$: orthogonal set
- orthogonal set condition + \
  $|| v_i || = 1$ for all $i$ $=>$ S: orthonormal set

Theorem \
- $S = {bold(v_1), bold(v_2), ..., bold(v_n)}$: Orthogonal Set $=>$ linearly independent

Coordinated Relative to Orthonormal Bases
- $S = {bold(v_1), bold(v_2), ..., bold(v_n)}$: basis \
  $bold(u) = c_1 bold(v_1) + c_2 bold(v_2) + ... + c_n bold(v_n)$ \
  $(bold(u))_s = (c_1, c_2, ..., c_n)$ $->$ $n$개 변수 있는 연립방적식 풀어야 찾을 수 있음 \
  +) 직교하는 basis는 표현이 조금 더 쉽지 않을까?

Theorem
- $S = {bold(v_1), bold(v_2), ..., bold(v_n)}$: Orthogonal basis
- $bold(u) = "proj"_(bold(r_1))bold(u) + "proj"_(bold(r_2))bold(u) + ... + "proj"_(bold(r_n))bold(u)$ \
  $= <bold(v_1), bold(u)> \/ ||bold(v_1)||^2 dot bold(v_1) + <bold(v_2), bold(u)> \/ ||bold(v_2)||^2 dot bold(v_2) + ... + <bold(v_n), bold(u)> \/ ||bold(v_n)||^2 dot bold(v_n)$
- Orthogonal: \
  $(bold(u))_s = (<bold(v_1), bold(u)> \/ ||bold(v_1)||^2, <bold(v_2), bold(u)> \/ ||bold(v_2)||^2, ..., <bold(v_n), bold(u)> \/ ||bold(v_n)||^2)$
- Orthonormal: \
  $(bold(u))_s = (<bold(v_1), bold(u)>, <bold(v_2), bold(u)>, ..., <bold(v_n), bold(u)>)$

Orthogonal Projection
- $bold(u) = bold(w_1) + bold(w_2)$
- $bold(u) = "proj"_w bold(u) + "proj"_(w^perp) bold(u)$
- $W$와 수직인 벡터들의 모음: \
  - null space of $W$
  - $W$'s Orthogonal compliment
  - $W^perp$
- Orthogonal Projection from $bold(u)$ to $bold(v_1)$, $bold(v_2)$ \
  $"proj"_w bold(u) = "proj"_bold(v_1) bold(u) + "proj"_bold(v_2) bold(u) + ... + "proj"_bold(v_r) bold(u)$

Gram-Schmidt Process
- input: ${bold(v_1), bold(v_2), ..., bold(v_r)}$ any basis for $W$.
- output: ${bold(v_2), bold(v_2), ..., bold(v_r)}$ orthogonal basis for $W$.
- 찾는 이유: 유용성; Projection to Orthogonal Compliment of $bold(v_1)$ \
  $=>$ Orthogonal 하면서 똑같은 공간을 span하는구나!

1. $bold(u_1) = bold(v_1)$
2. $bold(u_2) = "proj"_(w_1^perp)bold(v_2)$ $=>$ $W_1 = "span"{bold(u_1)}$
3. ...
4. $bold(u_i) = "proj"_(w_(i - 1)^perp)bold(v_i)$ $=>$ $W_i = "span"{bold(u_i)}$
