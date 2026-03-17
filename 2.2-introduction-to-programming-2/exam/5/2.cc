/**
 * problem.md 2026-02-01
1 / 3
問題2: ⽊の配達

예시: L, RR, LLR, RRL
입력
K
path_1
path_2
...
path_K
a b
problem.md 2026-02-01
2 / 3
0 <= K <= 3
path_i, a, b는 1-3 길이의 문자열로, ROOT 또는 L과 R만으로 구성됩니다
path_i 서로 다릅니다
출력
최종 패키지 수는 k(=K)입니다.
k = 0이면: 0만 출력하며(최소 이동 횟수를 출력하지 않음).
k > 0에 대해:
첫 번째 줄에 k가 붙어
두 번째 행의 최소 이동 횟수 minMoves

深さ 4 固定（根の深さを 0，最⼤深さを 3 とする）の完全⼆分⽊を考える。

この⽊は合計 15 個のノードを持つ。
이 트리는 총 15개의 노드를 가짐
各ノードは荷物の有無を表す hasPackage（真偽値）を持つ。
각 노드는 부하의 존재 여부를 나타내는 hasPackage 불리언 값을 가짐
初期状態では，すべてのノードで
기본적으로 모든 노드는
hasPackage=false（荷物なし）である。


次に，⼊⼒で与えられる K 個（0 <= K <= 3）のノードに荷物を置く。
다음으로, 입력에 명시된 K 노드(0 < = K < = 3)에 부하를 가한다?

荷物を置くとは，そのノードの
짐을 배치하는 것은 그 노드의
hasPackage を true にすることである。（同じノードが複数回指定されることはない）
(동일 노드는 재지정 불가)

その後，出発ノード a と到着ノード b が与えられる。
다음으로, 출발 노드 A B가 주어짐

あなたはノード a から出発し，ノード b で終了するように⽊の辺に沿って移動する。
당신은 a에서 출발 b에 종료하도록 너무를 잘라야 함

ただし，移動中に 荷物が置かれているすべてのノードを少なくとも 1 回は訪
問して配達しなければならない。
하지만 이사 중에는 짐이 놓인 노드 중 적어도 한 곳을 방문해 배달해야합니다

ここで，ノードの「訪問」とは，そのノードに到達することを指す。
여기서 노드의 방문은 해당 노드에 도달하는 것을 의미

移動経路上でそのノードを通過するこ
とも訪問に含めてよい（⽊なので通過とは到達と同義である）。
이동경로의 그 노드를 통과하는 경우 방문에 포함할 수 있다.
트리이기때문에 지나가는 것과 동의어

また，出発点 a や到着点 b に荷物がある場
合は，出発時／到着時にそのノードを訪問したものとしてよい（追加の移動は不要）。
또한 출발점과 도착점에 짐이 있는 경우에는 출발시/도착시 그 노드의 ...
추가 이동불요

移動回数は「親⼦関係で直接つながっている 2 ノード間の辺を 1 本移動するごとに 
1 増える」と定義する。
이동횟수는 부모자식 관계로 직결된 두 노드 사이의 한 개 간선을 이동 으로 정의

同じ辺や同じノードを何度通ってもよい。
같은 쪽이나 같은 노드를 원하는 만큼 통과 가능

最終的な荷物数 k（この問題では k = K）と，荷物がある全ノードを訪問しつつ a から b へ到達するために
必要な 最⼩移動回数を求めよ。
최종적인 짐 수 k와 패키지가 위치한 모든 노드를 방문할 때A에서 B로 이동하는 방법에
필요한 최소이동횟수를 구하여라

この問題では，buildFixedTree 関数と deleteTree 関数を作成する。
이번 문제에서는 buildFixedTree와 deleteTree 함수를 구현

ノードの指定⽅法
노드 지정 방법

ノードは整数番号では指定せず，根からの道順を表す⽂字列 path で指定する。
노드는 정수로 지정되지 않고, 근에서 방향을 나타내는 문자열 경로로 지정

根は ROOT で表す。

それ以外は，⽂字 L と R のみからなる⻑さ 1〜3 の⽂字列で表す。
L︓左の⼦へ進む
R︓右の⼦へ進む

例︓L, RR, LLR, RRL
⼊⼒
K
path_1
path_2
...
path_K
a b
problem.md 2026-02-01
2 / 3
0 <= K <= 3
path_i，a，b は ROOT または L と R のみからなる⻑さ 1〜3 の⽂字列
path_i は互いに異なる
出⼒
最終的な荷物数を k(=K) とする。
k = 0 の場合︓0 のみを出⼒する（最⼩移動回数は出⼒しない）。
k > 0 の場合︓
1 ⾏⽬に k
2 ⾏⽬に最⼩移動回数 minMoves
サンプル
⼊⼒例 1
3
ROOT
LR
RRL
LLL LLL
出⼒例 1
3
14
⼊⼒例 2
3
LLL
RRR
LR
LLR RLL
出⼒例 2
3
14
problem.md 2026-02-01
3 / 3
⼊⼒例 3
3
LRL
RRL
LL
LRL RRL
出⼒例 3
3
8
⼊⼒例 4
1
ROOT
LLL RRR
出⼒例 4
1
6
 */

