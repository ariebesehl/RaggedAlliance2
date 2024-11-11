
#include "CRA__DEF__Base.sqf"
#include "CRA__DEF__Location.sqf"
#include "CRA__DEF__Main.sqf"
#include "CRA__DEF__Item.sqf"
#include "CRA__DEF__Asset.sqf"

#include "CRA__FNC__Item.sqf"
#include "CRA__FNC__Asset.sqf"
#include "CRA__FNC__Location.sqf"
#include "CRA__FNC__Main.sqf"

dCRA_SD_COUNT = missionNamespace getVariable ["dCRA_SD_COUNT", CRQ_SD_TYPES apply {0}];
dCRA_SD_INDEX = missionNamespace getVariable ["dCRA_SD_INDEX", CRQ_SD_TYPES apply {_x call CRQ_Side}];

// json, category, wealth, wear, size, style, function // TODO improv/makeshift level
// dCRA_BS_TYPE = missionNamespace getVariable ["dCRA_BS_TYPE", [
	// ["mil-base-small",			[["mil"], [0.50], [0.50], [0.25], ["military"], ["base", "command", "general"]]], // 0-1-0
	// ["mil-camp-tiny",			[["mil"], [0.50], [0.50], [0.25], ["military", "remote"], ["camp", "recon", "outpost"]]], // 0-2-0
	// ["out-camp-small",			[["out"], [0.25], [0.85], [0.40], ["outlaw", "remote", "junk"], ["camp", "outpost", "recon"]]], // 0-2-1
	// ["mil-road-small",			[["mil"], [0.50], [0.50], [0.40], ["military", "remote"], ["checkpoint", "recon", "camp", "outpost"]]], // 0-5-0
	// ["mil-road-tiny",			[["mil"], [0.50], [0.50], [0.25], ["military", "remote"], ["checkpoint", "recon", "camp", "outpost"]]], // 0-5-1
	// ["mil-road-medium",			[["mil"], [0.50], [0.50], [0.60], ["military", "remote"], ["checkpoint", "recon", "camp", "outpost"]]], // 0-5-2
	
	// ["ind-warehouse-blue",		[["ind"], [0.65], [0.55], [0.50], ["local", "industrial", "plain", "urban"], ["general", "warehouse", "shed", "storage"]]], // 1-1-0
	// ["gpp-school",				[["gpp"], [0.40], [0.65], [0.65], ["local", "village", "plain"], ["community", "general", "command", "storage"]]], // 1-1-1
	// ["res-bungalow",			[["res", "com"], [0.70], [0.40], [0.65], ["suburban", "rich", "local"], ["house", "command", "general", "tourism"]]], // 1-1-2
	// ["res-villa",				[["res", "com"], [0.80], [0.40], [0.60], ["suburban", "rich", "local"], ["house", "command", "general", "tourism"]]],
	// ["ind-shed-1",				[["ind"], [0.50], [0.65], [0.55], ["industrial", "plain"], ["shed", "general", "warehouse", "storage"]]],
	// ["ind-shed-2", 				[["ind"], [0.50], [0.65], [0.55], ["industrial", "plain"], ["shed", "general", "warehouse", "storage"]]],
	// ["com-office-block-white",	[["com"], [0.65], [0.60], [0.60], ["urban", "plain"], ["management", "office"]]],
	// ["com-office-tower-glass",	[["com"], [0.85], [0.40], [0.80], ["urban", "rich"], ["flagship", "bank", "management", "office"]]], // 1-1-7
	
	// ["res-house-yellow-wood",	[["res"], [0.40], [0.60], [0.40], ["local", "plain", "village"], ["house"]]], // 1-2-0
	// ["res-native-house-s",		[["res", "com"], [0.25], [0.65], [0.30], ["native", "local", "remote"], ["house", "tourism"]]],
	// ["res-native-house-l",		[["res", "com"], [0.25], [0.65], [0.45], ["native", "local", "remote"], ["house", "tourism"]]],
	// ["res-house-yellow-metal",	[["res"], [0.35], [0.65], [0.40], ["local", "plain", "village"], ["house"]]],
	// ["res-house-yellow-stone",	[["res"], [0.45], [0.60], [0.40], ["local", "plain", "village"], ["house"]]], // 1-2-4
	
	// ["gpp-guard-house",			[["gpp"], [0.50], [0.60], [0.15], ["local", "plain"], ["guard", "outpost", "general"]]], // 1-3-0
	// ["mil-hist-bunker",			[["mil"], [0.50], [0.75], [0.35], ["military", "historic", "remote"], ["guard", "outpost", "recon", "general"]]], // 1-3-1
	// ["ind-misc-container",		[["ind"], [0.50], [0.70], [0.25], ["industrial", "plain"], ["storage"]]], // 1-3-2
	// ["mil-hist-pillbox-hex",	[["mil"], [0.50], [0.75], [0.15], ["military", "historic", "remote"], ["guard", "outpost", "recon", "general"]]], // 1-3-3
	
	// ["air-terminal-remote",		[["air"], [0.35], [0.70], [0.40], ["airport", "remote", "local"], ["terminal", "general"]]], // 1-4-0
	// ["air-terminal-urban",		[["air"], [0.65], [0.60], [0.65], ["airport", "plain", "local"], ["flagship", "terminal", "general", "command"]]], // 1-4-1
	// ["air-tower-metal",			[["air"], [0.40], [0.65], [0.45], ["airport", "remote", "local"], ["control", "command"]]], // 1-4-2
	
	// ["res-house-purple-wood",	[["res", "agr"], [0.30], [0.80], [0.45], ["local", "farm", "village", "destute"], ["house", "general"]]], // 1-6-0
	// ["res-house-turqoise",		[["res"], [0.35], [0.65], [0.25], ["local", "village", "plain"], ["house"]]], // 1-6-1
	// ["res-house-white-blue",	[["res"], [0.45], [0.60], [0.35], ["local", "village", "plain", "suburban"], ["house"]]], // 1-6-2
	// ["res-house-grey-brick",	[["res"], [0.30], [0.85], [0.30], ["unfinished", "local", "village", "plain"], ["house"]]], // 1-6-3
	// ["res-house-white-grey",	[["res"], [0.40], [0.65], [0.30], ["local", "village", "plain", "suburban"], ["house"]]], // 1-6-4
