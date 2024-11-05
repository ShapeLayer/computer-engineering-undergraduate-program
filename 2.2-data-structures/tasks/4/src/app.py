from typing import TypeVar, Generic

T = TypeVar("T")

class Node(Generic[T]):
    def __init__(self, data: T, link: 'Node'):
        self.data: T = data
        self.link = link

class LinkedList:
    def __init__(self):
        self.head = None
    
    def is_empty(self):
        return self.head == None

    def is_full(self):
        return False

    def get_node(self, pos: int) -> Node:
        if pos < 0:
            return None
        node = self.head
        while pos > 0 and node != None:
            node = node.link
            pos -= 1
        return node
    
    def get_entry(self, pos: int) -> T:
        node = self.getNode(pos)
        if node == None:
            return None
        else:
            return node.data

    def __getitem__(self, key: int) -> T:
        return self.get_entry(key)

    def insert(self, pos: int, elem: T):
        prev = self.get_node(pos - 1)
        if prev == None:
            self.head = Node(elem, self.head)
        else:
            node = Node(elem, prev.link)
            prev.link = node
    
    def delete(self, pos: int):
        prev = self.get_node(pos - 1)
        if prev == None:
            if self.head is not None:
                self.head = self.head.link
        elif prev.link != None:
            prev.link = prev.link.link

class Term:
    def __init__(self, expo, coef):
        '''
        :param expo: 항의 지수
        :param coef: 항의 계수
        '''
        self.expo = expo
        self.coef = coef

class SparsePoly(LinkedList):
    def __str__(self):
        coef_buf = self.coef()
        str_buf = []
        degs = [*coef_buf.keys()]
        while degs:
            deg = degs.pop()
            str_buf.append(f'{coef_buf[deg]} x^{deg}')
        return ' +\t'.join(str_buf)
    
    def read(self):
        '''
        사용자 입력 함수
        '''
        while True:
            gets = [*map(int, input('계수 차수 입력(종료: -1): ').split())]
            if gets[0] == -1 and gets[1] == -1:
                break
            if (len(gets) != 2):
                # fallback
                continue
            c, d = gets
            if self.get_node(d) == None:
                self._fill_until(d)
            self.get_node(d).data = c
        
        self.display()
    
    def _fill_until(self, pos: int):
        node = self.head # pos 0
        if node == None:
            self.head = Node(0, None)
            node = self.head
        for i in range(pos):
            if node.link == None:
                node.link = Node(0, None)
            node = node.link

    def display(self):
        '''
        화면 출력 함수
        '''
        print(f'\t입력 다항식: {self.__str__()}')

    def add(self, polyB: 'SparsePoly') -> 'SparsePoly':
        '''
        다항식 덧셈 함수
        '''
        _new = SparsePoly()
        _new.head = Node(0, None)
        entry_self, entry_other, entry_new = self.head, polyB.head, _new.head
        while True:
            if entry_self:
                entry_new.data += entry_self.data
                entry_self = entry_self.link
            if entry_other:
                entry_new.data += entry_other.data
                entry_other = entry_other.link
            if entry_self != None or entry_other != None:
                entry_new.link = Node(0, None)
                entry_new = entry_new.link
            else:
                break
        return _new

    def __add__(self, other: 'SparsePoly') -> 'SparsePoly':
        return self.add(other)

    def equal(self, other: 'SparsePoly') -> bool:
        '''
        다항식 항등 평가
        '''
        entry_self, entry_other = self.head, other.head
        while True:
            if entry_self == None and entry_other == None:
                return True
            if entry_self == None or entry_other == None:
                return False
            if entry_self.data != entry_other.data:
                return False
            entry_self, entry_other = entry_self.link, entry_other.link

    def __eq__(self, other: 'SparsePoly') -> 'SparsePoly':
        return self.equal(other)

    def degree(self):
        '''
        다항식 차수 반환
        '''
        i = 0
        entry = self.head
        while True:
            if entry.link == None:
                return i
            i += 1
            entry = entry.link

    def coef(self) -> dict[int, int]:
        '''
        다항식 계수 반환
        '''
        coef_buf = {}
        node = self.head
        degree = 0
        while node != None:
            if node.data != 0:
                coef_buf[degree] = node.data
            node = node.link
            degree += 1
        return coef_buf

if __name__ == '__main__':
    a, b = SparsePoly(), SparsePoly()
    a.read()
    b.read()
    print(f'\tA = {a}')
    print(f'\tB = {b}')
    print(f'\tA + B = {a + b}')
