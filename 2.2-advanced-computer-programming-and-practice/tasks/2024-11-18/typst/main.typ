#import "@preview/codly:0.2.0": *
#show: codly-init.with()
#codly(languages: (
  py: (name: "Python", icon: "", color: rgb("#3572A5")),
  cpp: (name: "C++", icon: "", color: rgb("#f34b7d")),
  sh: (name: "Shell", icon: "", color: rgb("#58c623"))
))


#set page(
  margin: (x: 3em, y: 4em)
)
#set text(font: ("Noto Sans CJK KR", "Noto Sans KR"), size: .9em)

#align(center)[
  #text(size: 2em)[고급프로그래밍및실습 과제 \#6 (12주차)]\
  
  214823 박종현
]

1. `static_cast`
2. `dynamic_cast`
3. `const_cast`
4. `reinterpret_cast`
+ (선택) 다중 예외처리

= 답안의 의도한 실행 결과
```
```

- 표준 출력 없음
- 호스트에게 `0` 리턴
\
발생해서는 안되는 상황
#align(center)[#image("assets/exceptions.png", width: 70%)]
- 의도적으로 예외를 발생시키는 코드에서 프로세스 호스트에게 다음 오류 코드를 리턴
  - `ECANCELED`(`89`) : 예외 발생 중 `AssertionFailedException`이 아닌 `exception` 발생
  - `ENOTRECOVERABLE`(`104`) : 아무 오류도 발생하지 않음

= 답안
```
```

```cpp
#include "bits/stdc++.h"
#define UUID_SIZE 37
#define _ASSERT(expr) do { if (!(expr)) throw AssertionFailedException(); } while (0)

enum ResponseState {
  ok,
  error,
};

class CommonResponse {
private:
  ResponseState state;
public:
  CommonResponse(ResponseState state): state(state) {}
  ResponseState getState() const {
    return state;
  }
};

class AssertionFailedException : public exception {};

class UUID {
private:
  uint32_t time_low;
  uint16_t time_mid;
  uint16_t time_hi_and_version;
  uint16_t clock_seq;
  uint64_t node;
public:
  UUID(uint32_t time_low, uint16_t time_mid, uint16_t time_hi_and_version, uint16_t clock_seq, uint64_t node): time_low(time_low), time_mid(time_mid), time_hi_and_version(time_hi_and_version), clock_seq(clock_seq), node(node) {}
  void get(char* buffer) const {
    snprintf(buffer, sizeof(buffer), "%08x-%04x-%04x-%04x-%012llx",
      time_low,
      time_mid,
      time_hi_and_version,
      clock_seq,
      node);
  }
  void set(char* buffer) {
    if (!buffer || strlen(buffer) != 36) {
      return;
    }

    unsigned int tl;
    unsigned short tm, thv, cs;
    unsigned long long n;

    if (sscanf(buffer, "%08x-%04hx-%04hx-%04hx-%012llx",
              &tl, &tm, &thv, &cs, &n) == 5) {
      time_low = tl;
      time_mid = tm;
      time_hi_and_version = thv;
      clock_seq = cs;
      node = n;
    }
  }
};

class AuthorizationResponse : public CommonResponse {
private:
  UUID secret_key;
public:
  AuthorizationResponse(ResponseState state, UUID secret_key): CommonResponse(state), secret_key(secret_key) {}
  UUID get_secret_key() const {
    return secret_key;
  }
};

int main() {
  CommonResponse cr = CommonResponse(ok);
  AuthorizationResponse ar = AuthorizationResponse(ok, UUID(0, 0, 0, 0, 0));

  CommonResponse ar__cr_converted = *dynamic_cast<CommonResponse*>(&ar);
  AuthorizationResponse cr__ar_converted = *static_cast<AuthorizationResponse*>(&cr);

  _ASSERT(typeid(cr) == typeid(CommonResponse));
  _ASSERT(typeid(ar) == typeid(AuthorizationResponse));
  _ASSERT(typeid(ar__cr_converted) == typeid(CommonResponse));
  _ASSERT(typeid(cr__ar_converted) == typeid(AuthorizationResponse));


  const UUID const_uuid = UUID(0x12345678, 0x9ABC, 0xDEF0, 0x1234, 0x567890ABCDEF);

  char ar_uuid_buf[UUID_SIZE];
  ar.get_secret_key().get(ar_uuid_buf);

  UUID const_uuid_new = (*const_cast<UUID*>(&const_uuid));
  const_uuid_new.set(ar_uuid_buf);

  char const_uuid_buf[UUID_SIZE];
  const_uuid_new.get(const_uuid_buf);

  _ASSERT(strcmp(ar_uuid_buf, const_uuid_buf));


  CommonResponse *pcr = &cr;
  AuthorizationResponse *par = &ar;
  
  cr__ar_converted = *(reinterpret_cast<AuthorizationResponse*>(pcr));
  ar__cr_converted = *(reinterpret_cast<CommonResponse*>(par));
  _ASSERT(typeid(cr__ar_converted) == typeid(ar));
  _ASSERT(typeid(ar__cr_converted) == typeid(cr));

  try {
    _ASSERT(typeid(cr__ar_converted) == typeid(cr));
  } catch (const AssertionFailedException e) {
    return 0;
  } catch (const exception e) {
    return ECANCELED;
  }
  return ENOTRECOVERABLE;
}

```
\
== 실행 결과
```
```

#align(center)[#image("assets/out.png")]
