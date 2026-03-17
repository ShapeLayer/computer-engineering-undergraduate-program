#include <iostream>
#include <string>
#include <stdio.h>
#include <ctype.h>
using namespace std;

/**
 * problem.md 2025-11-22
1 / 1
問4（⽂字列プロセッサー）
⼊⼒された1⾏の⽂字列に対し，
한줄의 스트링 입력
下記の処理を施す⽂字列プロセッサーを作成せよ．
아래와 같은 문자열 처리기
・⼩⽂字 → ⼤⽂字に変換
소문자 -> 대문자
・⼤⽂字 → ⼩⽂字に変換
대문자 -> 소문자
・数字は数値として加算し，変換後の⽂字列から数字を除去する（数字は出⼒⽂字列に残さない）．
숫자는 수치로 추가되어 변환된 문자열에서는 수문자는 소거? 출력에는 숫자 없음
・最後に，これらの数字の総和を16進数で出⼒する
최후 숫자들의 합을 16진수로

⼊⼒される値
1⾏の⽂字列
期待される出⼒値
処理後の1⾏の⽂字列
求めた数字の総和(16進数)
サンプルケース
⼊⼒ 出⼒
hello34WOr5ld
HELLOwoRLD
27
aaa111bbb222ccc333ddd444eee555
AAABBBCCCDDDEEE
681
Ab9_cd88Ef!
aB_CDeF!
61[

 */
// 16進文字列（大文字）に変換する関数
void toHex(unsigned int num, char* hexStr) {
    char buf[32];
    int idx = 0;

    /*** 回答記入箇所その1 ***/

    // num が 0 のときは "0" を返す
    // 0 이면 0
    if (num == 0) {
        buf[idx++] = '0';
    }
    else {
        // num が 0 になるまで 16 で割って余りを文字に変換していく
        // 0이 아니라면 16으로 나눠서 변환
        while (num) {
            int rem = num % 16;
            if (rem < 10) {
                buf[idx++] = (char)(rem + '0');
            } else {
                buf[idx++] = (char)(rem - 10 + 'a');
            }
            num /= 16;
        }
        // reverse buf[0..idx-1]
        for (int i = 0; i < idx / 2; i++) {
            char temp = buf[i];
            buf[i] = buf[idx - 1 - i];
            buf[idx - 1 - i] = temp;
        }
    }
    // 逆順を hexStr にコピーする
    for (int i = 0; i < idx; i++) {
        hexStr[i] = buf[i];
    }


    // 終端文字
    hexStr[idx] = '\0';
}

int main() {
    string input;
    cin >> input;

    char out[1024];     // 変換後の文字列（数字は入れない）
    int outPos = 0;     // out[] の書き込み位置

    int sum = 0;        // 数字の合計値
                        // 합계
    int num = 0;        // 連続数字をまとめるための変数
                        // 연속수문자를 위한 변수
    bool inNumber = false;

    
    /*** 回答記入箇所その2 ***/
    for (char each : input) {
        if ('0' <= each && each <= '9') {
            inNumber = true;
            num *= 10;
            num += (int)(each - '0');
        } else {
            if (inNumber) {
                sum += num;
                num = 0;
                inNumber = false;
            }
            if ('A' <= each && each <= 'Z') {
                out[outPos++] = (char)(each - 'A' + 'a');
            } else if ('a' <= each && each <= 'z') { // small
                out[outPos++] = (char)(each - 'a' + 'A');
            } else {
                out[outPos++] = each;
            }
        }
    }
    if (inNumber) {
        sum += num;
        inNumber = false;
    }

    // 文字列の終端
    out[outPos] = '\0';

    // 数値を16進へ変換
    char hexStr[32];
    toHex(sum, hexStr);

    // 出力
    printf("%s\n", out);
    printf("%s\n", hexStr);

    return 0;
}
