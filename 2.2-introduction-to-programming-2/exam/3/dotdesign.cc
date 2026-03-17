#include <iostream>
using namespace std;

#define MAX_H 20
#define MAX_W 20

int canvas[MAX_H][MAX_W];
bool visited[MAX_H][MAX_W];

int heightValue, widthValue;

/**
 * problem.md 2025-11-22
1 / 2
問3（ドットデザインの最⼤領域探索）
ドット絵デザイナーが作成した H×W のキャンバスデータを解析したい．
캔버스 데이터를 분석하고 싶다
キャンバスは整数値の⼆次元配列で表され，
캔버스는 정수 2차원 배열
同じ整数の連続した模様（上下左右のみ連結） を「パターン」と呼ぶ．
같은 정수 -- 상하좌우 연속 패턴을 '패턴'
このとき，最も⼤きいパターンの⾯積（単位︓セル数） を求めよ．
가장 큰 패턴; 셀 단위 면적을 찾아라
ただし，デザイナーは複数の模様をレイヤー状に配置しており，
여러 패턴을 여러 겹으로 배치
0 は背景（空⽩）を表し，パターンとして数えない．
0은 배경(공백), 패턴아님

⼊⼒される値
最初の⾏に配列の⾼さ H と幅 W（1 ≤ H, W ≤ 20）が与えられる
첫줄 배열 높이 H와 너비 W(1 ≤ H, W ≤ 20)

続く H ⾏にわたり，各⾏ W 個の整数（0〜9）が与えられる
다음 H 행마다 W 정수(0부터 9까지)가 주어진다

期待される出⼒値
最も⼤きい領域のセル数（整数） 
가장 큰 영역 내 셀 수 (정수) 

problem.md 2025-11-22
2 / 2
サンプルケース
⼊⼒ 出⼒
6 8
0 0 2 2 0 3 3 3
1 1 2 0 0 3 0 0
1 1 2 4 4 4 4 0
0 0 0 4 0 0 4 0
5 5 5 4 4 4 4 4
5 0 5 5 0 0 0 0
11
5 7
1 0 1 0 1 0 1
1 1 0 0 0 1 1
0 1 0 2 2 2 0
3 3 0 2 0 2 0
3 0 0 2 2 2 0
8
6 8
0 0 4 4 4 0 0 0
0 4 4 0 1 4 4 0
4 4 0 0 0 0 4 0
0 4 4 4 0 4 4 0
0 0 0 0 0 0 0 0
5 5 5 5 5 5 5 5
10
 */
int countArea(int startRow, int startCol) {
    int targetValue = canvas[startRow][startCol];

    // 手動キュー（配列版 BFS）
    int queueRow[MAX_H * MAX_W];
    int queueCol[MAX_H * MAX_W];
    int frontIndex = 0;
    int backIndex = 0;

    queueRow[backIndex] = startRow;
    queueCol[backIndex] = startCol;
    backIndex++;

    visited[startRow][startCol] = true;

    int areaSize = 1;

    while (frontIndex < backIndex) {
        
        /****** ここに回答を記入 ******/
        const int dt[4][2] = {{ -1, 0 }, { 1, 0 }, { 0, -1 }, { 0, 1 }};
        int y = queueRow[frontIndex];
        int x = queueCol[frontIndex];
        
        for (const auto& delta : dt) {
            int ny = y + delta[0];
            int nx = x + delta[1];

            if (!(0 <= ny && ny < MAX_H &&
                  0 <= nx && nx < MAX_W)) {
                continue;
            }
            if (canvas[ny][nx] != targetValue) continue;
            if (visited[ny][nx]) continue;

            areaSize++;
            visited[ny][nx] = true;
            queueRow[backIndex] = ny;
            queueCol[backIndex] = nx;
            backIndex++;
        }
        frontIndex++;
    }

    return areaSize;
}

int main() {
    cin >> heightValue >> widthValue;

    int rowIndex = 0;
    while (rowIndex < heightValue) {
        int colIndex = 0;
        while (colIndex < widthValue) {
            cin >> canvas[rowIndex][colIndex];
            visited[rowIndex][colIndex] = false;
            colIndex++;
        }
        rowIndex++;
    }

    int maxAreaSize = 0;

    rowIndex = 0;
    while (rowIndex < heightValue) {
        int colIndex = 0;
        while (colIndex < widthValue) {
            // 背景(0)は無視
            if (canvas[rowIndex][colIndex] != 0 &&
                visited[rowIndex][colIndex] == false) {
                int areaSize = countArea(rowIndex, colIndex);
                if (areaSize > maxAreaSize) {
                    maxAreaSize = areaSize;
                }
            }
            colIndex++;
        }
        rowIndex++;
    }

    cout << maxAreaSize << endl;

    return 0;
}
