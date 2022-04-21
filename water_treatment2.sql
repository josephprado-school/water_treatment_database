-- 12/12/21

drop schema if exists water_treatment2;
create schema if not exists water_treatment2;
use water_treatment2;

create table if not exists Facility
(
	Facility_ID int not null primary key,
    Facility_Name VARCHAR(60) not null,
    Address VARCHAR(100) not null,
    Contact_Name VARCHAR(45) not null,
    Contact_Phone VARCHAR(15) not null,
    Quantity double
);

create table if not exists Water_Source
(
	Water_Source_ID int not null primary key,
    Location varchar(100) not null,
    Water_Quality varchar(45) not null
);

create table if not exists Business
(
	Business_ID int primary key,
    Business_Type varchar(45) not null,
    Business_Name varchar(45) not null,
    Business_Address varchar(100) not null,
    Contact_Name varchar(45) not null,
    Start_Date date not null
);

create table if not exists Business_Used
(
	Business_ID int not null,
    Water_Source_ID int not null,
    Usage_Record_Date date not null,
    Amount_Water_Consumed double not null,
    Amount_Water_Wasted double not null,
    primary key (Business_ID, Water_Source_ID, Usage_Record_Date),
    foreign key (Business_ID) references Business (Business_ID)
    on delete cascade on update cascade,
    foreign key (Water_Source_ID) references Water_Source (Water_Source_ID)
    on delete cascade on update cascade
);

create table if not exists Treatment
(
	Treatment_Number int primary key,
    Treatment_Description longtext not null
);

create table if not exists Treatments_Performed
(
	Facility_ID int not null,
    Water_Source_ID int not null,
    Treatment_Number int not null,
    Date_Treated date not null,
    Quantity_Treated double not null,
    Treatment_Description longtext not null,
    primary key(Facility_ID, Water_Source_ID, Treatment_Number, Date_Treated),
    foreign key (Facility_ID) references Facility (Facility_ID)
    on delete restrict on update cascade,
    foreign key (Water_Source_ID) references Water_Source (Water_Source_ID)
    on delete restrict on update cascade,
    foreign key (Treatment_Number) references Treatment (Treatment_Number)
    on delete restrict on update cascade
);

create table if not exists Regulation
(
	Regulation_ID int primary key,
    Regulation_Name varchar(200) not null,
    Approval_Date date not null,
    Regulation_Description longtext not null
);

create table if not exists Water_Source_Has_Regulation
(
	Water_Source_ID int not null,
    Regulation_ID int not null,
    primary key (Water_Source_ID, Regulation_ID),
    foreign key (Water_Source_ID) references Water_Source (Water_Source_ID)
    on delete cascade on update cascade,
    foreign key (Regulation_ID) references Regulation (Regulation_ID)
    on delete cascade on update cascade
);

create table if not exists Treatment_Has_Regulation
(
	Treatment_Number int not null,
    Regulation_ID int not null,
    primary key (Treatment_Number, Regulation_ID),
    foreign key (Treatment_Number) references Treatment (Treatment_Number)
    on delete restrict on update cascade,
    foreign key (Regulation_ID) references Regulation (Regulation_ID)
    on delete cascade on update cascade
);

create table if not exists Investment
(
	Investment_ID int primary key,
    Facility_ID int not null,
    Capital_Cost double,
    Operating_Cost double,
    Maintenance_Cost double,
    Expected_Improvement double not null,
    foreign key (Facility_ID) references Facility (Facility_ID)
    on delete cascade on update cascade
);

INSERT INTO Water_Source VALUES (1, 'Columbia River', 'Substandard');
INSERT INTO Water_Source VALUES (2, 'Cowlitz River', 'Good');
INSERT INTO Water_Source VALUES (3, 'Entiat River', 'Extraordinary');
INSERT INTO Water_Source VALUES (4, 'Franklin D. Roosevelt Lake', 'Good');
INSERT INTO Water_Source VALUES (5, 'Hangman Creek', 'Good');
INSERT INTO Water_Source VALUES (6, 'Klicktat River', 'Fair');
INSERT INTO Water_Source VALUES (7, 'Lake Chelan', 'Good');
INSERT INTO Water_Source VALUES (8, 'Lake Crescent', 'Good');
INSERT INTO Water_Source VALUES (9, 'Lake Sacajawea', 'Extraordinary');
INSERT INTO Water_Source VALUES (10, 'Lake Wallula', 'Excellent');
INSERT INTO Water_Source VALUES (11, 'Lake Washington', 'Good');
INSERT INTO Water_Source VALUES (12, 'Lewis River', 'Good');
INSERT INTO Water_Source VALUES (13, 'Lower Crab Creek', 'Substandard');
INSERT INTO Water_Source VALUES (14, 'Methow River', 'Toxic');
INSERT INTO Water_Source VALUES (15, 'Moses Lake', 'Good');
INSERT INTO Water_Source VALUES (16, 'Naches River', 'Excellent');
INSERT INTO Water_Source VALUES (17, 'Nisqually River', 'Good');
INSERT INTO Water_Source VALUES (18, 'Nooksack River', 'Good');
INSERT INTO Water_Source VALUES (19, 'Okanongan River', 'Substandard');
INSERT INTO Water_Source VALUES (20, 'Ozette Lake', 'Toxic');
INSERT INTO Water_Source VALUES (21, 'Palouse River', 'Extraordinary');
INSERT INTO Water_Source VALUES (22, 'Pend Oreille River', 'Good');
INSERT INTO Water_Source VALUES (23, 'Potholes Reservoir and Ross Lake', 'Good');
INSERT INTO Water_Source VALUES (24, 'Puyallup River', 'Good');
INSERT INTO Water_Source VALUES (25, 'Quinault River', 'Substandard');
INSERT INTO Water_Source VALUES (26, 'Rock Creek', 'Good');
INSERT INTO Water_Source VALUES (27, 'Sanpoil River', 'Extraordinary');
INSERT INTO Water_Source VALUES (28, 'Skagit River', 'Good');
INSERT INTO Water_Source VALUES (29, 'Skykomish River', 'Good');
INSERT INTO Water_Source VALUES (30, 'Snake River', 'Fair');
INSERT INTO Water_Source VALUES (31, 'Spokane River', 'Good');
INSERT INTO Water_Source VALUES (32, 'Toppenish Creek', 'Toxic');
INSERT INTO Water_Source VALUES (33, 'Touchet River', 'Extraordinary');
INSERT INTO Water_Source VALUES (34, 'Tucannon River', 'Good');
INSERT INTO Water_Source VALUES (35, 'Union Flat Creek', 'Good');
INSERT INTO Water_Source VALUES (36, 'Wenatchee River and Yakima River.', 'Fair');

