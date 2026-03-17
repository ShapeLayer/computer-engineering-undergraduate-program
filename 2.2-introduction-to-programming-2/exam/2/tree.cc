/**
 * 문제 3 (배수 약수 트리)
 * 
 * 두 정수 A, B (1~10000)를 입력받아, 이를 바탕으로 특정 규칙에 따라 "이진 트리"를 구축하고 출력하는 프로그램을 작성하시오.
 * 
 * 트리 구축 규칙은 다음과 같다:
 * (1) 깊이 1의 루트 노드 값은 0이다.
 * (2) 깊이 2의 왼쪽 노드에 A, 오른쪽 노드에 B를 배치한다.
 * (3) 이후 각 깊이에 대해, 동일 깊이에 존재하는 노드들을 왼쪽부터 순서대로 짝지어 다음 처리를 수행한다.
 * (3-1) 해당 쌍의 왼쪽 노드 값을 a, 오른쪽 노드 값을 b로 한다.
 * (3-2) a와 b의 최소공배수 (LCM)를 구하여, 왼쪽 노드의 왼쪽 자식에 LCM(a,b), 왼쪽 노드의 오른쪽 자식에 2×LCM(a,b)를 설정한다.
 * (3-3) a와 b의 최대공약수 (GCD)를 구하고, 그 약수들을 큰 순서대로 정렬한 배열을 구한다.
 * (3-4) 가장 큰 약수를 오른쪽 노드의 왼쪽 자식에, 두 번째로 큰 약수를 오른쪽 노드의 오른쪽 자식에 설정한다 (단, 약수가 부족한 경우는 0으로 한다).
 * (4) 이 작업을 깊이 5까지 반복한다.
 * 
 * 최종적으로, 트리의 각 노드 값을 "레벨 순서(깊이 순서)"로 출력하시오. 각 레벨은 한 줄씩 출력하고, 노드 값은 공백으로 구분한다. 단, 답변 부분 외의 코드는 일절 수정하지 않는다.
 */

#include <iostream>
using namespace std;

// ノード構造体
struct Node {
    int value;
    Node* left;
    Node* right;
    Node(int v = 0) {
        value = v;
        left = NULL;
        right = NULL;
    }
};

// 最大公約数
int gcd(int a, int b) {
    /*回答記入箇所その1*/
    if (b == 0) return a;
    return gcd(b, a % b);
}

// 最小公倍数
int lcm(int a, int b) {
    /*回答記入箇所その2*/
    return a / gcd(a, b) * b;
}

// 約数を大きい順に配列に格納する
int divisors_desc(int n, int* out_divs, int max_size) {
    /*回答記入箇所その3*/
    int ptr = 0;
    for (int i = 1; i <= n && ptr < max_size; i++) {
        if (n % i == 0) {
            out_divs[ptr++] = n / i;
        }
    }
    return ptr;
}

// 木の深さを取得
int GetDepth(Node* node) {
    if (node == NULL) {
        return 0;
    }

    int left_depth = GetDepth(node->left);
    int right_depth = GetDepth(node->right);

    if (left_depth > right_depth) {
        return left_depth + 1;
    }
    else {
        return right_depth + 1;
    }
}

// 指定レベルのノードを出力
void PrintLevel(Node* node, int level) {
    if (node == NULL) {
        return;
    }

    if (level == 0) {
        cout << node->value << " ";
    }
    else {
        PrintLevel(node->left, level - 1);
        PrintLevel(node->right, level - 1);
    }
}

// 木全体をレベル順に出力
void PrintTreeLevels(Node* root) {
    int depth = GetDepth(root);
    for (int i = 0; i < depth; i++) {
        PrintLevel(root, i);
        cout << endl;
    }
}

// 指定レベルのノードを配列に収集
void CollectLevelNodes(Node* node, int level, Node** out_nodes, int& index, int max_size) {
    /*回答記入箇所その4*/
    /**
     * node: 호출 진입점 기준으로 루트는 재할당하지 않음
     *       * 변수명이 root가 아님
     * level: 검색 대상 레벨
     * out_nodes: 노드를 수집하여 참조형에 삽입, 호출점으로 리턴 후 참조하여 사용
     * index: 검색 결과 참조 리턴하는 배열 사이즈
     * max_size: **out_nodes의 최대 사이즈
     * 
     * => 재귀로 완전탐색, **out_nodes의 커서는 index로 사용
     */
    if (node == NULL) {
        return;
    }
    if (level == 0) {
        if (index < max_size) {
            out_nodes[index++] = node;
        }
    }
    else {
        CollectLevelNodes(node->left, level - 1, out_nodes, index, max_size);
        CollectLevelNodes(node->right, level - 1, out_nodes, index, max_size);
    }
}

int main() {
    int A, B;
    cout << "2つの整数を入力してください (1～10000): ";
    cin >> A >> B;

    if (A < 1 || B < 1 || A > 10000 || B > 10000) {
        cout << "エラー: 入力は1～10000の範囲で指定してください。" << endl;
        return 1;
    }

    // 深さ1（ルート）
    Node* root = new Node(0);

    // 深さ2（入力値を左右に配置）
    root->left = new Node(A);
    root->right = new Node(B);

    const int TARGET_DEPTH = 5;
    const int MAX_NODES_PER_LEVEL = 256; // 十分なサイズを確保

    // 木の成長
    for (int current_depth = 2; current_depth < TARGET_DEPTH; current_depth++) {
        Node* current_nodes[MAX_NODES_PER_LEVEL];
        int index = 0;

        // 現在のレベルのノードを取得
        CollectLevelNodes(root, current_depth - 1, current_nodes, index, MAX_NODES_PER_LEVEL);

        // ペアごとに処理
        for (int i = 0; i + 1 < index; i += 2) {
            Node* left_node = current_nodes[i];
            Node* right_node = current_nodes[i + 1];

            if (left_node == NULL) {
                left_node = new Node(0);
            }
            if (right_node == NULL) {
                right_node = new Node(0);
            }

            // 最小公倍数の計算
            int current_lcm = lcm(left_node->value, right_node->value);
            int lcm1 = current_lcm;
            int lcm2;
            if (current_lcm == 0) {
                lcm2 = 0;
            }
            else {
                lcm2 = 2 * current_lcm;
            }

            // 最大公約数とその約数群を取得
            int current_gcd = gcd(left_node->value, right_node->value);
            int divs[100];
            int div_count = divisors_desc(current_gcd, divs, 100);

            int g1 = 0;
            int g2 = 0;
            if (div_count >= 1) {
                g1 = divs[0];
            }
            if (div_count >= 2) {
                g2 = divs[1];
            }

            // 左ノードに倍数群を設定
            if (left_node->left == NULL) {
                left_node->left = new Node(lcm1);
            }
            else {
                left_node->left->value = lcm1;
            }

            if (left_node->right == NULL) {
                left_node->right = new Node(lcm2);
            }
            else {
                left_node->right->value = lcm2;
            }

            // 右ノードに約数群を設定
            if (right_node->left == NULL) {
                right_node->left = new Node(g1);
            }
            else {
                right_node->left->value = g1;
            }

            if (right_node->right == NULL) {
                right_node->right = new Node(g2);
            }
            else {
                right_node->right->value = g2;
            }
        }
    }

    cout << endl;
    PrintTreeLevels(root);

    return 0;
}
