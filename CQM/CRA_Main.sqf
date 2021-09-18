
gRA_SettingPlayerStart = [false,true] select (["CRA_PlayerStart", 0] call BIS_fnc_getParamValue);
gRA_SettingPlayerIdentity = [false,true] select (["CRA_PlayerIdentity", 0] call BIS_fnc_getParamValue);
gRA_SettingProgressStart = (["CRA_ProgressStart", 0] call BIS_fnc_getParamValue) / 100;
gRA_SettingProgressSpeed = (["CRA_ProgressSpeed", 400] call BIS_fnc_getParamValue) / 100;
gRA_SettingProgressArmy = ["CRA_ProgressArmy", 1] call BIS_fnc_getParamValue;
gRA_SettingProgressRangeMode = ["CRA_TriggerMode", 0] call BIS_fnc_getParamValue;
gRA_SettingProgressRangeBase = ["CRA_TriggerBase", 800] call BIS_fnc_getParamValue;
gRA_SettingProgressEnemyCountMode = ["CRA_EnemyCountMode", 0] call BIS_fnc_getParamValue;
gRA_SettingProgressEnemyCountPlayer = ["CRA_EnemyCountPlayer", 0] call BIS_fnc_getParamValue;
gRA_SettingProgressEnemyCountBase = (["CRA_EnemyCountBase", 1] call BIS_fnc_getParamValue) / 100;
gRA_SettingProgressEnemyCountVariance = (["CRA_EnemyCountVariance", 0] call BIS_fnc_getParamValue) / 100;
gRA_SettingProgressEnemySkillMode = ["CRA_EnemySkillMode", 0] call BIS_fnc_getParamValue;
gRA_SettingProgressEnemySkillBase = (["CRA_EnemySkillBase", 25] call BIS_fnc_getParamValue) / 100;
gRA_SettingProgressEnemySkillVariance = (["CRA_EnemySkillVariance", 0] call BIS_fnc_getParamValue) / 100;

gRA_SettingCivilianVehicleCount = ["CRA_CivilianVehicleCount", 4] call BIS_fnc_getParamValue;

gRA_ProgressValue = missionNamespace getVariable ["gRA_ProgressValue", 0];
gRA_ProgressFactor = missionNamespace getVariable ["gRA_ProgressFactor", 0];
gRA_ProgressArmy = missionNamespace getVariable ["gRA_ProgressArmy", 1];
gRA_ProgressEnemyCountBase = missionNamespace getVariable ["gRA_ProgressEnemyCountBase", 1];
gRA_ProgressEnemyCountVarianceBase = missionNamespace getVariable ["gRA_ProgressEnemyCountVarianceBase", (1 - gRA_SettingProgressEnemyCountVariance / 2)];
gRA_ProgressEnemySkillBase = missionNamespace getVariable ["gRA_ProgressEnemySkillBase", 0.25];
gRA_ProgressEnemySkillVarianceBase = missionNamespace getVariable ["gRA_ProgressEnemySkillVarianceBase", (1 - gRA_SettingProgressEnemySkillVariance / 2)];

gRA_PathAvailable = false;
gRA_PathPlayer = 0;
gRA_PathPos = [];
gRA_PathHandle = scriptNull;
gRA_PathResult = [];
gRA_PathAgent = objNull;
gRA_PathAgentResult = [];

gRA_PlayerProgress = missionNamespace getVariable ["gRA_PlayerProgress", 0];
gRA_PlayerEnter = missionNamespace getVariable ["gRA_PlayerEnter", 800];
gRA_PlayerLeave = missionNamespace getVariable ["gRA_PlayerLeave", 800 + CRA_TRIGGER_HYSTERESIS];
gRA_PlayerVar = missionNamespace getVariable ["gRA_PlayerVar", []];
gRA_PlayerInventory = missionNamespace getVariable ["gRA_PlayerInventory", []];
gRA_PlayerPos = [];

gRA_Locations = missionNamespace getVariable ["gRA_Locations", []];
gRA_LocationHistory = [];
gRA_LocationSafe = [];
gRA_LocationAuto = locationNull;

gRA_Civilians = [];

gRA_Version = missionNamespace getVariable ["gRA_Version", []];
gRA_LoadTime = missionNamespace getVariable ["gRA_LoadTime", 0];
gRA_CacheLoad = missionNamespace getVariable ["gRA_CacheLoad", false]; // TODO param values
gRA_CacheSave = missionNamespace getVariable ["gRA_CacheSave", false];

