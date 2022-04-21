import java.util.*;

public class Menu
{
    private static final int SCREEN_WIDTH = 110;
    private boolean main;
    private boolean restrict;
    private String title;
    private SQLMethod sql;
    private Map<String, String> subMenus;

    /**
     * @brief Creates a MenuList based on the menu hierarchy in a given file
     * @pre fileName must contain a hierarchy of menus in the following format: 
     *          Menu 0
     *              SubMenu 1
     *              SubMenu 2
     * 
     *              SubMenu 1
     *                  SubSubMenu 1.1
     *                  SubSubMenu 1.2
     * 
     *              SubMenu 2
     *                  SubSubMenu 2.1**R**
     *                  SubSubMenu 2.2
     * 
     *      In the example file above, indentations are ignored, however, blank  
     *      line spaces determine which menus belong to which "super" menu;
     *      each menu name must be unique; menus with the suffix **R** are restricted 
     *      to admin users only
     * 
     * @param fileName A file containing a hierarchy of menus
     * @return A MenuList containing the menus in fileName, along with their 
     *         sub menu relationships
     * @post A MenuList will be created from fileName
     */
    public static MenuList getMenusFromFile(String fileName)
    {
        MenuList menus = new MenuList();
        Scanner scan = Input.getFileScanner(fileName);
        boolean isMain = true;

        while (scan != null && scan.hasNextLine())
        {
            ArrayList<String> subMenus = new ArrayList<String>();
            String name = scan.nextLine().trim();
            String line = scan.nextLine().trim();
            while (!line.equals(""))
            {
                subMenus.add(line);
                line = !scan.hasNextLine() ? "" : scan.nextLine().trim();
            }
            menus.add(new Menu(isMain, name, subMenus));
            isMain = false;
        }
        return menus;
    }

    /**
     * @brief Initializes the fields of the Menu
     * @param isMain Specifies whether the menu is the main menu
     * @param menuTitle The header to be displayed at the top of the menu screen
     * @post The fields of the Menu will be initialized
     */
    private void init(boolean isMain, String menuTitle)
    {
        main = isMain;
        restrict = false;
        title = menuTitle;
        sql = null;
        subMenus = new LinkedHashMap<String, String>();
    }

    /**
     * @brief Constricts an empty Menu
     * @post A non-main Menu will be created, with title set to empty string, 
     *       sql set to null, and subMenus as an empty map
     */
    public Menu()
    {
        init(false, "");
    }

    /**
     * @brief Creates a Menu from the given parameters
     * @param isMain Specifies whether the menu is the main menu
     * @param menuTitle The header to be displayed at the top of the menu screen
     * @param menuOptions A map of sub menu names
     * @post a Menu will be created with main set to isMain, title set to menuTitle, 
     *       subMenus set to menuOptions, and a SQLMethod stored in sql (if applicable);
     *       if the "Back" (for non-main menus) and "Quit" are not listed in menuOptions, 
     *       they will be added by default to the end of subMenus
     */
    public Menu(boolean isMain, String menuTitle, List<String> menuOptions)
    {
        init(isMain, menuTitle);
        boolean hasQuit = false;
        boolean hasBack = false;

        for (int i = 0; i < menuOptions.size(); i++)
        {
            String number = String.valueOf(i + 1);
            String name = menuOptions.get(i);
            subMenus.put(number, name);

            if (name.substring(0, 4).equalsIgnoreCase("sql#"))
            {
                sql = new SQLMethod(name);
                subMenus.remove(number);
                break;
            }
            switch (name.toLowerCase())
            {
                case "quit": hasQuit = true; break;
                case "back": hasBack = true; break;
                default:     break;
            }
            if (name.contains("**R**"))
            {
                restrict = true;
                subMenus.put(number, name.replace("**R**",""));
            }
        }
        if (!hasBack && !isMain)
            subMenus.put("B", "Back");
            
        if (!hasQuit)
            subMenus.put("Q", "Quit");
    }

    /**
     * @brief Creates a new Menu as a copy of another Menu
     * @param other A Menu to copy
     * @post A new Menu will be created, which will be a copy of other
     */
    public Menu(Menu other)
    {
        main = other.main;
        restrict = other.restrict;
        title = other.title;
        sql = other.sql;
        subMenus = other.subMenus;
    }

    /**
     * @brief Returns the screen width of the Menu
     * @return The screen width of the Menu as an integer
     */
    public static int getScreenWidth()
    {
        return SCREEN_WIDTH;
    }

    /**
     * @brief Returns if this Menu is a main menu
     * @return True if this Menu is a main menu, or false otherwise
     */
    public boolean isMainMenu()
    {
        return main;
    }

    /**
     * @brief Returns if this Menu is restricted to admin only
     * @return True if this Menu is restricted, or false otherwise
     */
    public boolean isRestricted()
    {
        return restrict;
    }

    /**
     * @brief Returns the title of the Menu
     * @return The title for the Menu
     */
    public String getTitle()
    {
        return title;
    }

    /**
     * @brief Returns a map containing the names of the Menu's sub menus 
     * @return A Map containing, as string, the names of the Menu's 
     *         available sub menus
     */
    public Map<String, String> getSubMenus()
    {
        return subMenus;
    }

