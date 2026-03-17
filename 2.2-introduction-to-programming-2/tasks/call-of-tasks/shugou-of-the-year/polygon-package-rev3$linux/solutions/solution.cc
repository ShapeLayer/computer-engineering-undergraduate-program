#include <iostream>
#include <vector>
#include <map>
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

int Drink::getVolume() {
  return volume;
}
int Drink::getAlcoholPercentile() {
  return alcoholPercentile;
}

int main() {
  string data;

  int N;
  vector<pair<string, Drink *>> drink_log;
  string faculties[] = {
    "education",
    "science_and_engineering",
    "economics",
    "agriculture",
    "art_and_regional_design"
  };

  cin >> N;
  for (int i = 0; i < N; i++) {
    string name;
    int volume, alcoholPercentile;
    cin >> name >> volume >> alcoholPercentile;
    drink_log.push_back(make_pair(name, new Drink(volume, alcoholPercentile)));
  }

  map<string, int> total_alcohol_10x;
  for (auto each : faculties) {
    total_alcohol_10x[each] = 0;
  }
  int max_alcohol_10x = 0;

  for (auto each : drink_log) {
    string name = each.first;
    Drink *drink = each.second;

    if (total_alcohol_10x.find(name) == total_alcohol_10x.end()) {
      total_alcohol_10x[name] = 0;
    }

    total_alcohol_10x[name] += (drink->getVolume() * 100) * (.01f * drink->getAlcoholPercentile());
    if (total_alcohol_10x[name] > max_alcohol_10x) {
      max_alcohol_10x = total_alcohol_10x[name];
    }
  }

  for (auto each : faculties) {
    if (total_alcohol_10x[each] == max_alcohol_10x) {
      data = each;
      break;
    }
  }

  cout << data << endl;

  return 0;
}