INSERT INTO Facility VALUES (1, 'Columbia River Treatment Plant', '437 E. Bishop Street, Columbia, WA 17036', 'Kara Curran', '206-477-5371', 3439228.5);
INSERT INTO Facility VALUES (2, 'Cowlitz River Treatment Plant', '54 North Peachtree Drive, Cowlitz, WA 20191', 'Dion Henson', '206-263-9465', 687982.166666667);
INSERT INTO Facility VALUES (3, 'Entiat River Treatment Plant', '11 Sulphur Springs Street, Entiat, WA 33020', 'Emillie Truong', '206-463-7318 ', 137554.533333333);
INSERT INTO Facility VALUES (4, 'Franklin D. Roosevelt Lake Treatment Facility', '7127 St Margarets Ave., Franklin, WA 01902', 'Lynden Povey', '206-263-1810', 1375454);
INSERT INTO Facility VALUES (5, 'Hangman Creek Treatment Plant', '944 Helen Court, Hangman, WA 48174', 'Brandon-Lee Connor', '206-263-1760 ', 275168);
INSERT INTO Facility VALUES (6, 'Klicktat River Treatment Plant', '9347 Cooper St., Klicktat, WA 08087', 'Ananya Fox', '509-575-6077', 1697869.23333333);
INSERT INTO Facility VALUES (7, 'Lake Chelan Treatment Facility', '8589 Richardson Street, Lake, WA 45140', 'Ace Jensen', '253-223-8111', 3378414.8);
INSERT INTO Facility VALUES (8, 'Lake Crescent Treatment Facility', '157 Trusel Dr., Lake, WA 30240', 'Isabella Moody', '206-619-6074', 2751476.53333333);
INSERT INTO Facility VALUES (9, 'Lake Sacajawea Treatment Facility', '8203 Ridgewood St., Lake, WA 46614', 'Ali Campbell', '253-236-7972', 3378396.26666667);
INSERT INTO Facility VALUES (10, 'Lake Wallula Treatment Plant', '8842 Trout Street, Lake, WA 19053', 'Juliana Alvarado', '425-446-5309', 1417843.63333333);
INSERT INTO Facility VALUES (11, 'Lake Washington Treatment Facility', '960 Highland St., Lake, WA 30134', 'Clayton Chaney', '509-887-1688', 6790891.73333333);
INSERT INTO Facility VALUES (12, 'Lewis River Treatment Plant', '7541 Orange St., Lewis, WA 10550', 'Lily Kim', '360-312-8963', 1201298.76666667);
INSERT INTO Facility VALUES (13, 'Lower Crab Creek Treatment Facility', '7092 West Kingston Rd., Lower, WA 44004', 'Teagan Nicholson', '509-670-9519', 8489919.83333333);
INSERT INTO Facility VALUES (14, 'Methow River Treatment Facility', '164 N. Augusta Ave., Methow, WA 08807', 'Ryleigh Kline', '360-785-8173', 3603817.3);
INSERT INTO Facility VALUES (15, 'Moses Lake Treatment Plant', '820 Canal Rd., Moses, WA 48035', 'Carsen Stevenson', '206-585-1227', 1375415.13333333);
INSERT INTO Facility VALUES (16, 'Naches River Treatment Facility', '987 Lake View St., Naches, WA 02446', 'Lea Sheppard', '206-278-3020', 3438836.66666667);
INSERT INTO Facility VALUES (17, 'Nisqually River Treatment Facility', '7449 Cobblestone Drive, Nisqually, WA 30518', 'Jakayla Mata', '360-943-9025', 1201300.83333333);
INSERT INTO Facility VALUES (18, 'Nooksack River Treatment Plant', '611 Thompson Street, Nooksack, WA 30263', 'Garrett Pace', '509-691-4356', 8489059.33333333);
INSERT INTO Facility VALUES (19, 'Okanongan River Treatment Facility', '9 Glenridge Ave., Okanongan, WA 30736', 'Jazmin Pierce', '360-822-9347', 3603934.7);
INSERT INTO Facility VALUES (20, 'Ozette Lake Treatment Plant', '8635 Winchester Street, Ozette, WA 28303', 'John Mason', '206-351-2012', 3438668.66666667);
INSERT INTO Facility VALUES (21, 'Palouse River Treatment Plant', '18 North Gates St., Palouse, WA 07753', 'Holly Nash', '509-261-6315', 8489385.83333333);
INSERT INTO Facility VALUES (22, 'Pend Oreille River Treatment Facility', '164 Bear Hill St., Pend, WA 02151', 'Araceli Horton', '206-450-4985', 687832.833333333);
INSERT INTO Facility VALUES (23, 'Potholes Reservoir and Ross Lake Treatment Plant', '306 Cobblestone Dr., Potholes, WA 32958', 'Jeffery Glenn', '360-537-2135', 4804284.66666667);
INSERT INTO Facility VALUES (24, 'Puyallup River Treatment Facility', '3 Selby Street, Puyallup, WA 59901', 'Bradyn Osborne', '425-622-2551', 1417751.7);
INSERT INTO Facility VALUES (25, 'Quinault River Treatment Plant', '5 Acacia St., Quinault, WA 08861', 'Ayla Flynn', '360-272-6870', 4804916);
INSERT INTO Facility VALUES (26, 'Rock Creek Treatment Facility', '761 North Bowman Lane, Rock, WA 83651', 'Conor Lynch', '253-358-1361', 4221893.5);
INSERT INTO Facility VALUES (27, 'Sanpoil River Treatment Plant', '69 Cross Lane, Sanpoil, WA 55104', 'Robert Chambers', '360-216-6198', 2402413.2);
INSERT INTO Facility VALUES (28, 'Skagit River Treatment Facility', '936 Pumpkin Hill Dr., Skagit, WA 85224', 'Boston Galloway', '360-730-1118', 2402074.53333333);
INSERT INTO Facility VALUES (29, 'Skykomish River Treatment Facility', '10 Santa Clara St., Skykomish, WA 33030', 'Reuben Aguirre', '425-298-4339', 4253433.9);
INSERT INTO Facility VALUES (30, 'Snake River Treatment Facility', '7416 Beach Ave., Snake, WA 32714', 'Miracle Gentry', '509-759-3245', 6791099.33333333);
INSERT INTO Facility VALUES (31, 'Spokane River Treatment Plant', '438 Oakland St., Spokane, WA 23434', 'Leah Norton', '509-285-3705', 1697790.16666667);
INSERT INTO Facility VALUES (32, 'Toppenish Creek Treatment Plant', '7762 Cemetery St., Toppenish, WA 07039', 'Bryan Chen', '360-485-3570', 2402238);
INSERT INTO Facility VALUES (33, 'Touchet River Treatment Plant', '601 Pierce Ave., Touchet, WA 22405', 'Jada Shah', '206-528-4505', 2063450.5);
INSERT INTO Facility VALUES (34, 'Tucannon River Treatment Plant', '7559 Fawn Ave., Tucannon, WA 30236', 'Cruz Diaz', '360-846-8774', 2402584.93333333);
INSERT INTO Facility VALUES (35, 'Union Flat Creek Treatment Facility', '901 Tarkiln Hill St., Union, WA 44139', 'Felipe Kane', '206-604-8630', 2063863);
INSERT INTO Facility VALUES (36, 'Wenatchee River and Yakima River. Treatment Plant', '8527 North Trout Ave., Wenatchee, WA 14043', 'Alaina Le', '425-891-7582', 5671677.6);

INSERT INTO Treatment VALUES (1, 'DISINFECT/GASEOUS CHLORIN');
INSERT INTO Treatment VALUES (2, 'PART-RMVL/COAGULATION');
INSERT INTO Treatment VALUES (3, 'PART-RMVL/RAPID MIX');
INSERT INTO Treatment VALUES (4, 'PART-RMVL/GASEOUS CHLORIN');
INSERT INTO Treatment VALUES (5, 'PART-RMVL/FLOCCULATION');
INSERT INTO Treatment VALUES (6, 'PART-RMVL/SEDIMENTATION');
INSERT INTO Treatment VALUES (7, 'PART-RMVL/RAPID SAND FIL');
INSERT INTO Treatment VALUES (8, 'OTHER/FLUORIDATION');
INSERT INTO Treatment VALUES (9, 'DISINFECT/HYPOCHLORIN');
INSERT INTO Treatment VALUES (10, 'CORR-CTRL/CORROSION INHIB');
INSERT INTO Treatment VALUES (11, 'T-O CTRL/AERATION');
INSERT INTO Treatment VALUES (12, 'IRON RMVL/SEQUESTATION');

INSERT INTO Business VALUES (1, 'Industrial', 'Amazone', '750 Edgefield Dr.,  Seattle,  WA 99301', 'Geoffrey Bezos', '2019-08-15');
INSERT INTO Business VALUES (2, 'Agricultural', 'Blueberry Farm', '8709 Meadow St.,  Olympia,  WA 98052', 'Hermione Granger', '2021-10-18');
INSERT INTO Business VALUES (3, 'Industrial', 'SomeSocialMediaCompany', '116 Victoria Rd.,  Spokane,  WA 98012', 'Mary Crawley', '2016-08-03');
INSERT INTO Business VALUES (4, 'Industrial', 'Pie Bakery', '803 Constitution St.,  Tacoma,  WA 98682', 'Elizabeth McCord', '2021-06-22');
INSERT INTO Business VALUES (5, 'Agricultural', 'Apple Farm', '840 Pennington St.,  Vancouver,  WA 98208', 'Mary Berry', '2019-10-15');
INSERT INTO Business VALUES (6, 'Agricultural', 'Pumpkin Patch', '616 E. Cambridge St.,  Issaquah,  WA 99208', 'Tom Branson', '2018-01-21');
INSERT INTO Business VALUES (7, 'Agricultural', 'Microgreens', '7658 2nd St.,  Kenmore,  WA 98115', 'Toph Beifong', '1999-12-12');
INSERT INTO Business VALUES (8, 'Industrial', 'Dunder Mifflin', '7200 Ridgewood Drive,  Forks,  WA 98103', 'Hieu Do', '2002-05-22');
INSERT INTO Business VALUES (9, 'Agricultural', 'Strawberry Field', '934 Linda Street,  Fife,  WA 98391', 'Michael Scott', '2009-10-24');
INSERT INTO Business VALUES (10, 'Agricultural', 'Cherry Tree', '94 Dunbar St.,  Federal Way,  WA 99336', 'Hannah Montana', '2018-10-09');
INSERT INTO Business VALUES (11, 'Industrial', 'Stark Industries', '756 East Cedarwood Ave.,  Lacey,  WA 98225', 'Beth Harmon', '2020-01-02');
INSERT INTO Business VALUES (12, 'Agricultural', 'Corn Maze', '7023 Border Dr.,  Bellevue,  WA 98632', 'Tony Stark', '2015-03-27');
INSERT INTO Business VALUES (13, 'Industrial', 'Astromech', '18 Rockland St.,  Lynnwood,  WA 98270', 'Cam Cardashian', '2001-12-22');
INSERT INTO Business VALUES (14, 'Industrial', 'Monsters, Incorporated', '94 Leeton Ridge St., Lake Stevens, WA 98105', 'General Iroh', '1988-11-22');
INSERT INTO Business VALUES (15, 'Industrial', 'Roxxon', '8517 Amerige Dr.,  Longview,  WA 98023', 'Leslie Knope', '2002-04-03');
INSERT INTO Business VALUES (16, 'Agricultural', 'Vineyard', '24 Baker Street,  Leavensworth,  WA 98003', 'Ron Swanson', '2019-12-23');
INSERT INTO Business VALUES (17, 'Agricultural', 'Peach Orchard', '8983 Mill Pond Ave.,  Richland,  WA 98387', 'April Ludgate', '2020-08-22');
INSERT INTO Business VALUES (18, 'Agricultural', 'Christmas Tree Farm', '394 Cedar Ave.,  Vancouver,  WA 98118', 'Jack Donaghy', '2021-01-11');
INSERT INTO Business VALUES (19, 'Industrial', 'Planet Express', '56 Heather Ave.,  Tukwila,  WA 98133', 'Taylor Swift', '2018-10-15');
INSERT INTO Business VALUES (20, 'Agricultural', 'Schrute Farm', '300 Wild Rose Lane,  Toledo,  WA 98042', 'Liz Lemon', '2009-09-01');
INSERT INTO Business VALUES (21, 'Industrial', 'Weasleys Wizard Wheezes', '8418 East Sherwood Drive,  Sammamish,  WA 98661', 'Dwight Schrute', '2010-09-08');
INSERT INTO Business VALUES (22, 'Industrial', 'Central Perk', '582 Thompson Ave.,  Redmond,  WA 98092', 'Fred Weasley', '2017-08-20');
INSERT INTO Business VALUES (23, 'Industrial', 'BioPharma', '9071 Pleasant Circle,  Kirkland,  WA 98902', 'Blair Waldorf', '2018-05-06');

