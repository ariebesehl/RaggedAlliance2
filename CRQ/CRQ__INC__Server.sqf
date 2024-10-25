
#define CRQ_DEFINE_SERVER 1

#include "CRQ__INC__Shared.sqf"

#include "CRQ__DEF__Server.sqf"
#include "..\CQM\CQM__FNC__Server.sqf"
#include "CRQ__FNC__Server.sqf"

gCS_PM_MS_Year = ["CRQ_PM_MS_StartYY", 29] call BIS_fnc_getParamValue;
gCS_PM_MS_Month = ["CRQ_PM_MS_StartMN", 4] call BIS_fnc_getParamValue;
gCS_PM_MS_Day = ["CRQ_PM_MS_StartDD", 19] call BIS_fnc_getParamValue;
gCS_PM_MS_Hour = ["CRQ_PM_MS_StartHH", 13] call BIS_fnc_getParamValue;
gCS_PM_MS_Minute = ["CRQ_PM_MS_StartMM", 37] call BIS_fnc_getParamValue;
gCS_PM_GC_CountCorpse = ["CRQ_PM_GC_CountCorpse", 180] call BIS_fnc_getParamValue;
gCS_PM_GC_CountWreck = ["CRQ_PM_GC_CountWreck", 30] call BIS_fnc_getParamValue;
gCS_PM_GC_DecayCorpse = ["CRQ_PM_GC_DecayCorpse", 600] call BIS_fnc_getParamValue;
gCS_PM_GC_DecayWreck = ["CRQ_PM_GC_DecayWreck", 600] call BIS_fnc_getParamValue;
gCS_DT_Params = missionNamespace getVariable ["gCS_DT_Params", []];
gCS_DT_Start = missionNamespace getVariable ["gCS_DT_Start", 0];
gCS_DT_Now = missionNamespace getVariable ["gCS_DT_Now", 0];
gCS_TM_Now = missionNamespace getVariable ["gCS_TM_Now", [] call CRQ_fnc_TimeNow];
gCS_EN_Light = missionNamespace getVariable ["gCS_EN_Light", false];
gCS_MN_HNDL = missionNamespace getVariable ["gCS_MN_HNDL", scriptNull];
gCS_MN_LOOP = missionNamespace getVariable ["gCS_MN_LOOP", (CRQ_MN_LOOP apply {[_x#0, gCS_TM_Now + (_x#1)]})];
gCS_MN_FNCU = missionNamespace getVariable ["gCS_MN_FNCU", [CQM_MN_LOOP_0,CQM_MN_LOOP_1,CQM_MN_LOOP_2,CQM_MN_LOOP_3,CQM_MN_LOOP_4,CQM_MN_LOOP_5,CQM_MN_LOOP_6,CQM_MN_LOOP_7]];
gCS_MN_FNCS = missionNamespace getVariable ["gCS_MN_FNCS", [
		{},
		{},
		{},
		{if (gCS_GC_Handle isEqualTo scriptNull) then {gCS_GC_Handle = [] spawn CRQ_fnc_GC_CollectorLoop;};},
		{},
		{[] call CRQ_fnc_DT_Loop;[] call CRQ_fnc_EN_LightsLoop;},
		{},
		{[] call CRQ_fnc_EN_ClimateLoop;}
]];
gCS_MP_All = missionNamespace getVariable ["gCS_MP_All", 0];
gCS_MP_Broadcast = missionNamespace getVariable ["gCS_MP_Broadcast", if (isDedicated) then {-2} else {0}];
gCS_SyncArrays = missionNamespace getVariable ["gCS_SyncArrays", createHashMap];
gCS_Action = missionNamespace getVariable ["gCS_Action", []];
gCS_GC_Handle = missionNamespace getVariable ["gCS_GC_Handle", scriptNull];
gCS_GC_Group = missionNamespace getVariable ["gCS_GC_Group", grpNull];
gCS_GC_Items = missionNamespace getVariable ["gCS_GC_Items", [[0, []], [0, []]]];
gCS_GC_Queue = missionNamespace getVariable ["gCS_GC_Queue", [[], []]];
gCS_GC_DecayExpress = missionNamespace getVariable ["gCS_GC_DecayExpress", gCS_PM_GC_DecayCorpse * CRQ_GC_EXPRESS];
gCS_GC_DecayDelete = missionNamespace getVariable ["gCS_GC_DecayDelete", gCS_PM_GC_DecayCorpse + CRQ_GC_DELETE];

addMissionEventHandler ["HandleDisconnect", CRQ_EHS_ClientDisconnect];
addMissionEventHandler ["EntityRespawned", CRQ_EHS_ClientRespawn];

call CRQ_fnc_MN_Init;
