public class Node {
  Node left, right, parent;
  int value, size = 0;
  public Node(int v) {
    this.left = null;
    this.right = null;
    this.parent = null;
    this.size = 1;
    this.value = v;
  }
}