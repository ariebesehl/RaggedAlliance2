
#include "CRA__Shared.sqf"

CRA_Paradrop = {
	params ["_unit", "_vector"];
	(_vector#0) set [2, CRA_PARADROP_HEIGHT];
	private _parachute = createVehicle ["Steerable_Parachute_F", _vector#0, [], 0, "CAN_COLLIDE"];
	_parachute setDir (_vector#1);
	sleep 0.01;
	_unit moveInAny _parachute;
};