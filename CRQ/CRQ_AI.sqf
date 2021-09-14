
#include "CRQ__AI.sqf"

CRQ_AI_SafeGroup = {
	combatBehaviour _this isEqualTo "SAFE"
};
CRQ_AI_Timeout = {
	params ["_group", "_timeout"];
	[_group, currentWaypoint _group] setWaypointTimeout _timeout;
};
CRQ_AI_SquadRegroup = {
	private _leader = leader _this;
	{_x doFollow _leader;} forEach (units _this);
};
CRQ_AI_SquadScatter = {
	params ["_group", "_pos"];
	{doStop _x; if ([false,true] selectRandomWeighted [1 - CRQ_AI_SCATTER_PROB,CRQ_AI_SCATTER_PROB]) then {_x doMove (_pos getPos [random [CRQ_AI_SCATTER_DIST_MIN,CRQ_AI_SCATTER_DIST_AVG,CRQ_AI_SCATTER_DIST_MAX], random 360]);};} forEach (units _group);
};
CRQ_AI_SquadRest = {
	{
		if (primaryWeapon _x isNotEqualTo "") then { // exclude pistol-wielders, they immediately stand-up
			if ([false,true] selectRandomWeighted [1 - CRQ_AI_REST_PROB,CRQ_AI_REST_PROB]) then {doStop _x; _x action ["SitDown", _x];};
		};
	} forEach (units _this);
};
CRQ_AI_SquadStop = {
	{doStop _x;} forEach (units _this);
};
/*
CRQ_AI_SafeUnits = {
	private _safe = true;
	{
		if (_safe && !isNull _x) then {
			if (combatBehaviour _x isNotEqualTo "SAFE") then {
				_safe = false;
			};
		};
	} forEach _this;
	_safe
};
CRQ_AI_Safe = {
	((_this call CRQ_AI_SafeGroup) && ((units _this) call CRQ_AI_SafeUnits))
};
CRQ_AI_Engage = {
	systemChat ("CRQ_AI_Engage " + str _this);
	_this call CRQ_AI_SquadRegroup;
	_this call CRQ_AI_DropScripted;
};
CRQ_AI_DropScripted = {
	private _remove = [];
	{if (waypointType _x isEqualTo "SCRIPTED") then {_remove pushBack _forEachIndex;};} forEach waypoints _this;
	reverse _remove;
	{deleteWaypoint [_this, _x];} forEach _remove;
};
*/
