
#define CQM_CORPSE_GROUP "[--- CORPSES ---]"

#include "CRA__Main.sqf"
#include "CRA__Item.sqf"
#include "CRA__Vehicle.sqf"
#include "CRA_Item.sqf"
#include "CRA_Vehicle.sqf"
#include "CRA_Main.sqf"

#define CQM_MN_INIT_ZERO CRA_InitPre
#define CQM_MN_INIT_MAIN CRA_Init
#define CQM_CL_CONN CRA_PlayerConnect //params ["_unit", "_id", "_uid", "_name", "_jip"];
#define CQM_CL_DISC CRA_PlayerDisconnect //params ["_unit", "_id", "_uid", "_name"];
#define CQM_CL_SPAWN CRA_PlayerSpawn //params ["_unit","_isRespawn"];
#define CQM_MN_LOOP_0 CRA_Loop
#define CQM_MN_LOOP_1 {}
#define CQM_MN_LOOP_2 {}
#define CQM_MN_LOOP_3 {}
#define CQM_MN_LOOP_4 {}
#define CQM_MN_LOOP_5 {}
#define CQM_MN_LOOP_6 {}
#define CQM_MN_LOOP_7 {}
#define CQM_DT_NIGHT {}
#define CQM_DT_DAY {}
#define CQM_EN_LT_ON CRA_LightsOn
#define CQM_EN_LT_OFF CRA_LightsOff
