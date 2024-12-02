from typing import TypeVar
from collections import deque

T = TypeVar('T')

class TreeNode:
    def __init__(self, value: T):
        self.value: T = value
        self.parent: TreeNode = None
        self.left: TreeNode = None
        self.right: TreeNode = None
    
    def __str__(self) -> str:
        return f'TreeNode ({self.value}): ' + f'parent({self.parent.value if self.parent else self.parent}), left({self.left.value if self.left else self.left}), right({self.right.value if self.right else self.right})'

class Tree:
    def __init__(self):
        self.entry: TreeNode[T] = None

    def add(self, value: T):
        node = TreeNode(value)
        finding = self.search(value)
        if not finding:
            self.entry = node
            return
        
        if finding.value == value:
            return
        if finding.value > value:
            finding.left = node
        elif finding.value < value:
            finding.right = node
        node.parent = finding
    
    def remove(self, value: T):
        finding = self.search(value)
        if finding.value != value:
            return
        
        s: deque[TreeNode[T]] = deque()
        now = finding
        while True:
            if now.left:
                s.append(now)
                now = now.left
            elif now.right:
                s.append(now)
                now = now.right
            else:
                break
        if s:
            now = s.pop()
        while s:
            next = s.pop()
            if now is next.left:
                now.right = next.right
            elif now is next.right:
                now.left = next.left
            now = next
        
        now = now
        if now.left:
            now = now.left
        elif now.right:
            now = now.right
        else:
            now = None

        parent = finding.parent
        if not parent:
            if parent:
                now.parent = None
            self.entry = now
        else:
            if finding is parent.left:
                parent.left = now
            elif finding is parent.right:
                parent.right = now
        if now:
            now.parent = finding.parent
        del finding

    def search(self, value: T) -> TreeNode:
        if self.is_empty():
            return None
        now = self.entry
        while True:
            if now.value > value:
                next = now.left
                if not next:
                    return now
                now = next
            elif now.value < value:
                next = now.right
                if not next:
                    return now
                now = next
            else:
                return now
    
    def is_empty(self):
        return self.entry == None
    
    def union(self, other: 'Tree[T]') -> 'Tree[T]':
        _new: Tree[T] = Tree()
        [_new.add(each) for each in self.inorder_traverse()]
        [_new.add(each) for each in other.inorder_traverse()]
        return _new
    
    def difference(self, other: 'Tree[T]') -> 'Tree[T]':
        _new: Tree[T] = Tree()
        [_new.add(each) for each in self.inorder_traverse()]
        for each in other.inorder_traverse():
            _new.remove(each)
        return _new
    
    def inorder_traverse(self) -> list[T]:
        q: deque[TreeNode[T]] = deque()
        result: list[T] = []
        q.append(self.entry)
        while q:
            now = q.popleft()
            result.append(now.value)
            if now.left:
                q.append(now.left)
            if now.right:
                q.append(now.right)
        return result
    
def example():
    a: Tree[int] = Tree()
    b: Tree[int] = Tree()
    [a.add(each) for each in map(int, input('A 집합의 원소를 입력: ').split())]
    [b.add(each) for each in map(int, input('B 집합의 원소를 입력: ').split())]
    
    finding = int(input('검색할 원소 입력: '))
    print(f'집합 A에서 {finding} 검색:', 'T' if a.search(finding) else 'F')
    print(f'집합 B에서 {finding} 검색:', 'T' if a.search(finding) else 'F')

    c = a.union(b)
    d = a.difference(b)
    
    print(f'C: {c.inorder_traverse()}')
    print(f'D: {d.inorder_traverse()}')
    print('T' if c.difference(d).is_empty() else 'F')

def manual_test():
    tree: Tree[int] = Tree()
    for i in range(10):
        tree.add((i // 2 + 1) * (1 + -2 * (i % 2)))
    print(tree.inorder_traverse())
    tree.remove(2)
    print(tree.inorder_traverse())
    assert tree.difference(tree).is_empty()

if __name__ == '__main__':
    example()
