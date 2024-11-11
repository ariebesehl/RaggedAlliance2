
// #include "CRQ__DEF__Var.sqf" // scheduled for removal?

#include "CRQAIM.sqf"

#include "CRQ__DEF__Shared.sqf"
#include "CRQ__DEF__Catalog.sqf"
#include "..\CQM\CQM__INC__Shared.sqf"
#include "CRQ__FNC__Shared.sqf"
#include "CRQ__FNC__Catalog.sqf"

dCRQ_BS_DWRD = missionNamespace getVariable ["dCRQ_BS_DWRD", [
	CRQ_BS_DWRD apply {false},
	CRQ_BS_DWRD apply {true},
	CRQ_BS_DWRD,
	(CRQ_BS_DWRD apply {_x}) call {reverse _this; _this},
	(CRQ_BS_DWRD apply {2^_x}),
	(CRQ_BS_DWRD apply {2^_x}) call {reverse _this; _this}
]];
dCRQ_BS_WORD = missionNamespace getVariable ["dCRQ_BS_WORD", [
	CRQ_BS_WORD apply {false},
	CRQ_BS_WORD apply {true},
	CRQ_BS_WORD,
	(CRQ_BS_WORD apply {_x}) call {reverse _this; _this},
	(CRQ_BS_WORD apply {2^_x}),
	(CRQ_BS_WORD apply {2^_x}) call {reverse _this; _this}
]];
dCRQ_BS_BYTE = missionNamespace getVariable ["dCRQ_BS_BYTE", [
	CRQ_BS_BYTE apply {false},
	CRQ_BS_BYTE apply {true},
	CRQ_BS_BYTE,
	(CRQ_BS_BYTE apply {_x}) call {reverse _this; _this},
	(CRQ_BS_BYTE apply {2^_x}),
	(CRQ_BS_BYTE apply {2^_x}) call {reverse _this; _this}
]];

dCRQ_CDAT_DEFAULTS = missionNamespace getVariable ["dCRQ_CDAT_DEFAULTS", CRQ_CDAT_DEFAULTS];
dCRQ_QDAT_DEFAULTS = missionNamespace getVariable ["dCRQ_QDAT_DEFAULTS", CRQ_QDAT_DEFAULTS];
dCRQ_AMMO_DATA = missionNamespace getVariable ["dCRQ_AMMO_DATA", CRQ_AMMO_DATA];
dCRQ_AMMO_LETHALITY = missionNamespace getVariable ["dCRQ_AMMO_LETHALITY", CRQ_AMMO_LETHALITY];
dCRQ_AMMO_TYPES = missionNamespace getVariable ["dCRQ_AMMO_TYPES", createHashMapFromArray CRQ_AMMO_TYPES];
dCRQ_CATEGORY_ASSET_ARMAMENT = missionNamespace getVariable ["dCRQ_CATEGORY_ASSET_ARMAMENT", createHashMapFromArray CRQ_CATEGORY_ASSET_ARMAMENT];
dCRQ_WEAPON_ATTACHMENT_TYPE = missionNamespace getVariable ["dCRQ_WEAPON_ATTACHMENT_TYPE", createHashMapFromArray CRQ_WEAPON_ATTACHMENT_TYPE];
dCQM_QUALITY_PARAMS = missionNamespace getVariable ["dCQM_QUALITY_PARAMS", createHashMapFromArray CQM_QUALITY_PARAMS];

pCQ_UT_Vec = missionNamespace getVariable ["pCQ_UT_Vec", [[[0,0,0],0],CRQ_UT_VU_RADIUS,CRQ_UT_VU_RESOLUTION,true,[]]];

pCQ_CFG_World = configFile >> "CfgWorlds" >> worldName;
pCQ_CFG_Ammo = configFile >> "CfgAmmo";
pCQ_CFG_Glasses = configFile >> "CfgGlasses";
pCQ_CFG_Magazines = configFile >> "CfgMagazines";
pCQ_CFG_MagazineWells = configFile >> "CfgMagazineWells";
pCQ_CFG_Vehicles = configFile >> "CfgVehicles";
pCQ_CFG_Weapons = configFile >> "CfgWeapons";
pCQ_CFG_WeaponThrow = configFile >> "CfgWeapons" >> "Throw";
pCQ_CFG_WeaponPut = configFile >> "CfgWeapons" >> "Put";
pCQ_CFG_IGUI = configfile >> "RscInGameUI";

pCQ_OBJ_Footprints = missionNamespace getVariable ["pCQ_OBJ_Footprints", createHashMap];
pCQ_AI_Adjust = missionNamespace getVariable ["pCQ_AI_Adjust", []];

pCQ_CL_Connect = missionNamespace getVariable ["pCQ_CL_Connect", (CRQ_SD_TYPES apply {[]})];
pCQ_CL_Data = missionNamespace getVariable ["pCQ_CL_Data", (CRQ_SD_TYPES apply {[]})];

pCQ_CT_CounterAmmo = missionNamespace getVariable ["pCQ_CT_CounterAmmo", -1];
pCQ_CT_CounterItem = missionNamespace getVariable ["pCQ_CT_CounterItem", -1];
pCQ_CT_Ammo = missionNamespace getVariable ["pCQ_CT_Ammo", []];
pCQ_CT_Item = missionNamespace getVariable ["pCQ_CT_Item", []];
pCQ_CT_Category = missionNamespace getVariable ["pCQ_CT_Category", []];
pCQ_CT_FindAmmo = missionNamespace getVariable ["pCQ_CT_FindAmmo", createHashMap];
pCQ_CT_FindItem = missionNamespace getVariable ["pCQ_CT_FindItem", createHashMap];
pCQ_CT_QualityParams = missionNamespace getVariable ["pCQ_CT_QualityParams", []];
pCQ_CT_Client = missionNamespace getVariable ["pCQ_CT_Client", []];

gCQ_LNK_LIST = missionNamespace getVariable ["gCQ_LNK_LIST", createHashMap];
gCQ_LNK_FNCH = missionNamespace getVariable ["gCQ_LNK_FNCH", [{[_this#0, "CRQP_NGLNK", _this#1] call CRQ_VarGet}, {[_this#0, "CRQP_NGLNK", _this#1] call CRQ_VarSet}, {[_this#0, "CRQP_NGLNK"] call CRQ_VarFree}]];
gCQ_LNK_FNCO = missionNamespace getVariable ["gCQ_LNK_FNCO", [{(_this#0) getVariable ["CRQP_NGLNK", _this#1]}, {(_this#0) setVariable ["CRQP_NGLNK", _this#1]}, {(_this#0) set ["CRQP_NGLNK", nil]}]];