// ]];

dCRA_BASE_0_1_0 = missionNamespace getVariable ["dCRA_BASE_0_1_0",CRA_BASE_0_1_0];
dCRA_BASE_0_2_0 = missionNamespace getVariable ["dCRA_BASE_0_2_0",CRA_BASE_0_2_0];
dCRA_BASE_0_2_1 = missionNamespace getVariable ["dCRA_BASE_0_2_1",CRA_BASE_0_2_1];
dCRA_BASE_0_5_0 = missionNamespace getVariable ["dCRA_BASE_0_5_0",CRA_BASE_0_5_0];
dCRA_BASE_0_5_1 = missionNamespace getVariable ["dCRA_BASE_0_5_1",CRA_BASE_0_5_1];
dCRA_BASE_0_5_2 = missionNamespace getVariable ["dCRA_BASE_0_5_2",CRA_BASE_0_5_2];
dCRA_BASE_0_7_0 = missionNamespace getVariable ["dCRA_BASE_0_7_0",CRA_BASE_0_7_0];
dCRA_BASE_1_1_0 = missionNamespace getVariable ["dCRA_BASE_1_1_0",CRA_BASE_1_1_0];
dCRA_BASE_1_1_1 = missionNamespace getVariable ["dCRA_BASE_1_1_1",CRA_BASE_1_1_1];
dCRA_BASE_1_1_2 = missionNamespace getVariable ["dCRA_BASE_1_1_2",CRA_BASE_1_1_2];
dCRA_BASE_1_1_3 = missionNamespace getVariable ["dCRA_BASE_1_1_3",CRA_BASE_1_1_3];
dCRA_BASE_1_1_4 = missionNamespace getVariable ["dCRA_BASE_1_1_4",CRA_BASE_1_1_4];
dCRA_BASE_1_1_5 = missionNamespace getVariable ["dCRA_BASE_1_1_5",CRA_BASE_1_1_5];
dCRA_BASE_1_1_6 = missionNamespace getVariable ["dCRA_BASE_1_1_6",CRA_BASE_1_1_6];
dCRA_BASE_1_1_7 = missionNamespace getVariable ["dCRA_BASE_1_1_7",CRA_BASE_1_1_7];
dCRA_BASE_1_2_0 = missionNamespace getVariable ["dCRA_BASE_1_2_0",CRA_BASE_1_2_0];
dCRA_BASE_1_2_1 = missionNamespace getVariable ["dCRA_BASE_1_2_1",CRA_BASE_1_2_1];
dCRA_BASE_1_2_2 = missionNamespace getVariable ["dCRA_BASE_1_2_2",CRA_BASE_1_2_2];
dCRA_BASE_1_2_3 = missionNamespace getVariable ["dCRA_BASE_1_2_3",CRA_BASE_1_2_3];
dCRA_BASE_1_2_4 = missionNamespace getVariable ["dCRA_BASE_1_2_4",CRA_BASE_1_2_4];
dCRA_BASE_1_3_0 = missionNamespace getVariable ["dCRA_BASE_1_3_0",CRA_BASE_1_3_0];
dCRA_BASE_1_3_1 = missionNamespace getVariable ["dCRA_BASE_1_3_1",CRA_BASE_1_3_1];
dCRA_BASE_1_3_2 = missionNamespace getVariable ["dCRA_BASE_1_3_2",CRA_BASE_1_3_2];
dCRA_BASE_1_3_3 = missionNamespace getVariable ["dCRA_BASE_1_3_3",CRA_BASE_1_3_3];
dCRA_BASE_1_4_0 = missionNamespace getVariable ["dCRA_BASE_1_4_0",CRA_BASE_1_4_0];
dCRA_BASE_1_4_1 = missionNamespace getVariable ["dCRA_BASE_1_4_1",CRA_BASE_1_4_1];
dCRA_BASE_1_4_2 = missionNamespace getVariable ["dCRA_BASE_1_4_2",CRA_BASE_1_4_2];
dCRA_BASE_1_6_0 = missionNamespace getVariable ["dCRA_BASE_1_6_0",CRA_BASE_1_6_0];
dCRA_BASE_1_6_1 = missionNamespace getVariable ["dCRA_BASE_1_6_1",CRA_BASE_1_6_1];
dCRA_BASE_1_6_2 = missionNamespace getVariable ["dCRA_BASE_1_6_2",CRA_BASE_1_6_2];
dCRA_BASE_1_6_3 = missionNamespace getVariable ["dCRA_BASE_1_6_3",CRA_BASE_1_6_3];
dCRA_BASE_1_6_4 = missionNamespace getVariable ["dCRA_BASE_1_6_4",CRA_BASE_1_6_4];
dCRA_BASE_1_6_5 = missionNamespace getVariable ["dCRA_BASE_1_6_5",CRA_BASE_1_6_5];
dCRA_BASE_INDEX = missionNamespace getVariable ["dCRA_BASE_INDEX",CRA_BASE_INDEX];


