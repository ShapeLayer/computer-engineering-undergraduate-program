#include "bits/stdc++.h"
using namespace std;

#define MAX_CODE_LENGTH 20
#define MAX_STACK_DEPTH 10
#define MIN_VALUE -1024
#define MAX_VALUE 1024
#define BEFUNGE_SPACE_ASCII "84*"

static constexpr uint8_t STACK_CAP = 12;

struct stack_state
{
  array<int, STACK_CAP> data{};
  uint8_t len = 0;

  bool operator==(const stack_state &other) const noexcept
  {
    if (len != other.len)
      return false;
    for (uint8_t i = 0; i < len; ++i)
      if (data[i] != other.data[i])
        return false;
    return true;
  }
} typedef stack_state_t;

struct stack_hasher
{
  size_t operator()(const stack_state_t &st) const noexcept
  {
    uint64_t h = st.len;
    for (uint8_t i = 0; i < st.len; ++i)
    {
      uint64_t v = static_cast<uint64_t>(st.data[i]);
      h ^= (v + (h << 6) + (h >> 2));
    }
    return static_cast<size_t>(h);
  }
} typedef stack_hasher_t;

struct node
{
  stack_state_t state;
  int parent;    // index in nodes vector
  char token;    // token that led here
  uint8_t depth; // program length so far
} typedef node_t;

inline bool in_bounds(const stack_state_t &st)
{
  if (st.len > MAX_STACK_DEPTH)
    return false;
  for (uint8_t i = 0; i < st.len; ++i)
    if (st.data[i] < MIN_VALUE || st.data[i] > MAX_VALUE)
      return false;
  return true;
}

inline bool apply_token(const stack_state_t &cur,
                       char tok,
                       stack_state_t &next)
{
  next = cur;

  auto __push = [&](int v) -> bool
  {
    if (next.len >= STACK_CAP)
      return false;
    next.data[next.len++] = v;
    return in_bounds(next);
  };

  if ('0' <= tok && tok <= '9')
  {
    return __push(tok - '0');
  }

  switch (tok)
  {
  case ':':
  {
    if (next.len == 0 || next.len >= STACK_CAP)
      return false;
    next.data[next.len] = next.data[next.len - 1];
    ++next.len;
    return in_bounds(next);
  }
  case '+':
  case '-':
  case '*':
  case '/':
  case '%':
  {
    if (next.len < 2)
      return false;
    int a = next.data[--next.len];
    int b = next.data[--next.len];
    long long result = 0;
    if (tok == '+')
      result = static_cast<long long>(b) + a;
    else if (tok == '-')
      result = b - a;
    else if (tok == '*')
      result = static_cast<long long>(b) * a;
    else if (tok == '/')
    {
      if (a == 0)
        return false;
      result = b / a;
    }
    else
    { // '%'
      if (a == 0)
        return false;
      result = b % a;
    }
    if (result < INT_MIN || result > INT_MAX)
      return false;
    next.data[next.len++] = static_cast<int>(result);
    return in_bounds(next);
  }
  default:
    return false;
  }
}

static constexpr array<char, 6> ops = {':', '+', '-', '*', '/', '%'};

inline vector<char> make_token_order(int target)
{
  vector<pair<int, char>> digits;
  digits.reserve(10);
  for (char d = '0'; d <= '9'; ++d)
  {
    int val = d - '0';
    digits.emplace_back(abs(target - val), d);
  }
  sort(digits.begin(), digits.end(),
       [](auto &lhs, auto &rhs)
       {
         if (lhs.first != rhs.first)
           return lhs.first < rhs.first;
         return lhs.second < rhs.second;
       });

  vector<char> order;
  order.reserve(16);
  for (auto &p : digits)
    order.push_back(p.second);
  order.insert(order.end(), ops.begin(), ops.end());
  return order;
}

inline string rebuild_code(const vector<node_t> &nodes, int idx)
{
  string program;
  while (idx != 0)
  {
    program.push_back(nodes[idx].token);
    idx = nodes[idx].parent;
  }
  reverse(program.begin(), program.end());
  return program;
}

