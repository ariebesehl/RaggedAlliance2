
#include "CRQ__AI_Base.sqf"
#define CRQ_fnc_AI_SAFE {((combatBehaviour _this) isEqualTo "SAFE")}
#ifndef CRQ_DEFINE_AISCRIPT
#include "CRQ__AI_Extended.sqf"
dCRQ_AI_TMS = missionNamespace getVariable ["dCRQ_AI_TMS", CRQ_AI_TIMEOUTS];
dCRQ_AI_TMC = missionNamespace getVariable ["dCRQ_AI_TMC", CRQ_AI_TIMEOUT_COMBAT];
dCRQ_AI_AML = missionNamespace getVariable ["dCRQ_AI_AML", (CRQ_AI_MODES select [1, (count CRQ_AI_MODES) - 1])];
dCRQ_AI_ASL = missionNamespace getVariable ["dCRQ_AI_ASL", (CRQ_AI_SPEEDS select [1, (count CRQ_AI_SPEEDS) - 1])];
dCRQ_AI_AFL = missionNamespace getVariable ["dCRQ_AI_AFL", (CRQ_AI_FORM_LIST select [1, (count CRQ_AI_FORM_LIST) - 1])];
dCRQ_AI_FNC = missionNamespace getVariable ["dCRQ_AI_FNC", CRQ_AI_SCRIPT_FNC apply {compile _x}];
dCRQ_AI_fnc_BHXO = missionNamespace getVariable ["dCRQ_AI_fnc_BHXO", {_this params ["_u","_p","_t"]; sleep _t; if (_u call CRQ_fnc_AI_SAFE) then {doStop _u; _u doMove _p;};}];
dCRQ_AI_fnc_BHRS = missionNamespace getVariable ["dCRQ_AI_fnc_BHRS", {_this params ["_u", "_t"]; sleep _t; if (_u call CRQ_fnc_AI_SAFE) then {doStop _u; _u action ["SitDown", _u];};}];
dCRQ_AI_fnc_BHLK = missionNamespace getVariable ["dCRQ_AI_fnc_BHLK", {_this params ["_u","_p","_t"]; sleep _t; if (_u call CRQ_fnc_AI_SAFE) then {_u doWatch _p;};}];
dCRQ_AI_fnc_BHRT = missionNamespace getVariable ["dCRQ_AI_fnc_BHRT", {_this params ["_u", "_p", "_t"]; sleep _t; if (_u call CRQ_fnc_AI_SAFE) then {doStop _u; _u doMove _p;};}];
#endif
CRQ_fnc_AI_STOP = {{doStop _x;} forEach (units _this);};
CRQ_fnc_AI_TMO = {
	params ["_g", "_t"];
	[_g, currentWaypoint _g] setWaypointTimeout _t;
};
CRQ_fnc_AI_STS = {
	params ["_g", ["_f", 0], ["_m", 0], ["_s", 0]];
	if (_f > 0) then {_g setFormation (dCRQ_AI_AFL#(_f - 1));} else {if (_f < 0) then {_g setFormation selectRandom dCRQ_AI_AFL;};};
	if (_m > 0) then {_g setBehaviour (dCRQ_AI_AML#(_m - 1));} else {if (_m < 0) then {_g setBehaviour selectRandom dCRQ_AI_AML;};};
	if (_s > 0) then {_g setSpeedMode (dCRQ_AI_ASL#(_s - 1));} else {if (_s < 0) then {_g setSpeedMode selectRandom dCRQ_AI_ASL;};};
};
CRQ_fnc_AI_BHRG = {
	if (random 1 < CRQ_AI_BHRG_P0) then {[_this, -1] call CRQ_fnc_AI_STS;};
	private _l = leader _this;
	{_x doFollow _l;} forEach (units _this);
};
CRQ_fnc_AI_BHXO = {
	params ["_g", "_v", "_t"];
	private _P = _v#0;
	{if (random 1 < CRQ_AI_BHXO_P0) then {[_x, _p getPos [random CRQ_AI_BHXO_P1, random 360], random _t] spawn dCRQ_AI_fnc_BHXO;};} forEach (units _g);
};
CRQ_fnc_AI_BHRS = {
	params ["_g", "_t"];
	{if (random 1 < CRQ_AI_BHRS_P0) then {[_x, random _t] spawn dCRQ_AI_fnc_BHRS;};} forEach (units _g);
};
CRQ_fnc_AI_BHLK = {
	params ["_g", "_v", "_t"];
	private _P = _v#0;
	{doStop _x; [_x, _p getPos [random CRQ_AI_BHLK_P0, (getDir _x) + random CRQ_AI_BHLK_P1], random _t] spawn dCRQ_AI_fnc_BHLK;} forEach (units _g);
};
CRQ_fnc_AI_BHBN = {
	{private _b = binocular _x; if (_b isNotEqualTo "") then {_x selectWeapon _b;};} forEach (units _this);
};
CRQ_fnc_AI_SET = {
	params ["_u", "_i", "_p"];
	(_u getVariable ["CRQP_AI", scriptNull]) call {if (_this isNotEqualTo scriptNull) then {terminate _this;};};
	_u setVariable ["CRQP_AI", _p spawn _i];
};
CRQ_fnc_AI_BHRT = {
	params ["_g", "_v", "_t"];
	private _l = leader _g;
	private _p = (_v#0) vectorAdd [CRQ_AI_BHRT_P1, CRQ_AI_BHRT_P1, 0];
	{if (_x isEqualTo _l || {random 1 < CRQ_AI_BHRT_P0}) then {[_x, dCRQ_AI_fnc_BHRT, [_x, _p vectorAdd [random CRQ_AI_BHRT_P2, random CRQ_AI_BHRT_P2, 0], random _t]] call CRQ_fnc_AI_SET;};} forEach (units _g);
};
