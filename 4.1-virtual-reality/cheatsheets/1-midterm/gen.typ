#let subtext(content) = {
  text(size: .5em, fill: luma(40%))[#content]
}
#set page("a4",
  flipped: true,
  columns: 3,
  margin: (x: 10pt, y: 10pt),
  header: subtext([가상현실 Cheat Sheet (보강)]),
  footer: subtext(align(right)[by Park, Jonghyeon])
)
#let serif = ("Noto Serif KR", "Noto Serif CJK KR", )
#let sans = ("Noto Sans KR", "Noto Sans CJK KR", "Gothic A1", )
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

*벡터의 기본 연산*
- 내적 (Dot Product): $u dot v = |u||v| cos(theta)$ 
  - 두 벡터의 정렬 상태 측정, 조명(Lambertian) 계산
- 외적 (Cross Product): $u times v = |u||v| sin(theta) n$
  - 법선 벡터 생성, 회전축/토크 계산, 앞/뒤 판단

== 2. 좌표계 변환

*변환 행렬*

1. 크기 변환 (Scaling):
  $
    vec(x_1, y_1, z_1, 1) = mat(s_x, 0, 0, 0; 0, s_y, 0, 0; 0, 0, s_z, 0; 0, 0, 0, 1) vec(x, y, z, 1)
  $

2. 회전 변환:
  Z축: $R_z(theta) = mat(cos theta, -sin theta, 0, 0; sin theta, cos theta, 0, 0; 0, 0, 1, 0; 0, 0, 0, 1)$
  
  X축: $R_x(theta) = mat(1, 0, 0, 0; 0, cos theta, -sin theta, 0; 0, sin theta, cos theta, 0; 0, 0, 0, 1)$
  
  Y축: $R_y(theta) = mat(cos theta, 0, sin theta, 0; 0, 1, 0, 0; -sin theta, 0, cos theta, 0; 0, 0, 0, 1)$

3. 이동 변환 (Translation):
  $
    T(t_x, t_y, t_z) = mat(1, 0, 0, t_x; 0, 1, 0, t_y; 0, 0, 1, t_z; 0, 0, 0, 1)
  $

*동차 좌표계 (Homogeneous Coordinate)*
- 평행이동을 행렬 곱셈으로 통합 처리 가능
- 2D: $(x, y, 1)$, 3D: $(x, y, z, 1)$

*변환 순서*

- 계 내 정점이 대상: $S arrow R arrow T$ → $P_"world" = T(R(S P_"local"))$
- 계 전체가 대상: $T arrow R arrow S$ → $P_"world" = S(R(T P_"local"))$

*회전 처리*

- 유니티: $z arrow x arrow y$ 축 순서 (ZXY)
  $
    R_"final" = R_y(phi) R_x(theta) R_z(psi)
  $
- 오른손 좌표계: $Z arrow X arrow Y$ 또는 다른 순서 (순서 중요!)

*짐벌락 (Gimbal Lock)*

- 특정 각도에서 두 회전축이 일치 → 자유도 1개 손실
- 예: $theta = pi/2$일 때 Y와 Z축이 같은 방향 바라봄
  $
    R = R_y(phi) R_x(pi/2) R_z(psi) = mat(cos(phi - psi), sin(phi - psi), 0; 0, 0, -1; -sin(phi - psi), cos(phi - psi), 0)
  $
- 해결책: 쿼터니언 사용

*쿼터니언 (Quaternion)*

- 정의: $q = w + x bold(i) + y bold(j) + z bold(k) = (w, x, y, z)$
- 회전 표현: $q = (cos theta/2, u sin theta/2)$ (축 $u$, 각 $theta$)
- 단위 조건: $|q| = 1$ (즉, $w^2 + x^2 + y^2 + z^2 = 1$)
- 역원소: $q^(-1) = q^* = (w, -x, -y, -z)$ (단위 쿼터니언인 경우)
- 점 회전: $p' = q p q^(-1)$ (여기서 $p = (0, p_x, p_y, p_z)$)

*쿼터니언의 장점*

- 짐벌락 방지: 모든 방향에서 자유로운 회전
- 부드러운 보간: SLERP (Spherical Linear Interpolation)로 최단 경로 보간
- 효율성: 행렬보다 메모리·연산량 적음 (9개 vs 4개 요소)

== 3. 충돌 검사

