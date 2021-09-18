
#include "CRQ__Server.sqf"
#include "CRQ_Shared.sqf"

#include "..\CQM\CQM_Server.sqf"
/*
gCS_Debug = true;
#define CRQ_DEBUG(TEXT) if (gCS_Debug) then {[(TEXT)] remoteExec ["systemChat", gCS_Broadcast]};
*/
addMissionEventHandler ["PlayerConnected", {_this call CRQ_ClientConnect;}];
addMissionEventHandler ["PlayerDisconnected", {_this call CRQ_ClientDisconnect;}];
addMissionEventHandler ["HandleDisconnect", {_this call CRQ_ClientHandleDisconnect; false}];
addMissionEventHandler ["EntityRespawned", {_this call CRQ_ClientRespawn;}];

gMS_TimeStartHour = ["CRQ_MissionTimeStartHour", 13] call BIS_fnc_getParamValue;
gMS_TimeStartMinute = ["CRQ_MissionTimeStartMinute", 37] call BIS_fnc_getParamValue;
gCS_CorpseDecay = ["CRQ_CorpseDecay", 600] call BIS_fnc_getParamValue;
gCS_WreckDecay = ["CRQ_WreckDecay", 600] call BIS_fnc_getParamValue;

gCS_PlayerResolve = [];
gT_Timing = missionNamespace getVariable ["gT_Timing", []];

gT_Now = 0;
gT_Daytime = 0;
gT_Lights = false;
gMS_Start = missionNamespace getVariable ["gMS_Start", 0];
gCS_Broadcast = [0,-2] select isDedicated;
gCS_Action = [];
gCS_Corpse = [];
gCS_CorpseGroup = grpNull;
gCS_CorpseDelete = gCS_CorpseDecay + CRQ_CORPSE_DELETE;
gCS_Wreck = [];

