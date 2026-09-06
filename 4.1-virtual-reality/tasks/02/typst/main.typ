#let sans = ("Noto Sans KR", "Noto Sans CJK KR", "Noto Sans JP", "Noto Sans CJK JP")
#let serif = ("Noto Serif KR", "Noto Serif CJK KR", "Noto Serif JP", "Noto Serif CJK JP")
#let mono = ("Noto Sans Mono", "D2Coding", "MonoplexKR")

#set text(font: serif, size: 10pt)

#counter(page).update(1)

// Required End

#set page(margin: (
  top: 25mm,
  bottom: 25mm,
  left: 25mm,
  right: 25mm,
),
  numbering: "1"
)

// #show raw: it => text(font: mono)[#it]

#set text(font: serif, size: 10pt)
#show heading.where(
  level: 1
): it => block(width: 100%)[
  #set align(center)
  #text(weight: "regular", size: 1.3em)[
    #it.body
  ]
]

#show heading.where(level: 2): set text(size: 1.5em, weight: "semibold")
#show heading.where(level: 2): set align(center)
#show heading.where(level: 3): set text(size: 1.3em, weight: "regular")

#show quote.where(block: true): set align(center)

#let img(path, size: 100%) = {
  align(center)[
    #image(path, width: size)
  ]
}

#let hero(
  title,
  subtitle,
) = [
  #place(
    top,
    float: true,
    scope: "parent",
    clearance: 30pt,
  )[
    = #title
    #v(12pt)
    #align(center)[#text(size: 1.5em)[
      #subtitle
    ]]

    #v(10pt)
    
    #align(center)[
    박종현, 
    전남대학교 공과대학 컴퓨터정보통신공학과\
    jonghyeon\@jnu.ac.kr
    ]
  ]
]

#show raw.where(block: false): it => box(fill: rgb("f5f5f5"), outset: (y: 3pt), inset: (x: 2pt), text(fill: red, it))
#show raw.where(block: true): it => block(fill: rgb("f5f5f5"), inset: (x: 10pt, y: 10pt), width: 100%, it)

#set par(justify: true, leading: 1.1em)

#set footnote.entry(gap: 1em)
#show footnote.entry: set par(leading: 1em, spacing: 1em)

#set table(stroke: 0.5pt + luma(25%))

/**
 * Content Start
 */

#hero(
  [발산하지 않는 최대 타임스텝 ∆t 구하기],
  [〈가상현실〉과제]
)

\

== 1. 시뮬레이션 구현 분석

\

=== 용수철 힘 계산

```cs
private void ApplySpringForce();
```


```cs
Vector3 diff;  // 마우스로 잡아끈 결과로써 물체에 이동에 관해 변화시켜야 하는 정도
float currentDistance = diff.magnitude;
Vector3 dir = diff.normalized;
```

\

훅의 법칙 적용
```cs
// Hooke's Law (F = kx)
float displacement = currentDistance - restLength;
Vector3 springForce = dir * (springConstant * displacement);
```

$
F_s = k x
$

변위에 비례하는 스프링 힘`springForce`를 계산한다. `springConstant`는 스프링 강성 $k$, `dir`과 `displacement`는 변위 $x$의 방향과 세기이다.

\

감쇠 적용
```cs
// Damping (F = -cv)
Vector3 r = worldVertexPos - transform.position;
Vector3 pointVelocity = velocity + Vector3.Cross(angularVelocity, r);
Vector3 damperForce = -dampingConstant * pointVelocity;
```

접점의 속도에 반대하는 감쇠를 적용한다. 감쇠는 감쇠 계수 $c$, 접점 속도 $dot(x)_v$, 감쇠력 $F_d$에 대해 다음과 같이 계산한다.

$
dot(x)_v = v + omega times r
$

$
F_d = -c dot(x)_v
$

접점 속도 `pointVelocity` $dot(x)_v$는 병진 속도 `velocity`와 회전에 의한 접선 속도 $dot(theta) times r$의 합으로 계산된다.

\

힘과 토크 계산 결과값 누적

```cs
Vector3 totalForce = springForce + damperForce;
forceAccumulator += totalForce;
torqueAccumulator += Vector3.Cross(r, totalForce);
```

최종 외력 `totalForce` $F$ 는 스프링 힘과 감쇠력의 합으로 구성된다.

$
arrow(F)_s = k x = k "displacement" arrow("dir")\
arrow(F)_v = arrow(v) + bold(omega) times arrow(r) \
arrow(F)_d = -c dot arrow(x)_v = -c arrow(v) + bold(omega) times bold(r)
$

$
arrow(a) = arrow(F)_"total" dot m^(-1)\
arrow(tau) = arrow(r) times arrow(F)_"total"\
$

역관성 텐서:
$
alpha = I^(-1) arrow(tau)
$

```cs
Vector3.Scale(tau, inverseInertiaTensor)
```

=== 적분식

dt 선택:

```cs
float dt = useFixedDeltaTime ? Time.fixedDeltaTime : customTimeStep;
```

=== 회전 업데이트

코드에서는 회전에 대해 각속도 벡터 $bold(omega)$의 dt 스텝분을 `rotationStep`이라 두고,

