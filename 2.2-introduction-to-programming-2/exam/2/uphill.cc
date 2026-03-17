#include <iostream>
using namespace std;

int main() {
    int n;
    cin >> n;
    int a[100]; // nは1桁の整数なので100で十分余裕あり
    for (int i = 0; i < n; i++) {
        cin >> a[i];
    }

    int mount_count = 0;

    /* ここに回答を記入 */
    int prev = -1;

    int flag = 0;
    // 0: idle
    // 1: increase
    // 2: decrease

    for (int i = 0; i < n; i++) {
        if (prev < a[i]) {
            if (flag == 2) {
                mount_count++;
            }
            flag = 1;
        } else if (prev > a[i]) {
            flag = 2;
        } else {
            if (flag == 2) {
                mount_count++;
            }
            flag = 0;
        }
        prev = a[i];
    }
    if (flag == 2) mount_count++;

    cout << mount_count << endl;
    return 0;
}
