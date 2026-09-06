#let subtext(content) = {
  text(size: .5em, fill: luma(40%))[#content]
}
#set page("a4",
  flipped: true,
  columns: 3,
  margin: (x: 10pt, y: 10pt),
  header: subtext([가상현실 Cheat Sheet]),
  footer: subtext(align(right)[by Park, Jonghyeon])
)
#let serif = ("Noto Serif CJK KR", )
#let sans = ("Noto Sans CJK KR", "Gothic A1", )
#set text(
  font: serif,
  size: 6pt
)
#set table(
  stroke: .05em,
  align: horizon,
  inset: 3pt
)
#let c(content) = {
  table.cell(align: center + horizon)[#content]
}

== 1. Introduction

== 2. 좌표계 변환

*변환 행렬*
1. 크기 변환 (Scaling):
  $
    vec(x_1, y_1, z_1, 1) = mat(s_x, 0, 0, 0; 0, s_y, 0, 0; 0, 0, s_z, 0; 0, 0, 0, 1) vec(x, y, z, 1) = vec(s_x x, s_y y, s_z z, 1)
  $

2. 회전 변환 (Rotation, Z축 기준):
  $
  vec(x_2, y_2, z_2, 1) = mat(cos theta, -sin theta, 0, 0; sin theta, cos theta, 0, 0; 0, 0, 1, 0; 0, 0, 0, 1) vec(x_1, y_1, z_1, 1) = vec(x_1 cos theta - y_1 sin theta, x_1 sin theta + y_1 cos theta, z_1, 1)
  $
3. 이동 변환 (Translation):
  $
  vec(x_"final", y_"final", z_"final", 1) &= mat(1, 0, 0, t_x; 0, 1, 0, t_y; 0, 0, 1, t_z; 0, 0, 0, 1) vec(x_2, y_2, z_2, 1) = vec(x_2 + t_x dot 1, y_2 + t_y dot 1, z_2 + t_z dot 1, 1) = vec(x_2 + t_x, y_2 + t_y, z_2 + t_z, 1)
  $

- 계 안의 특정 정점이 변환 대상인 경우: $S arrow R arrow T$
  $
  P_"world" = T(R(S dot P_"local")) = M P_"local"
  $

- 계 전체가 변환 대상인 경우: $T arrow R arrow S$
  $
  P_"world" = S(R(T dot P_"local")) = M P_"local"
  $

*회전 처리*

- 유니티는 $z arrow x arrow y$ 축 순서로 회전 처리
  $
  A_"final" &= R_y(phi) dot (R_x(theta) dot (R_z(psi) dot A_"initial")) \
  &= R_y(phi) R_x(theta) R_z(psi) dot A_"initial" \
  $

*짐벌락*
- 특정한 각도에서 두 축이 일치하면서, 두 회전축이 같은 방향을 바라보게 되어, 회전 자유도 1개를 잃는 현상
- 같은 방향을 바라보는 두 개 축은 종속 관계가 됨
  $
  R&=R_y (phi) R_x (pi/2) R_z (psi)\
  &=mat(
    cos(phi - psi), sin(phi - psi), 0;
    0, 0, -1;
    -sin(phi - psi), cos(phi - psi), 0
  )
  $

*쿼터니언*
- $q = w + x bold(i) + y bold(j) + z bold(k)$
- $q = (w, x, y, z)$
- $q = (cos theta/2, cos theta/w bold(u))$
- $R = q bold(v) q^(-1) = q^* = (w, -x, -y, -z)$
- $|q| = 1$

== 3. 충돌 검사
*고전 방식*
- 분리 축 정리
- Lin-Canny Closest Features
- GJK 알고리즘

*BVH: Bounding Volume Hierarchy*
- 모든 물체들을 계층화, 충돌이 발생할 타당한 후려가 있는 물체쌍에 대해서만 검사 수행
- AABB: Axis-Aligned Bounding Box (Tree)
- OBB: Oriented Bounding Box
- k-DOP: k-Discrete Oriented Polytype 

*Spatial Partitioning*
- 공간을 일정한 크기의 셀로 분할하여 관리

*Temporal Coherence & Sweep and Prune*
- 시간의 연속성 이융(이미 충돌이 발생한 물체 쌍은 다음 프레임에서도 충돌이 계속될 확률 높음)

*점과 점 사이의 충돌 검사*
- $l = ||p_1 - p_2||$
- if $l < r_1 + r_2$ then collide

*점과 선분 사이의 충돌 검사*
- $arrow(v_i) = p_i - l_1$
- $arrow(n) = (l_2 - l_1) / (||l_2 - l_1||)$
\
- $arrow(v_i) dot arrow(n)$ : 수선의 발
- $arrow(v_i) dot arrow(n) < 0$ : 수선의 발이 선분의 왼쪽 바깥에 위치\
  $0 <= arrow(v_i) dot arrow(n) <= ||L||$ : 수선의 발이 선분위에 위치\
  $||L|| < arrow(v_i) dot arrow(n)$ : 수선의 발이 선분의 오른쪽 바깥에 위치
