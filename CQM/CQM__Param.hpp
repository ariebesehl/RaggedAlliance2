
class Params
{
	class CRQ_MissionTimeStartHour
	{
		title = "Mission Start Time (Hour)";
		texts[] = {"Random","Dawn","Morning","Noon","Afternoon","Evening","Night","00","01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23"};
		values[] = {-1,-2,-3,-4,-5,-6,-7,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23};
		default = -2;
	};
	class CRQ_MissionTimeStartMinute
	{
		title = "Mission Start Time (Minute)";
		texts[] = {"Random","00","01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","53","54","55","56","57","58","59"};
		values[] = {-1,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59};
		default = -1;
	};
	class CRQ_EnvironmentGrass
	{
		title = "Environment Grass";
		texts[] = {"None","Normal","Max"};
		values[] = {500,250,125};
		default = 500;
	};
	
	/*
	class CRQ_EnvironmentWeather
	{
		title = "Environment Weather -- NOT YET IMPLEMENTED";
		texts[] = {"Always Sunny","Always Mild","Always Bleak","Always Rainy","Always Stormy","Random Realistic","Random Implausible"};
		values[] = {0,25,50,75,100,-1,-2};
		default = 0;
	};
	class CRQ_EnvironmentFog
	{
		title = "Environment Fog -- NOT YET IMPLEMENTED";
		texts[] = {"Never","Always"};
		values[] = {0,100};
		default = 0;
	};
	*/
	
