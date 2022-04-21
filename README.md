# DSS for Washington's Water Treatment Facilities


## TABLE OF CONTENTS

* Introduction
* Requirements
* Configuration
* Usage
* Contributors


## INTRODUCTION

This DSS (Decision Support System) is intended to provide the Washington State government with a tool to aid
in decision making related to water resource management and investment. The database stores information related to
Washington's local water sources, the businesses who use them, treatment facilities that provide services to them,
water quality standards/regulations, and public investments (past and future) in water treatment operations.

This DSS provides an interface to that database, as well as the ability (with the appropriate access) to add, remove,
and/or modify the data contained within.

[Youtube video demo](https://youtu.be/lxFntJuIt-s)


## REQUIREMENTS

To use this DSS, a connection to a MySQL server is required.


## CONFIGURATION

Prior to running the file Main.java, the following steps must be taken:

#### 1. Include the JDBC Driver file in Classpath

Open the folder containing the source code in your IDE of choice and follow the appropriate steps
for your IDE to include the MySQL connector jar file in the classpath of the project.


#### 2. Edit the Main.java file

Line 7:  Enter the applicable hostname for the MySQL database connection
Line 8:  Enter the applicable port number for the MySQL database connection
Line 11: Enter the applicable username for the MySQL database connection
Line 12: Enter the applicable password for the MySQL database connection


#### 3. Create the MySQL Database

In MySQL workbench, import the SQL file water_treatment2.sql (included with the source code) 
and run the script. This will create the database and load data for the DSS to operate on.


## USAGE

After completing the steps listed in the configuration above, run the file Main.java.

#### DSS Modules:

#### Water Sources, Treatments & Regulations

Provides information related to the current activities of treatment facilities and water sources;
and past and present water treatment regulations; and the compliance status of each water source 
with those regulations.


#### Businesses
Provides information about Washington businesses and their water usage history. Businesses are
classified as either Agricultural or Industrial.


#### Statistics & Data Analysis
This module in the DSS is under construction, and not available.


#### Updates
Provides users (with administrative rights) to add, remove, and/or modify data in the database.


## CONTRIBUTORS

* Hieu Do
* David Harmon
* Giang Ngo
* Joe Prado