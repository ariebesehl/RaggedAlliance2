
class Params {
	class CRQ_MS_TimeStartHH {
		title = "CRQ | Mission Start [hh:]";
		texts[] = {"Random","Dawn","Morning","Noon","Afternoon","Evening","Night","00","01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23"};
		values[] = {-1,-2,-3,-4,-5,-6,-7,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23};
		default = -2;
	};
	class CRQ_MS_TimeStartMM {
		title = "CRQ | Mission Start [:mm]";
		texts[] = {"Random","00","01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","53","54","55","56","57","58","59"};
		values[] = {-1,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59};
		default = -1;
	};
	class CRQ_EN_Grass {
		title = "CRQ | Environment Grass";
		texts[] = {"None","Less","Normal","More","Max"};
		values[] = {500,375,250,188,125};
		default = 500;
	};
	/*
	class CRQ_EN_Weather {
		title = "CRQ | Environment Weather -- NOT YET IMPLEMENTED";
		texts[] = {"Always Sunny","Always Mild","Always Bleak","Always Rainy","Always Stormy","Random Realistic","Random Implausible"};
		values[] = {0,25,50,75,100,-1,-2};
		default = 0;
	};
	class CRQ_EN_Fog {
		title = "CRQ | Environment Fog -- NOT YET IMPLEMENTED";
		texts[] = {"Never","Always"};
		values[] = {0,100};
		default = 0;
	};
	*/
	class CRQ_GC_CountCorpse {
		title = "CRQ | Corpses Max";
		texts[] = {"8","16","32","64","128","256","512","1024","2048","4096"};
		values[] = {8,16,32,64,128,256,512,1024,2048,4096};
		default = 256;
	};
	class CRQ_GC_CountWreck {
		title = "CRQ | Wrecks Max";
		texts[] = {"4","8","16","32","64","128","256","512"};
		values[] = {4,8,16,32,64,128,256,512};
		default = 64;
	};
	class CRQ_GC_DecayCorpse {
		title = "CRQ | Corpses Decay [min]";
		texts[] = {"1","5","10","15","30","60","90","120","240","480"};
		values[] = {60,300,600,900,1800,3600,5400,7200,14400,28800};
		default = 3600;
	};
	class CRQ_GC_DecayWreck {
		title = "CRQ | Wrecks Decay [min]";
		texts[] = {"1","5","10","15","30","60","90","120","240","480"};
		values[] = {60,300,600,900,1800,3600,5400,7200,14400,28800};
		default = 900;
	};
	class CRQ_PL_Sway {
		title = "CRQ | Player Weapon Sway [%]";
		texts[] = {"0","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","53","54","55","56","57","58","59","60","61","62","63","64","65","66","67","68","69","70","71","72","73","74","75","76","77","78","79","80","81","82","83","84","85","86","87","88","89","90","91","92","93","94","95","96","97","98","99","100"};
		values[] = {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100};
		default = 0;
	};
	class CRQ_PL_Fatigue {
		title = "CRQ | Player Fatigue";
		texts[] = {"Enable","Disable"};
		values[] = {1,0};
		default = 0;
	};
	class CRQ_PL_TraitMed {
		title = "CRQ | Player Trait Medic";
		texts[] = {"Enable","Disable"};
		values[] = {1,0};
		default = 1;
	};
	class CRQ_PL_TraitEng {
		title = "CRQ | Player Trait Engineer";
		texts[] = {"Enable","Disable"};
		values[] = {1,0};
		default = 1;
	};
	class CRQ_PL_TraitExp {
		title = "CRQ | Player Trait Explosive Specialist";
		texts[] = {"Enable","Disable"};
		values[] = {1,0};
		default = 1;
	};
	class CRQ_PL_TraitHak {
		title = "CRQ | Player Trait UAV Hacker";
		texts[] = {"Enable","Disable"};
		values[] = {1,0};
		default = 1;
	};
	#include "..\CQM\CQM__DEF__Param.hpp"
};