#include <iostream>
#include <string>
#include <algorithm>
#include <climits>

using namespace std;

struct Node {
public:
    bool hasPackage;
    int depth;
    Node* parent;
    Node* left;
    Node* right;

    Node(int d, Node* p)
        : hasPackage(false), depth(d), parent(p), left(NULL), right(NULL) {
    }
};

Node* buildFixedTree(int depth, int maxDepth, Node* parent) {
    Node* node = new Node(depth, parent);
    /*回答記入箇所その①*/

    if (depth < maxDepth) {
        node->left = buildFixedTree(depth + 1, maxDepth, node);
        node->right = buildFixedTree(depth + 1, maxDepth, node);
    }

    

    return node;
}

void deleteTree(Node* node) {
    /*回答記入箇所その②*/
    delete node;
}

Node* pathToNode(Node* root, const string& s) {
    if (s == "ROOT") {
        return root;
    }
    Node* cur = root;
    for (int i = 0; i < (int)s.size(); i++) {
        if (s[i] == 'L') {
            cur = cur->left;
        }
        else { // 'R'
            cur = cur->right;
        }
    }
    return cur;
}

int distNodes(Node* u, Node* v) {
    Node* uu = u;
    Node* vv = v;

    while (uu->depth > vv->depth) {
        uu = uu->parent;
    }
    while (vv->depth > uu->depth) {
        vv = vv->parent;
    }
    while (uu != vv) {
        uu = uu->parent;
        vv = vv->parent;
    }
    Node* lca = uu;

    return u->depth + v->depth - 2 * lca->depth;
}

int main() {
    // 固定木（深さ0〜3の完全二分木）を作成
    Node* root = buildFixedTree(0, 3, NULL);

    int K;
    cin >> K;

    Node* packages[3];
    for (int i = 0; i < 3; i++) {
        packages[i] = NULL;
    }

    for (int i = 0; i < K; i++) {
        string p;
        cin >> p;
        Node* nd = pathToNode(root, p);
        nd->hasPackage = true;
        packages[i] = nd; // 入力保証：重複なし，K<=3
    }

    string aPath, bPath;
    cin >> aPath >> bPath;

    Node* a = pathToNode(root, aPath);
    Node* b = pathToNode(root, bPath);

    int k = K;

    // k=0 の場合：0 のみ（minMoves は出力しない）
    if (k == 0) {
        cout << 0 << endl;
        deleteTree(root);
        return 0;
    }

    // a と b が荷物なら開始/終了で訪問済みなので必須訪問から除外できる
    Node* req[3];
    for (int i = 0; i < 3; i++) {
        req[i] = NULL;
    }

    int reqN = 0;
    for (int i = 0; i < K; i++) {
        Node* v = packages[i];
        if (v == a) {
            continue;
        }
        if (v == b) {
            continue;
        }
        req[reqN] = v;
        reqN++;
    }

    int minMoves = INT_MAX;

    if (reqN == 0) {
        // 荷物は a / b のみ（または両方）なので a->b の最短距離で十分
        minMoves = distNodes(a, b);
    }
    else {
        // required の順序を全探索（最大 3! = 6 通り）
        sort(req, req + reqN);

        do {
            int total = 0;

            total += distNodes(a, req[0]);
            for (int i = 0; i + 1 < reqN; i++) {
                total += distNodes(req[i], req[i + 1]);
            }
            total += distNodes(req[reqN - 1], b);

            if (total < minMoves) {
                minMoves = total;
            }
        } while (next_permutation(req, req + reqN));
    }

    // 出力：k と minMoves は改行
    cout << k << endl;
    cout << minMoves << endl;

    deleteTree(root);
    return 0;
}
