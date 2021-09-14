
#include "CRQ_AI.sqf"

_this params ["_group", "_position", "_target", "_type"];

if (_type != CRQ_AI_SCRIPT_RESTART) then {
	if (_group call CRQ_AI_SafeGroup) then {
		_group setVariable ["disorganized", true];
		switch (_type) do {
			case CRQ_AI_SCRIPT_WAIT: {
				[_group, selectRandom CRQ_AI_TIMEOUT_WAIT] call CRQ_AI_Timeout;
			};
			case CRQ_AI_SCRIPT_REGROUP: {
				[_group, selectRandom CRQ_AI_TIMEOUT_REGROUP] call CRQ_AI_Timeout;
				_group call CRQ_AI_SquadRegroup;
			};
			case CRQ_AI_SCRIPT_SCATTER: {
				[_group, selectRandom CRQ_AI_TIMEOUT_SCATTER] call CRQ_AI_Timeout;
				[_group, _position] call CRQ_AI_SquadScatter;
			};
			case CRQ_AI_SCRIPT_REST: {
				[_group, selectRandom CRQ_AI_TIMEOUT_REST] call CRQ_AI_Timeout;
				_group call CRQ_AI_SquadRest;
			};
			case CRQ_AI_SCRIPT_STOP: {
				[_group, selectRandom CRQ_AI_TIMEOUT_STOP] call CRQ_AI_Timeout;
				_group call CRQ_AI_SquadStop;
			};
			default {};
		};
	} else {
		[_group, CRQ_AI_TIMEOUT_COMBAT] call CRQ_AI_Timeout;
		if (_group getVariable ["disorganized", true]) then {
			_group setVariable ["disorganized", false];
			_group call CRQ_AI_SquadRegroup;
		};
	};
} else {
	_group setCurrentWaypoint [_group, 0];
};
