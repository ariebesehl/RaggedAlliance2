
#include "..\CRA\CRA__INC__Server.sqf"

#define CQM_fnc_MN_InitZero CRA_fnc_MN_InitZero
#define CQM_fnc_MN_InitMain CRA_fnc_MN_InitMain
#define CQM_fnc_MN_Loop_0 CRA_fnc_MN_Loop
#define CQM_fnc_MN_Loop_1 {}
#define CQM_fnc_MN_Loop_2 {}
#define CQM_fnc_MN_Loop_3 {}
#define CQM_fnc_MN_Loop_4 {}
#define CQM_fnc_MN_Loop_5 {}
#define CQM_fnc_MN_Loop_6 {}
#define CQM_fnc_MN_Loop_7 {}

#define CQM_fnc_DT_Night {}
#define CQM_fnc_DT_Day {}
#define CQM_fnc_EN_LightsOn {true call CRA_fnc_EN_LightSwitch}
#define CQM_fnc_EN_LightsOff {false call CRA_fnc_EN_LightSwitch}

#define CQM_fnc_CL_Connect CRA_fnc_PL_Connect //params ["_unit", "_id", "_uid", "_name", "_jip"];
#define CQM_fnc_CL_Disconnect CRA_fnc_PL_Disconnect //params ["_unit", "_id", "_uid", "_name"];
#define CQM_fnc_CL_Spawn CRA_fnc_PL_Spawn //params ["_unit","_isRespawn"];
