#include <iostream>
#include <string>

using namespace std;

class Text {
public:
  string content;

  Text(string content) {
    this->content = content;
  }

  void replace(string find, string replaceTo) {
    this->content.replace(this->content.find(find), find.length(), replaceTo);
  }
};

int main() {
  char content[100];
  char find[10], replaceTo[10];
  gets(content);
  gets(find);
  gets(replaceTo);

  string content_s(content);
  string find_s(find);
  string replaceTo_s(replaceTo);
  Text text = Text(content_s);
  text.replace(find_s, replaceTo_s);

  cout << text.content << endl;

  return 0;
}
