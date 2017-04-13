import java.util.Random;

public class Stats {
  public static int avg(int[] arr) {
    int sum = 0;
    for (int i = 0; i < arr.length; i++) {
      sum += arr[i];
    }
    return sum/arr.length;
  }

  public static int min(int[] arr) {
    int min = Integer.MAX_VALUE;
    for (int i = 0; i < arr.length; i++) {
      if (arr[i] < min) {
        min = arr[i];
      }
    }
    return min;
  }

  public static int max(int[] arr) {
    int max = Integer.MIN_VALUE;
    for (int i = 0; i < arr.length; i++) {
      if (arr[i] > max) {
        max = arr[i];
      }
    }
    return max;
  }

  public static void main(String[] args) {
    int[] size = {25, 50, 100, 500, 1000, 2000, 3000, 4000, 5000, 6000, 7000, 8000, 9000, 10000}, stats = new int[50], height = new int[50];
    int minComp, maxComp, avgComp, minHeight, avgHeight, maxHeight;
    Random random = new Random();
    for (int i = 0; i < 14; i++) {
      for (int k = 0; k < 50; k++) {
        Tree tree = new Tree();
        for (int j = 0; j < size[i]; j++) {
          if (args[0].equals("asc")) {
            tree.insert(j);
          } else {
            tree.insert(random.nextInt(10000));
          }
        }
        tree.numberOfComparisons = 0;
        tree.find(random.nextInt(10000), false);
        stats[k] = tree.numberOfComparisons;
        height[k] = tree.height(tree.root);
      }
      minComp = min(stats); avgComp = avg(stats); maxComp = max(stats);
      minHeight = min(height); avgHeight = avg(height); maxHeight = max(height);

      if (args.length == 3) {
        if (args[2].equals("min")) {
          if (args[1].equals("comparisons")) {
            System.out.println(minComp);
          } else if (args[1].equals("height")) {
            System.out.println(minHeight);
          }
        } else if (args[2].equals("avg")) {
          if (args[1].equals("comparisons")) {
            System.out.println(avgComp);
          } else if (args[1].equals("height")) {
            System.out.println(avgHeight);
          }
        } else if (args[2].equals("max")) {
          if (args[1].equals("comparisons")) {
            System.out.println(maxComp);
          } else if (args[1].equals("height")) {
            System.out.println(maxHeight);
          }
        }
      }
    }
  }
}