import java.sql.*;

public class MySQLConnection
{
    private String host;
    private String port;
    private String schema;
    private String param;
    private String user;
    private String pass;
    private boolean connSuccess;
    private Connection conn;

    /**
     * @brief Constructs a new MySQLConnection object
     * @param hostName
     * @param portNumber
     * @param schemaName
     * @param parameters
     * @param username
     * @param password
     * @post A new MySQLConnection will be created, with a database connection 
     *       stored in conn
     */
    public MySQLConnection(String hostName, String portNumber, String schemaName,
                            String parameters, String username, String password)
    {
        host = hostName;
        port = portNumber;
        schema = schemaName;
        param = parameters;
        user = username;
        pass = password;
        connSuccess = connectToDB();
    }

    /**
     * @brief Creates a connection to a database
     * @return True if the connection is successful, or false otherwise
     * @post A database connections will be established and stored in conn
     * @throws SQLException
     */
    private boolean connectToDB()
    {
        try
        {
            Class.forName("com.mysql.cj.jdbc.Driver");
            String url = "jdbc:mysql://" + host + ":" + port + "/" + schema + param;
            conn = DriverManager.getConnection(url, user, pass);
        }
        catch (ClassNotFoundException e)
        {
            System.out.println("\nCould not load the driver.\n");
        }
        catch (SQLException e)
        {
            System.out.println("\nSQLException: " + e + "\n");
        }
        return conn != null;
    }

    /**
     * @brief Closes the connection to the database
     * @post The connection conn will be closed
     * @throws SQLException
     */
    public void closeDBConnection()
    {
        if (conn != null)
        {
            try
            {
                conn.close();
                System.out.println("Connection closed.");
            }
            catch (SQLException e)
            {
                System.out.println("SQLException: " + e);
            }
        }
    }

    /**
     * Qbrief Reuturns the connection of the MySQLConnection object
     * @return The connection of the MySQLConnection object
     */
    public Connection getConn()
    {
        return conn;
    }

    /**
     * @brief Returns the connection status of the MySQLObject
     * @return True if conn is connected, or false otherwise
     */
    public boolean isConnected()
    {
        return connSuccess;
    }

    /**
     * @brief Prompts the user to enter a valid username and password
     * @return True if both username and password match the user and pass stored in the MySQLConnection
     * @post User will be prompted to enter a valid username and password, or to hit enter twice to return 
     *       to the previous screen; if user provides an invalid username or password, user will be prompted 
     *       again
     */
    public boolean validateCredentials()
    {
        String u = "";
        String p = "";

        // continue to request credentials until u and p are valid, or user hits enter twice
        while (!u.equals(user) || !p.equals(pass))
        {
            System.out.println("Admin access required. Please enter valid credentials, or hit ENTER twice to exit.\n");

            u = Input.getString("UserID   ");
            p = Input.getString("Password ");
            System.out.println();

            if (u.equals("") && p.equals(""))
                return false;
        }
        return true;
    }
}