CRQ_ActionRemoveAll = {
	if (_this isNotEqualTo objNull) then {
		[_this] remoteExec ["removeAllActions", gCS_Broadcast];
		private _remove = [];
		{if (_this == (_x#0)) then {_remove pushBack _forEachIndex;};} forEach gCS_Action;
		reverse _remove;
		{gCS_Action deleteAt _x;} forEach _remove;
	};
};
CRQ_ActionAdd = {
	if ((_this#0) isNotEqualTo objNull) then {
		gCS_Action pushBack _this;
		[gCS_Broadcast, _this] call CRQ_ActionBroadcast;
	};
};
CRQ_ActionBroadcast = {
	params ["_target", "_action"];
	[_action#0, _action#1] remoteExec ["addAction", _target];
};
CRQ_ActionSynchronize = {
	sleep CRQ_PLAYER_ACTION_SYNC_DELAY;
	{[_this, _x] call CRQ_ActionBroadcast;} forEach gCS_Action;
};
CRQ_ClientConnect = {
	gCS_PlayerResolve pushBack [_this spawn CRQ_ClientResolve, gT_Now, _this];
};
CRQ_ClientDisconnect = {
	//params ["_id", "_uid", "_name", "_jip", "_owner", "_idstr"];
	_this call CQM_ClientDisconnect;
};
CRQ_ClientHandleDisconnect = {
	//params ["_unit", "_id", "_uid", "_name"];
	_this call CQM_ClientHandleDisconnect;
};
CRQ_ClientResolve = {
	params ["_id", "_uid", "_name", "_jip", "_owner", "_idstr"];
	private _unit = objNull;
	while {true} do {
		private _players = allPlayers;
		private _index = _players findIf {owner _x isEqualTo _owner};
		if (_index != -1) exitWith {_unit = _players#_index;};
		sleep CRQ_PLAYER_RESOLVE_RESOLUTION;
	};
	_this remoteExec ["CRQ_LocalClientConnect", _owner];
	[_unit, false] call CRQ_ClientSpawn;
	if (_jip) then {_owner spawn CRQ_ActionSynchronize;};
	_this call CQM_ClientConnect;
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
CRQ_ClientLoop = {
	private _remove = [];
	{
		if ((_x#0) isEqualTo scriptNull) then {
			_remove pushBack _forEachIndex;
		} else {
			if ((gT_Now - (_x#1)) > CRQ_PLAYER_RESOLVE_TIMEOUT) then {
				terminate (_x#0);
				// TODO resolve this
				_remove pushBack _forEachIndex;
			};
		};
	} forEach gCS_PlayerResolve;
	reverse _remove;
	{gCS_PlayerResolve deleteAt _x;} forEach _remove;
};
CRQ_CorpseInit = {
	gCS_CorpseGroup = CRQ_SIDE_CIVFOR call CRQ_GroupCreate;
	gCS_CorpseGroup setGroupIdGlobal ["[CORPSES]"];
};
CRQ_CorpseRegister = {
	if (group _this isNotEqualTo grpNull) then {[_this] join gCS_CorpseGroup;};
	gCS_Corpse pushBack [_this, gT_Now, false];
};
CRQ_CorpseLoop = {
	private _remove = [];
	{
		_x params ["_corpse", "_timeDeath", "_hidden"];
		if ((gT_Now - _timeDeath) >= gCS_CorpseDecay && {!_hidden}) then {
			(gCS_Corpse#_forEachIndex) set [2, true];
			hideBody _corpse;
		};
		if ((gT_Now - _timeDeath) >= gCS_CorpseDelete) then {
			_corpse call CRQ_UnitDelete;
			_remove pushBack _forEachIndex;
		};
	} forEach gCS_Corpse;
	reverse _remove;
	{gCS_Corpse deleteAt _x;} forEach _remove;
};
CRQ_WreckRegister = {
	gCS_Wreck pushBack [_this, gT_Now, false];
};
CRQ_WreckLoop = {
	private _remove = [];
	{
		_x params ["_wreck", "_timeDeath", "_hidden"];
		if ((gT_Now - _timeDeath) >= gCS_WreckDecay) then {
			_wreck call CRQ_VehicleDelete;
			_remove pushBack _forEachIndex;
		};
	} forEach gCS_Wreck;
	reverse _remove;
	{gCS_Wreck deleteAt _x;} forEach _remove;
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
		private _max = 23;
		switch (_hour) do {
			case -2: {_min = CRQ_TIME_DAWN_MIN; _max = CRQ_TIME_DAWN_MAX;};
			case -3: {_min = CRQ_TIME_MORNING_MIN; _max = CRQ_TIME_MORNING_MAX;};
			case -4: {_min = CRQ_TIME_NOON_MIN; _max = CRQ_TIME_NOON_MAX;};
			case -5: {_min = CRQ_TIME_AFTERNOON_MIN; _max = CRQ_TIME_AFTERNOON_MAX;};
			case -6: {_min = CRQ_TIME_EVENING_MIN; _max = CRQ_TIME_EVENING_MAX;};
			case -7: {_min = CRQ_TIME_NIGHT_MIN; _max = CRQ_TIME_NIGHT_MAX;};
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
CRQ_DayLoop = {
	private _dayTime = dayTime;
	if (_dayTime >= CRQ_TIME_NIGHT_MIN && gT_Daytime < CRQ_TIME_NIGHT_MIN) then {call CQM_Night;};
	if (_dayTime > CRQ_TIME_NIGHT_MAX && gT_Daytime <= CRQ_TIME_NIGHT_MAX) then {call CQM_Day;};
	gT_Daytime = _dayTime;
};
CRQ_LightsLoop = {
	private _lights = call CRQ_Lights;
	if (gT_Lights) then {
		if (!_lights) then {gT_Lights = _lights; call CQM_LightsOff;};
	} else {
		if (_lights) then {gT_Lights = _lights; call CQM_LightsOn;};
	};
};
CRQ_InitPre = {
	gMS_Start = [gMS_TimeStartHour, gMS_TimeStartMinute] call CRQ_MissionTime;
	skipTime (gMS_Start - dayTime);
	{gT_Timing pushBack [_x#0, _x#1];} forEach CRQ_LOOP_TIMER;
	call CRQ_ClientInit;
	call CQM_InitPre;
};
CRQ_Init = {
	skipTime (gMS_Start - dayTime); // TODO find out why -autoInit ignores above preInit
	call CRQ_CorpseInit;
	call CQM_Init;
};
CRQ_Main = {
	call CRQ_InitPre;
	sleep 0.01;
	call CRQ_Init;
	gT_Daytime = dayTime;
	gT_Lights = call CRQ_Lights;
	while {true} do {
		gT_Now = time;
		{
			private _delay = _x#0;
			private _stamp = _x#1;
			private _elapsed = gT_Now - _stamp;
			if (_delay <= _elapsed) then {
				_x set [1, gT_Now - (_elapsed % _delay)];
				switch (_forEachIndex) do {
					case 0: { // 1s
						call CQM_Loop_0;
					};
					case 1: { // 2s
						call CQM_Loop_1;
					};
					case 2: { // 4s
						call CQM_Loop_2;
					};
					case 3: {
						call CRQ_WreckLoop;
						call CRQ_CorpseLoop;
						call CQM_Loop_3;
					};
					case 4: {
						call CQM_Loop_4;
					};
					case 5: {
						call CQM_Loop_5;
					};
					case 6: {
						call CRQ_ClientLoop;
						call CRQ_LightsLoop;
						call CRQ_DayLoop;
						call CQM_Loop_6;
					};
					case 7: {
						call CQM_Loop_7;
					};
					default {};
				};
			};		
		} forEach gT_Timing;
		sleep CRQ_DELAY_LOOP;
	};
};

call CRQ_Main;
