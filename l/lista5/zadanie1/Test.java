import java.util.Random;

public class Test {
  private static void createBalancedTree(Tree tree, int[] arr, int start, int end) {
    if (end-start == 0) {
      tree.insert(arr[end]);
    } else if (end-start == 1) {
      tree.insert(arr[start]);
      tree.insert(arr[end]);
    } else {
      int m = (start+end)/2;
      tree.insert(arr[m]);
      createBalancedTree(tree, arr, start, m-1);
      createBalancedTree(tree, arr, m+1, end);
    }
  }

  public static void main(String[] args) {
    int[] size = {25, 50, 100, 500, 1000, 2000, 3000, 4000, 5000, 6000, 7000, 8000, 9000, 10000}, stats = new int[50], avgRand = new int[14], avgBalanced = new int[14], avgAsc = new int[14];
    String[] type = {"asc", "balanced", "rand"};
    Random random = new Random();

    for (String t : type) {
      int k = 0;
      for (int s : size) {
        for (int i = 0; i < 50; i++) {
          Tree tree = new Tree();
          if (t.equals("asc") || t.equals("rand")) {
            for (int j = 0; j < s; j++) {
              if (t.equals("rand")) {
                tree.insert(random.nextInt(100000));
              } else {
                tree.insert(j);
              }
            }
          } else {
            int arr[] = new int[s];
            for (int j = 0; j < s; j++) {
              arr[j] = j;
            }
            createBalancedTree(tree, arr, 0, s-1);
          }
          Procedures.comparisons = 0;
          Procedures.osSelect(tree.root, random.nextInt(s));
          stats[i] = Procedures.comparisons;
        }
        if (t.equals("asc")) {
          avgAsc[k] = Get.avg(stats);
        } else if (t.equals("balanced")) {
          avgBalanced[k] = Get.avg(stats);
        } else {
          avgRand[k] = Get.avg(stats);
        }
        k++;
      }
    }
    System.out.print("Losowo zbudowane binarne drzewo poszukiwań:\r\n");
    for (int i = 0; i < avgRand.length; i++) {
      System.out.print(size[i] + " " + avgRand[i] + "\r\n");
    }
    System.out.println("\r\nZbalansowane binarne drzewo poszukiwań:");
    for (int i = 0; i < avgBalanced.length; i++) {
      System.out.print(size[i] + " " + avgBalanced[i] + "\r\n");
    }
    System.out.println("\r\nNiezbalansowane binarne drzewo poszukiwań:");
    for (int i = 0; i < avgAsc.length; i++) {
      System.out.print(size[i] + " " + avgAsc[i] + "\r\n");
    }
  }
}