dCRA_BS_INST_NULL = missionNamespace getVariable ["dCRA_LC_INST_NULL",CRA_BS_INST_TYPES apply {objNull}];
dCRA_LC_TYPES = missionNamespace getVariable ["dCRA_LC_TYPES", CRA_LC_TYPES];
dCRA_LC_SCAN = missionNamespace getVariable ["dCRA_LC_SCAN", CRA_LC_SCAN];
dCRA_LC_OVERRIDE = missionNamespace getVariable ["dCRA_LC_OVERRIDE", CRA_LC_OVERRIDE];

dCRA_GP_WP_LOCATION = missionNamespace getVariable ["dCRA_GP_WP_LOCATION", CRA_GP_WP_LOCATION];
dCRA_SQUADS = missionNamespace getVariable ["dCRA_SQUADS", CRA_SQUADS];
dCRA_PLAYER_IDENTITY = missionNamespace getVariable ["dCRA_PLAYER_IDENTITY", CRA_PLAYER_IDENTITY];
dCRA_DEPOT_TYPES = missionNamespace getVariable ["dCRA_DEPOT_TYPES", CRA_DEPOT_TYPES];
dCRA_ASSET_INVENTORY = missionNamespace getVariable ["dCRA_ASSET_INVENTORY", CRA_ASSET_INVENTORY];

dCRA_UNIT_UNIFORM_CIVILIAN = missionNamespace getVariable ["dCRA_UNIT_UNIFORM_CIVILIAN", CRA_UNIT_UNIFORM_CIVILIAN];
dCRA_UNIT_UNIFORM_MEDIC = missionNamespace getVariable ["dCRA_UNIT_UNIFORM_MEDIC", CRA_UNIT_UNIFORM_MEDIC];
dCRA_UNIT_UNIFORM_UTILITY = missionNamespace getVariable ["dCRA_UNIT_UNIFORM_UTILITY", CRA_UNIT_UNIFORM_UTILITY];
dCRA_UNIT_UNIFORM_LOOTER = missionNamespace getVariable ["dCRA_UNIT_UNIFORM_LOOTER", CRA_UNIT_UNIFORM_LOOTER];
dCRA_UNIT_UNIFORM_CARTEL = missionNamespace getVariable ["dCRA_UNIT_UNIFORM_CARTEL", CRA_UNIT_UNIFORM_CARTEL];
dCRA_UNIT_UNIFORM_ARMY = missionNamespace getVariable ["dCRA_UNIT_UNIFORM_ARMY", CRA_UNIT_UNIFORM_ARMY];
dCRA_UNIT_UNIFORM_ARMY_LEADER = missionNamespace getVariable ["dCRA_UNIT_UNIFORM_ARMY_LEADER", CRA_UNIT_UNIFORM_ARMY_LEADER];
dCRA_UNIT_INDEX = missionNamespace getVariable ["dCRA_UNIT_INDEX", CRA_UNIT_INDEX];