INSERT INTO Regulation VALUES (1, 'Primary Drinking Water Standards: Treatment Technique Requirements', '2016-04-03', 'Requires monitoring of Acrylamide and Epichlorohydrin: https://www.flrules.org/gateway/RuleNo.asp?title=DRINKING%20WATER%20STANDARDS,%20MONITORING,%20AND%20REPORTING&ID=62-550.315');
INSERT INTO Regulation VALUES (2, 'Secondary Drinking Water Standards: Maximum Contaminant Levels', '2021-11-27', 'Requires monitoring of fluoride level: https://www.flrules.org/gateway/RuleNo.asp?title=DRINKING%20WATER%20STANDARDS,%20MONITORING,%20AND%20REPORTING&ID=62-550.320');
INSERT INTO Regulation VALUES (3, 'Nitrate and Nitrite Monitoring Requirements', '2005-01-17', 'Requires monitoring of Nitrate level: https://www.flrules.org/gateway/RuleNo.asp?title=DRINKING%20WATER%20STANDARDS,%20MONITORING,%20AND%20REPORTING&ID=62-550.512');
INSERT INTO Regulation VALUES (4, 'Chlorination Moitoring and Reporting', '2017-08-17', 'Requires chlorine treatment: https://www.doh.wa.gov/CommunityandEnvironment/DrinkingWater/Disinfection/ChlorinationMonitoringandReporting');
INSERT INTO Regulation VALUES (5, 'Corrosion Control', '2016-01-05', 'Corrosion Control: https://www.law.cornell.edu/cfr/text/40/141.82');
INSERT INTO Regulation VALUES (6, 'Flocculation Standards', '2004-08-07', 'Flocculation to remove pathogen: https://www.iwapublishing.com/news/coagulation-and-flocculation-water-and-wastewater-treatment');
INSERT INTO Regulation VALUES (7, 'Monitoring requirements for water quality parameters', '2020-12-16', 'Number of monitoring sites given population: https://www.law.cornell.edu/cfr/text/40/141.87');
INSERT INTO Regulation VALUES (8, 'Interim Enhanced Surface Water Treatment Rule (IESWTR)', '1998-12-08', 'Requires certain public water systems to meet strengthened filtration requirements: https://www.epa.gov/dwreginfo/surface-water-treatment-rules');
INSERT INTO Regulation VALUES (9, 'Washington Primary Drinking Water Regulations', '2021-05-13', 'Washington Primary Drinking Water Regulations: http://www.example.com/amusement.htm?authority=art&act=basketball#basin');
INSERT INTO Regulation VALUES (10, 'Site Location And Design Regulations For Domestic Wastewater Treatment Works', '2009-06-25', 'Site Location And Design Regulations For Domestic Wastewater Treatment Works: https://belief.example.com/');
INSERT INTO Regulation VALUES (11, 'Regulation For State Of Washington Continuing Planning Process', '1971-03-11', 'Regulation For State Of Washington Continuing Planning Process: http://example.com/basketball/aunt');
INSERT INTO Regulation VALUES (12, 'The Basic Standards And Methodologies For Surface Water', '2019-11-12', 'The Basic Standards And Methodologies For Surface Water: http://example.com/#advice');
INSERT INTO Regulation VALUES (13, 'Classifications And Numeric Standards For Arkansas River Basin', '1971-05-08', 'Classifications And Numeric Standards For Arkansas River Basin: http://example.com/action');
INSERT INTO Regulation VALUES (14, 'Classifications And Numeric Standards For Upper Washington River Basin And North Platte River (Planning Region 12)', '1988-02-23', 'Classifications And Numeric Standards For Upper Washington River Basin And North Platte River (Planning Region 12): https://www.example.com/bite');
INSERT INTO Regulation VALUES (15, 'Classifications And Numeric Standards For San Juan And Dolores River Basins', '1973-09-06', 'Classifications And Numeric Standards For San Juan And Dolores River Basins: http://example.com/?boat=book');
INSERT INTO Regulation VALUES (16, 'Classifications And Numeric Standards For Gunnison And Lower Dolores River Basins', '1997-04-07', 'Classifications And Numeric Standards For Gunnison And Lower Dolores River Basins: https://bubble.example.edu/#alarm');
INSERT INTO Regulation VALUES (17, 'Classifications And Numeric Standards For Rio Grande Basin', '2007-10-03', 'Classifications And Numeric Standards For Rio Grande Basin: http://www.example.com/');
INSERT INTO Regulation VALUES (18, 'Classifications And Numeric Standards For Lower Washington River Basin', '1992-09-09', 'Classifications And Numeric Standards For Lower Washington River Basin: http://www.example.com/bat.php');
INSERT INTO Regulation VALUES (19, 'Classifications And Numeric Standards South Platte River Basin Laramie River Basin Republican River Basin Smoky Hill River Basin', '1997-11-29', 'Classifications And Numeric Standards South Platte River Basin Laramie River Basin Republican River Basin Smoky Hill River Basin: http://www.example.com/');
INSERT INTO Regulation VALUES (20, 'Washington River Salinity Standards', '1971-03-16', 'Washington River Salinity Standards: http://example.org/back.aspx');
INSERT INTO Regulation VALUES (21, 'The Basic Standards For Ground Water', '2006-05-26', 'The Basic Standards For Ground Water: http://example.com/');
INSERT INTO Regulation VALUES (22, 'Site Specific Water Quality Classifications And Standards For Ground Water', '1994-01-02', 'Site Specific Water Quality Classifications And Standards For Ground Water: https://www.example.com/');
INSERT INTO Regulation VALUES (23, 'On Site Wastewater Treatment System Regulation', '2000-12-23', 'On Site Wastewater Treatment System Regulation: http://www.example.edu/base');
INSERT INTO Regulation VALUES (24, 'Water Pollution Control Revolving Fund Rules', '1981-12-15', 'Water Pollution Control Revolving Fund Rules: https://example.com/?beginner=bedroom#addition');
INSERT INTO Regulation VALUES (25, 'Drinking Water Revolving Fund', '2013-11-30', 'Drinking Water Revolving Fund: http://badge.example.com/birthday');
INSERT INTO Regulation VALUES (26, 'Domestic Wastewater Treatment Grant Funding System [Repealed Eff. 09/30/2014]', '2013-12-14', 'Domestic Wastewater Treatment Grant Funding System [Repealed Eff. 09/30/2014]: http://blood.example.net/');
INSERT INTO Regulation VALUES (27, 'State Of Washington: Drinking Water Grant Program [Repealed Eff. 09/30/2014]', '1970-04-21', 'State Of Washington: Drinking Water Grant Program [Repealed Eff. 09/30/2014]: http://acoustics.example.com/');
INSERT INTO Regulation VALUES (28, 'State Funded Water And Wastewater Infrastructure Programs', '1979-12-28', 'State Funded Water And Wastewater Infrastructure Programs: https://example.net/?border=bikes&birthday=bubble');
INSERT INTO Regulation VALUES (29, 'Washington Discharge Permit System Regulations', '1982-11-08', 'Washington Discharge Permit System Regulations: http://www.example.org/board/amount?art=books&ants=advice');
INSERT INTO Regulation VALUES (30, 'Regulations For Effluent Limitations', '2014-03-05', 'Regulations For Effluent Limitations: https://example.com/');
INSERT INTO Regulation VALUES (31, 'Pretreatment Regulations', '2016-03-07', 'Pretreatment Regulations: https://example.edu/bottle/bear.php#airport');
INSERT INTO Regulation VALUES (32, 'Biosolids Regulation', '1991-06-10', 'Biosolids Regulation: http://example.net/');
INSERT INTO Regulation VALUES (33, 'Regulation Controlling Discharges To Storm Sewers', '1983-03-25', 'Regulation Controlling Discharges To Storm Sewers: https://www.example.com/');
INSERT INTO Regulation VALUES (34, 'Hcsfo Financial Assurance Criteria Regulations For Washington Housed Commercial Swine Feeding Operations', '1979-04-10', 'Hcsfo Financial Assurance Criteria Regulations For Washington Housed Commercial Swine Feeding Operations: http://example.com/');
INSERT INTO Regulation VALUES (35, 'Dillon Reservoir Control Regulation', '2003-11-15', 'Dillon Reservoir Control Regulation: https://www.example.net/?blood=angle&air=alarm');
INSERT INTO Regulation VALUES (36, 'Animal Feeding Operations Control Regulation', '1996-01-13', 'Animal Feeding Operations Control Regulation: http://www.example.com/?bedroom=bikes');
INSERT INTO Regulation VALUES (37, '401 Certification Regulation', '2009-12-26', '401 Certification Regulation: https://www.example.com/');
INSERT INTO Regulation VALUES (38, 'Passive Treatment Of Mine Drainage Control Regulation [Repealed Eff. 03/04/2007]', '1989-07-14', 'Passive Treatment Of Mine Drainage Control Regulation [Repealed Eff. 03/04/2007]: https://example.net/');
INSERT INTO Regulation VALUES (39, 'Reclaimed Water Control Regulation', '1991-08-12', 'Reclaimed Water Control Regulation: https://www.example.com/animal.php');
INSERT INTO Regulation VALUES (40, 'Nutrients Management Control Regulation', '2002-12-24', 'Nutrients Management Control Regulation: https://www.example.com/breath/bit.html');
INSERT INTO Regulation VALUES (41, 'Graywater Control Regulation', '2009-07-07', 'Graywater Control Regulation: https://www.example.net/baby.aspx');
INSERT INTO Regulation VALUES (42, 'Washingtons Section 303(D) List Of Impaired Waters And Monitoring And Evaluation List', '1998-05-18', 'Washingtons Section 303(D) List Of Impaired Waters And Monitoring And Evaluation List: http://amount.example.com/bridge/border');
INSERT INTO Regulation VALUES (43, 'Washingtons Monitoring And Evaluation List [Repealed Eff. 04/30/2010]', '1991-12-08', 'Washingtons Monitoring And Evaluation List [Repealed Eff. 04/30/2010]: http://advertisement.example.com/berry.aspx');
INSERT INTO Regulation VALUES (44, 'Water Quality Civil Penalty Inflation Adjustment Regulation', '1979-08-18', 'Water Quality Civil Penalty Inflation Adjustment Regulation: http://example.com/?airport=aunt');

