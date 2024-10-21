
#define CRQ_DEFINE_CLIENT 1

#include "CRQ__Client.sqf"

#include "CRQ_Shared.sqf"

#include "..\CQM\CQM__FNC__Client.sqf"

gCC_PM_ENL_Grass = (["CRQ_EN_Grass", 250] call BIS_fnc_getParamValue) / 10;
gCC_PM_PLL_Sway = (["CRQ_PL_Sway", 100] call BIS_fnc_getParamValue) / 100;
gCC_PM_PLL_Fatigue = [false,true] select (["CRQ_PL_Fatigue", 1] call BIS_fnc_getParamValue);
gCC_PM_PLL_Medic = [false,true] select (["CRQ_PL_TraitMed", 0] call BIS_fnc_getParamValue);
gCC_PM_PLL_Engineer = [false,true] select (["CRQ_PL_TraitEng", 0] call BIS_fnc_getParamValue);
gCC_PM_PLL_Explosive = [false,true] select (["CRQ_PL_TraitExp", 0] call BIS_fnc_getParamValue);
gCC_PM_PLL_Hacker = [false,true] select (["CRQ_PL_TraitHak", 0] call BIS_fnc_getParamValue);

gCC_TM_Now = missionNamespace getVariable ["gCC_TM_Now", time];
gCC_MN_Initialized = missionNamespace getVariable ["gCC_MN_Initialized", false];
gCC_UI_MapIcons = missionNamespace getVariable ["gCC_UI_MapIcons", createHashMap];

gCC_SpawnMonitor = scriptNull;

