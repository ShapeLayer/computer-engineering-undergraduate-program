#let subtext(content) = {
  text(size: .5em, fill: luma(40%))[#content]
}
#set page("a4",
  flipped: true,
  columns: 4,
  margin: (x: 10pt, y: 10pt),
  header: subtext([모바일통신시스템 Cheat Sheet]),
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

== Ch 1. 이동통신의 개요

*Decibel*
- $1"dB" = 10 log_10(P_2/P_1)$ -- (Power)
- $1"dB" = 20 log_10(V_2/V_1)$ -- (Volts)

#table(
  columns: 4,
  [3dB], [전력 2배 증가], [6dB], [전압 2배 증가],
  [-3dB], [전력 1/2배로 감소], [-6dB], [전압 1/2배로 감소],
  [10dB], [전력 10배 증가], [20dB], [전압 10배 증가],
  [-10dB], [전력 1/10배로 감소], [-20dB], [전압 1/10배로 감소],
)


*Decibel의 절대강도*
- $"dBm" = 10 log "Power"/(1"mW")$
- $"dBW" = 10 log "Power"/(1"W")$

#table(
  columns: 2,
  [Power in Watts], [Power in dBm],
  [0.1mW], [-10dBm],
  [1mW], [0dBm],
  [1W], [30dBm],
  [1000W], [60dBm]
)

*Decibel의 연산*
- $A "dB" plus.minus B "dB" = (A plus.minus B) "dB"$
- $A "dBm" plus.minus B "dB" = (A plus.minus B) "dB"$
- $A "dBm" - B "dBm" = (A - B) "dB"$

*Uncertainty*
- 정보 $X_j$가 발생할 확률 $p(X_j) = p_j$의 자기정보량\
  $I(X_j) = log_2(1/p_j) = -log_w p_j "bits"$
- 평균자기정보량\
  $H(X) = E[I(X_j)] = sum_(j=1)^N p_j log_2(1/p_j) = -sum_(j=1)^(N) p_j log_2 p_j$
- 엔트로피\
  $H = sum_(j=1)^(N) p_j log_2(1/p_j) = -sum_(j = 1)^(N) p_j log_2 p_j$

*Thermal Noise*
- $N_o = K T$
  - $N_o$: 잡음전력밀도 (W/Hz)
  - $K$: 볼츠만 상수 ($1.38 times 10^(-23)$ J/K)
  - $T$: 절대온도 (K) = 섭씨온도 + 273.15
- $B$ Hz의 대역폭에서 잡음전력\
  $N = N_o B = k T B$ (W)\
  $N_"dBm" = 10 log_(10)(N/1"mW") = 10 log_(10)(k T B / 1"mW")$ (dBm)

*채널 용량*
#grid(
  columns: 2,
  [
    - Nyquist's Formula\
      $C = 2 B log_2 M$ (bps)
      - $C$: 채널 용량 (bps)
      - $B$: 대역폭 (Hz)
      - $M$: Binary Symbol의 수
  ],
  [
    - Shannon's Formula\
      $C = B log_2(1 + S/N)$ (bps)
      - $C$: 채널 용량 (bps)
      - $B$: 대역폭 (Hz)
      - $S$: 신호전력 (W)
      - $N$: 잡음전력 (W)
  ]
)

\
- Siganl to Noise Ratio: $E_b / N_0$
  - $E_b/N_0 = (S T_b)/(N_0) = S/R times 1/(k T) = S / (N_0 R)$
  #grid(
    inset: (x: 0em, y: .3em),
    columns: (2),
    [- $E_b = S T_b$: 신호에 할당된 E (J)],
    [- $T_b = 1/R$: 1비트당 시간 (s)],
    [- $R$: 데이터 전송률 (bps)],
    [- $N_0 = N/B$: 잡음전력밀도 (W/Hz)],
  )
- 신호의 대역폭이 $B$ 일 때
  - $E_b/N_0 = S / N times B / R$

*주파수 효율*
- $eta_b = R/B "bps/Hz"$
  - $R$: 데이터 전송률 (bps), $B$: 대역폭 (Hz)
- 최대 주파수 효율\
  $eta_b = C/B= log_2(1 + S/N) "bps/Hz"$

== Ch 2. 전파와 전송 시스템

*파장과 안테나의 길이*
- $lambda = C / f$
- 안테나의 길이: 파장의 $1/2$ 혹은 $1/4$