```cs
Vector3 rotationStep = angularVelocity * dt;
float angle = rotationStep.magnitude * Mathf.Rad2Deg; // 라디안을 도 단위로
Quaternion deltaRot = Quaternion.AngleAxis(angle, rotationStep.normalized);
transform.rotation = deltaRot * transform.rotation;
```

수학적으로, 작은 회전 벡터 $bold(theta)=bold(omega) Delta t$에 대해 회전 쿼터니언은 축/각 표현으로 적용된다.

=== 감쇠

각 스텝의 처리 마지막에 다음과 같은 감쇠 항을 적용한다:

```
velocity *= 0.995f;
angularVelocity *= 0.995f;
```

=== Explict Euler 방법

질량 $m$, 감쇠 계수 $c$, 용수철 상수 $k$ 인 운동 방정식은 질량 $m = 1$ 로 가정할 때, 아래와 같다.

$
dot.double(x) = -c dot(x) - k(x)
$

변수를 $bold(upright(y)) = mat(delim: "[", x; y)$ 라고 할 때, Explict Euler 방법에 대해서 다음과 같이 정리할 수 있다.

$
dot(bold(upright(y))) = mat(delim: "[", dot(x); dot(v)) = mat(delim: "[", 0, 1; -k, -c) mat(delim: "[", x; y) = bold(upright(A)) bold(upright(y))
$

$
bold(upright(y))_(n + 1) = bold(upright(y))_n + Delta t dot(bold(upright(y)))_n = bold(upright(y))_n + Delta t bold(upright(A)) bold(upright(y))_n = (bold(upright(I)) + Delta t bold(upright(A)))bold(upright(y))_n
$

시뮬레이션이 발산하지 않고 안정적이려면, 상태 전이 행렬인 $(bold(upright(I)) + Delta t bold(upright(A)))$의 모든 eigenvalue $lambda$ 의 크기가 1보다 작거나 같아야 한다. $(lambda <= 1)$
행렬 $bold(upright(A))$ 의 교유값을 $mu$ 라고 하면, 상태 전이 행렬의 고유값은 $lambda = 1 + Delta t mu$가 된다. 따라서 안정성 조건은 $| 1 + Delta mu| <= 1$ 이다.

== 2. 안정성 조건 계산

행렬 $bold(A) = mat(0, 1; -k, -c)$ 의 고유값 $mu$는 특성 방정식 $det(bold(A) - mu bold(I)) = 0$을 풀어 구한다.

$ mu^2 + c mu + k = 0 $


$ mu = (-c plus.minus sqrt(c^2 - 4k)) / 2 = -c / 2 plus.minus i sqrt(4k - c^2) / 2 $

$mu$는 $c^2 < 4k$일 때 복소수 근을 갖는다.
- 실수부: $alpha = -c / 2$
- 허수부: $beta = sqrt(4k - c^2) / 2$
- $alpha^2 + beta^2 = (-c / 2)^2 + (sqrt(4k - c^2) / 2)^2 = c^2 / 4 + (4k - c^2) / 4 = k$

\

안정성 조건 $|1 + Delta t mu| <= 1$ 에 $mu = alpha + i beta$ 를 대입하면 다음과 같다:

$ |1 + Delta t (alpha + i beta)| <= 1 $
$ |(1 + Delta t alpha) + i(Delta t beta)| <= 1 $
$ (1 + Delta t alpha)^2 + (Delta t beta)^2 <= 1^2 $
$ 1 + 2 Delta t alpha + Delta t^2 alpha^2 + Delta t^2 beta^2 <= 1 $
$ 2 Delta t alpha + Delta t^2 (alpha^2 + beta^2) <= 0 $
$ 2 alpha + Delta t (alpha^2 + beta^2) <= 0  quad (Delta t > 0) $
$ Delta t (alpha^2 + beta^2) <= -2 alpha $
$ Delta t <= (-2 alpha) / (alpha^2 + beta^2) $
$ Delta t <= c / k quad (-2 alpha = c, alpha^2 + beta^2 = k) $

따라서 질량 $m$이 1일 때, Explict Euler 방법에서 시스템이 발산하지 않는 최대 타임스텝은 $Delta t_(max) = c/k$ 이다.

== 3. 결론

주어진 시뮬레이션 파라미터가 $m=1, k=200, c=10$ 일 때:

$ Delta t_(max) = 10 / 200 = 0.05 "sec" $

`customTimeStep`이 $0.05$초를 초과하면, 값이 발산하여 오브젝트가 폭발한다. 

\

#image("assets/unity.png")

```cs
// 위치가 과도하게 커지면 발산으로 판단하고 리셋한다.
if (transform.position.magnitude > 100f)
{
  Debug.LogWarning("시뮬레이션 발산 발생! 위치를 리셋합니다.");
  ResetPhysics();
}
```

미리 작성된 발산 감지 코드는 위치 벡터의 크기가 100을 초과할 때 발산으로 감지한다. 때문에 실험 과정에서 $Delta t$를 $0.05$로 두고 물체의 움직임을 매우 격하게 제어했더니, 실제로는 발산하지 않음에도, 처리 값이 발산하는 것으로 판단하는 경우가 있었다.
