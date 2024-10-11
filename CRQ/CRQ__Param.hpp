
class CRQ_MissionTimeStartHour {
	title = "CRQ | Mission Start [hh]";
	texts[] = {"Random","Dawn","Morning","Noon","Afternoon","Evening","Night","00","01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23"};
	values[] = {-1,-2,-3,-4,-5,-6,-7,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23};
	default = -2;
};
class CRQ_MissionTimeStartMinute {
	title = "CRQ | Mission Start [mm]";
	texts[] = {"Random","00","01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","53","54","55","56","57","58","59"};
	values[] = {-1,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59};
	default = -1;
};
class CRQ_EnvironmentGrass {
	title = "CRQ | Environment Grass";
	texts[] = {"None","Normal","Max"};
	values[] = {500,250,125};
	default = 500;
};
/*
class CRQ_EnvironmentWeather {
	title = "CRQ | Environment Weather -- NOT YET IMPLEMENTED";
	texts[] = {"Always Sunny","Always Mild","Always Bleak","Always Rainy","Always Stormy","Random Realistic","Random Implausible"};
	values[] = {0,25,50,75,100,-1,-2};
	default = 0;
};
class CRQ_EnvironmentFog {
	title = "CRQ | Environment Fog -- NOT YET IMPLEMENTED";
	texts[] = {"Never","Always"};
	values[] = {0,100};
	default = 0;
};
*/
class CRQ_CorpseDecay {
	title = "CRQ | Corpses Decay [min]";
	texts[] = {"1","5","10","15","30","60","90","120"};
	values[] = {60,300,600,900,1800,3600,5400,7200};
	default = 1800;
};
class CRQ_CorpseCount {
	title = "CRQ | Corpses Max";
	texts[] = {"8","16","32","64","128","256","512"};
	values[] = {8,16,32,64,128,256,512};
	default = 128;
};
class CRQ_WreckDecay {
	title = "CRQ | Wrecks Decay [min]";
	texts[] = {"1","5","10","15","30","60","90","120"};
	values[] = {60,300,600,900,1800,3600,5400,7200};
	default = 600;
};
class CRQ_WreckCount {
	title = "CRQ | Wrecks Max";
	texts[] = {"4","8","16","32","64","128","256"};
	values[] = {4,8,16,32,64,128,256};
	default = 32;
};
class CRQ_PlayerFatigue {
	title = "CRQ | Player Fatigue";
	texts[] = {"Enable","Disable"};
	values[] = {1,0};
	default = 0;
};
class CRQ_PlayerSway {
	title = "CRQ | Player Weapon Sway [%]";
	texts[] = {"0","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","53","54","55","56","57","58","59","60","61","62","63","64","65","66","67","68","69","70","71","72","73","74","75","76","77","78","79","80","81","82","83","84","85","86","87","88","89","90","91","92","93","94","95","96","97","98","99","100"};
	values[] = {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100};
	default = 0;
};
class CRQ_PlayerMedic {
	title = "CRQ | Player Trait Medic";
	texts[] = {"Enable","Disable"};
	values[] = {1,0};
	default = 1;
};
class CRQ_PlayerEngineer {
	title = "CRQ | Player Trait Engineer";
	texts[] = {"Enable","Disable"};
	values[] = {1,0};
	default = 1;
};
class CRQ_PlayerExplosiveSpecialist {
	title = "CRQ | Player Trait Explosive Specialist";
	texts[] = {"Enable","Disable"};
	values[] = {1,0};
	default = 1;
};
class CRQ_PlayerUAVHacker {
	title = "CRQ | Player Trait UAV Hacker";
	texts[] = {"Enable","Disable"};
	values[] = {1,0};
	default = 1;
};
