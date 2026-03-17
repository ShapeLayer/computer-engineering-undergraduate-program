#include <iostream>
#include <string>
using namespace std;

//構造体型Petの宣言
struct Pet {
public:
  string speciesName;
  string name;
  double weight;
};

int main() {
  string sN1, sN2;
  string name1, name2;
  double weight1, weight2;
  double ave;

  /* ここを作成 */
  #define INPUT(identifier, species, name, weight) \
    cin >> species >> name >> weight;
  typedef struct Pet pet_t;
  
  INPUT(1, sN1, name1, weight1);
  INPUT(2, sN2, name2, weight2);
  pet_t pet1 = { sN1, name1, weight1 };
  pet_t pet2 = { sN2, name2, weight2 };

  ave = (weight1 + weight2) / 2.;

  cout << pet1.speciesName << "の" << pet1.name << "と" << pet2.speciesName 
    << "の" << pet2.name << "の平均体重は" << ave << "です" << endl;
}
