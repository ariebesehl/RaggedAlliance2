
#include "CRQ__AI_Base.sqf"

#ifndef CRQ_DEFINE_AISCRIPT
#include "CRQ__AI_Extended.sqf"
#endif

dCRA_AI_TIMEOUTS = missionNamespace getVariable ["dCRA_AI_TIMEOUTS", CRQ_AI_TIMEOUTS];

CRQ_AI_Safe = {
	((combatBehaviour _this) isEqualTo "SAFE")
};
CRQ_AI_Timeout = {
	params ["_g", "_t"];
	[_g, currentWaypoint _g] setWaypointTimeout _t;
};
CRQ_AI_Behaviour = {
	params ["_g", ["_f", CRQ_AI_FORM_UNCHANGED], ["_m", CRQ_AI_MODE_UNCHANGED], ["_s", CRQ_AI_SPEED_UNCHANGED]];
	if (_f != CRQ_AI_FORM_UNCHANGED) then {_g setFormation (if (_f == CRQ_AI_FORM_RANDOM) then {CRQ_AI_FORM_LIST selectRandomWeighted CRQ_AI_FORM_WEIGHT} else {CRQ_AI_FORM_LIST#_f});};
	_g setBehaviour (CRQ_AI_MODES#_m);
	_g setSpeedMode (CRQ_AI_SPEEDS#_s);
};
CRQ_AI_Regroup = {
	if (random 1 < CRQ_AI_REGROUP_FORM_PROB) then {[_this, CRQ_AI_FORM_RANDOM] call CRQ_AI_Behaviour;};
	private _l = leader _this;
	{_x doFollow _l;} forEach (units _this);
};
CRQ_AI_Scatter = {
	params ["_g", "_v", "_t"];
	private _P = _v#0;
	{if (random 1 < CRQ_AI_SCATTER_PROB) then {[_x, _p getPos [random CRQ_AI_SCATTER_DIST, random 360], random _t] spawn {params ["_u","_p","_t"]; sleep _t; doStop _u; _u doMove _p;};};} forEach (units _g);
};
CRQ_AI_Rest = {
	params ["_g", "_t"];
	{if (random 1 < CRQ_AI_REST_PROB) then {[_x, random _t] spawn {params ["_u", "_t"]; sleep _t; doStop _u; _u action ["SitDown", _u];};};} forEach (units _g);
};
CRQ_AI_Stop = {
	{doStop _x;} forEach (units _this);
};
CRQ_AI_Look = {
	params ["_g", "_v", "_t"];
	private _P = _v#0;
	{doStop _x; [_x, _p getPos [random CRQ_AI_LOOK_DIST, (getDir _x) + random CRQ_AI_LOOK_DIR], random _t] spawn {params ["_u","_p","_t"]; sleep _t; _u doWatch _p;};} forEach (units _g);
};
CRQ_AI_Bino = {
	{private _b = binocular _x; if (_b isNotEqualTo "") then {_x selectWeapon _b;};} forEach (units _this);
};
CRQ_AI_Return = {
	params ["_g", "_v", "_t"];
	private _l = leader _g;
	private _p = (_v#0) vectorAdd [CRQ_AI_RETURN_SCATTER_0,CRQ_AI_RETURN_SCATTER_0,0];
	{if (_x isEqualTo _l || {random 1 < CRQ_AI_RETURN_PROB}) then {[_x, _p vectorAdd [random CRQ_AI_RETURN_SCATTER_1,random CRQ_AI_RETURN_SCATTER_1,0], random _t] spawn {params ["_u","_p","_t"]; sleep _t; doStop _u; _u doMove _p;};};} forEach (units _g);
};
