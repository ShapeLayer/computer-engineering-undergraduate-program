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
#define SWAP(a, b) { \
    auto tmp = a; \
    a = b; \
    b = tmp; \
}
    if (a > b) SWAP(a, b);
    int i = 0;
    while (++i) {
        if ((b * i) % a == 0) return b * i;
    }
    return -1;
}

// 約数を大きい順に配列に格納する
int divisors_desc(int n, int* out_divs, int max_size) {
    /*回答記入箇所その3*/
    int ptr = 0;
    int div = 1;

    while (true) {
        if (n % div == 0) {
            out_divs[ptr] = n / div;
            if (out_divs[ptr] == 0) return ptr;
            ptr++;
        }
        if (ptr >= max_size) return ptr;
        div++;
    }
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
     * Node: 루트는 재할당되지 않음
     * level: 검색 대상 레벨
     * out_nodes: 참조 리턴 대상
     * index: 검색 결과 참조 리턴하는 배열의 사이즈
     * max_size: **out_nodes의 최대 사이즈
     */

    queue<Node *> q;
    q.push(node);
    bool is_null = false;
    for (int i = 0; i < level; i++) {
        auto size = q.size();
        for (int _ = 0; _ < size; _++) {
            auto now = q.front();
            if (now == NULL) is_null = true;
            q.pop();
            if (now != NULL) {
                q.push(now->left);
                q.push(now->right);
            } else {
                q.push(NULL);
                q.push(NULL);
            }
        }
    }
    // collect
    cout << level << ":" << endl;
    index = q.size() - 1;
    for (int i = 0; i <= index; i++) {
        out_nodes[i] = q.front();
        cout << (out_nodes[i] != NULL ? out_nodes[i]->value : -1) << ' ' << endl;
        q.pop();
    }
    
    cout << endl;
}

/**
 * 두 정수 A,B(1에서 10000까지)를 입력합니다.
 * 이를 기반으로 특정 규칙으로 "이진 트리"를 구축하고 이를 출력하는 프로그램을 작성합니다.
 * 나무를 짓는 규칙은 다음과 같습니다.
 
 * 
 * (4) 이 작업을 깊이 5까지 반복합니다.
 * 마지막으로 트리의 각 노드의 값을 "레벨 순서(깊이 순서)"로 출력합니다. 각 레벨은 한 번에 한 줄씩 인쇄하고 노드의
 * 값은 공백으로 구분되어야 합니다.
 */


int main() {
    int A, B;
    cout << "2つの整数を入力してください (1～10000): ";
    cin >> A >> B;

    if (A < 1 || B < 1 || A > 10000 || B > 10000) {
        cout << "エラー: 入力は1～10000の範囲で指定してください。" << endl;
        return 1;
    }

    // 深さ1（ルート）
    /**
     * (1) 깊이 1의 루트 노드 값은 0
     */
    Node* root = new Node(0);

    // 深さ2（入力値を左右に配置）
    /**
     * (2) 깊이 2의 왼쪽 노드에 A를 배치하고 오른쪽 노드에 B를 배치
     */
    root->left = new Node(A);
    root->right = new Node(B);

    const int TARGET_DEPTH = 5;
    const int MAX_NODES_PER_LEVEL = 256; // 十分なサイズを確保

    // 木の成長
    /**
     * (3) 이후의 각 깊이에 대해 동일한 깊이의 노드를 왼쪽에서 오른쪽으로 순서대로 페어링하고 다음 작업을 수행합니다.
     * (3-1) left: a, right: b
     * (3-2) on left node -- left: lcm(a, b), right: lcm(a, b) * 2
     * (3-3) on right node -- a와 b의 최대공약수(GCD)를 구하고, 제수의 배열을 가장 큰 순서대로 구한다.
     * (3-4)              left: max(gcd(a, b)), right: secondary max
     *    (단, 제수가 부족하면 0)
     */
    for (int current_depth = 2; current_depth < TARGET_DEPTH; current_depth++) {
        Node* current_nodes[MAX_NODES_PER_LEVEL];
        int index = 0;

        // 現在のレベルのノードを取得
        // init: root, 1, arr[MAX], 0, MAX(int)
        // init expected: [NULL, NULL], 1
        CollectLevelNodes(root, current_depth - 1, current_nodes, index, MAX_NODES_PER_LEVEL);

        cout << "index " << index << endl;
        // ペアごとに処理
        for (int i = 0; i <= index; i += 2) {
            Node* left_node = current_nodes[i];
            Node* right_node = current_nodes[i + 1];

            if (left_node == NULL) {
                left_node = new Node(0);
                cout << " flag triggered" << endl;
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
