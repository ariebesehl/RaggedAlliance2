
#include "CQM__Client.sqf"
// included in CRQ_Shared.sqf
//#include "CQM_Shared.sqf"

#include "CRA_Client.sqf"

CQM_LocalClientConnect = {
	call CRA_LocalClientConnect;
};
CQM_LocalClientSpawn = {
};
CQM_LocalClientKilled = {
	//params ["_unit", "_killer", "_instigator", "_useEffects"];
	call CRA_LocalPlayerDeath;
};
CQM_DisplayLaptopCreate = {
	//params ["_display"];
};
CQM_DisplayLaptopExit = {
	//params ["_display", "_type"];
	_this call CRA_DisplayLaptopExit;
};
CQM_DisplayLaptopTile = {
	//params ["_display", "_index"];
	_this call CRA_DisplayLaptopTile;
};
CQM_DisplayMapCreate = {
	//params ["_display"];
};
CQM_DisplayMapExit = {
	//params ["_display", "_type"];
	_this call CRA_DisplayMapExit;
};
CQM_DisplayMapSelectMap = {
	//params ["_display", "_pos", "_button"];
	_this call CRA_DisplayMapSelectMap;
};
CQM_DisplayMapSelectList = {
	//params ["_display", "_index"];
	_this call CRA_DisplayMapSelectList;
};