*in Simple Model*
- Path 1: $alpha/r cos(2 pi f (t - r/c))$
- Path 2: $- alpha/(2d - r) cos(2 pi f (t - (2d - r)/c))$
- Rx: $alpha/r cos(2 pi f (t - r/c)) - alpha/(2d - r) cos(2 pi f (t - (2d - r)/c))$
- $Delta theta = {(w pi f (2d - r))/ c+pi}-{(2 pi f r)/c} = 2 pi {((2d - r) - r)/c} f + pi$
- Delay Spread $T_d = (2d - 2r)/c$
  - $Delta theta$ 짝수배: 보강, 홀수배: 상쇄

*등방형 방사기*
- $P_d = P_t / (4 pi r^2)$
  - $P_d$: 거리 $r$에서의 전력 밀도 (W/m^2)
  - $P_t$: 송신 전력 (W)
  - $r$: 송신기로부터의 거리 (m)

*실제 전파 환경에서 안테나 이득*
- $G_t = (P_"DA")/P_"DI"$
  - $G_t$: 송신 안테나 이득
  - $P_"DA"$: 송신 안테나에서 방사되는 전력 밀도 (W/$"m"^2$)
  - $P_"DI"$: 등방형 방사기에서 방사되는 전력 밀도 (W/$"m"^2$)
- 수신 전력밀도: $P_D = (P_t G_t)/(4 pi d^2)$

*최대송신전력 EIRP*
- $"EIRP" = P_t G_t; "ERP [dB]" = "EIRP [dB]" - G_d$
  - $"EIRP"$: 등가등방성방사전력 (W)
  - $P_t$: 송신 전력 (W)
  - $G_t$: 송신 안테나 이득
  - $"ERP"$: 등가방사전력 (W)
  - $G_d$: 등방형 방사기에 대한 안테나 이득 (dB) ($approx 2.15 "dB"$)

*전자장 강도로 신호 세기 측정*
- $P = V^2/R; P_D=epsilon^2/Z=epsilon^2/377$
  - $P$: 전력 (W)
  - $V$: 전압 (V)
  - $R$: 저항 (Ohm)
  - $P_D$: 전력 밀도 (W/m^2)
  - $epsilon$: 전자장 강도 (V/m)
- $epsilon = sqrt(P_D times 377) = sqrt((377 "EIRP")/(4 pi d^2)) = sqrt((30 "EIRP")/d)$

*수신전력*
- $A_"eff" = P_r / P_D$
  - $A_"eff"$: 안테나의 유효면적 (m^2)
  - $P_r$: 수신 전력 (W)
  - $P_D$: 수신 지점에서의 전력 밀도 (W/m^2)
- $P_r = A_"eff" P_D = (A_"eff" P_t G_t)/(4 pi d^2)$
- $A_"eff" = (lambda^2 G_r)/(4 pi); quad G_r = (4 pi A_"eff")/(lambda^2)$

*수신전력*
- $P_r = (A_"eff" P_t G_t)/(4 pi d^2) = (lambda^2 P_t G_t G_r)/((4 pi)(4 pi d^2)) = ("EIRP" G_r)/(4 pi d \/ lambda)^2 = ("EIRP" G_r)/L_"fs"$
  - $P_r$: 수신 전력 (W)
  - $A_"eff"$: 안테나의 유효면적 (m^2)
  - $P_t$: 송신 전력 (W)
  - $G_t$: 송신 안테나 이득
  - $d$: 송신기로부터의 거리 (m)
  - $lambda$: 파장 (m)
  - $"EIRP"$: 등가등방성방사전력 (W)
  - $G_r$: 수신 안테나 이득
  - $L_"fs"$: 자유공간 손실
- [dB] $P_r = P_t + G_t + G_r - (32.44 + 20 log d + 10 log f)$

*자유경로손실*
- $L_"fs" = P_t/P_r = 1/(G_t G_r) ((4 pi d)/lambda)^2$
- $L_"fs" = ((4 pi d)/lambda)^2 = (4 pi f_c d)^2/(c)^2$ $(G_t=1; G_r=1)$
- $L_"fs" "[dB]" = 32.44 + 20 log_(10)d + 10 log_(10)f$

*Friis 자유공간 모델*
- $d_f = (2D^2)/lambda; quad d_f > D; quad d_f > lambda$
- $p_r (d) = P_r (d_0) (d_0/d)^2; quad d >= d_0 >= d_f$
- 안테나 끝단에서 관측점까지의 거리
  - $r = sqrt(R^2 + (D/2)^2) approx R[1 + 1/2 (D/(2R))^2] = R + (D^2)/(8R)$
  - $Delta = r - R approx (D^2)/(8R)$
  - $phi = beta Delta = (2 pi)/lambda Delta = (2 pi)/lambda (D^2)/(8R) <= pi/8$

