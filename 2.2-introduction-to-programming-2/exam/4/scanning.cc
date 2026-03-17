#include <iostream>
#include <string>
#include <cctype>
using namespace std;

/**
 * problem.md 2025-12-06
1 / 3
問題4 ⽂字列スキャニング
1 ⾏の⽂字列 s が⼊⼒される．
1행문자열이 입력된다
この⽂字列に含まれる 単語数 と，最も⻑い単語（最⻑単語そのもの） を求めるプログラムを作成せよ．
이 문자열의 단어 수와 가장 긴 단어(가장 긴 단어 자체)를 찾는 프로그램
ここで，単語とは 空⽩⽂字で区切られた「⾮空の連続部分列」と定義する．
여기서 단어는 공백으로 정의된 "비어 있지 않은 연속 부분 열"로 정의
空⽩⽂字にはスペース ' ' のほか，タブ，改⾏などを含むものとする．
공백 문자에는 공백 '', 탭, 줄 탭 등이 포함된다.

⼊⼒
⼊⼒は次の形式で標準⼊⼒から与えられる．
1 ⾏の⽂字列 s
⽂字列 s には，英字・数字・記号・スペースなどが含まれてよい．
문자열 s는 문자, 숫자, 기호, 공백 등을 포함
⾏末の改⾏⽂字は⼊⼒の終わりを表すものとし，単語の区切りとしても扱ってよい．
줄 끝의 줄 바꿈은 입력의 끝을 나타내야 하며, 단어 구분으로도 간주될 수 있음

出⼒
次の 2 ⾏をこの順番で出⼒せよ．
1 ⾏⽬:
Words: 単語数 단어수
2 ⾏⽬:
Longest word: 最⻑単語 최장단어

「単語数」は整数で表す． 단어수는 정수
「最⻑単語」は，⽂字数が最⼤の単語そのものをそのまま出⼒する． 문자열

最⻑の単語が複数ある場合は，最初に現れた単語 を出⼒する
답이 두개라면 먼저 나온걸 선택
⽂字列 s に単語が 1 つも含まれない場合（空⽩⽂字のみの場合など）は，
문자열에 단어가 하나도 없다면 아래와 같이
Words: 0
Longest word: （後ろには何も出⼒しない）
を出⼒するものとする．
単語の定義について
단어정의
problem.md 2025-12-06
2 / 3
単語は，空⽩⽂字以外の⽂字が 1 ⽂字以上連続した部分列である．
단어는 빈칸 문자가 아닌 최소 하나의 연속된 글자를 가진 서브열
単語同⼠の間には 1 個以上の空⽩⽂字が⼊ることがある．
단어 사이에는 하나 이상의 공백문자가 들어있을 수 있음
空⽩⽂字としては，スペース ' ' のほか，タブ，復帰，改⾏など， ⼀般的な空⽩⽂字とみなされる⽂
공백문자에는 스페이스, 탭, ??, 개행 일반적인 공백문자로 간주됨 => 화이트스페이스 이야기인듯
字を含むものとする（isspace 関数で判定できる⽂字群）．
문자에는 isspaceㄱ함수로 결정할 수 있는 문자그룹이 있음

サンプル
サンプル 1
⼊⼒
cat dog bird fish
出⼒
Words: 4
Longest word: bird
（説明）
単語は cat, dog, bird, fish の 4 個であり，最⻑は bird と fish（4 ⽂字）だが， 先に現れた bird を出⼒
する．
サンプル 2
⼊⼒
AI-2025 is the best-of-the-best system!!
出⼒
Words: 5
Longest word: best-of-the-best
（説明）
空⽩で区切ると
AI-2025
is
the
best-of-the-best
system!!
problem.md 2025-12-06
3 / 3
の 5 単語となる．
もっとも⻑い単語は best-of-the-best である．
サンプル 3
⼊⼒
The quick brown fox jumps over the lazy dog multiple times and still manages to
surprise everyone with incredible agility
出⼒
Words: 20
Longest word: incredible
（説明）
20 個の単語からなる⽂であり，最⻑の単語は incredible である．

実装上の注意
⼊⼒の取得には getline(cin, s); を⽤いるとよい．
空⽩⽂字の判定には isspace 関数を⽤いることができる（<cctype> をインクルードすること）．
出⼒形式（スペースや改⾏の位置）は，上記の例と厳密に⼀致させること．
구현 노트
입력을 얻으려면 getline(cin, s)을 사용
isspace 함수는 공백 문자(포함)를 결정하는 데 사용<cctype>
출력 형식(공백과 개행)은 위 예시와 엄격히 일치

 */

void analyze(const string& s, int& wordCount, string& longestWord) {
    wordCount = 0;
    longestWord = "";
    bool inWord = false;
    string currentWord = "";

    /* ここに回答を記入 */
    for (char _c : s) {
        if (!isspace(_c)) {
            currentWord += _c;
            inWord = true;
            continue;
        }
        if (longestWord.size() < currentWord.size()) longestWord = currentWord;
        if (inWord) wordCount++;
        inWord = false;
        currentWord.clear();
    }
    if (longestWord.size() < currentWord.size()) longestWord = currentWord;
    if (inWord) wordCount++;
    return;

    // 文字列が非空白で終わった場合の処理
    if (inWord) {
        if ((int)currentWord.size() > (int)longestWord.size()) {
            longestWord = currentWord;
        }
    }
}

int main() {
    string s;
    getline(cin, s);

    int wordCount;
    string longestWord;
    analyze(s, wordCount, longestWord);

    cout << "Words: " << wordCount << endl;
    cout << "Longest word: " << longestWord << endl;

    return 0;
}
