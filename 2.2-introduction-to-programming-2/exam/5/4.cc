/**
 * problem.md 2026-02-01
1 / 4
問題4: 献⽴メモ

あなたは，給⾷の献⽴メモを管理している。
점심 메모 관리
⽇付を表す 4 桁の⽂字列 MMDD（例︓0131）をキー，メニュー名（空⽩を含まない⽂字列）を値として保存
する。
날짜를 Mmdd 키, 메뉴 이름이 값
最初に Q 件の登録が与えられる。各登録は「⽇付 date」と「メニュー menu」からなる。
최초에 Q가 등록되어있음 이름등록은 날짜와 메뉴
同じ⽇付が複数回与えられた場合は，最後に与えられたメニューで上書きする。
같은 날짜가 두 번 표시되면 최후의 메뉴로 덮어쓰기?
Q 件の登録の⼊⼒が終わったら，プログラムは 1 ⾏だけ
Q건의 등록의 입력이 주어짐 프로그램은 1행만 출력
aとbを入⼒
と出⼒する。

その後に⼊⼒される 2 つの⽇付 a, b（ともに MMDD 形式）に対して，
그후 입력받는 a,b에 대해
a 以上 b 以下（⽂字列の辞書順⽐較）の⽇付を持つ要素を，⽇付の昇順で
date menu
の形式で 1 ⾏ずつ出⼒せよ。
該当する要素が 1 件もない場合は，「aとbを⼊⼒」の次の⾏に
EMPTY
を 1 ⾏だけ出⼒する。
⼊⼒
Q
date menu
date menu
...
（Q ⾏）
a b
1 <= Q <= 200000
date, a, b は MMDD 形式（⻑さ 4 の数字列）
menu は空⽩を含まない⽂字列（英⼩⽂字など）
problem.md 2026-02-01
2 / 4
※この問題では MMDD を ⽂字列の辞書順で⽐較する（4 桁固定のため，通常の⽂字列⽐較でよい）。
出⼒
まず 1 ⾏⽬に
aとbを入⼒
を出⼒する。
次に，⼊⼒された a, b に対して a <= date <= b の範囲にある登録済みの (date, menu) を，
date の昇順で
date menu
の形式で 1 ⾏ずつ出⼒する。
該当する要素が 0 件なら EMPTY を 1 ⾏だけ出⼒する。
サンプル
⼊⼒例 1
5
0130 curry
0131 sushi
0201 ramen
0131 udon
0210 pizza
0131 0201
出⼒例 1
aとbを入⼒
0131 udon
0201 ramen
⼊⼒例 2
3
0130 curry
0201 ramen
0210 pizza
0101 0120
出
⼒
例
2
a
と
b
を入⼒
EMPTY
⼊
⼒
例
3
18
1231 soba
0707 tanabata
0808 okonomiyaki
0707 somen
0701 curry
0715 yakiniku
0101 osechi
0101 ozoni
0601 salad
0602 ramen
0602 tsukemen
1111 pizza
0909 sushi
1001 udon
0707 kakigori
0708 tempura
0706 unagi
0706 yakitori
0707 0708
出
⼒
例
3
a
と
b
を入⼒
0707 kakigori
0708 tempura
⼊
⼒
例
4
6
0101 osechi
0102 ozoni
0103 curry
0104 ramen
0105 sushi
0106 udon
0103 0103
出⼒例 4
aとbを入⼒
0103 curry
 */


#include <iostream>
#include <map>
#include <string>

using namespace std;

int main() {
    int q;
    cin >> q;

    map<string, string> menuByDate;

    int i;
    for (i = 0; i < q; i = i + 1) {
        string date;
        string menu;

        cin >> date >> menu;
        menuByDate[date] = menu;
    }

    cout << "aとbを入力" << endl;

    string a;
    string b;
    cin >> a >> b;

    int printedCount = 0;
    map<string, string>::iterator it;

    /*** 変更可能箇所ここから ***/

    int starts_at_month = (a[0] - '0') * 10 + (a[1] - '0');
    int starts_at_date = (a[2] - '0') * 10 + (a[3] - '0');
    int ends_at_month = (b[0] - '0') * 10 + (b[1] - '0');
    int ends_at_date = (b[2] - '0') * 10 + (b[3] - '0');
    if (ends_at_month < starts_at_month) ends_at_month += 12;

    // cout << starts_at_month << " " << starts_at_date << " " << ends_at_month  << " " << ends_at_date << endl;
    for (int mm = starts_at_month; mm <= ends_at_month; mm++) {
        for (
            int dd = (mm == starts_at_month ? starts_at_date : 1);
            dd <= (mm == ends_at_month ? ends_at_date : 31);
            dd++
        ) {
            string query;
            query += (char)((mm / 10) + '0');
            query += (char)((mm % 10) + '0');
            query += (char)((dd / 10) + '0');
            query += (char)((dd % 10) + '0');
            // cout << mm << " " << dd << " " << "query " << query << endl;

            it = menuByDate.find(query);
            if (it != menuByDate.end()) {
                cout << query << ' ' << menuByDate[query] << endl;
                printedCount++;
            }
        }
        
    }


    /*** 変更可能箇所ここまで ***/

    if (printedCount == 0) {
        cout << "EMPTY" << endl;
    }

    return 0;
}