CRA_Temp = {
	private _location = if (_this isEqualType -1) then {gRA_Locations#_this} else {_this};
	private _units = _location getVariable [CRA_VAR_LOCATION_UNIT_PERSONNEL, []];
	{_x setDamage 1;} forEach _units;
	{[_x, _location] call CRA_PlayerTeleport;} forEach allPlayers;
};
CRA_Loop = {
	call CRA_PlayerLoop;
	call CRA_VehicleLoop;
	call CRA_DepotLoop;
	call CRA_CivilianLoop;
	call CRA_LocationLoop;
};
CRA_LightsOn = {
	{if (_x getVariable [CRA_VAR_LOCATION_STATE, -1] == CRA_STATE_ACTIVE) then {[_x, true] call CRA_LocationBaseLights;};} forEach gRA_Locations;
};
CRA_LightsOff = {
	{if (_x getVariable [CRA_VAR_LOCATION_STATE, -1] == CRA_STATE_ACTIVE) then {[_x, false] call CRA_LocationBaseLights;};} forEach gRA_Locations;
};
CRA_InitPre = {
	private _tickStart = diag_tickTime;
	call CRA_PlayerInit;
	gRA_Version = CRA_VERSION + productVersion;
	private _cacheOK = false;
	if (gRA_CacheLoad && {(profileNamespace getVariable [CRA_VAR_VERSION, []]) isEqualTo gRA_Version}) then {
		private _crc = profileNamespace getVariable [CRA_VAR_CRC, -1];
		if (_crc == (call CRA_CacheLoad)) then {_cacheOK = true;} else {call CRA_CacheReset;};
	};
	if (!_cacheOK) then {
		call CRA_CacheClear;
		call CRA_UnitIdentityInit;
		call CRA_ItemInit;
		call CRA_VehicleInit;
		call CRA_DepotGenerate;
		if (gRA_CacheSave) then {call CRA_CacheSave;};
	};
	call CRA_DepotInit;
	call CRA_LocationInit;
	call CRA_SideInit;
	gRA_LoadTime = diag_tickTime - _tickStart;
};
CRA_Init = {
	call CRA_ProgressInit; // TODO this back into InitPre?
};
CRA_CacheLoad = { // TODO add statics!
	private _crc = [0, CRA_VERSION] call CRQ_CRC;
	{_crc = [_crc, _x#0, _x#1, _x#2] call CRQ_CacheLoad;} forEach CRA_CACHE_ITEM;
	{_crc = [_crc, _x#0, _x#1, _x#2] call CRQ_CacheLoad;} forEach CRA_CACHE_VEHICLE;
	_crc = (_crc call CRA_DepotLoad);
	_crc
};
CRA_CacheSave = {
	private _crc = [0, CRA_VERSION] call CRQ_CRC;
	{_crc = [_crc, _x#1, _x#0, _x#2] call CRQ_CacheSave;} forEach CRA_CACHE_ITEM;
	{_crc = [_crc, _x#1, _x#0, _x#2] call CRQ_CacheSave;} forEach CRA_CACHE_VEHICLE;
	_crc = _crc call CRA_DepotSave;
	profileNamespace setVariable [CRA_VAR_CRC, _crc];
	profileNamespace setVariable [CRA_VAR_VERSION, gRA_Version];
};
CRA_CacheClear = {
	{profileNamespace setVariable [_x#0, nil];} forEach CRA_CACHE_ITEM;
	{profileNamespace setVariable [_x#0, nil];} forEach CRA_CACHE_VEHICLE;
	profileNamespace setVariable [CRA_VAR_CACHE_DEPOT_DATA, nil];
	profileNamespace setVariable [CRA_VAR_CACHE_DEPOT_TYPES, nil];
	profileNamespace setVariable [CRA_VAR_CRC, nil];
	profileNamespace setVariable [CRA_VAR_VERSION, nil];
};
CRA_CacheReset = {
	{missionNamespace setVariable [_x#1, _x#2];} forEach CRA_CACHE_ITEM;
	{missionNamespace setVariable [_x#1, _x#2];} forEach CRA_CACHE_VEHICLE;
	call CRA_DepotReset;
};
CRA_SideInit = {
	civilian setFriend [west, 1];
	civilian setFriend [east, 1];
	civilian setFriend [resistance, 1];
};
CRA_SideOpponent = {
	switch (_this) do {
		default {[]};
		case CRQ_SIDE_CIVFOR: {[]};
		case CRQ_SIDE_OPFOR: {[CRQ_SIDE_BLUFOR, CRQ_SIDE_IDFOR]};
		case CRQ_SIDE_IDFOR: {[CRQ_SIDE_BLUFOR, CRQ_SIDE_OPFOR]};
		case CRQ_SIDE_BLUFOR: {[CRQ_SIDE_OPFOR, CRQ_SIDE_IDFOR]};
		case civilian: {[]};
		case east: {[west, resistance]};
		case resistance: {[west, resistance]};
		case west: {[east, resistance]};
	};
};
CRA_SideAlly = {
	switch (_this) do {
		default {[]};
		case CRQ_SIDE_CIVFOR: {[]};
		case CRQ_SIDE_OPFOR: {[]};
		case CRQ_SIDE_IDFOR: {[]};
		case CRQ_SIDE_BLUFOR: {[]};
		case civilian: {[]};
		case east: {[]};
		case resistance: {[]};
		case west: {[]};
	};
};
CRA_PathRoad = {
	params ["_roadInit", "_roadExclude", "_refPos", "_refRadius"];
	private _roadPath = [];
	private _limit = ceil (_refRadius / CRA_PATHGENERATOR_SEGMENTATION);
	private _counter = 0;
	private _roadCurrent = _roadInit;
	private _branches = [];
	private _branchCurrent = -1;
	private _history = +_roadExclude;
	private _pathFound = false;
	while {!_pathFound} do {
		_history pushBack _roadCurrent;
		_roadPath pushBack _roadCurrent;
		
		private _options = [];
		{
			if (_history find _x == -1) then {
				private _info = getRoadInfo _x;
				if ((_info#0) isEqualTo "ROAD" || {(_info#0) isEqualTo "MAIN ROAD" || {(_info#0) isEqualTo "TRACK"}}) then {_options pushBack _x;};
			};
		} forEach (roadsConnectedTo _roadCurrent);
		private _countOptions = count _options;
		
		if (_counter < _limit && _countOptions > 0) then {
			_counter = _counter + 1;
			if (_countOptions > 1) then {
				_branchCurrent = _branchCurrent + 1;
				_roadCurrent = selectRandom (_options);
				private _branchOptions = [];
				{if (_x isNotEqualTo _roadCurrent) then {_branchOptions pushBack _x};} forEach _options;
				_branches set [_branchCurrent, [_counter, _branchOptions]];
			} else {
				_roadCurrent = _options#0;
			};
			if ((_roadCurrent call CRQ_Pos2D) distance2D _refPos >= _refRadius) then {_pathFound = true;};
		} else {
			while {true} do {
				if (_branchCurrent < 0) exitWith {
					_counter = _limit;
					_roadPath = [];
				};
				if ((_branches#_branchCurrent#1) isNotEqualTo []) then {
					_roadCurrent = (_branches#_branchCurrent#1) deleteAt 0;
					_counter = (_branches#_branchCurrent#0);
					_roadPath resize (_counter); // OPTIMIZE resize history too?
				} else {
					_branchCurrent = _branchCurrent - 1;
				};
			};
		};
		if (_counter >= _limit) exitWith {};
	};
	_roadPath
};
CRA_PathGen = {
	params ["_pos", "_radiusSearch", "_radiusEdge"];
	private _roads = [];
	{
		private _info = getRoadInfo _x;
		if ((_info#0) isEqualTo "ROAD" || {(_info#0) isEqualTo "MAIN ROAD" || {(_info#0) isEqualTo "TRACK"}}) then {_roads pushBack _x;};
	} forEach (_pos nearRoads _radiusSearch);
	_roads = _roads call CRQ_ArrayRandomize;
	private _path1 = [];
	private _path2 = [];
	gRA_PathResult = [];
	{
		_path1 = [_x, [], _pos, _radiusEdge] call CRA_PathRoad;
		private _length = count _path1;
		if (_length > 0) then {
			//private _exclude = if (_length > 1) then {[_path1#0, _path1#1]} else {[_path1#0]};
			private _exclude = if (_length > 1) then {[_path1#1]} else {[]};
			_path2 = [_x, _exclude, _pos, _radiusEdge] call CRA_PathRoad;
		};
		if (_path2 isNotEqualTo []) exitWith {
			reverse _path1;
			_path1 deleteAt (_length - 1);
			{gRA_PathResult pushBack _x;} forEach _path1;
			{gRA_PathResult pushBack _x;} forEach _path2;
		};
	} forEach _roads;
};
CRA_PathWaypoints = {
	private _indexLast = (count _this) - 1;
	private _waypoints = [];
	private _lastWaypoint = 0;
	private _indexMin = CRA_VEHICLE_WAYPOINT_ANALYSIS + 2;
	private _indexMax = _indexLast - (CRA_VEHICLE_WAYPOINT_ANALYSIS + 1);
	{
		if (_forEachIndex > _indexMin && _forEachIndex < _indexMax && (_forEachIndex - _lastWaypoint) > CRA_VEHICLE_WAYPOINT_SPACING) then { // TODO might be an off by one here, idk
			if (count (roadsConnectedTo _x) > 2) then { // TODO explicitly exclude bridges, implicitly this is probably inherent through fact that no existing bridge has a junction
				private _lower1 = _forEachIndex - 2;
				private _upper0 = _forEachIndex + 1;
				private _lower0 = _lower1 - CRA_VEHICLE_WAYPOINT_ANALYSIS;
				private _upper1 = _upper0 + CRA_VEHICLE_WAYPOINT_ANALYSIS;
				private _prev = [];
				private _next = [];
				for [{private _i = _lower0}, {_i <= _lower1}, {_i = _i + 1}] do {
					private _road0 = (_this#_i);
					private _road1 = (_this#(_i + 1));
					_prev pushBack [(_road0 getDir _road1), (_road0 distance2D _road1)];
				};
				for [{private _i = _upper0}, {_i <= _upper1}, {_i = _i + 1}] do {
					private _road0 = (_this#_i);
					private _road1 = (_this#(_i + 1));
					_next pushBack [(_road0 getDir _road1), (_road0 distance2D _road1)];
				};
				if (([_prev call CRQ_AngleAvg, _next call CRQ_AngleAvg] call CRQ_Angle) > CRA_VEHICLE_WAYPOINT_ANGLE_MIN) then {_waypoints pushBack _x;};
			};
		};
	} forEach _this;
	_waypoints pushBack ((_this#_indexLast));
	_waypoints
};
CRA_PathAgent = {
	params ["_start","_end"];
	gRA_PathAgent = calculatePath ["car", "safe", _start, _end];
	gRA_PathAgent addEventHandler ["PathCalculated", {if (gRA_PathAgentResult isEqualTo []) then {gRA_PathAgentResult = _this#1;};}];
};
/*
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
CRA_ActionRelayReceive = {
	params ["_object", "_invoker", "_id", "_args"];
	_args params ["_type", "_typeArgs"];
	switch (_args#0) do {
		case CRA_ACTION_ID_PLAYER_TELEPORT: {["Teleport: Coming soon!"] remoteExec ["systemChat", owner _invoker];};
		case CRA_ACTION_ID_MILITIA_TRAIN: {["Train Militia: Coming soon!"] remoteExec ["systemChat", owner _invoker];};
		case CRA_ACTION_ID_INVENTORY_SORT: {_args call CRA_PlayerActionBaseInventory;};
		case CRA_ACTION_ID_INVENTORY_GATHER: {_args call CRA_PlayerActionBaseInventory;};
		default {};
	};
};
CRA_ActionRelayAdd = {
	params ["_object", "_label", "_args"];
	if (_object isNotEqualTo objNull) then {
		private _countOptions = if (count _this > 3) then {count (_this#3)} else {0};
		private _priority = if (_countOptions > 0) then {_this#3#0} else {CRA_ACTION_PRIORITY};
		private _range = if (_countOptions > 1) then {_this#3#1} else {CRA_ACTION_RANGE};
		private _label = "<t color='#" + CRA_ACTION_COLOR + "'>" + _label + "</t>";
		[_object, [_label, {_this call CRA_LocalActionRelayTransmit;}, _args, _priority, true, true, "", "true", _range, false]] call CRQ_ActionAdd;
	};
};
CRA_ProgressInit = {
	gRA_ProgressEnemyCountVarianceBase = 1.0 - gRA_SettingProgressEnemyCountVariance / 2;
	gRA_ProgressEnemySkillVarianceBase = 1.0 - gRA_SettingProgressEnemySkillVariance / 2;
	{gRA_ProgressValue = gRA_ProgressValue + (_x getVariable [CRA_VAR_LOCATION_VALUE, 0]);} forEach gRA_Locations;
	gRA_ProgressFactor = if (gRA_ProgressValue > 0) then {gRA_SettingProgressSpeed / gRA_ProgressValue} else {0};
	gRA_PlayerProgress = gRA_SettingProgressStart;
	call CRA_ProgressCalculate;
};
CRA_ProgressRange = {
	switch (gRA_SettingProgressRangeMode) do {
		default {_this};
		case 1: {_this * (1 + gRA_PlayerProgress)};
	};
};
CRA_ProgressArmy = {
	private _progress = 1;
	if (gRA_SettingProgressArmy >= 0) then {
		_progress = if (_this > 1) then {1} else {_this};
		_progress = 1 - ((1 - _progress) ^ gRA_SettingProgressArmy);
	};
	_progress
};
CRA_ProgressEnemySkill = {
	private _skill = gRA_SettingProgressEnemySkillBase;
	switch (gRA_SettingProgressEnemySkillMode) do {
		case 1: {_skill = gRA_SettingProgressEnemySkillBase * (1 + _this);};
		default {};
	};
	if (_skill > 1) then {1} else {_skill};
};
CRA_ProgressEnemyCount = {
	private _count = gRA_SettingProgressEnemyCountBase;
	switch (gRA_SettingProgressEnemyCountMode) do {
		default {};
		case 1: {_count = _count * (1 + _this);};
	};
	_count
};
CRA_ProgressEnemyCountPlayerFactor = {
	private _playerCount = count allPlayers;
	switch (gRA_SettingProgressEnemyCountPlayer) do {
		case 2: {_playerCount};
		case 1: {sqrt _playerCount};
		default {1};
	};
};
CRA_ProgressCalculate = {
	gRA_PlayerEnter = gRA_SettingProgressRangeBase call CRA_ProgressRange;
	gRA_PlayerLeave = (gRA_SettingProgressRangeBase call CRA_ProgressRange) + CRA_TRIGGER_HYSTERESIS;
	gRA_ProgressArmy = gRA_PlayerProgress call CRA_ProgressArmy;
	gRA_ProgressEnemyCountBase = gRA_PlayerProgress call CRA_ProgressEnemyCount;
	gRA_ProgressEnemySkillBase = gRA_PlayerProgress call CRA_ProgressEnemySkill;
	private _depotAbandonRangeBase = switch (gRA_SettingDepotAbandonRangeMode) do {
		case 1: {1000};
		default {gRA_PlayerEnter};
	};
	gRA_DepotAbandonRange = _depotAbandonRangeBase * gRA_SettingDepotAbandonRange;
};
CRA_ProgressAward = {
	gRA_PlayerProgress = gRA_PlayerProgress + (_this * gRA_ProgressFactor);
	if (gRA_PlayerProgress > 1) then {gRA_PlayerProgress = 1;};
	call CRA_ProgressCalculate;
};
CRA_PlayerInit = {
	private _countMax = playableSlotsNumber (CRA_PLAYER_SIDE call CRQ_Side);
	for [{private _i = 0}, {_i < _countMax}, {_i = _i + 1}] do {
		gRA_PlayerVar pushBack (CRA_PLAYER_VAR + str _i);
		gRA_PlayerInventory pushBack [];
	};
};
CRA_PlayerLoop = {
	private _positions = [];
	{_positions pushBack (_x call CRQ_Pos2D);} forEach allPlayers;
	gRA_PlayerPos = _positions;
};
CRA_PlayerConnect = {
	//params ["_id", "_uid", "_name", "_jip", "_owner", "_idstr"];
};
CRA_PlayerDisconnect = {
	//params ["_id", "_uid", "_name", "_jip", "_owner", "_idstr"];
};
CRA_PlayerHandleDisconnect = {
	params ["_unit", "_id", "_uid", "_name"];
	private _index = gRA_PlayerVar find (vehicleVarName _unit);
	if (_index != -1) then {
		gRA_PlayerInventory set [_index, getUnitLoadout _unit];
		_unit call CRQ_UnitDelete;
	};
};
CRA_PlayerLoadoutClear = {
	_this set [0, []];
	_this set [1, []];
	_this set [2, []];
	(_this#3) set [1, []];
	_this set [4, []];
	_this set [5, []];
	_this set [8, []];
	(_this#9) set [1, ""];
	(_this#9) set [5, ""];
	_this
};
CRA_PlayerLoadoutGenerate = {
	(_this#3#1) pushBack ["FirstAidKit",1];
	private _vest = [-1 call CRA_ItemLevel, (CRA_UNIT_VEST_PLAYER#1) selectRandomWeighted (CRA_UNIT_VEST_PLAYER#0)] call CRA_Item;
	private _backpack = [-1 call CRA_ItemLevel, (CRA_UNIT_BACKPACK_PLAYER#1) selectRandomWeighted (CRA_UNIT_BACKPACK_PLAYER#0)] call CRA_Item;
	if (_vest != -1) then {_this set [4, [gRA_ItemIndex#_vest, []]];};
	if (_backpack != -1) then {_this set [5, [gRA_ItemIndex#_backpack, []]];};
	private _weapon = [[-1 call CRA_ItemLevel, [CRA_INDEX_WEAPON_ALL]] call CRA_Item, true, true] call CRA_ItemWeaponRasterize;
	_this = [_this, _weapon] call CRQ_InventoryLoadoutAppend;
	_this
};
CRA_PlayerIndex = {
	(gRA_PlayerVar find (vehicleVarName _this))
};
CRA_PlayerLoadout = {
	private _index = _this call CRA_PlayerIndex;
	private _identity = if (gRA_SettingPlayerIdentity && _index != -1) then {CRA_PLAYER_IDENTITY#_index} else {[]};
	private _loadout = [];
	if (_index != -1) then {
		private _existing = +(gRA_PlayerInventory#_index);
		if (_existing isNotEqualTo []) then {
			_loadout = _existing;
			gRA_PlayerInventory set [_index, []];
		} else {
			_loadout = (CRA_PLAYER_LOADOUT#_index) call CRA_PlayerLoadoutGenerate;
		};
	} else {
		_loadout = ((getUnitLoadout _this) call CRA_PlayerLoadoutClear) call CRA_PlayerLoadoutGenerate;
	};
	[_this, _identity, _loadout] remoteExec ["CRQ_LocalClientIdentityLoadout", owner _this];
};
CRA_PlayerSpawn = {
	params ["_unit", "_respawn"];
	_unit call CRA_PlayerLoadout;
	private _location = _unit getVariable [CRA_VAR_PLAYER_SPAWN_LOCATION, nil];
	if (isNil {_location}) then {
		_location = gRA_LocationAuto;
		_unit setVariable [CRA_VAR_PLAYER_SPAWN_LOCATION, _location];
		_unit setVariable [CRA_VAR_PLAYER_SPAWN_AUTO, true];
	};
	if (isNull _location) then {_unit call CRA_PlayerParadrop;} else {[_unit, _location] call CRA_PlayerTeleport;};
};
CRA_PlayerSpawnLocation = {
	params ["_unit", "_location"];
	if (gRA_LocationSafe find _location != -1) then {_unit setVariable [CRA_VAR_PLAYER_SPAWN_LOCATION, _location];};
};
CRA_PlayerInRange = {
	params ["_pos", "_range"];
	private _trigger = false;
	{if (_x distance2D _pos <= _range) exitWith {_trigger = true;};} forEach gRA_PlayerPos;
	_trigger
};
CRA_PlayerParadrop = {
	private _vector = _this getVariable [CRA_VAR_PLAYER_SPAWN_DROP, nil];
	if (isNil {_vector}) then {_vector = [getMarkerPos "gM_Start", markerDir "gM_Start"];};
	[_this, _vector] remoteExec ["CRA_Paradrop", owner _this];
	//[_vector#0, [0,0,0], CRA_PARADROP_HEIGHT + 20, "FULL", "B_CTRG_Heli_Transport_01_tropic_F", west] call BIS_fnc_ambientFlyBy;
};
CRA_PlayerTeleport = {
	params ["_unit", "_location"];
	private _vector = _location getVariable [CRA_VAR_LOCATION_BASE_VEC, []];
	if (_vector isEqualTo []) then {_vector = [locationPosition _location, random 360];};
	_unit setPos (_vector#0);
	_unit setDir (_vector#1);
};
CRA_PlayerActionBaseInventory = {
	private _location = gRA_Locations#(_this#1);
	if (true) then { // TODO
		switch (_this#0) do {
			case CRA_ACTION_ID_INVENTORY_SORT: {
				_location call CRA_LocationInventorySort;
				private _message = format ["%1: Inventory has been sorted", text _location];
				CRQ_MESSAGE(_message);
			};
			case CRA_ACTION_ID_INVENTORY_GATHER: {
				([_location, _this#2] call CRA_LocationInventoryGather) params ["_countItems", "_countMags", "_countWeapons", "_countContainers"];
				private _messageGather = format ["%1: Items have been gathered in a %2m radius", text _location, _this#2];
				private _messageCount = format ["%1: %2x weapons, %3x mags, %4x vests/backpacks, and %5x items were added to the base's inventory box", text _location, _countWeapons, _countMags, _countContainers, _countItems];
				CRQ_MESSAGE(_messageGather);
				CRQ_MESSAGE(_messageCount);
			};
			default {};
		};
	} else {
		private _messageDanger = format ["%1: This is a hostile area!", text _location];
		CRQ_MESSAGE(_messageDanger);
	};
};
CRA_PlayerLocationSafe = {
	private _candidates = [];
	{
		private _owner = _x getVariable [CRA_VAR_LOCATION_OWNER, -1];
		if (_owner == CRA_PLAYER_SIDE) then {_candidates pushBack _x;};
	} forEach gRA_LocationHistory;
	gRA_LocationSafe = _candidates;
	gRA_LocationAuto = if (_candidates isNotEqualTo []) then {_candidates#(count _candidates - 1)} else {locationNull};
	{
		if (_x getVariable [CRA_VAR_PLAYER_SPAWN_AUTO, true]) then {
			_x setVariable [CRA_VAR_PLAYER_SPAWN_LOCATION, gRA_LocationAuto];
		} else {
			private _location = _x getVariable [CRA_VAR_PLAYER_SPAWN_LOCATION, locationNull];
			if (!isNull _location) then {
				if (_candidates find _location == -1) then {
					_x setVariable [CRA_VAR_PLAYER_SPAWN_LOCATION, gRA_LocationAuto];
				};
			};
		};
	} forEach allPlayers;
};
CRA_PlayerLocationEnter = {
	private _messageTrigger = format ["%1: %2 are known to be present", text _this, (_this getVariable [CRA_VAR_LOCATION_OWNER, -1]) call CRQ_SideLabel];
	CRQ_MESSAGE(_messageTrigger);
};
CRA_PlayerLocationCapture = {
	private _ownerPrev = _this getVariable [CRA_VAR_LOCATION_OWNER_PREV, CRQ_SIDE_CIVFOR];
	private _owner = _this getVariable [CRA_VAR_LOCATION_OWNER, -1];
	if (_this getVariable [CRA_VAR_LOCATION_ANNOUNCE, false]) then {
		private _message = "";
		if (_owner != CRQ_SIDE_CIVFOR) then {
			if (_ownerPrev != CRQ_SIDE_CIVFOR) then {
				_message = format ["%1: %2 have gained control from %3", text _location, _owner call CRQ_SideLabel, _ownerPrev call CRQ_SideLabel];
			} else {
				_message = format ["%1: %2 have gained control", text _location, _owner call CRQ_SideLabel];
			};
		} else {
			_message = format ["%1: %2 have lost control", text _location, _ownerPrev call CRQ_SideLabel];
		};
		CRQ_MESSAGE(_message);
	};
	private _playerAffected = false;
	if (_ownerPrev == CRA_PLAYER_SIDE) then {_location call CRA_PlayerLocationLost; _playerAffected = true;};
	if (_owner == CRA_PLAYER_SIDE) then {_location call CRA_PlayerLocationWin; _playerAffected = true;};
	if (_playerAffected) then {call CRA_PlayerLocationSafe;};
};
CRA_PlayerLocationWin = {
	[] remoteExec [if (gRA_LocationHistory isNotEqualTo []) then {"CRA_LocalBattleWin"} else {"CRA_LocalIntroSecond"}, gCS_Broadcast];
	if (!(_this getVariable [CRA_VAR_LOCATION_CAPTURED, true])) then {
		(_this getVariable [CRA_VAR_LOCATION_VALUE, 0]) call CRA_ProgressAward;
		_this setVariable [CRA_VAR_LOCATION_CAPTURED, true];
		gRA_LocationHistory pushBack _this;
	};
	private _message = format ["%1 has been secured", text _this];
	CRQ_NOTIFY(_message);
};
CRA_PlayerLocationLost = {
	[] remoteExec ["CRA_LocalPlayerDeath", gCS_Broadcast];
	private _message = format ["%1 has been seized by the enemy!", text _this];
	CRQ_NOTIFY(_message);
};
CRA_LocationLoop = {
	{
		private _pos = locationPosition _x;
		switch (_x getVariable [CRA_VAR_LOCATION_STATE, -1]) do {
			case CRA_STATE_INIT;
			case CRA_STATE_HIBERNATE: {
				if ([_pos, gRA_PlayerEnter] call CRA_PlayerInRange) then {_x call CRA_LocationEnter;};
			};
			case CRA_STATE_ACTIVE: {
				_x call CRA_LocationPersonnelLoop;
				_x call CRA_LocationCaptureLoop;
				_x call CRA_LocationBaseRadioLoop;
				if (!([_pos, gRA_PlayerLeave] call CRA_PlayerInRange)) then {_x call CRA_LocationLeave;};
			};
			default {};
		};
	} forEach gRA_Locations;
};
CRA_LocationEnter = {
	_this call CRA_LocationBaseSpawn;
	_this call CRA_LocationBaseRadioNext;
	[_this, call CRQ_Lights] call CRA_LocationBaseLights;
	
	private _init = _this getVariable [CRA_VAR_LOCATION_STATE, -1] == CRA_STATE_INIT;
	
	private _timeDelta = gT_Now - (_this getVariable [CRA_VAR_LOCATION_HIBERNATE_TIME, gT_Now]);
	private _rejuvenation = (_timeDelta / 60) * CRA_LOCATION_REJUVENATION;
	private _damageUnit = (_this getVariable [CRA_VAR_LOCATION_DAMAGE_PERSONNEL, 0]) - _rejuvenation;
	private _damageVehicle = (_this getVariable [CRA_VAR_LOCATION_DAMAGE_VEHICLE, 0]) - _rejuvenation;
	
	private _enemyControlled = (CRA_PLAYER_SIDE call CRA_SideOpponent) find (_this getVariable [CRA_VAR_LOCATION_OWNER, -1]) != -1;
	if (_init || _enemyControlled && {_damageUnit <= 0 && _damageVehicle <= 0}) then {
		if (_init || {random 1 < _rejuvenation}) then {
			_this call CRA_LocationOwnerInit; // TODO partial rejuvenation
			_this call CRA_LocationInventoryInit;
		};
		_this call CRA_LocationPersonnelSpawn;
	} else {
		_this call CRA_LocationThaw;
	};
	
	_this call CRA_LocationPersonnelOrders;
	
	_this call CRA_LocationInventoryLoad;
	_this call CRA_LocationActionCreate;
	if (_init) then {if (_this getVariable [CRA_VAR_LOCATION_ANNOUNCE, false]) then {_this call CRA_PlayerLocationEnter;};};
	[_this, CRA_STATE_ACTIVE] call CRA_LocationState;
};
CRA_LocationLeave = {
	_this call CRA_LocationHibernate;
	_this call CRA_LocationPersonnelDespawn;
	_this call CRA_LocationActionRemove;
	_this call CRA_LocationInventorySave;
	_this call CRA_LocationBaseDespawn;
	[_this, CRA_STATE_HIBERNATE] call CRA_LocationState;
};
CRA_LocationState = {
	params ["_location", "_state"];
	_location setVariable [CRA_VAR_LOCATION_STATE, _state];
	_location call CRA_LocationMarkerState;
};
CRA_LocationOwnerInit = {
	_this setVariable [CRA_VAR_LOCATION_OWNER, ([CRQ_SIDE_OPFOR, CRQ_SIDE_IDFOR] selectRandomWeighted [gRA_ProgressArmy, 1 - gRA_ProgressArmy])];
};
CRA_LocationOwnerChange = {
	params ["_location", "_owner"];
	_location setVariable [CRA_VAR_LOCATION_OWNER_PREV, _location getVariable [CRA_VAR_LOCATION_OWNER, nil]];
	_location setVariable [CRA_VAR_LOCATION_OWNER, _owner];
	_location call CRA_LocationMarkerState;
};
CRA_LocationCaptureLoop = {
	private _pos = (_this getVariable [CRA_VAR_LOCATION_BASE_VEC, [[]]])#0;
	if (_pos isEqualTo []) then {_pos = locationPosition _this;};
	private _radius = ((size _this)#0) + CRA_BASE_ORBIT;
	private _owner = _this getVariable [CRA_VAR_LOCATION_OWNER, CRQ_SIDE_CIVFOR];
	private _unitCount = [0,0,0];
	private _alive = [];
	private _units = [];
	{
		if (_x isKindOf "Man") then {
			if (alive _x) then {_units pushBack _x;};
		} else {
			{if (alive _x) then {_units pushBack _x;};} forEach (crew _x);
		};
	} forEach (_pos nearEntities [["Man", "Car", "Tank"], _radius]);
	{
		private _side = ((side _x) call CRQ_Side);
		if (_side == CRQ_SIDE_OPFOR || {_side == CRQ_SIDE_IDFOR || {_side == CRQ_SIDE_BLUFOR}}) then {_unitCount set [_side, (_unitCount#_side) + 1];};
	} forEach _units;
	{_alive pushBack (_x > 0);} forEach _unitCount;
	if (_owner == CRQ_SIDE_CIVFOR || {!(_alive#_owner)}) then {
		private _dominant = [];
		private _aliveAllies = false;
		private _aliveOpponents = false;
		{if (_alive#_x) exitWith {_aliveAllies = true;};} forEach (_owner call CRA_SideAlly);
		{if (_alive#_x) exitWith {_aliveOpponents = true;};} forEach (_owner call CRA_SideOpponent);
		if (!_aliveAllies && _aliveOpponents) then {_dominant pushBack [-1, CRQ_SIDE_CIVFOR];};
		
		private _capture = [];
		{
			if (_x) then {
				private _unopposed = true;
				{if (_alive#_x) exitWith {_unopposed = false;};} forEach (_forEachIndex call CRA_SideOpponent);
				if (_unopposed) then {_capture pushBack _forEachIndex;};
			};
		} forEach _alive;
		
		private _countDominant = 0;
		{
			private _count = _unitCount#_x;
			if (_count > _countDominant) then {
				_dominant pushBack [_count, _x];
				_countDominant = _count;
			};
		} forEach _capture;
		
		if (_dominant isNotEqualTo []) then {
			_dominant sort false;
			private _sidesAllowed = _this getVariable [CRA_VAR_LOCATION_CAPTUREABLE, [CRQ_SIDE_CIVFOR]];
			{if (_sidesAllowed find (_x#1) != -1) exitWith {[_this, _x#1] call CRA_LocationCapture;};} forEach _dominant;
		};
	};
};
CRA_LocationCapture = {
	params ["_location", "_winner"];
	[_location, _winner] call CRA_LocationOwnerChange;
	_location call CRA_LocationPersonnelClear;
	_location call CRA_LocationPersonnelDespawn;
	_location call CRA_PlayerLocationCapture;
};
CRA_UnitHibernate = {
	private _type = typeOf _this;
	private _vec = [getPosATL _this, getDir _this];
	private _loadout = getUnitLoadout _this;
	private _identity = _this call CRQ_GetIdentity;
	private _skill = skill _this;
	private _damage = damage _this;
	[_type, _vec, _loadout, _identity, _skill, _damage]
};
CRA_LocationHibernate = {
	private _hibUnits = [];
	private _hibVehicles = [];
	private _hibGroups = [];
	private _groups = _this getVariable [CRA_VAR_LOCATION_GROUP_PERSONNEL, []];
	private _units = _this getVariable [CRA_VAR_LOCATION_UNIT_PERSONNEL, []];
	private _vehicles = _this getVariable [CRA_VAR_LOCATION_UNIT_VEHICLE, []];
	private _countUnit = _this getVariable [CRA_VAR_LOCATION_COUNT_PERSONNEL, -1];
	private _countVehicle = _this getVariable [CRA_VAR_LOCATION_COUNT_VEHICLE, -1];
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
			private _hibernated = _x call CRA_UnitHibernate;
			_unitDamage = _unitDamage + (_hibernated#5);
			_hibUnits pushBack [_group, _turret, _hibernated];
		};
	} forEach _units;
	{
		if (isNull _x) then {
			_vehicleDamage = _vehicleDamage + 1;
			_hibVehicles pushBack [];
		} else {
			private _hibernated = _x call CRA_VehicleHibernate;
			_vehicleDamage = _vehicleDamage + (_hibernated#1#3);
			_hibVehicles pushBack _hibernated;
		};
	} forEach _vehicles;
	{if (isNull _x) then {_hibGroups pushBack -1;} else {_hibGroups pushBack _forEachIndex;};} forEach _groups;
	_this setVariable [CRA_VAR_LOCATION_HIBERNATE_GROUPS, _hibGroups];
	_this setVariable [CRA_VAR_LOCATION_HIBERNATE_VEHICLES, _hibVehicles];
	_this setVariable [CRA_VAR_LOCATION_HIBERNATE_UNITS, _hibUnits];
	_this setVariable [CRA_VAR_LOCATION_HIBERNATE_TIME, gT_Now];
	_this setVariable [CRA_VAR_LOCATION_DAMAGE_PERSONNEL, if (_countUnit > 0) then {_unitDamage / _countUnit} else {0}];
	_this setVariable [CRA_VAR_LOCATION_DAMAGE_VEHICLE, if (_countVehicle > 0) then {_vehicleDamage / _countVehicle} else {0}];
};
CRA_LocationThaw = {
	private _groups = [];
	private _vehicles = [];
	private _units = [];
	private _owner = _this getVariable [CRA_VAR_LOCATION_OWNER, -1];
	{if (_x != -1) then {_groups pushBack (_owner call CRQ_GroupCreate);} else {_groups pushBack grpNull;};} forEach (_this getVariable [CRA_VAR_LOCATION_HIBERNATE_GROUPS, []]);
	{if (_x isNotEqualTo []) then {_vehicles pushBack (_x call CRA_VehicleThaw);} else {_vehicles pushBack objNull;};} forEach (_this getVariable [CRA_VAR_LOCATION_HIBERNATE_VEHICLES, []]);
	{
		if (_x isEqualTo []) then {
			_units pushBack objNull;
		} else {
			_x params ["_groupIndex", "_vehicleIndex", "_data"];
			private _unit = ([_groups#_groupIndex] + _data) call CRQ_UnitCreate;
			_units pushBack _unit;
			if (_vehicleIndex isNotEqualTo []) then {
				private _vehicle = _vehicles#(_vehicleIndex#0);
				private _turret = _vehicleIndex#1;
				switch (true) do {
					case (_turret isEqualTo [-1]): {_unit moveInDriver _vehicle;};
					case (_turret isEqualTo []): {_unit moveInCargo _vehicle;}; // TODO might cause conflict
					default {_unit moveInTurret [_vehicle, _turret];};
				};
			};
		};
	} forEach (_this getVariable [CRA_VAR_LOCATION_HIBERNATE_UNITS, []]);
	_this setVariable [CRA_VAR_LOCATION_GROUP_PERSONNEL, _groups];
	_this setVariable [CRA_VAR_LOCATION_UNIT_VEHICLE, _vehicles];
	_this setVariable [CRA_VAR_LOCATION_UNIT_PERSONNEL, _units];
	_this setVariable [CRA_VAR_LOCATION_HIBERNATE_GROUPS, []];
	_this setVariable [CRA_VAR_LOCATION_HIBERNATE_VEHICLES, []];
	_this setVariable [CRA_VAR_LOCATION_HIBERNATE_UNITS, []];
};
CRA_LocationRoadblockInit = {
	private _roadBlocks = [];
	private _full = (worldSize / CRA_ROADBLOCK_DENSITY);
	private _half = _full / 2;
	private _radius = 1.42 * _full;
	private _posY = _half;
	for [{private _iY = 0}, {_iY < CRA_ROADBLOCK_DENSITY}, {_iY = _iY + 1}] do {
		private _posX = _half;
		for [{private _iX = 0}, {_iX < CRA_ROADBLOCK_DENSITY}, {_iX = _iX + 1}] do {
			private _pos = [_posX, _posY];
			private _roadsAll = [_posX, _posY] nearRoads _radius;
			private _countAll = count _roadsAll;
			private _history = [];
			private _found = false;
			while {true} do {
				private _remaining = _countAll - count _history;
				if (_remaining < 1) exitWith {};
				if (true) then {
					private _index = floor (random _remaining);
					{if (_x <= _index) then {_index = _index + 1;};} forEach _history;
					_history pushBack _index;
					
					private _road = _roadsAll#_index;
					
					private _roadPos = _road call CRQ_Pos2D;
					if (!(_roadPos inArea [_pos, _half, _half, 0, true])) exitWith {};
					
					private _roadInfo = getRoadInfo _road;
					if ((_roadInfo#8) || {["TRACK","ROAD","MAIN ROAD"] find (_roadInfo#0) == -1}) exitWith {};
					
					private _exclude = false;
					{if (_roadPos distance2D (locationPosition _x) < CRA_ROADBLOCK_DISTANCE_LOCATION) exitWith {_exclude = true;};} forEach gRA_Locations;
					if (_exclude) exitWith {};
					
					{if (_roadPos distance2D (_x#0) < CRA_ROADBLOCK_DISTANCE_OTHER) exitWith {_exclude = true;};} forEach _roadBlocks;
					if (_exclude) exitWith {};
					
					private _path0 = [_road, [], _roadPos, 120] call CRA_PathRoad;
					if (_path0 isEqualTo []) exitWith {};
					private _path1 = [_road, [_path0#1], _roadPos, 120] call CRA_PathRoad;
					if (_path1 isEqualTo []) exitWith {};
					reverse _path1;
					_path0 deleteAt 0;
					private _path = _path1 + _path0;
					private _pathLength = count _path - CRA_ROADBLOCK_SEGMENTS;
					private _segments = [];
					for [{private _i = 1}, {_i < _pathLength}, {_i = _i + 1}] do {
						private _segment0 = _path#(_i - 1);
						private _segment1 = _path#_i;
						private _straight = true;
						private _angles = [];
						private _dirs = [];
						for [{private _n = 1}, {_n <= CRA_ROADBLOCK_SEGMENTS}, {_n = _n + 1}] do {
							private _distance0 = _segment0 distance2D _segment1;
							private _dir0 = _segment0 getDir _segment1;
							_segment0 = _segment1;
							_segment1 = _path#(_i + _n);
							private _distance1 = _segment0 distance2D _segment1;
							private _dir1 = _segment0 getDir _segment1;
							private _angle = [_dir0, _dir1] call CRQ_Angle;
							if (_angle > CRA_ROADBLOCK_ANGLE_MAX) exitWith {_straight = false;};
							_angles pushBack [_angle, _distance0 + _distance1];
							_dirs pushBack [_dir0, _distance0];
							_dirs pushBack [_dir1, _distance1];
						};
						if (_straight) exitWith {_segments pushback [_angles call CRQ_AngleAvg, _i, _dirs call CRQ_AngleAvg];};
					};
					if (_segments isEqualTo []) exitWith {};
					_segments sort true;
					_roadBlocks pushBack [_path#((_segments#0#1) + floor (CRA_ROADBLOCK_SEGMENTS / 2)), _segments#0#2];
					_found = true;
				};
				if (_found || {count _history >= CRA_ROADBLOCK_SCAN_ATTEMPTS}) exitWith {};
			};
			_posX = _posX + _full;
		};
		_posY = _posY + _full;
	};
	private _offset = count gRA_Locations;
	{gRA_Locations pushBack ([_offset + _forEachIndex, CRA_LOCATION_TYPE_ROADBLOCK, [(_x#0) call CRQ_Pos2D, _x#1], "CRA_ROADBLOCK_" + str _forEachIndex, "Roadblock", [], objNull] call CRA_LocationGenerate);} forEach _roadBlocks;
};
CRA_LocationOutpostInit = {
	private _outpostTypes = [];
	{_outpostTypes pushBack [toLowerANSI ((_x#0) call CRQ_ClassModel), _x#1];} forEach CRA_BASEB_OUTPOSTS;
	
	private _candidates = [];
	{
		private _obj = _x;
		private _name = _obj call CRQ_ObjectModel;
		{
			if (_name isEqualTo (_x#0)) exitWith {
				private _pos = getPosATL _obj;
				private _include = true;
				{if (_pos distance2D (locationPosition _x) < CRA_LOCATION_OUTPOST_PROXIMITY) exitWith {_include = false;};} forEach gRA_Locations;
				if (_include) then {_candidates pushBack [_obj, [_pos, getDir _obj], _x#1];};
			};
		} forEach _outpostTypes;
	} forEach (["HOUSE"] call CRQ_WorldTerrainObjects);
	if (_candidates isNotEqualTo []) then {
		_candidates = _candidates call CRQ_ArrayRandomize;
		private _probability = CRA_LOCATION_OUTPOST_COUNT / (count _candidates);
systemChat (str [count _candidates, _probability]);
		private _offset = count gRA_Locations;
		private _index = 0;
		private _outposts = [];
		{
			if (random 1 < _probability) then {
				private _pos = _x#1#0;
				private _include = true;
				{if (_pos distance2D (locationPosition _x) < CRA_LOCATION_OUTPOST_PROXIMITY) exitWith {_include = false;};} forEach _outposts;
				if (_include) then {
					_outposts pushBack ([_offset + _index, CRA_LOCATION_TYPE_OUTPOST, _x#1, "CRA_OUTPOST_" + str _index, "Outpost", _x#2, _x#0] call CRA_LocationGenerate);
					_index = _index + 1;
				};
			};
		} forEach _candidates;
		gRA_Locations append _outposts;
	};
};
CRA_LocationInit = {
	private _scanTypes = [];
	private _houseBases = [];
	{
		_scanTypes pushBack (_x#0);
		private _base = [];
		{_base pushBack [[CRQ_VEC_HOUSE,[_x#0]],_x#1];} forEach (_x#3);
		_houseBases pushback _base;
	} forEach CRA_LOCATION_SCAN;
	{
		private _scanIndex = _forEachIndex;
		private _scanLocation = _x;
		private _scanID = className _scanLocation;
		private _scanType = type _scanLocation;
		
		private _scanOverrideIndex = CRA_LOCATION_SCAN_OVERRIDE findIf {(_x#0) == _scanID};
		private _scanTypeIndex = _scanTypes findIf {_x == _scanType};
		
		private _locationData = [];
		private _locationBaseGenerics = [];
		private _locationBaseBuildings = [];
		if (_scanOverrideIndex != -1) then {
			_locationData = CRA_LOCATION_SCAN_OVERRIDE#_scanOverrideIndex#1;
			_locationBaseGenerics = CRA_LOCATION_SCAN_OVERRIDE#_scanOverrideIndex#2;
			{_locationBaseBuildings pushBack [[CRQ_VEC_HOUSE,[_x#0]],_x#1];} forEach (CRA_LOCATION_SCAN_OVERRIDE#_scanOverrideIndex#3);
		} else {
			_locationData = CRA_LOCATION_SCAN#_scanTypeIndex#1;
		};
		if (_locationBaseGenerics isEqualTo []) then {_locationBaseGenerics = CRA_LOCATION_SCAN#_scanTypeIndex#2;};
		if (_locationBaseBuildings isEqualTo []) then {_locationBaseBuildings = _houseBases#_scanTypeIndex;};
		
		_locationData params ["_locationType", "_locationName", "_locationLabel","_locationVec","_locationSize","_locationBasePref"];
		(_locationBasePref call CRQ_ByteDecode) params ["_baseGeneric", "_baseBuilding"];
		private _locationBaseTypes = [];
		if (_baseGeneric) then {_locationBaseTypes pushBack _locationBaseGenerics;};
		if (_baseBuilding) then {_locationBaseTypes append _locationBaseBuildings;};
		_locationBaseTypes = _locationBaseTypes call CRQ_ArrayRandomize;
		if (!_baseGeneric) then {_locationBaseTypes pushBack _locationBaseGenerics;};
		private _locationRadius = if (_locationSize isEqualTo []) then {selectMax (size _scanLocation)} else {selectMax _locationSize};
		private _scanVec = [];
		if (_locationVec isEqualTo []) then {
			_scanVec = [locationPosition _scanLocation, 0];
		} else {
			[[locationPosition _scanLocation, 0], _locationRadius, 0] call CRQ_VecUtilSetup;
			_scanVec = _locationVec call CRQ_VecUtil;
		};
		if (_locationName isEqualTo "") then {_locationName = _scanID;};
		if (_locationLabel isEqualTo "") then {_locationLabel = text _scanLocation;};
		{
			_x params ["_locationPositioning", "_locationBases"];
			[_scanVec, _locationRadius, 0] call CRQ_VecUtilSetup;
			private _vec = _locationPositioning call CRQ_VecUtil;
			if (call CRQ_VecUtilValid) exitWith {
				gRA_Locations pushBack ([_scanIndex, _locationType, _vec, _locationName, _locationLabel, _locationBases, call CRQ_VecUtilObject] call CRA_LocationGenerate);
			};
		} forEach _locationBaseTypes;
	} forEach (_scanTypes call CRQ_WorldLocations);
	call CRA_LocationRoadblockInit;
	call CRA_LocationOutpostInit;
};
CRA_LocationGenerate = {
	params ["_index", "_type", "_vec", "_name", "_label", "_base", "_anchor"];
	(CRA_LOCATION_TYPES#_type) params ["_locationData", "_locationBaseData"];
	_locationData params ["_config", "_value", "_capture", "_personnel", "_markerTypes", "_locationType"];
	if (_base isEqualTo []) then {_base = _locationBaseData#1;};
	(CRA_BASE_INDEX#(selectRandom _base)) params ["_baseData", "_baseInst", "_baseProp", "_basePersonnel"];
	
	private _location = createLocation [_locationType, _vec#0, _baseData#0, _baseData#0];
	_location setName _name;
	_location setText _label;
	
	_location setVariable [CRA_VAR_LOCATION_BASE_VEC, _vec];
	_location setVariable [CRA_VAR_LOCATION_OWNER, -1];
	_location setVariable [CRA_VAR_LOCATION_STATE, CRA_STATE_INIT];
	_location setVariable [CRA_VAR_LOCATION_ENGAGED, false];
	_location setVariable [CRA_VAR_LOCATION_CAPTURED, false];
	
	_location setVariable [CRA_VAR_LOCATION_INDEX, _index];
	
	(_config call CRQ_ByteDecode) params ["_announce"];
	_location setVariable [CRA_VAR_LOCATION_ANNOUNCE, _announce];
	
	_location setVariable [CRA_VAR_LOCATION_VALUE, _value];
	_location setVariable [CRA_VAR_LOCATION_CAPTUREABLE, _capture];
	_location setVariable [CRA_VAR_LOCATION_STRENGTH, _personnel#0];
	
	_location setVariable [CRA_VAR_LOCATION_MARKER_TYPES, _markerTypes];
	_location setVariable [CRA_VAR_LOCATION_MARKER, if (_markerTypes isNotEqualTo []) then {createMarker [_name, _vec#0]} else {""}];
	
	{if (!_x) then {_baseInst set [_forEachIndex, ['',[-1,[]],-1]];};} forEach ((_locationBaseData#0) call CRQ_ByteDecode);
	_location setVariable [CRA_VAR_LOCATION_BASE_INST, [_vec, _baseInst] call CRQ_PropRasterize];
	if (isNull _anchor) then {
		_location setVariable [CRA_VAR_LOCATION_BASE_CLUTTER, [_vec#0, _baseData#0] call CRQ_WorldClutter];
		_location setVariable [CRA_VAR_LOCATION_BASE_PROP, [_vec, _baseProp] call CRQ_PropRasterize];
	} else {
		_location setVariable [CRA_VAR_LOCATION_BASE_CLUTTER, [_vec#0, _baseData#0, [_anchor]] call CRQ_WorldClutter];
		private _prop = [];
		{if (_forEachIndex > 0) then {_prop pushBack _x};} forEach _baseProp;
		_location setVariable [CRA_VAR_LOCATION_BASE_PROP, [_vec, _prop] call CRQ_PropRasterize];
	};
	
	private _personnelTypes = [];
	private _personnelCount = [0,0,0,0];
	private _waypointTypes = CRA_LOCATION_PERSONNEL_WP#_type;
	private _waypointCount = [];
	{_waypointCount pushBack (count _x);} forEach _waypointTypes;
	{
		private _roleIndex = _x#0#0;
		private _waypoints = +(_x#1);
		for [{private _i = count (_x#1)},{_i < (_waypointCount#_roleIndex)},{_i = _i + 1}] do {_waypoints pushBack (_waypointTypes#_roleIndex#_i);};
		_personnelTypes pushBack [_x#0, [_vec, _waypoints] call CRQ_PosRasterize];
		[_personnelCount, _roleIndex, 1] call CRQ_ArrayIncrement;
	} forEach _basePersonnel;
	{
		for [{private _i = _x},{_i < (_personnel#1#_forEachIndex)},{_i = _i + 1}] do {
			_personnelTypes pushBack [CRA_PERSONNEL_TYPES#_forEachIndex, [_vec, _waypointTypes#_forEachIndex] call CRQ_PosRasterize];
		};
	} forEach _personnelCount;
	_location setVariable [CRA_VAR_LOCATION_BASE_PERSONNEL, _personnelTypes];
	_location
};
CRA_LocationBaseRadioLoop = {
	if ((gT_Now - (_this getVariable [CRA_VAR_LOCATION_RADIO_START, gT_Now])) > (_this getVariable [CRA_VAR_LOCATION_RADIO_LENGTH, 1])) then {_this call CRA_LocationBaseRadioNext;};
};
CRA_LocationBaseRadioNext = {
	private _radio = _this getVariable [CRA_VAR_LOCATION_UNIT_INST_RADIO, objNull];
	if (_radio isNotEqualTo objNull) then {
		private _index = _this getVariable [CRA_VAR_LOCATION_RADIO_TRACK, -1];
		_index = (_index + 1) % (count CRA_BASE_RADIO_TRACKS);
		private _track = (CRA_BASE_RADIO_TRACKS#_index);
		// binding sound to object does not cause sound to be stopped when object deleted
		playSound3D [getMissionPath (_track#0), objNull, false, getPosASL _radio, _track#2,_track#3, CRA_BASE_RADIO_RANGE];
		_this setVariable [CRA_VAR_LOCATION_RADIO_TRACK, _index];
		_this setVariable [CRA_VAR_LOCATION_RADIO_START, gT_Now];
		_this setVariable [CRA_VAR_LOCATION_RADIO_LENGTH, (_track#1) + CRA_BASE_RADIO_GRACE];
	};
};
CRA_LocationBaseLights = {
	params ["_location", "_state"];
	private _fire = _location getVariable [CRA_VAR_LOCATION_UNIT_INST_FIRE, objNull];
	if (_fire isNotEqualTo objNull) then {_fire inflame _state;};
};
CRA_LocationBaseSpawn = {
	{_x hideObjectGlobal true;} forEach (_this getVariable [CRA_VAR_LOCATION_BASE_CLUTTER, []]);
	{_this setVariable [_x#1, (_this getVariable [_x#0, []]) call CRQ_PropSpawn];} forEach [[CRA_VAR_LOCATION_BASE_PROP,CRA_VAR_LOCATION_UNIT_PROP],[CRA_VAR_LOCATION_BASE_INST,CRA_VAR_LOCATION_UNIT_INST]];
	private _installations = _this getVariable [CRA_VAR_LOCATION_UNIT_INST, CRA_BASE_INST_EMPTY];
	_this setVariable [CRA_VAR_LOCATION_UNIT_INST_MAP, _installations#0];
	_this setVariable [CRA_VAR_LOCATION_UNIT_INST_BOX, _installations#1];
	_this setVariable [CRA_VAR_LOCATION_UNIT_INST_BOX_AUX, _installations#2];
	_this setVariable [CRA_VAR_LOCATION_UNIT_INST_RADIO, _installations#3];
	_this setVariable [CRA_VAR_LOCATION_UNIT_INST_FIRE, _installations#4];
	_this setVariable [CRA_VAR_LOCATION_UNIT_INST_GATE, _installations#5];
};
CRA_LocationBaseDespawn = {
	_this setVariable [CRA_VAR_LOCATION_UNIT_INST_MAP, objNull];
	_this setVariable [CRA_VAR_LOCATION_UNIT_INST_BOX, objNull];
	_this setVariable [CRA_VAR_LOCATION_UNIT_INST_BOX_AUX, objNull];
	_this setVariable [CRA_VAR_LOCATION_UNIT_INST_RADIO, objNull];
	_this setVariable [CRA_VAR_LOCATION_UNIT_INST_FIRE, objNull];
	_this setVariable [CRA_VAR_LOCATION_UNIT_INST_GATE, objNull];
	{(_this getVariable [_x, []]) call CRQ_PropDespawn; _this setVariable [_x, []];} forEach [CRA_VAR_LOCATION_UNIT_INST,CRA_VAR_LOCATION_UNIT_PROP];
	{_x hideObjectGlobal false;} forEach (_this getVariable [CRA_VAR_LOCATION_BASE_CLUTTER, []]);
};
CRA_LocationActionCreate = {
	private _index = _this getVariable [CRA_VAR_LOCATION_INDEX, -1];
	private _map = _this getVariable [CRA_VAR_LOCATION_UNIT_INST_MAP, objNull];
	private _box = _this getVariable [CRA_VAR_LOCATION_UNIT_INST_BOX, objNull];
	if (_index != -1) then {
		[_map, "Teleport", [CRA_ACTION_ID_PLAYER_TELEPORT]] call CRA_ActionRelayAdd;
		[_map, "Train Militia", [CRA_ACTION_ID_MILITIA_TRAIN]] call CRA_ActionRelayAdd;
		[_box, "Unload, Repack, Sort", [CRA_ACTION_ID_INVENTORY_SORT, _index]] call CRA_ActionRelayAdd;
		[_box, format ["Gather Items (%1m)", CRA_BASE_GATHER_RANGE], [CRA_ACTION_ID_INVENTORY_GATHER, _index, CRA_BASE_GATHER_RANGE]] call CRA_ActionRelayAdd;
	};
};
CRA_LocationActionRemove = {
	{(_this getVariable [_x, objNull]) call CRQ_ActionRemoveAll;} forEach [CRA_VAR_LOCATION_UNIT_INST_MAP, CRA_VAR_LOCATION_UNIT_INST_BOX];
};
CRA_LocationInventoryInit = {
	_this setVariable [CRA_VAR_LOCATION_INVENTORY, [[(floor (-0.5 + random 2)) call CRA_ItemLevel, [CRA_INDEX_WEAPON_ALL]] call CRA_Item, false, false] call CRA_ItemWeaponRasterize];
};
CRA_LocationInventorySave = {
	private _box = _this getVariable [CRA_VAR_LOCATION_UNIT_INST_BOX, objNull];
	if (!isNull _box) then {_this setVariable [CRA_VAR_LOCATION_INVENTORY, _box call CRQ_InventoryBox];};
};
CRA_LocationInventoryLoad = {
	private _box = _this getVariable [CRA_VAR_LOCATION_UNIT_INST_BOX, objNull];
	if (!isNull _box) then {
		_box call CRQ_InventoryBoxClear;
		[_box, _this getVariable [CRA_VAR_LOCATION_INVENTORY, [[[],[],[]],[]]]] call CRQ_InventoryBoxAppend;
	};
};
CRA_LocationInventorySort = {
	private _box = _this getVariable [CRA_VAR_LOCATION_UNIT_INST_BOX, objNull];
	if (!isNull _box) then {_box call CRQ_InventoryBoxOrganize;};
};
CRA_LocationInventoryGather = {
	params ["_location", "_range"];
	private _items = [];
	private _mags = [];
	private _weapons = [];
	private _containers = [];
	private _pos = (_location getVariable [CRA_VAR_LOCATION_BASE_VEC, [[]]])#0;
	private _box = _location getVariable [CRA_VAR_LOCATION_UNIT_INST_BOX, objNull];
	if ((_pos isNotEqualTo []) && !isNull _box) then {
		{
			if (_x isKindOf "Man") then {
				if (!alive _x) then {
					private _inventory = [_x, true, false] call CRQ_InventoryUnit;
					_items append (_inventory#0#0);
					_mags append (_inventory#0#1);
					_weapons append (_inventory#0#2);
					_containers append (_inventory#1);
					[_x, _x call CRQ_UnitLoadoutBlank] call CRQ_SetLoadout;
				};
			} else {
				private _inventory = _x call CRQ_InventoryBox;
				_items append (_inventory#0#0);
				_mags append (_inventory#0#1);
				_weapons append (_inventory#0#2);
				_containers append (_inventory#1);
				deleteVehicle _x;
			};
		} forEach (nearestObjects [_pos, ["Man", "WeaponHolderSimulated", "GroundWeaponHolder"], _range]);
		[_box, [[_items, _mags, _weapons], _containers]] call CRQ_InventoryBoxAppend;
	};
	[count _items, count _mags, count _weapons, count _containers]
};
CRA_LocationMarkerState = {
	private _marker = _this getVariable [CRA_VAR_LOCATION_MARKER, ""];
	if (_marker isNotEqualTo "") then {
		private _state = _this getVariable [CRA_VAR_LOCATION_STATE, -1];
		private _owner = _this getVariable [CRA_VAR_LOCATION_OWNER, -1];
		private _types = _this getVariable [CRA_VAR_LOCATION_MARKER_TYPES, []];
		if (_owner != -1 && _types isNotEqualTo []) then {_marker setMarkerType (_types#_owner);};
		if (_state != -1) then {_marker setMarkerAlpha (CRA_ALPHA_STATE#_state);};
	};
};
CRA_LocationPersonnelSpawn = {
	private _owner = _this getVariable [CRA_VAR_LOCATION_OWNER, -1];
	private _factions = switch (_owner) do {
		case CRQ_SIDE_OPFOR: {CRA_FACTION_OPFOR#(floor (gRA_PlayerProgress * (count CRA_FACTION_OPFOR)))};
		case CRQ_SIDE_IDFOR: {CRA_FACTION_IDFOR#(floor (gRA_PlayerProgress * (count CRA_FACTION_IDFOR)))};
		default {[]};
	};
	private _faction = (_factions#1) selectRandomWeighted (_factions#0);
	private _strength = _this getVariable [CRA_VAR_LOCATION_STRENGTH, [1.00,1.00]];
	private _groups = [];
	private _units = [];
	private _vehicles = [];
	{
		(_x#0) params ["_role", "_count", "_args"];
		private _group = grpNull;
		switch (_role) do {
			case CRA_ROLE_GUARD: {
				if (_count < 0) then {_count = -(_count) * (_strength#0) * CRA_ROLE_STRENGTH_GUARD;};
				_group = _owner call CRQ_GroupCreate;
				_units append ([_group, selectRandom (_x#1), [_faction, _count, _args] call CRA_UnitList] call CRA_GroupPopulate);
			};
			case CRA_ROLE_PATROL: {
				if (_count < 0)  then {_count = -(_count) * (_strength#1) * CRA_ROLE_STRENGTH_PATROL;};
				_group = _owner call CRQ_GroupCreate;
				_units append ([_group, selectRandom (_x#1), [_faction, _count, _args] call CRA_UnitList] call CRA_GroupPopulate);
			};
			case CRA_ROLE_VEHICLE: {
				private _vehicleTypes = gRA_VehicleArmed#(call CRA_ItemLevel)#(_args#0)#_owner;
				if (_vehicleTypes isNotEqualTo []) then {
					_group = _owner call CRQ_GroupCreate;
					private _vehicle = [selectRandom _vehicleTypes, [selectRandom (_x#1), random 360], [_group, [1,1,1,0]]] call CRA_VehicleCreate;
					_vehicles pushBack _vehicle;
					_units append (units _group);
				};
			};
			case CRA_ROLE_STATIC: {
				private _staticTypes = gRA_Statics#(call CRA_ItemLevel)#(_args#0)#_owner;
				if (_staticTypes isNotEqualTo []) then {
					private _baseDir = (_this getVariable [CRA_VAR_LOCATION_BASE_VEC, [[],0]])#1;
					_group = _owner call CRQ_GroupCreate;
					_vehicles pushBack ([selectRandom _staticTypes, [selectRandom (_x#1), _baseDir + (_args#1)], [_group, [1,1,1,0]]] call CRA_VehicleCreate);
					_units append (units _group);
				};
			};
			default {};
		};
		_groups pushBack _group;
	} forEach (_this getVariable [CRA_VAR_LOCATION_BASE_PERSONNEL, []]);
	_this setVariable [CRA_VAR_LOCATION_GROUP_PERSONNEL, _groups];
	_this setVariable [CRA_VAR_LOCATION_UNIT_PERSONNEL, _units];
	_this setVariable [CRA_VAR_LOCATION_COUNT_PERSONNEL, count _units];
	_this setVariable [CRA_VAR_LOCATION_UNIT_VEHICLE, _vehicles];
	_this setVariable [CRA_VAR_LOCATION_COUNT_VEHICLE, count _vehicles];
};
CRA_LocationPersonnelClear = {
	_this setVariable [CRA_VAR_LOCATION_HIBERNATE_GROUPS, []];
	_this setVariable [CRA_VAR_LOCATION_HIBERNATE_UNITS, []];
	_this setVariable [CRA_VAR_LOCATION_HIBERNATE_VEHICLES, []];
	{
		if (!isNull _x) then {
			_x setVariable [CRA_VAR_VEHICLE_ALLOW_ABANDON, true];
			_x setVariable [CRA_VAR_VEHICLE_ALLOW_HIBERNATE, true];
			gRA_Vehicles pushBack _x;
		};
	} forEach (_this getVariable [CRA_VAR_LOCATION_UNIT_VEHICLE, []]);
	_this setVariable [CRA_VAR_LOCATION_UNIT_VEHICLE, []];
	_this setVariable [CRA_VAR_LOCATION_COUNT_PERSONNEL, 0];
};
CRA_LocationPersonnelDespawn = {
	{if (!isNull _x) then {_x call CRQ_VehicleDelete;};} forEach (_this getVariable [CRA_VAR_LOCATION_UNIT_VEHICLE, []]);
	{if (!isNull _x) then {_x call CRQ_UnitDelete;};} forEach (_this getVariable [CRA_VAR_LOCATION_UNIT_PERSONNEL, []]);
	{if (!isNull _x) then {deleteGroup _x;};} forEach (_this getVariable [CRA_VAR_LOCATION_GROUP_PERSONNEL, []]);
	_this setVariable [CRA_VAR_LOCATION_UNIT_VEHICLE, []];
	_this setVariable [CRA_VAR_LOCATION_UNIT_PERSONNEL, []];
	_this setVariable [CRA_VAR_LOCATION_GROUP_PERSONNEL, []];
};
CRA_LocationPersonnelOrders = {
	private _data = _this getVariable [CRA_VAR_LOCATION_BASE_PERSONNEL, []];
	{
		if (!isNull _x) then {
			[_x, 4, 0] call CRQ_GroupMode;
			switch (_data#_forEachIndex#0#0) do {
				case CRA_ROLE_GUARD: {[_x, _data#_forEachIndex#1] call CRQ_GroupWaypointsInfantryGarrison;};
				case CRA_ROLE_PATROL: {[_x, _data#_forEachIndex#1] call CRQ_GroupWaypointsInfantryPatrol;};
				case CRA_ROLE_VEHICLE: {[_x, _data#_forEachIndex#1] call CRQ_GroupWaypointsVehiclePatrol;};
				default {};
			};
		};
	} forEach (_this getVariable [CRA_VAR_LOCATION_GROUP_PERSONNEL, []]);
};
CRA_LocationPersonnelLoop = {
	private _units = _this getVariable [CRA_VAR_LOCATION_UNIT_PERSONNEL, []];
	private _vehicles = _this getVariable [CRA_VAR_LOCATION_UNIT_VEHICLE, []];
	private _groups = _this getVariable [CRA_VAR_LOCATION_GROUP_PERSONNEL, []];
	if (_units isNotEqualTo []) then {
		private _removeUnit = [];
		{if (!isNull _x && {!alive _x}) then {_x call CRQ_CorpseRegister; _removeUnit pushBack _forEachIndex;};} forEach _units;
		reverse _removeUnit;
		{_units set [_x, objNull];} forEach _removeUnit;
		_this setVariable [CRA_VAR_LOCATION_UNIT_PERSONNEL, _units];
	};
	if (_vehicles isNotEqualTo []) then {
		private _removeVehicle = [];
		{if (!isNull _x && {!alive _x}) then {_x call CRQ_WreckRegister; _removeVehicle pushBack _forEachIndex;};} forEach _vehicles;
		reverse _removeVehicle;
		{_vehicles set [_x, objNull];} forEach _removeVehicle;
		_this setVariable [CRA_VAR_LOCATION_UNIT_VEHICLE, _vehicles];
	};
	if (_groups isNotEqualTo []) then {
		private _removeGroup = [];
		{if (!isNull _x && {units _x isEqualTo []}) then {deleteGroup _x; _removeGroup pushBack _forEachIndex;};} forEach _groups;
		reverse _removeGroup;
		{_groups set [_x, grpNull];} forEach _removeGroup;
		_this setVariable [CRA_VAR_LOCATION_GROUP_PERSONNEL, _groups];
	};
};
CRA_UnitSkill = {
	private _skill = gRA_ProgressEnemySkillBase * (gRA_ProgressEnemySkillVarianceBase + random gRA_SettingProgressEnemySkillVariance);
	if (_skill > 1) then {_skill = 1;};
	_skill
};
CRA_GroupPopulate = {
	private _units = [];
	params ["_group", "_basePos", "_types"];
	private _posZ = if (count _basePos > 2) then {_basePos#2} else {0};
	{
		private _pos = [(_basePos#0) - 2.5 + random 5, (_basePos#1) - 2.5 + random 5, _posZ];
		_units pushBack ([_group, _x#0, [_pos, random 360], _x call CRA_UnitLoadoutGenerate, call CRA_UnitIdentity, call CRA_UnitSkill] call CRQ_UnitCreate);
	} forEach _types;
	_units
};
CRA_UnitList = {
	params ["_faction", "_count","_args"];
	private _leader = [];
	private _squad = [];
	switch (_faction) do {
		case CRA_FACTION_OPFOR_ARMY: {
			switch (_args#0) do { // specops, recon, diver, etc...
				default {
					_leader = CRA_SQUAD_ARMY_LEADER;
					_squad = CRA_SQUAD_ARMY;
				};
			};
		};
		case CRA_FACTION_IDFOR_LOOTER: {
			switch (_args#0) do {
				default {
					_leader = CRA_SQUAD_LOOTER_LEADER;
					_squad = CRA_SQUAD_LOOTER;
				};
			};
		};
		case CRA_FACTION_IDFOR_CARTEL: {
			switch (_args#0) do {
				default {
					_leader = CRA_SQUAD_CARTEL_LEADER;
					_squad = CRA_SQUAD_CARTEL;
				};
			};
		};
		default {};
	};
	_count = round (_count * gRA_ProgressEnemyCountBase * (call CRA_ProgressEnemyCountPlayerFactor) * (gRA_ProgressEnemyCountVarianceBase + random gRA_SettingProgressEnemyCountVariance));
	if (_count < 1) then {_count = 1;};
	private _unit = selectRandom _leader;
	private _weapons = _unit call CRA_UnitWeapon;
	if (count _weapons < 1) then {
		_unit = _leader#0;
		_weapons = _unit call CRA_UnitWeapon;
	};
	private _units = [[_unit, _weapons]];
	for [{private _i = 1;}, {_i < _count;}, {_i = _i + 1;}] do {
		_unit = selectRandom ((_squad#1) selectRandomWeighted (_squad#0));
		_weapons = _unit call CRA_UnitWeapon;
		if (count _weapons < 1) then {
			_unit = selectRandom (_squad#1#0);
			_weapons = _unit call CRA_UnitWeapon;
		};
		_units pushBack [_unit, _weapons];
	};
	_units
};
CRA_CivilianLoop = {
	private _countPlayers = count gRA_PlayerPos;
	if (_countPlayers > 0) then {
		if (gRA_PathAvailable) then {
			if (!([gRA_PathPos, CRA_PATHGENERATOR_RADIUS] call CRA_PlayerInRange)) then {
				gRA_PathResult = [];
				gRA_PathAvailable = false;
			};
		} else {
			if (gRA_PathResult isEqualTo []) then {
				if (isNull gRA_PathHandle) then {
					gRA_PathPlayer = (gRA_PathPlayer + 1) % _countPlayers;
					gRA_PathPos = gRA_PlayerPos#gRA_PathPlayer;
					gRA_PathHandle = [gRA_PathPos, CRA_PATHGENERATOR_RADIUS, gRA_PlayerEnter] spawn CRA_PathGen;
				};
			} else {
				private _length = count gRA_PathResult;
				if (_length < 1 || {((getRoadInfo (gRA_PathResult#0))#8) || {((getRoadInfo (gRA_PathResult#(_length - 1)))#8)}}) then {gRA_PathResult = [];} else {gRA_PathAvailable = true;};
			};
		};
	};
	
	private _remove = [];
	{
		private _forceDespawn = false;
		
		private _units = [];
		private _corpses = [];
		{if (alive _x) then {_units pushBack _x;} else {_corpses pushBack _x;};} forEach (units _x);
		
		private _disembark = false;
		private _vehicle = _x getVariable [CRA_VAR_GROUP_VEHICLE, objNull];
		if (_vehicle isEqualType objNull) then {
			if (isNull _vehicle) exitWith {_forceDespawn = true;};
			
			{if ((objectParent _x) isNotEqualTo _vehicle) exitWith {_disembark = true;};} forEach _units;
			
			{if ((alive _x) && {_units find _x == -1}) exitWith {_disembark = true;};} forEach (crew _vehicle);
			/*
			private _alighted = true;
			{if ((objectParent _x) isEqualTo _vehicle) exitWith {_alighted = false;};} forEach _units;
			if (_alighted) exitWith {_disembark = true;};
			
			private _hijacked = false;
			{if ((alive _x) && {_units find _x == -1}) exitWith {_hijacked = true;};} forEach (crew _vehicle);
			if (_hijacked) exitWith {_disembark = true;};
			*/
			private _path = _x getVariable [CRA_VAR_GROUP_VEHICLE_PATH, []]; // TODO extend destination, waypoints, etc...
			private _pathLast = (count _path) - 1;
			private _destination = _path#_pathLast;
			private _posDestination = _destination call CRQ_Pos2D;
			if (_vehicle distance2D _posDestination > CRA_CIVILIAN_DESTINATION) exitWith {};
			
			private _extend = [];
			private _exclude = [_path#(_pathLast - 1)];
			private _counter = 0;
			private _max = count CRA_CIVILIAN_EXTENSIONS;
			while {_extend isEqualTo [] && {_counter < _max}} do {
				_extend = [_destination, _exclude, _posDestination, CRA_CIVILIAN_EXTENSIONS#_counter] call CRA_PathRoad;
				//_extend = [_destination, _path, _posDestination, CRA_CIVILIAN_EXTENSIONS#_counter] call CRA_PathRoad;
				_counter = _counter + 1;
			};
			_counter = 0;
			while {_extend isEqualTo [] && {_counter < _max}} do {
				_extend = [_destination, [], _posDestination, CRA_CIVILIAN_EXTENSIONS#_counter] call CRA_PathRoad;
				_counter = _counter + 1;
			};
			
			if (_extend isEqualTo []) exitWith {_disembark = true;};
			_x call CRQ_GroupWaypointsClear;
			[_x, _extend call CRA_PathWaypoints] call CRQ_GroupWaypointsVehicleTravel;
			_x setVariable [CRA_VAR_GROUP_VEHICLE_PATH, _extend];
		} else {
			// TODO hibernated vehicle
		};
		if (_disembark) then {
			_x leaveVehicle _vehicle;
			_x setVariable [CRA_VAR_GROUP_VEHICLE, objNull];
			_vehicle setVariable [CRA_VAR_VEHICLE_ALLOW_ABANDON, true];
			_vehicle setVariable [CRA_VAR_VEHICLE_ALLOW_HIBERNATE, true];
			_vehicle setVariable [CRA_VAR_VEHICLE_GROUP, grpNull];
			_vehicle = objNull;
		};
		
		private _unitsInRange = [];
		private _unitsDelete = [];
		if (_forceDespawn) then {
			{_unitsDelete pushBack _x;} forEach _units;
		} else {
			{if ([_x call CRQ_Pos2D, gRA_PlayerLeave] call CRA_PlayerInRange) then {_unitsInRange pushBack _x;} else {_unitsDelete pushBack _x;};} forEach _units;
		};
		
		
		if (_unitsInRange isNotEqualTo []) then {
			{_x call CRQ_CorpseRegister;} forEach _corpses;
			{_x call CRQ_UnitDelete;} forEach _unitsDelete;
		} else {
			if (_vehicle isEqualType objNull && {!isNull _vehicle}) then {_vehicle call CRQ_VehicleDelete;};
			{_x call CRQ_CorpseRegister;} forEach _corpses;
			{_x call CRQ_UnitDelete;} forEach _unitsDelete;
			deleteGroup _x;
			_remove pushBack _forEachIndex;
		};
	} forEach gRA_Civilians;
	reverse _remove;
	{gRA_Civilians deleteAt _x;} forEach _remove;
	
	if (gRA_PathAvailable && {(count gRA_Civilians) < gRA_SettingCivilianVehicleCount}) then {
		call CRA_CivilianCarSpawn;
		gRA_PathResult = [];
		gRA_PathAvailable = false;
	};
};
CRA_CivilianCarSpawn = {
	private _roadLast = (count gRA_PathResult) - 1;
	private _vec = [(gRA_PathResult#0) call CRQ_Pos2D, (gRA_PathResult#0) getDir (gRA_PathResult#1)];
	if (([_vec#0, CRA_CIVILIAN_SPAWN_CLEARANCE] call CRQ_VehiclesFind) isNotEqualTo []) exitWith {};
	private _group = CRQ_SIDE_CIVFOR call CRQ_GroupCreate;
	
	private _vehicle = [selectRandom (gRA_VehicleUnarmed#CRA_VEHICLE_CAR#CRQ_SIDE_CIVFOR), _vec, [_group, [1,-1,-1,-1]]] call CRA_VehicleCreate;
	
	[_group, gRA_PathResult call CRA_PathWaypoints] call CRQ_GroupWaypointsVehicleTravel;
	
	_vehicle setVariable [CRA_VAR_VEHICLE_GROUP, _group];
	_vehicle setVariable [CRA_VAR_VEHICLE_ALLOW_ABANDON, false];
	_vehicle setVariable [CRA_VAR_VEHICLE_ALLOW_HIBERNATE, false];
	gRA_Vehicles pushBack _vehicle;
	
	[_group, 4, 0] call CRQ_GroupMode;
	_group setVariable [CRA_VAR_GROUP_VEHICLE, _vehicle];
	_group setVariable [CRA_VAR_GROUP_VEHICLE_PATH, gRA_PathResult];
	gRA_Civilians pushBack _group;
};
