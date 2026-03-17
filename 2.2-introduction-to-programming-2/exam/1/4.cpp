// passed

#include <iostream>
#include <map>
using namespace std;

#include "bits/stdc++.h"
int main() {
    map<double,string> exchangeRates = {
        {149.18,"米ドル"},
        {156.77,"ユーロ"},
        {180.21,"英ポンド"},
        {164.39,"スイスフラン"},
        {93.26,"オーストラリアドル"},
        {87.17,"ニュージーランドドル"}
    };

    string newCurrency;
    double newRate;

    // ユーザから通貨名と為替レートを入力
    cin >> newRate >> newCurrency;
    exchangeRates.insert(make_pair(newRate, newCurrency));

    vector<pair<double, string>> sorted = vector<pair<double, string>>(exchangeRates.begin(), exchangeRates.end());
    sort(sorted.begin(), sorted.end());

    string secondHighestRateCurrency;
    secondHighestRateCurrency = sorted.at(sorted.size() - 2).second;
    // 2番目に高い為替レートの通貨を出力
    cout << secondHighestRateCurrency << endl;
}