INSERT INTO Water_Source_Has_Regulation VALUES (1, 11);
INSERT INTO Water_Source_Has_Regulation VALUES (33, 41);
INSERT INTO Water_Source_Has_Regulation VALUES (27, 35);
INSERT INTO Water_Source_Has_Regulation VALUES (1, 16);
INSERT INTO Water_Source_Has_Regulation VALUES (16, 18);
INSERT INTO Water_Source_Has_Regulation VALUES (24, 43);
INSERT INTO Water_Source_Has_Regulation VALUES (14, 16);
INSERT INTO Water_Source_Has_Regulation VALUES (20, 43);
INSERT INTO Water_Source_Has_Regulation VALUES (21, 23);
INSERT INTO Water_Source_Has_Regulation VALUES (17, 24);
INSERT INTO Water_Source_Has_Regulation VALUES (3, 2);
INSERT INTO Water_Source_Has_Regulation VALUES (36, 43);
INSERT INTO Water_Source_Has_Regulation VALUES (3, 20);
INSERT INTO Water_Source_Has_Regulation VALUES (36, 32);
INSERT INTO Water_Source_Has_Regulation VALUES (13, 20);
INSERT INTO Water_Source_Has_Regulation VALUES (10, 25);
INSERT INTO Water_Source_Has_Regulation VALUES (17, 28);
INSERT INTO Water_Source_Has_Regulation VALUES (36, 37);
INSERT INTO Water_Source_Has_Regulation VALUES (1, 33);
INSERT INTO Water_Source_Has_Regulation VALUES (19, 19);
INSERT INTO Water_Source_Has_Regulation VALUES (28, 27);
INSERT INTO Water_Source_Has_Regulation VALUES (35, 20);
INSERT INTO Water_Source_Has_Regulation VALUES (7, 9);
INSERT INTO Water_Source_Has_Regulation VALUES (34, 13);
INSERT INTO Water_Source_Has_Regulation VALUES (11, 4);
INSERT INTO Water_Source_Has_Regulation VALUES (26, 38);
INSERT INTO Water_Source_Has_Regulation VALUES (18, 31);
INSERT INTO Water_Source_Has_Regulation VALUES (26, 12);
INSERT INTO Water_Source_Has_Regulation VALUES (10, 18);
INSERT INTO Water_Source_Has_Regulation VALUES (33, 36);
INSERT INTO Water_Source_Has_Regulation VALUES (29, 24);
INSERT INTO Water_Source_Has_Regulation VALUES (6, 36);
INSERT INTO Water_Source_Has_Regulation VALUES (15, 5);
INSERT INTO Water_Source_Has_Regulation VALUES (34, 25);
INSERT INTO Water_Source_Has_Regulation VALUES (20, 36);
INSERT INTO Water_Source_Has_Regulation VALUES (9, 28);
INSERT INTO Water_Source_Has_Regulation VALUES (11, 37);
INSERT INTO Water_Source_Has_Regulation VALUES (7, 21);
INSERT INTO Water_Source_Has_Regulation VALUES (27, 9);
INSERT INTO Water_Source_Has_Regulation VALUES (33, 30);
INSERT INTO Water_Source_Has_Regulation VALUES (20, 42);
INSERT INTO Water_Source_Has_Regulation VALUES (1, 24);
INSERT INTO Water_Source_Has_Regulation VALUES (14, 37);
INSERT INTO Water_Source_Has_Regulation VALUES (8, 22);
INSERT INTO Water_Source_Has_Regulation VALUES (35, 6);
INSERT INTO Water_Source_Has_Regulation VALUES (9, 18);
INSERT INTO Water_Source_Has_Regulation VALUES (11, 5);
INSERT INTO Water_Source_Has_Regulation VALUES (24, 16);
INSERT INTO Water_Source_Has_Regulation VALUES (4, 34);
INSERT INTO Water_Source_Has_Regulation VALUES (31, 44);
INSERT INTO Water_Source_Has_Regulation VALUES (35, 21);
INSERT INTO Water_Source_Has_Regulation VALUES (23, 44);
INSERT INTO Water_Source_Has_Regulation VALUES (31, 17);
INSERT INTO Water_Source_Has_Regulation VALUES (5, 11);
INSERT INTO Water_Source_Has_Regulation VALUES (3, 33);
INSERT INTO Water_Source_Has_Regulation VALUES (4, 1);
INSERT INTO Water_Source_Has_Regulation VALUES (9, 39);
INSERT INTO Water_Source_Has_Regulation VALUES (12, 1);
INSERT INTO Water_Source_Has_Regulation VALUES (32, 21);
INSERT INTO Water_Source_Has_Regulation VALUES (2, 1);
INSERT INTO Water_Source_Has_Regulation VALUES (23, 28);
INSERT INTO Water_Source_Has_Regulation VALUES (21, 10);
INSERT INTO Water_Source_Has_Regulation VALUES (13, 23);
INSERT INTO Water_Source_Has_Regulation VALUES (27, 11);
INSERT INTO Water_Source_Has_Regulation VALUES (27, 36);
INSERT INTO Water_Source_Has_Regulation VALUES (34, 44);
INSERT INTO Water_Source_Has_Regulation VALUES (12, 4);
INSERT INTO Water_Source_Has_Regulation VALUES (17, 40);