dRA_InventoryGatherSources = missionNamespace getVariable ["dRA_InventoryGatherSources", ["Man", "WeaponHolderSimulated", "GroundWeaponHolder"] + CRQ_CLASS_VEHICLE];
dRA_WaypointCount = missionNamespace getVariable ["dRA_WaypointCount", dCRA_GP_WP_LOCATION apply {_x apply {count _x}}];

gRA_PM_SystemHotLoad = [false,true] select (["CRA_PM_SystemHotloading", 0] call BIS_fnc_getParamValue);
gRA_PM_SystemClutterDetect = [false,true] select (["CRA_PM_SystemClutterDetect", 0] call BIS_fnc_getParamValue);
gRA_PM_LC_RB_Mode = ["CRA_PM_LC_RB_Mode", 0] call BIS_fnc_getParamValue;
gRA_PM_LC_RB_Density = ((["CRA_PM_LC_RB_Density", 11] call BIS_fnc_getParamValue) % CRA_LCRB_DENSITY) + 1;
gRA_PM_PL_Start = [false,true] select (["CRA_PM_PL_Start", 0] call BIS_fnc_getParamValue);
gRA_PM_PL_Identity = [false,true] select (["CRA_PM_PL_Identity", 0] call BIS_fnc_getParamValue);
gRA_PM_PG_MissionMode = ["CRA_PM_PG_Mode", 1] call BIS_fnc_getParamValue;
gRA_PM_PG_MissionFactor = (["CRA_PM_PG_Factor", 4000] call BIS_fnc_getParamValue) / 1000;
gRA_PM_PG_MissionInit = (["CRA_PM_PG_Init", 0] call BIS_fnc_getParamValue) / 100;
gRA_PM_PG_MissionFinal = (["CRA_PM_PG_Final", 100] call BIS_fnc_getParamValue) / 100;
gRA_PM_PG_EquipmentMode = ["CRA_PM_EquipmentMode", 1] call BIS_fnc_getParamValue;
gRA_PM_PG_EquipmentFactor = (["CRA_PM_EquipmentFactor", 1000] call BIS_fnc_getParamValue) / 1000;
gRA_PM_PG_EquipmentInit = (["CRA_PM_EquipmentInit", 0] call BIS_fnc_getParamValue) / 100;
gRA_PM_PG_EquipmentFinal = (["CRA_PM_EquipmentFinal", 100] call BIS_fnc_getParamValue) / 100;
gRA_PM_PG_ActivationMode = ["CRA_PM_ActivationMode", 0] call BIS_fnc_getParamValue;
gRA_PM_PG_ActivationFactor = (["CRA_PM_ActivationFactor", 1000] call BIS_fnc_getParamValue) / 1000;
gRA_PM_PG_ActivationInit = (["CRA_PM_ActivationInit", 600] call BIS_fnc_getParamValue) call {CRA_ACTIVITY_BASE(_this)};
gRA_PM_PG_ActivationFinal = (["CRA_PM_ActivationFinal", 1200] call BIS_fnc_getParamValue) call {CRA_ACTIVITY_BASE(_this)};
gRA_PM_PG_EnemyArmyMode = ["CRA_PM_EnemyArmyMode", 0] call BIS_fnc_getParamValue;
gRA_PM_PG_EnemyArmyFactor = (["CRA_PM_EnemyArmyFactor", 1000] call BIS_fnc_getParamValue) / 1000;
gRA_PM_PG_EnemyArmyInit = (["CRA_PM_EnemyArmyInit", 0] call BIS_fnc_getParamValue) / 100;
gRA_PM_PG_EnemyArmyFinal = (["CRA_PM_EnemyArmyFinal", 100] call BIS_fnc_getParamValue) / 100;
gRA_PM_PG_EnemyCountMode = ["CRA_PM_EnemyCountMode", 0] call BIS_fnc_getParamValue;
gRA_PM_PG_EnemyCountFactor = (["CRA_PM_EnemyCountFactor", 1000] call BIS_fnc_getParamValue) / 1000;
gRA_PM_PG_EnemyCountInit = (["CRA_PM_EnemyCountInit", 100] call BIS_fnc_getParamValue) / 100;
gRA_PM_PG_EnemyCountFinal = (["CRA_PM_EnemyCountFinal", 200] call BIS_fnc_getParamValue) / 100;
gRA_PM_PG_EnemyCountPlayerMode = ["CRA_PM_EnemyCountPlayerMode", 0] call BIS_fnc_getParamValue;
gRA_PM_PG_EnemyCountPlayerFactor = (["CRA_PM_EnemyCountPlayerFactor", 1000] call BIS_fnc_getParamValue) / 1000;
gRA_PM_PG_EnemyCountPlayerInit = (["CRA_PM_EnemyCountPlayerInit", 100] call BIS_fnc_getParamValue) / 100;
gRA_PM_PG_EnemyCountPlayerFinal = (["CRA_PM_EnemyCountPlayerFinal", 200] call BIS_fnc_getParamValue) / 100;
gRA_PM_PG_EnemyCountVarianceMode = ["CRA_PM_EnemyCountVarianceMode", 0] call BIS_fnc_getParamValue;
gRA_PM_PG_EnemyCountVarianceFactor = (["CRA_PM_EnemyCountVarianceFactor", 1000] call BIS_fnc_getParamValue) / 1000;
gRA_PM_PG_EnemyCountVarianceInit = (["CRA_PM_EnemyCountVarianceInit", 0] call BIS_fnc_getParamValue) / 100;
gRA_PM_PG_EnemyCountVarianceFinal = (["CRA_PM_EnemyCountVarianceFinal", 0] call BIS_fnc_getParamValue) / 100;
gRA_PM_PG_EnemyCountVarianceDist = ["CRA_PM_EnemyCountVarianceDist", 0] call BIS_fnc_getParamValue;
gRA_PM_PG_EnemySkillMode = ["CRA_PM_EnemySkillMode", 0] call BIS_fnc_getParamValue;
gRA_PM_PG_EnemySkillFactor = (["CRA_PM_EnemySkillFactor", 1000] call BIS_fnc_getParamValue) / 1000;
gRA_PM_PG_EnemySkillInit = (["CRA_PM_EnemySkillInit", 20] call BIS_fnc_getParamValue) / 100;
gRA_PM_PG_EnemySkillFinal = (["CRA_PM_EnemySkillFinal", 40] call BIS_fnc_getParamValue) / 100;
gRA_PM_PG_EnemySkillVarianceMode = ["CRA_PM_EnemySkillVarianceMode", 0] call BIS_fnc_getParamValue;
gRA_PM_PG_EnemySkillVarianceFactor = (["CRA_PM_EnemySkillVarianceFactor", 1000] call BIS_fnc_getParamValue) / 1000;
gRA_PM_PG_EnemySkillVarianceInit = (["CRA_PM_EnemySkillVarianceInit", 0] call BIS_fnc_getParamValue) / 100;
gRA_PM_PG_EnemySkillVarianceFinal = (["CRA_PM_EnemySkillVarianceFinal", 0] call BIS_fnc_getParamValue) / 100;
gRA_PM_PG_EnemySkillVarianceDist = ["CRA_PM_EnemySkillVarianceDist", 0] call BIS_fnc_getParamValue;
gRA_PM_CivilianCarProb = (["CRA_PM_CivilianCarProbability", 100] call BIS_fnc_getParamValue) / 100;
gRA_PM_CivilianCarCount = ["CRA_PM_CivilianCarCount", 6] call BIS_fnc_getParamValue;
gRA_PM_CivilianPlaneProb = (["CRA_PM_CivilianPlaneProbability", 5] call BIS_fnc_getParamValue) / 100;
gRA_PM_CivilianPlaneCount = ["CRA_PM_CivilianPlaneCount", 2] call BIS_fnc_getParamValue;
gRA_PM_CivilianHeliProb = (["CRA_PM_CivilianHeliProbability", 5] call BIS_fnc_getParamValue) / 100;
gRA_PM_CivilianHeliCount = ["CRA_PM_CivilianHeliCount", 2] call BIS_fnc_getParamValue;
gRA_PM_AS_RespawnWreck = ["CRA_PM_AS_RespawnWreck", 180] call BIS_fnc_getParamValue;
gRA_PM_AS_RespawnAbandon = ["CRA_PM_AS_RespawnAbandon", 0] call BIS_fnc_getParamValue;
gRA_PM_AS_AbandonMode = ["CRA_PM_AS_AbandonMode", 0] call BIS_fnc_getParamValue;
gRA_PM_AS_AbandonTime = ["CRA_PM_AS_AbandonTime", 180] call BIS_fnc_getParamValue;

