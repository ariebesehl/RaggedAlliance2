
CRA_fnc_PLL_Paradrop = {
	params ["_unit", "_vec"];
	(_vec#0) set [2, CRA_PARADROP_HEIGHT - (getTerrainHeightASL (_vec#0) min 0)];
	private _parachute = [CRA_PARADROP_ASSET, _vec] call CRQ_ObjectSpawn;
	sleep 0.01;
	_unit moveInAny _parachute;
};
CRA_fnc_PLL_Teleport = {
	params ["_unit", "_vec"];
	_unit setDir (_vec#1);
	_unit setPos (_vec#0);
};
