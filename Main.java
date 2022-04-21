public class Main
{
    public static void main(String[] args)
    {
        // adjust variabels values as needed
        String menus  = "Menus.txt";
        String host   = "localhost";
        String port   = "3306";
        String schema = "water_treatment2";
        String param  = "?serverTimezone=UTC&useSSL=TRUE";
        String user   = "";
        String pass   = "";

        user = user != "" ? user : Input.getString("UserId  ");
        pass = pass != "" ? pass : Input.getString("Password");

        MySQLConnection mySQL = new MySQLConnection(host, port, schema, param, user, pass);
        if (mySQL.isConnected())
        {
            Navigation nav = new Navigation(mySQL, menus);
            nav.navigate();
        }
    }
}