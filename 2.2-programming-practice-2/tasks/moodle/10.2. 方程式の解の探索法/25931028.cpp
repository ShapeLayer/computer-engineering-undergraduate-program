#ifdef __cplusplus
#include <cstdio>
#include <cstdbool>
#include <climits>
#include <cmath>
#else
#include <stdio.h>
#include <stdbool.h>
#include <limits.h>
#include <math.h>
#endif

#ifdef __cplusplus
extern "C" {
#endif

#ifdef _MSC_VER
#define scnf(...) scanf_s( __VA_ARGS__ )
#else
#define scnf(...) scanf( __VA_ARGS__ )
#endif

#define i32 int
#define i64 long long
#define f32 float
#define f64 double

#define F64_EPSILON 1e-16

#define _FAILURE_A_IS_GREATER_THAN_B { \
  printf("error: wrong input (a is greater than or equal to b).\n"); \
  return 1; \
}
#define _FAILURE_F_A_AND_F_B_HAVE_SAME_SIGN { \
  printf("error: wrong input (f(a) and f(b) have the same sign).\n"); \
  return 1; \
}
#define _SUCCESS(...) { \
  printf("解の一つは%.6lfです\n", __VA_ARGS__); \
  return 0; \
}

f64 f(f64 x) {
  return x * x * x - 2 * x * x - 5 * x + 6;
}

int main() {
  f64 a, b;
  scnf("%lf%lf", &a, &b);
  if (a >= b) _FAILURE_A_IS_GREATER_THAN_B;

  f64 fa = f(a);
  f64 fb = f(b);

  if (fabs(fa) < F64_EPSILON) _SUCCESS(a);
  if (fabs(fb) < F64_EPSILON) _SUCCESS(b);

  if (fa * fb > 0) _FAILURE_F_A_AND_F_B_HAVE_SAME_SIGN;

  f32 c, fc;

  while (
    (b - a) > F64_EPSILON &&
    fabs((a + b) / 2.0) > F64_EPSILON
  ) {
    c = (a + b) / 2.0;
    fc = f(c);

    if (fabs(fc) < F64_EPSILON) {
      _SUCCESS(c);
    } 
    
    if (fa * fc < 0) {
      b = c;
      fb = fc;
    } else {
      a = c;
      fa = fc;
    }
  }

  c = (a + b) / 2.0;
  _SUCCESS(c);

  return 0;
}

#ifdef __cplusplus
}
#endif
