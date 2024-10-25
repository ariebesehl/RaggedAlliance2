
dCRA_BASE_0_1_0 = missionNamespace getVariable ["dCRA_BASE_0_1_0",CRA_BASE_0_1_0];
dCRA_BASE_0_2_0 = missionNamespace getVariable ["dCRA_BASE_0_2_0",CRA_BASE_0_2_0];
dCRA_BASE_0_2_1 = missionNamespace getVariable ["dCRA_BASE_0_2_1",CRA_BASE_0_2_1];
dCRA_BASE_0_5_0 = missionNamespace getVariable ["dCRA_BASE_0_5_0",CRA_BASE_0_5_0];
dCRA_BASE_0_5_1 = missionNamespace getVariable ["dCRA_BASE_0_5_1",CRA_BASE_0_5_1];
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
dCRA_BASE_1_4_0 = missionNamespace getVariable ["dCRA_BASE_1_4_0",CRA_BASE_1_4_0];
dCRA_BASE_1_4_1 = missionNamespace getVariable ["dCRA_BASE_1_4_1",CRA_BASE_1_4_1];
dCRA_BASE_1_4_2 = missionNamespace getVariable ["dCRA_BASE_1_4_2",CRA_BASE_1_4_2];
dCRA_BASE_1_6_0 = missionNamespace getVariable ["dCRA_BASE_1_6_0",CRA_BASE_1_6_0];
dCRA_BASE_1_6_1 = missionNamespace getVariable ["dCRA_BASE_1_6_1",CRA_BASE_1_6_1];
dCRA_BASE_1_6_2 = missionNamespace getVariable ["dCRA_BASE_1_6_2",CRA_BASE_1_6_2];
dCRA_BASE_1_6_3 = missionNamespace getVariable ["dCRA_BASE_1_6_3",CRA_BASE_1_6_3];
dCRA_BASE_1_6_4 = missionNamespace getVariable ["dCRA_BASE_1_6_4",CRA_BASE_1_6_4];
dCRA_BASE_INDEX = missionNamespace getVariable ["dCRA_BASE_INDEX",CRA_BASE_INDEX];

dCRA_LOCATION_TYPES = missionNamespace getVariable ["dCRA_LOCATION_TYPES", CRA_LOCATION_TYPES];
dCRA_LOCATION_SCAN = missionNamespace getVariable ["dCRA_LOCATION_SCAN", CRA_LOCATION_SCAN];
dCRA_LOCATION_OVERRIDE = missionNamespace getVariable ["dCRA_LOCATION_OVERRIDE", CRA_LOCATION_OVERRIDE];
dCRA_LOCATION_WAYPOINTS = missionNamespace getVariable ["dCRA_LOCATION_WAYPOINTS", CRA_LOCATION_WAYPOINTS];
dCRA_SQUADS = missionNamespace getVariable ["dCRA_SQUADS", CRA_SQUADS];
dCRA_PLAYER_IDENTITY = missionNamespace getVariable ["dCRA_PLAYER_IDENTITY", CRA_PLAYER_IDENTITY];

dRA_InventoryGatherSources = missionNamespace getVariable ["dRA_InventoryGatherSources", ["Man", "WeaponHolderSimulated", "GroundWeaponHolder"] + CRQ_CLASS_VEHICLE];
dRA_WaypointCount = missionNamespace getVariable ["dRA_WaypointCount", dCRA_LOCATION_WAYPOINTS apply {_x apply {count _x}}];
dRA_WorldHouses = missionNamespace getVariable ["dRA_WorldHouses", []];

gRA_SettingSystemHotLoad = [false,true] select (["CRA_SystemHotloading", 0] call BIS_fnc_getParamValue);
gRA_SettingSystemClutterDetect = [false,true] select (["CRA_SystemClutterDetect", 0] call BIS_fnc_getParamValue);

gRA_SettingPlayerStart = [false,true] select (["CRA_PlayerStart", 0] call BIS_fnc_getParamValue);
gRA_SettingPlayerIdentity = [false,true] select (["CRA_PlayerIdentity", 0] call BIS_fnc_getParamValue);

gRA_SettingProgressMissionMode = ["CRA_ProgressMode", 1] call BIS_fnc_getParamValue;
gRA_SettingProgressMissionFactor = (["CRA_ProgressFactor", 4000] call BIS_fnc_getParamValue) / 1000;
gRA_SettingProgressMissionInit = (["CRA_ProgressInit", 0] call BIS_fnc_getParamValue) / 100;
gRA_SettingProgressMissionFinal = (["CRA_ProgressFinal", 100] call BIS_fnc_getParamValue) / 100;
gRA_SettingProgressEquipmentMode = ["CRA_EquipmentMode", 1] call BIS_fnc_getParamValue;
gRA_SettingProgressEquipmentFactor = (["CRA_EquipmentFactor", 1000] call BIS_fnc_getParamValue) / 1000;
gRA_SettingProgressEquipmentInit = (["CRA_EquipmentInit", 0] call BIS_fnc_getParamValue) / 100;
gRA_SettingProgressEquipmentFinal = (["CRA_EquipmentFinal", 100] call BIS_fnc_getParamValue) / 100;
gRA_SettingProgressActivationMode = ["CRA_ActivationMode", 0] call BIS_fnc_getParamValue;
gRA_SettingProgressActivationFactor = (["CRA_ActivationFactor", 1000] call BIS_fnc_getParamValue) / 1000;
gRA_SettingProgressActivationInit = (["CRA_ActivationInit", 600] call BIS_fnc_getParamValue) call {CRA_ACTIVITY_BASE(_this)};
gRA_SettingProgressActivationFinal = (["CRA_ActivationFinal", 1200] call BIS_fnc_getParamValue) call {CRA_ACTIVITY_BASE(_this)};
gRA_SettingProgressEnemyArmyMode = ["CRA_EnemyArmyMode", 0] call BIS_fnc_getParamValue;
gRA_SettingProgressEnemyArmyFactor = (["CRA_EnemyArmyFactor", 1000] call BIS_fnc_getParamValue) / 1000;
gRA_SettingProgressEnemyArmyInit = (["CRA_EnemyArmyInit", 0] call BIS_fnc_getParamValue) / 100;
gRA_SettingProgressEnemyArmyFinal = (["CRA_EnemyArmyFinal", 100] call BIS_fnc_getParamValue) / 100;
gRA_SettingProgressEnemyCountMode = ["CRA_EnemyCountMode", 0] call BIS_fnc_getParamValue;
gRA_SettingProgressEnemyCountFactor = (["CRA_EnemyCountFactor", 1000] call BIS_fnc_getParamValue) / 1000;
gRA_SettingProgressEnemyCountInit = (["CRA_EnemyCountInit", 100] call BIS_fnc_getParamValue) / 100;
gRA_SettingProgressEnemyCountFinal = (["CRA_EnemyCountFinal", 200] call BIS_fnc_getParamValue) / 100;
gRA_SettingProgressEnemyCountPlayerMode = ["CRA_EnemyCountPlayerMode", 0] call BIS_fnc_getParamValue;
gRA_SettingProgressEnemyCountPlayerFactor = (["CRA_EnemyCountPlayerFactor", 1000] call BIS_fnc_getParamValue) / 1000;
gRA_SettingProgressEnemyCountPlayerInit = (["CRA_EnemyCountPlayerInit", 100] call BIS_fnc_getParamValue) / 100;
gRA_SettingProgressEnemyCountPlayerFinal = (["CRA_EnemyCountPlayerFinal", 200] call BIS_fnc_getParamValue) / 100;
gRA_SettingProgressEnemyCountVarianceMode = ["CRA_EnemyCountVarianceMode", 0] call BIS_fnc_getParamValue;
gRA_SettingProgressEnemyCountVarianceFactor = (["CRA_EnemyCountVarianceFactor", 1000] call BIS_fnc_getParamValue) / 1000;
gRA_SettingProgressEnemyCountVarianceInit = (["CRA_EnemyCountVarianceInit", 0] call BIS_fnc_getParamValue) / 100;
gRA_SettingProgressEnemyCountVarianceFinal = (["CRA_EnemyCountVarianceFinal", 0] call BIS_fnc_getParamValue) / 100;
gRA_SettingProgressEnemyCountVarianceDist = ["CRA_EnemyCountVarianceDist", 0] call BIS_fnc_getParamValue;
gRA_SettingProgressEnemySkillMode = ["CRA_EnemySkillMode", 0] call BIS_fnc_getParamValue;
gRA_SettingProgressEnemySkillFactor = (["CRA_EnemySkillFactor", 1000] call BIS_fnc_getParamValue) / 1000;
gRA_SettingProgressEnemySkillInit = (["CRA_EnemySkillInit", 20] call BIS_fnc_getParamValue) / 100;
gRA_SettingProgressEnemySkillFinal = (["CRA_EnemySkillFinal", 40] call BIS_fnc_getParamValue) / 100;
gRA_SettingProgressEnemySkillVarianceMode = ["CRA_EnemySkillVarianceMode", 0] call BIS_fnc_getParamValue;
gRA_SettingProgressEnemySkillVarianceFactor = (["CRA_EnemySkillVarianceFactor", 1000] call BIS_fnc_getParamValue) / 1000;
gRA_SettingProgressEnemySkillVarianceInit = (["CRA_EnemySkillVarianceInit", 0] call BIS_fnc_getParamValue) / 100;
gRA_SettingProgressEnemySkillVarianceFinal = (["CRA_EnemySkillVarianceFinal", 0] call BIS_fnc_getParamValue) / 100;
gRA_SettingProgressEnemySkillVarianceDist = ["CRA_EnemySkillVarianceDist", 0] call BIS_fnc_getParamValue;

gRA_SettingCivilianCarProb = (["CRA_CivilianCarProbability", 100] call BIS_fnc_getParamValue) / 100;
gRA_SettingCivilianCarCount = ["CRA_CivilianCarCount", 6] call BIS_fnc_getParamValue;
gRA_SettingCivilianPlaneProb = (["CRA_CivilianPlaneProbability", 5] call BIS_fnc_getParamValue) / 100;
gRA_SettingCivilianPlaneCount = ["CRA_CivilianPlaneCount", 2] call BIS_fnc_getParamValue;
gRA_SettingCivilianHeliProb = (["CRA_CivilianHeliProbability", 5] call BIS_fnc_getParamValue) / 100;
gRA_SettingCivilianHeliCount = ["CRA_CivilianHeliCount", 2] call BIS_fnc_getParamValue;

gRA_ProgressSpanMission = missionNamespace getVariable ["gRA_ProgressSpanMission", gRA_SettingProgressMissionFinal - gRA_SettingProgressMissionInit];
gRA_ProgressSpanEquipment = missionNamespace getVariable ["gRA_ProgressSpanEquipment", gRA_SettingProgressEquipmentFinal - gRA_SettingProgressEquipmentInit];
gRA_ProgressSpanActivation = missionNamespace getVariable ["gRA_ProgressSpanActivation", gRA_SettingProgressActivationFinal - gRA_SettingProgressActivationInit];
gRA_ProgressSpanEnemyArmy = missionNamespace getVariable ["gRA_ProgressSpanEnemyArmy", gRA_SettingProgressEnemyArmyFinal - gRA_SettingProgressEnemyArmyInit];
gRA_ProgressSpanEnemyCountBase = missionNamespace getVariable ["gRA_ProgressSpanEnemyCountBase", gRA_SettingProgressEnemyCountFinal - gRA_SettingProgressEnemyCountInit];
gRA_ProgressSpanEnemyCountPlayer = missionNamespace getVariable ["gRA_ProgressSpanEnemyCountPlayer", gRA_SettingProgressEnemyCountPlayerFinal - gRA_SettingProgressEnemyCountPlayerInit];
gRA_ProgressSpanEnemyCountVariance = missionNamespace getVariable ["gRA_ProgressSpanEnemyCountVariance", gRA_SettingProgressEnemyCountVarianceFinal - gRA_SettingProgressEnemyCountVarianceInit];
gRA_ProgressSpanEnemySkillBase = missionNamespace getVariable ["gRA_ProgressSpanEnemySkillBase", gRA_SettingProgressEnemySkillFinal - gRA_SettingProgressEnemySkillInit];
gRA_ProgressSpanEnemySkillVariance = missionNamespace getVariable ["gRA_ProgressSpanEnemySkillVariance", gRA_SettingProgressEnemySkillVarianceFinal - gRA_SettingProgressEnemySkillVarianceInit];

gRA_ProgressCoeffEnemyCountPlayer = missionNamespace getVariable ["gRA_ProgressCoeffEnemyCountPlayer", 1];

gRA_ProgressValue = missionNamespace getVariable ["gRA_ProgressValue", 1];
gRA_ProgressGain = missionNamespace getVariable ["gRA_ProgressGain", 0];

gRA_ProgressMission = missionNamespace getVariable ["gRA_ProgressMission", 0];
gRA_ProgressEquipment = missionNamespace getVariable ["gRA_ProgressEquipment", 0];
gRA_ProgressActivation = missionNamespace getVariable ["gRA_ProgressActivation", 800];
gRA_ProgressEnemyArmy = missionNamespace getVariable ["gRA_ProgressEnemyArmy", 0];
gRA_ProgressEnemyCountBase = missionNamespace getVariable ["gRA_ProgressEnemyCountBase", 1];
gRA_ProgressEnemyCountVariance = missionNamespace getVariable ["gRA_ProgressEnemyCountVariance", [1,1,1]];
gRA_ProgressEnemySkillBase = missionNamespace getVariable ["gRA_ProgressEnemySkillBase", 0.25];
gRA_ProgressEnemySkillVariance = missionNamespace getVariable ["gRA_ProgressEnemySkillVariance", [1,1,1]];

gRA_SD_Matrix = missionNamespace getVariable ["gRA_SD_Matrix", call CRQ_fnc_SD_Matrix];

gRA_PlayerReg = missionNamespace getVariable ["gRA_PlayerReg", []];
gRA_PlayerInit = missionNamespace getVariable ["gRA_PlayerInit", []];
gRA_PlayerDist = missionNamespace getVariable ["gRA_PlayerDist", []];
gRA_PlayerIndex = missionNamespace getVariable ["gRA_PlayerIndex", createHashMap];
gRA_PlayerVar = missionNamespace getVariable ["gRA_PlayerVar", []];
gRA_PlayerInventory = missionNamespace getVariable ["gRA_PlayerInventory", []];
gRA_PlayerAsset = missionNamespace getVariable ["gRA_PlayerAsset", []];
gRA_PlayerMail = missionNamespace getVariable ["gRA_PlayerMail", []];
gRA_PlayerUnits = [];
gRA_PlayerCount = 0;
gRA_PlayerPos = [];
gRA_PlayerPrePos = [];


gRA_LocationIndexDepot = missionNamespace getVariable ["gRA_LocationIndexDepot", -1];
gRA_LocationIndexBase = missionNamespace getVariable ["gRA_LocationIndexBase", -1];
gRA_LocationIndexRoadblock = missionNamespace getVariable ["gRA_LocationIndexRoadblock", -1];
gRA_LocationIndexOutpost = missionNamespace getVariable ["gRA_LocationIndexOutpost", -1];
gRA_Locations = missionNamespace getVariable ["gRA_Locations", []];
gRA_LocationHistory = [];
gRA_LocationSafe = createHashMap;

gRA_CivilianAssetCount = missionNamespace getVariable ["gRA_CivilianAssetCount", CRA_ASSET_CLASSES apply {0}];
gRA_CivilianAssetLimit = missionNamespace getVariable ["gRA_CivilianAssetLimit", CRA_ASSET_CLASSES apply {0}];
gRA_CivilianAssetProb = missionNamespace getVariable ["gRA_CivilianAssetProb", CRA_ASSET_CLASSES apply {0}];
gRA_CivilianAssetTime = missionNamespace getVariable ["gRA_CivilianAssetTime", CRA_ASSET_CLASSES apply {-1}];
gRA_CivilianAssetSpawn = missionNamespace getVariable ["gRA_CivilianAssetSpawn", CRA_ASSET_CLASSES apply {scriptNull}];

gRA_TickInitPre = missionNamespace getVariable ["gRA_TickInitPre", -1];
gRA_TickInitPost = missionNamespace getVariable ["gRA_TickInitPost", -1];
gRA_TickInitDepot = missionNamespace getVariable ["gRA_TickInitPost", -1];
gRA_TickInitLocation = missionNamespace getVariable ["gRA_TickInitPost", -1];
gRA_TickLoop = missionNamespace getVariable ["gRA_TickLoop", -1];