CRQ_EHL_ClientKilled = {
	if ((_this#0) isEqualTo player) then {_this spawn CQM_LocalClientKilled;}
};
CRQ_EHL_ClientRespawn = {
	if ((_this#0) isEqualTo player) then {[] call CRQ_fnc_CLL_SpawnInit;};
};
addMissionEventHandler ["EntityKilled", CRQ_EHL_ClientKilled];
addMissionEventHandler ["EntityRespawned", CRQ_EHL_ClientRespawn];

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
CRQ_fnc_CLL_PauseExit = {
	// TODO
};
CRQ_fnc_CLL_PauseForce = {
	(findDisplay 46) createDisplay "RscDisplayMPInterrupt";
};
CRQ_fnc_CLL_PauseState = {
	(findDisplay 49) isNotEqualTo displayNull
};
CRQ_fnc_CLL_Sync = {
	_this = missionNamespace getVariable ["CRQP_SYN", []];
	if (_this isEqualTo []) exitWith {};
	(pCQ_CL_Data#(_this#0#0)) set [_this#0#1, _this#1];
};
CRQ_fnc_CLL_Connect = {
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
	gCC_MN_Initialized = true;
	[player, getPlayerID player, getPlayerUID player, profileName, didJIP] remoteExec ["CRQ_fnc_CL_Connect", 2];
	[] spawn CQM_LocalClientConnect;
	setTerrainGrid gCC_PM_ENL_Grass;
	[] call CRQ_fnc_CLL_SpawnInit;
};
CRQ_fnc_CLL_Suspend = {
	"CRQL_SPN" cutText ["", "BLACK", 0.001, true, false]; // non-zero, as 0s defaults to 5s
	player allowDamage false;
	player enableSimulation false;
	player setCaptive true;
};
CRQ_fnc_CLL_Restore = {
	player enableSimulation true;
	player allowDamage true;
	player setCaptive false;
	"CRQL_SPN" cutText ["", "BLACK IN", CRQ_CLL_SP_FADE, true, false];
};
CRQ_fnc_CLL_SpawnInit = {
	[] call CRQ_fnc_CLL_Suspend;
	[] call CRQ_fnc_PLL_Traits;
	player setVariable ["CRQ_CVAR_REG", true];
	terminate gCC_SpawnMonitor;
	gCC_SpawnMonitor = [] spawn CRQ_fnc_CLL_SpawnMonitor;
};
CRQ_fnc_CLL_SpawnMonitor = {
	CRQ_CLL_SP_RESOLVE call CRQ_Wait;
	if (player getVariable ["CRQ_CVAR_REG", false]) then {[] call CRQ_fnc_CLL_SpawnResolve;};
};
CRQ_fnc_CLL_SpawnResolve = {
	player setVariable ["CRQ_CVAR_REG", nil];
	if (CQM_CLIENT_RESTORE_AUTO) then {[] call CRQ_fnc_CLL_Restore;};
	[] spawn CQM_LocalClientSpawn;
};
CRQ_fnc_PLL_UI_Enter = {
	player playMoveNow "HubSpectator_stand";
};
CRQ_fnc_PLL_UI_Exit = {
	player switchMove "AmovPercMstpSlowWrflDnon"; // TODO pick correct animation
};
CRQ_fnc_PLL_Incapacitated = {
	player getVariable ["BIS_revive_incapacitated", false]
};
CRQ_fnc_PLL_IdentityLoadout = {
	params ["_unit", "_identity", "_loadout"];
	if (player isNotEqualTo _unit) exitWith {};
	if (_identity isNotEqualTo []) then {[player, _identity] call CRQ_IdentityApply;};
	if (_loadout isNotEqualTo []) then {[player, _loadout] call CRQ_LoadoutApply;};
};
CRQ_fnc_PLL_Traits = {
	if (!gCC_PM_PLL_Fatigue) then {
		player enableFatigue false;
		player enableStamina false;
	};
	if (gCC_PM_PLL_Medic) then {player setUnitTrait ["medic", true];};
	if (gCC_PM_PLL_Engineer) then {player setUnitTrait ["engineer", true];};
	if (gCC_PM_PLL_Explosive) then {player setUnitTrait ["explosiveSpecialist", true];};
	if (gCC_PM_PLL_Hacker) then {player setUnitTrait ["UAVHacker", true];};
	player setCustomAimCoef gCC_PM_PLL_Sway;
};
CRQ_fnc_UI_Display = {
	disableSerialization;
	private _parent = findDisplay 46;
	private _child = displayNull;
	while {true} do {
		_child = displayChild _parent;
		if (_child isEqualTo displayNull) exitWith {ctrlIDD _parent};
		_parent = _child;
	};
};
// WARNING (to myself): Don't change these function names, they are maybe referenced in hpp files
CRQ_DisplayLaptopCreate = {
	createDialog "CRQ_GUI_DISP_LAPTOP_ROOT";
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
CRQ_fnc_UI_MapCreate = {
	params ["_root", "_title", "_list", ["_index", -1], ["_pos", []]];
	private _display = _root createDisplay "CRQ_GUI_DISP_MAP_ROOT";
	(_display displayCtrl CRQ_UI_ID_MAP_TITLE) ctrlSetText _title;
	if (_pos isNotEqualTo []) then {[_display, _pos, 0] call CRQ_fnc_UI_MapPos;};
	private _ctrlList = _display displayCtrl CRQ_UI_ID_MAP_LIST;
	if (_list isEqualTo []) then {
		_ctrlList ctrlShow false;
	} else {
		{_ctrlList lbAdd _x;} forEach _list;
		if (_index >= 0) then {_ctrlList lbSetCurSel _index;};
	};
	[_display] call CQM_fnc_UI_MapCreate;
};
CRQ_fnc_UI_MapExit = {
	//params ["_display", "_type"];
	_this call CQM_fnc_UI_MapExit;
};
CRQ_fnc_UI_MapDraw = {
	{if (_y isNotEqualTo []) then {_this drawIcon _y;};} forEach gCC_UI_MapIcons;
};
CRQ_fnc_UI_MapIconClear = {
	gCC_UI_MapIcons = createHashMap;
};
CRQ_fnc_UI_MapIconAdd = {
	params ["_id", ["_texture", ""], ["_vec", []], ["_color", CRQ_DISPLAY_MAP_ICON_COLOR], ["_size", CRQ_DISPLAY_MAP_ICON_SIZE]];
	if (_texture isEqualTo "" || {_vec isEqualTo []}) exitWith {};
	gCC_UI_MapIcons set [_id, [_texture, _color, _vec#0, _size#0, _size#1, _vec#1]];
};
CRQ_fnc_UI_MapIconRemove = {
	if ((gCC_UI_MapIcons getOrDefault [_this, []]) isNotEqualTo []) then {gCC_UI_MapIcons set [_this, []];};
};
CRQ_fnc_UI_MapIconSetVec = {
	params ["_id", "_vec"];
	private _icon = gCC_UI_MapIcons getOrDefault [_id, []];
	if (_icon isEqualTo []) exitWith {};
	_icon set [2, _vec#0];
	_icon set [5, _vec#1];
};
CRQ_fnc_UI_MapIconSetPos = {
	params ["_id", "_pos"];
	private _icon = gCC_UI_MapIcons getOrDefault [_id, []];
	if (_icon isEqualTo []) exitWith {};
	_icon set [2, _pos];
};
CRQ_fnc_UI_MapIconSetDir = {
	params ["_id", "_dir"];
	private _icon = gCC_UI_MapIcons getOrDefault [_id, []];
	if (_icon isEqualTo []) exitWith {};
	_icon set [5, _dir];
};
CRQ_fnc_UI_MapIconSetColor = {
	params ["_id", "_color"];
	private _icon = gCC_UI_MapIcons getOrDefault [_id, []];
	if (_icon isEqualTo []) exitWith {};
	_icon set [1, _color];
};
CRQ_fnc_UI_MapSelectMap = {
	params ["_map", "_button", "_posMapX", "_posMapY"];
	[ctrlParent _map, _map ctrlMapScreenToWorld [_posMapX, _posMapY], _button] call CQM_fnc_UI_MapSelectMap;
};
CRQ_fnc_UI_MapSelectList = {
	params ["_list", "_index"];
	[ctrlParent _list, _index] call CQM_fnc_UI_MapSelectList;
};
CRQ_fnc_UI_MapPos = {
	params ["_display", "_pos", ["_transition", 0.2]];
	private _map = _display displayCtrl CRQ_UI_ID_MAP_MAP;
	_map ctrlMapAnimAdd [_transition, ctrlMapScale _map, _pos];
	ctrlMapAnimCommit _map;
};
CRQ_fnc_UI_MapIndex = {
	params ["_display", "_index"];
	(_display displayCtrl CRQ_UI_ID_MAP_LIST) lbSetCurSel _index;
};
CRQ_fnc_UI_MapGetIndex = {
	(lbCurSel (_display displayCtrl CRQ_UI_ID_MAP_LIST))
};
CRQ_fnc_UI_MapGetPos = {
	[0.0,0.0] // TODO
};
CRQ_fnc_HUD_InfoOpacity = {
	if (true) exitWith {};
	disableSerialization;
	private _iddLast = (uiNamespace getVariable ["CRQU_INFO", [-1]])#0;
	private _ctrl = (findDisplay _iddLast) displayCtrl CRQ_UI_ID_INFO_DESC;
	private _colorBG = ctrlBackgroundColor _ctrl;
	if ((_colorBG#3) isEqualTo (_this)) exitWith {};
	_colorBG set [3, _this];
	_ctrl ctrlSetBackgroundColor _colorBG;
	_ctrl ctrlCommit 0;
};
CRQ_fnc_HUD_InfoDestroy = {
	disableSerialization;
	ctrlDelete ((findDisplay ((uiNamespace getVariable ["CRQU_INFO", [-1]])#0)) displayCtrl CRQ_UI_ID_INFO_DESC)
};
CRQ_fnc_HUD_InfoCreate = {
	disableSerialization;
	[] call CRQ_fnc_HUD_InfoDestroy;
	private _ctrl = (findDisplay _this) ctrlCreate ["CRQ_UI_CT_INFO_DESC", CRQ_UI_ID_INFO_DESC];
	_ctrl ctrlCommit 0;
	uiNamespace setVariable ["CRQU_INFO", [_this, gCC_TM_Now]];
};
CRQ_fnc_HUD_InfoText = {
	disableSerialization;
	private _iddLast = (uiNamespace getVariable ["CRQU_INFO", [-1]])#0;
	private _iddCurrent = [] call CRQ_fnc_UI_Display;
	if (_iddLast isNotEqualTo _iddCurrent) then { // TODO queue messages when escaped
		if (_iddCurrent isEqualTo 49) exitWith {0 call CRQ_fnc_HUD_InfoOpacity;};
		if (_iddLast isEqualTo 49) exitWith {1 call CRQ_fnc_HUD_InfoOpacity;};
		_iddCurrent call CRQ_fnc_HUD_InfoCreate;
	};
	private _ctrl = (findDisplay _iddCurrent) displayCtrl CRQ_UI_ID_INFO_DESC;
	if (_ctrl isEqualTo controlNull) exitWith {};
	_ctrl ctrlSetStructuredText parseText ("<t align='center'>" + _this + "</t>");
	(uiNamespace getVariable ["CRQU_INFO", [-1, -1]]) set [1, gCC_TM_Now];
};
CRQ_fnc_HUD_InfoLoop = {
	disableSerialization;
	(uiNamespace getVariable ["CRQU_INFO", [-1, -1]]) params ["_iddLast", "_timeLast"];
	if ((gCC_TM_Now - _timeLast) > 12) then {
		[] call CRQ_fnc_HUD_InfoDestroy;
		uiNamespace setVariable ["CRQU_INFO", [-1, -1]];
	};
};
CRQ_fnc_HUD_Init = {
	disableSerialization;
	"CRQL_HUD" cutRsc ["CRQ_HUD_ROOT", "PLAIN", 0, true];
};
CRQ_fnc_HUD_Loop = {
	disableSerialization;
	[] call CRQ_fnc_HUD_InfoLoop;
};
CRQ_fnc_CLL_MainLoop = {
	waitUntil {sleep CRQ_TIME_WAIT; gCC_MN_Initialized};
	[] call CRQ_fnc_HUD_Init;
	while {true} do {
		gCC_TM_Now = time;
		[] call CRQ_fnc_HUD_InfoLoop;
		sleep 0.125;
	};
};
CRQ_fnc_CLL_MainInit = {
	[] spawn CRQ_fnc_CLL_Connect;
	[] spawn CRQ_fnc_CLL_MainLoop;
};

call CRQ_fnc_CLL_MainInit;