gRA_TickInitPre = missionNamespace getVariable ["gRA_TickInitPre", -1];
gRA_TickInitPost = missionNamespace getVariable ["gRA_TickInitPost", -1];
gRA_TickInitDepot = missionNamespace getVariable ["gRA_TickInitPost", -1];
gRA_TickInitLocation = missionNamespace getVariable ["gRA_TickInitPost", -1];
gRA_TickLoop = missionNamespace getVariable ["gRA_TickLoop", -1];

gRA_PG_FuncMission = missionNamespace getVariable ["gRA_PG_FuncMission", {0}];
gRA_PG_FuncEquipment = missionNamespace getVariable ["gRA_PG_FuncEquipment", {0}];
gRA_PG_FuncActivation = missionNamespace getVariable ["gRA_PG_FuncActivation", {800}];
gRA_PG_FuncEnemyArmy = missionNamespace getVariable ["gRA_PG_FuncEnemyArmy", {0}];
gRA_PG_FuncEnemyCountBase = missionNamespace getVariable ["gRA_PG_FuncEnemyCountBase", {1}];
gRA_PG_FuncEnemyCountPlayer = missionNamespace getVariable ["gRA_PG_FuncEnemyCountPlayer", {1}];
gRA_PG_FuncEnemyCountVarianceBase = missionNamespace getVariable ["gRA_PG_FuncEnemyCountVarianceBase", {0}];
gRA_PG_FuncEnemyCountVarianceDist = missionNamespace getVariable ["gRA_PG_FuncEnemyCountVarianceDist", {[1,1,1]}];
gRA_PG_FuncEnemySkillBase = missionNamespace getVariable ["gRA_PG_FuncEnemySkillBase", {0.2}];
gRA_PG_FuncEnemySkillVarianceBase = missionNamespace getVariable ["gRA_PG_FuncEnemySkillVarianceBase", {0}];
gRA_PG_FuncEnemySkillVarianceDist = missionNamespace getVariable ["gRA_PG_FuncEnemySkillVarianceDist", {[1,1,1]}];
gRA_PG_FuncVarianceEnemyCount = missionNamespace getVariable ["gRA_PG_FuncVarianceEnemyCount", {1}];
gRA_PG_FuncVarianceEnemySkill = missionNamespace getVariable ["gRA_PG_FuncVarianceEnemySkill", {1}];
gRA_PG_SpanMission = missionNamespace getVariable ["gRA_PG_SpanMission", gRA_PM_PG_MissionFinal - gRA_PM_PG_MissionInit];
gRA_PG_SpanEquipment = missionNamespace getVariable ["gRA_PG_SpanEquipment", gRA_PM_PG_EquipmentFinal - gRA_PM_PG_EquipmentInit];
gRA_PG_SpanActivation = missionNamespace getVariable ["gRA_PG_SpanActivation", gRA_PM_PG_ActivationFinal - gRA_PM_PG_ActivationInit];
gRA_PG_SpanEnemyArmy = missionNamespace getVariable ["gRA_PG_SpanEnemyArmy", gRA_PM_PG_EnemyArmyFinal - gRA_PM_PG_EnemyArmyInit];
gRA_PG_SpanEnemyCountBase = missionNamespace getVariable ["gRA_PG_SpanEnemyCountBase", gRA_PM_PG_EnemyCountFinal - gRA_PM_PG_EnemyCountInit];
gRA_PG_SpanEnemyCountPlayer = missionNamespace getVariable ["gRA_PG_SpanEnemyCountPlayer", gRA_PM_PG_EnemyCountPlayerFinal - gRA_PM_PG_EnemyCountPlayerInit];
gRA_PG_SpanEnemyCountVariance = missionNamespace getVariable ["gRA_PG_SpanEnemyCountVariance", gRA_PM_PG_EnemyCountVarianceFinal - gRA_PM_PG_EnemyCountVarianceInit];
gRA_PG_SpanEnemySkillBase = missionNamespace getVariable ["gRA_PG_SpanEnemySkillBase", gRA_PM_PG_EnemySkillFinal - gRA_PM_PG_EnemySkillInit];
gRA_PG_SpanEnemySkillVariance = missionNamespace getVariable ["gRA_PG_SpanEnemySkillVariance", gRA_PM_PG_EnemySkillVarianceFinal - gRA_PM_PG_EnemySkillVarianceInit];
gRA_PG_CoeffEnemyCountPlayer = missionNamespace getVariable ["gRA_PG_CoeffEnemyCountPlayer", 1];
gRA_PG_Value = missionNamespace getVariable ["gRA_PG_Value", 1];
gRA_PG_Gain = missionNamespace getVariable ["gRA_PG_Gain", 0];
gRA_PG_Mission = missionNamespace getVariable ["gRA_PG_Mission", 0];
gRA_PG_Equipment = missionNamespace getVariable ["gRA_PG_Equipment", 0];
gRA_PG_Activation = missionNamespace getVariable ["gRA_PG_Activation", 800];
gRA_PG_EnemyArmy = missionNamespace getVariable ["gRA_PG_EnemyArmy", 0];
gRA_PG_EnemyCountBase = missionNamespace getVariable ["gRA_PG_EnemyCountBase", 1];
gRA_PG_EnemyCountVariance = missionNamespace getVariable ["gRA_PG_EnemyCountVariance", [1,1,1]];
gRA_PG_EnemySkillBase = missionNamespace getVariable ["gRA_PG_EnemySkillBase", 0.25];
gRA_PG_EnemySkillVariance = missionNamespace getVariable ["gRA_PG_EnemySkillVariance", [1,1,1]];

