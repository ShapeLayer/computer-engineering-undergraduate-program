#include <iostream>
#include <string>
#include <cctype>
using namespace std;

#define VERIFIED 
#define DEBUG
/**
 * alphanumeric operation string
 * 주어진 문자열에 근거해 정수값을 노드로 보유하는 단방향 리스트 구성 조작
 * 리스트 구분자는 -> (->로 끝나서는 안됨)
 * 
 * 명령
 * - 숫자: 리스트에 추가
 * - a : 이후의 수문자는 오름차순 정렬로 처리
 * - d : 이후의 수문자는 내림차순 정렬로 처리
 * - f : 이후의 수문자 그룹들이 삭제 대상
 * 
 * 룰
 * - 명령 없는 숫자 그대로 추가
 * - a 모드에서 범위는 입력이 종료되거나 다음 a/d가 나타날 때까지 하나의 명렬
 *   - f가 중간에 등장 시
 *      - f 앞 우선 처리
 *      - f 뒤에서 삭제 작업 수행
 *        - f 영향 받는 값들을 대상으로 소수 존재 시 소수 삭제
 *        - 삭제 후 a 명령의 대상 전체를 정렬
 * - d 모드에서는 하나의 범위도 취합니다.
 *   - f가 없으면 전체 내림차순 정렬
 *   - f가 중간에 등장 시
 *      - f 앞뒤로 잘라서 각각 소트 후 연결
 * 입력 끝에 모드 범위가 남아 있으면 위의 규칙으로 처리되어 출력 목록에 추가됩니다.
 */

class Node {
public:
    int value;
    Node* next;
};


void printList(Node* head);

// 1桁素数判定
bool isPrime(int n) {
    return n == 2 || n == 3 || n == 5 || n == 7;
}

// ノード追加（head/tail を更新）
void append(Node*& head, Node*& tail, int v) {
    Node* n = new Node;
    n->value = v;
    n->next = NULL;
    if (head == NULL) {
        head = n;
        tail = n;
    }
    else {
        tail->next = n;
        tail = n;
    }
}

// head2/tail2 を head1/tail1 の後ろに接続（head1 が NULL の場合は head2 を代入）
void connect(Node*& head1, Node*& tail1, Node*& head2, Node*& tail2) {
#define SWAP(a, b) { \
    auto __tmp = a; \
    a = b; \
    b = __tmp; \
}
    if (head1 == NULL) {
        SWAP(head1, head2);
        SWAP(tail1, tail2);
    }

#ifdef DEBUG
    if (head1) {
        cout << "h1: ";
        printList(head1);
    }
    if (tail1) {
        cout << "t1: " << tail1->value << endl;
    }
    if (head2) {
        cout << "h2: ";
        printList(head2);
    }
    if (tail1) {
        cout << "t2: " << tail2->value << endl;
    }
#endif

    auto curr = head1;
    while(curr && curr->next) {
        curr = curr->next;
    }
    curr->next = head2;
    if (head2) {
        while(curr && curr->next) {
            curr = curr->next;
            }
        tail1 = curr;
        tail2 = curr;
    }
}

#include "bits/stdc++.h"
#define SERIALIZE(v, node) { \
    auto curr = node; \
    while (curr != NULL) { \
        v.push_back(curr->value); \
        curr = curr->next; \
    } \
}

// 昇順ソート
VERIFIED void sortAsc(Node* head) {
    /* 回答箇所その2 */
    vector<int> v;
    SERIALIZE(v, head);
    // cout << "trying sort" << endl;
    sort(v.begin(), v.end());

    auto curr = head;
    for (int i = 0; i < v.size(); i++) {
        curr->value = v.at(i);
        curr = curr->next;
    }
}

// 降順ソート
VERIFIED void sortDesc(Node* head) {
    /* 回答箇所その3 */
    vector<int> v;
    SERIALIZE(v, head);
    sort(v.begin(), v.end());

    auto curr = head;
    for (int i = v.size() - 1; i > -1; i--) {
        curr->value = v.at(i);
        curr = curr->next;
    }
}

// 素数を削除し、head/tail を正しく更新する（head/tail は参照で渡す）
void removePrimes(Node*& head, Node*& tail) {
    /* 回答箇所その4 */
    vector<int> v;
    SERIALIZE(v, head);
    Node *prev = NULL;
    for (int i = 0; i < v.size(); i++) {
        auto curr = v.at(i);
        if (isPrime(curr)) continue;
        Node *_new = new Node;
        _new->value = curr;
        if (prev == NULL) {
            head = _new;
        } else {
            prev->next = _new;
        }
        prev = _new;
    }
    tail = prev;
}