INSERT INTO Treatment_Has_Regulation VALUES (3, 24);
INSERT INTO Treatment_Has_Regulation VALUES (5, 19);
INSERT INTO Treatment_Has_Regulation VALUES (9, 40);
INSERT INTO Treatment_Has_Regulation VALUES (9, 38);
INSERT INTO Treatment_Has_Regulation VALUES (2, 2);
INSERT INTO Treatment_Has_Regulation VALUES (5, 32);
INSERT INTO Treatment_Has_Regulation VALUES (4, 32);
INSERT INTO Treatment_Has_Regulation VALUES (11, 15);
INSERT INTO Treatment_Has_Regulation VALUES (7, 30);
INSERT INTO Treatment_Has_Regulation VALUES (11, 26);
INSERT INTO Treatment_Has_Regulation VALUES (10, 4);
INSERT INTO Treatment_Has_Regulation VALUES (12, 10);
INSERT INTO Treatment_Has_Regulation VALUES (3, 36);
INSERT INTO Treatment_Has_Regulation VALUES (9, 16);
INSERT INTO Treatment_Has_Regulation VALUES (1, 21);
INSERT INTO Treatment_Has_Regulation VALUES (5, 38);
INSERT INTO Treatment_Has_Regulation VALUES (9, 35);
INSERT INTO Treatment_Has_Regulation VALUES (5, 1);
INSERT INTO Treatment_Has_Regulation VALUES (11, 44);
INSERT INTO Treatment_Has_Regulation VALUES (8, 5);
INSERT INTO Treatment_Has_Regulation VALUES (10, 3);
INSERT INTO Treatment_Has_Regulation VALUES (11, 37);
INSERT INTO Treatment_Has_Regulation VALUES (2, 43);
INSERT INTO Treatment_Has_Regulation VALUES (11, 33);
INSERT INTO Treatment_Has_Regulation VALUES (6, 40);
INSERT INTO Treatment_Has_Regulation VALUES (8, 16);
INSERT INTO Treatment_Has_Regulation VALUES (3, 32);
INSERT INTO Treatment_Has_Regulation VALUES (10, 28);
INSERT INTO Treatment_Has_Regulation VALUES (8, 32);
INSERT INTO Treatment_Has_Regulation VALUES (6, 8);
INSERT INTO Treatment_Has_Regulation VALUES (10, 26);
INSERT INTO Treatment_Has_Regulation VALUES (1, 13);
INSERT INTO Treatment_Has_Regulation VALUES (8, 43);
INSERT INTO Treatment_Has_Regulation VALUES (10, 39);
INSERT INTO Treatment_Has_Regulation VALUES (8, 31);
INSERT INTO Treatment_Has_Regulation VALUES (2, 20);
INSERT INTO Treatment_Has_Regulation VALUES (6, 39);
INSERT INTO Treatment_Has_Regulation VALUES (5, 18);
INSERT INTO Treatment_Has_Regulation VALUES (9, 1);
INSERT INTO Treatment_Has_Regulation VALUES (1, 31);
INSERT INTO Treatment_Has_Regulation VALUES (10, 13);
INSERT INTO Treatment_Has_Regulation VALUES (3, 37);
INSERT INTO Treatment_Has_Regulation VALUES (1, 18);
INSERT INTO Treatment_Has_Regulation VALUES (8, 1);
INSERT INTO Treatment_Has_Regulation VALUES (1, 14);
INSERT INTO Treatment_Has_Regulation VALUES (6, 2);
INSERT INTO Treatment_Has_Regulation VALUES (1, 29);
INSERT INTO Treatment_Has_Regulation VALUES (3, 21);
INSERT INTO Treatment_Has_Regulation VALUES (1, 22);
INSERT INTO Treatment_Has_Regulation VALUES (4, 11);
INSERT INTO Treatment_Has_Regulation VALUES (10, 24);
INSERT INTO Treatment_Has_Regulation VALUES (10, 14);
INSERT INTO Treatment_Has_Regulation VALUES (3, 12);
INSERT INTO Treatment_Has_Regulation VALUES (2, 28);
INSERT INTO Treatment_Has_Regulation VALUES (3, 44);
INSERT INTO Treatment_Has_Regulation VALUES (7, 44);
INSERT INTO Treatment_Has_Regulation VALUES (5, 31);
INSERT INTO Treatment_Has_Regulation VALUES (8, 18);
INSERT INTO Treatment_Has_Regulation VALUES (2, 1);
INSERT INTO Treatment_Has_Regulation VALUES (6, 11);
INSERT INTO Treatment_Has_Regulation VALUES (11, 42);