gRA_fnc_ProgressMission = missionNamespace getVariable ["gRA_fnc_ProgressMission", {0}];
gRA_fnc_ProgressEquipment = missionNamespace getVariable ["gRA_fnc_ProgressEquipment", {0}];
gRA_fnc_ProgressActivation = missionNamespace getVariable ["gRA_fnc_ProgressActivation", {800}];
gRA_fnc_ProgressEnemyArmy = missionNamespace getVariable ["gRA_fnc_ProgressEnemyArmy", {0}];
gRA_fnc_ProgressEnemyCountBase = missionNamespace getVariable ["gRA_fnc_ProgressEnemyCountBase", {1}];
gRA_fnc_ProgressEnemyCountPlayer = missionNamespace getVariable ["gRA_fnc_ProgressEnemyCountPlayer", {1}];
gRA_fnc_ProgressEnemyCountVarianceBase = missionNamespace getVariable ["gRA_fnc_ProgressEnemyCountVarianceBase", {0}];
gRA_fnc_ProgressEnemyCountVarianceDist = missionNamespace getVariable ["gRA_fnc_ProgressEnemyCountVarianceDist", {[1,1,1]}];
gRA_fnc_ProgressEnemySkillBase = missionNamespace getVariable ["gRA_fnc_ProgressEnemySkillBase", {0.2}];
gRA_fnc_ProgressEnemySkillVarianceBase = missionNamespace getVariable ["gRA_fnc_ProgressEnemySkillVarianceBase", {0}];
gRA_fnc_ProgressEnemySkillVarianceDist = missionNamespace getVariable ["gRA_fnc_ProgressEnemySkillVarianceDist", {[1,1,1]}];

gRA_fnc_VarianceEnemyCount = missionNamespace getVariable ["gRA_fnc_VarianceEnemyCount", {1}];
gRA_fnc_VarianceEnemySkill = missionNamespace getVariable ["gRA_fnc_VarianceEnemySkill", {1}];

gRA_BaseTypes = missionNamespace getVariable ["gRA_BaseTypes", []];

