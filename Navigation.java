import java.util.*;

public class Navigation
{
    private MySQLConnection mySQL;
    private MenuList menus;
    private Stack<Menu> nav;
    
    /**
     * @brief Creates a new Navigation object
     * @param sqlConn A MySQLConnection
     * @param fileName The name of a file containing a menu hierarchy
     * @post A new Navigation object will be created from the given parameters
     */
    public Navigation(MySQLConnection sqlConn, String fileName)
    {
        mySQL = sqlConn;
        menus = Menu.getMenusFromFile(fileName);
        nav = new Stack<Menu>();
        nav.push(menus.get(0));
    }

    /**
     * @brief Facilitates the navigation between menu screens
     * @post Displays the contents of the main menu, then prompts user to select 
     *       a new menu to display; if the user selects a Menu for which no sub-menus 
     *       exist, a dummy menu will be created and displayed, informing the user that 
     *       the selected item is unavailable / "coming soon"
     */
    public void navigate()
    {
        while (true)
        {
            String nextMenu = nav.peek().displayCurrentMenu(mySQL);
            switch (nextMenu.toLowerCase())
            {
                case "quit":
                    break;

                case "back":
                    nav.pop();
                    continue;

                default:
                    Menu result = menus.getMenu(nextMenu);
                    if (result != null)
                        // menu exists, push a copy of the original onto stack
                        nav.push(new Menu(result));
                    else
                        // menu does not exist, create dummy menu and push onto stack
                        nav.push(new Menu(false, nextMenu + " - COMING SOON!", new ArrayList<String>()));
                    continue;
            }
            break;
        }
        System.out.println();
        System.out.println("Thank you for using the " + menus.get(0).getTitle());
        System.out.println("Goodbye.");
        System.out.println();
        mySQL.closeDBConnection();
    }
}