INSERT INTO Treatments_Performed VALUES (19, 19, 7, '2001-01-01', 3874516, 'Successful');
INSERT INTO Treatments_Performed VALUES (7, 7, 1, '2014-09-05', 4171133, 'Successful');
INSERT INTO Treatments_Performed VALUES (25, 25, 8, '2016-12-29', 4284481, 'Successful');
INSERT INTO Treatments_Performed VALUES (18, 18, 4, '2009-01-31', 4428636, 'Successful');
INSERT INTO Treatments_Performed VALUES (16, 16, 6, '2014-08-18', 1455364, 'Successful');
INSERT INTO Treatments_Performed VALUES (24, 24, 3, '2019-10-24', 1282737, 'Successful');
INSERT INTO Treatments_Performed VALUES (13, 13, 12, '2020-12-04', 4625920, 'Successful');
INSERT INTO Treatments_Performed VALUES (6, 6, 2, '2021-10-14', 281305, 'Successful');
INSERT INTO Treatments_Performed VALUES (25, 25, 4, '2016-03-21', 2833620, 'Successful');
INSERT INTO Treatments_Performed VALUES (16, 16, 12, '2015-05-10', 2400140, 'Successful');
INSERT INTO Treatments_Performed VALUES (2, 2, 5, '2021-12-31', 3537425, 'Successful');
INSERT INTO Treatments_Performed VALUES (30, 30, 10, '2019-02-08', 4728805, 'Successful');
INSERT INTO Treatments_Performed VALUES (30, 30, 8, '2016-04-12', 2551529, 'Successful');
INSERT INTO Treatments_Performed VALUES (2, 2, 4, '2018-08-08', 979941, 'Successful');
INSERT INTO Treatments_Performed VALUES (30, 30, 5, '2019-11-04', 1719825, 'Successful');
INSERT INTO Treatments_Performed VALUES (3, 3, 9, '2008-04-21', 4784823, 'Successful');
INSERT INTO Treatments_Performed VALUES (33, 33, 3, '2015-12-23', 3084547, 'Successful');
INSERT INTO Treatments_Performed VALUES (20, 20, 4, '2019-03-19', 3319930, 'Successful');
INSERT INTO Treatments_Performed VALUES (3, 3, 2, '2019-02-25', 1146431, 'Successful');
INSERT INTO Treatments_Performed VALUES (12, 12, 8, '2020-08-02', 2468473, 'Successful');
INSERT INTO Treatments_Performed VALUES (12, 12, 9, '2021-12-17', 1840797, 'Successful');
INSERT INTO Treatments_Performed VALUES (31, 31, 6, '2019-12-19', 250626, 'Successful');
INSERT INTO Treatments_Performed VALUES (2, 2, 11, '2018-03-29', 3212495, 'Successful');
INSERT INTO Treatments_Performed VALUES (16, 16, 4, '2021-11-04', 4397414, 'Successful');
INSERT INTO Treatments_Performed VALUES (10, 10, 12, '2020-01-18', 1429090, 'Successful');
INSERT INTO Treatments_Performed VALUES (34, 34, 11, '2021-08-23', 854485, 'Successful');
INSERT INTO Treatments_Performed VALUES (6, 6, 4, '2020-10-15', 2390372, 'Successful');
INSERT INTO Treatments_Performed VALUES (15, 15, 1, '2021-11-30', 3189337, 'Successful');
INSERT INTO Treatments_Performed VALUES (21, 21, 1, '2019-10-07', 2272615, 'Successful');
INSERT INTO Treatments_Performed VALUES (12, 12, 12, '2019-07-31', 1678158, 'Successful');
INSERT INTO Treatments_Performed VALUES (26, 26, 8, '2021-02-21', 4197573, 'Successful');
INSERT INTO Treatments_Performed VALUES (20, 20, 8, '2021-04-17', 1793142, 'Successful');
INSERT INTO Treatments_Performed VALUES (35, 35, 4, '2021-07-12', 1259074, 'Successful');
INSERT INTO Treatments_Performed VALUES (19, 19, 8, '2020-03-01', 4176953, 'Successful');
INSERT INTO Treatments_Performed VALUES (28, 28, 4, '2020-06-03', 469735, 'Successful');
INSERT INTO Treatments_Performed VALUES (25, 25, 12, '2021-11-07', 4133187, 'Successful');
INSERT INTO Treatments_Performed VALUES (20, 20, 9, '2021-07-01', 2680740, 'Successful');
INSERT INTO Treatments_Performed VALUES (16, 16, 9, '2021-08-23', 4966720, 'Successful');
INSERT INTO Treatments_Performed VALUES (26, 26, 9, '2021-12-20', 4150445, 'Successful');
INSERT INTO Treatments_Performed VALUES (12, 12, 1, '2021-01-09', 3175019, 'Successful');
INSERT INTO Treatments_Performed VALUES (22, 22, 12, '2020-10-24', 3175333, 'Successful');
INSERT INTO Treatments_Performed VALUES (10, 10, 12, '2021-10-03', 244824, 'Successful');
INSERT INTO Treatments_Performed VALUES (27, 27, 10, '2021-01-28', 4498272, 'Successful');
INSERT INTO Treatments_Performed VALUES (29, 29, 2, '2021-07-06', 1753804, 'Successful');
INSERT INTO Treatments_Performed VALUES (6, 6, 6, '2021-08-02', 1743607, 'Successful');
INSERT INTO Treatments_Performed VALUES (18, 18, 4, '2021-01-17', 4132006, 'Successful');
INSERT INTO Treatments_Performed VALUES (36, 36, 5, '2021-01-15', 2770293, 'Successful');
INSERT INTO Treatments_Performed VALUES (14, 14, 10, '2021-10-07', 4600469, 'Successful');
INSERT INTO Treatments_Performed VALUES (6, 6, 9, '2021-07-10', 1781987, 'Successful');
INSERT INTO Treatments_Performed VALUES (28, 28, 8, '2021-03-28', 1165256, 'Successful');
INSERT INTO Treatments_Performed VALUES (5, 5, 1, '2021-03-18', 727081, 'Successful');
INSERT INTO Treatments_Performed VALUES (4, 4, 11, '2021-07-08', 4574402, 'Successful');
INSERT INTO Treatments_Performed VALUES (4, 4, 7, '2020-11-20', 3608359, 'Successful');
INSERT INTO Treatments_Performed VALUES (12, 12, 12, '2018-07-19', 3166098, 'Successful');
INSERT INTO Treatments_Performed VALUES (8, 8, 4, '2014-04-18', 589829, 'Successful');
INSERT INTO Treatments_Performed VALUES (33, 33, 11, '2021-07-06', 4076400, 'Successful');
INSERT INTO Treatments_Performed VALUES (30, 30, 11, '2021-02-26', 3232406, 'Successful');
INSERT INTO Treatments_Performed VALUES (34, 34, 12, '2021-06-27', 534663, 'Successful');
INSERT INTO Treatments_Performed VALUES (35, 35, 10, '2021-10-09', 2674349, 'Successful');
INSERT INTO Treatments_Performed VALUES (22, 22, 12, '2021-07-30', 4390049, 'Successful');
INSERT INTO Treatments_Performed VALUES (16, 16, 10, '2021-07-31', 424624, 'Successful');
INSERT INTO Treatments_Performed VALUES (29, 29, 7, '2021-07-11', 2385713, 'Successful');
INSERT INTO Treatments_Performed VALUES (2, 2, 1, '2021-07-08', 4447584, 'Successful');
INSERT INTO Treatments_Performed VALUES (5, 5, 12, '2021-03-16', 3913293, 'Successful');
INSERT INTO Treatments_Performed VALUES (22, 22, 8, '2021-11-01', 3176512, 'Successful');
INSERT INTO Treatments_Performed VALUES (29, 29, 6, '2021-12-19', 2062004, 'Successful');
INSERT INTO Treatments_Performed VALUES (27, 27, 3, '2021-12-25', 4660256, 'Successful');
INSERT INTO Treatments_Performed VALUES (33, 33, 7, '2021-03-10', 315645, 'Successful');
INSERT INTO Treatments_Performed VALUES (19, 19, 5, '2021-05-15', 3318712, 'Successful');
INSERT INTO Treatments_Performed VALUES (23, 23, 6, '2021-04-26', 917895, 'Successful');
INSERT INTO Treatments_Performed VALUES (24, 24, 10, '2020-04-11', 285851, 'Successful');
INSERT INTO Treatments_Performed VALUES (10, 10, 9, '2020-05-28', 2281308, 'Successful');
INSERT INTO Treatments_Performed VALUES (33, 33, 8, '2020-08-26', 2127076, 'Successful');
INSERT INTO Treatments_Performed VALUES (1, 1, 6, '2020-05-27', 3384247, 'Successful');
INSERT INTO Treatments_Performed VALUES (34, 34, 10, '2020-12-18', 3045129, 'Successful');
INSERT INTO Treatments_Performed VALUES (13, 13, 4, '2020-07-02', 3301164, 'Successful');
INSERT INTO Treatments_Performed VALUES (2, 2, 10, '2020-07-14', 1576190, 'Successful');
INSERT INTO Treatments_Performed VALUES (11, 11, 12, '2021-12-18', 731928, 'Successful');
INSERT INTO Treatments_Performed VALUES (28, 28, 4, '2021-10-01', 1036000, 'Successful');
INSERT INTO Treatments_Performed VALUES (24, 24, 4, '2021-05-15', 2013129, 'Successful');
INSERT INTO Treatments_Performed VALUES (22, 22, 5, '2021-08-13', 4715762, 'Successful');
INSERT INTO Treatments_Performed VALUES (28, 28, 5, '2021-01-13', 4623543, 'Successful');
INSERT INTO Treatments_Performed VALUES (28, 28, 6, '2021-02-10', 1398178, 'Successful');
INSERT INTO Treatments_Performed VALUES (21, 21, 2, '2021-05-19', 1539846, 'Successful');
INSERT INTO Treatments_Performed VALUES (12, 12, 4, '2021-07-21', 3359626, 'Successful');
INSERT INTO Treatments_Performed VALUES (22, 22, 3, '2021-08-27', 3566552, 'Successful');
INSERT INTO Treatments_Performed VALUES (18, 18, 7, '2021-11-22', 592013, 'Successful');
INSERT INTO Treatments_Performed VALUES (24, 24, 3, '2021-11-10', 2712153, 'Successful');
INSERT INTO Treatments_Performed VALUES (26, 26, 2, '2021-06-14', 992749, 'Successful');
INSERT INTO Treatments_Performed VALUES (31, 31, 1, '2021-10-25', 294643, 'Successful');
INSERT INTO Treatments_Performed VALUES (21, 21, 10, '2021-07-06', 1036364, 'Successful');
INSERT INTO Treatments_Performed VALUES (14, 14, 3, '2021-11-25', 2787535, 'Successful');
INSERT INTO Treatments_Performed VALUES (7, 7, 5, '2021-08-30', 4078967, 'Successful');
INSERT INTO Treatments_Performed VALUES (16, 16, 4, '2021-03-06', 1953806, 'Successful');
INSERT INTO Treatments_Performed VALUES (23, 23, 3, '2021-12-21', 667981, 'Successful');
INSERT INTO Treatments_Performed VALUES (33, 33, 6, '2021-06-24', 2924713, 'Successful');
INSERT INTO Treatments_Performed VALUES (34, 34, 7, '2021-08-05', 4779362, 'Successful');
INSERT INTO Treatments_Performed VALUES (34, 34, 1, '2021-11-07', 4261287, 'Successful');
INSERT INTO Treatments_Performed VALUES (17, 17, 1, '2021-08-28', 3182723, 'Successful');
INSERT INTO Treatments_Performed VALUES (16, 16, 7, '2021-11-11', 4517986, 'Successful');
INSERT INTO Treatments_Performed VALUES (3, 3, 6, '2021-11-13', 1676235, 'Successful');
INSERT INTO Treatments_Performed VALUES (10, 10, 2, '2021-04-28', 204286, 'Successful');
INSERT INTO Treatments_Performed VALUES (20, 20, 8, '2021-10-26', 4610593, 'Successful');
INSERT INTO Treatments_Performed VALUES (4, 4, 2, '2021-04-01', 1869530, 'Successful');
INSERT INTO Treatments_Performed VALUES (10, 10, 12, '2021-10-08', 4252336, 'Successful');
INSERT INTO Treatments_Performed VALUES (22, 22, 4, '2021-04-29', 1697001, 'Successful');
INSERT INTO Treatments_Performed VALUES (30, 30, 4, '2021-12-02', 1396698, 'Successful');
INSERT INTO Treatments_Performed VALUES (17, 17, 2, '2021-05-18', 3766593, 'Successful');
INSERT INTO Treatments_Performed VALUES (31, 31, 7, '2021-10-21', 3700993, 'Successful');
INSERT INTO Treatments_Performed VALUES (10, 10, 8, '2021-02-06', 4844406, 'Successful');
INSERT INTO Treatments_Performed VALUES (5, 5, 6, '2021-10-12', 4788852, 'Successful');
INSERT INTO Treatments_Performed VALUES (35, 35, 1, '2021-06-24', 3350096, 'Successful');
INSERT INTO Treatments_Performed VALUES (5, 5, 9, '2021-05-05', 2919326, 'Successful');
INSERT INTO Treatments_Performed VALUES (4, 4, 7, '2021-11-22', 1682809, 'Successful');
INSERT INTO Treatments_Performed VALUES (27, 27, 3, '2021-12-07', 2486849, 'Successful');
INSERT INTO Treatments_Performed VALUES (22, 22, 4, '2021-03-29', 1130733, 'Successful');
INSERT INTO Treatments_Performed VALUES (30, 30, 2, '2021-07-26', 4561356, 'Successful');
INSERT INTO Treatments_Performed VALUES (22, 22, 3, '2021-08-02', 4967792, 'Successful');
INSERT INTO Treatments_Performed VALUES (2, 2, 3, '2021-11-09', 2421287, 'Successful');
INSERT INTO Treatments_Performed VALUES (26, 26, 11, '2021-10-08', 697155, 'Successful');
INSERT INTO Treatments_Performed VALUES (3, 3, 11, '2021-01-17', 665952, 'Successful');
INSERT INTO Treatments_Performed VALUES (23, 23, 9, '2021-11-18', 4504236, 'Successful');
INSERT INTO Treatments_Performed VALUES (28, 28, 12, '2021-07-10', 1446590, 'Successful');
INSERT INTO Treatments_Performed VALUES (3, 3, 11, '2021-05-07', 2948650, 'Successful');
INSERT INTO Treatments_Performed VALUES (7, 7, 6, '2021-12-01', 4221069, 'Successful');
INSERT INTO Treatments_Performed VALUES (6, 6, 9, '2021-02-07', 2820603, 'Successful');
INSERT INTO Treatments_Performed VALUES (11, 11, 1, '2021-04-27', 2011132, 'Successful');
INSERT INTO Treatments_Performed VALUES (18, 18, 11, '2021-07-13', 1800644, 'Successful');
INSERT INTO Treatments_Performed VALUES (1, 1, 1, '2021-12-19', 2996798, 'Successful');
INSERT INTO Treatments_Performed VALUES (34, 34, 3, '2021-10-29', 3061451, 'Successful');
INSERT INTO Treatments_Performed VALUES (2, 2, 7, '2021-05-03', 3065170, 'Successful');
INSERT INTO Treatments_Performed VALUES (26, 26, 3, '2021-01-11', 3377995, 'Successful');
INSERT INTO Treatments_Performed VALUES (28, 28, 8, '2021-06-10', 832373, 'Successful');
INSERT INTO Treatments_Performed VALUES (2, 2, 6, '2021-12-27', 2158516, 'Successful');
INSERT INTO Treatments_Performed VALUES (26, 26, 5, '2021-02-22', 2214754, 'Successful');
INSERT INTO Treatments_Performed VALUES (23, 23, 5, '2021-05-10', 2084706, 'Successful');
INSERT INTO Treatments_Performed VALUES (9, 9, 9, '2021-01-08', 2322571, 'Successful');
INSERT INTO Treatments_Performed VALUES (13, 13, 6, '2021-06-08', 2191263, 'Successful');
INSERT INTO Treatments_Performed VALUES (24, 24, 10, '2021-01-02', 2057895, 'Successful');
INSERT INTO Treatments_Performed VALUES (2, 2, 12, '2021-01-09', 3631052, 'Successful');
INSERT INTO Treatments_Performed VALUES (27, 27, 4, '2021-06-28', 1557215, 'Successful');
INSERT INTO Treatments_Performed VALUES (27, 27, 11, '2021-05-28', 1733412, 'Successful');
INSERT INTO Treatments_Performed VALUES (13, 13, 9, '2021-08-05', 1489528, 'Successful');
INSERT INTO Treatments_Performed VALUES (27, 27, 12, '2021-06-27', 3928908, 'Successful');
INSERT INTO Treatments_Performed VALUES (15, 15, 5, '2021-04-29', 3323610, 'Successful');
INSERT INTO Treatments_Performed VALUES (23, 23, 1, '2021-07-30', 279966, 'Successful');
INSERT INTO Treatments_Performed VALUES (10, 10, 12, '2021-08-27', 605014, 'Successful');
INSERT INTO Treatments_Performed VALUES (9, 9, 9, '2021-02-05', 4059768, 'Successful');
INSERT INTO Treatments_Performed VALUES (12, 12, 4, '2021-06-02', 3679147, 'Successful');
INSERT INTO Treatments_Performed VALUES (30, 30, 11, '2021-04-29', 1199512, 'Successful');
INSERT INTO Treatments_Performed VALUES (24, 24, 12, '2021-04-16', 3305915, 'Successful');
INSERT INTO Treatments_Performed VALUES (5, 5, 11, '2021-01-04', 4797510, 'Successful');
INSERT INTO Treatments_Performed VALUES (24, 24, 9, '2021-11-07', 2635628, 'Successful');
INSERT INTO Treatments_Performed VALUES (8, 8, 6, '2021-01-09', 3154712, 'Successful');
INSERT INTO Treatments_Performed VALUES (13, 13, 12, '2021-06-26', 3862637, 'Successful');
INSERT INTO Treatments_Performed VALUES (29, 29, 8, '2021-11-14', 3081816, 'Successful');
INSERT INTO Treatments_Performed VALUES (36, 36, 6, '2021-12-17', 221990, 'Successful');
INSERT INTO Treatments_Performed VALUES (17, 17, 5, '2021-10-18', 2078652, 'Successful');
INSERT INTO Treatments_Performed VALUES (27, 27, 12, '2021-09-28', 3977685, 'Successful');
INSERT INTO Treatments_Performed VALUES (4, 4, 4, '2021-04-04', 3108904, 'Successful');
INSERT INTO Treatments_Performed VALUES (24, 24, 11, '2021-12-19', 708427, 'Successful');
INSERT INTO Treatments_Performed VALUES (16, 16, 6, '2021-08-30', 3076265, 'Successful');
INSERT INTO Treatments_Performed VALUES (3, 3, 3, '2021-08-03', 3685583, 'Successful');
INSERT INTO Treatments_Performed VALUES (9, 9, 2, '2021-06-21', 1612128, 'Successful');
INSERT INTO Treatments_Performed VALUES (6, 6, 9, '2021-12-12', 3100050, 'Successful');
INSERT INTO Treatments_Performed VALUES (29, 29, 8, '2021-04-03', 2145024, 'Successful');
INSERT INTO Treatments_Performed VALUES (4, 4, 4, '2021-06-24', 3505639, 'Successful');
INSERT INTO Treatments_Performed VALUES (17, 17, 6, '2021-05-01', 1385202, 'Successful');
INSERT INTO Treatments_Performed VALUES (7, 7, 12, '2021-01-24', 1325356, 'Successful');
INSERT INTO Treatments_Performed VALUES (28, 28, 3, '2021-02-25', 1552813, 'Successful');
INSERT INTO Treatments_Performed VALUES (29, 29, 3, '2021-02-03', 3391700, 'Successful');
INSERT INTO Treatments_Performed VALUES (16, 16, 9, '2021-08-01', 205126, 'Successful');
INSERT INTO Treatments_Performed VALUES (4, 4, 12, '2021-07-08', 3485775, 'Successful');
INSERT INTO Treatments_Performed VALUES (7, 7, 10, '2021-06-22', 4057850, 'Successful');

