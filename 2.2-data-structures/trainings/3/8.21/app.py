class Node:
    def __init__(self, value, parent: 'Node'=None):
        self.value = value
        self.left = None
        self.right = None
        self.parent = parent

def get_height(root: Node):
    if root is None:
        return 0
    return 1 + max(get_height(root.left), get_height(root.right))

def is_balenced(root: Node):
    if root is None:
        return True
    return is_balenced(root.left) and is_balenced(root.right) and abs(get_height(root.left) - get_height(root.right)) < 2

if __name__ == '__main__':
    a = Node('a')
    b = Node('b', a)
    e = Node('e', a)
    a.left, a.right = b, e
    c = Node('c', b)
    d = Node('d', b)
    b.left, b.right = c, d
    f = Node('f', e)
    e.right = f
    print(is_balenced(a))
