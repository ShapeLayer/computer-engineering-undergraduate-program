#include <iostream>
#define SWAP(a, b) { auto temp = a; a = b; b = temp; }
using namespace std;

int main() {
  int N;
  cin >> N;
  int arr[N];
  for (int i = 0; i < N; i++) {
    cin >> arr[i];
  }

  int Q, a, b;
  for (cin >> Q; Q--;) {
    cin >> a >> b;
    SWAP(arr[a - 1], arr[b - 1]);
  }

  for (int i = 0; i < N; i++) {
    cout << arr[i] << (i == N - 1 ? '\n' : ' ');
  }
  return 0;
}
