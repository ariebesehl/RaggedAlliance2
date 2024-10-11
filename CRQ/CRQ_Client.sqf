
#define CRQ_DEFINE_CLIENT 1

#include "CRQ__Client.sqf"

#include "CRQ_Shared.sqf"

#include "..\CQM\CQM_Client.sqf"

addMissionEventHandler ["EntityKilled", {_this call CRQ_LocalClientKilled;}];
addMissionEventHandler ["EntityRespawned", {_this call CRQ_LocalClientRespawn;}];

gCC_SettingClientGrass = (["CRQ_EnvironmentGrass", 250] call BIS_fnc_getParamValue) / 10;
gCC_SettingClientFatigue = [false,true] select (["CRQ_PlayerFatigue", 1] call BIS_fnc_getParamValue);
gCC_SettingClientMedic = [false,true] select (["CRQ_PlayerMedic", 0] call BIS_fnc_getParamValue);
gCC_SettingClientEngineer = [false,true] select (["CRQ_PlayerEngineer", 0] call BIS_fnc_getParamValue);
gCC_SettingClientExplosive = [false,true] select (["CRQ_PlayerExplosiveSpecialist", 0] call BIS_fnc_getParamValue);
gCC_SettingClientHacker = [false,true] select (["CRQ_PlayerUAVHacker", 0] call BIS_fnc_getParamValue);
gCC_SettingClientSway = (["CRQ_PlayerSway", 100] call BIS_fnc_getParamValue) / 100;

gCC_DisplayMapIcons = missionNamespace getVariable ["gCC_DisplayMapIcons", []];

gCC_SpawnMonitor = scriptNull;

