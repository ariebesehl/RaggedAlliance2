
#include "CRA__Shared.sqf"

pRA_Themes = missionNamespace getVariable ["pRA_Themes", createHashMapFromArray CRA_THEMES];
pRA_Locations = missionNamespace getVariable ["pRA_Locations", []];
pRA_LocationSafe = missionNamespace getVariable ["pRA_LocationSafe", []];
pRA_LoadMessage = missionNamespace getVariable ["pRA_LoadMessage", 0];
pRA_LoadIndex = missionNamespace getVariable ["pRA_LoadIndex", 0];
pRA_LoadTotal = missionNamespace getVariable ["pRA_LoadTotal", 0];
pRA_Initializing = missionNamespace getVariable ["pRA_Initializing", true];

CRA_Paradrop = {
	params ["_unit", "_vec"];
	(_vec#0) set [2, CRA_PARADROP_HEIGHT - (getTerrainHeightASL (_vec#0) min 0)];
	private _parachute = ["Steerable_Parachute_F", _vec] call CRQ_ObjectSpawn;
	sleep 0.01;
	_unit moveInAny _parachute;
};
CRA_Teleport = {
	params ["_unit", "_vec"];
	_unit setDir (_vec#1);
	_unit setPos (_vec#0);
};
