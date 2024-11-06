#include "bits/stdc++.h"

class Matrix {
private:
  int rows, cols;
  int** data;
public:
  Matrix(int rows, int cols) : rows(rows), cols(cols) {
    data = new int*[rows];
    for (int i = 0; i < rows; i++) {
      data[i] = new int[cols];
    }
  }

  int get_each(int i, int j) {
    return data[i][j];
  }
  void set_each(int i, int j, int val) {
    data[i][j] = val;
  }

  Matrix operator+(Matrix &m2) {
    Matrix m(rows, cols);
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < cols; j++) {
        m.set_each(i, j, this->get_each(i, j) + m2.get_each(i, j));
      }
    }
    return m;
  }
  Matrix operator*(Matrix &m2) {
    Matrix m(rows, m2.cols);
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < m2.cols; j++) {
        int sum = 0;
        for (int k = 0; k < cols; k++) {
          sum += this->get_each(i, k) * m2.get_each(k, j);
        }
        m.set_each(i, j, sum);
      }
    }
    return m;
  }
};

int main() {
  Matrix m1(3, 4), m2(3, 4), m3(4, 3);
  
  // m1
  for (int i = 0; i < 3; i++) {
    for (int j = 0; j < 4; j++) {
      m1.set_each(i, j, i + j);
    }
  }

  // m2
  for (int i = 0; i < 3; i++) {
    for (int j = 0; j < 4; j++) {
      m2.set_each(i, j, i + j);
    }
  }

  // m3
  for (int i = 0; i < 4; i++) {
    for (int j = 0; j < 3; j++) {
      m3.set_each(i, j, i + j);
    }
  }

  Matrix m4 = m1 + m2;
  Matrix m5 = m1 * m3;
  
  
  // out
  cout << "m1:" << endl;
  for (int i = 0; i < 3; i++) {
    for (int j = 0; j < 4; j++) {
      cout << m1.get_each(i, j) << " ";
    }
    cout << endl;
  }
  cout << endl;

  cout << "m2:" << endl;
  for (int i = 0; i < 3; i++) {
    for (int j = 0; j < 4; j++) {
      cout << m2.get_each(i, j) << " ";
    }
    cout << endl;
  }
  cout << endl;

  cout << "m3:" << endl;
  for (int i = 0; i < 4; i++) {
    for (int j = 0; j < 3; j++) {
      cout << m3.get_each(i, j) << " ";
    }
    cout << endl;
  }
  cout << endl;

  cout << "m4:" << endl;
  for (int i = 0; i < 3; i++) {
    for (int j = 0; j < 4; j++) {
      cout << m4.get_each(i, j) << " ";
    }
    cout << endl;
  }
  cout << endl;

  cout << "m5:" << endl;
  for (int i = 0; i < 3; i++) {
    for (int j = 0; j < 3; j++) {
      cout << m5.get_each(i, j) << " ";
    }
    cout << endl;
  }
  cout << endl;
}
