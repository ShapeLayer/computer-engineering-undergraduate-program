#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>

#define STACKMAX 10 // スタック領域の大きさ
#define BUFFMAX 100 // バッファ長

class Stack
{                         // 数値を保持するスタックのクラス
  double stack[STACKMAX]; // スタック領域
  int stackTop;           // スタックのトップ位置
public:
  Stack();                // コンストラクタ
  void push(double data); // スタックにプッシュする
  double pop();           // スタックからポップする
  void show();            // スタックを表示する
};

class Token
{               // 取得したトークンのクラス
  char command; // コマンド・演算子文字，数値の時は'v'が入る
  double value; // 数値
public:
  char readNext();                    // 次のトークンを読む
  double getValue() { return value; } // 保持する数値を返す
};

Stack stack; // スタック

/* メイン関数 */
int main()
{
  Token token;   // トークン
  char command;  // コマンド文字
  double value1; // 計算用
  double value2; // 計算用

  command = token.readNext(); // トークンを読む
  while (command != 'q')
  { // コマンド文字が'q'でない限り以下を実行する
    switch (command)
    { // コマンド文字で処理を分岐する

    case 'v': // 数値であれば，スタックへプッシュする
      stack.push(token.getValue());
      break;

    case '+': // '+'であれば，ポップした2つの数値で加算し結果をプッシュする
      value2 = stack.pop();
      value1 = stack.pop();
      stack.push(value1 + value2);
      break;

    case '-': // '-'であれば，ポップした2つの数値で減算し結果をプッシュする
      value2 = stack.pop();
      value1 = stack.pop();
      stack.push(value1 - value2);
      break;

    case '*': // '*'であれば，ポップした2つの数値で乗算し結果をプッシュする
      value2 = stack.pop();
      value1 = stack.pop();
      stack.push(value1 * value2);
      break;

    case '/': // '/'であれば，ポップした2つの数値で除算し結果をプッシュする
      value2 = stack.pop();

      /**
       * 「スタックから2つの数値をポップし，除算してプッシュ．ゼロでの割り算は警告」
       * => 警告以外の処理は定義されない: 状態復元による具現
       */
      if (value2 == 0)
      {
        printf("warning: divide by zero. command ignored.\n");
        stack.push(value2);
        break;
      }
      value1 = stack.pop();
      stack.push(value1 / value2);
      break;
    }
    stack.show(); // スタックを表示して，次のトークンを読む
    command = token.readNext();
  }
}

/* 次のトークンを読む */
char Token::readNext()
{
  char buff[BUFFMAX]; // 取得用バッファ

  // トークン文字列を取得する（%sは空白文字（改行/空白/Tab等）が出現までを取得する）
  scanf("%s", buff, BUFFMAX - 1);

  // トークン先頭文字が数字なら文字列を数値に変換し，コマンド文字を'v'にする
  if (isdigit(buff[0]))
  {
    value = atof(buff);
    command = 'v';
  }
  else if (buff[0] == 'q')
  {
    command = 'q';
  }
  else
    command = buff[0]; // そうでなければ最初の文字をコマンド文字として取得する

  // コマンド文字を返す
  return command;
}

/* スタックのコンストラクタ */
Stack::Stack()
{
  // スタックトップを底に，print format文字列を実数型の標準に設定する
  stackTop = 0;
}

/* スタックへプッシュする */
void Stack::push(double data)
{
  // スタック領域に余裕があれば，トップの位置にデータを入れてトップ位置をずらす
  if (stackTop < STACKMAX)
  {
    stack[stackTop] = data;
    stackTop++;
  }
  else
  {
    printf("スタックプッシュに失敗\n");
  }
}

/* スタックがらポップする */
double Stack::pop()
{
  // スタックが空で無いなら，トップ位置をずらしてデータを取り出して戻す
  if (stackTop > 0)
  {
    stackTop--;
    return stack[stackTop];
  }
  else
  {
    printf("スタックポップに失敗\n");
    return 0;
  }
}

/* スタックを表示する */
void Stack::show()
{
  // スタックの内容を並べて表示する
  printf("\n----------\n");
  for (int i = 0; i < stackTop; i++)
  {
    printf("%f", stack[i]);
    printf("\n");
  }
  printf("----------\n");
}
