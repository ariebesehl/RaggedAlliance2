
#define CRQ_DEFINE_SERVER 1

#include "CRQ__Server.sqf"

#include "CRQ_Shared.sqf"

#include "..\CQM\CQM_Server.sqf"

addMissionEventHandler ["HandleDisconnect", {_this call CRQ_ClientDisconnect; false}];
addMissionEventHandler ["EntityRespawned", {_this call CRQ_ClientRespawn;}];

gCS_SettingDaytimeHour = ["CRQ_MissionTimeStartHour", 13] call BIS_fnc_getParamValue;
gCS_SettingDaytimeMinute = ["CRQ_MissionTimeStartMinute", 37] call BIS_fnc_getParamValue;
gCS_SettingCorpseDecay = ["CRQ_CorpseDecay", 600] call BIS_fnc_getParamValue;
gCS_SettingCorpseCount = ["CRQ_CorpseCount", 180] call BIS_fnc_getParamValue;
gCS_SettingWreckDecay = ["CRQ_WreckDecay", 600] call BIS_fnc_getParamValue;
gCS_SettingWreckCount = ["CRQ_WreckCount", 30] call BIS_fnc_getParamValue;

gCS_SyncArrays = missionNamespace getVariable ["gCS_SyncArrays", []];

gCS_Now = missionNamespace getVariable ["gCS_Now", 0];
gCS_LoopTimer = missionNamespace getVariable ["gCS_LoopTimer", []];
gCS_LoopResolution = missionNamespace getVariable ["gCS_LoopDelay", CRQ_LOOP_RESOLUTION];

gCS_Lights = missionNamespace getVariable ["gCS_Lights", false];
gCS_DaytimeNow = missionNamespace getVariable ["gCS_DaytimeNow", 0];
gCS_DaytimeStart = missionNamespace getVariable ["gCS_DaytimeStart", 0];
gCS_DaytimeTimer = missionNamespace getVariable ["gCS_DaytimeTimer", []];
gCS_Broadcast = missionNamespace getVariable ["gCS_Broadcast", if (isDedicated) then {-2} else {0}];
gCS_Action = missionNamespace getVariable ["gCS_Action", []];
gCS_Corpse = missionNamespace getVariable ["gCS_Corpse", []];
gCS_CorpseGroup = missionNamespace getVariable ["gCS_CorpseGroup", grpNull];
gCS_CorpseCount = missionNamespace getVariable ["gCS_CorpseCount", gCS_SettingCorpseCount];
gCS_CorpseDecay = missionNamespace getVariable ["gCS_CorpseDecay", gCS_SettingCorpseDecay];
gCS_CorpseDelete = missionNamespace getVariable ["gCS_CorpseDelete", gCS_SettingCorpseDecay + CRQ_CORPSE_DELETE];
gCS_CorpseExpedite = missionNamespace getVariable ["gCS_CorpseExpedite", gCS_SettingCorpseDecay * CRQ_CORPSE_EXPEDITE];
gCS_Wreck = missionNamespace getVariable ["gCS_Wreck", []];
gCS_WreckCount = missionNamespace getVariable ["gCS_WreckCount", gCS_SettingWreckCount];
gCS_WreckDecay = missionNamespace getVariable ["gCS_WreckDecay", gCS_SettingWreckDecay];

gCS_GarbageCollector = missionNamespace getVariable ["gCS_GarbageCollector", scriptNull];

