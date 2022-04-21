import java.util.*;
import java.time.*;
import java.sql.*;
import java.text.DecimalFormat;

public class SQLMethod
{
    private String method;
    private boolean escape;

    /**
     * @brief Creates a new SQLMethod object with the given method name
     * @param methodName The name of the method to be stored
     */
    public SQLMethod(String methodName)
    {
        method = methodName;
        escape = false;
    }

    /**
     * @brief Executes the method stored in method
     * @param conn A database connection
     * @post The appropriate method will be executed
     */
    public boolean executeSQL(Connection conn)
    {
        switch(method.toLowerCase())
        {
            case "sql#1": executeSQL1(conn); break;
            case "sql#2": executeSQL2(conn); break;
            case "sql#3": executeSQL3(conn); break;
            case "sql#4": executeSQL4(conn); break;
            case "sql#5": executeSQL5(conn); break;
            case "sql#6": executeSQL6(conn); break;
            case "sql#7": executeSQL7(conn); break;
            case "sql#8": executeSQL8(conn); break;
            case "sql#9": executeSQL9(conn); break;
            case "sql#10": executeSQL10(conn); break;
            case "sql#11": executeSQL11(conn); break;
            case "sql#12": executeSQL12(conn); break;
            default: break;            
        }
        if (escape)
        {
            // reset escape back to false before returning
            escape = false;
            return true;
        }
        return false;
    }

