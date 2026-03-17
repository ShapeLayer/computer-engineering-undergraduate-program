#include <iostream>
#include <stack>
#include <queue>
#include <string>
using namespace std;


bool isPalindromeStackQueue(const string& s, int left, int right) {
    stack<char> st;
    queue<char> qu;

    /* 回答記入箇所その1 */

    // asdf fdsa (stack) (queue)
    for (int i = left; i <= right; i++) {
        st.push(s[i]);
        qu.push(s[i]);
    }
    
    while (!st.empty()) {
        if (st.top() != qu.front()) {
            return false;
        }
        st.pop();
        qu.pop();
    }
    return true;
}

int main() {
    string S;
    getline(cin, S);
    
    int bestLeft = -1;
    int bestRight = -1;
    int bestLen = 0;
    int n = S.length();


    /* 回答記入箇所その2 */
    for (int left = 0; left < n - 1; left++) {
        for (int right = left +1; right < n; right++) {
            if (isPalindromeStackQueue(S, left, right)) {
                int curr = right - left + 1;
                if (bestLen < curr) {
                    bestLen = curr;
                    bestLeft = left;
                    bestRight = right;
                }
            }
        }
    }
    

    if (bestLen <= 1) {
        cout << "回文なし" << endl;
    }
    else {
        for (int i = bestLeft; i <= bestRight; i++) {
            cout << S[i];
        }
        cout << endl;
    }

    return 0;
}
