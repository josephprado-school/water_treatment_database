import java.util.*;
import java.io.*;

public class Input
{
    private static Scanner keyboard = new Scanner(System.in);

    /**
     * @brief Prompts user to enter a value
     * @param prompt A message displayed to the user
     * @return The value entered by the user, as a string
     */
    public static String getString(String prompt)
    {
        System.out.print(prompt + ": ");
        return keyboard.nextLine();
    }

    /**
     * @brief Prompts user to enter a value and validates that value against a set of predefined
     *        acceptable values
     * @param prompt A message displayed to the user
     * @param validOptions A set of acceptable values for user to choose from
     * @return The value entered by the user, as a string
     * @post User will be prompted to enter a value; if user enters a value not contained in 
     *       validOptions, user will be prompted again
     */
    public static String getString(String prompt, Set<String> validOptions)
    {
        String result = "";
        while (true)
        {
            result = getString(prompt);
            for (String s : validOptions)
            {
                if (s.equalsIgnoreCase(result))
                    // return the actual option 's' instead of user's selection 'result'
                    return s;
            }
            System.out.println("Invalid option: " + "\"" + result + "\"\n");
        }
    }

    /**
     * @brief Creates a Scanner for a given file
     * @param fileName The name of a file to scan
     * @return A Scanner for the given file
     * @post A Scanner object will be created to use on the given file (if it exists)
     * @throws FileNotFoundException if unable to locate file
     */
    public static Scanner getFileScanner(String fileName)
    {
        try
        {
            File file = new File(fileName);
            Scanner scan = new Scanner(file);
            return scan;
        }
        catch (FileNotFoundException e)
        {
            System.out.println("Could not locate file: " + "\"" + fileName + "\"");
            return null;
        }
    }
}