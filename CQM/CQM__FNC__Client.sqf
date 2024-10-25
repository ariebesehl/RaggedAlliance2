
#include "CRA__FNC__Client.sqf"

#define CQM_fnc_CLL_Connect CRA_LocalClientConnect
#define CQM_fnc_CLL_Spawn {}
#define CQM_fnc_CLL_Killed CRA_LocalPlayerDeath //params ["_unit", "_killer", "_instigator", "_useEffects"];
#define CQM_fnc_UI_LaptopCreate {} //params ["_display"];
#define CQM_fnc_UI_LaptopExit CRA_DisplayLaptopExit //params ["_display", "_type"];
#define CQM_fnc_UI_LaptopTile CRA_DisplayLaptopTile //params ["_display", "_index"];
#define CQM_fnc_UI_MapCreate {} //params ["_display"];
#define CQM_fnc_UI_MapExit CRA_DisplayMapExit //params ["_display", "_type"];
#define CQM_fnc_UI_MapSelectMap CRA_DisplayMapSelectMap //params ["_display", "_pos", "_button"];
#define CQM_fnc_UI_MapSelectList CRA_DisplayMapSelectList //params ["_display", "_index"];