string find_shortcode(int target)
{
  vector<node_t> nodes;
  nodes.reserve(100000);
  nodes.push_back(node_t{stack_state_t{}, -1, 0, 0});

  queue<int> q;
  q.push(0);

  unordered_set<stack_state_t, stack_hasher_t> visited;
  visited.reserve(100000);
  visited.insert(nodes[0].state);

  vector<char> token_order = make_token_order(target);

  while (!q.empty())
  {
    int curr_ptr = q.front();
    q.pop();

    const node_t &curr_node = nodes[curr_ptr];
    const stack_state_t &state = curr_node.state;

    if (state.len > 0 && state.data[state.len - 1] == target)
    {
      return rebuild_code(nodes, curr_ptr);
    }
    if (curr_node.depth >= MAX_CODE_LENGTH)
      continue;

    for (char tok : token_order)
    {
      stack_state_t next;
      if (!apply_token(state, tok, next))
        continue;
      if (!visited.emplace(next).second)
        continue;

      nodes.push_back(node_t{next, curr_ptr, tok, static_cast<uint8_t>(curr_node.depth + 1)});
      q.push(static_cast<int>(nodes.size() - 1));
    }
  }
  return {};
}

int gcd(int a, int b)
{
  while (b != 0)
  {
    int r = a % b;
    a = b;
    b = r;
  }
  return a;
}

inline bool simulate_token(vector<int> &stack, char tok)
{
  auto push = [&](int v) -> bool
  {
    stack.push_back(v);
    return true;
  };

  if ('0' <= tok && tok <= '9')
    return push(tok - '0');

  switch (tok)
  {
  case ':':
    if (stack.empty())
      return false;
    stack.push_back(stack.back());
    return true;
  case '\\':
    if (stack.size() < 2)
      return false;
    swap(stack.back(), stack[stack.size() - 2]);
    return true;
  case '+':
  case '-':
  case '*':
  case '/':
  case '%':
  {
    if (stack.size() < 2)
      return false;
    int a = stack.back();
    stack.pop_back();
    int b = stack.back();
    stack.pop_back();
    long long res = 0;
    if (tok == '+')
      res = (long long)b + a;
    else if (tok == '-')
      res = b - a;
    else if (tok == '*')
      res = (long long)b * a;
    else if (tok == '/')
    {
      if (a == 0)
        return false;
      res = b / a;
    }
    else
    {
      if (a == 0)
        return false;
      res = b % a;
    }
    stack.push_back(static_cast<int>(res));
    return true;
  }
  case '.':
  case ',':
    if (stack.empty())
      return false;
    stack.pop_back();
    return true;
  default:
    return true;
  }
}

inline string make_strategy_program(const vector<int> &values)
{
  string program;
  vector<int> stack;

  auto emit = [&](char tok) -> bool
  {
    if (!simulate_token(stack, tok))
      return false;
    program.push_back(tok);
    return true;
  };

  auto emit_seq = [&](string_view seq) -> bool
  {
    for (char tok : seq)
      if (!emit(tok))
        return false;
    return true;
  };

  auto emit_space = [&]() -> bool
  {
    constexpr size_t pushCost = (sizeof(BEFUNGE_SPACE_ASCII) - 1) + 1; // literal + ','
    constexpr size_t swapDupCost = 4;                                  // \ : , \

    auto dup_top = [&]() -> bool
    {
      if (stack.empty() || stack.back() != 32)
        return false;
      return emit(':') && emit(',');
    };

    auto dup_with_swap = [&]() -> bool
    {
      if (stack.size() < 2 || stack[stack.size() - 2] != 32)
        return false;
      return emit('\\') && emit(':') && emit(',') && emit('\\');
    };

    if (dup_top())
      return true;

    if (pushCost >= swapDupCost && dup_with_swap())
      return true;

    if (!emit_seq(BEFUNGE_SPACE_ASCII))
      return false;
    return emit(',');
  };

  for (size_t i = 0; i < values.size(); ++i)
  {
    string code = find_shortcode(values[i]);
    if (code.empty() || !emit_seq(code) || !emit('.'))
      return {};
    if (i + 1 < values.size() && !emit_space())
      return {};
  }
  return program;
}

inline bool fill_horizontal(const string &program, int w, int h, vector<string> &grid)
{
  size_t idx = 0;
  for (int r = 0; r < h; ++r)
  {
    if (r % 2 == 0)
    {
      for (int c = 0; c < w; ++c)
      {
        if (r > 0 && c == 0)
          grid[r][c] = '>';
        else if (c == w - 1 && r + 1 < h)
          grid[r][c] = 'v';
        else
          grid[r][c] = (idx < program.size()) ? program[idx++] : ' ';
      }
    }
    else
    {
      for (int c = w - 1; c >= 0; --c)
      {
        if (c == w - 1)
          grid[r][c] = '<';
        else if (c == 0 && r + 1 < h)
          grid[r][c] = 'v';
        else
          grid[r][c] = (idx < program.size()) ? program[idx++] : ' ';
      }
    }
  }
  return idx == program.size();
}

