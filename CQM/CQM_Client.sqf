
#include "CQM__Client.sqf"
#include "CQM_Shared.sqf"

#include "CRA_Client.sqf"

CQM_LocalClientConnect = {
	params ["_id", "_uid", "_name", "_jip", "_owner", "_idstr"];
	call CRA_LocalIntroFirst;
};
CQM_LocalClientDisconnect = {
	params ["_id", "_uid", "_name", "_jip", "_owner", "_idstr"];
};
CQM_LocalClientSpawn = {
};
CQM_LocalClientKilled = {
	params ["_unit", "_killer", "_instigator", "_useEffects"];
	call CRA_LocalPlayerDeath;
};