gRA_SD_Matrix = missionNamespace getVariable ["gRA_SD_Matrix", call CRQ_fnc_SD_Matrix];

gRA_PL_Reg = missionNamespace getVariable ["gRA_PL_Reg", []];
gRA_PL_Init = missionNamespace getVariable ["gRA_PL_Init", []];
gRA_PL_Dist = missionNamespace getVariable ["gRA_PL_Dist", []];
gRA_PL_Index = missionNamespace getVariable ["gRA_PL_Index", createHashMap];
gRA_PL_Var = missionNamespace getVariable ["gRA_PL_Var", []];
gRA_PL_Inventory = missionNamespace getVariable ["gRA_PL_Inventory", []];
gRA_PL_Asset = missionNamespace getVariable ["gRA_PL_Asset", []];
gRA_PL_Mail = missionNamespace getVariable ["gRA_PL_Mail", []];
gRA_PL_Units = [];
gRA_PL_Count = 0;
gRA_PL_Pos = [];
gRA_PL_PrePos = [];


gRA_MAP_Grid = missionNamespace getVariable ["gRA_MAP_Grid", createHashMap];
gRA_MAP_Mass = missionNamespace getVariable ["gRA_MAP_Mass", []];
gRA_MAP_House = missionNamespace getVariable ["gRA_MAP_House", []];