*자유공간에서의 전파*
- 수신전력 $P_r = P_"ti"/P_"ri"= (P_t G_t G_r)/(L_t L L_r) = (P_t G_t G_r) / ((4 pi d)/lambda)^2$
  - $L"[dB]" = 10 log_(P_"ti"/P_"ri")$
  - $arrow.double p_r(d) = p_r (d_0)(d_0/d)^2$
- 평균 경로손실\
  $overline(P L)(d)"[dB]" = overline(d_0)"[dB]"+10 log (d/d_0)^n$
  - $n$: pathloss exponent
  - log-normal shadow: $overline(P L)(d)"[dB]" = overline(d_0)"[dB]"+10 log (d/d_0)^n + X_sigma$
    - PDF: $f_Y (y) = 1/(y sigma sqrt(2 pi) ) exp(-(ln y - mu)^2/(2 sigma^2))$
    - Normal PDF: $f_X(x) = 1/(sigma sqrt(2 pi) ) exp(-(x - mu)^2/(2 sigma^2))$

*잡음 모델*
- Noise Figure: $F = (S/N)_"in"/(S/N)_"out" = ((S_"in")/(N_"in"))/((G S_"in")/(G (N_"in" + N_"amin")))) = 1 + (N_"amin"/N_"in")$
  - $F$: 잡음 지수

*안테나 이득*
- $g = d times e; quad G = 10 log e + D "[dB]"$
  - $d$: 방향성, $e$: 안테나 효율

== Ch 3. Communication Channel \ Ch 4. Communication System

*Delay Spread*
- Rx $R(t) = A s(t) + A s(t - tau)$ \ 
  $arrow.r.l.double$ $R(f) = A S (f) + A S (f) e ^(-j 2 pi f tau) = A S (f)(1 + e ^(-j 2 pi f tau))$
- Effective Ch $H(f) = 1 + e^(-j 2 pi f tau) = e^(-j pi f tau) 2 cos(pi f tau)$
- Ch Spectrum $|H(f)| = 2 |cos(pi f tau)|$

*Small Scale Fading*
- $X = ln Y arrow.l.r.double Y = exp(X)$
- $f_X (x) = f_Y (y) (d y)/(d x) = 1/ (e^x sigma sqrt(2 pi)) exp(-(x - mu)^2/(2 sigma^2))e^x=1/(sigma sqrt(2 pi))exp(-(x - mu)^2/(2 sigma^2))$

*Rayleigh Fading*
- $f_h (h) = 1/overline(h) exp(-h/overline(h))$
  - $h$: 채널 이득의 제곱, $overline(h)$: 채널 이득의 평균
*Rician Fading*
- $K = (rho)^2/(2sigma^2) = "LOS"/"NLOS"$
- $f_h (h) = (K + 1)/overline(h) exp(-K - (K + 1) h/overline(h)) I_0(2 sqrt(K (K + 1) h/overline(h)))$
  - $I_0$: modified Bessel function of the first kind, order zero

== Ch 5. Cellular System

*Frequency Reuse*
- $C = K N M$
  - $K$ : 셀 당 채널 수, $N$: 클러스터 당 셀 수, $M$: 클러스터 수, $1/N$: 주파수 재사용 지수
- 같은 채널을 사용하는 셀의 간격\
  $D = D_"norm" times sqrt(3) R = sqrt(3N) R$
- Cochannel reuse ratio
  - $Q = D/R = sqrt(3N)$

*Interference*
- Rx $P_r = P_0 (d/d_0)^(-n)$
- $P_r "[dBm]" = P_0 "[dBm]" + 10n log(d/d_0)$
- $"SIR" = S / I = S/(sum_(i=1)^I I_i) = (P_0 (d_0)(R/d_0)^(-n))/(sum_(i=1)^I P_0 (d_i/d_0)^(-n)) = (R^(-n))/(sum_(i=1)^I D_i^(-n)) = 1/(sum_(i=1)^I (D_i/R)^(-n)) = 1/(sum_(i=1)^I Q_i^(-n))$

*Cell Splitting*
- Cell boundary
  - w/o splitting $P_r prop R_(t 1) R^(-n)$;   w/ splitting $P_r prop R_(t 2) (R\/2)^(-n)$

*Sectoring*
- SIR
  - w/ omni: $S/I=Q^n/6$
  - w/ dir: $S/I=Q^n/2$

*Trunking*
- GoS: $A_u = lambda H "[Erl]"$
  - $lambda$: 시간 당 전화 수, $H$: 시간 당 평균 통화 시간, $A_u$: 트래픽 강도
- $A = U A_u$; $U$: 가입자 수, $A$: 총 트래픽 강도
- 채널 당 제공 트래픽 강도: $A_c = A/C$
- Carried Traffic: $A_"ca" = A(1 - P_b)$
- Trunking 효율: $eta = A_"ca"/C = A(1 - P_b)/C$
\

