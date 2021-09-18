
#include "CRQ__Client.sqf"
#include "CRQ_Shared.sqf"

#include "..\CQM\CQM_Client.sqf"

addMissionEventHandler ["EntityKilled", {_this call CRQ_LocalClientKilled;}];
addMissionEventHandler ["EntityRespawned", {_this call CRQ_LocalClientRespawn;}];

gMS_PlayerGrass = (["CRQ_EnvironmentGrass", 250] call BIS_fnc_getParamValue) / 10;
gMS_PlayerFatigue = [false,true] select (["CRQ_PlayerFatigue", 1] call BIS_fnc_getParamValue);
gMS_PlayerMedic = [false,true] select (["CRQ_PlayerMedic", 0] call BIS_fnc_getParamValue);
gMS_PlayerEngineer = [false,true] select (["CRQ_PlayerEngineer", 0] call BIS_fnc_getParamValue);
gMS_PlayerSway = (["CRQ_PlayerSway", 100] call BIS_fnc_getParamValue) / 100;

gLC_SpawnMonitor = scriptNull;

CRQ_LocalClientConnect = {
	//params ["_id", "_uid", "_name", "_jip", "_owner", "_idstr"];
	_this spawn CQM_LocalClientConnect;
	setTerrainGrid gMS_PlayerGrass;
	call CRQ_LocalClientSpawn;
};
CRQ_LocalClientDisconnect = {
	//params ["_id", "_uid", "_name", "_jip", "_owner", "_idstr"];
	_this spawn CQM_LocalClientDisconnect;
};
CRQ_LocalClientKilled = {
	params ["_unit"];//, "_killer", "_instigator", "_useEffects"];
	if (_unit isEqualTo player) then {_this spawn CQM_LocalClientKilled;}
};

CRQ_LocalClientRespawn = {
	params ["_unit"];//, "_corpse"];
	if (_unit isEqualTo player) then {call CRQ_LocalClientSpawn;};
};

CRQ_LocalClientSpawn = {
	"_screenLayer" cutText ["", "BLACK FADED", 0, true, false];
	player allowDamage false;
	player enableSimulation false;
	player setCaptive true;
	call CRQ_LocalPlayerTraits;
	player setVariable [CRQ_VAR_CLIENT_SPAWN, true];
	terminate gLC_SpawnMonitor;
	gLC_SpawnMonitor = [] spawn CRQ_LocalClientSpawnMonitor;
};
CRQ_LocalClientSpawnMonitor = {
	CRQ_SPAWN_RESOLVE_TIMEOUT call CRQ_Wait;
	if (player getVariable [CRQ_VAR_CLIENT_SPAWN, false]) then {call CRQ_LocalClientSpawnResolve;};
};
CRQ_LocalClientSpawnResolve = {
	player setVariable [CRQ_VAR_CLIENT_SPAWN, nil];
	player enableSimulation true;
	player allowDamage true;
	player setCaptive false;
	"_screenLayer" cutText ["", "BLACK IN", CRQ_SPAWN_FADEIN_TIME, true, false];
	[] spawn CQM_LocalClientSpawn;
};
CRQ_LocalClientIdentityLoadout = {
	params ["_unit", "_identity", "_loadout"];
	if (player isEqualTo _unit) then {
		if (_identity isNotEqualTo []) then {[player, _identity] call CRQ_SetIdentity;};
		if (_loadout isNotEqualTo []) then {[player, _loadout] call CRQ_SetLoadout;};
	};
};
CRQ_LocalPlayerTraits = {
	if (!gMS_PlayerFatigue) then {
		player enableFatigue false;
		player enableStamina false;
	};
	if (gMS_PlayerMedic) then {
		player setUnitTrait ["medic", true];
	};
	if (gMS_PlayerEngineer) then {
		player setUnitTrait ["engineer", true];
		player setUnitTrait ["explosiveSpecialist", true];
		player setUnitTrait ["UAVHacker", true];
	};
	player setCustomAimCoef gMS_PlayerSway;
};