gRA_BS_Types = missionNamespace getVariable ["gRA_BS_Types", []];
gRA_LC_IndexDepot = missionNamespace getVariable ["gRA_LC_IndexDepot", -1];
gRA_LC_IndexBase = missionNamespace getVariable ["gRA_LC_IndexBase", -1];
gRA_LC_IndexRoadblock = missionNamespace getVariable ["gRA_LC_IndexRoadblock", -1];
gRA_LC_IndexOutpost = missionNamespace getVariable ["gRA_LC_IndexOutpost", -1];
gRA_LC_List = missionNamespace getVariable ["gRA_LC_List", []];
gRA_LC_History = missionNamespace getVariable ["gRA_LC_History", []];
gRA_LC_Safe = missionNamespace getVariable ["gRA_LC_Safe", createHashMap];
gRA_DepotTypes = missionNamespace getVariable ["gRA_DepotTypes", []];

gRA_GP_Ticket = missionNamespace getVariable ["gRA_GP_Ticket", -1];
gRA_GP_List = missionNamespace getVariable ["gRA_GP_List", createHashMap];

gRA_CivilianAssetCount = missionNamespace getVariable ["gRA_CivilianAssetCount", CRA_ASSET_CLASSES apply {0}];
gRA_CivilianAssetLimit = missionNamespace getVariable ["gRA_CivilianAssetLimit", CRA_ASSET_CLASSES apply {0}];
gRA_CivilianAssetProb = missionNamespace getVariable ["gRA_CivilianAssetProb", CRA_ASSET_CLASSES apply {0}];
gRA_CivilianAssetTime = missionNamespace getVariable ["gRA_CivilianAssetTime", CRA_ASSET_CLASSES apply {-1}];
gRA_CivilianAssetSpawn = missionNamespace getVariable ["gRA_CivilianAssetSpawn", CRA_ASSET_CLASSES apply {scriptNull}];

gRA_AS_List = [];
gRA_AS_FuncAbandonMode = missionNamespace getVariable ["gRA_AS_FuncAbandonMode", {true}];
gRA_AS_Catalog = missionNamespace getVariable ["gRA_AS_Catalog", []];
gRA_AS_Dimensions = missionNamespace getVariable ["gRA_AS_Dimensions", []];
gRA_IT_Catalog = missionNamespace getVariable ["gRA_IT_Catalog", []];

gRA_Temp = missionNamespace getVariable ["gRA_Temp", []];

