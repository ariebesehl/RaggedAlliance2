
class Params {
	class CRQ_PM_Label_1 {
		title = "CRQ | Param";
		texts[] = {"","[--- this is a decorative placeholder ---]"};
		values[] = {0,-1};
		default = 0;
	};
	/*
	class CRQ_PM_MS_StartYY {
		title = " ------  Mission | Start [YYYY-]";
		texts[] = {"Ignored","1970","1971","1972","1973","1974","1975","1976","1977","1978","1979","1980","1981","1982","1983","1984","1985","1986","1987","1988","1989","1990","1991","1992","1993","1994","1995","1996","1997","1998","1999","2000","2001","2002","2003","2004","2005","2006","2007","2008","2009","2010","2011","2012","2013","2014","2015","2016","2017","2018","2019","2020","2021","2022","2023","2024","2025","2026","2027","2028","2029","2030","2031","2032","2033","2034","2035","2036","2037"};
		values[] = {0,68,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67};
		default = 0;
	};
	class CRQ_PM_MS_StartMN {
		title = " ------  Mission | Start [-MM-]";
		texts[] = {"Ignored","01","02","03","04","05","06","07","08","09","10","11","12"};
		values[] = {0,12,1,2,3,4,5,6,7,8,9,10,11};
		default = 0;
	};
	class CRQ_PM_MS_StartDD {
		title = " ------  Mission | Start [hh:]";
		texts[] = {"Ignored","01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31"};
		values[] = {0,31,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30};
		default = 0;
	};
	*/
	class CRQ_PM_MS_StartHH {
		title = " ------  Mission | Start [hh:]";
		texts[] = {"Ignored","Live (local)","Live (UTC)","Random","Dawn","Morning","Noon","Afternoon","Evening","Night","00","01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23"};
		values[] = {0,-1,-2,-3,-4,-5,-6,-7,-8,-9,24,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23};
		default = -4;
	};
	class CRQ_PM_MS_StartMM {
		title = " ------  Mission | Start [:mm]";
		texts[] = {"Ignored","Live (local)","Live (UTC)","Random","00","01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","53","54","55","56","57","58","59"};
		values[] = {0,-1,-2,-3,60,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59};
		default = -3;
	};
	class CRQ_PM_EN_Grass {
		title = " ------  Environment | Grass";
		texts[] = {"Ignored", "Grid 50.000 - None","Grid 37.500 - Less","Grid 25.000 - Normal","Grid 18.750 - More","Grid 12.500 - Max","Grid 06.250 - 'xtra1'","Grid 03.125 - 'xtra2'","Grid 01.563 - 'xtra3'","Grid 00.782 - 'xtra4'"};
		values[] = {0, 50000,37500,25000,18750,12500,6250,3125,1563,782};
		default = 50000;
	};
	/*
	class CRQ_PM_EN_Weather {
		title = " ------  Environment | Weather -- NOT YET IMPLEMENTED";
		texts[] = {"Always Sunny","Always Mild","Always Bleak","Always Rainy","Always Stormy","Random Realistic","Random Implausible"};
		values[] = {0,25,50,75,100,-1,-2};
		default = 0;
	};
	class CRQ_PM_EN_Fog {
		title = " ------  Environment | Fog -- NOT YET IMPLEMENTED";
		texts[] = {"Never","Always"};
		values[] = {0,100};
		default = 0;
	};
	*/
	class CRQ_PM_GC_CountCorpse {
		title = " ------  Remains | Max Corpses";
		texts[] = {"8","16","32","64","128","256","512","1024","2048","4096"};
		values[] = {8,16,32,64,128,256,512,1024,2048,4096};
		default = 256;
	};
	class CRQ_PM_GC_CountWreck {
		title = " ------  Remains | Max Wrecks";
		texts[] = {"4","8","16","32","64","128","256","512"};
		values[] = {4,8,16,32,64,128,256,512};
		default = 64;
	};
	class CRQ_PM_GC_DecayCorpse {
		title = " ------  Remains | Decay Corpses [min]";
		texts[] = {"1","5","10","15","30","60","90","120","240","480"};
		values[] = {60,300,600,900,1800,3600,5400,7200,14400,28800};
		default = 3600;
	};
	class CRQ_PM_GC_DecayWreck {
		title = " ------  Remains | Decay Wrecks [min]";
		texts[] = {"1","5","10","15","30","60","90","120","240","480"};
		values[] = {60,300,600,900,1800,3600,5400,7200,14400,28800};
		default = 900;
	};
	class CRQ_PM_PL_Fatigue {
		title = " ------  Player | Energy | Fatigue";
		texts[] = {"Ignored","Disable", "Force"};
		values[] = {1,0,2};
		default = 0;
	};
	class CRQ_PM_PL_Stamina {
		title = " ------  Player | Energy | Stamina";
		texts[] = {"Ignored","Disable", "Force"};
		values[] = {1,0,2};
		default = 0;
	};
	class CRQ_PM_PL_TraitMed {
		title = " ------  Player | Trait | Medic";
		texts[] = {"Ignored","Disable", "Force"};
		values[] = {1,0,2};
		default = 2;
	};
	class CRQ_PM_PL_TraitEng {
		title = " ------  Player | Trait | Engineer";
		texts[] = {"Ignored","Disable", "Force"};
		values[] = {1,0,2};
		default = 2;
	};
	class CRQ_PM_PL_TraitExp {
		title = " ------  Player | Trait | Explosives Specialist";
		texts[] = {"Ignored","Disable", "Force"};
		values[] = {1,0,2};
		default = 2;
	};
	class CRQ_PM_PL_TraitHak {
		title = " ------  Player | Trait | UAV Hacker";
		texts[] = {"Ignored","Disable", "Force"};
		values[] = {1,0,2};
		default = 2;
	};
	class CRQ_PM_PL_Sway {
		title = " ------  Player | Marksmanship | Weapon Sway [%]";
		texts[] = {"0","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","53","54","55","56","57","58","59","60","61","62","63","64","65","66","67","68","69","70","71","72","73","74","75","76","77","78","79","80","81","82","83","84","85","86","87","88","89","90","91","92","93","94","95","96","97","98","99","100"};
		values[] = {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100};
		default = 0;
	};
	class CRQ_PM_Label_2 {
		title = "";
		texts[] = {"","[--- this is a decorative placeholder ---]"};
		values[] = {0,-1};
		default = 0;
	};
	class CRQ_PM_Label_3 {
		title = "CQM | Param";
		texts[] = {"","[--- this is a decorative placeholder ---]"};
		values[] = {0,-1};
		default = 0;
	};
	
	#include "..\CQM\CQM__INC__Param.hpp"
	
	class CRQ_PM_Label_0 {
		title = "";
		texts[] = {"","[--- this is a decorative placeholder ---]"};
		values[] = {0,-1};
		default = 0;
	};
};