INSERT INTO Business_Used VALUES
(1, 1, "2020-10-22", 1770536, 534383),(1, 1, "2020-11-22", 1730536, 504383),(1, 1, "2020-12-22", 1540536, 514383),
(1, 1, "2021-01-22", 1691728, 541557),(1, 1, "2021-02-22", 1175296, 863216),(1, 1, "2021-03-22", 1891652, 928000),
(1, 1, "2021-04-22", 1153685, 410592),(1, 1, "2021-05-22", 1953064, 779718),(1, 1, "2021-06-22", 1120639, 903502),
(1, 1, "2021-07-22", 1678203, 803038),(1, 1, "2021-08-22", 1783926, 847313),(1, 1, "2021-09-22", 1209929, 544478),
(1, 1, "2021-10-22", 1904148, 646422),(1, 1, "2021-11-22", 1153631, 872420),(1, 1, "2021-12-22", 1564801, 764634),

(2, 2, "2020-10-23", 1388241, 633525),(2, 2, "2020-11-23", 1288241, 563825),(2, 2, "2020-12-23", 1318241, 443225),
(2, 2, "2021-01-23", 1198582, 400640),(2, 2, "2021-02-23", 1293945, 819999),(2, 2, "2021-03-23", 1005618, 473682),
(2, 2, "2021-04-23", 1138373, 997975),(2, 2, "2021-05-23", 1341626, 667941),(2, 2, "2021-06-23", 1467807, 733961),
(2, 2, "2021-07-23", 1133005, 980116),(2, 2, "2021-08-23", 1661011, 413036),(2, 2, "2021-09-23", 1951225, 762180),
(2, 2, "2021-10-23", 1764676, 724190),(2, 2, "2021-11-23", 1872666, 411324),(2, 2, "2021-12-23", 1110457, 729154),

