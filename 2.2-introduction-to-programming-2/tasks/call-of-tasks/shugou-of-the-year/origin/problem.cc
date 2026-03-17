#include <iostream>
using namespace std;

class Drink {
private:
  int volume;
  int alcoholPercentile;
public:
  Drink(int v, int a) : volume(v), alcoholPercentile(a) {}
  int getVolume();
  int getAlcoholPercentile();
};

int main() {
  string data;

  cout << data << endl;

  return 0;
}