- Erlang B Formula: $P_b = (A_c^C / C!)/(sum_(k=0)^C A_c^k / k!)$
- Erlang C Formula: $P_b = (A_c^C / C!)/(sum_(k=0)^(C-1) A_c^k / k! + (A_c^C / C!)(C/(C - A_c)))$

== Ch 6. CDMA System

*Orthogonality*
- $r(t) = s(t) + n(t)$
- $y(t) = r(t) * h(t) = integral r(tau)h(t - tau) d tau = s_0 (t) + n_0 (t)$
- Matched filter (SNR at t = $tau$)
  - $gamma = (|s_0 (T)|^2)/(bb(E)[|n_0 (T)|^2]) <= (integral_0^T |s(tau)|^2 d tau integral_0^T |h(t - tau)|^2 d tau)/(N_0/2 integral_0^tau |h(tau)|^2 d tau)$ 
  - 코시 슈바르츠: $|A B|^2 <= |A|^2 |B|^2$
- Optimal SNR $gamma^* = (integral_0^T |s(tau)|^2 d tau) / (N_0/2) = 2E_s / N_0$
  - $E_s$: 심볼당 에너지 (J)
  - 최적 채널 필터: $h(t) = s^*(T-t)  $
\
- Correlator
  - $y(t) = r(t) k s (t) = integral_0^T r(t) k s (tau) d tau$

*Auto Correlation*
- $R_(s s) (tau) = integral_(-infinity)^(infinity) s(t) s(t - tau) d tau$

*Spread Spectrum*
- Channel Capacity: $C = W log_2(1 + S/N)$ ($W$: 대역폭, $S/N$: 신호 대 잡음비)
- Processing Gain: $G_p = W/R$

*Rake Receiver*
- Tx: $s(t) = sqrt(P) d(t)c(t) cos(2 pi f_c t)$
- Rx: $r(t) = sum_(i=0)^(L-1) alpha_i s(t - tau_i) + n(t)$

#table(
  columns: (.5fr, 1fr, 1fr),
  align: horizon,

  [항목], [값(시간 영역)], [값(주파수 영역)],

  [메시지 데이터 \ Message Data],
  [
    $b(t) in {1, -1}$ \
    Bit Period: $T_b$ [sec]
  ],
  [
    $b(t) = sum_i b_i p_(T_b) (t - i T_b)$ \
    \* $p_(T_b)(t)$: Bit Period의 Pulse Function \
    $S_b(f) = T_b op("sinc")^2(f T_b)$ \
    Bandwidth: $B approx 1/T_b$
  ],

  // Row 2: Spreading Code
  [확산 코드 \ Spreading Code],
  [
    $c(t) in {1, -1}$ \
    Chip Period: $T_c$ [sec]
  ],
  [
    $c(t) = sum_n c_n p_(T_c) (t - n T_c)$ \
    $S_c(f) = T_c op("sinc")^2(f T_c)$ \
    Bandwidth: $B approx 1/T_c$
  ],

  // Row 3: Spread Signal
  [확산 신호 \ Spread Signal],
  [
    $x(t) = b(t) dot c(t)$ \
    Signal Period: $T_c$ [sec]
  ],
  [
    $S_x(f) = S_b(f) ast S_c(f)$ \
    Bandwidth: $W approx 1/T_c$
  ],

  // Row 4: De-spread Signal
  [복조된 신호 \ De-spread Signal],
  [
    $b(t) = x(t) dot c(t)$ \
    $c^2(t) = 1$
  ],
  [],

  // Row 5: Processing Gain
  [처리 이득 \ Processing Gain],
  [],
  [
    $G_p = frac(1 \/ T_c, 1 \/ T_b) = T_b / T_c$ \
    $1/T_c$ 는 확산 대역 $W$, \
    $1/T_b$ 는 원본 대역 $B$
  ]
)

*Uplink Capacity*
- $E_b/N_0 = (S T)/(N\/W) = S/N W/R = S/N S F$
  - $S$: 신호전력 (W), $T$: 심볼당 시간 (s), $N$: 잡음전력 (W), $W$: 확산 대역폭 (Hz), $R$: 원본 대역폭 (Hz), $S F$: 확산 이득
- 완벽히 전력 제어 시 $S/N = 1/(M - 1); E_b/N_0 = 1/(M - 1) W/R$
- 실제 상황 $E_b/N_0 = 1/(M-1) W/R 1/(1+ eta) lambda$ ($eta$: 기타 간섭, $lambda$: 섹터화 이득)