*충돌 처리 파이프라인*

1. Update Objects (상태 갱신)
2. Check Collision: Detection (충돌 검출)
3. Resolve Contacts: Response/Resolution (충돌 반응)

*고전 방식 알고리즘*

- SAT (Separating Axis Theorem, 분리축 정리): 모든 축에서 투영이 겹쳐야 충돌
- GJK (Gilbert-Johnson-Keerthi): 볼록 물체 간 최소 거리 계산
- Lin-Canny Closest Features: 가장 가까운 특징(점, 선, 면) 추적

*BVH: Bounding Volume Hierarchy*

- 물체를 계층화하여 가능성 있는 쌍만 검사 (Broad Phase 최적화)
- AABB (Axis-Aligned Bounding Box): 빠르지만 회전된 물체에 오차
- OBB (Oriented Bounding Box): 정확하지만 계산 복잡
- k-DOP (k-Discrete Oriented Polytope): 중간적 보완

*공간 분할 (Spatial Partitioning)*

- 공간을 셀로 분할하여 인접 물체만 검사
- 예: BSP trees, Octrees, Uniform grids

*Broad Phase & Narrow Phase*

- Broad Phase: 간단한 AABB로 충돌 후보 선별 (빠르고 많은 쌍 처리)
- Narrow Phase: 후보들에 대해 정밀한 폴리곤 검사 (느리지만 정확)

*Temporal Coherence & Sweep and Prune*

- 시간 연속성 이용: 이미 충돌한 쌍은 다음 프레임에서도 충돌 확률 높음
- Sweep and Prune: 축을 따라 정렬한 구간이 겹치는지 확인

*연속 vs 이산 충돌 검사 (CCD)*

- Discrete: 특정 시점($t, t+1$)만 검사 → 빠른 물체 "터널링" 위험
- Continuous: 이동 경로(Swept Volume)를 고려 → Time of Impact (TOI) 계산

*점과 점 사이의 충돌*

- $l = ||p_1 - p_2||$
- 충돌 조건: if $l < r_1 + r_2$ then collide

*점과 선분 사이의 충돌*

- 점 $p_i$에서 선분 $l_1 \sim l_2$로 수선의 발 $p'$ 구하기:
  $p' = l_1 + u(l_2 - l_1)$, $u = (p_i - l_1) dot (l_2 - l_1) / ||l_2 - l_1||^2$
- if $u < 0$: $l_"min" = ||p_i - l_1||$
- if $u > 1$: $l_"min" = ||p_i - l_2||$
- if $0 <= u <= 1$: $l_"min" = ||p_i - p'||$
- 충돌 조건: if $l_"min" < r_i$ then collide

*점과 삼각형 사이의 충돌*

