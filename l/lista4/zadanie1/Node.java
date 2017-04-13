public class Node {
  Node left, right, parent;
  int value;
  public Node(int v) {
    this.value = v;
    this.parent = null;
    this.left = null;
    this.right = null;
  }
}