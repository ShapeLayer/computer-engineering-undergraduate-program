#include <iostream> 
using namespace std;

//構造体型Examの宣言 
struct Exam {
  string name;
  int japanese;
  int math;
  int english;
  int total;
};

//関数の宣言 
void total(Exam* pE);
void ranking(Exam* pE[3]);

int main(){
  Exam student1 = { "", 0, 0, 0, 0 };
  Exam student2 = { "", 0, 0, 0, 0 };
  Exam student3 = { "", 0, 0, 0, 0 };
  Exam* rank[3] = { &student1,&student2,&student3 };

  cin >> student1.name >> student1.japanese >> student1.math >> student1.english;
  cin >> student2.name >> student2.japanese >> student2.math >> student2.english;
  cin >> student3.name >> student3.japanese >> student3.math >> student3.english;

  total(&student1);
  total(&student2);
  total(&student3);
  ranking(rank);
}

//total関数の定義 
void total(Exam* pE){
  /* ここを作成 */
  pE->total = pE->japanese + pE->math + pE->english;
}

//ranking関数の定義
void ranking(Exam* pE[3]) {
  Exam* tmp;
  
  /* ここを作成 */
  #define SWAP(a, b) { tmp = a, a = b, b = tmp; }
  for (int i = 0; i < 3; i++) {
    for (int j = i; j < 3; j++) {
      if (pE[i]->total < pE[j]->total) {
        SWAP(pE[i], pE[j]);
      }
    }
  }

  for (int i = 0; i < 3; i++) {
    cout << i + 1 << "位" << pE[i]->name << endl;
  }
}
