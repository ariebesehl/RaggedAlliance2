
#define CRQ_DEFINE_CLIENT 1

#include "CRQ__INC__Shared.sqf"

#include "CRQ__DEF__Client.sqf"
#include "..\CQM\CQM__FNC__Client.sqf"
#include "CRQ__FNC__Client.sqf";

gCC_PM_ENL_Grass = (["CRQ_PM_EN_Grass", 25000] call BIS_fnc_getParamValue) / 1000;
gCC_PM_PLL_Fatigue = ["CRQ_PM_PL_Fatigue", 1] call BIS_fnc_getParamValue;
gCC_PM_PLL_Stamina = ["CRQ_PM_PL_Stamina", 1] call BIS_fnc_getParamValue;
gCC_PM_PLL_Traits = missionNamespace getVariable ["gCC_PM_PLL_Traits", [ // D298: MED, EXP, ENG, HAK
		(["CRQ_PM_PL_TraitMed", 1] call BIS_fnc_getParamValue), // D298: 0=(no one),1=(role/cfg/notouch),2=(everyone)
		(["CRQ_PM_PL_TraitExp", 1] call BIS_fnc_getParamValue),
		(["CRQ_PM_PL_TraitEng", 1] call BIS_fnc_getParamValue),
		(["CRQ_PM_PL_TraitHak", 1] call BIS_fnc_getParamValue)
]];
gCC_PM_PLL_Sway = (["CRQ_PM_PL_Sway", 100] call BIS_fnc_getParamValue) / 100;
gCC_TM_Now = missionNamespace getVariable ["gCC_TM_Now", time];
gCC_MN_Initialized = missionNamespace getVariable ["gCC_MN_Initialized", false];
gCC_UI_MapIcons = missionNamespace getVariable ["gCC_UI_MapIcons", createHashMap];
gCC_SpawnMonitor = scriptNull;

addMissionEventHandler ["EntityKilled", CRQ_EHL_ClientKilled];
addMissionEventHandler ["EntityRespawned", CRQ_EHL_ClientRespawn];

call CRQ_fnc_CLL_MainInit;
