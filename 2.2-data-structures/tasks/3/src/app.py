from math import ceil

def compute(gets: list):
    n = len(gets)
    def evaluate(gets: list) -> bool:
        n = len(gets)
        is_palindrome = True
        for i in range(ceil(n / 2)):
            is_palindrome = is_palindrome and gets[i] == gets[-(i + 1)]
            if not is_palindrome:
                break
        return is_palindrome
    _max_len = -1
    _max_len_end = (-1, -1)
    for i in range(n):
        for j in range(i, n):
            now = gets[i:j]
            if evaluate(now):
                if _max_len < j - i:
                    _max_len = j - i
                    _max_len_end = (i, j)
    return (_max_len, _max_len_end)

if __name__ == '__main__':
    _max_len, _max_len_end = compute(input().split())
    print(f'Answer is from {_max_len_end[0]} with length {_max_len}')
