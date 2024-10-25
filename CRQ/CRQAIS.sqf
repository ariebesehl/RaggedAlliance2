
#define CRQAIS 1
#include "CRQAIM.sqf"
params ["_g","","","_v", "_n"];
if (_n >= 0) then {
	private _sf = _g call CRQ_fnc_AI_SAFE;
	if (_sf) then {
		_g setVariable ["CRQP_ORG", false];
		(selectRandom (dCRQ_AI_TMS#_n)) call {
			[_g, _this] call CRQ_fnc_AI_TMO;
			_this call (dCRQ_AI_FNC#_n);
		};
	} else {
		[_g, selectRandom dCRQ_AI_TMC] call CRQ_fnc_AI_TMO;
		if (_g getVariable ["CRQP_ORG", false]) exitWith {};
		_g setVariable ["CRQP_ORG", true];
		_g call CRQ_fnc_AI_BHRG;
	};
	_g setVariable ["CRQP_TGL", _sf isNotEqualTo (_g getVariable ["CRQP_STS", _sf])];
	_g setVariable ["CRQP_STS", _sf];
} else {
	_g spawn {sleep 1; if (_this isEqualTo grpNull) exitWith {}; _this setCurrentWaypoint [_this, 0];};
};
