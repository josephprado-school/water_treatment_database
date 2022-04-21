import java.util.*;

public class MenuList extends ArrayList<Menu>
{
    /**
     * @brief Creates a new MenuList
     */
    public MenuList()
    {
        super();
    }

    /**
     * @brief Returns the index location of the named Menu (if available)
     * @param title The title of the Menu to search for
     * @return The index location of the named Menu, or -1 if not found
     */
    public int getIndexOf(String title)
    {
        int index = -1;
        int size = size();
        for (int i = 0; i < size; i++)
        {
            if (get(i).getTitle().equalsIgnoreCase(title))
            {
                index = i;
                break;
            }
        }
        return index;
    }

    /**
     * @brief Checks if the MenuList conatins a Menu with the given title
     * @param title The title of a Menu
     * @return True if a Mennu with the given title is stored, or false otherwise
     */
    public boolean contains(String title)
    {
        return getIndexOf(title) >= 0;
    }

    /**
     * @brief Returns a Menu with the given title
     * @param title The title of a Menu
     * @return The Menu with the given title, or null if not found
     */
    public Menu getMenu(String title)
    {
        int index = getIndexOf(title);
        return index >= 0 ? get(index) : null;
    }
}