// リスト出力（"->" 区切り、末尾に "->" を付けない）
void printList(Node* head) {
    Node* cur = head;
    while (cur != NULL) {
        cout << cur->value;
        if (cur->next != NULL) cout << "->";
        cur = cur->next;
    }
    cout << endl;
}

// メモリ解放
void freeList(Node*& head) {
    Node* cur = head;
    while (cur != NULL) {
        Node* nxt = cur->next;
        delete cur;
        cur = nxt;
    }
    head = NULL;
}

int main() {
    string input;
    cin >> input;

    Node* finalHead = NULL;
    Node* finalTail = NULL;

    char mode = 'n'; // n: none, a: asc, d: desc
    bool inF = false;

    // 現在の a/d 範囲の非fリストと fリスト（それぞれ head/tail ペアで管理）
    Node* rangeNonFHead = NULL;
    Node* rangeNonFTail = NULL;
    Node* rangeFHead = NULL;
    Node* rangeFTail = NULL;

    int i = 0;
    while (i < (int)input.size()) {
        char c = input[i];
        if (isdigit(c)) {
            int num = c - '0';
            if (mode == 'n') {
                // コマンド前の数字はそのまま出力リストへ
                append(finalHead, finalTail, num);
            }
            else {
                if (inF) append(rangeFHead, rangeFTail, num);
                else append(rangeNonFHead, rangeNonFTail, num);
            }
            i++;
        }
        else if (c == 'a' || c == 'd') {
            // 直前のモード範囲を確定して final に追加
            if (mode == 'a') {
                // f 範囲があれば素数を削除
                if (rangeFHead != NULL) {
                    removePrimes(rangeFHead, rangeFTail);
                }
                // 非f と f を連結（f 内の素数は削除済み）
                connect(rangeNonFHead, rangeNonFTail, rangeFHead, rangeFTail);
                // 昇順ソート（範囲全体）
                sortAsc(rangeNonFHead);
                // final に接続
                connect(finalHead, finalTail, rangeNonFHead, rangeNonFTail);
            }
            else if (mode == 'd') {
                if (rangeFHead == NULL) {
                    // f がなければ範囲全体を降順
                    sortDesc(rangeNonFHead);
                    connect(finalHead, finalTail, rangeNonFHead, rangeNonFTail);
                }
                else {
                    // 特例：非f と f をそれぞれ降順にして、非f->f の順で結合
                    sortDesc(rangeNonFHead);
                    sortDesc(rangeFHead); // f 範囲は素数除去しない
                    connect(rangeNonFHead, rangeNonFTail, rangeFHead, rangeFTail);
                    connect(finalHead, finalTail, rangeNonFHead, rangeNonFTail);
                }
            }
            // 新しいモードへ切替
            mode = c;
            inF = false;
            // 範囲バッファをクリア（注意：既に接続した場合はポインタが移動済みなので安全）
            rangeNonFHead = NULL;
            rangeNonFTail = NULL;
            rangeFHead = NULL;
            rangeFTail = NULL;
            i++;
        }
        else if (c == 'f') {
            inF = true;
            i++;
        }
        else {
            // 仕様外文字はスキップ
            i++;
        }
    }

    // 入力末尾：最後のモード範囲を確定して final に追加
    if (mode == 'a') {
        if (rangeFHead != NULL) {
            removePrimes(rangeFHead, rangeFTail);
        }
        connect(rangeNonFHead, rangeNonFTail, rangeFHead, rangeFTail);
        sortAsc(rangeNonFHead);
        connect(finalHead, finalTail, rangeNonFHead, rangeNonFTail);
    }
    else if (mode == 'd') {
        if (rangeFHead == NULL) {
            sortDesc(rangeNonFHead);
            connect(finalHead, finalTail, rangeNonFHead, rangeNonFTail);
        }
        else {
            sortDesc(rangeNonFHead);
            sortDesc(rangeFHead);
            connect(rangeNonFHead, rangeNonFTail, rangeFHead, rangeFTail);
            connect(finalHead, finalTail, rangeNonFHead, rangeNonFTail);
        }
    }

    // 出力
    printList(finalHead);

    // メモリ開放
    freeList(finalHead);

    return 0;
}
