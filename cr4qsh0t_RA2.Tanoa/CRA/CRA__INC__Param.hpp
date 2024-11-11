
class CRA_PM_SystemHotloading {
	title = " ------  System | Hot-Loading";
	texts[] = {"Enable", "Disable"};
	values[] = {1,0};
	default = 1;
};
class CRA_PM_SystemClutterDetect {
	title = " ------  System | Clutter Detection";
	texts[] = {"Bounding Box [Faster Loading]","Collision [More Accurate]"};
	values[] = {0,1};
	default = 0;
};
class CRA_PM_LC_RB_Mode {
	title = " ------  Location | Checkpoint Mode";
	texts[] = {"None [Off]", "Grid-Based Segmentation [Original RA2]","Pool Segmentation [Improved Uniform RA2]"};
	values[] = {0,1,2};
	default = 2;
};
class CRA_PM_LC_RB_Density {
	title = " ------  Location | Checkpoint Density";
	texts[] = {"1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25"};
	values[] = {25,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24};
	default = 11;
};
class CRA_PM_PL_Start {
	title = " ------  Mission | Start Location";
	texts[] = {"Story","Random -- NOT YET IMPLEMENTED / IGNORED"};
	values[] = {0,1};
	default = 0;
};
class CRA_PM_PL_Identity {
	title = " ------  Player | Identity";
	texts[] = {"User","Story"};
	values[] = {0,1};
	default = 0;
};
class CRA_PM_PG_Mode {
	title = " ------  Progress | f(x)";
	texts[] = {"Constant | f(x) = x0","Linear | f(x) = x0 + (x1 - x0) * x * a","Parabolic | f(x) = x0 + (x1 - x0) * x^a","Reverse Linear | f(x) = x1 + (x0 - x1) * (1 - x) * a","Reverse Parabolic | f(x) = x1 + (x0 - x1) * (1 - x)^a"};
	values[] = {0,1,2,3,4};
	default = 1;
};
class CRA_PM_PG_Factor {
	title = " ------  Progress | a";
	texts[] = {"0.031","0.042","0.063","0.083","0.100","0.111","0.125","0.143","0.167","0.200","0.250","0.333","0.500","0.556","0.571","0.600","0.667","0.750","0.800","0.833","1.000","1.200","1.250","1.333","1.500","1.667","1.750","1.800","2.000","3.000","4.000","5.000","6.000","7.000","8.000","9.000","10.000","12.000","16.000","24.000","32.000",};
	values[] = {31,42,63,83,100,111,125,143,167,200,250,333,500,556,571,600,667,750,800,833,1000,1200,1250,1333,1500,1667,1750,1800,2000,3000,4000,5000,6000,7000,8000,9000,10000,12000,16000,24000,32000,};
	default = 4000;
};
class CRA_PM_PG_Init {
	title = " ------  Progress | x0[%]";
	texts[] = {"0","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","53","54","55","56","57","58","59","60","61","62","63","64","65","66","67","68","69","70","71","72","73","74","75","76","77","78","79","80","81","82","83","84","85","86","87","88","89","90","91","92","93","94","95","96","97","98","99","100"};
	values[] = {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100};
	default = 0;
};
class CRA_PM_PG_Final {
	title = " ------  Progress | x1[%]";
	texts[] = {"0","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","53","54","55","56","57","58","59","60","61","62","63","64","65","66","67","68","69","70","71","72","73","74","75","76","77","78","79","80","81","82","83","84","85","86","87","88","89","90","91","92","93","94","95","96","97","98","99","100"};
	values[] = {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100};
	default = 100;
};
class CRA_PM_EquipmentMode {
	title = " ------  Equipment Quality | f(x)";
	texts[] = {"Constant | f(x) = x0","Linear | f(x) = x0 + (x1 - x0) * x * a","Parabolic | f(x) = x0 + (x1 - x0) * x^a","Reverse Linear | f(x) = x1 + (x0 - x1) * (1 - x) * a","Reverse Parabolic | f(x) = x1 + (x0 - x1) * (1 - x)^a"};
	values[] = {0,1,2,3,4};
	default = 1;
};
class CRA_PM_EquipmentFactor {
	title = " ------  Equipment Quality | a";
	texts[] = {"0.031","0.042","0.063","0.083","0.100","0.111","0.125","0.143","0.167","0.200","0.250","0.333","0.500","0.556","0.571","0.600","0.667","0.750","0.800","0.833","1.000","1.200","1.250","1.333","1.500","1.667","1.750","1.800","2.000","3.000","4.000","5.000","6.000","7.000","8.000","9.000","10.000","12.000","16.000","24.000","32.000",};
	values[] = {31,42,63,83,100,111,125,143,167,200,250,333,500,556,571,600,667,750,800,833,1000,1200,1250,1333,1500,1667,1750,1800,2000,3000,4000,5000,6000,7000,8000,9000,10000,12000,16000,24000,32000,};
	default = 1000;
};
class CRA_PM_EquipmentInit {
	title = " ------  Equipment Quality | x0[%]";
	texts[] = {"0","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","53","54","55","56","57","58","59","60","61","62","63","64","65","66","67","68","69","70","71","72","73","74","75","76","77","78","79","80","81","82","83","84","85","86","87","88","89","90","91","92","93","94","95","96","97","98","99","100"};
	values[] = {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100};
	default = 0;
};
class CRA_PM_EquipmentFinal {
	title = " ------  Equipment Quality | x1[%]";
	texts[] = {"0","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","53","54","55","56","57","58","59","60","61","62","63","64","65","66","67","68","69","70","71","72","73","74","75","76","77","78","79","80","81","82","83","84","85","86","87","88","89","90","91","92","93","94","95","96","97","98","99","100"};
	values[] = {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100};
	default = 100;
};
class CRA_PM_ActivationMode {
	title = " ------  Activation Range | f(x)";
	texts[] = {"Constant | f(x) = x0","Linear | f(x) = x0 + (x1 - x0) * x * a","Parabolic | f(x) = x0 + (x1 - x0) * x^a","Reverse Linear | f(x) = x1 + (x0 - x1) * (1 - x) * a","Reverse Parabolic | f(x) = x1 + (x0 - x1) * (1 - x)^a"};
	values[] = {0,1,2,3,4};
	default = 0;
};
class CRA_PM_ActivationFactor {
	title = " ------  Activation Range | a";
	texts[] = {"0.031","0.042","0.063","0.083","0.100","0.111","0.125","0.143","0.167","0.200","0.250","0.333","0.500","0.556","0.571","0.600","0.667","0.750","0.800","0.833","1.000","1.200","1.250","1.333","1.500","1.667","1.750","1.800","2.000","3.000","4.000","5.000","6.000","7.000","8.000","9.000","10.000","12.000","16.000","24.000","32.000",};
	values[] = {31,42,63,83,100,111,125,143,167,200,250,333,500,556,571,600,667,750,800,833,1000,1200,1250,1333,1500,1667,1750,1800,2000,3000,4000,5000,6000,7000,8000,9000,10000,12000,16000,24000,32000,};
	default = 2000;
};
class CRA_PM_ActivationInit {
	title = " ------  Activation Range | x0[m]";
	texts[] = {"500","550","600","650","700","750","800","850","900","950","1000","1050","1100","1150","1200","1250","1300","1350","1400","1450","1500","1550","1600","1650","1700","1750","1800","1850","1900","1950","2000","2050","2100","2150","2200","2250","2300","2350","2400","2450","2500"};
	values[] = {500,550,600,650,700,750,800,850,900,950,1000,1050,1100,1150,1200,1250,1300,1350,1400,1450,1500,1550,1600,1650,1700,1750,1800,1850,1900,1950,2000,2050,2100,2150,2200,2250,2300,2350,2400,2450,2500};
	default = 700;
};
class CRA_PM_ActivationFinal {
	title = " ------  Activation Range | x1[m]";
	texts[] = {"500","550","600","650","700","750","800","850","900","950","1000","1050","1100","1150","1200","1250","1300","1350","1400","1450","1500","1550","1600","1650","1700","1750","1800","1850","1900","1950","2000","2050","2100","2150","2200","2250","2300","2350","2400","2450","2500"};
	values[] = {500,550,600,650,700,750,800,850,900,950,1000,1050,1100,1150,1200,1250,1300,1350,1400,1450,1500,1550,1600,1650,1700,1750,1800,1850,1900,1950,2000,2050,2100,2150,2200,2250,2300,2350,2400,2450,2500};
	default = 1400;
};