CRQ_LocalSyncArrayClear = {
	params ["_name"];
	missionNamespace setVariable [_name, []];
};
CRQ_LocalSyncArrayIndex = {
	params ["_name", "_index", "_data"];
	if (isNil _name) exitWith {};
	private _array = missionNamespace getVariable _name;
	_array set [_index, _data];
};
CRQ_LocalClientInit = {
	[] spawn CRQ_LocalClientConnect;
};
CRQ_LocalClientConnect = {
	private _initCode = [{getClientStateNumber < 10}, {player isEqualTo objNull}, {!(local player)}, {(findDisplay 46) isEqualTo displayNull}];
	private _initWait = _initCode apply {true};
	while {true} do {
		private _ready = true;
		{
			if (_x && {[] call (_initCode#_forEachIndex)}) exitWith {_ready = false;};
			_initWait set [_forEachIndex, false];
		} forEach _initWait;
		if (_ready) exitWith {};
		sleep CRQ_TIME_WAIT;
	};
	[player, getPlayerID player, getPlayerUID player, profileName, didJIP] remoteExec ["CRQ_ClientConnect", 2];
	[] spawn CQM_LocalClientConnect;
	setTerrainGrid gCC_SettingClientGrass;
	[] call CRQ_LocalClientSpawn;
};
CRQ_LocalClientKilled = {
	params ["_unit"];//, "_killer", "_instigator", "_useEffects"];
	if (_unit isEqualTo player) then {_this spawn CQM_LocalClientKilled;}
};

CRQ_LocalClientRespawn = {
	params ["_unit"];//, "_corpse"];
	if (_unit isEqualTo player) then {[] call CRQ_LocalClientSpawn;};
};
CRQ_LocalClientSuspend = {
	CRQ_SPAWN_LAYER cutText ["", "BLACK", 0.001, true, false]; // non-zero, as 0s defaults to 5s
	player allowDamage false;
	player enableSimulation false;
	player setCaptive true;
};
CRQ_LocalClientRestore = {
	player enableSimulation true;
	player allowDamage true;
	player setCaptive false;
	CRQ_SPAWN_LAYER cutText ["", "BLACK IN", CRQ_SPAWN_FADE, true, false];
};
CRQ_LocalClientSpawn = {
	[] call CRQ_LocalClientSuspend;
	[] call CRQ_LocalPlayerTraits;
	player setVariable [CRQ_CVAR_CLIENT_SPAWN, true];
	terminate gCC_SpawnMonitor;
	gCC_SpawnMonitor = [] spawn CRQ_LocalClientSpawnMonitor;
};
CRQ_LocalClientSpawnMonitor = {
	CRQ_SPAWN_RESOLVE call CRQ_Wait;
	if (player getVariable [CRQ_CVAR_CLIENT_SPAWN, false]) then {[] call CRQ_LocalClientSpawnResolve;};
};
CRQ_LocalClientSpawnResolve = {
	player setVariable [CRQ_CVAR_CLIENT_SPAWN, nil];
	if (CQM_CLIENT_RESTORE_AUTO) then {[] call CRQ_LocalClientRestore;};
	[] spawn CQM_LocalClientSpawn;
};
CRQ_LocalClientIdentityLoadout = {
	params ["_unit", "_identity", "_loadout"];
	if (player isNotEqualTo _unit) exitWith {};
	if (_identity isNotEqualTo []) then {[player, _identity] call CRQ_IdentityApply;};
	if (_loadout isNotEqualTo []) then {[player, _loadout] call CRQ_LoadoutApply;};
};
CRQ_LocalPlayerTraits = {
	if (!gCC_SettingClientFatigue) then {
		player enableFatigue false;
		player enableStamina false;
	};
	if (gCC_SettingClientMedic) then {player setUnitTrait ["medic", true];};
	if (gCC_SettingClientEngineer) then {player setUnitTrait ["engineer", true];};
	if (gCC_SettingClientExplosive) then {player setUnitTrait ["explosiveSpecialist", true];};
	if (gCC_SettingClientHacker) then {player setUnitTrait ["UAVHacker", true];};
	player setCustomAimCoef gCC_SettingClientSway;
};

CRQ_DisplayLaptopCreate = {
	createDialog CRQ_STRING(CRQ_GUI_DISP_LAPTOP_ROOT);
	[] call CQM_DisplayLaptopCreate;
};
CRQ_DisplayLaptopExit = {
	//params ["_display", "_type"];
	_this call CQM_DisplayLaptopExit;
};
CRQ_DisplayLaptopTile = {
	//params ["_display", "_index"];
	_this call CQM_DisplayLaptopTile;
};
CRQ_DisplayMapCreate = {
	params ["_root", "_title", "_list", ["_index", -1], ["_pos", []]];
	private _display = _root createDisplay CRQ_STRING(CRQ_GUI_DISP_MAP_ROOT);
	(_display displayCtrl CRQ_GUI_ID_MAP_TITLE) ctrlSetText _title;
	if (_pos isNotEqualTo []) then {[_display, _pos, 0] call CRQ_DisplayMapPos;};
	private _ctrlList = _display displayCtrl CRQ_GUI_ID_MAP_LIST;
	if (_list isEqualTo []) then {
		_ctrlList ctrlShow false;
	} else {
		{_ctrlList lbAdd _x;} forEach _list;
		if (_index >= 0) then {_ctrlList lbSetCurSel _index;};
	};
	[_display] call CQM_DisplayMapCreate;
};
CRQ_DisplayMapExit = {
	//params ["_display", "_type"];
	_this call CQM_DisplayMapExit;
};
CRQ_DisplayMapDraw = {
	{if (_x isNotEqualTo []) then {_this drawIcon _x;};} forEach gCC_DisplayMapIcons;
};
CRQ_DisplayMapIconClear = {
	gCC_DisplayMapIcons = [];
};
CRQ_DisplayMapIconAdd = {
	params [["_texture", ""], ["_vec", []], ["_color", CRQ_DISPLAY_MAP_ICON_COLOR], ["_size", CRQ_DISPLAY_MAP_ICON_SIZE]];
	if (_texture isEqualTo "" || {_vec isEqualTo []}) exitWith {-1};
	private _icon = [_texture, _color, _vec#0, _size#0, _size#1, _vec#1];
	private _index = gCC_DisplayMapIcons findIf {_x isEqualTo []};
	if (_index != -1) exitWith {
		gCC_DisplayMapIcons set [_index, _icon];
		_index
	};
	gCC_DisplayMapIcons pushBack _icon;
	((count gCC_DisplayMapIcons) - 1)
};
CRQ_DisplayMapIconRemove = {
	if (_this isEqualType -1 && _this != -1) then {gCC_DisplayMapIcons set [_this, []];};
};
CRQ_DisplayMapIconSetVec = {
	params ["_index", "_vec"];
	if (_index == -1 || {(gCC_DisplayMapIcons#_index) isEqualTo []}) exitWith {};
	(gCC_DisplayMapIcons#_index) set [2, _vec#0];
	(gCC_DisplayMapIcons#_index) set [5, _vec#1];
};
CRQ_DisplayMapIconSetPos = {
	params ["_index", "_pos"];
	if (_index == -1 || {(gCC_DisplayMapIcons#_index) isEqualTo []}) exitWith {};
	(gCC_DisplayMapIcons#_index) set [2, _pos];
};
CRQ_DisplayMapIconSetDir = {
	params ["_index", "_dir"];
	if (_index == -1 || {(gCC_DisplayMapIcons#_index) isEqualTo []}) exitWith {};
	(gCC_DisplayMapIcons#_index) set [5, _dir];
};
CRQ_DisplayMapIconSetColor = {
	params ["_index", "_color"];
	if (_index == -1 || {(gCC_DisplayMapIcons#_index) isEqualTo []}) exitWith {};
	(gCC_DisplayMapIcons#_index) set [1, _color];
};
CRQ_DisplayMapSelectMap = {
	params ["_map", "_button", "_posMapX", "_posMapY"];
	[ctrlParent _map, _map ctrlMapScreenToWorld [_posMapX, _posMapY], _button] call CQM_DisplayMapSelectMap;
};
CRQ_DisplayMapSelectList = {
	params ["_list", "_index"];
	[ctrlParent _list, _index] call CQM_DisplayMapSelectList;
};
CRQ_DisplayMapPos = {
	params ["_display", "_pos", ["_transition", 0.2]];
	private _map = _display displayCtrl CRQ_GUI_ID_MAP_MAP;
	_map ctrlMapAnimAdd [_transition, ctrlMapScale _map, _pos];
	ctrlMapAnimCommit _map;
};
CRQ_DisplayMapIndex = {
	params ["_display", "_index"];
	(_display displayCtrl CRQ_GUI_ID_MAP_LIST) lbSetCurSel _index;
};
CRQ_DisplayMapGetIndex = {
	(lbCurSel (_display displayCtrl CRQ_GUI_ID_MAP_LIST))
};
CRQ_DisplayMapGetPos = {
	[0.0,0.0] // TODO
};

[] call CRQ_LocalClientInit;