- 법선 벡터: $arrow(n) = (t_2 - t_1) times (t_3 - t_1)$, $hat(n) = arrow(n) / ||arrow(n)||$
- 투영점: $p' = p - (arrow(n) dot p / ||arrow(n)||^2) arrow(n)$
- 삼각형 내부 판정 (외적 이용): 모든 조건이 true여야 함
  1. $arrow(n) dot ((t_2 - t_1) times (p' - t_1)) > 0$
  2. $arrow(n) dot ((t_3 - t_2) times (p' - t_2)) > 0$
  3. $arrow(n) dot ((t_1 - t_3) times (p' - t_3)) > 0$

== 4. 강체 시뮬레이션

*지배 방정식*

- $M dot.double(X) + C dot(X) + K X = sum(F_"external")$
- $C dot(X) + K X = sum(F_"internal")$ (내력)
- $M$: 질량 행렬, $C$: 감쇠, $K$: 강성

*강체의 상태 변수*

- 위치: 질량 중심 $p$ (3 DOF)
- 자세: 회전행렬 $R$ 또는 쿼터니언 (3 DOF)
- 속도: $v$ (3 DOF), 각속도: $omega$ (3 DOF)
- 총 6 자유도

*좌표 변환*

- 강체 고정 좌표계의 점 $r$을 전역 좌표계로:
  $x = R r + p$
- 강체 위 점 $a$의 속도: $v_a = v + omega times r_a$ (병진 + 회전)

*관성과 관성 모멘트*

- 병진: $f = m a$, $a = f/m$
- 회전: $tau = I alpha$, $alpha = I^(-1) tau$
- 관성 모멘트: $I = integral r^2 d m = integral integral integral rho r^2 d V$
  
*관성 모멘트 텐서*

- 일반: $I_"uniform" = mat(I_(x x), I_(x y), I_(x z); I_(y x), I_(y y), I_(y z); I_(z x), I_(z y), I_(z z))$
- 정렬(대칭축): $I_"aligned" = mat(I_(x x), 0, 0; 0, I_(y y), 0; 0, 0, I_(z z))$

*도형별 관성 모멘트*

- 직육면체 (폭 $w$, 높이 $h$, 깊이 $d$):
  $I_(x x) = 1/12 m (h^2 + d^2)$, $I_(y y) = 1/12 m (w^2 + d^2)$, $I_(z z) = 1/12 m (w^2 + h^2)$
- 구 (반지름 $R$):
  $I = 2/5 m R^2$
- 원통 (반지름 $R$, 길이 $L$):
  $I_(z z) = 1/2 m R^2$, $I_(x x) = I_(y y) = 1/12 m (3R^2 + L^2)$

*운동 방정식의 해석적 풀이*

- 자유낙하: $m dot.double(y) = -m g$ → $dot.double(y) = -g$
  - 속도: $dot(y)(t) = -g t + v_0$
  - 위치: $y(t) = -1/2 g t^2 + v_0 t + y_0$

=== 4.1. 강체 시뮬레이션에서의 수치 적분

*시간 이산화*

컴퓨터는 연속 시간을 계산할 수 없으므로 작은 시간 간격 $Delta t$로 이산화하여 근사 계산:
$$
v = integral a d t approx sum_i a_i Delta t,
quad x = integral v d t approx sum_i v_i Delta t
$$

*전진 오일러 방법 (Forward Euler)*

- 현재 시점($t_i$)의 정보로 다음 시점($t_{i+1}$) 예측
- $v_(i+1) = v_i + a_i Delta t$, $x_(i+1) = x_i + v_i Delta t$
- 장점: 구현 간단, 빠름
- 단점: 오차 누적, 강성(stiffness) 높으면 발산 위험 ($||A|| > 1$일 때)

*후진 오일러 방법 (Backward Euler)*

- 미래 시점($t_{i+1}$)의 정보로 현재 갱신
- $v_(i+1) = v_i + a_(i+1) Delta t$, $x_(i+1) = x_i + v_(i+1) Delta t$
- 장점: 무조건 안정적 ($|lambda| < 1$ 항상)
- 단점: 계산 복잡 (선형계 풀이 필요)

*후진 오일러 방법의 방정식 해결 (스프링 예시)*

스프링 시스템: $m dot.double(x) + k x = F$에 후진 오일러 적용:
$$
x_(t+1) = x_t + v_(t+1) Delta t,
quad v_(t+1) = v_t - (k Delta t)/m x_(t+1)
$$

행렬 형태로 정리:
$$
mat(1, -Delta t; (k Delta t)/m, 1) mat(x_(t+1); v_(t+1)) = mat(1, 0; 0, 1) mat(x_t; v_t)
$$

행렬식: $D = det(A) = 1 + (k Delta t^2) / m$

역행렬: $A^(-1) = 1/D mat(1, Delta t; -(k Delta t)/m, 1)$

해: $S_(t+1) = A^(-1) B S_t = 1/D mat(1, Delta t; -(k Delta t)/m, 1) mat(x_t; v_t)$

*안정성 분석*

전진 오일러에서 점화식: $X_(t+1) = A X_t$
- 안정 조건: $||lambda_i|| <= 1$ (모든 고유값의 절댓값 ≤ 1)
- 후진 오일러에서: $|lambda|^2 = 1 / (1 + (k Delta t^2)/m) < 1$ → 항상 안정

*고유값 계산 (후진 오일러)*

특성 방정식: $det(A^(-1)B - lambda I) = 0$
$$
(1/D - lambda)^2 + (k Delta t^2) / (m D^2) = 0
$$

복소 고유값:
$$
lambda = (1 pm i sqrt(k/m) Delta t) / D, quad D = 1 + (k Delta t^2)/m
$$

크기:
$$
|lambda|^2 = 1 / (1 + (k Delta t^2)/m) < 1
$$

따라서 후진 오일러는 $Delta t$ 크기와 무관하게 항상 안정적.