CRQ_SyncArrayCRCFull = {
	params ["_name", "_array"];
	private _existing = gCS_SyncArrays findIf {_name isEqualTo (_x#0)};
	private _crc = [];
	{_crc pushBack (_x call CRQ_CRC);} forEach _array;
	if (_existing != -1) then {
		(gCS_SyncArrays#_existing) set [1, _crc call CRQ_CRC];
		(gCS_SyncArrays#_existing) set [2, _crc];
	} else {
		gCS_SyncArrays pushBack [_name, _crc call CRQ_CRC, _crc];
	};
};
CRQ_SyncArrayCRCIndex = {
	params ["_name", "_index", "_data"];
	private _existing = gCS_SyncArrays findIf {_name isEqualTo (_x#0)};
	if (_existing == -1) exitWith {};
	(gCS_SyncArrays#_existing#2) set [_index, _data call CRQ_CRC];
	(gCS_SyncArrays#_existing) set [1, (gCS_SyncArrays#_existing#2) call CRQ_CRC];
};

CRQ_SyncArrayClear = {
	params ["_name", ["_target", gCS_Broadcast]];
	[_name] remoteExec ["CRQ_LocalSyncArrayClear", _target];
};
CRQ_SyncArrayIndex = {
	params ["_name", "_index", "_data", ["_target", gCS_Broadcast]];
	[_name, _index, _data] remoteExec ["CRQ_LocalSyncArrayIndex", _target];
};
CRQ_SyncArrayFull = {
	params ["_name", "_array", ["_target", gCS_Broadcast]];
	[_name] remoteExec ["CRQ_LocalSyncArrayClear", _target];
	_this spawn {
		params ["_name", "_array", ["_target", gCS_Broadcast]];
		{[_name, _forEachIndex, _x] remoteExec ["CRQ_LocalSyncArrayIndex", _target]; sleep 0.005;} forEach _array;
	};
};

CRQ_ActionRemoveAll = {
	if (_this isEqualTo objNull) exitWith {};
	[_this] remoteExec ["removeAllActions", gCS_Broadcast];
	private _remove = [];
	{if (_this == (_x#0)) then {_remove pushBack _forEachIndex;};} forEach gCS_Action;
	reverse _remove;
	{gCS_Action deleteAt _x;} forEach _remove;
};
CRQ_ActionAdd = {
	if ((_this#0) isEqualTo objNull) exitWith {};
	gCS_Action pushBack _this;
	[gCS_Broadcast, _this] call CRQ_ActionBroadcast;
};
CRQ_ActionBroadcast = {
	params ["_target", "_action"];
	[_action#0, _action#1] remoteExec ["addAction", _target];
};
CRQ_ActionSynchronize = {
	sleep CRQ_ACTION_SYNC;
	{[_this, _x] call CRQ_ActionBroadcast;} forEach gCS_Action;
};
CRQ_ClientConnect = { // TODO there is now getUserInfo that includes clientStateNumber and player unit
	params ["_unit", "_id", "_uid", "_name", "_jip"];
	[_unit, false] call CRQ_ClientSpawn;
	if (_jip) then {(owner _unit) spawn CRQ_ActionSynchronize;};
	_this call CQM_ClientConnect;
};
CRQ_ClientDisconnect = {
	//params ["_unit", "_id", "_uid", "_name"];
	_this call CQM_ClientDisconnect;
};
CRQ_ClientSpawn = {
	params ["_unit","_isRespawn"];
	_this call CQM_ClientSpawn;
	remoteExec ["CRQ_LocalClientSpawnResolve", owner _unit];
};
CRQ_ClientRespawn = {
	params ["_unit", "_corpse"];
	[_unit, true] call CRQ_ClientSpawn;
	_corpse setVehicleVarName "";
	_corpse call CRQ_CorpseRegister;
};
CRQ_CorpseInit = {
	gCS_CorpseGroup = CRQ_SIDE_CIVFOR call CRQ_GroupCreate;
	gCS_CorpseGroup setGroupIdGlobal [CQM_CORPSE_GROUP];
};
CRQ_CorpseRegister = {
	if ((group _this) isNotEqualTo grpNull) then {[_this] join gCS_CorpseGroup;};
	gCS_Corpse pushBack [_this, gCS_Now, true];
};
CRQ_fnc_CorpseExpedite = {
	if (isNil {_this getVariable [CRQ_SVAR_CORPSE_EXPEDITE, nil]}) then {_this setVariable [CRQ_SVAR_CORPSE_EXPEDITE, true];};
};
CRQ_fnc_CorpseLoop = {
	private _count = count gCS_Corpse;
	if (_count > gCS_CorpseCount) then {
		private _purge = [];
		{_purge pushBack [_x#1, _forEachIndex];} forEach gCS_Corpse;
		_purge sort true;
		private _timePurge = gCS_Now - gCS_CorpseDelete;
		{_x set [2, false]; _x set [1, _timePurge];} forEach ((_purge select [0, _count - gCS_CorpseCount]) apply {gCS_Corpse#(_x#1)});
	};
	private _remove = [];
	{
		_x params ["_corpse", "_timeDeath", "_visible"];
		if (_corpse getVariable [CRQ_SVAR_CORPSE_EXPEDITE, false]) then {
			_corpse setVariable [CRQ_SVAR_CORPSE_EXPEDITE, false];
			_timeDeath = _timeDeath min (gCS_Now - gCS_CorpseExpedite);
			_x set [1, _timeDeath];
		};
		if (_visible && {gCS_Now - _timeDeath >= gCS_CorpseDecay}) then {
			_x set [2, false];
			hideBody _corpse;
		};
		if (gCS_Now - _timeDeath >= gCS_CorpseDelete) then {
			_corpse call CRQ_UnitDelete;
			_remove pushBack _forEachIndex;
		};
	} forEach gCS_Corpse;
	reverse _remove;
	{gCS_Corpse deleteAt _x;} forEach _remove;
};
CRQ_WreckRegister = {
	gCS_Wreck pushBack [_this, gCS_Now];
};
CRQ_fnc_WreckLoop = {
	private _count = count gCS_Wreck;
	if (_count > gCS_WreckCount) then {
		private _purge = [];
		{_purge pushBack [_x#1, _forEachIndex];} forEach gCS_Wreck;
		_purge sort true;
		private _timePurge = gCS_Now - gCS_WreckDecay;
		{_x set [1, _timePurge];} forEach ((_purge select [0, _count - gCS_WreckCount]) apply {gCS_Wreck#(_x#1)});
	};
	private _remove = [];
	{
		_x params ["_wreck", "_timeDeath"];
		if ((gCS_Now - _timeDeath) >= gCS_WreckDecay) then {
			_wreck call CRQ_VehicleDelete;
			_remove pushBack _forEachIndex;
		};
	} forEach gCS_Wreck;
	reverse _remove;
	{gCS_Wreck deleteAt _x;} forEach _remove;
};
CRQ_fnc_GarbageCollector = {
	[] call CRQ_fnc_CorpseLoop;
	[] call CRQ_fnc_WreckLoop;
};
CRQ_ClientInit = {
	// TODO remove AI players if not explicitly disabled in description.ext
	//private _slots = playableSlotsNumber _x;
	//for [{private _i = 0}, {_i < _slots} , {_i = _i + 1}] do {};
};
CRQ_MissionTime = {
	params ["_hour", "_minute"];
	if (_hour < 0) then {
		private _min = 0;
		private _max = 23; // TODO shouldn't this be 24?
		switch (_hour) do {
			case -2: {_min = (gCS_DaytimeTimer#0); _max = (gCS_DaytimeTimer#1);};
			case -3: {_min = (gCS_DaytimeTimer#1); _max = (gCS_DaytimeTimer#2);};
			case -4: {_min = (gCS_DaytimeTimer#2); _max = (gCS_DaytimeTimer#3);};
			case -5: {_min = (gCS_DaytimeTimer#3); _max = (gCS_DaytimeTimer#4);};
			case -6: {_min = (gCS_DaytimeTimer#4); _max = (gCS_DaytimeTimer#5);};
			case -7: {_min = (gCS_DaytimeTimer#5); _max = (gCS_DaytimeTimer#0);};
			default {};
		};
		private _range = if (_min > _max) then {24 - _min + _max} else {_max - _min};
		_hour = _min + random _range;
		if (_hour > 24) then {_hour = _hour - 24};
		if (_minute >= 0) then {_hour = floor _hour;} else {_minute = 0;};
	} else {
		if (_minute < 0) then {_minute = floor (random 60);};
	};
	(_hour + (_minute / 60))
};
CRQ_DayTimer = { // TODO polar circles, [-1,0] and [0,-1]
	(date call BIS_fnc_sunriseSunsetTime) params ["_sunrise", "_sunset"];
	private _rangeNight = 24 - _sunset + _sunrise;
	private _rangeDay = _sunset - _sunrise;
	gCS_DaytimeTimer = CRQ_DAYTIME_TIMER apply {if (_x < 0) then {(_sunset + -_x * _rangeNight) % 24} else {_sunrise + _x * _rangeDay};};
};
CRQ_DayLoop = {
	private _dayTime = dayTime;
	if (_daytime < gCS_DaytimeNow) then {[] call CRQ_DayTimer;};
	if (_dayTime >= (gCS_DaytimeTimer#5) && {gCS_DaytimeNow < (gCS_DaytimeTimer#5)}) then {[] call CQM_Night;};
	if (_dayTime > (gCS_DaytimeTimer#0) && {gCS_DaytimeNow <= (gCS_DaytimeTimer#0)}) then {[] call CQM_Day;};
	gCS_DaytimeNow = _dayTime;
};
CRQ_LightsLoop = {
	if (gCS_Lights == ([] call CRQ_Lights)) exitWith {};
	if (gCS_Lights) then {[] call CQM_LightsOff; gCS_Lights = false;} else {[] call CQM_LightsOn; gCS_Lights = true;};
};

CRQ_AiInit = {
	private _skillAdjust = [];
	{
		private _bounds = getArray _x;
		if (_bounds isNotEqualTo [0,0,1,1]) then {
			_bounds params ["_minIn", "_minOut", "_maxIn", "_maxOut"];
			if (_minOut >= _maxOut) exitWith {};
			private _codeIn = if (_maxIn != 1) then {
				if (_minIn != 0) then {"(((_this select 1) max " + str _minIn + ") min " + str _maxIn + ")"} else {"((_this select 1) min " + str _maxIn + ")"};
			} else {
				if (_minIn != 0) then {"((_this select 1) max " + str _minIn + ")"} else {"(_this select 1)"};
			};
			private _codeSkill = "((" + _codeIn + " - " + str _minOut + ") max 0) * " + str (1 / (_maxOut - _minOut));
			_skillAdjust pushBack (compile ("(_this select 0) setSkill ['" + configName _x + "', " + _codeSkill + "];"));
		};
	} forEach (configProperties [configFile >> "CfgAISkill", "true", true]);
	missionNamespace setVariable ["pCQ_AiSkillAdjust", _skillAdjust, true];
};

//gCS_EnvOvercast = 0;
//gCS_EnvStamp = 0;
//gCS_EnvDelay = 0;
CRQ_EnvLoop = { // TODO
	0 setFog 0;
	0 setOvercast 0;
	/*if ((gCS_Now - gCS_EnvStamp) >= gCS_EnvDelay) then {
		gCS_EnvStamp = gCS_Now;
		gCS_EnvDelay = 7.5 + random 5;
		gCS_EnvOvercast = random 1;
		gCS_EnvDelay setOvercast gCS_EnvOvercast;
		systemChat str [gCS_EnvStamp,gCS_EnvDelay,gCS_EnvOvercast];
	};*/
};



CRQ_InitPre = {
	[] call CRQ_DayTimer;
	gCS_DaytimeStart = [gCS_SettingDaytimeHour, gCS_SettingDaytimeMinute] call CRQ_MissionTime;
	skipTime (gCS_DaytimeStart - dayTime);
	{gCS_LoopTimer pushBack [_x#0, _x#1];} forEach CRQ_LOOP_TIMER;
	[] call CRQ_ClientInit;
	[] call CRQ_AiInit;
	[] call CQM_InitPre;
};
CRQ_Init = {
	skipTime (gCS_DaytimeStart - dayTime); // TODO find out why -autoInit ignores above preInit
	[] call CRQ_CorpseInit;
	[] call CQM_Init;
	gCS_DaytimeNow = dayTime;
	gCS_Lights = call CRQ_Lights;
};
CRQ_Main = {
	[] call CRQ_InitPre;
	sleep 0.01;
	[] call CRQ_Init;
	while {true} do {
		gCS_Now = time;
		{
			_x params ["_delay", "_stamp"];
			private _elapsed = gCS_Now - _stamp;
			if (_elapsed >= _delay) then {
				_x set [1, gCS_Now - (_elapsed % _delay)];
				[] call ([CQM_Loop_0,CQM_Loop_1,CQM_Loop_2,CQM_Loop_3,CQM_Loop_4,CQM_Loop_5,CQM_Loop_6,CQM_Loop_7]#_forEachIndex);
				[] call ([{
				},{
				},{
				},{
					if (gCS_GarbageCollector isEqualTo scriptNull) then {gCS_GarbageCollector = [] spawn CRQ_fnc_GarbageCollector;};
				},{
				},{
					[] call CRQ_DayLoop;
					[] call CRQ_LightsLoop;
				},{
				},{
					[] call CRQ_EnvLoop;
				}]#_forEachIndex);
				/*switch (_forEachIndex) do {
					case 0: { // 1s
						[] call CQM_Loop_0;
					};
					case 1: { // 2s
						[] call CQM_Loop_1;
					};
					case 2: { // 4s
						[] call CQM_Loop_2;
					};
					case 3: {
						[] call CQM_Loop_3;
						if (gCS_GarbageCollector isEqualTo scriptNull) then {gCS_GarbageCollector = [] spawn CRQ_fnc_GarbageCollector;};
					};
					case 4: {
						[] call CQM_Loop_4;
					};
					case 5: {
						[] call CRQ_DayLoop;
						[] call CRQ_LightsLoop;
						[] call CQM_Loop_5;
					};
					case 6: {
						[] call CQM_Loop_6;
					};
					case 7: {
						[] call CRQ_EnvLoop;
						[] call CQM_Loop_7;
					};
					default {};
				};*/
			};		
		} forEach gCS_LoopTimer;
		sleep gCS_LoopResolution;
	};
};

[] call CRQ_Main;