inline bool fill_vertical(const string &program, int w, int h, vector<string> &grid)
{
  size_t idx = 0;
  for (int c = 0; c < w; ++c)
  {
    if (c % 2 == 0)
    {
      for (int r = 0; r < h; ++r)
      {
        if (r == 0)
          grid[r][c] = 'v';
        else if (r == h - 1 && c + 1 < w)
          grid[r][c] = '>';
        else
          grid[r][c] = (idx < program.size()) ? program[idx++] : ' ';
      }
    }
    else
    {
      for (int r = h - 1; r >= 0; --r)
      {
        if (r == h - 1)
          grid[r][c] = '^';
        else if (r == 0 && c + 1 < w)
          grid[r][c] = '>';
        else
          grid[r][c] = (idx < program.size()) ? program[idx++] : ' ';
      }
    }
  }
  return idx == program.size();
}

inline bool build_grid(const string &program, int w, int h, vector<string> &grid)
{
  if (w <= 0 || h <= 0)
    return false;
  grid.assign(h, string(w, ' '));
  if (w >= h)
    return fill_horizontal(program, w, h, grid);
  return fill_vertical(program, w, h, grid);
}

int main()
{
  ios::sync_with_stdio(false);
  cin.tie(nullptr);
  cout.tie(nullptr);

  /**
   * 문제:
   * 
   * 두 수 $A$와 $B$, 그리고 Befunge 소스코드의 가로 길이 $w$와 세로 길이 $h$가 주어질 때, $A$와 $B$, 그리고 $A+B$를 공백으로 구분하여 출력하는 $w \times h$ 크기의 Befunge 소스코드를 생성하는 프로그램을 작성하여라. 프로그램이 생성한 Befunge 코드를 실행하면 전체 칸의 절반 이상은 최소 한 번 실행되어야 한다. (전체 칸의 절반 이상은 커서가 거쳐가야한다.)  
   * 만약 그 어떤 경우에도 Befunge 코드를 생성할 수 없다면, `IMPOSSIBLE`을 출력하여라.
   * 스페셜 저지: 이 문제는 채점 서버 측의 채점 프로그램이 직접 소스코드를 컴파일하여 제출 답안을 평가하므로, 채점 서버의 정해 프로그램의 출력이 같을 필요는 없다.
   * 아래는 $A=27$, $B=3$, $w=12$, $h=10$ 일 때, $A$, $B$, $A+B$를 공백으로 구분한 `27 3 30`를 출력하는 $12 \times 9 = 108$ 칸 크기의 Befunge 프로그램 코드이다. 하지만 전체 $108$개 칸 중 $42$개 칸만 커서가 거쳐가므로 채점 프로그램은 오답으로 처리할 것이다.  
   * 
   * 입력으로 a, b, w, h가 공백으로 구분되어 주어진다.
   */

  /**
   * 전략:
   * 1. A, B, A + B를 각각 Befunge 코드로 표현한다.
   * 2. A, B에 대한 최대공약수 G를 구하고, A/G, B/G, G에 대해 Befunge 코드를 생성한다.
   * 3. 1.과 2.의 Befunge 코드 길이를 비교하여 더 작은 쪽을 선택한다.
   * 4. 남은 칸은 > < ^ v를 이용해 커서가 지나가도록 한다.
   */

  int A, B, w, h;
  if (!(cin >> A >> B >> w >> h))
    return 0;

  const vector<int> direct_values = {A, B, A + B};
  string direct = make_strategy_program(direct_values);

  int g = gcd(abs(A), abs(B));
  string normalized;
  if (g > 0)
  {
    vector<int> normalized_values = {A / g, B / g, g};
    normalized = make_strategy_program(normalized_values);
  }

  string best;
  if (!direct.empty() && !normalized.empty())
    best = (normalized.size() < direct.size()) ? normalized : direct;
  else
    best = direct.empty() ? normalized : direct;

  if (best.empty())
  {
    cout << "IMPOSSIBLE\n";
    return 0;
  }

  if (w <= 0 || h <= 0)
  {
    cout << "IMPOSSIBLE\n";
    return 0;
  }

  const long long capacity = 1LL * w * h;
  if (static_cast<long long>(best.size()) > capacity)
  {
    cout << "IMPOSSIBLE\n";
    return 0;
  }

  vector<string> grid;
  if (!build_grid(best, w, h, grid))
  {
    cout << "IMPOSSIBLE\n";
    return 0;
  }

  for (const string &row : grid)
    cout << row << '\n';
  return 0;
}