/*
// D301: Commented-out stuff from CRA_Main.sqf
gRA_PathAvailable = false;
gRA_PathPlayer = 0;
gRA_PathPos = [];
gRA_PathHandle = scriptNull;
gRA_PathResult = [];
CRA_PathGen = {
	params ["_pos", "_radiusSearch", "_radiusEdge"];
	
	private _roads = [];
	{if (_x call CRQ_fnc_RD_IsRoad) then {_roads pushBack _x;};} forEach (_pos nearRoads _radiusSearch);
	{
		private _path0 = [_x, [], _pos, _radiusEdge] call CRQ_RoadPath;
		private _length = count _path0;
		private _path1 = if (_length > 0) then {[_x, if (_length > 1) then {[_path0#1]} else {[]}, _pos, _radiusEdge] call CRQ_RoadPath} else {[]};
		if (_path1 isNotEqualTo []) exitWith {
			reverse _path0;
			_path0 deleteAt (_length - 1);
			gRA_PathResult = _path0 + _path1;
		};
	} forEach (_roads call CRQ_fnc_ArrayRandomize);
};
gRA_PathAgent = objNull;
gRA_PathAgentResult = [];
CRA_PathAgent = {
	params ["_start", "_end", ["_type", "car"], ["_mode", "SAFE"]];
	gRA_PathAgent = calculatePath [_type, _mode, _start, _end];
	gRA_PathAgent addEventHandler ["PathCalculated", {if (gRA_PathAgentResult isEqualTo []) then {gRA_PathAgentResult = _this#1;};}];
};
gRA_PathSmoke = [];
gRA_PathSmokeIndex = 0;
gRA_PathSmokeGroup = grpNull;
CRA_PathGenMark = {
	if (isNull gRA_PathSmokeGroup) then {gRA_PathSmokeGroup = createGroup sideLogic;};
	{deleteVehicle _x;} forEach gRA_PathSmoke;
	gRA_PathSmoke = [];
	private _type = ["ModuleSmokeYellow_F", "ModuleSmokeBlue_F", "ModuleSmokeRed_F", "ModuleSmokeGreen_F", "ModuleSmokeOrange_F", "ModuleSmokeWhite_F", "ModuleSmokePurple_F"]#gRA_PathSmokeIndex;
	{
		gRA_PathSmoke pushBack (_type createUnit [_x, gRA_PathSmokeGroup,"this setVariable ['BIS_fnc_initModules_disableAutoActivation', false, true];"]);
	} forEach _this;
	gRA_PathSmokeIndex = (gRA_PathSmokeIndex + 1) % 7;
};
CRA_Weed = {
	params ["_pos"];
	private _spacing = 1;
	private _bury = -0.25;
	for [{private _iY = 0}, {_iY < 10}, {_iY = _iY + 1}] do {
		for [{private _iX = 0}, {_iX < 10}, {_iX = _iX + 1}] do {
			private _posPlant = [(_pos#0) + _iX * _spacing, (_pos#1) + _iY * _spacing, _bury];
			private _plant = createSimpleObject ["Land_FlowerPot_01_Flower_F", ATLToASL _posPlant];
			_plant setDir (random 360);
		};
	};
};
// and from CRA_Vehicle/CRA_Asset.sqf
CRA_DBG_Depot = {
	private _lines = [];
	private _types = ["CRA_ASSET_WHEELED","CRA_ASSET_TRACKED","CRA_ASSET_WINGED","CRA_ASSET_BOAT","CRA_ASSET_ROTOR","CRA_ASSET_STATIC"];
	private _vec = ["CRQ_VU_PABS","CRQ_VU_PREL","CRQ_VU_PVEC","CRQ_VU_PVTL","CRQ_VU_PVWL"];
	private _spType = ["CRA_DEPOT_POS_INSIDE","CRA_DEPOT_POS_OUTSIDE","CRA_DEPOT_POS_BOAT"];
	private _fnc_Vec = {
		private _line = "[";
		{
			_line = _line + "[" + (_vec#(_x#0));
			if (count _x > 1) then {_line = _line + "," + str (_x#1);};
			if (count _x > 2) then {_line = _line + "," + str (_x#2);};
			_line = _line + (if (_forEachIndex < (count _this - 1)) then {"],"} else {"]"});
		} forEach _this;
		(_line + "]")
	};
	{
		private _line = "[" + ("'" + (_x#0) + "'") + "," + (_types#(_x#2)) + ",[";
		private _spawn = "";
		private _spLast = count (_x#4) - 1;
		{
			private _spLine = "[" + (_spType#(_x#1)) + ",";
			_spLine = _spLine + (switch (_x#1) do {
				case CRA_DEPOT_POS_INSIDE: {((_x#0) call _fnc_Vec) + ",[" + str (_x#3) + "," + str ((_x#2) apply {(round (_x * 100)) / 100}) + "]"};
				case CRA_DEPOT_POS_BOAT: {([[CRQ_VU_PVEC,_x#2]] call _fnc_Vec) + ",[" + str (_x#3) + "," + str (_x#2#1) + "]"};
				default {""};
			});
			_spLine = _spLine + "]" + (if (_forEachIndex < _spLast) then {","} else {""});
			_spawn = _spawn + _spLine;
		} forEach (_x#4);
		_line = _line + _spawn;
		_line = _line + "]]";
		_lines pushBack _line;
	} forEach gRA_DepotTypes;
	private _last = count gRA_DepotTypes - 1;
	private _output = "[";
	{_output = _output + _x + (if (_forEachIndex < _last) then {",\"} else {"]"}) + (toString [10]);} forEach _lines;
	_output
};
*/