class CRA_PM_EnemyArmyMode {
	title = " ------  OPFOR Presence | f(x)";
	texts[] = {"Constant | f(x) = x0","Linear | f(x) = x0 + (x1 - x0) * x * a","Parabolic | f(x) = x0 + (x1 - x0) * x^a","Reverse Linear | f(x) = x1 + (x0 - x1) * (1 - x) * a","Reverse Parabolic | f(x) = x1 + (x0 - x1) * (1 - x)^a"};
	values[] = {0,1,2,3,4};
	default = 4;
};
class CRA_PM_EnemyArmyFactor {
	title = " ------  OPFOR Presence | a";
	texts[] = {"0.031","0.042","0.063","0.083","0.100","0.111","0.125","0.143","0.167","0.200","0.250","0.333","0.500","0.556","0.571","0.600","0.667","0.750","0.800","0.833","1.000","1.200","1.250","1.333","1.500","1.667","1.750","1.800","2.000","3.000","4.000","5.000","6.000","7.000","8.000","9.000","10.000","12.000","16.000","24.000","32.000",};
	values[] = {31,42,63,83,100,111,125,143,167,200,250,333,500,556,571,600,667,750,800,833,1000,1200,1250,1333,1500,1667,1750,1800,2000,3000,4000,5000,6000,7000,8000,9000,10000,12000,16000,24000,32000,};
	default = 2000;
};
class CRA_PM_EnemyArmyInit {
	title = " ------  OPFOR Presence | x0[%]";
	texts[] = {"0","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","53","54","55","56","57","58","59","60","61","62","63","64","65","66","67","68","69","70","71","72","73","74","75","76","77","78","79","80","81","82","83","84","85","86","87","88","89","90","91","92","93","94","95","96","97","98","99","100"};
	values[] = {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100};
	default = 0;
};
class CRA_PM_EnemyArmyFinal {
	title = " ------  OPFOR Presence | x1[%]";
	texts[] = {"0","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","53","54","55","56","57","58","59","60","61","62","63","64","65","66","67","68","69","70","71","72","73","74","75","76","77","78","79","80","81","82","83","84","85","86","87","88","89","90","91","92","93","94","95","96","97","98","99","100"};
	values[] = {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100};
	default = 100;
};
class CRA_PM_EnemyCountMode {
	title = " ------  Enemy Count | f(x)";
	texts[] = {"Constant | f(x) = x0","Linear | f(x) = x0 + (x1 - x0) * x * a","Parabolic | f(x) = x0 + (x1 - x0) * x^a","Reverse Linear | f(x) = x1 + (x0 - x1) * (1 - x) * a","Reverse Parabolic | f(x) = x1 + (x0 - x1) * (1 - x)^a"};
	values[] = {0,1,2,3,4};
	default = 1;
};
class CRA_PM_EnemyCountFactor {
	title = " ------  Enemy Count | a";
	texts[] = {"0.031","0.042","0.063","0.083","0.100","0.111","0.125","0.143","0.167","0.200","0.250","0.333","0.500","0.556","0.571","0.600","0.667","0.750","0.800","0.833","1.000","1.200","1.250","1.333","1.500","1.667","1.750","1.800","2.000","3.000","4.000","5.000","6.000","7.000","8.000","9.000","10.000","12.000","16.000","24.000","32.000",};
	values[] = {31,42,63,83,100,111,125,143,167,200,250,333,500,556,571,600,667,750,800,833,1000,1200,1250,1333,1500,1667,1750,1800,2000,3000,4000,5000,6000,7000,8000,9000,10000,12000,16000,24000,32000,};
	default = 1000;
};
class CRA_PM_EnemyCountInit {
	title = " ------  Enemy Count | x0[%]";
	texts[] = {"0","5","10","15","20","25","30","35","40","45","50","55","60","65","70","75","80","85","90","95","100","105","110","115","120","125","130","135","140","145","150","155","160","165","170","175","180","185","190","195","200","205","210","215","220","225","230","235","240","245","250","255","260","265","270","275","280","285","290","295","300","305","310","315","320","325","330","335","340","345","350","355","360","365","370","375","380","385","390","395","400"};
	values[] = {0,5,10,15,20,25,30,35,40,45,50,55,60,65,70,75,80,85,90,95,100,105,110,115,120,125,130,135,140,145,150,155,160,165,170,175,180,185,190,195,200,205,210,215,220,225,230,235,240,245,250,255,260,265,270,275,280,285,290,295,300,305,310,315,320,325,330,335,340,345,350,355,360,365,370,375,380,385,390,395,400};
	default = 100;
};
class CRA_PM_EnemyCountFinal {
	title = " ------  Enemy Count | x1[%]";
	texts[] = {"0","5","10","15","20","25","30","35","40","45","50","55","60","65","70","75","80","85","90","95","100","105","110","115","120","125","130","135","140","145","150","155","160","165","170","175","180","185","190","195","200","205","210","215","220","225","230","235","240","245","250","255","260","265","270","275","280","285","290","295","300","305","310","315","320","325","330","335","340","345","350","355","360","365","370","375","380","385","390","395","400"};
	values[] = {0,5,10,15,20,25,30,35,40,45,50,55,60,65,70,75,80,85,90,95,100,105,110,115,120,125,130,135,140,145,150,155,160,165,170,175,180,185,190,195,200,205,210,215,220,225,230,235,240,245,250,255,260,265,270,275,280,285,290,295,300,305,310,315,320,325,330,335,340,345,350,355,360,365,370,375,380,385,390,395,400};
	default = 200;
};
class CRA_PM_EnemyCountPlayerMode {
	title = " ------  Enemy Count Additional Players | f(x)";
	texts[] = {"Constant | f(x) = x0","Linear | f(x) = x0 + (x1 - x0) * x * a","Parabolic | f(x) = x0 + (x1 - x0) * x^a","Reverse Linear | f(x) = x1 + (x0 - x1) * (1 - x) * a","Reverse Parabolic | f(x) = x1 + (x0 - x1) * (1 - x)^a"};
	values[] = {0,1,2,3,4};
	default = 2;
};
class CRA_PM_EnemyCountPlayerFactor {
	title = " ------  Enemy Count Additional Players | a";
	texts[] = {"0.031","0.042","0.063","0.083","0.100","0.111","0.125","0.143","0.167","0.200","0.250","0.333","0.500","0.556","0.571","0.600","0.667","0.750","0.800","0.833","1.000","1.200","1.250","1.333","1.500","1.667","1.750","1.800","2.000","3.000","4.000","5.000","6.000","7.000","8.000","9.000","10.000","12.000","16.000","24.000","32.000",};
	values[] = {31,42,63,83,100,111,125,143,167,200,250,333,500,556,571,600,667,750,800,833,1000,1200,1250,1333,1500,1667,1750,1800,2000,3000,4000,5000,6000,7000,8000,9000,10000,12000,16000,24000,32000,};
	default = 667;
};
class CRA_PM_EnemyCountPlayerInit {
	title = " ------  Enemy Count Additional Players | x0[%]";
	texts[] = {"0","5","10","15","20","25","30","35","40","45","50","55","60","65","70","75","80","85","90","95","100","105","110","115","120","125","130","135","140","145","150","155","160","165","170","175","180","185","190","195","200","205","210","215","220","225","230","235","240","245","250","255","260","265","270","275","280","285","290","295","300","305","310","315","320","325","330","335","340","345","350","355","360","365","370","375","380","385","390","395","400"};
	values[] = {0,5,10,15,20,25,30,35,40,45,50,55,60,65,70,75,80,85,90,95,100,105,110,115,120,125,130,135,140,145,150,155,160,165,170,175,180,185,190,195,200,205,210,215,220,225,230,235,240,245,250,255,260,265,270,275,280,285,290,295,300,305,310,315,320,325,330,335,340,345,350,355,360,365,370,375,380,385,390,395,400};
	default = 100;
};
class CRA_PM_EnemyCountPlayerFinal {
	title = " ------  Enemy Count Additional Players | x1[%]";
	texts[] = {"0","5","10","15","20","25","30","35","40","45","50","55","60","65","70","75","80","85","90","95","100","105","110","115","120","125","130","135","140","145","150","155","160","165","170","175","180","185","190","195","200","205","210","215","220","225","230","235","240","245","250","255","260","265","270","275","280","285","290","295","300","305","310","315","320","325","330","335","340","345","350","355","360","365","370","375","380","385","390","395","400"};
	values[] = {0,5,10,15,20,25,30,35,40,45,50,55,60,65,70,75,80,85,90,95,100,105,110,115,120,125,130,135,140,145,150,155,160,165,170,175,180,185,190,195,200,205,210,215,220,225,230,235,240,245,250,255,260,265,270,275,280,285,290,295,300,305,310,315,320,325,330,335,340,345,350,355,360,365,370,375,380,385,390,395,400};
	default = 285;
};
class CRA_PM_EnemyCountVarianceMode {
	title = " ------  Enemy Count Variance | f(x)";
	texts[] = {"Constant | f(x) = x0","Linear | f(x) = x0 + (x1 - x0) * x * a","Parabolic | f(x) = x0 + (x1 - x0) * x^a","Reverse Linear | f(x) = x1 + (x0 - x1) * (1 - x) * a","Reverse Parabolic | f(x) = x1 + (x0 - x1) * (1 - x)^a"};
	values[] = {0,1,2,3,4};
	default = 1;
};
class CRA_PM_EnemyCountVarianceFactor {
	title = " ------  Enemy Count Variance | a";
	texts[] = {"0.031","0.042","0.063","0.083","0.100","0.111","0.125","0.143","0.167","0.200","0.250","0.333","0.500","0.556","0.571","0.600","0.667","0.750","0.800","0.833","1.000","1.200","1.250","1.333","1.500","1.667","1.750","1.800","2.000","3.000","4.000","5.000","6.000","7.000","8.000","9.000","10.000","12.000","16.000","24.000","32.000",};
	values[] = {31,42,63,83,100,111,125,143,167,200,250,333,500,556,571,600,667,750,800,833,1000,1200,1250,1333,1500,1667,1750,1800,2000,3000,4000,5000,6000,7000,8000,9000,10000,12000,16000,24000,32000,};
	default = 1000;
};
class CRA_PM_EnemyCountVarianceInit {
	title = " ------  Enemy Count Variance | x0[%]";
	texts[] = {"0","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","53","54","55","56","57","58","59","60","61","62","63","64","65","66","67","68","69","70","71","72","73","74","75","76","77","78","79","80","81","82","83","84","85","86","87","88","89","90","91","92","93","94","95","96","97","98","99","100"};
	values[] = {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100};
	default = 20;
};
class CRA_PM_EnemyCountVarianceFinal {
	title = " ------  Enemy Count Variance | x1[%]";
	texts[] = {"0","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","53","54","55","56","57","58","59","60","61","62","63","64","65","66","67","68","69","70","71","72","73","74","75","76","77","78","79","80","81","82","83","84","85","86","87","88","89","90","91","92","93","94","95","96","97","98","99","100"};
	values[] = {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100};
	default = 10;
};
class CRA_PM_EnemyCountVarianceDist {
	title = " ------  Enemy Count Variance | P(X)";
	texts[] = {"Uniform","Normal/Gaussian"};
	values[] = {0,1};
	default = 0;
};
class CRA_PM_EnemySkillMode {
	title = " ------  Enemy Skill | f(x)";
	texts[] = {"Constant | f(x) = x0","Linear | f(x) = x0 + (x1 - x0) * x * a","Parabolic | f(x) = x0 + (x1 - x0) * x^a","Reverse Linear | f(x) = x1 + (x0 - x1) * (1 - x) * a","Reverse Parabolic | f(x) = x1 + (x0 - x1) * (1 - x)^a"};
	values[] = {0,1,2,3,4};
	default = 0;
};
class CRA_PM_EnemySkillFactor {
	title = " ------  Enemy Skill | a";
	texts[] = {"0.031","0.042","0.063","0.083","0.100","0.111","0.125","0.143","0.167","0.200","0.250","0.333","0.500","0.556","0.571","0.600","0.667","0.750","0.800","0.833","1.000","1.200","1.250","1.333","1.500","1.667","1.750","1.800","2.000","3.000","4.000","5.000","6.000","7.000","8.000","9.000","10.000","12.000","16.000","24.000","32.000",};
	values[] = {31,42,63,83,100,111,125,143,167,200,250,333,500,556,571,600,667,750,800,833,1000,1200,1250,1333,1500,1667,1750,1800,2000,3000,4000,5000,6000,7000,8000,9000,10000,12000,16000,24000,32000,};
	default = 1000;
};
class CRA_PM_EnemySkillInit {
	title = " ------  Enemy Skill | x0[%]";
	texts[] = {"0","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","53","54","55","56","57","58","59","60","61","62","63","64","65","66","67","68","69","70","71","72","73","74","75","76","77","78","79","80","81","82","83","84","85","86","87","88","89","90","91","92","93","94","95","96","97","98","99","100"};
	values[] = {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100};
	default = 20;
};
class CRA_PM_EnemySkillFinal {
	title = " ------  Enemy Skill | x1[%]";
	texts[] = {"0","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","53","54","55","56","57","58","59","60","61","62","63","64","65","66","67","68","69","70","71","72","73","74","75","76","77","78","79","80","81","82","83","84","85","86","87","88","89","90","91","92","93","94","95","96","97","98","99","100"};
	values[] = {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100};
	default = 25;
};
class CRA_PM_EnemySkillVarianceMode {
	title = " ------  Enemy Skill Variance | f(x)";
	texts[] = {"Constant | f(x) = x0","Linear | f(x) = x0 + (x1 - x0) * x * a","Parabolic | f(x) = x0 + (x1 - x0) * x^a","Reverse Linear | f(x) = x1 + (x0 - x1) * (1 - x) * a","Reverse Parabolic | f(x) = x1 + (x0 - x1) * (1 - x)^a"};
	values[] = {0,1,2,3,4};
	default = 0;
};
class CRA_PM_EnemySkillVarianceFactor {
	title = " ------  Enemy Skill Variance | a";
	texts[] = {"0.031","0.042","0.063","0.083","0.100","0.111","0.125","0.143","0.167","0.200","0.250","0.333","0.500","0.556","0.571","0.600","0.667","0.750","0.800","0.833","1.000","1.200","1.250","1.333","1.500","1.667","1.750","1.800","2.000","3.000","4.000","5.000","6.000","7.000","8.000","9.000","10.000","12.000","16.000","24.000","32.000",};
	values[] = {31,42,63,83,100,111,125,143,167,200,250,333,500,556,571,600,667,750,800,833,1000,1200,1250,1333,1500,1667,1750,1800,2000,3000,4000,5000,6000,7000,8000,9000,10000,12000,16000,24000,32000,};
	default = 1000;
};
class CRA_PM_EnemySkillVarianceInit {
	title = " ------  Enemy Skill Variance | x0[%]";
	texts[] = {"0","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","53","54","55","56","57","58","59","60","61","62","63","64","65","66","67","68","69","70","71","72","73","74","75","76","77","78","79","80","81","82","83","84","85","86","87","88","89","90","91","92","93","94","95","96","97","98","99","100"};
	values[] = {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100};
	default = 0;
};
class CRA_PM_EnemySkillVarianceFinal {
	title = " ------  Enemy Skill Variance | x1[%]";
	texts[] = {"0","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","53","54","55","56","57","58","59","60","61","62","63","64","65","66","67","68","69","70","71","72","73","74","75","76","77","78","79","80","81","82","83","84","85","86","87","88","89","90","91","92","93","94","95","96","97","98","99","100"};
	values[] = {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100};
	default = 0;
};
class CRA_PM_EnemySkillVarianceDist {
	title = " ------  Enemy Skill Variance | P(X)";
	texts[] = {"Uniform","Normal/Gaussian"};
	values[] = {0,1};
	default = 1;
};
class CRA_PM_AS_AbandonMode {
	title = " ------  Vehicle Abandon Mode";
	texts[] = {"Timeout or Rangeout","Timeout and Rangeout","Timeout","Rangeout","Never"};
	values[] = {1,2,3,4,0};
	default = 1;
};
class CRA_PM_AS_AbandonTime {
	title = " ------  Vehicle Abandon Timeout [min]";
	texts[] = {"1","3","5","10","15","30","60"};
	values[] = {60,180,300,600,900,1800,3600};
	default = 900;
};
class CRA_PM_AS_RespawnAbandon {
	title = " ------  Vehicle Abandoned Respawn [min]";
	texts[] = {"0","1","3","5","10","15","30","Never"};
	values[] = {0,60,180,300,600,900,1800,-1};
	default = 0;
};
class CRA_PM_AS_RespawnWreck {
	title = " ------  Vehicle Wrecked Respawn [min]";
	texts[] = {"0","1","3","5","10","15","30","Never"};
	values[] = {0,60,180,300,600,900,1800,-1};
	default = 180;
};
class CRA_PM_CivilianCarProbability {
	title = " ------  Civilian Car Probability [%]";
	texts[] = {"0","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","53","54","55","56","57","58","59","60","61","62","63","64","65","66","67","68","69","70","71","72","73","74","75","76","77","78","79","80","81","82","83","84","85","86","87","88","89","90","91","92","93","94","95","96","97","98","99","100"};
	values[] = {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100};
	default = 85;
};
class CRA_PM_CivilianCarCount {
	title = " ------  Civilian Car Count";
	texts[] = {"0","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32"};
	values[] = {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32};
	default = 6;
};
class CRA_PM_CivilianPlaneProbability {
	title = " ------  Civilian Plane Probability [%]";
	texts[] = {"0","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","53","54","55","56","57","58","59","60","61","62","63","64","65","66","67","68","69","70","71","72","73","74","75","76","77","78","79","80","81","82","83","84","85","86","87","88","89","90","91","92","93","94","95","96","97","98","99","100"};
	values[] = {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100};
	default = 3;
};
class CRA_PM_CivilianPlaneCount {
	title = " ------  Civilian Plane Count";
	texts[] = {"0","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32"};
	values[] = {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32};
	default = 2;
};
class CRA_PM_CivilianHeliProbability {
	title = " ------  Civilian Helicopter Probability [%]";
	texts[] = {"0","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","53","54","55","56","57","58","59","60","61","62","63","64","65","66","67","68","69","70","71","72","73","74","75","76","77","78","79","80","81","82","83","84","85","86","87","88","89","90","91","92","93","94","95","96","97","98","99","100"};
	values[] = {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100};
	default = 2;
};
class CRA_PM_CivilianHeliCount {
	title = " ------  Civilian Helicopter Count";
	texts[] = {"0","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32"};
	values[] = {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32};
	default = 2;
};
