#include "bits/stdc++.h"
// Required C++11: Refer `call_draw_all_characters` function

class GameCharacter {
public:
  virtual void draw() = 0;
  static vector<GameCharacter*> characters;

  static vector<GameCharacter*> *getCharacters() {
    return &characters;
  }
};

vector<GameCharacter*> GameCharacter::characters;

class Player: public GameCharacter {
  void draw() {
    cout << "플레이어를 그립니다." << endl;
  }
};

class Zombie: public GameCharacter {
  void draw() {
    cout << "좀비를 그립니다." << endl;
  }
};

class Minion: public GameCharacter {
  void draw() {
    cout << "미니언을 그립니다." << endl;
  }
};

class Hobit: public GameCharacter {
  void draw() {
    cout << "호빗을 그립니다." << endl;
  }
};

void init_register_all_characters() {
  vector<GameCharacter*> *characters = GameCharacter::getCharacters();

  characters->push_back(new Hobit());
  characters->push_back(new Player());
  characters->push_back(new Zombie());
  characters->push_back(new Minion());
}

void call_draw_all_characters() {
  vector<GameCharacter*> *characters = GameCharacter::getCharacters();

  for (GameCharacter* character: *characters) {
    character->draw();
  }
}

int main() {
  init_register_all_characters();
  call_draw_all_characters();
  return 0;
}
