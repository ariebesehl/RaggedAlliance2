
// #include "CRQ__DEF__Var.sqf" // scheduled for removal?

#include "CRQAIM.sqf"

#include "CRQ__DEF__Shared.sqf"
#include "CRQ__DEF__Catalog.sqf"
#include "..\CQM\CQM__FNC__Shared.sqf"
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

gCQ_CfgAmmo = configFile >> "CfgAmmo";
gCQ_CfgGlasses = configFile >> "CfgGlasses";
gCQ_CfgMagazines = configFile >> "CfgMagazines";
gCQ_CfgMagazineWells = configFile >> "CfgMagazineWells";
gCQ_CfgVehicles = configFile >> "CfgVehicles";
gCQ_CfgWeapons = configFile >> "CfgWeapons";
gCQ_CfgWeaponThrow = configFile >> "CfgWeapons" >> "Throw";
gCQ_CfgWeaponPut = configFile >> "CfgWeapons" >> "Put";
gCQ_CfgIGUI = configfile >> "RscInGameUI";
gCQ_ObjectAreas = missionNamespace getVariable ["gCQ_ObjectAreas", createHashMap];
gCQ_VecUtil = missionNamespace getVariable ["gCQ_VecUtil", [[[0,0,0],0],CRQ_UT_VU_RADIUS,CRQ_UT_VU_RESOLUTION,true,[]]];
pCQ_AI_Adjust = missionNamespace getVariable ["pCQ_AI_Adjust", []];
pCQ_CL_Connect = missionNamespace getVariable ["pCQ_CL_Connect", (CRQ_SD_TYPES apply {[]})];
pCQ_CL_Data = missionNamespace getVariable ["pCQ_CL_Data", (CRQ_SD_TYPES apply {[]})];

dCRQ_CDAT_DEFAULTS = missionNamespace getVariable ["dCRQ_CDAT_DEFAULTS", CRQ_CDAT_DEFAULTS];
dCRQ_QDAT_DEFAULTS = missionNamespace getVariable ["dCRQ_QDAT_DEFAULTS", CRQ_QDAT_DEFAULTS];
dCRQ_AMMO_DATA = missionNamespace getVariable ["dCRQ_AMMO_DATA", CRQ_AMMO_DATA];
dCRQ_AMMO_LETHALITY = missionNamespace getVariable ["dCRQ_AMMO_LETHALITY", CRQ_AMMO_LETHALITY];
dCRQ_AMMO_TYPES = missionNamespace getVariable ["dCRQ_AMMO_TYPES", createHashMapFromArray CRQ_AMMO_TYPES];
dCRQ_CATEGORY_ASSET_ARMAMENT = missionNamespace getVariable ["dCRQ_CATEGORY_ASSET_ARMAMENT", createHashMapFromArray CRQ_CATEGORY_ASSET_ARMAMENT];
dCRQ_WEAPON_ATTACHMENT_TYPE = missionNamespace getVariable ["dCRQ_WEAPON_ATTACHMENT_TYPE", createHashMapFromArray CRQ_WEAPON_ATTACHMENT_TYPE];
dCQM_QUALITY_PARAMS = missionNamespace getVariable ["dCQM_QUALITY_PARAMS", createHashMapFromArray CQM_QUALITY_PARAMS];
gCQ_CatalogCounterAmmo = missionNamespace getVariable ["gCQ_CatalogCounterAmmo", -1];
gCQ_CatalogCounterItem = missionNamespace getVariable ["gCQ_CatalogCounterItem", -1];
gCQ_CatalogAmmo = missionNamespace getVariable ["gCQ_CatalogAmmo", []];
gCQ_CatalogItem = missionNamespace getVariable ["gCQ_CatalogItem", []];
gCQ_CatalogCategory = missionNamespace getVariable ["gCQ_CatalogCategory", []];
gCQ_CatalogFindAmmo = missionNamespace getVariable ["gCQ_CatalogFindAmmo", createHashMap];
gCQ_CatalogFindItem = missionNamespace getVariable ["gCQ_CatalogFindItem", createHashMap];
gCQ_CatalogQualityParams = missionNamespace getVariable ["gCQ_CatalogQualityParams", []];
pCQ_CatalogItem = missionNamespace getVariable ["pCQ_CatalogItem", []];