	class CRQ_CorpseDecay
	{
		title = "Corpses Decay (Minutes)";
		texts[] = {"1","5","10","15","30","60"};
		values[] = {60,300,600,900,1800,3600};
		default = 900;
	};
	class CRQ_CorpseCount
	{
		title = "Corpses Max -- NOT YET IMPLEMENTED";
		texts[] = {"8","15","30","60","120","180","360","720"};
		values[] = {8,15,30,60,120,180,360,720};
		default = 180;
	};
	class CRQ_WreckDecay
	{
		title = "Wrecks Decay (Minutes)";
		texts[] = {"1","5","10","15","30","60"};
		values[] = {60,300,600,900,1800,3600};
		default = 600;
	};
	class CRQ_WreckCount
	{
		title = "Wrecks Max -- NOT YET IMPLEMENTED";
		texts[] = {"8","15","30","60","120"};
		values[] = {8,15,30,60,120};
		default = 30;
	};
	class CRQ_PlayerFatigue
	{
		title = "Player Fatigue";
		texts[] = {"Enable","Disable"};
		values[] = {1,0};
		default = 0;
	};
	class CRQ_PlayerMedic
	{
		title = "Player Trait Medic";
		texts[] = {"Enable","Disable"};
		values[] = {1,0};
		default = 1;
	};
	class CRQ_PlayerEngineer
	{
		title = "Player Trait Engineer (includes Explosive Specialist & UAV Hacker)";
		texts[] = {"Enable","Disable"};
		values[] = {1,0};
		default = 1;
	};
	class CRQ_PlayerSway
	{
		title = "Player Weapon Sway";
		texts[] = {"100%","75%","50%","25%","Disabled"};
		values[] = {100,75,50,25,0};
		default = 0;
	};
	class CRA_PlayerStart
	{
		title = "Player Start";
		texts[] = {"Story","Random"};
		values[] = {0,1};
		default = 0;
	};
	class CRA_PlayerIdentity
	{
		title = "Player Identity";
		texts[] = {"User","Story"};
		values[] = {0,1};
		default = 0;
	};
	class CRA_ProgressStart
	{
		title = "Progress Starting (%)";
		texts[] = {"0","5","10","15","20","25","30","35","40","45","50","55","60","65","70","75","80","85","90","95","100"};
		values[] = {0,5,10,15,20,25,30,35,40,45,50,55,60,65,70,75,80,85,90,95,100};
		default = 0;
	};
	class CRA_ProgressSpeed
	{
		title = "Progress Speed (Factor)";
		texts[] = {"0x - None",".5x - Slowest","1x - Slower","2x - Slow","4x - Normal","8x - Fast","16x - Faster","32x - Fastest"};
		values[] = {0,50,100,200,400,800,1600,3200};
		default = 400;
	};
	class CRA_ProgressArmy
	{
		title = "Progress Army";
		texts[] = {"Never","Slowest","Slower","Slow","Normal","Fast","Faster","Fastest","Always"};
		values[] = {0,1,2,3,4,5,6,7,-1};
		default = 2;
	};
	class CRA_TriggerMode
	{
		title = "Activation Mode";
		texts[] = {"Fixed Distance","Progressive Doubling (Linear)"};
		values[] = {0,1};
		default = 1;
	};
	class CRA_TriggerBase
	{
		title = "Activation Base (Meters)";
		texts[] = {"600","800","1000","1200","1400","1600","1800","2000","2200","2400"};
		values[] = {600,800,1000,1200,1400,1600,1800,2000,2200,2400};
		default = 800;
	};
	class CRA_EnemyCountMode
	{
		title = "Enemy Count Mode";
		texts[] = {"Fixed","Progressive Doubling (Linear)"};
		values[] = {0,1};
		default = 1;
	};
	class CRA_EnemyCountPlayer
	{
		title = "Enemy Count Player Count";
		texts[] = {"Unaffected","Square Root","Linear"};
		values[] = {0,1,2};
		default = 1;
	};
	class CRA_EnemyCountBase
	{
		title = "Enemy Count Base (%)";
		texts[] = {"25","50","75","100","125","150","175","200"};
		values[] = {25,50,75,100,125,150,175,200};
		default = 100;
	};
	class CRA_EnemyCountVariance
	{
		title = "Enemy Count Variance (%%)";
		texts[] = {"0","5","10","15","20","25","30","35","40","45","50","55","60","65","70","75","80","85","90","95","100"};
		values[] = {0,5,10,15,20,25,30,35,40,45,50,55,60,65,70,75,80,85,90,95,100};
		default = 25;
	};
	class CRA_EnemySkillMode
	{
		title = "Enemy Skill Mode";
		texts[] = {"Fixed Skill","Progressive Doubling (Linear)"};
		values[] = {0,1};
		default = 1;
	};
	class CRA_EnemySkillBase
	{
		title = "Enemy Skill Base (%)";
		texts[] = {"0","5","10","15","20","25","30","35","40","45","50","55","60","65","70","75","80","85","90","95","100"};
		values[] = {0,5,10,15,20,25,30,35,40,45,50,55,60,65,70,75,80,85,90,95,100};
		default = 20;
	};
	class CRA_EnemySkillVariance
	{
		title = "Enemy Skill Variance (%%)";
		texts[] = {"0","5","10","15","20","25","30","35","40","45","50","55","60","65","70","75","80","85","90","95","100"};
		values[] = {0,5,10,15,20,25,30,35,40,45,50,55,60,65,70,75,80,85,90,95,100};
		default = 15;
	};
	class CRA_VehicleRespawnWreck
	{
		title = "Vehicle Wrecked Respawn (Minutes)";
		texts[] = {"Immediate","1","3","5","10","15","30","Never"};
		values[] = {0,60,180,300,600,900,1800,-1};
		default = 180;
	};
	class CRA_VehicleRespawnAbandon
	{
		title = "Vehicle Abandoned Respawn (Minutes)";
		texts[] = {"Immediate","1","3","5","10","15","30","Never"};
		values[] = {0,60,180,300,600,900,1800,-1};
		default = 0;
	};
	class CRA_VehicleAbandonMode
	{
		title = "Vehicle Abandon Mode";
		texts[] = {"Either Timeout or Rangeout","Both Timeout and Rangeout","Timeout only","Rangeout only","Never"};
		values[] = {0,1,2,3,-1};
		default = 0;
	};
	class CRA_VehicleAbandonTime
	{
		title = "Vehicle Abandon Timeout (Minutes)";
		texts[] = {"1","3","5","10","15","30","60"};
		values[] = {60,180,300,600,900,1800,3600};
		default = 900;
	};
	class CRA_VehicleAbandonRangeMode
	{
		title = "Vehicle Abandon Rangeout Reference";
		texts[] = {"Activation Range","1000m"};
		values[] = {0,1};
		default = 0;
	};
	class CRA_VehicleAbandonRange
	{
		title = "Vehicle Abandon Rangeout (%)";
		texts[] = {"25","50","75","100","125","150","175"};
		values[] = {25,50,75,100,125,150,175};
		default = 100;
	};
	class CRA_CivilianVehicleCount
	{
		title = "Civilian Vehicle Count";
		texts[] = {"1","2","3","4","5","8","10","15","20"};
		values[] = {1,2,3,4,5,8,10,15,20};
		default = 4;
	};
};
