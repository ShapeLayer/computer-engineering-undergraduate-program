#include <iostream>

using namespace std;

struct Calculator {
public:
  float getAverage(int a, int b) {
    /**
     * Calculate average of numbers.
     *
     *
     * @param a, b Two integers to be averaged.
     * @return average of `values`.
     */
    return ((float)(a + b)) / 2;
  }

  float getAverage(int a, int b, int c) {
    /**
     * Calculate average of numbers.
     *
     *
     * @param a, b, c Three integers to be averaged.
     * @return average of `values`.
     */
    return ((float)(a + b + c)) / 3;
  }
};

int main() {
  /**
   * Input expected: 3 Integers seperated by whitespace.
   * example:
   * 7 8 10
   */
  Calculator calc = Calculator();
  int a, b, c;
  
  cin >> a >> b >> c;
  float first = calc.getAverage(a, b);
  float second = calc.getAverage(a, b, c);
  cout << "The result of two overloaded `getAverage()` function" << endl;
  cout << "getAverage(a, b): " << first << endl;
  cout << "getAverage(a, b, c): " << second << endl;

  return 0;
}
