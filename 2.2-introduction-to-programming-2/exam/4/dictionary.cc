#include <iostream>
#include <map>
#include <string>
using namespace std;

/**
 * problem.md 2025-12-11
1 / 5
問7（⽂字列辞書のバージョン管理）
あなたは⽂字列辞書のバージョン管理システムの開発を任された．
문자열 사전의 버전 관리 시스템 개발
このシステムでは，「ファイル名」と「そのバージョン番号」を管理し，
이 시스템에서는 "파일 이름"과 "버전 번호"를 관리
次の 4 種類のコマンドを順に処理する．
다음 네 가지 명령

s︓ファイルの登録（set）
r︓ファイルの削除（remove）
q︓接頭辞（prefix）での最⼤バージョン問い合わせ（query）
e︓処理終了（exit）
s: 파일 등록(SET)
r: 파일 삭제
q: 접두사(prefix)로 최대 버전을 조회하세요
e: 처리 종료(종료)

この機能を満たすプログラムを作成せよ．
이 기능을 충족하는 프로그램

各コマンドの仕様각 명령어의 사양

1. コマンド s（登録） 등록
形式︓형식
s <ファイル名> <バージョン>
ファイル名は 英字のみ（A〜Z, a〜z）を使⽤できる．
파일 이름은 영어 문자
それ以外の⽂字（数字，記号など）が 1 ⽂字でも含まれている場合，
숫자, 기호 등 포함 시 오류 메시지 출력
次のエラーメッセージを出⼒し，登録処理を⾏わない︓
다음 메시지 출력하고 스킵

エラー：ファイル名は英字のみ使⽤可能

条件を満たす場合は，内部の map<string,int> に
조건 충족 시 내부 맵 에
key = ファイル名 파일명
value = バージョン番号 として登録する（すでに同名ファイルがある場合は 上書き とする）．
      버전 번호(같은 이름 있다면 덮었긔)

      2. コマンド r（削除） 삭제
形式︓ 형식
r <ファイル名>

指定したファイル名が登録されていない場合は，次のエラーメッセージを出⼒する︓
지정된 파일 이름이 등록되지 않은 경우 오류 메시지
problem.md 2025-12-11
2 / 5
エラー：このファイルは存在しません

登録されている場合は，そのエントリを削除する．
등록되어있으면 삭제

3. コマンド q（検索） 검색
形式︓
q <prefix>
現在 map に登録されているファイル名の中から， prefix で始まるファイル名 をすべて探す．
현재 맵에 등록된 파일 이름 중에서 접두사로 시작하는 모든 파일 이름 검색
その中で，バージョン番号が最⼤の値 を 1 つ求める．
그중 가장 큰 버전인 값을 찾아라
条件を満たすファイルが 1 つも存在しない場合は，次のエラーメッセージを出⼒する︓
기준에 맞는 파일이 없다면 오류 출력

エラー：このファイルは存在しません

条件を満たすファイルが 1 つ以上存在する場合は，次の形式で最⼤バージョンを出⼒する︓
조건에 맞는 파일이 하나 이상 있다면 최대 버전 출력

最⼤バージョン：X

ここで X は最⼤のバージョン番号（整数）である．
X는 가장 큰 버저 ㄴ수
※ ファイル名が prefix で始まるかどうかの判定には，
파일 이름이 접두사로 시작하는지 확인하려면 startWith사용
先頭から 1 ⽂字ずつ⽐較する関数（例︓startsWith）を⽤いてよい．

4. コマンド e（終了） 종료
形式︓
e
次のメッセージを出⼒して，コマンド処理ループを終了する︓
명령 처리 루프 종료

操作終了
ループ終了後，次の⾒出しを出⼒する︓
루프 종료 시 다음 내용 출력:
problem.md 2025-12-11
3 / 5

登録されているファイル⼀覧：

続けて，登録されているファイル名を辞書順（昇順）で 1 ⾏ずつ 出⼒する．
다음으로 등록된 파일명 사전 순서 오름차순으로 한 줄 씩 출력
登録されているファイルが 1 つもない場合は，ファイル名は 1 ⾏も出⼒しない（⾒出し⾏のみ出⼒）．
등록된 파일 없으면 파일 이름 출력 않음 헤더만 남음
map<string,int> をそのまま⾛査すれば，辞書順になる．
맵을 그대로 스캔하면 사전순이 될 것이다
...예?

 */

// prefix 判定（compare 禁止 → 手書きループ）
bool startsWith(const string& s, const string& prefix) {
    if (s.size() < prefix.size()) {
        return false;
    }
    for (size_t i = 0; i < prefix.size(); i++) {
        if (s[i] != prefix[i]) {
            return false;
        }
    }
    return true;
}

// ファイル名が英字のみか判定
bool isAlphabetOnly(const string& s) {
    for (char c : s) {
        if (!((c >= 'A' && c <= 'Z') || (c >= 'a' && c <= 'z'))) {
            return false;
        }
    }
    return true;
}

int main() {
    map<string, int> files;

    while (true) {
        cout << "コマンドを入力(s:登録/r:削除/q:探索/e:終了)" << endl;
        char cmd;
        cin >> cmd;

        if (!cin) {
            break;  // EOF 保険
        }

        if (cmd == 'e') {
            cout << "操作終了" << endl;
            break;
        }

        if (cmd == 's') {
            string name;
            int version;
            cin >> name >> version;

            if (!isAlphabetOnly(name)) {
                cout << "エラー：ファイル名は英字のみ使用可能" << endl;
                continue;
            } else {
                // TODO: files に (name, version) を登録する（既存なら上書き）
                
                files[name] = version;
                
            }
        }
        else if (cmd == 'r') {
            string name;
            cin >> name;

            // TODO: files から name を探し、
            //  - 見つからなければ
            //      エラー：このファイルは存在しません
            //  - 見つかれば
            //      その要素を削除する
            if (files.find(name) == files.end()) {
                cout << "エラー：このファイルは存在しません" << endl;
            } else {
                files.erase(name);
            }
        }
        else if (cmd == 'q') {
            string prefix;
            cin >> prefix;

            int maxVersion = -1;

            // TODO:
            //  files 内の全ての (key, value) について、
            //  key が prefix で始まるものを探し、
            //  その中で最大の value を maxVersion に記録する

            for (map<string, int>::iterator it = files.begin();
                it != files.end(); ++it) {
                auto name = it->first;
                auto version = it->second;
                if (!startsWith(name, prefix)) continue;
                maxVersion = maxVersion < version ? version : maxVersion;
            }

            // TODO:
            //  条件を満たすファイルが 1 つもなければ
            //      
            //  あれば
            //      最大バージョン：<maxVersion>

            if (maxVersion != -1) {
                cout << "最大バージョン：" << maxVersion;
            } else {
                cout << "エラー：このファイルは存在しません";
            }
            cout << endl;
            
        }
        else {
            cout << "コマンドエラー" << endl;
            // 不正コマンド対策（無視して続行）
            string dummy;
            getline(cin, dummy);
        }
    }

    // e が入力された後：登録されているファイル名を一覧表示
    cout << "登録されているファイル一覧：" << endl;

    // TODO:
    // files の中身を辞書順（map の順）で 1 行ずつ出力する
    // 例:
    for (map<string, int>::iterator it = files.begin();
         it != files.end(); ++it) {
        cout << it->first << endl;
    }

    return 0;
}
