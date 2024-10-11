
#define CRQ_DEFINE_AISCRIPT 1

#include "CRQ_AI_Main.sqf"

params ["_g","","","_v", "_n"];

if (_n >= 0) then {
	if (_g call CRQ_AI_Safe) then {
		_g setVariable [CRQ_AIVAR_ORGANIZED, false];
		(selectRandom (dCRA_AI_TIMEOUTS#_n)) call ([
			{[_g, _this] call CRQ_AI_Timeout;},
			{[_g, _this] call CRQ_AI_Timeout; _g call CRQ_AI_Regroup;},
			{[_g, _this] call CRQ_AI_Timeout; [_g, _v, _this#0] call CRQ_AI_Scatter;},
			{[_g, _this] call CRQ_AI_Timeout; [_g, _this#0] call CRQ_AI_Rest;},
			{[_g, _this] call CRQ_AI_Timeout; _g call CRQ_AI_Stop;},
			{[_g, _this] call CRQ_AI_Timeout; [_g, _v, _this#0] call CRQ_AI_Look;},
			{[_g, _this] call CRQ_AI_Timeout; _g call CRQ_AI_Bino;},
			{[_g, _this] call CRQ_AI_Timeout; [_g, _v, _this#0] call CRQ_AI_Return;}
		]#_n);
	} else {
		[_g, selectRandom CRQ_AI_TIMEOUT_COMBAT] call CRQ_AI_Timeout;
		if (_g getVariable [CRQ_AIVAR_ORGANIZED, false]) exitWith {};
		_g setVariable [CRQ_AIVAR_ORGANIZED, true];
		_g call CRQ_AI_Regroup;
	};
} else {
	_g spawn {sleep CRQ_AI_RESTART_DELAY; _this setCurrentWaypoint [_this, 0];};
};
