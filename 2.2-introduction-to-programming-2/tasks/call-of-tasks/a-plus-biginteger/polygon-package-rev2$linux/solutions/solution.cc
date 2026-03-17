#include <iostream>
#include <string>
#include <cstdlib>
#include <cstring>
#include <iomanip>
#include <algorithm>
using namespace std;

class BigInteger
{
private:
  bool is_positive;
  unsigned int *digits_buf;
  unsigned int buf_size;

public:
  BigInteger(const string &s)
  {
    is_positive = s.size() == 0 || s[0] != '-';
    buf_size = (s.size() + 8 - 1) / 8;
    digits_buf = (unsigned int *)calloc(buf_size, sizeof(unsigned int));
    for (int i = s.size() - 1, pos = 0, cur_digit = 1; i >= (is_positive ? 0 : 1); --i)
    {
      digits_buf[pos] += (s[i] - '0') * cur_digit;
      cur_digit *= 10;
      if (cur_digit == 100000000)
      {
        cur_digit = 1;
        ++pos;
      }
    }
  }

  ~BigInteger()
  {
    free(digits_buf);
  }

  BigInteger(const BigInteger &other)
  {
    is_positive = other.is_positive;
    buf_size = other.buf_size;
    digits_buf = (unsigned int *)calloc(buf_size, sizeof(unsigned int));
    memcpy(digits_buf, other.digits_buf, buf_size * sizeof(unsigned int));
  }

  BigInteger &operator=(const BigInteger &other)
  {
    if (this != &other)
    {
      free(digits_buf);
      is_positive = other.is_positive;
      buf_size = other.buf_size;
      digits_buf = (unsigned int *)calloc(buf_size, sizeof(unsigned int));
      memcpy(digits_buf, other.digits_buf, buf_size * sizeof(unsigned int));
    }
    return *this;
  }

  BigInteger operator+(const BigInteger &other) const
  {
    if (is_positive && !other.is_positive)
    {
      BigInteger neg_other = other;
      neg_other.is_positive = true;
      return *this - neg_other;
    }
    if (!is_positive && other.is_positive)
    {
      BigInteger neg_this = *this;
      neg_this.is_positive = true;
      return other - neg_this;
    }

    unsigned int new_size = max(buf_size, other.buf_size) + 1;
    BigInteger result("");
    free(result.digits_buf);
    result.buf_size = new_size;
    result.digits_buf = (unsigned int *)calloc(new_size, sizeof(unsigned int));
    result.is_positive = is_positive;

    unsigned long long carry = 0;
    for (unsigned int i = 0; i < new_size; ++i)
    {
      unsigned long long sum = carry;
      if (i < buf_size)
        sum += digits_buf[i];
      if (i < other.buf_size)
        sum += other.digits_buf[i];
      result.digits_buf[i] = sum % 100000000;
      carry = sum / 100000000;
    }

    return result;
  }

  BigInteger operator-(const BigInteger &other) const
  {
    if (!is_positive && other.is_positive)
    {
      BigInteger neg_this = *this;
      neg_this.is_positive = true;
      BigInteger result = neg_this + other;
      result.is_positive = false;
      return result;
    }
    if (is_positive && !other.is_positive)
    {
      BigInteger neg_other = other;
      neg_other.is_positive = true;
      return *this + neg_other;
    }

    bool result_positive = is_positive;
    const BigInteger *larger = this;
    const BigInteger *smaller = &other;

    bool swap = false;
    if (buf_size < other.buf_size)
      swap = true;
    else if (buf_size == other.buf_size)
    {
      for (int i = buf_size - 1; i >= 0; --i)
      {
        if (digits_buf[i] < other.digits_buf[i])
        {
          swap = true;
          break;
        }
        if (digits_buf[i] > other.digits_buf[i])
          break;
      }
    }

    if (swap)
    {
      larger = &other;
      smaller = this;
      result_positive = !result_positive;
    }

    BigInteger result("");
    free(result.digits_buf);
    result.buf_size = larger->buf_size;
    result.digits_buf = (unsigned int *)calloc(result.buf_size, sizeof(unsigned int));
    result.is_positive = result_positive;

    long long borrow = 0;
    for (unsigned int i = 0; i < result.buf_size; ++i)
    {
      long long diff = (long long)larger->digits_buf[i] - borrow;
      if (i < smaller->buf_size)
        diff -= smaller->digits_buf[i];
      if (diff < 0)
      {
        diff += 100000000;
        borrow = 1;
      }
      else
      {
        borrow = 0;
      }
      result.digits_buf[i] = diff;
    }

    return result;
  }

  friend ostream &operator<<(ostream &os, const BigInteger &bi)
  {
    if (!bi.is_positive)
      os << '-';

    int start = bi.buf_size - 1;
    while (start > 0 && bi.digits_buf[start] == 0)
      --start;

    os << bi.digits_buf[start];
    for (int i = start - 1; i >= 0; --i)
    {
      os << setfill('0') << setw(8) << bi.digits_buf[i];
    }
    return os;
  }
};

int main()
{
  string a, b;
  cin >> a >> b;
  BigInteger big_a(a);
  BigInteger big_b(b);
  BigInteger big_c = big_a + big_b;
  cout << big_c << endl;
  return 0;
}