    /**
     * @brief Executes the given query with user's parameter selection
     * @pre query must not have more than 1 parameter (?)
     * @param conn A database connection
     * @param query A query to execute
     * @param selection A value for a single parameter to use in the query; if
     *        query does not use any parameters, pass null or an empty string ""
     * @return A result set from the query
     * @post The querey will have been executed
     * @throws SQLException
     */
    private ResultSet executeSQLQuery(Connection conn, String query, String selection)
    {
        try
        {
            PreparedStatement stmt = conn.prepareStatement(query, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            ParameterMetaData pMeta = stmt.getParameterMetaData();

            int paramCount = pMeta.getParameterCount();
            if (paramCount > 0)
                stmt.setObject(1, selection);
            
            return stmt.executeQuery();
        }
        catch (SQLException e)
        {
            System.out.println("SQLException: " + e);
            return null;
        }
    }

    /**
     * @brief Formats data into readable text
     * @param result A result set containing data to format
     * @param col The column of the result set to format
     * @return A string formatted in a genaraly more readable form, mainly numbers
     * @post Strings will be return back as is, while integers will be formatted to 
     *       include thousands comma separators, and doubles containing two decimals
     */
    private String formatText(ResultSet result, int col)
    {
        try
        {
            String dataType = result.getObject(col).getClass().getSimpleName();
            String text = result.getObject(col).toString();

            switch(dataType)
            {
                case "Integer":
                case "int":
                    int i = result.getInt(col);
                    text = String.format("%,d", i);
                    break;

                case "Double":
                case "double":
                case "Float":
                case "float":
                    double d = result.getDouble(col);
                    text = String.format("%,.2f", d);
                    break;
                
                default:    // strings, dates, etc.
                    break;
            }
            return text;
        }
        catch (SQLException e)
        {
            System.out.println("SQLException: " + e);
            return null;
        }
    }

    /**
     * @brief Prints the full contents of the given result set in a sinlge column
     * @param result The result set to print
     * @post All rows and columns of the given result set will be printed in a single 
     *       column, with each row separated by a border below
     * @throws SQLException
     */
    private void printFullResultSingleColumn(ResultSet result)
    {
        try
        {
            ResultSetMetaData rMeta = result.getMetaData();
    
            // get standard width for labels
            List<String> labels = new ArrayList<String>();
            int numCols = rMeta.getColumnCount();
            for (int col = 1; col <= numCols; col++)
                labels.add(rMeta.getColumnLabel(col) + ": ");
            int labelWidth = Menu.getMaxLength(labels);

            while (result.next())
            {
                // print each row, column by column
                for (int col = 1; col <= numCols; col++)
                {
                    String value = formatText(result, col);
                    
                    // pad label on right with spaces so that all labels are labelWidth
                    String label = Menu.padTextRight(labels.get(col - 1), labelWidth);

                    String line = label + value;
                    int maxWidth = Menu.getScreenWidth();
                    if (line.length() <= maxWidth)
                        // entire line fits with screen
                        System.out.println(line);
                    else
                    {
                        // line is too long; print 1st line, then remaining lines with left padding
                        int endIndex = maxWidth;
                        String lineSeg = line;
                        while (lineSeg.length() > labelWidth)
                        {
                            System.out.println(lineSeg.substring(0, endIndex));
                            lineSeg = lineSeg.substring(endIndex, lineSeg.length());
                            lineSeg = Menu.padTextLeft(lineSeg, labelWidth + lineSeg.length());
                            endIndex = Math.min(maxWidth, lineSeg.length());
                        }
                    }
                }
                Menu.printBorder('-', 0, 0);
            }
            System.out.println();
        }
        catch (SQLException e)
        {
            System.out.println("SQLException: " + e);
        }
    }

    /**
     * @brief Prompts user to select from a list of options
     * @param options The map from which options will be chosen
     * @return The user's selection as a string
     * @post The contents of options will be printed out in a single column; user 
     *       will be  prompted to choose from  the displayed options; the value 
     *       corresponding to the key selected will be returned
     */
    private String getUserSelection(Map<String, String> options)
    {
        Menu.printOptions(options);
        System.out.println();

        // get user's selection from options
        String selection = Input.getString("Select an option", options.keySet());
        selection = options.get(selection);
        System.out.println("You selected: " + selection + "\n");
        return selection;
    }

    /**
     * @brief Returns a Map of the given column of the given result set
     * @param result A result set
     * @param column The column to create a map for
     * @return A map of containing the data in column as strings
     * @post A map of strings will be created with the data in column as values 
     *       and the enty number as keys
     * @throws SQLException
     */
    private Map<String, String> getOptionsMap(ResultSet result, int column)
    {
        try
        {
            Map<String, String> options = new LinkedHashMap<String, String>();
            int row = 1;
            while (result.next())
            {
                options.put(String.valueOf(row), result.getObject(column).toString());
                row++;
            }
            return options;
        }
        catch (SQLException e)
        {
            System.out.println("SQLException: " + e);
            return null;
        }
    }

    /**
     * @brief Displays detailed information about a user selected treatment facility
     * @param conn A database connection
     * @post A complete list of treatment facilities in the database will be printed out to the screen 
     *       and user will be prompted to select one. All details about the selected facility will be 
     *       printed to the screen
     */
    private void executeSQL1(Connection conn)
    {
        String q1 = "select * from facility order by facility_id asc";
        ResultSet result = executeSQLQuery(conn, q1, null);
        String selection = getUserSelection(getOptionsMap(result, 2));

        String q2 = "select * from facility where facility_name = \"" + selection + "\"";
        result = executeSQLQuery(conn, q2, selection);
        printFullResultSingleColumn(result);
    }

    /**
     * @brief Displays detailed information about a user selected water source
     * @param conn A database connection
     * @post A complete list of water sources in the database will be printed out to the screen 
     *       and user will be prompted to select one. From the user's selection, 2 sets of information 
     *       will be printed to the screen: 1) a list of all the types of treatments the water source 
     *       has received in the past, followed by 2) a list of all the treatments the water source 
     *       is required to receive based on imposed water regulations
     */
    private void executeSQL2(Connection conn)
    {
        String q1 = "select * from water_source order by water_source_id asc";
        ResultSet result = executeSQLQuery(conn, q1, null);
        String selection = getUserSelection(getOptionsMap(result, 2));

        String q2 = "SELECT DISTINCT t.Treatment_Number, t.Treatment_Description " +
                    "FROM Water_Source AS w " +
                    "JOIN Treatments_Performed AS tp ON w.Water_Source_ID = tp.Water_Source_ID " +
                    "JOIN Treatment AS t ON tp.Treatment_Number = t.Treatment_Number "+
                    "WHERE w.Location = ? " +
                    "ORDER BY t.Treatment_Number ASC;";

        result = executeSQLQuery(conn, q2, selection);
        System.out.println("LIST OF TREATMENTS RECEIVED BY " + selection + "\n");
        printFullResultSingleColumn(result);

        String q3 = "SELECT DISTINCT t.Treatment_Number, t.Treatment_Description " +
                    "FROM Water_Source AS w " +
                    "JOIN Water_Source_Has_Regulation AS wr ON w.Water_Source_ID = wr.Water_Source_ID " +
                    "JOIN Regulation AS r ON wr.Regulation_ID = r.Regulation_ID "+
                    "JOIN Treatment_Has_Regulation AS tr ON r.Regulation_ID = tr.Regulation_ID " +
                    "JOIN Treatment As t ON tr.Treatment_Number = t.Treatment_Number " +
                    "WHERE w.Location = ? " +
                    "ORDER BY t.Treatment_Number ASC";

        result = executeSQLQuery(conn, q3, selection);
        System.out.println("LIST OF REGULATION MANDATED TREATMENTS FOR " + selection + "\n");
        printFullResultSingleColumn(result);
    }

    /**
     * @brief Prints detailed info about a specific Water Treatment Regulation
     * @param conn A database connection
     * @post A list of regulations will be displayed to the screen; user will 
     *       be prompted to select an option, for which detailed information 
     *       will be printed
     */
    private void executeSQL3(Connection conn)
    {
        String column = "Regulation_Name";
        String table = "Regulation";

        // print all values from the given table column for user to select from
        String q1 = "SELECT " + column + " FROM " + table + ";";
        ResultSet result = executeSQLQuery(conn, q1, null);
        String selection = getUserSelection(getOptionsMap(result, 1));

        // retrieve the details from user's selection
        String q2 = "SELECT * FROM " + table + " WHERE " + column + " = ?;";
        result = executeSQLQuery(conn, q2, selection);

        // display final results of query
        printFullResultSingleColumn(result);
    }

    /**
     * @brief Prints the list of treatments that the water source selected needs and the list of
     * treatments it received
     * @param conn A database connection
     * @throws SQLException
     */
    private void executeSQL4(Connection conn)
    {
        sql4: try {
            //Step1: Allow users to choose from a list of regulated water sources
            String query1 = "SELECT * FROM Water_Source " +
                    "WHERE Water_Source_ID IN (SELECT DISTINCT Water_Source_ID FROM Water_Source_Has_Regulation) " +
                    "ORDER BY Water_Source_ID ASC";
            ResultSet waterSourceWithRegulations = executeSQLQuery(conn, query1, "");

            System.out.println("The following water sources are regulated. Please select one to view compliance: ");
            String userLocationSelection = getUserSelection(getOptionsMap(waterSourceWithRegulations, 2));

            //Step 2: Find the treatment numbers that the source is required to have
            String query2 = "SELECT DISTINCT Treatment_Number FROM Treatment_Has_Regulation WHERE Regulation_ID IN " +
                    "(SELECT Regulation_ID FROM Water_Source_Has_Regulation WHERE Water_Source_ID = " +
                    "(SELECT Water_Source_ID FROM Water_Source WHERE Location = '" +
                    userLocationSelection + "')) ORDER BY Treatment_Number";
            ResultSet treatmentsRequired = executeSQLQuery(conn, query2, "");
            if(!treatmentsRequired.isBeforeFirst()) {
                System.out.print("The Water Source does not have any associated regulations.");
                break sql4;
            }
            System.out.print("The Water Source selected requires Treatment ID# ");
            int numTreatmentsRequired = 0;
            while (treatmentsRequired.next()){
                System.out.print(" " + treatmentsRequired.getInt(1));
                numTreatmentsRequired++;
            }
            System.out.println();

//            String query3 = "SELECT Treatment_Number, Date_Treated FROM Treatments_Performed " +
//                    "WHERE Water_Source_ID = " +
//                    "(SELECT Water_Source_ID FROM Water_Source WHERE Location = '" +
//                    userLocationSelection + "') AND Date_Treated >= (curdate() - 183)";
            String query3 = "SELECT Treatment_Number, Date_Treated FROM Treatments_Performed " +
                    "WHERE Water_Source_ID = " +
                    "(SELECT Water_Source_ID FROM Water_Source WHERE Location = '" +
                    userLocationSelection + "') AND Date_Treated >= DATE_SUB(NOW(),INTERVAL 183 DAY)";
            ResultSet treatmentsReceived = executeSQLQuery(conn, query3, "");
            int numTreatmentsReceived = 0;
            if (!treatmentsReceived.isBeforeFirst()) {
                System.out.println("This water source received no treatment within the last 6 months");
            } else {
                System.out.println("Within the last 6 months...");
                while (treatmentsReceived.next()){
                    System.out.println("Treatment ID # " + treatmentsReceived.getInt(1) +
                            " was performed on " + treatmentsReceived.getDate(2));
                    numTreatmentsReceived++;
                }
            }
            if (numTreatmentsReceived < numTreatmentsRequired){
                System.out.println("SUMMARY: This water source DOES NOT meet regulations. Only " +
                        numTreatmentsReceived + " out of the " + numTreatmentsRequired +
                        " required treatments were administered.");
            } else {
                System.out.println("SUMMARY: This water source DOES meet regulations. " +
                        numTreatmentsReceived + " out of " + numTreatmentsRequired +
                        " required treatments were successfully administered.");
            }
            Menu.printBorder('-', 0, 1);
        } catch (SQLException e)
        {
            System.out.println("SQLException: " + e);
        }
    }

    /**
     * @brief Displays the average water consumption and average water wasted per month for 
     *        the given business type
     * @param conn A database connection
     * @param businessType The type of business to display data for
     * @post The average water consumption per month and average water wasted per month for 
     *       all businesses in the given business type will be printed on the screen; values 
     *       will be displayed in millions of gallons 
     * @throws SQLException
     */
    private void executeSQL56(Connection conn, String businessType)
    {
        try
        {   
            java.sql.Date maxDateDefault = java.sql.Date.valueOf("2021-12-31"); //latest max date default
            java.sql.Date minDate = java.sql.Date.valueOf("2021-12-31"); // oldest date that values have been reported
            String date = "";
            String query1 = "SELECT Usage_Record_Date " +
                            "FROM Business as b JOIN Business_Used as u ON b.Business_ID = u.Business_ID " + 
                            "WHERE Business_Type = '" + businessType + "'";
            ResultSet resultSet1 = executeSQLQuery(conn, query1, "");

            while (resultSet1.next())
            {
                java.sql.Date reportDate = resultSet1.getDate(1); //date that values have been reported
                if (reportDate.compareTo(minDate) < 0)
                    minDate = reportDate;
            }
            
            boolean inValidFormat = true;
            boolean inValidMonth = true;
            boolean inValidDate = true;

            
            while (inValidFormat || inValidMonth || inValidDate) 
            {
                System.out.println("Please choose date from 2020-10 to 2021-12");
                date = Input.getString("Enter the year and month you want to see the report following the format (YYYY-MM)");
                
                // check valid format
                if (date.length() == 7 && date.charAt(4) == '-') {
                    inValidFormat = false;
                } else {
                    System.out.println("The date input does not follow the format. Please try again.\n");
                    continue; 
                }

                //check the month if it's in the range (1-12)
                if (Integer.parseInt(date.substring(5)) < 1 || Integer.parseInt(date.substring(5)) > 12) {
                    System.out.println("The month input is not valid. Please try again.\n");
                    continue; 
                } else { 
                    inValidMonth = false;
                }

                java.sql.Date userDate = java.sql.Date.valueOf(date + "-24");
                // check if the date is valid in the report 
                if (userDate.compareTo(minDate) < 0 || userDate.compareTo(maxDateDefault) > 0) 
                    System.out.println("Data is only available between " + minDate.toString() + " and " + maxDateDefault + "\n");
                else 
                    inValidDate = false;
            }

            String query2 = "SELECT Amount_Water_Consumed, Amount_Water_Wasted " +
                            "FROM Business as b JOIN Business_Used as u ON b.Business_ID = u.Business_ID " + 
                            "WHERE Business_Type = '" + businessType + "' AND Usage_Record_Date LIKE ? ";
            ResultSet resultSet = executeSQLQuery(conn, query2, date + "%");

            double totalConsumed = 0;
            double totalWasted = 0;

            while (resultSet.next())
            {
                double valConsumed = resultSet.getDouble(1);
                totalConsumed += valConsumed;
                double valWasted = resultSet.getDouble(2);
                totalWasted += valWasted;
            }

            List<String> labels = new ArrayList<String>();
            labels.add("Total amount of water consumed by " + businessType + " Businesses in millions of gallons: ");
            labels.add("Total amount of water wasted by " + businessType + " Businesses in millions of gallons: ");
            
            int labelWidth = Menu.getMaxLength(labels);

            System.out.println(Menu.padTextRight(labels.get(0), labelWidth) + String.format("%.3f", totalConsumed/1_000_000));
            System.out.println(Menu.padTextRight(labels.get(1), labelWidth) + String.format("%.3f", totalWasted/1_000_000));
            Menu.printBorder('-', 0, 1);
        }
        catch (SQLException e)
        {
            System.out.println("SQLException: " + e);
        }
    }

    /**
     * @brief Displays the average water consumption and average water wasted per month for Industrial businesses
     * @param conn A database connection
     */
    private void executeSQL5(Connection conn)
    {
        executeSQL56(conn, "Industrial");
    }
    
    /**
     * @brief Displays the average water consumption and average water wasted per month for Agricultural businesses 
     * @param conn A database connection
     */
    private void executeSQL6(Connection conn)
    {
        executeSQL56(conn, "Agricultural");
    }

    /**
     * @brief Report the average amount of water consumed and wasted per month by both agricultural and industrial
     * businesses, as well as the amount of water that will need treatment.
     * @param conn A database connection
     * @post A report will be printed to terminal
     * @throws SQLException
     */
    private void executeSQL7(Connection conn)
    {
        try {
            String query = "select Amount_Water_Consumed, Amount_Water_Wasted, Usage_Record_Date " +
                    "from Business_Used where Usage_Record_Date >= DATE_SUB(NOW(),INTERVAL 2 YEAR) " +
                    "order by year(Usage_Record_Date), month(Usage_Record_Date)";
            ResultSet resultSet = executeSQLQuery(conn, query, "");

            // Create an ArrayList object where the keys are a string representing YYYY-MM and
            // the value is a 4-element array representing
            // [numBusinessesConsideredInAverageCalculation, AvgAmountConsumed, AvgAmountWasted, TotalNeedingTreatment]
            // that will make up individual rows of the report
            Map <String, double[]> report = new TreeMap<>();

            //process data to calculate the average water consumption and average water wasted for all businesses
            //int numRecords = 0; // numRecords = sum(numMonthlyRecords/business)
            while (resultSet.next()) { //for each result tuple
                LocalDate date = (resultSet.getDate(3)).toLocalDate();
                String key = date.getYear() + "-";
                if (date.getMonthValue() < 10) {
                    key += "0";
                }
                key += date.getMonthValue();
                double waterConsumed = resultSet.getDouble(1)/Math.pow(10,6);
                double waterWasted = resultSet.getDouble(2)/Math.pow(10,6);
                double waterNeedsTreatment = waterConsumed + waterWasted;
                double[] thisRecord = {1.0, waterConsumed, waterWasted, waterNeedsTreatment};
                //if key-value pair does exist
                if (report.containsKey(key)) {
                    double[] oldRecord = report.get(key);
                    double[] newRecord = new double[4];
                    for (int i = 0; i < 4; i++) {
                        newRecord[i] = oldRecord[i] + thisRecord[i];
                    }
                    report.put(key, newRecord);
                } else {
                    report.put(key, thisRecord);
                }
            }

            System.out.println("AVERAGE WATER USAGE BY BOTH AGRICULTURAL AND INDUSTRIAL BUSINESSES IN THE PAST TWO YEARS");
            System.out.println("Note 1: Water amounts are reported in millions of gallons (MG)");
            System.out.println("Note 2: The 'Num. Records' column represents the number of records " +
                    "used in the average calculations.");
            Menu.printBorder('-', 0, 0);
            DecimalFormat numFormat = new DecimalFormat("#.00");
            final Object[][] table = new String[report.size() + 1][];
            table[0] = new String[] { "Year-Month", "Num. Records", "Amt. Consumed (MG)", "Amt. Wasted (MG)",
                    "Amt. Needing Treatment (MG)" };
            int numRows = 1;
            for (String thisKey: report.keySet()) {
                double[] thisRecord = report.get(thisKey);
                table[numRows] = new String[]{thisKey, numFormat.format(thisRecord[0]), numFormat.format(thisRecord[1]),
                        numFormat.format(thisRecord[2]), numFormat.format(thisRecord[3])};
                numRows++;
            }
            for (final Object[] row : table) {
                System.out.format("%-20s%-20s%-20s%-20s%-20s%n", row);
            }
            Menu.printBorder('-', 0, 1);
        } catch (SQLException e)
        {
            System.out.println("SQLException: " + e);
        }
    }

    /**
     * @brief Executes a user defined update to the database
     * @param conn A database connection
     * @param column A table column
     * @param table A databse table
     * @post A list of options (rows) from the given table and column will be printed to 
     *       the screen; user will be prompted to make a selection from those options; 
     *       a detailed list of the selected row's current column values will be printed 
     *       to the screen, followed by a list of the column names of the table; user will 
     *       be prompted to select from those columns; finally user will be prompted to 
     *       enter a new value for the selected column; if a valid entry, the database 
     *       row and column will be updated
     * @throws SQLException
     */
    private void executeSQLUpdate(Connection conn, String column, String table)
    {
        try
        {
            String backLabel = "B";
            String backValue = "Back to Menu";

            // print all values from the given table column for user to select from
            String q1 = "SELECT " + column + " FROM " + table + ";";
            ResultSet result = executeSQLQuery(conn, q1, null);
            Map<String, String> options = getOptionsMap(result, 1);

            // add back as an option; if back is selected, exit method
            options.put(backLabel, backValue);
            String selection = getUserSelection(options);

            if (!selection.equalsIgnoreCase(backValue))
            {
                // retrieve the details from user's selection
                String q2 = "SELECT * FROM " + table + " WHERE " + column + " = ?;";
                result = executeSQLQuery(conn, q2, selection);

                // display final results of query
                printFullResultSingleColumn(result);

                // get column names to display for user
                // add back as an option; if back is selected, exit method
                Map<String, String> columns = getColumnList(conn.getMetaData(), table);
                columns.put(backLabel, backValue);
                String targetRow = selection;
                String targetCol = getUserSelection(columns);

                if (!targetCol.equalsIgnoreCase(backValue))
                {
                    String targetVal = Input.getString("Enter a new value for " + targetCol);

                    // prepare update statement and execute
                    String update = "UPDATE " + table + " SET " + targetCol + " = ? WHERE " + column + " = ?;";
                    PreparedStatement stmt = conn.prepareStatement(update);
                    stmt.setObject(1, targetVal);
                    stmt.setObject(2, targetRow);
                    stmt.executeUpdate();

                    System.out.println();
                    System.out.println(targetCol + " for " + targetRow + " has been successfully updated.");
                    Menu.printBorder('-', 0, 1);
                }
                else
                    escape = true;
            }
            else
                escape = true;
        }
        catch (SQLException e)
        {
            System.out.println("SQLException: " + e);
        }
    }
    
    /**
     * @brief Provides a user interface for updating the database's Facilty table
     * @param conn A database connection
     */
    private void executeSQL8(Connection conn)
    {
        executeSQLUpdate(conn, "Facility_Name", "Facility");
    }
    
    /**
     * @brief Provides a user interface for updating the database's Water_Source table
     * @param conn A database connection
     */
    private void executeSQL9(Connection conn)
    {
        executeSQLUpdate(conn, "Location", "Water_Source");
    }
    
    /**
     * @brief Provides a user interface for updating the database's Business table
     * @param conn A database connection
     */
    private void executeSQL10(Connection conn)
    {
        executeSQLUpdate(conn, "Business_Name", "Business");
    }
    
    /**
     * @brief Provides a user interface for updating the database's Regulation table
     * @param conn A database connection
     */
    private void executeSQL11(Connection conn)
    {
        executeSQLUpdate(conn, "Regulation_Name", "Regulation");
    }

    /**
     * @brief Report the total number of industrial and agricultural
     * businesses opened every quarter in the last two years grouped by business type.
     * @param conn A database connection
     * @post A report will be printed to terminal
     * @throws SQLException
     */
    private void executeSQL12(Connection conn)
    {
        try
        {
            //Step 1: Query all businesses opened in the last two years
            String query = "select Business_Type, Start_Date " +
                    "from Business " +
                    "where Start_Date >= DATE_SUB(NOW(),INTERVAL 2 YEAR) " +
                    "order by Start_Date asc";

            ResultSet resultSet = executeSQLQuery(conn, query, "");

            //Step 2a: Parse and put data into tree maps.
            // Key : value pairs indicate Year-Quarter and number of businesses
            Map<String, Integer> industrial = new TreeMap<String, Integer>();
            Map<String, Integer> agricultural = new TreeMap<String, Integer>();
            String key;

            int count = 0;
            boolean firstDate = true; //
            int firstYear = 0;
            while (resultSet.next()) { //for each result tuple
                //construct a key based on date and month
                LocalDate date = (resultSet.getDate(2)).toLocalDate();
                int year = date.getYear();
                if (firstDate) {
                    firstYear = year;
                    firstDate = false;
                }
                int month = date.getMonthValue();
                int quarter = (int) Math.ceil(month / 3.0);
                key = String.valueOf(year) + "-Q" + String.valueOf(quarter);
                count = count + 1;

                if ((resultSet.getString(1)).equals("Industrial")){
                    if (industrial.containsKey(key)){
                        industrial.put(key, industrial.get(key) + 1);
                    } else {
                        industrial.put(key, 1);
                    }
                } else if ((resultSet.getString(1)).equals("Agricultural")){
                    if (agricultural.containsKey(key)){
                        agricultural.put(key, agricultural.get(key) + 1);
                    } else {
                        agricultural.put(key, 1);
                    }
                }
            }

            //Step 2b: add empty keys representing quarters with no businesses opened
            for (int i = firstYear; i <= Calendar.getInstance().get(Calendar.YEAR); i++) {
                for (int quarter = 1; quarter <= 4; quarter++){
                    String mapKey = String.valueOf(i) + "-Q" + String.valueOf(quarter);
                    if (!agricultural.containsKey(mapKey)){
                        agricultural.put(mapKey, 0);
                    }
                    if (!industrial.containsKey(mapKey)){
                        industrial.put(mapKey, 0);
                    }
                }
            }

            //Step 3: print data from tree maps
            System.out.println("NUMBER OF NEW BUSINESSES OPENED EVERY QUARTER IN THE PAST TWO YEARS");
            System.out.println("Q1 = Jan. - Mar.; Q2 = Apr. - Jun.; Q3 = Jul. - Sep.; Q4 = Oct. - Dec.");
            Menu.printBorder('-', 0, 0);
            final Object[][] table = new String[industrial.size() + 1][];
            table[0] = new String[] { "Year-Quarter", "Industrial", "Agricultural" };
            int numRows = 1;
            for (String thisKey: industrial.keySet()) {
                table[numRows] = new String[]{thisKey, String.valueOf(industrial.get(thisKey)),
                        String.valueOf(agricultural.get(thisKey))};
                numRows++;
            }
            for (final Object[] row : table) {
                System.out.format("%-15s%-15s%-15s%n", row);
            }
            Menu.printBorder('-', 0, 1);
        }
        catch (SQLException e)
        {
            System.out.println("SQLException: " + e);
        }
    }

    /**
     * @brief Creates a map containing the column names of the given table
     * @param meta A DatabaseMetaData object
     * @param table A database table name
     * @return A map containing the column names of the given database table
     * @post A map will be created with values containing the column names of
     *       the specified table as strings, and keys containing the column numbers, 
     *       also as strings
     * @throws SQLException
     */
    private Map<String, String> getColumnList(DatabaseMetaData meta, String table)
    {
        try
        {
            Map<String, String> columns = new LinkedHashMap<String, String>();
            ResultSet result = meta.getColumns(null, null, table, null);
            int i = 1;
            while (result.next())
                columns.put(String.valueOf(i++), result.getString("COLUMN_NAME"));
            return columns;
        }
        catch (SQLException e)
        {
            System.out.println("SQLException: " + e);
            return null;
        }
    }
}
