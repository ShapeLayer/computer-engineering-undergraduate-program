#include "bits/stdc++.h"

class Book {
private:
  int number;
  string title;
  string author;
public:
  int get_number() { return number; }
  void set_number(int value) { number = value; }

  string get_title() { return title; }
  void set_title(string value) { title = value; }

  string get_author() { return author; }
  void set_author(string value) { author = value; }

  bool operator==(const Book &other) const {
    return this->number == other.number;
  }

  virtual int getLateFees(int delayed) = 0;
  virtual ~Book() {};
};

class Novel: public Book {
public:
  int getLateFees(int delayed) { return 300 * delayed; }
};
class Poet: public Book {
public:
  int getLateFees(int delayed) { return 200 * delayed; }
};
class ScienceFiction: public Book {
public:
  int getLateFees(int delayed) { return 600 * delayed; }
};

int main() {
  Novel novel;
  novel.set_number(1);
  novel.set_title("Omniscient Reader");
  novel.set_author("singNsong");

  Poet poet;
  poet.set_number(1);
  poet.set_title("Prelude");
  poet.set_author("Yun Dong-ju");

  ScienceFiction science_fiction;
  science_fiction.set_number(2);
  science_fiction.set_title("Martian");
  science_fiction.set_author("Andy Weir");

  cout << "novel == poet? " << (novel == poet ? "true" : "false") << endl
       << "novel == science_fiction? " << (novel == science_fiction ? "true" : "false") << endl;
  cout << endl;
  cout << "delay fees" << endl
       << "novel, 3 days: " << novel.getLateFees(3) << endl
       << "poet, 2 days: " << novel.getLateFees(2) << endl
       << "science_fiction, 5 days: " << novel.getLateFees(5) << endl;

}