    /**
     * @brief Prints a border using the given character
     * @param c The charcter to use for the border
     * @param above The amount of space above the border
     * @param below The amount of space below the border
     * @post Prints a border across the SCREEN_WIDTH using 
     *       the given character c, with blank pace above 
     *       and/or below as specified 
     */
    public static void printBorder(char c, int above, int below)
    {
        // space above border
        for (int i = 0; i < above; i++)
            System.out.println();

        // border
        for (int i = 0; i < SCREEN_WIDTH; i++)
            System.out.print(c);
        System.out.println();

        // space below border
        for (int i = 0; i < below; i++)
            System.out.println();
    }

    /**
     * @brief Returns a string of blank spaces of which can be used 
     *        to pad the given text to make a fixed width string
     * @param text A string of text
     * @param fixedWidth A width of which to compare the given text
     * @return A string of blank spaces that, if combined with text, 
     *         will be of length fixedWidth
     */
    public static String getPadding(String text, int fixedWidth)
    {
        int padWidth = fixedWidth - text.length();
        String pad = "";
        for (int i = 0; i < padWidth; i++)
            pad += " ";
        return pad;
    }

    /**
     * @brief Pads the given text string with spaces on the left
     * @param text A string of text
     * @param fixedWidth A width of which to compare the given text
     * @return The given text string with spaces padded on the left 
     *         such that the new string is of fixedWidth length
     */
    public static String padTextLeft(String text, int fixedWidth)
    {
        return getPadding(text, fixedWidth) + text;
    }

    /**
     * @brief Pads the given text string with spaces on the right
     * @param text A string of text
     * @param fixedWidth A width of which to compare the given text
     * @return The given text string with spaces padded on the right 
     *         such that the new string is of fixedWidth length
     */
    public static String padTextRight(String text, int fixedWidth)
    {
        return text + getPadding(text, fixedWidth);
    }

    /**
     * @brief Calculates the required space paddings on the left and right
     *        for the given text to be centered on the screen
     * @param text A string of text
     * @return An array containing 2 entries; array[0] and array[1] will 
     *         each store a string of spaces for which the given text can 
     *         be padded on the left and right, respectively, in order to 
     *         center on the screen
     */
    public static String[] getCenterAlignment(String text)
    {
        String[] alignment = new String[2];

        // spaces on left and right of centered text
        int textLength = text.length();
        int left = (SCREEN_WIDTH - textLength) / 2;
        int right = SCREEN_WIDTH - textLength - left;

        String leftPad = getPadding(text, textLength + left);
        String rightPad = getPadding(text, textLength + right);
        
        alignment[0] = leftPad;
        alignment[1] = rightPad;
        return alignment;
    }

    /**
     * @brief Prints the given text string centered on the screen
     * @param text A string of text
     * @param newLine Specifies if the cursor should be moved to the next 
     *                line after printing
     * @post text will be printed centered on the screen; if newLine is true, 
     *       cursor will be positioned on the next line
     */
    public static void printCentered(String text, boolean newLine)
    {
        // print text centered between left and right space paddings
        String[] align = getCenterAlignment(text);
        String nl = newLine ? "\n" : "";
        System.out.print(align[0] + text + align[1] + nl);
    }

    /**
     * @brief Returns the maximum length among a collection of strings
     * @param strings A collection of strings to compare
     * @return The length of the longest string as an integer
     */
    public static int getMaxLength(Collection<String> strings)
    {
        int maxLength = 0;
        for (String s : strings)
            maxLength = Math.max(maxLength, s.length());
        return maxLength;
    }

    /**
     * @brief Prints the given Map of options centered on the screen
     * @param optionList A map of options to print
     * @post The key-value pairs of optionList will be printed to the screen 
     *       in format "key. value" such that the longest option will be 
     *       centered on the screen, with all other options left-aligned to 
     *       that option
     */
    public static void printOptions(Map<String, String> optionList)
    {
        printCentered("Options", true);
        System.out.println();

        // length of longest menu item
        int maxLength = getMaxLength(optionList.values());
        int labelWidth = getMaxLength(optionList.keySet());

        // print all options left-aligned to the center-aligned longest option
        for (String k : optionList.keySet())
        {
            String line = padTextRight(optionList.get(k), maxLength);
            printCentered(padTextLeft(k, labelWidth) + ". " + line, true);
        }
    }

    /**
     * @brief Displays the contents of the current Menu
     * @param conn A database connection
     * @return A string containing the name of the next Menu to be displayed
     * @post The title and subMenus of the Menu will be printed to the screen; 
     *       user will be prompted to select from one of the displayed options; 
     *       if the Menu stores a SQLMethod, it will be executed
     */
    public String displayCurrentMenu(MySQLConnection mySQL)
    {
        String welcomeMsg = main ? "Welcome to the " : "";
        printBorder('*', 1, 1);
        printCentered(welcomeMsg + title, true);
        printBorder('*', 1, 1);

        // check for admin privileges
        if (restrict)
        {
            boolean admin = mySQL.validateCredentials();
            if (!admin)
                return "back";
            restrict = false;
        }
        // run applicable sql method
        if (sql != null)
        {
            boolean escape = sql.executeSQL(mySQL.getConn());
            if (escape)
                return "back";
        }
        printOptions(subMenus);
        System.out.println();

        String selection = Input.getString("Select an option", subMenus.keySet());
        selection = subMenus.get(selection.toUpperCase());
        System.out.println("You selected: " + selection);
        return selection;
    }
}