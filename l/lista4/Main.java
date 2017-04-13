import java.io.BufferedReader;
import java.io.FileReader;

public class Main {
  public static void main(String[] args) {
    int counter = 0, max = 0;
    Tree tree = new Tree();
    try (BufferedReader bufferedReader = new BufferedReader(new FileReader(args[0]))) {
      String line; boolean knownMax = false;
      while ((line = bufferedReader.readLine()) != null) {
        if (!knownMax) {
          try {
            max = Integer.parseInt(line);
            knownMax = true;
            continue;
          } catch (NumberFormatException e) {
            System.err.println("\nBłąd: pierwsza linia pliku wejściowego nie jest liczbą całkowitą\n");
            System.exit(0);
          }  
        } else {
          counter++;
          if (line.contains("insert")) {
            line = line.replace("insert", "").trim();
            try {
              tree.insert(Integer.parseInt(line));
            } catch (NumberFormatException e) {
              System.err.println("\nBłąd: \"" + line + "\" nie jest liczbą całkowitą\n");
              System.exit(0);
            }
          } else if (line.contains("delete")) {
            line = line.replace("delete", "").trim();
            try {
              tree.delete(Integer.parseInt(line));
            } catch (NumberFormatException e) {
              System.err.println("\nBłąd: \"" + line + "\" nie jest liczbą całkowitą\n");
              System.exit(0);
            }
          } else if (line.contains("find")) {
            line = line.replace("find", "").trim();
            try {
              tree.find(Integer.parseInt(line), true);
            } catch (NumberFormatException e) {
              System.err.println("\nBłąd: \"" + line + "\" nie jest liczbą całkowitą\n");
              System.exit(0);
            }
          } else if (line.contains("min")) {
            tree.min(tree.root);
          } else if (line.contains("max")) {
            tree.max(tree.root);
          } else if (line.contains("inorder")) {
            tree.inorder(tree.root);
          } else {
            System.err.println("\nBłąd: nieznana lub nieprawidłowa operacja: " + line + "\n");
            System.exit(0);
          }
        }
      }
      if (counter != max) {
        System.err.println("\nBłąd: liczba wykonanych operacji jest różna od zadeklarowanej\n");
      }
    } catch (ArrayIndexOutOfBoundsException e) {
      System.err.println("\nUżycie:\n\tjava Main ścieżkaDoPliku\n");
    } catch (java.io.FileNotFoundException e) {
      System.err.println("\nBłąd: plik \"" + args[0] + "\" nie został znaleziony\n");
    } catch (Exception e) {
      e.printStackTrace();
    }
  }
}