/*
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
*/
CRA_Temp = {
	private _location = if (_this isEqualType -1) then {gRA_Locations#(gRA_LocationIndexBase + _this)} else {_this};
	private _units = _location getVariable [CRA_SVAR_LOCATION_UNIT_PERSONNEL, []];
	{_x setDamage 1;} forEach _units;
	{[_x, _location] call CRA_PlayerTeleport;} forEach gRA_PlayerUnits;
};
CRA_Temp2 = {
	(gRA_Locations apply {[_x getVariable ["CRA_SVAR_LOCATION_INDEX",-1], text _x]})
};
CRA_Loop = {
	if (pRA_Initializing) exitWith {};
	private _tickLoop = diag_tickTime;
	[] call CRA_SideLoop;
	[] call CRA_PlayerLoop;
	[] call CRA_AssetLoop;
	[] call CRA_CivilianLoop;
	[] call CRA_LocationLoop;
	gRA_TickLoop = diag_tickTime - _tickLoop;
};
CRA_SideLoop = {
	(call CRQ_fnc_SD_Matrix) call {
		{
			private _row = [];
			private _self = _forEachIndex;
			{
				private _sfF = (0.5 + (_this#2#_self#_forEachIndex));
				private _sfE = (0.5 + (_this#3#_self#_forEachIndex));
				private _owF = (0.5 + (_this#2#_forEachIndex#_self));
				private _owE = (0.5 + (_this#3#_forEachIndex#_self));
				_row pushBack (_sfF * _owF * _sfE * _owE);
			} forEach CRQ_SD_TYPES;
			gRA_SD_Matrix set [_self, _row];
		} forEach CRQ_SD_TYPES;
	};
};
CRA_LightsOn = {
	{if (_x getVariable [CRA_SVAR_LOCATION_STATE, -1] == CRA_STATE_ACTIVE) then {[_x, true] call CRA_LocationBaseLights;};} forEach gRA_Locations;
};
CRA_LightsOff = {
	{if (_x getVariable [CRA_SVAR_LOCATION_STATE, -1] == CRA_STATE_ACTIVE) then {[_x, false] call CRA_LocationBaseLights;};} forEach gRA_Locations;
};
CRA_CivilianInit = {
	private _params = [
		[gRA_SettingCivilianCarCount,gRA_SettingCivilianCarProb],
		[0,0],
		[gRA_SettingCivilianPlaneCount,gRA_SettingCivilianPlaneProb],
		[0,0],
		[gRA_SettingCivilianHeliCount,gRA_SettingCivilianHeliProb],
		[0,0]
	];
	private _timer = -CRA_CIVILIAN_SPAWN_TIMER / (count _params);
	private _prob = CRA_CIVILIAN_SPAWN_TIMER / 60;
	{
		gRA_CivilianAssetLimit set [_forEachIndex, _x#0];
		gRA_CivilianAssetProb set [_forEachIndex, 1 - ((1 - (_x#1)) ^ _prob)];
		gRA_CivilianAssetTime set [_forEachIndex, (gCS_TM_Now + (_forEachIndex * _timer)) call CRQ_fnc_TimeCoerce];
	} forEach _params;
};
CRA_InitPre = {
	private _tickInitPre = diag_tickTime;
	[] call CRA_PlayerInit;
	[] call CRA_SideInit;
	[true] call CRQ_CatalogInit;
	[] call CRA_ItemInit;
	[] call CRA_AssetInit;
	[] call CRA_ProgressInitPre;
	[] call CRA_CivilianInit;
	gRA_TickInitPre = diag_tickTime - _tickInitPre;
	if (gRA_SettingSystemHotLoad) exitWith {};
	[] call CRA_InitPost;
};
CRA_Init = {
	if (!gRA_SettingSystemHotLoad) exitWith {};
	[] spawn CRA_InitPost;
};
CRA_InitPost = {
	private _tickInitPost = diag_tickTime;
	if (gRA_SettingSystemHotLoad) then {CRQ_BS_TM_SYNC spawn {while {pRA_Initializing} do {publicVariable "pRA_LoadMessage"; publicVariable "pRA_LoadIndex"; publicVariable "pRA_LoadTotal"; sleep _this;};};};
	dRA_WorldHouses = ["HOUSE"] call CRQ_WorldTerrainObjects;
	private _tickInitDepot = diag_tickTime;
	[] call CRA_DepotInit;
	gRA_TickInitDepot = diag_tickTime - _tickInitDepot;
	private _tickInitLocation = diag_tickTime;
	[] call CRA_LocationInit;
	gRA_TickInitLocation = diag_tickTime - _tickInitLocation;
	[] call CRA_ProgressInitPost;
	missionNamespace setVariable ["pRA_Initializing", false, true];
	gRA_TickInitPost = diag_tickTime - _tickInitPost;
	[] call CRA_PlayerGreet;
};
CRA_SideInit = {
	private _relation = (CRQ_RELATIONS_NEUTRAL + CRQ_RELATIONS_FRIEND) / 2;
	[CRQ_SD_BLUFOR, CRQ_SD_CIVFOR, _relation] call CRQ_SideBilateral;
	[CRQ_SD_IDFOR,  CRQ_SD_CIVFOR, _relation] call CRQ_SideBilateral;
	[CRQ_SD_OPFOR,  CRQ_SD_CIVFOR, _relation] call CRQ_SideBilateral;
};
CRA_SideRelation = {
	([CRA_PLAYER_SIDE, _this] call CRQ_SideRelation)
};
CRA_ActionRelayReceive = {
	params ["_object", "_invoker", "_id", "_args"];
	//_args params ["_type", "_typeArgs"];
	switch (_args#0) do {
		case CRA_ACTION_ID_PLAYER_TELEPORT: {remoteExec ["CRA_LocalPlayerRequestTeleport", owner _invoker];};
		case CRA_ACTION_ID_PLAYER_PARADROP: {remoteExec ["CRA_LocalPlayerRequestParadrop", owner _invoker];};
		case CRA_ACTION_ID_MILITIA_TRAIN: {["Train Militia: Coming soon!"] remoteExec ["systemChat", owner _invoker];};
		case CRA_ACTION_ID_INTEL_GATHER: {_args call CRA_PlayerActionBase;};
		case CRA_ACTION_ID_INVENTORY_SORT: {_args call CRA_PlayerActionBase;};
		case CRA_ACTION_ID_INVENTORY_GATHER: {_args call CRA_PlayerActionBase;};
		default {};
	};
};
CRA_ActionRelayAdd = {
	params ["_object", "_label", "_args", ["_priority", CRA_ACTION_PRIORITY], ["_range", CRA_ACTION_RANGE]];
	if (_object isEqualTo objNull) exitWith {};
	private _label = "<t color='#" + CRA_ACTION_COLOR + "'>" + _label + "</t>";
	[_object, [_label, {_this call CRA_LocalActionRelayTransmit;}, _args, _priority, true, true, "", "true", _range, false]] call CRQ_fnc_AC_Add;
};
CRA_ProgressGrowthLinear = {
	params ["_base", "_span", "_factor", "_progress"];
	(_base + _span * (((_progress * _factor) min 1) max 0))
};
CRA_ProgressGrowthParabolic = {
	params ["_base", "_span", "_factor", "_progress"];
	(_base + _span * (((_progress ^ _factor) min 1) max 0))
};
CRA_ProgressInitPre = {
	
	gRA_ProgressValue = 1;
	gRA_ProgressGain = 0;
	
	gRA_fnc_ProgressMission = [
		{gRA_SettingProgressMissionInit},
		{[gRA_SettingProgressMissionInit, gRA_ProgressSpanMission, gRA_SettingProgressMissionFactor, gRA_ProgressGain / gRA_ProgressValue] call CRA_ProgressGrowthLinear},
		{[gRA_SettingProgressMissionInit, gRA_ProgressSpanMission, gRA_SettingProgressMissionFactor, gRA_ProgressGain / gRA_ProgressValue] call CRA_ProgressGrowthParabolic},
		{[gRA_SettingProgressMissionFinal, -gRA_ProgressSpanMission, gRA_SettingProgressMissionFactor, 1 - gRA_ProgressGain / gRA_ProgressValue] call CRA_ProgressGrowthLinear},
		{[gRA_SettingProgressMissionFinal, -gRA_ProgressSpanMission, gRA_SettingProgressMissionFactor, 1 - gRA_ProgressGain / gRA_ProgressValue] call CRA_ProgressGrowthParabolic}
	]#gRA_SettingProgressMissionMode;
	
	gRA_fnc_ProgressEquipment = [
		{gRA_SettingProgressEquipmentInit},
		{[gRA_SettingProgressEquipmentInit, gRA_ProgressSpanEquipment, gRA_SettingProgressEquipmentFactor, gRA_ProgressMission] call CRA_ProgressGrowthLinear},
		{[gRA_SettingProgressEquipmentInit, gRA_ProgressSpanEquipment, gRA_SettingProgressEquipmentFactor, gRA_ProgressMission] call CRA_ProgressGrowthParabolic},
		{[gRA_SettingProgressEquipmentFinal, -gRA_ProgressSpanEquipment, gRA_SettingProgressEquipmentFactor, 1 - gRA_ProgressMission] call CRA_ProgressGrowthLinear},
		{[gRA_SettingProgressEquipmentFinal, -gRA_ProgressSpanEquipment, gRA_SettingProgressEquipmentFactor, 1 - gRA_ProgressMission] call CRA_ProgressGrowthParabolic}
	]#gRA_SettingProgressEquipmentMode;
	
	gRA_fnc_ProgressActivation = [
		{gRA_SettingProgressActivationInit},
		{[gRA_SettingProgressActivationInit, gRA_ProgressSpanActivation, gRA_SettingProgressActivationFactor, gRA_ProgressMission] call CRA_ProgressGrowthLinear},
		{[gRA_SettingProgressActivationInit, gRA_ProgressSpanActivation, gRA_SettingProgressActivationFactor, gRA_ProgressMission] call CRA_ProgressGrowthParabolic},
		{[gRA_SettingProgressActivationFinal, -gRA_ProgressSpanActivation, gRA_SettingProgressActivationFactor, 1 - gRA_ProgressMission] call CRA_ProgressGrowthLinear},
		{[gRA_SettingProgressActivationFinal, -gRA_ProgressSpanActivation, gRA_SettingProgressActivationFactor, 1 - gRA_ProgressMission] call CRA_ProgressGrowthParabolic}
	]#gRA_SettingProgressActivationMode;
	
	gRA_fnc_ProgressEnemyArmy = [
		{gRA_SettingProgressEnemyArmyInit},
		{[gRA_SettingProgressEnemyArmyInit, gRA_ProgressSpanEnemyArmy, gRA_SettingProgressEnemyArmyFactor, gRA_ProgressMission] call CRA_ProgressGrowthLinear},
		{[gRA_SettingProgressEnemyArmyInit, gRA_ProgressSpanEnemyArmy, gRA_SettingProgressEnemyArmyFactor, gRA_ProgressMission] call CRA_ProgressGrowthParabolic},
		{[gRA_SettingProgressEnemyArmyFinal, -gRA_ProgressSpanEnemyArmy, gRA_SettingProgressEnemyArmyFactor, 1 - gRA_ProgressMission] call CRA_ProgressGrowthLinear},
		{[gRA_SettingProgressEnemyArmyFinal, -gRA_ProgressSpanEnemyArmy, gRA_SettingProgressEnemyArmyFactor, 1 - gRA_ProgressMission] call CRA_ProgressGrowthParabolic}
	]#gRA_SettingProgressEnemyArmyMode;
	
	gRA_fnc_ProgressEnemyCountBase = [
		{gRA_SettingProgressEnemyCountInit},
		{[gRA_SettingProgressEnemyCountInit, gRA_ProgressSpanEnemyCountBase, gRA_SettingProgressEnemyCountFactor, gRA_ProgressMission] call CRA_ProgressGrowthLinear},
		{[gRA_SettingProgressEnemyCountInit, gRA_ProgressSpanEnemyCountBase, gRA_SettingProgressEnemyCountFactor, gRA_ProgressMission] call CRA_ProgressGrowthParabolic},
		{[gRA_SettingProgressEnemyCountFinal, -gRA_ProgressSpanEnemyCountBase, gRA_SettingProgressEnemyCountFactor, 1 - gRA_ProgressMission] call CRA_ProgressGrowthLinear},
		{[gRA_SettingProgressEnemyCountFinal, -gRA_ProgressSpanEnemyCountBase, gRA_SettingProgressEnemyCountFactor, 1 - gRA_ProgressMission] call CRA_ProgressGrowthParabolic}
	]#gRA_SettingProgressEnemyCountMode;
	
	gRA_fnc_ProgressEnemyCountVarianceBase = [
		{gRA_SettingProgressEnemyCountVarianceInit},
		{[gRA_SettingProgressEnemyCountVarianceInit, gRA_ProgressSpanEnemyCountVariance, gRA_SettingProgressEnemyCountVarianceFactor, gRA_ProgressMission] call CRA_ProgressGrowthLinear},
		{[gRA_SettingProgressEnemyCountVarianceInit, gRA_ProgressSpanEnemyCountVariance, gRA_SettingProgressEnemyCountVarianceFactor, gRA_ProgressMission] call CRA_ProgressGrowthParabolic},
		{[gRA_SettingProgressEnemyCountVarianceFinal, -gRA_ProgressSpanEnemyCountVariance, gRA_SettingProgressEnemyCountVarianceFactor, 1 - gRA_ProgressMission] call CRA_ProgressGrowthLinear},
		{[gRA_SettingProgressEnemyCountVarianceFinal, -gRA_ProgressSpanEnemyCountVariance, gRA_SettingProgressEnemyCountVarianceFactor, 1 - gRA_ProgressMission] call CRA_ProgressGrowthParabolic}
	]#gRA_SettingProgressEnemyCountVarianceMode;
	gRA_fnc_ProgressEnemyCountVarianceDist = [
		{[1 - _this, 2 * _this, 0]},
		{[1 - _this, 1, 1 + _this]}
	]#gRA_SettingProgressEnemyCountVarianceDist;
	
	
	gRA_fnc_ProgressEnemySkillBase = [
		{gRA_SettingProgressEnemySkillInit},
		{[gRA_SettingProgressEnemySkillInit, gRA_ProgressSpanEnemySkillBase, gRA_SettingProgressEnemySkillFactor, gRA_ProgressMission] call CRA_ProgressGrowthLinear},
		{[gRA_SettingProgressEnemySkillInit, gRA_ProgressSpanEnemySkillBase, gRA_SettingProgressEnemySkillFactor, gRA_ProgressMission] call CRA_ProgressGrowthParabolic},
		{[gRA_SettingProgressEnemySkillFinal, -gRA_ProgressSpanEnemySkillBase, gRA_SettingProgressEnemySkillFactor, 1 - gRA_ProgressMission] call CRA_ProgressGrowthLinear},
		{[gRA_SettingProgressEnemySkillFinal, -gRA_ProgressSpanEnemySkillBase, gRA_SettingProgressEnemySkillFactor, 1 - gRA_ProgressMission] call CRA_ProgressGrowthParabolic}
	]#gRA_SettingProgressEnemySkillMode;
	
	gRA_fnc_ProgressEnemySkillVarianceBase = [
		{gRA_SettingProgressEnemySkillVarianceInit},
		{[gRA_SettingProgressEnemySkillVarianceInit, gRA_ProgressSpanEnemySkillVariance, gRA_SettingProgressEnemySkillVarianceFactor, gRA_ProgressMission] call CRA_ProgressGrowthLinear},
		{[gRA_SettingProgressEnemySkillVarianceInit, gRA_ProgressSpanEnemySkillVariance, gRA_SettingProgressEnemySkillVarianceFactor, gRA_ProgressMission] call CRA_ProgressGrowthParabolic},
		{[gRA_SettingProgressEnemySkillVarianceFinal, -gRA_ProgressSpanEnemySkillVariance, gRA_SettingProgressEnemySkillVarianceFactor, 1 - gRA_ProgressMission] call CRA_ProgressGrowthLinear},
		{[gRA_SettingProgressEnemySkillVarianceFinal, -gRA_ProgressSpanEnemySkillVariance, gRA_SettingProgressEnemySkillVarianceFactor, 1 - gRA_ProgressMission] call CRA_ProgressGrowthParabolic}
	]#gRA_SettingProgressEnemySkillVarianceMode;
	gRA_fnc_ProgressEnemySkillVarianceDist = [
		{[1 - _this, 2 * _this, 0]},
		{[1 - _this, 1, 1 + _this]}
	]#gRA_SettingProgressEnemySkillVarianceDist;
	
	gRA_ProgressCoeffEnemyCountPlayer = 1 / (1 max (playableSlotsNumber (CRA_PLAYER_SIDE call CRQ_Side) - 1));
	gRA_fnc_ProgressEnemyCountPlayer = [
		{gRA_SettingProgressEnemyCountPlayerInit},
		{[gRA_SettingProgressEnemyCountPlayerInit, gRA_ProgressSpanEnemyCountPlayer, gRA_SettingProgressEnemyCountPlayerFactor, (((gRA_PlayerCount) - 1) max 0) * gRA_ProgressCoeffEnemyCountPlayer] call CRA_ProgressGrowthLinear},
		{[gRA_SettingProgressEnemyCountPlayerInit, gRA_ProgressSpanEnemyCountPlayer, gRA_SettingProgressEnemyCountPlayerFactor, (((gRA_PlayerCount) - 1) max 0) * gRA_ProgressCoeffEnemyCountPlayer] call CRA_ProgressGrowthParabolic},
		{[gRA_SettingProgressEnemyCountPlayerFinal, -gRA_ProgressSpanEnemyCountPlayer, gRA_SettingProgressEnemyCountPlayerFactor, 1 - (((gRA_PlayerCount) - 1) max 0) * gRA_ProgressCoeffEnemyCountPlayer] call CRA_ProgressGrowthLinear},
		{[gRA_SettingProgressEnemyCountPlayerFinal, -gRA_ProgressSpanEnemyCountPlayer, gRA_SettingProgressEnemyCountPlayerFactor, 1 - (((gRA_PlayerCount) - 1) max 0) * gRA_ProgressCoeffEnemyCountPlayer] call CRA_ProgressGrowthParabolic}
	]#gRA_SettingProgressEnemyCountPlayerMode;
	
	gRA_fnc_VarianceEnemyCount = [
		{(gRA_ProgressEnemyCountVariance#0) + random (gRA_ProgressEnemyCountVariance#1)},
		{random gRA_ProgressEnemyCountVariance}
	]#gRA_SettingProgressEnemyCountVarianceDist;
	gRA_fnc_VarianceEnemySkill = [
		{(gRA_ProgressEnemySkillVariance#0) + random (gRA_ProgressEnemySkillVariance#1)},
		{random gRA_ProgressEnemySkillVariance}
	]#gRA_SettingProgressEnemySkillVarianceDist;
	
	[] call CRA_ProgressCalculate;
};
CRA_ProgressInitPost = {
	gRA_ProgressValue = 0;
	{gRA_ProgressValue = gRA_ProgressValue + (_x getVariable [CRA_SVAR_LOCATION_VALUE, 0]);} forEach gRA_Locations;
	gRA_ProgressValue = 1 max gRA_ProgressValue;
};
CRA_ProgressCalculate = {
	gRA_ProgressMission = [] call gRA_fnc_ProgressMission;
	gRA_ProgressEquipment = [] call gRA_fnc_ProgressEquipment;
	gRA_ProgressActivation = [] call gRA_fnc_ProgressActivation;
	gRA_ProgressEnemyArmy = [] call gRA_fnc_ProgressEnemyArmy;
	gRA_ProgressEnemyCountBase = [] call gRA_fnc_ProgressEnemyCountBase;
	gRA_ProgressEnemySkillBase = [] call gRA_fnc_ProgressEnemySkillBase;
	gRA_ProgressEnemyCountVariance = ([] call gRA_fnc_ProgressEnemyCountVarianceBase) call gRA_fnc_ProgressEnemyCountVarianceDist;
	gRA_ProgressEnemySkillVariance = ([] call gRA_fnc_ProgressEnemySkillVarianceBase) call gRA_fnc_ProgressEnemySkillVarianceDist;
};
CRA_ProgressAward = {
	gRA_ProgressGain = gRA_ProgressGain + _this;
	[] call CRA_ProgressCalculate;
};
CRA_PlayerInit = {
	private _last = (playableSlotsNumber (CRA_PLAYER_SIDE call CRQ_Side)) - 1;
	for "_i" from 0 to _last do {
		private _var = CRA_PLAYER_VAR + str _i;
		gRA_PlayerReg pushBack false;
		gRA_PlayerInit pushBack false;
		gRA_PlayerDist pushBack false;
		gRA_PlayerPrePos pushBack [];
		gRA_PlayerIndex set [_var, _i];
		gRA_PlayerVar pushBack _var;
		gRA_PlayerInventory pushBack [];
		gRA_PlayerMail pushBack [];
		gRA_PlayerAsset pushBack objNull;
	};
};
CRA_PlayerGetIndex = {
	(gRA_PlayerIndex getOrDefault [vehicleVarName _this, -1])
};
CRA_PlayerGetUnit = {
	missionNamespace getVariable [gRA_PlayerVar#_this, objNull]
};
CRA_PlayerGetOwner = {
	(owner (_this call CRA_PlayerGetUnit))
};
CRA_fnc_PL_MailRead = {
	params ["_unit", "_mailIndex"];
	private _playerIndex = _unit call CRA_PlayerGetIndex;
	if (_playerIndex == -1) exitWith {};
	(gRA_PlayerMail#_playerIndex#_mailIndex) set [0, true];
};
CRA_PlayerMailSend = {
	params ["_recipient", "_mail"];
	//_mail params ["_read", "_attachment", "_date", "_sender", "_subject", "_text"];
	if (_recipient isEqualTo []) then {_recipient = gRA_PlayerIndex apply {_y};};
	{
		private _mailbox = (gRA_PlayerMail#_x);
		private _index = count _mailbox;
		_mailbox pushBack (+_mail);
		private _owner = _x call CRA_PlayerGetOwner;
		if (_owner != 0) then {[CRA_PVAR_PLAYER_MAILBOX, _index, _mail, _owner] call CRQ_SyncArrayIndex;};
	} forEach _recipient;
};
CRA_PlayerLoop = {
	gRA_PlayerUnits = (allPlayers select {gRA_PlayerInit#(_x call CRA_PlayerGetIndex)});
	gRA_PlayerCount = count gRA_PlayerUnits;
	gRA_PlayerPos = (gRA_PlayerUnits apply {_x call CRQ_Pos2D});//TODO all necessary for  + (gRA_PlayerPrePos select {_x isNotEqualTo []});
	{
		private _asset = objectParent _x;
		if (_asset isNotEqualTo objNull) then {
			private _index = _x call CRA_PlayerGetIndex;
			if (_index < 0) exitWith {};
			gRA_PlayerAsset set [_index, _asset];
		};
	} forEach gRA_PlayerUnits;
};
CRA_PlayerGreet = {
	[[], [false, [], date, [CRA_TEXT_GENERIC_DICT,[CRA_DICT_PROTAGONIST_MAIL]], [CRA_TEXT_MAIL_SUBJECT_GREET,[-1]], [CRA_TEXT_MAIL_TEXT_GREET,[-1,CRA_DICT_ANTAGONIST_SHORT,-1,CRA_DICT_PROTAGONIST_FULL]]]] call CRA_PlayerMailSend;
};
CRA_PlayerHide = {
	gRA_PlayerDist set [_this call CRA_PlayerGetIndex, false];
	_this hideObjectGlobal true;
};
CRA_PlayerShow = {
	private _index = _this call CRA_PlayerGetIndex;
	gRA_PlayerInit set [_index, true];
	gRA_PlayerDist set [_index, true];
	_this hideObjectGlobal false;
};
CRA_PlayerRegister = { // Sometimes spawn before connect, sometimes other way around
	
};
CRA_PlayerConnect = {
//systemChat "CRA_PlayerConnect";
	params ["_unit", "_id", "_uid", "_name", "_jip"];
	private _index = _unit call CRA_PlayerGetIndex;
	if (_index == -1) exitWith {};
	gRA_PlayerInit set [_index, false];
	gRA_PlayerDist set [_index, false];
	[CRA_PVAR_PLAYER_MAILBOX, gRA_PlayerMail#_index, owner _unit] call CRQ_SyncArrayFull;
};
CRA_PlayerDisconnect = {
	params ["_unit", "_id", "_uid", "_name"];
	private _loadout = getUnitLoadout _unit;
	private _index = _unit call CRA_PlayerGetIndex;
	_unit call CRQ_UnitDelete;
	if (_index == -1) exitWith {};
	gRA_PlayerInit set [_index, false];
	gRA_PlayerDist set [_index, false];
	gRA_PlayerInventory set [_index, _loadout];
};
CRA_PlayerSpawn = {
//systemChat "CRA_PlayerSpawn";
	params ["_unit", "_respawn"];
	_unit call CRA_PlayerHide;
	_unit call CRA_PlayerLoadout;
	_unit call CRA_fnc_PL_RQI_Spawn;
	// remoteExec ["CRA_LocalPlayerRequestSpawn", owner _unit];
};
CRA_fnc_PL_RQI_Spawn = {
	remoteExec ["CRA_LocalPlayerRequestSpawn", owner _this];
};
CRA_fnc_PL_RQR_Spawn = {
	params ["_unit", "_index", ["_vec", []]];
	private _valid = true; // TODO
	if (_index < 0) then {
		[_unit, _vec] call CRA_PlayerParadrop;
	} else {
		[_unit, (gRA_Locations#_index)] call CRA_PlayerTeleport;
	};
	if (_valid) exitWith {
		_unit call CRA_PlayerShow;
		_unit call CRQ_fnc_CL_Restore;
	};
	_unit call CRA_fnc_PL_RQI_Spawn;
};
CRA_fnc_PL_RQR_Teleport = {
	params ["_unit", "_index"];
	if (_index == -1) exitWith {};
	if (gRA_LocationSafe getOrDefault [_index, false]) exitWith {[_unit, gRA_Locations#_index] call CRA_PlayerTeleport;};
	[CRA_TEXT_EVENT_LOCATION_INSECURE, [_index], owner _unit] call CRA_PlayerInfoMessage;
};
CRA_fnc_PL_RQR_Paradrop = {
	params ["_unit", "_vec"];
	private _valid = true; // TODO
	if (_valid) exitWith {[_unit, _vec] call CRA_PlayerParadrop;};
};
CRA_PlayerTeleport = {
	params ["_unit", "_location"];
	private _vec = _location getVariable [CRA_SVAR_LOCATION_BASE_PLAYER, []];
	if (_vec isEqualTo []) then {_vec = [locationPosition _location, random 360];};
	[_unit, _vec] remoteExec ["CRA_Teleport", owner _unit]; // setting Dir only works locally
};
CRA_PlayerParadrop = {
	params ["_unit", "_vec"];
	_this remoteExec ["CRA_Paradrop", owner _unit];
	//[_vector#0, [0,0,0], CRA_PARADROP_HEIGHT + 20, "FULL", "B_CTRG_Heli_Transport_01_tropic_F", west] call BIS_fnc_ambientFlyBy;
};
/*
CRA_PlayerInRange = {
	params ["_pos", "_range"];
	private _trigger = false;
	{if (_pos distance2D _x <= _range) exitWith {_trigger = true;};} forEach gRA_PlayerPos;
	_trigger
};
*/
CRA_PlayerActivity = {
	params ["_vec", "_range", ["_prev", 0], ["_min", -1e10], ["_max", 1e10]];
	private _pos = _vec#0;
	private _dist = 1e10;
	{_dist = _dist min (_pos distance2D _x);} forEach gRA_PlayerPos;
	private _activity = (CRA_ACTIVITY_COEF * _range / (1 max _dist)) max _prev;
	private _decay = CRA_ACTIVITY_COEF * _dist / (_range + CRA_ACTIVITY_HYSTERESIS);
	(((_activity - _decay) max _min) min _max)
};
CRA_PlayerLoadout = {
	private _index = _this call CRA_PlayerGetIndex;
	private _identity = if (gRA_SettingPlayerIdentity && {_index != -1}) then {dCRA_PLAYER_IDENTITY#_index} else {[]};
	private _loadout = [];
	if (_index != -1) then {
		_loadout = +(gRA_PlayerInventory#_index);
		if (_loadout isNotEqualTo []) then {
			gRA_PlayerInventory set [_index, []];
		} else {
			_loadout = (_index call CRA_UnitGenerate)#1;
		};
	} else {
		_loadout = (CRA_UNIT_PLAYER_DEFAULT call CRA_UnitGenerate)#1;
	};
	[_this, _identity, _loadout] remoteExec ["CRQ_fnc_PLL_IdentityLoadout", owner _this];
};
CRA_PlayerInfoMessage = {
	params ["_message", "_arg", ["_target", gCS_MP_Broadcast]];
	[_message, _arg] remoteExec ["CRA_LocalPlayerInfoMessage", _target];
};
CRA_PlayerInfoNotify = {
	params ["_message", "_arg", ["_target", gCS_MP_Broadcast]];
	[_message, _arg] remoteExec ["CRA_LocalPlayerInfoNotify", _target];
};
CRA_PlayerActionBase = {
	private _location = gRA_Locations#(_this#1);
	if (true) then { // TODO
		switch (_this#0) do {
			case CRA_ACTION_ID_INVENTORY_SORT: {
				_location call CRA_LocationInventorySort;
				[CRA_TEXT_INFO_BASE_INVENTORY_SORT,[_this#1]] call CRA_PlayerInfoMessage;
			};
			case CRA_ACTION_ID_INVENTORY_GATHER: {
				([_location, _this#2] call CRA_LocationInventoryGather) params ["_countItems", "_countMags", "_countWeapons", "_countContainers"];
				[CRA_TEXT_INFO_BASE_INVENTORY_GATHER,[_this#1, _this#2]] call CRA_PlayerInfoMessage;
				[CRA_TEXT_INFO_BASE_INVENTORY_GATHER_RESULT,[_this#1, _countWeapons, _countMags, _countContainers, _countItems]] call CRA_PlayerInfoMessage;
			};
			case CRA_ACTION_ID_INTEL_GATHER: {
				(_location call CRA_LocationIntelGather) params [["_range", 0], ["_intel", []]];
				if (_range <= 0) exitWith {};
				private _info = "";
				{
					private _label = str _y + "x" + _x;
					if (_forEachIndex > 0) then {_info = _info + ", " + _label;} else {_info = _label;};
				} forEach _intel;
				if (_info isNotEqualTo "") then {
					[CRA_TEXT_INFO_INTEL_GATHER,[_this#1, _range, _info]] call CRA_PlayerInfoMessage;
				} else {
					[CRA_TEXT_INFO_INTEL_NONE,[_this#1, _range]] call CRA_PlayerInfoMessage;
				};
			};
			default {};
		};
	} else {
		[CRA_TEXT_EVENT_LOCATION_INSECURE,[_this#1]] call CRA_PlayerInfoMessage;
	};
};
CRA_PlayerLocationSafe = {
	private _safe = createHashMap;
	private _locations = [];
	{
		if ((_x call CRA_fnc_LC_Owner) == CRA_PLAYER_SIDE) then {
			private _index = _x getVariable [CRA_SVAR_LOCATION_INDEX, -1];
			if (_index == -1) exitWith {};
			_safe set [_index, true];
			_locations pushBackUnique _index;
		};
	} forEach gRA_LocationHistory;
	gRA_LocationSafe = _safe;
	missionNamespace setVariable ["pRA_LocationSafe", _locations, true];
};
CRA_PlayerLocationEnter = {
	private _index = _this getVariable [CRA_SVAR_LOCATION_INDEX, -1];
	if (_index == -1) exitWith {};
	private _type = _this getVariable [CRA_SVAR_LOCATION_TYPE, CRA_LOCATION_TYPE_OUTPOST];
	if ([CRA_LOCATION_TYPE_OUTPOST, CRA_LOCATION_TYPE_ROADBLOCK] find _type == -1) then {
		[CRA_TEXT_EVENT_LOCATION_ANNOUNCE_FULL, [_index, _this call CRA_fnc_LC_Owner]] call CRA_PlayerInfoMessage;
	} else {
		[CRA_TEXT_EVENT_LOCATION_ANNOUNCE_SHORT, [_index]] call CRA_PlayerInfoMessage;
	};
};
CRA_PlayerLocationCapture = {
	private _index = _this getVariable [CRA_SVAR_LOCATION_INDEX, -1];
	if (_index == -1) exitWith {};
	private _owner = _this call CRA_fnc_LC_Owner;
	private _ownerPrev = [_this, 1] call CRA_fnc_LC_Owner;
	private _message = if (_owner != CRQ_SD_CIVFOR) then {
		if (_ownerPrev != CRQ_SD_CIVFOR) then {
			[CRA_TEXT_EVENT_LOCATION_CAPTURE_FROM, [_index, _owner, _ownerPrev]]
		} else {
			[CRA_TEXT_EVENT_LOCATION_CAPTURE, [_index, _owner]]
		};
	} else {
		[CRA_TEXT_EVENT_LOCATION_LOST, [_index, _ownerPrev]]
	};
	_message call CRA_PlayerInfoMessage;
	private _player = false;
	if (_ownerPrev isEqualTo CRA_PLAYER_SIDE) then {_this call CRA_PlayerLocationLost; _player = true;};
	if (_owner isEqualTo CRA_PLAYER_SIDE) then {_this call CRA_PlayerLocationWin; _player = true;};
	if (_player) then {[] call CRA_PlayerLocationSafe;};
};
CRA_PlayerLocationWin = {
	remoteExec ["CRA_LocalPlayerLocationWin", gCS_MP_Broadcast];
	if (_this getVariable [CRA_SVAR_LOCATION_UNCAPTURED, false]) then {
		(_this getVariable [CRA_SVAR_LOCATION_VALUE, 0]) call CRA_ProgressAward;
		_this setVariable [CRA_SVAR_LOCATION_UNCAPTURED, false];
		gRA_LocationHistory pushBack _this;
	};
	private _index = _this getVariable [CRA_SVAR_LOCATION_INDEX, -1];
	if (_index == -1) exitWith {};
	[CRA_TEXT_NOTIFY_LOCATION_GAIN, [_index]] call CRA_PlayerInfoNotify;
};
CRA_PlayerLocationLost = {
	remoteExec ["CRA_LocalPlayerLocationLost", gCS_MP_Broadcast];
	private _index = _this getVariable [CRA_SVAR_LOCATION_INDEX, -1];
	if (_index == -1) exitWith {};
	[CRA_TEXT_NOTIFY_LOCATION_LOST, [_index]] call CRA_PlayerInfoNotify;
};
CRA_LocationLoop = {
	{
		_x call {
			private _vec = _this getVariable [CRA_SVAR_VEC, []];
			if (_vec isEqualTo []) exitWith {};
			
			private _act = [_vec, gRA_ProgressActivation, _this getVariable [CRA_SVAR_ACTIVITY, 0], CRA_ACTIVITY_MIN, CRA_ACTIVITY_MAX] call CRA_PlayerActivity;
			_this setVariable [CRA_SVAR_ACTIVITY, _act];
			
			private _fncMain = _this getVariable [CRA_SVAR_FNC_MAIN, CRA_LOCATION_FNC_MAIN_NONE];
			private _state = _this getVariable [CRA_SVAR_LOCATION_STATE, -1];
			if (_state == CRA_STATE_ACTIVE) exitWith {
				if (_act <= 0) exitWith {
					_this call (_fncMain#2);
					[_this, CRA_STATE_HIBERNATE] call CRA_LocationState;
				};
				_this call (_fncMain#1);
			};
			if (_act < 1) exitWith {};
			_this call (_fncMain#0);
			[_this, CRA_STATE_ACTIVE] call CRA_LocationState;
		};
		_x call CRA_LocationTrigger;
	} forEach gRA_Locations;
};
CRA_LocationTrigger = {
	private _activity = _this getVariable [CRA_SVAR_ACTIVITY, 0];
	if (_activity <= 0) exitWith {};
	(_this getVariable [CRA_SVAR_TRIGGER, CRA_LOCATION_TRIG_NONE]) params ["_trigger", "_cache"];
	{
		_x params ["_type", "_fnc_cond", "_fnc_trigger"];
		private _state = _cache#_forEachIndex;
		if (_type - _state != 0 && {[_this, _activity] call _fnc_cond}) then {
			_this call _fnc_trigger;
			if (_type > 0) then {_cache set [_forEachIndex, _state + 1]};
		};
	} forEach _trigger;
};
CRA_LocationDiscover = {
	params ["_location", "_silent"];
	if (_location getVariable [CRA_SVAR_LOCATION_DISCOVER, true]) exitWith {};
	_location setVariable [CRA_SVAR_LOCATION_DISCOVER, true];
	_location call CRA_LocationMarkerState;
	if (_silent) exitWith {};
	_location call CRA_PlayerLocationEnter;
};
CRA_LocationBaseEnter = { // TODO find a proper name!
	_this call CRA_LocationBaseSpawn;
	_this call CRA_LocationBaseRadioNext;
	[_this, call CRQ_Lights] call CRA_LocationBaseLights;
	
	private _init = (_this getVariable [CRA_SVAR_LOCATION_STATE, -1]) == CRA_STATE_INIT;
	
	private _timeDelta = [_this getVariable [CRA_SVAR_LOCATION_HIBERNATE_TIME, gCS_TM_Now], gCS_TM_Now] call CRQ_fnc_TimeDelta;
	private _rejuvenation = (_timeDelta / 60) * CRA_LOCATION_REJUVENATION;
	private _damageUnit = (_this getVariable [CRA_SVAR_LOCATION_DAMAGE_PERSONNEL, 0]) - _rejuvenation;
	private _damageVehicle = (_this getVariable [CRA_SVAR_LOCATION_DAMAGE_VEHICLE, 0]) - _rejuvenation;
	
	private _hostile = (CRA_PLAYER_SIDE call CRQ_SideEnemy) find (_this call CRA_fnc_LC_Owner) != -1;
	if (_init || _hostile && {_damageUnit <= 0 && _damageVehicle <= 0}) then {
		if (_init || {random 1 < _rejuvenation}) then {
			[_this, ([CRQ_SD_OPFOR, CRQ_SD_IDFOR] selectRandomWeighted [gRA_ProgressEnemyArmy, 1 - gRA_ProgressEnemyArmy])] call CRA_LocationOwnerInit; // TODO partial rejuvenation
			_this call CRA_LocationInventoryInit;
		};
		_this call CRA_LocationPersonnelSpawn;
	} else {
		_this call CRA_LocationThaw;
	};
	
	_this call CRA_LocationPersonnelOrders;
	
	_this call CRA_LocationInventoryLoad;
	_this call CRA_LocationActionCreate;
	_this call CRA_LocationFlagUpdate;
};
CRA_LocationBaseActive = {
	_this call CRA_LocationPersonnelLoop;
	_this call CRA_LocationCaptureLoop;
	_this call CRA_LocationBaseRadioLoop;
};
CRA_LocationBaseLeave = { // TODO find a proper name!
	_this call CRA_LocationHibernate;
	_this call CRA_LocationPersonnelDespawn;
	_this call CRA_LocationActionRemove;
	_this call CRA_LocationInventorySave;
	_this call CRA_LocationBaseDespawn;
};
CRA_LocationDepotEnter = {
	_this call CRA_LocationBaseSpawn;
	if (_this getVariable [CRA_SVAR_LOCATION_STATE, -1] != CRA_STATE_INIT) exitWith {};
	for "_i" from 0 to ((count (_this getVariable [CRA_SVAR_LOCATION_ASSET_SPAWN, []])) - 1) do {[_this, _i] call CRA_DepotSpawn;};
};
// CRA_LocationDepotActive = {
	// {
		// (_x#1) params [["_removed", false], ["_timeDeath", -1], ["_timeAbandon", -1]];
		// if (_removed) then {
			// private _inhibit = gRA_SettingDepotRespawnAbandon == -1 || {_timeAbandon == -1 || {([_timeAbandon, gCS_TM_Now] call CRQ_fnc_TimeDelta) < gRA_SettingDepotRespawnAbandon}};
			// _inhibit = _inhibit && {gRA_SettingDepotRespawnWreck == -1 || {_timeDeath == -1 || {([_timeDeath, gCS_TM_Now] call CRQ_fnc_TimeDelta) < gRA_SettingDepotRespawnWreck}}};
			// if (_inhibit) exitWith {};
			// [_this, _forEachIndex] call CRA_DepotSpawn;
		// };
	// } forEach ([_this] call CRQ_LinkDataRead);
// };
CRA_LocationDepotActive = {
	{
		{
			_x params [["_removed", false], ["_timeDeath", -1], ["_timeAbandon", -1]];
			if (_removed) then {
				private _inhibit = gRA_SettingDepotRespawnAbandon == -1 || {_timeAbandon == -1 || {([_timeAbandon, gCS_TM_Now] call CRQ_fnc_TimeDelta) < gRA_SettingDepotRespawnAbandon}};
				_inhibit = _inhibit && {gRA_SettingDepotRespawnWreck == -1 || {_timeDeath == -1 || {([_timeDeath, gCS_TM_Now] call CRQ_fnc_TimeDelta) < gRA_SettingDepotRespawnWreck}}};
				if (_inhibit) exitWith {};
				[_this, _forEachIndex] call CRA_DepotSpawn;
			};
		} forEach ((_x call CRQ_fnc_LNK_Get)#1);
	} forEach (_this call CRQ_fnc_LNK_Get);
};
CRA_LocationDepotLeave = {
	_this call CRA_LocationBaseDespawn;
};
CRA_LocationState = {
	params ["_location", "_state"];
	_location setVariable [CRA_SVAR_LOCATION_STATE, _state];
	if (_location getVariable [CRA_SVAR_LOCATION_DISCOVER, false]) then {_location call CRA_LocationMarkerState;};
};
dCRA_SD_COUNT = missionNamespace getVariable ["dCRA_SD_COUNT", CRQ_SD_TYPES apply {0}];
dCRA_SD_INDEX = missionNamespace getVariable ["dCRA_SD_INDEX", CRQ_SD_TYPES apply {_x call CRQ_Side}];
#define CRA_GV_OW_MIN 0
#define CRA_GV_OW_MAX 1
#define CRA_GV_OW_RATE_DECAY 0.1
#define CRA_GV_OW_RATE_GROWTH 0.2
#define CRA_GV_OW_FACTOR_VALUE 0.2
CRA_fnc_LC_Owner = {
	if (_this isEqualType locationNull) exitWith {((_this getVariable ["CRAS_LC_OWN", [[CRQ_SD_UNKNOWN]]])#0) select -1};
	params ["_location", ["_history", 0]];
	(_location getVariable ["CRAS_LC_OWN", [[CRQ_SD_UNKNOWN]]]) params [["_owLog", []], ["_owFav", []]];//, ["_owRoll", [0,0,0,1]]];
	if (_history < 0) exitWith {
		if (_owFav isEqualTo []) exitWith {[CRQ_SD_UNKNOWN, 0]};
		_owFav
	};
	if (_owLog isEqualTo []) exitWith {CRQ_SD_UNKNOWN};
	if (_history > 0) exitWith {
		private _count = count _owLog;
		_owLog#(_count - 1 - (_history % _count))
	};
	(_owLog select -1)
};
CRA_LocationOwnerInit = {
	params ["_location", ["_side", CRQ_SD_UNKNOWN]];
	_location setVariable ["CRAS_LC_OWN", [[_side], [_side, CRA_GV_OW_MAX], (dCRA_SD_INDEX) apply {if (_x isEqualTo _side) then {CRA_GV_OW_MAX} else {CRA_GV_OW_MIN}}]];
};
CRA_LocationCaptureLoop = {
	
	private _allowed = _this getVariable [CRA_SVAR_LOCATION_CAPTUREABLE, [CRQ_SD_CIVFOR]];
	
	(_this getVariable ["CRAS_LC_OWN", []]) params [["_ownerLog", [CRQ_SD_CIVFOR]], ["_ownerFavor", [CRQ_SD_UNKNOWN, 0]], ["_owspRolling", [0,0,0,1]]];
	private _ownerPresent = _ownerLog select -1;//(_this call CRA_fnc_LC_Owner) call {if (_this isEqualTo -1) then {CRQ_SD_CIVFOR} else {_this};};
	if (_ownerPresent == CRQ_SD_CIVFOR && {_allowed isEqualTo CRA_LOCATION_CAPTURE_NONE}) exitWith {};
	
	
	private _pos = (_this getVariable [CRA_SVAR_VEC, [[]]])#0;
	if (_pos isEqualTo []) then {_pos = locationPosition _this;};
	private _radius = ((size _this)#0) + CRA_BASE_ORBIT;
	
	private _fnc_unitInclude = {alive _this && {!(isPlayer _this) || {!(captive _this) && {gRA_PlayerDist#(_this call CRA_PlayerGetIndex)}}}};
	private _units = (_pos nearEntities [["Man"], _radius]) select {_x call _fnc_unitInclude};
	{{if (_x call _fnc_unitInclude) then {_units pushBack _x;};} forEach (crew _x);} forEach (_pos nearEntities [["Car", "Tank"], _radius]);
	
	private _unitCount = +dCRA_SD_COUNT;
	{(_x call CRQ_Side) call {if (_this isNotEqualTo CRQ_SD_UNKNOWN) exitWith {_unitCount set [_this, (_unitCount#_this) + 1];};};} forEach _units;
	private _unitTotal = 0;
	{_unitTotal = _unitTotal + _x;} forEach _unitCount;
	
	private _unitShare = if (_unitTotal > 0) then {_unitCount apply {_x / _unitTotal}} else {_unitCount apply {0}};
	private _vP = _unitShare apply {-(2^_x) + _x + _x^0.5 + 1}; // Presence; highest in favor for most numerous, but positively biased to lower counts
	private _vC = _owspRolling apply {(2^_x - _x^0.5 - _x)}; // Contestance; lowest for highest ownership, biased positively to low as well
	private _vSum = 0;
	{
		private _side = _forEachIndex;
		private _v0 = _x;
		private _vG = CRA_GV_OW_RATE_GROWTH * (_vP#_side) * (_vC#_side);
		private _vD = CRA_GV_OW_RATE_DECAY;
		{if (_x > 0) then {_vD = _vD * (gRA_SD_Matrix#_forEachIndex#_side);};} forEach _unitCount;
		private _v1 = CRA_GV_OW_MIN max (CRA_GV_OW_MAX min (_v0 - _vD + _vG));
		_owspRolling set [_side, _v1];
		_vSum = _vSum + _v1;
	} forEach _owspRolling;
	
	if (!(_vSum > 0)) exitWith {};
	private _owspRelative = _owspRolling apply {_x / _vSum};
	private _owspRanked = [];
	{
		if ((_x#0) > 0 && {(_x#1) isNotEqualTo CRQ_SD_CIVFOR && {true}}) then {
			_owspRanked pushBack _x;
		};
	} forEach (dCRA_SD_INDEX apply {[_owspRelative#_x, _x]});
	_owspRanked sort false;
	
	private _ownerGain = if (_owspRanked isNotEqualTo []) then {
		private _vContSum = 0;
		{_vContSum = _vContSum + (_x#0);} forEach _owspRanked;
		private _owspContestant = +dCRA_SD_COUNT;
		{_owspContestant set [_x#1, (_x#0) / _vContSum];} forEach _owspRanked;
		private _owDominant = _owspRanked#0#1;
		private _owRepresant = if (_allowed find (_owDominant) != -1) then {_owDominant} else {CRQ_SD_CIVFOR};
		if (_owDominant isNotEqualTo CRQ_SD_UNKNOWN) exitWith {
			private _flagUpdate = false;
			if ((_ownerFavor#0) isNotEqualTo _owDominant) then {_ownerFavor set [0, _owRepresant];};
			private _owspDefendant = +_owspContestant;
			private _vContest = _owspDefendant deleteAt _owDominant;
			private _vDominant = if (_owspDefendant isNotEqualTo []) then {(_vContest - (selectMax _owspDefendant))^(1 / (count _owspDefendant + 1))} else {1};
			if ((_ownerFavor#1) isNotEqualTo _vDominant) then {
				_flagUpdate = true;
				_ownerFavor set [1, _vDominant];
			};
			
			if (_ownerPresent isNotEqualTo _owDominant && {!((_owspContestant#_owDominant) < CRA_GV_OW_MAX)}) exitWith {
				_flagUpdate = true;
				_owRepresant
			};
			if (_flagUpdate) then {_this call CRA_LocationFlagUpdate;};
			CRQ_SD_UNKNOWN
		};
		CRQ_SD_UNKNOWN
	} else {
		CRQ_SD_UNKNOWN
	};
	private _ownerLoss = if (!((_owspRelative#_ownerPresent) > CRA_GV_OW_MIN) && {_allowed find CRQ_SD_CIVFOR != -1}) then {
		CRQ_SD_CIVFOR
	} else {
		CRQ_SD_UNKNOWN
	};
	if ([_ownerLoss, _ownerGain] isNotEqualTo [CRQ_SD_UNKNOWN, CRQ_SD_UNKNOWN]) then {
		private _ownerNew = if (_ownerGain isNotEqualTo CRQ_SD_UNKNOWN) then {_ownerGain} else {_ownerLoss};
		_ownerLog pushBack _ownerNew;
		_this call CRA_LocationCapture;
	};
	_this setVariable ["CRAS_LC_OWN", [_ownerLog, _ownerFavor, _owspRolling]];
};
CRA_LocationCapture = {
	_this call CRA_LocationMarkerState;
	_this call CRA_LocationFlagUpdate;
	_this call CRA_LocationPersonnelClear;
	_this call CRA_LocationPersonnelDespawn;
	_this call CRA_PlayerLocationCapture;
};
CRA_LocationHibernate = {
	private _hibUnits = [];
	private _hibVehicles = [];
	private _hibGroups = [];
	private _groups = _this getVariable [CRA_SVAR_LOCATION_GROUP_PERSONNEL, []];
	private _units = _this getVariable [CRA_SVAR_LOCATION_UNIT_PERSONNEL, []];
	private _vehicles = _this getVariable [CRA_SVAR_LOCATION_UNIT_VEHICLE, []];
	private _countUnit = _this getVariable [CRA_SVAR_LOCATION_COUNT_PERSONNEL, -1];
	private _countVehicle = _this getVariable [CRA_SVAR_LOCATION_COUNT_VEHICLE, -1];
	private _unitDamage = 0;
	private _vehicleDamage = 0;
	{
		if (isNull _x) then {
			_unitDamage = _unitDamage + 1;
			_hibUnits pushBack [];
		} else {
			private _vehicle = objectParent _x;
			private _turret = if (_vehicle isNotEqualTo objNull) then {[_vehicles find _vehicle, _vehicle unitTurret _x]} else {[]};
			private _group = (_groups find (group _x));
			private _hibernated = [_x call CRQ_UnitHibernate, _x call CRQ_CatalogIdentityRetrieve];
			_unitDamage = _unitDamage + damage _x;
			_hibUnits pushBack [_group, _turret, _hibernated#0, _hibernated#1];
		};
	} forEach _units;
	{
		if (isNull _x) then {
			_vehicleDamage = _vehicleDamage + 1;
			_hibVehicles pushBack [];
		} else {
			private _hibernated = _x call CRQ_VehicleHibernate;
			_vehicleDamage = _vehicleDamage + damage _x;
			_hibVehicles pushBack _hibernated;
		};
	} forEach _vehicles;
	{if (isNull _x) then {_hibGroups pushBack -1;} else {_hibGroups pushBack _forEachIndex;};} forEach _groups;
	_this setVariable [CRA_SVAR_LOCATION_HIBERNATE_GROUPS, _hibGroups];
	_this setVariable [CRA_SVAR_LOCATION_HIBERNATE_VEHICLES, _hibVehicles];
	_this setVariable [CRA_SVAR_LOCATION_HIBERNATE_UNITS, _hibUnits];
	_this setVariable [CRA_SVAR_LOCATION_HIBERNATE_TIME, gCS_TM_Now];
	_this setVariable [CRA_SVAR_LOCATION_DAMAGE_PERSONNEL, if (_countUnit > 0) then {_unitDamage / _countUnit} else {0}];
	_this setVariable [CRA_SVAR_LOCATION_DAMAGE_VEHICLE, if (_countVehicle > 0) then {_vehicleDamage / _countVehicle} else {0}];
};
CRA_LocationThaw = {
	private _groups = [];
	private _vehicles = [];
	private _units = [];
	private _identities = [];
	private _owner = _this call CRA_fnc_LC_Owner;
	{if (_x != -1) then {_groups pushBack (_owner call CRA_fnc_GP_Create);} else {_groups pushBack grpNull;};} forEach (_this getVariable [CRA_SVAR_LOCATION_HIBERNATE_GROUPS, []]);
	{if (_x isNotEqualTo []) then {_vehicles pushBack (_x call CRQ_VehicleThaw);} else {_vehicles pushBack objNull;};} forEach (_this getVariable [CRA_SVAR_LOCATION_HIBERNATE_VEHICLES, []]);
	{
		if (_x isEqualTo []) then {
			_units pushBack objNull;
		} else {
			_x params ["_groupIndex", "_vehicleIndex", "_data", "_identity"];
			private _unit = ([_groups#_groupIndex] + _data) call CRQ_UnitCreate;
			_units pushBack _unit;
			_identities pushBack [_unit, _identity];
			if (_vehicleIndex isNotEqualTo []) then {[CRQ_CREW_TURRET, _unit, _vehicles#(_vehicleIndex#0), _vehicleIndex#1] call CRQ_UnitVehicleAssign;};
		};
	} forEach (_this getVariable [CRA_SVAR_LOCATION_HIBERNATE_UNITS, []]);
	{_x call CRQ_CatalogIdentityApply;} forEach _identities;
	_this setVariable [CRA_SVAR_LOCATION_GROUP_PERSONNEL, _groups];
	_this setVariable [CRA_SVAR_LOCATION_UNIT_VEHICLE, _vehicles];
	_this setVariable [CRA_SVAR_LOCATION_UNIT_PERSONNEL, _units];
	_this setVariable [CRA_SVAR_LOCATION_HIBERNATE_GROUPS, []];
	_this setVariable [CRA_SVAR_LOCATION_HIBERNATE_VEHICLES, []];
	_this setVariable [CRA_SVAR_LOCATION_HIBERNATE_UNITS, []];
};
#define CRA_LC_RB_TYPES ["MAIN ROAD", "ROAD", "TRACK"]
#define CRA_LC_RB_WEIGHTS [0.4, 0.2, 0.1]
CRA_LocationRoadblockInit = {
	private _roadBlocks = [];
	
	private _rdTypeLast = count CRA_LC_RB_TYPES - 1;
	private _rdTypeIndex = createHashMap;
	{_rdTypeIndex set [_x, _forEachIndex];} forEach CRA_LC_RB_TYPES;
	
	private _scanFull = (worldSize / CRA_ROADBLOCK_DENSITY);
	private _scanHalf = _scanFull / 2;
	private _scanRadius = 1.42 * _scanFull;
	private _scanRandX = random _scanHalf;
	private _scanY = random _scanHalf;
	private _scanDensity = CRA_ROADBLOCK_DENSITY + 1;
	CRA_LOAD_NEXT(0, _scanDensity * _scanDensity);
	for "_iY" from 1 to _scanDensity do {
		private _scanX = _scanRandX;
		for "_iX" from 1 to _scanDensity do {
			CRA_LOAD_INCREMENT();
			private _scanPos = [_scanX, _scanY];
			private _roadsAll = createHashMap;
			{_roadsAll set [_x, []];} forEach CRA_LC_RB_TYPES;
			{
				private _target = _roadsAll getOrDefault [(getRoadInfo _x)#0, [objNull]];
				if (_target isNotEqualTo [objNull]) then {
					private _rdPos = _x call CRQ_Pos2D;
					if (_rdPos inArea [_scanPos, _scanHalf, _scanHalf, 0, true]) then {_target pushBack [_x, _rdPos];};
				};
			} forEach (_scanPos nearRoads _scanRadius);
			private _attempt = 0;
			while {true} do {
				[] call {
					_attempt = _attempt + 1;
					private _rdType = CRA_LC_RB_TYPES selectRandomWeighted CRA_LC_RB_WEIGHTS;
					private _rdData = [];
					while {true} do {
						private _rdList = _roadsAll getOrDefault [_rdType, []];
						if (_rdList isNotEqualTo []) exitWith {
							private _rdRandom = floor (random (count _rdList));
							_rdData = _rdList deleteAt _rdRandom;
						};
						if (!((_rdTypeIndex get _rdType) < _rdTypeLast)) exitWith {};
						_rdType = CRA_LC_RB_TYPES#((_rdTypeIndex get _rdType) + 1);
					};
					if (_rdData isEqualTo []) exitWith {_attempt = CRA_ROADBLOCK_SCAN_ATTEMPTS};
					_rdData params ["_rdObj", "_rdPos"];
					
					private _discard = false;
					{if (_rdPos distance2D (locationPosition _x) < CRA_ROADBLOCK_PROXIMITY_LOCATION) exitWith {_discard = true;};} forEach gRA_Locations;
					if (_discard) exitWith {};
					
					{if (_rdPos distance2D (_x#0) < CRA_ROADBLOCK_PROXIMITY_ROADBLOCK) exitWith {_discard = true;};} forEach _roadBlocks;
					if (_discard) exitWith {};
					
					private _path0 = [_rdObj, [], _rdPos, CRA_ROADBLOCK_LENGTH] call CRQ_RoadPath;
					{if ((getRoadInfo _x)#8) exitWith {_discard = true};} forEach _path0;
					if (_discard || {_path0 isEqualTo []}) exitWith {};
					private _path1 = [_rdObj, [_path0#1], _rdPos, CRA_ROADBLOCK_LENGTH] call CRQ_RoadPath;
					{if ((getRoadInfo _x)#8) exitWith {_discard = true};} forEach _path1;
					if (_discard || {_path1 isEqualTo []}) exitWith {};
					reverse _path0;
					_path0 deleteAt (count _path0 - 1);
					private _path = _path0 + _path1;
					
					private _segments = [];
					for "_i" from 1 to (count _path - CRA_ROADBLOCK_SEGMENTS - 1) do {
						private _segment0 = _path#(_i - 1);
						private _segment1 = _path#_i;
						private _straight = true;
						private _angles = [];
						private _dirs = [];
						for "_n" from 1 to CRA_ROADBLOCK_SEGMENTS do {
							private _distance0 = _segment0 distance2D _segment1;
							private _dir0 = _segment0 getDir _segment1;
							_segment0 = _segment1;
							_segment1 = _path#(_i + _n);
							private _distance1 = _segment0 distance2D _segment1;
							private _dir1 = _segment0 getDir _segment1;
							private _angle = [_dir0, _dir1] call CRQ_Angle;
							if (_angle > CRA_ROADBLOCK_ANGLE) exitWith {_straight = false;};
							_angles pushBack [_angle, _distance0 + _distance1];
							_dirs pushBack [_dir0, _distance0];
							_dirs pushBack [_dir1, _distance1];
						};
						if (_straight) exitWith {_segments pushback [_angles call CRQ_AngleAvg, _i, _dirs call CRQ_AngleAvg];};
					};
					if (_segments isEqualTo []) exitWith {};
					_segments sort true;
					_roadBlocks pushBack [_path#((_segments#0#1) + floor (CRA_ROADBLOCK_SEGMENTS / 2)), _segments#0#2];
					_attempt = CRA_ROADBLOCK_SCAN_ATTEMPTS;
				};
				if (!(_attempt < CRA_ROADBLOCK_SCAN_ATTEMPTS)) exitWith {};
			};
			_scanX = _scanX + _scanFull;
		};
		_scanY = _scanY + _scanFull;
	};
	private _bases = [];
	{_bases append _x;} forEach (dCRA_LOCATION_TYPES#CRA_LOCATION_TYPE_ROADBLOCK#3#1);
	gRA_LocationIndexRoadblock = count gRA_Locations;
	CRA_LOAD_NEXT(0, count _roadBlocks);
	{
		CRA_LOAD_INDEX(_forEachIndex);
		private _vec = [(_x#0) call CRQ_Pos2D, _x#1];
		private _index = gRA_LocationIndexRoadblock + _forEachIndex;
		private _name = CRA_ROADBLOCK_NAME + str _forEachIndex;
		private _label = CRA_ROADBLOCK_LABEL;
		gRA_Locations pushBack ([[_index, _vec, _name, _label, objNull], CRA_LOCATION_TYPE_ROADBLOCK, selectRandom _bases] call CRA_LocationGenerate);
	} forEach _roadBlocks;
};
CRA_LocationOutpostInit = {
	private _bases = [];
	{_bases append _x;} forEach (dCRA_LOCATION_TYPES#CRA_LOCATION_TYPE_OUTPOST#3#1);
	
	private _outpostTypes = createHashMap;
	{private _bsIndex = _x; {_outpostTypes set [toLowerANSI _x, _bsIndex];} forEach (dCRA_BASE_INDEX#_bsIndex#0#0);} forEach _bases;
	
	CRA_LOAD_NEXT(0, count dRA_WorldHouses);
	private _candidates = [];
	{
		CRA_LOAD_INDEX(_forEachIndex);
		private _bsIndex = _outpostTypes getOrDefault [toLowerANSI (typeOf _x), -1];
		if (_bsIndex != -1) then {
			private _pos = _x call CRQ_Pos3D;
			private _include = true;
			{if (_pos distance2D (locationPosition _x) < CRA_OUTPOST_PROXIMITY) exitWith {_include = false;};} forEach gRA_Locations;
			if (_include) then {_candidates pushBack [_x, [_pos, getDir _x], _bsIndex];};
		};
	} forEach dRA_WorldHouses;
	
	if (_candidates isEqualTo []) exitWith {};
	
	CRA_LOAD_NEXT(0, count _candidates);
	_candidates = _candidates call CRQ_ArrayRandomize;
	private _probability = CRA_OUTPOST_COUNT / (count _candidates);
	gRA_LocationIndexOutpost = count gRA_Locations;
	private _index = 0;
	private _outposts = [];
	{
		CRA_LOAD_INDEX(_forEachIndex);
		if (random 1 < _probability) then {
			private _pos = _x#1#0;
			private _exclude = false;
			{if (_pos distance2D (locationPosition _x) < CRA_OUTPOST_PROXIMITY) exitWith {_exclude = true;};} forEach _outposts;
			if (_exclude) exitWith {};
			private _name = CRA_OUTPOST_NAME + str _index;
			private _label = CRA_OUTPOST_LABEL;
			_outposts pushBack ([[gRA_LocationIndexOutpost + _index, _x#1, _name, _label, _x#0], CRA_LOCATION_TYPE_OUTPOST, _x#2] call CRA_LocationGenerate);
			_index = _index + 1;
		};
	} forEach _candidates;
	gRA_Locations append _outposts;
};
gRA_Temp = missionNamespace getVariable ["gRA_Temp", []];
// atoll saercher // log off 298
CRQ_fnc_MAP_Atoll = {
	params ["_pos", ["_radius", 500], ["_sgmA", 120], ["_sgmR", 100], ["_ground", 0.25], ["_count", 0]];
	private _ret = [];
	_pos set [2, 0];
	private _scAngle = 360 / _sgmA;
	private _scLimitC = 360 - _scAngle;
	if (!(_count > 0)) then {_count = floor (0.34 * _sgmA);};
	for "_r" from 0 to _radius step (_radius / _sgmR) do {
		for "_a" from 0 to _scLimitC step _scAngle do {
			private _h = getTerrainHeightASL (_pos getPos [_r, _a]);
			if (if (_h >= _ground && {_count = _count - 1; !(_count < 0)}) then {_ret pushBack [_r, _a]; if (_count > 0) then {false} else {true}} else {false}) exitWith {};
		};
	};
	_ret
};
CRA_LocationInit = {
	CRA_LOAD_NEXT(0, 0);
	
	{
		private _anchors = _x#0#0;
		gRA_BaseTypes pushBack (if (_anchors isNotEqualTo []) then {[[CRQ_VUP_HOUSE,[_anchors]]]} else {[[CRQ_VUP_FIND,["meadow"],-2]]});
	} forEach dCRA_BASE_INDEX;
	
	private _srcTypes = dCRA_LOCATION_SCAN apply {_x#0};
	
	private _worldLocations = (_srcTypes call CRQ_WorldLocations);
	// gRA_Temp = [_worldLocations, {className _this}, {locationPosition _this}, {(_this#1) distance2D (locationPosition (_this#2)) < 421}] call CRQ_fnc_OBJ_Group;
	// systemChat str (count (gRA_Temp#0));
	
	CRA_LOAD_NEXT(0, count _worldLocations);
	gRA_LocationIndexBase = count gRA_Locations;
	{
		CRA_LOAD_INDEX(_forEachIndex);
		private _scIndex = gRA_LocationIndexBase + _forEachIndex;
		private _scSource = _x;
		private _scName = className _scSource;
		private _scType = (type _scSource) call {_srcTypes findIf {_this == _x}}; // guaranteed not -1
		
		private _ovIndex = dCRA_LOCATION_OVERRIDE findIf {_scName == (_x#0)};
		
		(if (_ovIndex != -1) then {
			dCRA_LOCATION_OVERRIDE#_ovIndex#1
		} else {
			dCRA_LOCATION_SCAN#_scType#1
		}) params ["_lcType", "_lcVec", "_lcSize", "_lcName", "_lcLabel"];
		
		if (_lcName isEqualTo "") then {_lcName = _scName;};
		if (_lcLabel isEqualTo "") then {_lcLabel = text _scSource;};
		
		private _lcRadius = (if (_lcSize isEqualTo []) then {selectMax (size _scSource)} else {selectMax _lcSize}) / 2;
		private _scVec = if (_lcVec isEqualTo []) then {
			[locationPosition _scSource, 0]
		} else {
			[[locationPosition _scSource, 0], _lcRadius] call CRQ_VecUtilSetup;
			_lcVec call CRQ_VecUtil
		};
		
		private _lcBaseSource = [];
		{_lcBaseSource append (_x call CRQ_ArrayRandomize);} forEach (dCRA_LOCATION_TYPES#_lcType#3#1); // TODO location override optional bases
		{
			[_scVec, _lcRadius] call CRQ_VecUtilSetup;
			private _vec = (gRA_BaseTypes#_x) call CRQ_VecUtil;
			if ([] call CRQ_VecUtilValid) exitWith { // TODO it should now be (unintentionally) possible for no base to be created
				gRA_Locations pushBack ([[_scIndex, _vec, _lcName, _lcLabel, [] call CRQ_VecUtilObject], _lcType, _x] call CRA_LocationGenerate);
			};
		} forEach _lcBaseSource;
	} forEach _worldLocations;
	[] call CRA_LocationRoadblockInit;
	[] call CRA_LocationOutpostInit;
	[] call CRA_LocationSync;
};
CRA_LocationSync = {
	CRA_LOAD_NEXT(0, 0);
	private _sync = gRA_Locations apply {private _vec = _x getVariable [CRA_SVAR_VEC, [[0,0,0],0]]; [text _x, [_vec#0#0, _vec#0#1]]};
	missionNamespace setVariable ["pRA_Locations", _sync, true];
};
gRA_Temp2 = [];
CRA_LocationGenerate = {
	params ["_data", "_type", "_base", ["_owner", -1], ["_vars", []]];
	_data params ["_index", "_vec", "_name", "_label", ["_anchor", objNull]];
	
	if (typeOf (_anchor) == "Land_MultistoryBuilding_01_F") then {gRA_Temp2 pushBack (_index - gRA_LocationIndexBase);};
	
	(if (_type isEqualType -1) then {dCRA_LOCATION_TYPES#_type} else {_type}) params ["_lcConfig", "_lcFnc", "_lcPersonnel", "_lcBases"];
	_lcConfig params ["_lcType", "", "_lc_fnc_Name", "_lc_fnc_Label", "", "_lcValue", "_lcCapture", "_lcMarkerType", "_lc_fnc_MarkerLabel"];
	
	(if (_base isEqualType -1) then {dCRA_BASE_INDEX#_base} else {_base}) params ["_bsData", ["_bsInst", []], ["_bsProp", []], ["_bsPersonnel", []]];
	_bsData params ["", "_bsArea", "_bsPlayer", ["_bsClutter", true]]; // TODO flip clutter and player around
	
	private _lcName = [_name, _label, _index, _vec] call _lc_fnc_Name;
	private _lcLabel = [_name, _label, _index, _vec] call _lc_fnc_Label;
	
	if (_bsArea isEqualType -1) then {_bsArea = ((sqrt (0.5)) * _bsArea) call {[[_this, _this],[0,0]]};};
	private _bsSize = _bsArea call CRQ_AreaMinMax;
	private _bsRadius = sqrt ((_bsSize#1#0) ^ 2 + (_bsSize#1#1) ^ 2);
	
	private _location = [_vec, _lcName, _lcLabel, _lcType, [(_bsSize#1#0) * 2, (_bsSize#1#1) * 2]] call CRQ_LocationCreate;
	_location setVariable ["CRAS_ID", name _location];
	
	_location setVariable [CRA_SVAR_VEC, _vec];
	
	_location setVariable [CRA_SVAR_FNC_MAIN, _lcFnc#0];
	_location setVariable [CRA_SVAR_TRIGGER, [_lcFnc#1, (_lcFnc#1) apply {0}]];
	
	if (_bsPlayer isNotEqualTo []) then {
		[_vec, _bsRadius] call CRQ_VecUtilSetup;
		_location setVariable [CRA_SVAR_LOCATION_BASE_PLAYER, _bsPlayer call CRQ_VecUtil];
	};
	_location setVariable [CRA_SVAR_LOCATION_INDEX, _index];
	
	// TODO CRITICAL this very temporary workaround (?)
	[_location, _owner] call CRA_LocationOwnerInit;
	
	_location setVariable [CRA_SVAR_LOCATION_STATE, CRA_STATE_INIT];
	_location setVariable [CRA_SVAR_LOCATION_UNCAPTURED, true];
	_location setVariable [CRA_SVAR_LOCATION_DISCOVER, false];
	_location setVariable [CRA_SVAR_LOCATION_TYPE, _type];
	_location setVariable [CRA_SVAR_LOCATION_VALUE, _lcValue];
	_location setVariable [CRA_SVAR_LOCATION_CAPTUREABLE, _lcCapture];
	
	private _bsMarker = if (_lcMarkerType isNotEqualTo []) then {createMarker [_name, _vec#0]} else {""};
	_bsMarker setMarkerTextLocal ([_name, _label, _index, _vec] call _lc_fnc_MarkerLabel);
	_location setVariable [CRA_SVAR_LOCATION_MARKER_TYPES, _lcMarkerType];
	_location setVariable [CRA_SVAR_LOCATION_MARKER, _bsMarker];
	
	if (_bsClutter) then {
		private _bsOffVec = [(_vec#0) vectorAdd ([_bsArea#1, _vec#1] call CRQ_AreaOffsetRotate), _vec#1];
		_location setVariable [CRA_SVAR_LOCATION_CLUTTER, [_bsOffVec, _bsArea#0, if (_anchor isEqualTo objNull) then {[]} else {[_anchor]}, 24, gRA_SettingSystemClutterDetect] call CRQ_WorldClutter2D];
	};
	
	private _installations = [];
	{if (_x) then {_installations pushBack (_bsInst#_forEachIndex);} else {_installations pushBack ['',[]];};} forEach ((_lcBases#0) call CRQ_fnc_ByteDecode);
	_location setVariable [CRA_SVAR_LOCATION_BASE_INST, [[_vec, _bsRadius], _installations] call CRQ_PropRasterize];
	_location setVariable [CRA_SVAR_LOCATION_BASE_PROP, [[_vec, _bsRadius], _bsProp] call CRQ_PropRasterize];
	
	if (_lcPersonnel isNotEqualTo []) then {
		private _psCount = (_lcPersonnel#1) apply {0};
		private _wpTypes = dCRA_LOCATION_WAYPOINTS#_type;
		private _wpCount = dRA_WaypointCount#_type;
		private _psSource = _bsPersonnel apply {
			private _role = _x#0#0;
			private _waypoints = _x#1;
			private _count = count _waypoints;
			[_psCount, _role, 1] call CRQ_ArrayIncrement;
			[_x#0, _waypoints + ((_wpTypes#_role) select [_count, (_wpCount#_role) - _count])]
		};
		{for "_i" from _x to ((_lcPersonnel#1#_forEachIndex) - 1) do {_psSource pushBack [CRA_PERSONNEL_TYPES#_forEachIndex, _wpTypes#_forEachIndex];};} forEach _psCount;
		private _personnel = [];
		{
			private _waypoints = [[_vec, _bsRadius], _x#1] call CRQ_VecRasterize;
			if (_waypoints isNotEqualTo []) then {_personnel pushBack [_x#0, _waypoints];};
		} forEach _psSource;
		private _psStrength = [];
		{_psStrength pushBack (_x * (CRA_STRENGTH#_forEachIndex));} forEach (_lcPersonnel#0);
		_location setVariable [CRA_SVAR_LOCATION_STRENGTH, _psStrength];
		_location setVariable [CRA_SVAR_LOCATION_BASE_PERSONNEL, _personnel];
	};
	
	{_location setVariable _x;} forEach _vars;
	
	_location
};
CRA_LocationBaseRadioLoop = {
	if (([_this getVariable [CRA_SVAR_LOCATION_RADIO_START, gCS_TM_Now], gCS_TM_Now] call CRQ_fnc_TimeDelta) > (_this getVariable [CRA_SVAR_LOCATION_RADIO_LENGTH, 1])) then {_this call CRA_LocationBaseRadioNext;};
};
CRA_LocationBaseRadioNext = {
	private _radio = _this getVariable [CRA_SVAR_LOCATION_UNIT_INST_RADIO, objNull];
	if (_radio isEqualTo objNull) exitWith {};
	private _index = _this getVariable [CRA_SVAR_LOCATION_RADIO_TRACK, -1];
	_index = (_index + 1) % (count CRA_BASE_RADIO_TRACKS);
	private _track = (CRA_BASE_RADIO_TRACKS#_index);
	// binding sound to object does not cause sound to be stopped when object deleted
	playSound3D [getMissionPath (_track#0), objNull, false, getPosASL _radio, _track#2,_track#3, CRA_BASE_RADIO_RANGE];
	_this setVariable [CRA_SVAR_LOCATION_RADIO_TRACK, _index];
	_this setVariable [CRA_SVAR_LOCATION_RADIO_START, gCS_TM_Now];
	_this setVariable [CRA_SVAR_LOCATION_RADIO_LENGTH, (_track#1) + CRA_BASE_RADIO_GRACE];
};
CRA_LocationBaseLights = {
	params ["_location", "_state"];
	private _fire = _location getVariable [CRA_SVAR_LOCATION_UNIT_INST_FIRE, objNull];
	if (_fire isNotEqualTo objNull) then {_fire inflame _state;};
};
CRA_LocationBaseSpawn = {
	{_x hideObjectGlobal true;} forEach (_this getVariable [CRA_SVAR_LOCATION_CLUTTER, []]);
	{
		_this setVariable [_x#1, [_this getVariable [_x#0, []], true, true] call CRQ_PropSpawn];
	} forEach [[CRA_SVAR_LOCATION_BASE_PROP,CRA_SVAR_LOCATION_UNIT_PROP]];
	{
		_this setVariable [_x#1, [_this getVariable [_x#0, []], false, false] call CRQ_PropSpawn];
	} forEach [[CRA_SVAR_LOCATION_BASE_INST,CRA_SVAR_LOCATION_UNIT_INST]];
	private _installations = _this getVariable [CRA_SVAR_LOCATION_UNIT_INST, CRA_BASE_INST_EMPTY];
	_this setVariable [CRA_SVAR_LOCATION_UNIT_INST_MAP, _installations#0];
	_this setVariable [CRA_SVAR_LOCATION_UNIT_INST_BOX, _installations#1];
	_this setVariable [CRA_SVAR_LOCATION_UNIT_INST_BOX_AUX, _installations#2];
	_this setVariable [CRA_SVAR_LOCATION_UNIT_INST_RADIO, _installations#3];
	_this setVariable [CRA_SVAR_LOCATION_UNIT_INST_FIRE, _installations#4];
	_this setVariable [CRA_SVAR_LOCATION_UNIT_INST_GATE, _installations#5];
	_this setVariable [CRA_SVAR_LOCATION_UNIT_INST_FLAG, _installations#6];
	(_installations#1) lockInventory false;
	(_installations#1) setMaxLoad CRA_BASE_INVENTORY_SIZE;
};
CRA_LocationBaseDespawn = {
	_this setVariable [CRA_SVAR_LOCATION_UNIT_INST_MAP, objNull];
	_this setVariable [CRA_SVAR_LOCATION_UNIT_INST_BOX, objNull];
	_this setVariable [CRA_SVAR_LOCATION_UNIT_INST_BOX_AUX, objNull];
	_this setVariable [CRA_SVAR_LOCATION_UNIT_INST_RADIO, objNull];
	_this setVariable [CRA_SVAR_LOCATION_UNIT_INST_FIRE, objNull];
	_this setVariable [CRA_SVAR_LOCATION_UNIT_INST_GATE, objNull];
	_this setVariable [CRA_SVAR_LOCATION_UNIT_INST_FLAG, objNull];
	{(_this getVariable [_x, []]) call CRQ_PropDespawn; _this setVariable [_x, []];} forEach [CRA_SVAR_LOCATION_UNIT_INST,CRA_SVAR_LOCATION_UNIT_PROP];
	{_x hideObjectGlobal false;} forEach (_this getVariable [CRA_SVAR_LOCATION_CLUTTER, []]);
};
CRA_LocationActionCreate = {
	private _map = _this getVariable [CRA_SVAR_LOCATION_UNIT_INST_MAP, objNull];
	private _box = _this getVariable [CRA_SVAR_LOCATION_UNIT_INST_BOX, objNull];
	private _index = _this getVariable [CRA_SVAR_LOCATION_INDEX, -1];
	if (_index == -1) exitWith {};
	[_map, "Teleport", [CRA_ACTION_ID_PLAYER_TELEPORT]] call CRA_ActionRelayAdd;
	[_map, "Paradrop", [CRA_ACTION_ID_PLAYER_PARADROP]] call CRA_ActionRelayAdd;
	//[_map, "Train Militia", [CRA_ACTION_ID_MILITIA_TRAIN]] call CRA_ActionRelayAdd;
	[_map, "Gather Intel", [CRA_ACTION_ID_INTEL_GATHER, _index]] call CRA_ActionRelayAdd;
	[_box, "Unload, Repack, Sort", [CRA_ACTION_ID_INVENTORY_SORT, _index]] call CRA_ActionRelayAdd;
	[_box, format ["Gather Items (%1m)", CRA_BASE_INVENTORY_GATHER_RANGE], [CRA_ACTION_ID_INVENTORY_GATHER, _index, CRA_BASE_INVENTORY_GATHER_RANGE]] call CRA_ActionRelayAdd;
};
CRA_LocationActionRemove = {
	{(_this getVariable [_x, objNull]) call {if (isNull _this) exitWith {}; _this call CRQ_fnc_AC_RemoveAll};} forEach [CRA_SVAR_LOCATION_UNIT_INST_MAP, CRA_SVAR_LOCATION_UNIT_INST_BOX];
};
CRA_LocationIntelGather = {
	private _range = CRA_BASE_INTEL_RANGE * (_this getVariable [CRA_SVAR_LOCATION_VALUE, 0]);
	if (_range <= 0) exitWith {[]};
	private _vec = _this getVariable [CRA_SVAR_VEC, []];
	if (_vec isEqualTo []) exitWith {[]};
	private _pos = _vec#0;
	private _intel = createHashMap;
	{
		private _lcVec = _x getVariable [CRA_SVAR_VEC, []];
		if (_lcVec isNotEqualTo [] && {_pos distance2D (_lcVec#0) <= _range && {_x isNotEqualTo _this}}) then {
			private _type = _x getVariable [CRA_SVAR_LOCATION_TYPE, -1];
			if (_type != -1) then {
				private _label = dCRA_LOCATION_TYPES#_type#0#1;
				private _count = _intel getOrDefault [_label, 0];
				_count = _count + 1;
				_intel set [_label, _count, false];
			};
			[_x, true] call CRA_LocationDiscover;
		};
	} forEach gRA_Locations;
	[_range, _intel]
};
CRA_LocationFlagUpdate = {
	(if (_this isEqualType locationNull) then {[_this]} else {_this}) params [["_location", locationNull]];//, ["_texture", ""], ["_level", 1]];
	private _flagObj = _location getVariable [CRA_SVAR_LOCATION_UNIT_INST_FLAG, objNull];
	if (_flagObj isEqualTo objNull) exitWith {};
	([_location, -1] call CRA_fnc_LC_Owner) params [["_favO", CRQ_SD_UNKNOWN], ["_favV", 0]];
	if (_favO isEqualTo CRQ_SD_UNKNOWN) exitWith {};
	
	_flagObj setFlagTexture (CQM_TX_SD_FLAGS#_favO);
	
	private _flagAnim = ("true" configClasses (configFile >> "CfgVehicles" >> (typeOf _flagObj) >> "AnimationSources")) apply {configName _x};
	if (_flagAnim isNotEqualTo []) exitWith {_flagObj animateSource [_flagAnim#0, _favV, true];};
	[_flagObj, _favV] remoteExec ["setFlagAnimationPhase", gCS_MP_All];
};
CRA_LocationInventoryInit = {
	private _box = _this getVariable [CRA_SVAR_LOCATION_UNIT_INST_BOX, objNull];
	if (_box isEqualTo objNull) exitWith {};
	_this setVariable [CRA_SVAR_LOCATION_INVENTORY, [[[CRA_ITEM_WP_ALL], (-0.03125 + random 0.125) call CRA_ItemQuality] call CRA_ItemRandom, false, false] call CRA_ItemWeaponRasterize];
};
CRA_LocationInventorySave = {
	private _box = _this getVariable [CRA_SVAR_LOCATION_UNIT_INST_BOX, objNull];
	if (_box isEqualTo objNull) exitWith {};
	_this setVariable [CRA_SVAR_LOCATION_INVENTORY, _box call CRQ_InventoryBox];
};
CRA_LocationInventoryLoad = {
	private _box = _this getVariable [CRA_SVAR_LOCATION_UNIT_INST_BOX, objNull];
	if (_box isEqualTo objNull) exitWith {};
	_box call CRQ_InventoryBoxClear;
	[_box, _this getVariable [CRA_SVAR_LOCATION_INVENTORY, [[[],[],[]],[]]]] call CRQ_InventoryBoxAppend;
};
CRA_LocationInventorySort = {
	private _box = _this getVariable [CRA_SVAR_LOCATION_UNIT_INST_BOX, objNull];
	if (_box isEqualTo objNull) exitWith {};
	_box call CRQ_InventoryBoxOrganize;
};
CRA_LocationInventoryGather = {
	params ["_location", "_range"];
	private _vec = _location getVariable [CRA_SVAR_VEC, []];
	private _box = _location getVariable [CRA_SVAR_LOCATION_UNIT_INST_BOX, objNull];
	if (_box isEqualTo objNull || {_vec isEqualTo []}) exitWith {[0,0,0,0]};
	private _inventory = [[[],[],[]],[]];
	private _corpses = [];
	private _boxes = [];
	{
		(typeOf _x) call {
			if (_this isEqualTo "Man") exitWith {_corpses pushBack _x;};
			if (_this isEqualTo "WeaponHolderSimulated") exitWith {_boxes pushBack _x;};
			if (_this isEqualTo "GroundWeaponHolder") exitWith {_boxes pushBack _x;};
			// must be vehicle then
			private _include = true;
			private _crew = crew _x;
			{if (alive _x) exitWith {_include = false;};} forEach _crew; // TODO this will unintentionally exclude if any player is in vehicle too
			if (_include) then {_corpses append _crew;};
		};
	} forEach (nearestObjects [(_vec#0), dRA_InventoryGatherSources, _range]);
	{
		[_inventory, [_x, true, false] call CRQ_InventoryUnit] call CRQ_InventoryAppend;
		[_x, _x call CRQ_LoadoutBlank] call CRQ_LoadoutApply;
		_x call CRQ_fnc_CorpseExpedite;
	} forEach _corpses;
	{
		[_inventory, _x call CRQ_InventoryBox] call CRQ_InventoryAppend;
		deleteVehicle _x;
	} forEach _boxes;
	[_box, _inventory] call CRQ_InventoryBoxAppend;
	[count (_inventory#0#0), count (_inventory#0#1), count (_inventory#0#2), count (_inventory#1)]
};
CRA_LocationMarkerState = {
	private _marker = _this getVariable [CRA_SVAR_LOCATION_MARKER, ""];
	if (_marker isEqualTo "") exitWith {};
	private _types = _this getVariable [CRA_SVAR_LOCATION_MARKER_TYPES, []];
	if (_types isEqualTo []) exitWith {};
	private _state = _this getVariable [CRA_SVAR_LOCATION_STATE, -1];
	if (_state == -1) exitWith {};
	private _owner = _this call CRA_fnc_LC_Owner;
	_marker setMarkerAlphaLocal (CRA_MARKER_ALPHA#_state);
	if (_owner != -1) then {_marker setMarkerType (_types#_owner);} else {_marker setMarkerType CRA_MARKER_UNKNOWN;};
};
CRA_LocationPersonnelSpawn = {
	private _owner = _this call CRA_fnc_LC_Owner;
	private _factions = switch (_owner) do { // TODO does this -1 fix really fix it?
		case CRQ_SD_OPFOR: {CRA_FACTION_OPFOR#(floor (gRA_ProgressMission * (count CRA_FACTION_OPFOR - 1)))};
		case CRQ_SD_IDFOR: {CRA_FACTION_IDFOR#(floor (gRA_ProgressMission * (count CRA_FACTION_IDFOR - 1)))};
		default {[]};
	};
	private _faction = (_factions#1) selectRandomWeighted (_factions#0);
	private _strength = _this getVariable [CRA_SVAR_LOCATION_STRENGTH, [1,1,1]];
	private _groups = [];
	private _units = [];
	private _vehicles = [];
	{
		(_x#0) params ["_role", "_count", "_args"];
		private _group = grpNull;
		switch (_role) do {
			case CRA_ROLE_GUARD: {
				if (_count < 0) then {_count = -(_count) * (_strength#0);};
				_group = _owner call CRA_fnc_GP_Create;
				_units append ([_group, selectRandom (_x#1), [_faction, _count, _args] call CRA_UnitList] call CRA_GroupPopulate);
			};
			case CRA_ROLE_SPOT: {
				if (_count < 0)  then {_count = -(_count) * (_strength#1);};
				_group = _owner call CRA_fnc_GP_Create;
				_units append ([_group, selectRandom (_x#1), [_faction, _count, _args, [0,360]] call CRA_UnitList] call CRA_GroupPopulate);
			};
			case CRA_ROLE_PATROL: {
				if (_count < 0)  then {_count = -(_count) * (_strength#2);};
				_group = _owner call CRA_fnc_GP_Create;
				_units append ([_group, selectRandom (_x#1), [_faction, _count, _args] call CRA_UnitList] call CRA_GroupPopulate);
			};
			case CRA_ROLE_VEHICLE: {
				private _vehicleTypes = _args apply {if (_x#0 != CRQ_SD_UNKNOWN) then {_x} else {[_owner, _x#1, _x#2]}};
				private _vehicleIndex = [_vehicleTypes, 0 call CRA_ItemQuality] call CRA_AssetRandom;
				if (_vehicleIndex != -1) then {
					_group = _owner call CRA_fnc_GP_Create;
					_vehicles pushBack ([_vehicleIndex, [(selectRandom (_x#1))#0, random 360], [_group, [-1, -1, -1, random -1]]] call CRA_AssetCreate);
					_units append (units _group);
				};
			};
			case CRA_ROLE_STATIC: {
				private _staticIndex = [[[_owner,CRA_ASSET_STATIC,_args#0]], 0 call CRA_ItemQuality] call CRA_AssetRandom;
				if (_staticIndex != -1) then {
					_group = _owner call CRA_fnc_GP_Create;
					_vehicles pushBack ([_staticIndex, selectRandom (_x#1), [_group, [-1, -1, -1, 0]]] call CRA_AssetCreate);
					_units append (units _group);
				};
			};
			default {};
		};
		_groups pushBack _group;
	} forEach (_this getVariable [CRA_SVAR_LOCATION_BASE_PERSONNEL, []]);
	_this setVariable [CRA_SVAR_LOCATION_GROUP_PERSONNEL, _groups];
	_this setVariable [CRA_SVAR_LOCATION_UNIT_PERSONNEL, _units];
	_this setVariable [CRA_SVAR_LOCATION_UNIT_VEHICLE, _vehicles];
	_this setVariable [CRA_SVAR_LOCATION_COUNT_PERSONNEL, count _units];
	_this setVariable [CRA_SVAR_LOCATION_COUNT_VEHICLE, count _vehicles];
};
CRA_LocationPersonnelClear = {
	_this setVariable [CRA_SVAR_LOCATION_HIBERNATE_GROUPS, []];
	_this setVariable [CRA_SVAR_LOCATION_HIBERNATE_UNITS, []];
	_this setVariable [CRA_SVAR_LOCATION_HIBERNATE_VEHICLES, []];
	{if (_x isNotEqualTo objNull) then {[_x, true] call CRA_AssetRegister;};} forEach (_this getVariable [CRA_SVAR_LOCATION_UNIT_VEHICLE, []]);
	_this setVariable [CRA_SVAR_LOCATION_UNIT_VEHICLE, []];
	_this setVariable [CRA_SVAR_LOCATION_COUNT_PERSONNEL, 0];
	_this setVariable [CRA_SVAR_LOCATION_COUNT_VEHICLE, 0];
};
CRA_LocationPersonnelDespawn = {
	{if (!isNull _x) then {_x call CRQ_VehicleDelete;};} forEach (_this getVariable [CRA_SVAR_LOCATION_UNIT_VEHICLE, []]);
	{if (!isNull _x) then {_x call CRQ_UnitDelete;};} forEach (_this getVariable [CRA_SVAR_LOCATION_UNIT_PERSONNEL, []]);
	{if (!isNull _x) then {deleteGroup _x;};} forEach (_this getVariable [CRA_SVAR_LOCATION_GROUP_PERSONNEL, []]);
	_this setVariable [CRA_SVAR_LOCATION_UNIT_VEHICLE, []];
	_this setVariable [CRA_SVAR_LOCATION_UNIT_PERSONNEL, []];
	_this setVariable [CRA_SVAR_LOCATION_GROUP_PERSONNEL, []];
};
CRA_LocationPersonnelOrders = {
	private _data = _this getVariable [CRA_SVAR_LOCATION_BASE_PERSONNEL, []];
	{
		if (_x isNotEqualTo grpNull) then {
			(_data#_forEachIndex) params ["_config", "_waypoints"];
			[_x, CRQ_AI_F_RAND, CRQ_AI_M_SAFE, CRQ_AI_S_LIMITED] call CRQ_fnc_AI_STS;
			[_x, _waypoints] call ([CRQ_WaypointInfantryGarrison,CRQ_WaypointInfantrySpot,CRQ_WaypointInfantryPatrol,CRQ_WaypointVehiclePatrol,{}]#(_config#0));
		};
	} forEach (_this getVariable [CRA_SVAR_LOCATION_GROUP_PERSONNEL, []]);
};
CRA_LocationPersonnelLoop = {
	private _units = _this getVariable [CRA_SVAR_LOCATION_UNIT_PERSONNEL, []];
	private _vehicles = _this getVariable [CRA_SVAR_LOCATION_UNIT_VEHICLE, []];
	private _groups = _this getVariable [CRA_SVAR_LOCATION_GROUP_PERSONNEL, []];
	{if (!isNull _x && {!alive _x}) then {_units set [_forEachIndex, objNull];};} forEach _units;
	{if (!isNull _x && {!alive _x}) then {_vehicles set [_forEachIndex, objNull];};} forEach _vehicles;
	{if (!isNull _x && {units _x isEqualTo []}) then {deleteGroup _x; _groups set [_forEachIndex, grpNull];};} forEach _groups; // TODO: GC-collect groups too, I guess?
	_this setVariable [CRA_SVAR_LOCATION_UNIT_PERSONNEL, _units];
	_this setVariable [CRA_SVAR_LOCATION_UNIT_VEHICLE, _vehicles];
	_this setVariable [CRA_SVAR_LOCATION_GROUP_PERSONNEL, _groups];
};
CRA_UnitSkill = {
	(1 min (gRA_ProgressEnemySkillBase * ([] call gRA_fnc_VarianceEnemySkill)))
};
CRA_UnitList = {
	params ["_faction", "_count", "_args"];
	private _sqSource = dCRA_SQUADS#_faction;
	
	private _sqIndex = _args#0;
	(_sqSource#_sqIndex) params [["_sqConfig", [0, [[1,1e10],-1]]]];
	_sqConfig params ["_sqFallback", "_sqCount"];
	
	while {_sqFallback >= 0} do {
		_sqIndex = _sqFallback;
		_sqFallback = _sqSource#_sqIndex#0#0;
	};
	
	_sqCount params ["_cntClamp", "_cntMod"];
	private _cntBase = if (_cntMod < 0) then {-_cntMod * _count} else {_cntMod};
	private _cntProg = round (_cntBase * gRA_ProgressEnemyCountBase * ([] call gRA_fnc_ProgressEnemyCountPlayer) * ([] call gRA_fnc_VarianceEnemyCount));
	private _cntFinal =  (_cntClamp#0) max ((_cntClamp#1) min _cntProg);
	
	(_sqSource#_sqIndex#1) params ["_ldWeight", "_ldType", "_sqWeight", "_sqType"];
	private _units = [(_ldType selectRandomWeighted _ldWeight) call CRA_UnitGenerate];
	for "_i" from 2 to _cntFinal do {_units pushBack (((_sqType selectRandomWeighted _sqWeight) call {(_this#1) selectRandomWeighted (_this#0)}) call CRA_UnitGenerate);};
	
	_units
};
CRA_GroupPopulate = {
	params ["_group", "_vec", "_types", ["_scatter", [3, 360]]];
	private _scPos = _scatter#0;
	private _scDir = _scatter#1;
	private _pos = (_vec#0) vectorAdd [_scPos / -2, _scPos / -2, 0];
	private _dir = (_vec#1) - _scDir / -2;
	private _units = _types apply {[_group, _x#0, [_pos vectorAdd [random _scPos, random _scPos, 0], _dir + random _scDir], _x#1, [] call CRA_UnitSkill] call CRQ_UnitCreate};
	private _relation = _group call CRA_SideRelation;
	{[_x, _relation call CRQ_CatalogIdentityGenerate] call CRQ_CatalogIdentityApply;} forEach _units;
	_units
};

#define CRA_GP_TICKET_MAX 65536 // high enough to practically never collide/low enough no 1e10 collision
gRA_GP_List = missionNamespace getVariable ["gRA_GP_List", createHashMap];
gRA_GP_Ticket = missionNamespace getVariable ["gRA_GP_Ticket", -1];
CRA_fnc_GP_Ticket = {
	gRA_GP_Ticket = (gRA_GP_Ticket + 1) % CRA_GP_TICKET_MAX;
	(format ["CRA_GP_%1", gRA_GP_Ticket])
};
CRA_fnc_GP_Create = {
	private _group = _this call CRQ_GroupCreate;
	_group setVariable ["CRAS_ID", call CRA_fnc_GP_Ticket];
	_group
};

CRA_fnc_GP_Register = { // TODO implement me
	gRA_GP_List set [_group getVariable "CRAS_ID", if (_this isEqualType []) then {_this} else {[
		_this,
		_this call CRQ_Side,
		[]
	]}];
	_this
};
CRA_fnc_GP_Loop = {
	private _remove = [];
	{
		_y params ["_group", "_side", "_task"];
		if (_group isEqualType grpNull) then {
			private _fnc = _group getVariable [CRA_SVAR_FNC_MAIN, [{false},{}]];
			(_group call (_fnc#0)) params ["_active", ["_units", []], ["_corpses", []]];
			if (_active isEqualTo false) then {
				_remove pushBack _x;
				_group call (_fnc#1);
				if (_units isEqualTo []) then {_units = units _group;};
				{_x call CRQ_UnitDelete;} forEach _units;
				deleteGroup _group;
			};
		} else { // TODO hibernated
		};
	} forEach gRA_GP_List;
	{gRA_GP_List deleteAt _x;} forEach _remove;
};


CRA_CivilianLoop = {
	[] call CRA_fnc_GP_Loop;
	if (!(gRA_PlayerCount > 0)) exitWith {};
	
	{
		private _type = _x;
		if (([gRA_CivilianAssetTime#_type, gCS_TM_Now] call CRQ_fnc_TimeDelta) >= CRA_CIVILIAN_SPAWN_TIMER) then {
			if ((gRA_CivilianAssetCount#_type) < (gRA_CivilianAssetLimit#_type) && {random 1 < (gRA_CivilianAssetProb#_type)}) then {
				if ((gRA_CivilianAssetSpawn#_type) isNotEqualTo scriptNull) exitWith {}; // TODO error-handling
				gRA_CivilianAssetSpawn set [_type, [selectRandom gRA_PlayerPos, _type] spawn CRA_CivilianAssetSpawn];
			};
			gRA_CivilianAssetTime set [_type, gCS_TM_Now];
		};
	} forEach [CRA_ASSET_WHEELED,CRA_ASSET_WINGED,CRA_ASSET_ROTOR];
	
};
CRA_CivilianAssetSpawn = {
	params ["_pos", "_type"];
	private _group = [] call {
		if (_type == CRA_ASSET_WHEELED) exitWith {[_pos, _type] call CRA_CivilianCarSpawn};
		if (_type == CRA_ASSET_WINGED || _type == CRA_ASSET_ROTOR) exitWith {[_pos, _type] call CRA_CivilianAirSpawn};
		grpNull;
	};
	if (_group isEqualTo grpNull) exitWith {};
	[gRA_CivilianAssetCount, _type] call CRQ_ArrayIncrement;
	_group call CRA_fnc_GP_Register;
};
CRA_CivilianAssetDespawn = {
	[gRA_CivilianAssetCount, _this, -1] call CRQ_ArrayIncrement;
};
CRA_CivilianCarSpawn = {
	params ["_pos"];
	private _path = [_pos, gRA_ProgressActivation * CRA_PATHGENERATOR_RADIUS, gRA_ProgressActivation] call CRA_CivilianCarPath;
	if (count _path < 1 || {((getRoadInfo (_path#0))#8) || {((getRoadInfo (_path#-1))#8)}}) exitWith {grpNull};
	([[(_path#0) call CRQ_Pos2D, (_path#0) getDir (_path#1)], [[CRQ_SD_CIVFOR,CRA_ASSET_WHEELED,CRA_VEHICLE_UNARMED]], _path call CRQ_RoadWaypoints] call CRA_CivilianAssetCreate) params [["_group", grpNull], ["_asset", objNull]];
	if (_group isEqualTo grpNull) exitWith {grpNull};
	_group setVariable [CRA_SVAR_GROUP_PATH, _path];
	_group setVariable [CRA_SVAR_FNC_MAIN, [{[_this, CRA_ASSET_WHEELED] call CRA_CivilianAssetActive}, {CRA_ASSET_WHEELED call CRA_CivilianAssetDespawn}]];
	_group
};
CRA_CivilianAirSpawn = {
	params ["_pos", "_type"];
	private _flAlt = CRQ_PT_FL_ALTITUDE + random (if (_type == CRA_ASSET_ROTOR) then {CRA_CIVILIAN_ALTITUDE_ROTOR} else {CRA_CIVILIAN_ALTITUDE_WING});
	private _flStart = [_pos, gRA_ProgressActivation * 2, _flAlt] call CRQ_FlightStart;
	private _flPath = [_flStart, gRA_ProgressActivation] call CRQ_FlightPath;
	([_flStart, [[CRQ_SD_CIVFOR,_type,CRA_VEHICLE_UNARMED]], _flPath] call CRA_CivilianAssetCreate) params [["_group", grpNull], ["_asset", objNull]];
	if (_group isEqualTo grpNull) exitWith {grpNull};
	_asset flyInHeight _flAlt;
	_asset setVariable [CRA_SVAR_ACTIVITY, 0.5];
	_asset setVariable [CRA_SVAR_ACTIVITY_BASE, -2];
	_group setVariable [CRA_SVAR_GROUP_PATH, _flPath];
	if (_type == CRA_ASSET_ROTOR) then { // I suppose I need "compile" if I want to refactor this seemingly unnecessary construct
		_group setVariable [CRA_SVAR_FNC_MAIN, [{[_this, CRA_ASSET_ROTOR] call CRA_CivilianAssetActive}, {CRA_ASSET_ROTOR call CRA_CivilianAssetDespawn}]];
	} else {
		_group setVariable [CRA_SVAR_FNC_MAIN, [{[_this, CRA_ASSET_WINGED] call CRA_CivilianAssetActive}, {CRA_ASSET_WINGED call CRA_CivilianAssetDespawn}]];
	};
	_group
};
CRA_CivilianAssetCreate = {
	params ["_vec", "_type", "_waypoints", ["_crew", [-1, -1, -1, random -1]]];
	private _asIndex = [_type] call CRA_AssetRandom;
	if (_asIndex == -1 || {([_vec#0, CRA_CIVILIAN_SPAWN_CLEARANCE, false] call CRQ_VehiclesFind) isNotEqualTo []}) exitWith {[]};
	private _group = CRQ_SD_CIVFOR call CRA_fnc_GP_Create;
	private _asset = [_asIndex, _vec, [_group, _crew]] call CRA_AssetCreate;
	[_group, CRQ_AI_F_RAND, CRQ_AI_M_SAFE, CRQ_AI_S_LIMITED] call CRQ_fnc_AI_STS;
	[_group, _waypoints] call CRQ_WaypointVehicleTravel;
	
	//[[_group, 0, [false, -1, -1]], [_asset, 0]] call CRQ_LinkCreate;
	[_group getVariable "CRAS_ID", [[_asset, 0], [_group]], [[false, -1, -1]]] call CRQ_fnc_LNK_Create;
	
	[_asset, true, false, false, _vec] call CRA_AssetRegister;
	// TODO why on asset, not group? attempting to disable day 295...
	//_asset disableAi "AUTOTARGET";
	//_asset disableAi "TARGET";
	// TODO these were previously commented out
	//_asset setCaptive true;
	//_group allowFleeing 0;
	[_group, _asset]
};

CRQ_fnc_GP_WaypointsData = {
	private _waypoints = waypoints _this;
	[_waypoints, currentWaypoint _this, count _waypoints - 1]
};
#define CRA_GP_TSK_AI_TIMEOUT CRA_SCRIPT_TIMEOUT
#define CRA_GP_TSK_UNKNOWN -1
#define CRA_GP_TSK_WH_CRUISE_FIND 1
#define CRA_GP_TSK_WH_CRUISE_TRVL 2
#define CRA_GP_TSK_FW_CRUISE_FIND 21
#define CRA_GP_TSK_FW_CRUISE_TRVL 22
CRA_fnc_GP_TSK_AI_Terminate = {
	(if (_this isEqualType grpNull) then {[_this]} else {_this}) params [["_group", grpNull], ["_timeOut", CRA_GP_TSK_AI_TIMEOUT]];
	(_group getVariable [CRA_SVAR_SCRIPT_HANDLE, []]) params [["_tskType", CRA_GP_TSK_UNKNOWN], ["_tskTime", gCS_TM_Now - _timeOut], ["_tskAI", scriptNull]];
	if (_tskAI isEqualTo scriptNull || {([_tskTime, gCS_TM_Now] call CRQ_fnc_TimeDelta) < CRA_SCRIPT_TIMEOUT}) exitWith {false};
	terminate _tskAI;
	true
};
CRA_fnc_GP_TSK_AI_Spawn = {
	params [["_tskGroup", grpNull], ["_tskType", CRA_GP_TSK_UNKNOWN], ["_tskFunc", {}]];
	if (_tskGroup isEqualTo grpNull) exitWith {};
	_tskGroup setVariable [CRA_SVAR_SCRIPT_HANDLE, [_tskType, gCS_TM_Now, _tskGroup spawn _tskFunc]];
};
CRA_fnc_GP_TSK_WH_CRUISE_FIND = {
	private _path1 = [];
	private _path0 = _this getVariable [CRA_SVAR_GROUP_PATH, []];
	private _rd0Last0 = count _path0 - 1;
	private _rd0Last1 = _rd0Last0 - 1;
	if (!(_rd0Last1 < 0)) then {
		private _rdLast = _path0#_rd0Last0;
		{_path1 = [_rdLast, [_path0#_rd0Last1], _rdLast call CRQ_Pos2D, _x] call CRQ_RoadPath; if (_path1 isNotEqualTo []) exitWith {};} forEach CRA_CIVILIAN_EXTENSIONS;
		if (_path1 isEqualTo []) exitWith {};
		[_this, _path1 call CRQ_RoadWaypoints] call CRQ_WaypointVehicleTravel;
	};
	_this setVariable [CRA_SVAR_GROUP_PATH, _path1];
};
CRA_fnc_GP_TSK_FW_CRUISE_FIND = {
	private _path0 = _this getVariable [CRA_SVAR_GROUP_PATH, []];
	if (_path0 isEqualTo []) then { // TODO shouldn't happen, find out why?
		_path0 = [_this call CRQ_VecGroup3D];
		_this setVariable [CRA_SVAR_GROUP_PATH, _path0]
	};
	private _path1 = [_path0#-1, gRA_ProgressActivation] call CRQ_FlightPath;
	_path0 append _path1;
	[_this, _path1] call CRQ_WaypointVehicleTravel;
};
CRA_CivilianAssetActive = {
	params ["_group", "_type"];
	private _active = true;
	
	private _units = [];
	{if (alive _x) then {_units pushBack _x;};} forEach (units _group);
	
	private _disembark = false;
	
	//private _link = [_group, 0] call CRQ_LinkDataRead;
	//private _asset = if (_link isNotEqualTo []) then {_link#0} else {objNull};
	private _vehicle = ((_group getVariable "CRAS_ID") call CRQ_fnc_LNK_Get) call {if (_this isEqualType createHashMap) then {objNull} else {_this#0#0};};
	//if (_vehicle isNotEqualTo _asset) then {systemChat "not yet";};
	
	private _activity = 0;
	if (_vehicle isEqualType objNull) then {
		if (_vehicle isEqualTo objNull) exitWith {_active = false;};
		if (_units isEqualTo []) exitWith {_disembark = true;};
		_activity = _vehicle getVariable [CRA_SVAR_ACTIVITY, 0];
		(_group call CRQ_fnc_GP_WaypointsData) params ["_waypoints", "_wpNow", "_wpLast"];
		if (_type == CRA_ASSET_WHEELED || {_type == CRA_ASSET_TRACKED}) exitWith {
			if (_wpNow > _wpLast) exitWith {if (_activity < 1) then {_active = false;} else {_disembark = true;};};
			private _alighted = false;
			{if ((objectParent _x) isNotEqualTo _vehicle) exitWith {_alighted = true;};} forEach _units;
			if (_alighted) exitWith {_disembark = true;};
			private _hijacked = false;
			{if ((alive _x) && {_units find _x == -1}) exitWith {_hijacked = true;};} forEach (crew _vehicle);
			if (_hijacked) exitWith {_disembark = true;};
			if (_vehicle distance2D (waypointPosition (_waypoints#_wpLast)) >= CRA_CIVILIAN_EXTEND) exitWith {};
			private _path = _group getVariable [CRA_SVAR_GROUP_PATH, []];
			if (_path isEqualTo []) exitWith {_disembark = true;};
			_active = !(_group call CRA_fnc_GP_TSK_AI_Terminate); // returns true if forced terminated from timeout
			if ([[(_path#-1) call CRQ_Pos2D, 0], gRA_ProgressActivation, 0, CRA_ACTIVITY_MIN, CRA_ACTIVITY_MAX] call CRA_PlayerActivity > 0) exitWith {
				[_group, CRA_GP_TSK_WH_CRUISE_FIND, CRA_fnc_GP_TSK_WH_CRUISE_FIND] call CRA_fnc_GP_TSK_AI_Spawn;
			};
		};
		if (_type == CRA_ASSET_WINGED || {_type == CRA_ASSET_ROTOR}) exitWith {
			private _actBase = (_vehicle getVariable [CRA_SVAR_ACTIVITY_BASE, gRA_ProgressActivation]) call {if (_this < 0) then {-_this * gRA_ProgressActivation} else {_this}};
			
			(_group call CRQ_fnc_GP_WaypointsData) params ["_waypoints", "_wpNow", "_wpLast"];
			
			_active = !(_group call CRA_fnc_GP_TSK_AI_Terminate); // returns true if forced terminated from timeout
			if (_wpNow < _wpLast && {[[waypointPosition [_group, _wpLast], 0], _actBase, 0, CRA_ACTIVITY_MIN, CRA_ACTIVITY_MAX] call CRA_PlayerActivity <= 0}) exitWith {};
			[_group, CRA_GP_TSK_FW_CRUISE_FIND, CRA_fnc_GP_TSK_FW_CRUISE_FIND] call CRA_fnc_GP_TSK_AI_Spawn;
		};
	} else {
		// TODO hibernated vehicle
	};
	
	if (_disembark) then {
		_group leaveVehicle _vehicle;
		//[_group, 0, grpNull] call CRQ_LinkFree;
		(_group getVariable "CRAS_ID") call CRQ_fnc_LNK_Free; // TODO keep link alive for fleeing civs?
		_vehicle call CRA_AssetAbandonEnable;
		_vehicle call CRA_AssetHibernateEnable;
		_vehicle = objNull;
	};
	
	if (_active && {_activity > 0}) exitWith {[true, _units]};
	if (_vehicle isEqualType objNull && {_vehicle isNotEqualTo objNull}) then {_vehicle call CRQ_VehicleDelete;};
	[false, _units]
};
CRA_CivilianCarPath = {
	params ["_pos", "_radiusSearch", "_radiusEdge"];
	private _roads = [];
	{if (_x call CRQ_fnc_RD_IsRoad) then {_roads pushBack _x;};} forEach (_pos nearRoads _radiusSearch);
	private _path = [];
	{
		private _path0 = [_x, [], _pos, _radiusEdge] call CRQ_RoadPath;
		private _length = count _path0;
		private _path1 = if (_length > 0) then {[_x, if (_length > 1) then {[_path0#1]} else {[]}, _pos, _radiusEdge] call CRQ_RoadPath} else {[]};
		if (_path1 isNotEqualTo []) exitWith {
			reverse _path0;
			_path0 deleteAt (_length - 1);
			_path = _path0 + _path1;
		};
	} forEach (_roads call CRQ_ArrayRandomize);
	_path
};
/*
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
	} forEach (_roads call CRQ_ArrayRandomize);
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
*/
