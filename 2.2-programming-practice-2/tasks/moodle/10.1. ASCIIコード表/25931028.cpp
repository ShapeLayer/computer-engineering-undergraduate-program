/**
 * This problem requires using the `printf` function explicitly, but not in `scanf`.
 * But it looks to be intended to use C-style I/O functions.
 * Because of that, I decided to use the C spec only.
 * 
 * However, it still looks to be implemented as a C++ program,
 * I wrapped my C code to make it compatible with both C and C++ compilers.
 */

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
#include <cstdio>
#include <cstdbool>
#include <climits>
#else
#include <stdio.h>
#include <stdbool.h>
#include <limits.h>
#endif

#define BUF_SIZE 128
#define FLAG_INVLD INT_MIN
char buf[BUF_SIZE];

int __parse_next_int(
  const char *str,
  int *ptr,
  int str_len
) {
  int val = 0;
  bool int_parsed = false;

  for (int i = *ptr; i < str_len; i++) {
    if ('0' <= str[i] && str[i] <= '9') {
      val = val * 10 + (str[i] - '0');
      int_parsed = true;
    } else {
      if (!int_parsed) continue;
      *ptr = i + 1;
      return val;
    }
  }
  *ptr = str_len;
  if (int_parsed) return FLAG_INVLD;
  return val;
}

int main() {
  int start, end;
  if (fgets(buf, sizeof(buf), stdin) == NULL) {
    return 1;
  }

  int p_parse = 0;
  start = __parse_next_int(buf, &p_parse, BUF_SIZE);
  end = __parse_next_int(buf, &p_parse, BUF_SIZE);

  if (start == FLAG_INVLD || end == FLAG_INVLD) {
    return 1;
  }

  printf("|-------------------|\n");
  printf("|16進|10進| 8進|文字|\n");
  printf("|-------------------|\n");
  for (int i = start; i < end; i++) {
    printf("|%4x|%4d|%4o|%4c|\n", i, i, i, (char)i);
  }
  printf("|-------------------|\n");
  return 0;
}

#ifdef __cplusplus
}
#endif