\
- 선분 위에 수선의 발이 닿지 않는 경우:\
  $l_"min" = min(||p_1 = l_1||, ||p_1 - l_2||)$

- 선분 위에 수선의 발이 닿는 경우:\
  $
  p_"middle" &= l_1 + arrow(n) dot (arrow(v_1) arrow(n))\
  &= l_1 + (l_2 - l_1)/(||l_2 - l_1) ((p_1 - l_1) (l_2 - l_1)/(||l_2 - l_1||))
  $\
  $l_"min" = ||p_1 - p_"middle"||$

- if $l_min < r_i$ then collide

*점과 삼각형 사이의 충돌 검사*
- 삼각형의 수직 방향 법선 벡터 $arrow(n)$\
  $arrow(n) = (t_2 - t_1) times (t_3 - t_1)$\
  $hat(n) = arrow(n)/(||arrow(n)||)$

- 수선의 발 $p'$\
  $p' = p - d hat(n) = p - d'/(||n||^2) dot n = p - (arrow(n) dot p)/(||n||^2) dot n$

- 수선의 발 $p'$ 와 세 점 $t_1$, $t_2$, $t_3$에 대해서 계산\
  $
  arrow(n_(11)) &= (t_2 - t_1) times (p' - t_1) \
  arrow(n_(12)) &= (p' - t_1) times (t_3 - t_1) \
  arrow(n_(21)) &= (t_3 - t_2) times (p' - t_2) \
  arrow(n_(22)) &= (p' - t_2) times (t_1 - t_2) \
  arrow(n_(31)) &= (t_1 - t_3) times (p' - t_3) \
  arrow(n_(32)) &= (p' - t_3) times (t_2 - t_3) \
  $
  $
  arrow(n_(11)) dot arrow(n_(12)) <= 0? \
  arrow(n_(21)) dot arrow(n_(22)) <= 0? \
  arrow(n_(31)) dot arrow(n_(32)) <= 0? \
  $

== 4. 강체 시뮬레이션
*지배 방정식*
- $M dot.double(X) + C dot(X) + K X = sum(F_"external")$
- $C dot(X) + K X = sum(F_"internal")$

*관성과 관성 모멘트*
- #table(
    columns: 2,
    [$f = m a$], [$r = I alpha$],
    [$a = 1/m dot f$], [$alpha = I^(-1) dot tau$],
    [관성: 질량 $m$], [관성: 관성 모멘트 $I$]
  )

*회전 변환*
- $tau = I alpha$

- $I = integral r^2 d m = integral integral integral rho r^2 d V$
- $I_"uniform" = mat(I_(x x), I_(x y), I_(x z); I_(y x), I_(y y), I_(y z); I_(z x), I_(z y), I_(z z))$
- $I_"aligned" = mat(I_(x x), 0, 0; 0, I_(y y), 0; 0, 0, I_(z z))$

*직육면체의 관성 모멘트*
- $I_(x x) = 1/12 m (h^2 + d^2)$
- $I_(y y) = 1/12 m (w^2 + d^2)$
- $I_(z z) = 1/12 m (w^2 + h^2)$

*구의 관성 모멘트*
- $I = 1/5 m R^2$

*원통의 관성 모멘트*
- $I_(x x) = I_(y y) = 1/12 m (3R^2 + L^2)$
- $I_(z z) = 1/2 m R^2$

=== 4.1. 강체 시뮬레이션에서의 수치 적분
- #table(
    columns: 2,
    [전진 오일러법], [후진 오일러법],
    [$v_(i + 1) = v_i + a_i Delta t$], [$v_(i + 1) = v_i + a_(i + 1) Delta t$],
    [$x_(i + 1) = x_i + v_i Delta t$], [$x_(i + 1) = x_i + v_(i + 1) Delta t$],
  )

*후진 오일러 방법의 방정식 해결*
$
x_(t + 1) - v_(t + 1) = x_t
$
$
v_(t + 1) - (k Delta t)/m = v_t + (k Delta t)/m x_0
$

$
arrow.double mat(1, -Delta t; (k Delta t)/m, 1) mat(x_(t + 1); v_(t + 1)) = mat(1, 0; 0, 1) mat(x_t; v_t) + mat(0; (k Delta t)/m x_0)
$
$
arrow.double S_(t + 1) = mat(x_(t + 1); v_(t + 1))
$
$
arrow.double A S_(t + 1) = B S_t
$
$
arrow.double S_(t + 1) = A^(-1) B S_t 
$
$
D = det(A) = (1 dot 1) - (- Delta t dot (k Delta t) / m) = 1 + (k Delta t^2)/m
$
$
A^(-1) = 1/D mat(1, Delta t; -(k Delta t)/m, 1)
$
