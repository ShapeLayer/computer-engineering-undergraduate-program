/**
 * 일본의 우편번호는 0으로 시작할 수 있음
 * https://ja.wikipedia.org/wiki/%E6%97%A5%E6%9C%AC%E3%81%AE%E9%83%B5%E4%BE%BF%E7%95%AA%E5%8F%B7
 */
#include "bits/stdc++.h"
using namespace std;
#define u32 unsigned int

struct postal_code {
  u32 front;
  u32 back;
} typedef postal_code_t;

inline bool parse_postal_code(const string &str, postal_code_t *code) {
  if (str.length() != 7) return false;

  code->front = 0;
  code->back = 0;

  for (int i = 0; i < 3; i++) {
    if (!isdigit(str[i])) return false;
    code->front = code->front * 10 + (u32)(str[i] - '0');
  }

  for (int i = 3; i < 7; i++) {
    if (!isdigit(str[i])) return false;
    code->back = code->back * 10 + (u32)(str[i] - '0');
  }
  return true;
}

string postalcode_to_hash(const postal_code_t *code) {
  ostringstream oss;
  oss << setw(3) << setfill('0') << code->front
      << setw(4) << setfill('0') << code->back;
  return oss.str();
}

int main() {
  ios::sync_with_stdio(false);
  cin.tie(nullptr);
  cout.tie(nullptr);

  string get;
  map<string, string> addr_table;

  // register
  bool postal_code_is_zero = false;
  do {
    // postal code
    cin >> get;
    postal_code_is_zero = get == "0";
    
    postal_code_t code;
    if (!parse_postal_code(get, &code)) { continue; }

    // address
    cin >> get;
    if (postal_code_is_zero && get == "$$") break;
    
    addr_table[postalcode_to_hash(&code)] = get;
  } while (get != "$$");

  // search
  do {
    cin >> get;
    if (get == "0") { break; }

    postal_code_t code;
    if (!parse_postal_code(get, &code)) { continue; }

    string hash = postalcode_to_hash(&code);
    if (addr_table.find(hash) != addr_table.end()) {
      cout << addr_table[hash] << endl;
    } else {
      cout << "該当住所がありません" << endl;
    }
  } while (true);

  return 0;
}
