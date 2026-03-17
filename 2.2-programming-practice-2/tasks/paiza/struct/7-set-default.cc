#include <iostream>
#include <vector>
#define ADULT_AGE 20
#define IS_ADULT(age) (age >= ADULT_AGE)
#define MAX(a, b) ((a) > (b) ? (a) : (b))
using namespace std;

class CustomerAllAge {
public:
  int age;
  int payRequired = 0;

  CustomerAllAge(int age) : age(age) {}
  virtual ~CustomerAllAge() {}
};

class CustomerAdult : public CustomerAllAge {
public:
  bool isDrinkOrdered = false;
  CustomerAdult(int age) : CustomerAllAge(age) {}
};

int main() {
  ios::sync_with_stdio(false);
  cin.tie(nullptr);
  cout.tie(nullptr);

  int N, K;
  cin >> N >> K;

  vector<CustomerAllAge*> customers;
  int age;
  for (int i = 0; i < N; i++) {
    cin >> age;

    if (!IS_ADULT(age)) {
      customers.push_back(new CustomerAllAge(age));
    } else {
      customers.push_back(new CustomerAdult(age));
    }
  }

  int n_i, m_i;
  string s_i;
  while (K--) {
    cin >> n_i >> s_i;
    if (s_i == "0") {
      s_i = "alcohol";
      m_i = 500;
    } else cin >> m_i;
    if (s_i == "alcohol") {
      if (!IS_ADULT(customers[n_i - 1]->age)) { continue; }

      CustomerAdult *ca = dynamic_cast<CustomerAdult *>(customers[n_i - 1]);
      ca->isDrinkOrdered = true;
    }
    CustomerAllAge *ca = customers[n_i - 1];
    int saled = 0;

    if (
      IS_ADULT(ca->age) &&
      dynamic_cast<CustomerAdult *>(ca)->isDrinkOrdered == true &&
      s_i == "food"
    ) {
      saled = 200;
    }

    ca->payRequired += m_i - saled;
  }

  for (int i = 0; i < N; i++) {
    cout << MAX(customers[i]->payRequired, 0) << endl;
  }

  return 0;
}
