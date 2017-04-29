public class Procedures {
  public static int comparisons = 0;
  private static int inf = Integer.MIN_VALUE;
  public static Node osSelect(Node x, int i) {
    if (i < 0 || i >= x.size) {
      System.err.println("\nBłąd: w drzewie o rozmiarze " + x.size + " nie istnieje " + i + ". statystyka pozycyjna");
      return null;
    } else {
      int r = 1;
      if (x.left != null) {
        r += x.left.size;
      }

      comparisons++;
      if (i == r-1) {
        return x;
      } else if (i < r) {
        return osSelect(x.left, i);
      } else {
        return osSelect(x.right, i-r);
      }
    }
  }

  public static int osRank(Node node, int value) {
    int r = 1;                    // Każdy element ma indeks o 1 większy od poprzedniego
    if (node == null) {
      System.err.println("\nBłąd: w drzewie nie ma węzła o kluczu " + value);
      return inf;
    }

    if (node.left != null) {
      r += node.left.size;        // Elementy z lewego poddrzewa mają mniejsze indeksy
    }

    if (node.value == value) {
      return r-1;                 // Indeks (liczony od 0) szukanego elementu w drzewie
    } else if (node.value > value) {
      return osRank(node.left, value);
    } else {
      return r + osRank(node.right, value);
    }
  }

  public static int osRank(Tree tree, Node node) {
    int k = 0;
    if (node == null) {
      System.err.println("\nBłąd: dostarczony węzeł jest pusty");
      return inf;
    }

    if (node.left != null) {
      k += node.left.size;
    }

    while (node != tree.root) {
      if (node == node.parent.right) {
        k += 1;
        if (node.parent.left != null) {
          k += node.parent.left.size;
        }
      }
      node = node.parent;
    }

    return k;
  }

  public static Node getNode(Node node, int value) {
    while (node != null) {
      if (node.value == value) {
        return node;
      } else if (value > node.value) {
        node = node.right;
      } else {
        node = node.left;
      }
    }
    return null;
  }

  public static void getSize(Node node) {
    if (node != null) {
      getSize(node.left);
      System.out.println(node.value + ": " + node.size);
      getSize(node.right);
    }
  }
}