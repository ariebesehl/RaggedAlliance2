
#include "CRQ__Client.sqf"
#include "CRQ_Shared.sqf"

#include "..\CQM\CQM_Client.sqf"

addMissionEventHandler ["EntityRespawned", {_this call CRQ_LocalClientRespawn;}];
addMissionEventHandler ["EntityKilled", {_this call CRQ_LocalClientKilled;}];

gMS_PlayerGrass = (["CRQ_EnvironmentGrass", 250] call BIS_fnc_getParamValue) / 10;
gMS_PlayerFatigue = [false,true] select (["CRQ_PlayerFatigue", 1] call BIS_fnc_getParamValue);
gMS_PlayerMedic = [false,true] select (["CRQ_PlayerMedic", 0] call BIS_fnc_getParamValue);
gMS_PlayerEngineer = [false,true] select (["CRQ_PlayerEngineer", 0] call BIS_fnc_getParamValue);
gMS_PlayerSway = (["CRQ_PlayerSway", 100] call BIS_fnc_getParamValue) / 100;

gLC_SpawnHandle = scriptNull;

CRQ_LocalClientConnect = {
	params ["_id", "_uid", "_name", "_jip", "_owner", "_idstr"];
	waitUntil {sleep CRQ_CLIENT_WAIT_RESOLUTION; getClientStateNumber > 9;};
	[player, false] remoteExec ["CRQ_ClientSpawn", 2];
	call CRQ_LocalClientSpawnPre;
	_this spawn CQM_LocalClientConnect;
	setTerrainGrid gMS_PlayerGrass;
};
CRQ_LocalClientDisconnect = {
	params ["_id", "_uid", "_name", "_jip", "_owner", "_idstr"];
	_this spawn CQM_LocalClientDisconnect;
};
CRQ_LocalClientRespawn = {
	params ["_entity", "_corpse"];
	if (player isEqualTo _entity) then {call CRQ_LocalClientSpawnPre;};
};
CRQ_LocalClientKilled = {
	params ["_unit", "_killer", "_instigator", "_useEffects"];
	if (player isEqualTo _unit) then {_this spawn CQM_LocalClientKilled;}
};
CRQ_LocalClientSpawnPre = {
	if (!isNull gLC_SpawnHandle) then {terminate gLC_SpawnHandle;};
	[] spawn CRQ_LocalClientSpawn;
};
CRQ_LocalClientSpawn = {
	gLC_SpawnHandle = _thisScript;
	private _timeResolve = time;
	private _unresolved = true;
	player allowDamage false;
	player enableSimulation false;
	player setCaptive true;
	"_screenLayer" cutText ["", "BLACK FADED", 0, true, false];
	//titleText ["", "BLACK", -1, false, false];
	while {_unresolved && ((time - _timeResolve) < CRQ_SPAWN_RESOLVE_TIMEOUT)} do {
		_unresolved = !(player getVariable ["respawn", false]);
		sleep CRQ_SPAWN_RESOLVE_DELAY;
	};
	player enableSimulation true;
	sleep CRQ_SPAWN_HOLD_TIME;
	"_screenLayer" cutText ["", "BLACK IN", CRQ_SPAWN_FADEIN_TIME, true, false];
	//titleFadeOut CRQ_SPAWN_FADEIN_TIME;
	player allowDamage true;
	player setCaptive false;
	[] spawn CQM_LocalClientSpawn;
	if (_unresolved) then {
		private _timeUnresolved = time;
		while {_unresolved && ((time - _timeUnresolved) < CRQ_SPAWN_UNRESOLVED_TIMEOUT)} do {
			_unresolved = !(player getVariable ["respawn", false]);
			sleep CRQ_SPAWN_UNRESOLVED_DELAY;
		};
	};
	player setVariable ["respawn", nil];
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
