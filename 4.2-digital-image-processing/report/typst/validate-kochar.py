translated = open("main.jp.typ", "r", encoding="utf-8").read()

for each in translated:
    o = ord(each)
    if 8200 <= o <= 9900:
        print(each, o)
    elif 44032 <= o <= 55203:
        print(each, o)
    elif 12593 <= o <= 12643:
        print(each, o)