(3, 3, "2020-10-24", 1991624, 793231),(3, 3, "2020-11-24", 1391624, 497031),(3, 3, "2020-12-24", 1291624, 393431),
(3, 3, "2021-01-24", 1605292, 970211),(3, 3, "2021-02-24", 1562735, 933580),(3, 3, "2021-03-24", 1988017, 455329),
(3, 3, "2021-04-24", 1299893, 791615),(3, 3, "2021-05-24", 1319803, 760365),(3, 3, "2021-06-24", 1754657, 875574),
(3, 3, "2021-07-24", 1635306, 474094),(3, 3, "2021-08-24", 1201369, 773203),(3, 3, "2021-09-24", 1823057, 987140),
(3, 3, "2021-10-24", 1649506, 989013),(3, 3, "2021-11-24", 1924630, 945964),(3, 3, "2021-12-24", 1303970, 901404),

(4, 4, "2020-10-22", 1534634, 864353),(4, 4, "2020-11-22", 1234614, 364153),(4, 4, "2020-12-22", 1934634, 761253),
(4, 4, "2021-01-22", 1279451, 840868),(4, 4, "2021-02-22", 1543626, 915976),(4, 4, "2021-03-22", 1187292, 583756),
(4, 4, "2021-04-22", 1677412, 990224),(4, 4, "2021-05-22", 1443892, 443962),(4, 4, "2021-06-22", 1539781, 700020),
(4, 4, "2021-07-22", 1677982, 697258),(4, 4, "2021-08-22", 1381764, 812340),(4, 4, "2021-09-22", 1615720, 514852),
(4, 4, "2021-10-22", 1115493, 872703),(4, 4, "2021-11-22", 1858397, 788731),(4, 4, "2021-12-22", 1900497, 562197),

(5, 5, "2020-10-23", 1859011, 631384),(5, 5, "2020-11-23", 1459011, 311384),(5, 5, "2020-12-23", 1259011, 351314),
(5, 5, "2021-01-23", 1345261, 486593),(5, 5, "2021-02-23", 1847328, 463198),(5, 5, "2021-03-23", 1267799, 583918),
(5, 5, "2021-04-23", 1572841, 883730),(5, 5, "2021-05-23", 1529165, 522239),(5, 5, "2021-06-23", 1297468, 698026),
(5, 5, "2021-07-23", 1733830, 941952),(5, 5, "2021-08-23", 1807340, 834711),(5, 5, "2021-09-23", 1123678, 756557),
(5, 5, "2021-10-23", 1595433, 711963),(5, 5, "2021-11-23", 1939335, 581207),(5, 5, "2021-12-23", 1986988, 993600),

(6, 6, "2020-10-24", 1987507, 493706),(6, 6, "2020-11-24", 1317307, 192356),(6, 6, "2020-12-24", 1257507, 391796),
(6, 6, "2021-01-24", 1939297, 465785),(6, 6, "2021-02-24", 1873336, 585970),(6, 6, "2021-03-24", 1704982, 629579),
(6, 6, "2021-04-24", 1625577, 452975),(6, 6, "2021-05-24", 1741477, 675121),(6, 6, "2021-06-24", 1852569, 775719),
(6, 6, "2021-07-24", 1534220, 426486),(6, 6, "2021-08-24", 1203964, 750191),(6, 6, "2021-09-24", 1046454, 442496),
(6, 6, "2021-10-24", 1874314, 953339),(6, 6, "2021-11-24", 1912544, 915162),(6, 6, "2021-12-24", 1144989, 693323),

(7, 7, "2020-10-22", 1069520, 830531),(7, 7, "2020-11-22", 1363520, 615231),(7, 7, "2020-12-22", 1569520, 486331),
(7, 7, "2021-01-22", 1005598, 989163),(7, 7, "2021-02-22", 1853543, 792315),(7, 7, "2021-03-22", 1188942, 734034),
(7, 7, "2021-04-22", 1096069, 819429),(7, 7, "2021-05-22", 1989603, 831788),(7, 7, "2021-06-22", 1839013, 422093),
(7, 7, "2021-07-22", 1059024, 671037),(7, 7, "2021-08-22", 1775666, 754757),(7, 7, "2021-09-22", 1058569, 621327),
(7, 7, "2021-10-22", 1158495, 834194),(7, 7, "2021-11-22", 1174302, 469780),(7, 7, "2021-12-22", 1131802, 656476);

INSERT INTO Investment VALUES (1, 1, 4279851, NULL, NULL, 59);
INSERT INTO Investment VALUES (2, 2, NULL, NULL, 242364, 50);
INSERT INTO Investment VALUES (3, 3, 3594727, NULL, NULL, 76);
INSERT INTO Investment VALUES (4, 4, 3018999, NULL, NULL, 72);
INSERT INTO Investment VALUES (5, 5, NULL, 4851371, NULL, 58);
INSERT INTO Investment VALUES (6, 6, NULL, NULL, 2444887, 37);
INSERT INTO Investment VALUES (7, 7, NULL, NULL, 1571748, 99);
INSERT INTO Investment VALUES (8, 8, NULL, 3935113, NULL, 74);
INSERT INTO Investment VALUES (9, 9, NULL, 4324644, NULL, 67);
INSERT INTO Investment VALUES (10, 10, NULL, 2587316, NULL, 69);
INSERT INTO Investment VALUES (11, 11, 1932717, NULL, NULL, 83);
INSERT INTO Investment VALUES (12, 12, NULL, NULL, 4120742, 35);
INSERT INTO Investment VALUES (13, 13, 4568318, NULL, NULL, 11);
INSERT INTO Investment VALUES (14, 14, NULL, NULL, 3196559, 48);
INSERT INTO Investment VALUES (15, 15, 4574083, NULL, NULL, 5);
INSERT INTO Investment VALUES (16, 16, NULL, NULL, 4287335, 32);
INSERT INTO Investment VALUES (17, 17, NULL, 1088025, NULL, 74);
INSERT INTO Investment VALUES (18, 18, NULL, 3845287, NULL, 16);
INSERT INTO Investment VALUES (19, 19, 4578728, NULL, NULL, 5);
INSERT INTO Investment VALUES (20, 20, 4468133, NULL, NULL, 52);
INSERT INTO Investment VALUES (21, 21, 876599, NULL, NULL, 70);
INSERT INTO Investment VALUES (22, 22, 1655823, NULL, NULL, 43);
INSERT INTO Investment VALUES (23, 23, 765867, NULL, NULL, 2);
INSERT INTO Investment VALUES (24, 24, NULL, NULL, 2845937, 97);
INSERT INTO Investment VALUES (25, 25, NULL, NULL, 3801285, 33);
INSERT INTO Investment VALUES (26, 26, NULL, NULL, 927023, 29);
INSERT INTO Investment VALUES (27, 27, NULL, 3108466, NULL, 22);
INSERT INTO Investment VALUES (28, 28, NULL, NULL, 2804345, 94);
INSERT INTO Investment VALUES (29, 29, 3305268, NULL, NULL, 24);
INSERT INTO Investment VALUES (30, 30, NULL, NULL, 3461782, 66);

-- Additional Data for Hieu's Video Demo
-- Water_Source_ID, Location, Water_Quality
INSERT INTO Water_Source VALUES (37, 'Walden Pond', 'Good');
INSERT INTO Water_Source VALUES (38, 'The Great Lake', 'Fair');
INSERT INTO Water_Source VALUES (39, 'The Anduin River', 'Excellent');

-- Water_Source_ID, Regulation_ID
INSERT INTO Water_Source_Has_Regulation VALUES (37, 4);
INSERT INTO Water_Source_Has_Regulation VALUES (38, 4);

-- Treatment_Number, Regulation_ID
-- INSERT INTO Treatment_Has_Regulation VALUES (10, 4); 

-- Facility_ID, Water_Source_ID, Treatment_Number, Date_Treated, Quantity_Treated, Treatment_Description
INSERT INTO Treatments_Performed VALUES (1, 37, 10, '2021-01-01', 3874516, 'Successful');
INSERT INTO Treatments_Performed VALUES (1, 38, 10, '2021-09-05', 4171133, 'Successful');
INSERT INTO Treatments_Performed VALUES (1, 39, 10, '2021-09-05', 4171135, 'Successful');


-- drop table Investment;
-- drop table Treatment_Has_Regulation;
-- drop table Water_Source_Has_Regulation;
-- drop table Regulation;
-- drop table Treatments_Performed;
-- drop table Treatment;
-- drop table Business_Used;
-- drop table Business;
-- drop table Water_Source;
-- drop table Facility;
-- drop schema water_treatment2