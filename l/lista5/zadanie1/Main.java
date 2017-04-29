public class Main {
  public static void main(String[] args) {
    Tree tree = new Tree();
    int[] A = {3, 8, 1, 7, 4, 5, 6, 2, 12};
    for (int a : A) {
      tree.insert(a);
    }
    System.out.print("\nA: ");
    tree.inorder(tree.root);
    System.out.println("\nosSelect():\n");
    for (int i = 0; i < A.length; i++) {
      System.out.print("i = " + i + "\tvalue = " + Procedures.osSelect(tree.root, i).value + "\n");
    }
    Procedures.osSelect(tree.root, -1);
    Procedures.osSelect(tree.root, 9);
    System.out.println("\nosRank():");

    for (int a : A) {
      System.out.println("value = " + a + "\trank = " + Procedures.osRank(tree.root, a));
    }

    Procedures.osRank(tree.root, 121);

    System.out.println("\nosRank() - wersja z Cormena:");

    Node node;
    for (int a : A) {
      node = Procedures.getNode(tree.root, a);
      System.out.println("value = " + a + "\trank = " + Procedures.osRank(tree, node));
    }

    node = Procedures.getNode(tree.root, 809);
    Procedures.osRank(tree, node);
  }
}