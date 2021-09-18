
#include "CQM__Server.sqf"
#include "CQM_Shared.sqf"

#include "CRA__Main.sqf"
#include "CRA__Item.sqf"
#include "CRA__Vehicle.sqf"
#include "CRA_Item.sqf"
#include "CRA_Vehicle.sqf"
#include "CRA_Main.sqf"

CQM_InitPre = {
	call CRA_InitPre;
};
CQM_Init = {
	call CRA_Init;
};
CQM_ClientConnect = {
	//params ["_id", "_uid", "_name", "_jip", "_owner", "_idstr"];
	_this call CRA_PlayerConnect;
};
CQM_ClientDisconnect = {
	//params ["_id", "_uid", "_name", "_jip", "_owner", "_idstr"];
	_this call CRA_PlayerDisconnect;
};
CQM_ClientHandleDisconnect = {
	//params ["_unit", "_id", "_uid", "_name"];
	_this call CRA_PlayerHandleDisconnect;
};
CQM_ClientSpawn = {
	//params ["_unit","_isRespawn"];
	_this call CRA_PlayerSpawn;
};
CQM_Loop_0 = {
};
CQM_Loop_1 = {
};
CQM_Loop_2 = {
};
CQM_Loop_3 = {
	call CRA_Loop;
};
CQM_Loop_4 = {
};
CQM_Loop_5 = {
};
CQM_Loop_6 = {
};
CQM_Loop_7 = {
};
CQM_Night = {
};
CQM_Day = {
};
CQM_LightsOn = {
	call CRA_LightsOn;
};
CQM_LightsOff = {
	call CRA_LightsOff;
};
