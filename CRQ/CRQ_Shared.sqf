
#include "CRQ__Var.sqf"
#include "CRQ__Shared.sqf"
#include "CRQ__Catalog.sqf"

#include "..\CQM\CQM__FNC__Shared.sqf"

#include "CRQ_AI_Main.sqf"
#include "CRQ_Catalog.sqf"

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
gCQ_VecUtil = missionNamespace getVariable ["gCQ_VecUtil", [[[0,0,0],0],CRQ_VU_RADIUS,CRQ_VU_RESOLUTION,true,[]]];

pCQ_AI_Adjust = missionNamespace getVariable ["pCQ_AI_Adjust", []];
pCQ_CL_Connect = missionNamespace getVariable ["pCQ_CL_Connect", (CRQ_SIDES apply {[]})];
pCQ_CL_Data = missionNamespace getVariable ["pCQ_CL_Data", (CRQ_SIDES apply {[]})];

CRQ_fnc_ObjectIsUnit = {
	(_this isEqualType objNull && {_this isKindOf "Man"})
};
CRQ_fnc_TimeNow = {
	systemTimeUTC call {(_this#3) * 3600.0 + (_this#4) * 60.0 + (_this#5) + ((_this#6) / 1000.0)};
};
CRQ_fnc_TimeCoerce = {
	(((_this % 86400.0) + 86400.0) % 86400.0)
};
CRQ_fnc_TimeDelta = {
	_this = ((_this param [1, [] call CRQ_fnc_TimeNow, [0]]) call CRQ_fnc_TimeCoerce) - ((_this param [0, [] call CRQ_fnc_TimeNow, [0]]) call CRQ_fnc_TimeCoerce);
	if (_this < 0) then {_this + 86400.0} else {_this};
};
CRQ_fnc_WordEncode = {
	private _cache = dCRQ_BS_WORD#4;
	private _word = 0;
	{if (_x) then {_word = _word + (_cache#_forEachIndex);};} forEach _this;
	_word
};
CRQ_fnc_ByteEncode = {
	private _cache = dCRQ_BS_BYTE#4;
	private _byte = 0;
	{if (_x) then {_byte = (_cache#_forEachIndex) + _byte;};} forEach _this;
	_byte
};
CRQ_fnc_WordDecode = {
	private _bits = +(dCRQ_BS_WORD#0);
	{if (_this >= _x) then {_this = _this - _x; _bits set [15 - _forEachIndex, true];};} forEach (dCRQ_BS_WORD#5);
	_bits
};
CRQ_fnc_ByteDecode = {
	private _bits = +(dCRQ_BS_BYTE#0);
	{if (_this >= _x) then {_this = _this - _x; _bits set [7 - _forEachIndex, true];};} forEach (dCRQ_BS_BYTE#5);
	_bits
};
CRQ_fnc_ByteSum = {
	private _sum = 0;
	{if (_x) then {_sum = _sum + 1;};} forEach (if (_this isEqualType -1) then {_this call CRQ_fnc_ByteDecode} else {_this});
	_sum
};
CRQ_fnc_ByteLSB = {
	private _index = 0;
	private _bits = if (_this isEqualType -1) then {_this call CRQ_fnc_ByteDecode} else {_this};
	{private _bit = _bits#_x; if ((!isNil {_bit}) && {_bit}) exitWith {_index = _x;};} forEach (dCRQ_BS_BYTE#2);
	_index
};
CRQ_fnc_ByteMSB = {
	private _index = 0;
	private _bits = if (_this isEqualType -1) then {_this call CRQ_fnc_ByteDecode} else {_this};
	{private _bit = _bits#_x; if ((!isNil {_bit}) && {_bit}) exitWith {_index = _x;};} forEach (dCRQ_BS_BYTE#3);
	_index
};
CRQ_fnc_ByteOr = {
	((_this#0) call CRQ_fnc_ByteDecode) params [["_b0_0", false], ["_b0_1", false], ["_b0_2", false], ["_b0_3", false], ["_b0_4", false], ["_b0_5", false], ["_b0_6", false], ["_b0_7", false]];
	((_this#1) call CRQ_fnc_ByteDecode) params [["_b1_0", false], ["_b1_1", false], ["_b1_2", false], ["_b1_3", false], ["_b1_4", false], ["_b1_5", false], ["_b1_6", false], ["_b1_7", false]];
	([_b0_0 || _b1_0, _b0_1 || _b1_1, _b0_2 || _b1_2, _b0_3 || _b1_3, _b0_4 || _b1_4, _b0_5 || _b1_5, _b0_6 || _b1_6, _b0_7 || _b1_7] call CRQ_fnc_ByteEncode)
};
CRQ_fnc_ByteAnd = {
	((_this#0) call CRQ_fnc_ByteDecode) params [["_b0_0", false], ["_b0_1", false], ["_b0_2", false], ["_b0_3", false], ["_b0_4", false], ["_b0_5", false], ["_b0_6", false], ["_b0_7", false]];
	((_this#1) call CRQ_fnc_ByteDecode) params [["_b1_0", false], ["_b1_1", false], ["_b1_2", false], ["_b1_3", false], ["_b1_4", false], ["_b1_5", false], ["_b1_6", false], ["_b1_7", false]];
	([_b0_0 && _b1_0, _b0_1 && _b1_1, _b0_2 && _b1_2, _b0_3 && _b1_3, _b0_4 && _b1_4, _b0_5 && _b1_5, _b0_6 && _b1_6, _b0_7 && _b1_7] call CRQ_fnc_ByteEncode)
};
CRQ_CRC = {
	params ["_data", ["_crc", CRQ_CRC_INIT]];
	{_crc = (_crc + _x) % CRQ_CRC_MODULO;} forEach (toArray (str _data));
	_crc
};
CRQ_CacheLoad = {
	params ["_source", "_target", "_default", ["_crc", CRQ_CRC_INIT]];
	private _var = profileNamespace getVariable [_source, _default];
	missionNamespace setVariable [_target, _var];
	([_var, _crc] call CRQ_CRC)
};
CRQ_CacheSave = {
	params ["_source", "_target", "_default", ["_crc", CRQ_CRC_INIT]];
	private _var = missionNamespace getVariable [_source, _default];
	profileNamespace setVariable [_target, _var];
	([_var, _crc] call CRQ_CRC)
};
CRQ_fnc_VarAvailable = {
	(isNil {(_this#0) getVariable [(_this#1), nil]})
};
CRQ_VarRetrieve = {
	(createHashMapFromArray ((allVariables _this) apply {[toLowerANSI _x, _this getVariable [_x, nil]]}))
};
CRQ_VarRestore = {
	params ["_target", "_vars"];
	{_target setVariable [_x, _y];} forEach _vars;
};
CRQ_VarGet = {
	params ["_vars", "_name", ["_default", nil]];
	(_vars getOrDefault [toLowerANSI _name, _default])
};
CRQ_VarSet = {
	params ["_vars", "_name", "_value"];
	_vars set [toLowerANSI _name, _value, false];
};
CRQ_Wait = {
	private _start = time;
	while {(time - _start) <  _this} do {sleep CRQ_TIME_WAIT;};
};
CRQ_ISO8601Short = {
	params ["_date", ["_separator", "-"], ["_yearFull", true]];
	_date params ["_year", "_month", "_day"];
	(str (if (_yearFull) then {_year} else {_year % 100}) + _separator + (if (_month < 10) then {"0" + str _month} else {str _month}) + _separator + (if (_day < 10) then {"0" + str _day} else {str _day}))
};
CRQ_ISO8601Full = {
	params ["_date", ["_sepDate", "-"], ["_sepTime", ":"], ["_sepISO", " "]];
	_date params ["_year", "_month", "_day", ["_hour", 0], ["_minute", 0], ["_second", 0]];
	(str _year + _sepDate + (if (_month < 10) then {"0" + str _month} else {str _month}) + _sepDate + (if (_day < 10) then {"0" + str _day} else {str _day}) + _sepISO + (if (_hour < 10) then {"0" + str _hour} else {str _hour}) + _sepTime + (if (_minute < 10) then {"0" + str _minute} else {str _minute}) + _sepTime + (if (_second < 10) then {"0" + str _second} else {str _second}))
};
CRQ_ArrayIncrement = {
	params ["_array", "_index", ["_increment", 1]];
	_array set [_index, (_array#_index) + _increment];
};
CRQ_ArrayRandomize = {
	private _reservoir = [];
	{_reservoir pushBack _forEachIndex;} forEach _this;
	private _randomized = [];
	{_randomized pushBack (_this#(_reservoir deleteAt (floor (random (count _reservoir)))));} forEach _this;
	_randomized
};
CRQ_Angle = {
	private _bigger = selectMax _this;
	private _smaller = selectMin _this;
	selectMin [_bigger - _smaller, 360 - _bigger + _smaller]
};
CRQ_AngleAvg = {
	private _distX = 0;
	private _distY = 0;
	{
		_distX = _distX + (sin (_x#0)) * (_x#1);
		_distY = _distY + (cos (_x#0)) * (_x#1);
	} forEach _this;
	((_distX atan2 _distY) + 180)
};
CRQ_Pos2D = {
	private _pos = getPosWorld _this;
	_pos deleteAt 2;
	_pos
};
/*
CRQ_Pos3D = {
	private _pos = getPosWorld _this;
	_pos set [2, (getPosATL _this)#2];
	_pos
};
*/
CRQ_Pos3D = {
	private _pos = getPosWorld _this;
	_pos set [2, ((getPosATL _this)#2) + (0 min (getTerrainHeightASL _pos))];
	_pos
};
CRQ_PosGroup = {
	private _pos = getPosWorld (leader _this);
	_pos deleteAt 2;
	_pos
};
CRQ_PosClosest = {
	params ["_pos", "_candidates"];
	private _best = 1e10;
	private _index = -1;
	{private _dist = _pos distance2D _x; if (_dist < _best) then {_best = _dist; _index = _forEachIndex;};} forEach _candidates;
	_index
};
CRQ_PosAvg = {
	private _posX = 0;
	private _posY = 0;
	{
		_posX = _posX + (_x#0);
		_posY = _posY + (_x#1);
	} forEach _this;
	private _num = count _this;
	if (_num > 0) then {[_posX / _num, _posY / _num]} else {[]};
};
CRQ_PosAvgObj = {
	private _posX = 0;
	private _posY = 0;
	{
		private _pos = getPosWorld _x;
		_posX = _posX + (_pos#0);
		_posY = _posY + (_pos#1);
	} forEach _this;
	private _num = count _this;
	if (_num > 0) then {[_posX / _num, _posY / _num]} else {[]};
};
CRQ_Vec2D = {
	[_this call CRQ_Pos2D, getDir _this]
};
CRQ_Vec3D = {
	[_this call CRQ_Pos3D, getDir _this]
};
CRQ_VecGroup2D = {
	private _leader = leader _this;
	[_leader call CRQ_Pos2D, formationDirection _leader]
};
CRQ_VecGroup3D = {
	private _leader = leader _this;
	[_leader call CRQ_Pos3D, formationDirection _leader]
};
CRQ_VecDist2D = {
	((_this#0#0) distance2D (_this#1#0))
};
CRQ_VecDist3D = {
	((_this#0#0) vectorDistance (_this#1#0))
};
CRQ_VecClosest2D = {
	params ["_vec", "_candidates"];
	private _best = 1e10;
	private _index = -1;
	private _pos = _vec#0;
	{private _dist = _pos distance2D _x; if (_dist < _best) then {_best = _dist; _index = _forEachIndex;};} forEach (_candidates apply {_x#0});
	_index
};
CRQ_VecClosest3D = {
	params ["_vec", "_candidates"];
	private _best = 1e10;
	private _index = -1;
	private _pos = _vec#0;
	{private _dist = _pos vectorDistance _x; if (_dist < _best) then {_best = _dist; _index = _forEachIndex;};} forEach (_candidates apply {_x#0});
	_index
};
CRQ_VecUtilSetup = {
	params ["_vec", ["_radius", CRQ_VU_RADIUS], ["_resolution", CRQ_VU_RESOLUTION]];
	if (_radius <= 0) then {_radius = CRQ_VU_RADIUS;};
	if (_resolution <= 0) then {_resolution = CRQ_VU_RESOLUTION;};
	gCQ_VecUtil = [if (count (_vec#0) > 2) then {_vec} else {[(_vec#0) + [0], _vec#1]}, _radius, _resolution, true, objNull, -1, getTerrainHeightASL (_vec#0)];
};
CRQ_VecUtilValid = {
	(gCQ_VecUtil#3)
};
CRQ_VecUtilObject = {
	(gCQ_VecUtil#4)
};
CRQ_VecUtilIndex = {
	(gCQ_VecUtil#5)
};
gCQ_VecPos = missionNamespace getVariable ["gCQ_VecPos", [{
	_argPos params [["_posX", 0], ["_posY", 0], ["_posZ", 0]];
	_vec set [0, [_posX, _posY, _posZ]];
	_vec set [1, _argDir];
},{
	_argPos params [["_vecX", 0], ["_vecY", 0], ["_vecZ", 0]];
	_vec set [0, (_vec#0) vectorAdd [_vecX, _vecY, _vecZ]];
	_vec set [1, (_vec#1) + _argDir];
},{
	_argPos params [["_vecDist", 0], ["_vecDir", 0], ["_vecZ", 0]];
	_vecDir = _vecDir + (_vec#1);
	_vec set [0, (_vec#0) vectorAdd [sin _vecDir * _vecDist, cos _vecDir * _vecDist, _vecZ]];
	_vec set [1, (_vec#1) + _argDir];
},{
	_argPos params [["_vecDist", 0], ["_vecDir", 0], ["_vecZ", 0]];
	_vecDir = _vecDir + (_vec#1);
	_vec set [0, [(_vec#0#0) + sin _vecDir * _vecDist, (_vec#0#1) + cos _vecDir * _vecDist, _vecZ]];
	_vec set [1, (_vec#1) + _argDir];
},{
	_argPos params [["_vecDist", 0], ["_vecDir", 0], ["_vecZ", 0]];
	_vecDir = _vecDir + (_vec#1);
	_vec set [0, ((_vec#0) vectorAdd [sin _vecDir * _vecDist, cos _vecDir * _vecDist, _vecZ]) call {_this vectorAdd [0, 0, (gCQ_VecUtil#6) - (getTerrainHeightASL _this)]}];
	_vec set [1, (_vec#1) + _argDir];
},{
	_argPos params [["_criteria", "meadow"], ["_radius", (gCQ_VecUtil#1)], ["_resolution", (gCQ_VecUtil#2)]];
	gCQ_VecUtil set [3, false];
	if (_radius < 0) then {_radius = -_radius * (gCQ_VecUtil#1);};
	private _found = false;
	for "_n" from 1 to CRQ_VU_ATTEMPTS_FIND do {
		private _options = selectBestPlaces [_vec#0, _radius, _criteria, _resolution, 1];
		if (_options isNotEqualTo []) exitWith {
			_vec set [0, _options#0#0];
			switch (_argDir) do {
				default {_vec set [1, _argDir];};
				case -1: {_vec set [1, random 360];};
				case -2: {
					private _roads = (_vec#0) nearRoads _radius; // OPTIMIZE 
					if (_roads isNotEqualTo []) then {
						_vec set [1, (_vec#0) getDir (_roads#([(_vec#0), _roads] call CRQ_PosClosest))];
					} else {
						_vec set [1, random 360];
					};
				};
			};
			gCQ_VecUtil set [3, true];
			_found = true;
		};
		if (_found) exitWith {};
	};
},{
	_argPos params [["_clearance", 5], ["_radiusMin", 0], ["_radiusMax", gCQ_VecUtil#1]];
	gCQ_VecUtil set [3, false];
	if (_radiusMin < 0) then {_radiusMin = -_radiusMin * (gCQ_VecUtil#1);};
	if (_radiusMax < 0) then {_radiusMax = -_radiusMax * (gCQ_VecUtil#1);};
	private _radiusVar = _radiusMax - _radiusMin;
	private _posBase = [_vec#0#0, _vec#0#1, 0];
	private _attempt = 0;
	private _found = false;
	for "_n" from 1 to CRQ_VU_ATTEMPTS_EMPTY do {
		private _dir = random 360;
		private _dist = _radiusMin + (random _radiusVar);
		(_posBase vectorAdd [sin _dir * _dist, cos _dir * _dist, 0]) call { // derived from BIS_fnc_findSafePos
			if ((_this isFlatEmpty [-1, -1, -1, 1, 0, false]) isEqualTo []) exitWith {};
			if ((nearestTerrainObjects [_this, [], _clearance, false, true]) isNotEqualTo []) exitWith {};
			private _posASL = AGLToASL _this;
			if ((lineIntersectsSurfaces [_posASL, _posASL vectorAdd [0, 0, 50], objNull, objNull, false, 1, "GEOM", "NONE"]) isNotEqualTo []) exitWith {};
			_vec set [0, _this];
			gCQ_VecUtil set [3, true];
			_found = true;
		};
		if (_found) exitWith {};
	};
},{
	_argPos params [["_types", []], ["_closest", false], ["_radius", gCQ_VecUtil#1]];
	gCQ_VecUtil set [3, false];
	gCQ_VecUtil set [4, objNull];
	gCQ_VecUtil set [5, -1];
	if (_radius < 0) then {_radius = -_radius * (gCQ_VecUtil#1);};
	private _found = [];
	private _houses = nearestTerrainObjects [_vec#0, ["HOUSE"], _radius, _closest, true];
	if (_types isNotEqualTo []) then {
		if (_closest) exitWith {
			{
				private _type = typeOf _x;
				private _index = _types findIf {_type == _x};
				if (_index != -1) exitWith {_found = [_x, _index];};
			} forEach _houses;
		};
		private _candidates = [];
		{
			private _type = typeOf _x;
			private _index = _types findIf {_type == _x};
			if (_index != -1) then {_candidates pushBack [_x, _index];};
		} forEach _houses;
		if (_candidates isNotEqualTo []) then {_found = selectRandom _candidates;};
	} else {
		if (_closest) exitWith {_found = [_houses#0, -1];};
		_found = [selectRandom _houses, -1];
	};
	if (_found isEqualTo []) exitWith {};
	_vec = (_found#0) call CRQ_Vec3D;
	gCQ_VecUtil set [3, true];
	gCQ_VecUtil set [4, _found#0];
	gCQ_VecUtil set [5, _found#1];
}]];
/*
gCQ_VecDir = missionNamespace getVariable ["gCQ_VecDir", [{
	_vec set [1, _argDir];
},{
	_vec set [1, (_vec#1) + _argDir];
},{
	_vec set [1, random 360];
},{
	private _roads = (_vec#0) nearRoads _radius; // OPTIMIZE 
	if (_roads isNotEqualTo []) then {
		_vec set [1, (_vec#0) getDir (_roads#([(_vec#0), _roads] call CRQ_PosClosest))];
	} else {
		_vec set [1, random 360];
	};
}]];
*/
CRQ_VecUtil = {
	private _vec = +(gCQ_VecUtil#0);
	{
		_x params ["_mode", ["_argPos", []], ["_argDir", 0]];
		[] call (gCQ_VecPos#_mode); // TODO inhibit continue if Valid == false
		//if (_argDir isEqualType -1) then {_vec set [1, _argDir];} else {[] call (gCQ_VecDir#(_argDir#0));}; // TODO 
	} forEach _this;
	_vec
};
CRQ_VecRasterize = {
	params ["_setup", "_sources"];
	_setup call CRQ_VecUtilSetup;
	private _rasterized = [];
	{private _vec = _x call CRQ_VecUtil; if (!([] call CRQ_VecUtilValid)) exitWith {}; _rasterized pushBack _vec;} forEach _sources;
	_rasterized
};
CRQ_AreaCorners = {
	params ["_vec", "_area"];
	(_vec#0) params ["_posX", "_posY"];
	private _angle = ((_area#0) atan2 (_area#1));
	private _radius = sqrt ((_area#0) ^ 2 + (_area#1) ^ 2);
	private _dir0 = _vec#1;
	private _dir1 = _dir0 + 180;
	[_dir0 - _angle, _dir0 + _angle, _dir1 - _angle, _dir1 + _angle] apply {[_posX + sin _x * _radius, _posY + cos _x * _radius]}
};
CRQ_AreaOffsetRotate = {
	params ["_offset", "_dir"];
	private _dist = sqrt ((_offset#0) ^ 2 + (_offset#1) ^ 2);
	private _angle = ((_offset#0) atan2 (_offset#1)) + _dir;
	[sin _angle * _dist, cos _angle * _dist]
};
CRQ_AreaMinMax = {
	params ["_size", "_center"];
	private _x0 = (_size#0) - (_center#0);
	private _x1 = (_size#0) + (_center#0);
	private _y0 = (_size#1) - (_center#1);
	private _y1 = (_size#1) + (_center#1);
	[[_x0 min _x1, _y0 min _y1],[_x0 max _x1, _y0 max _y1]]
};
CRQ_AreaIntersect = { // WARNING: input coordinates MUST be in 2D format!
	params ["_bsCorner", "_bsOffset", "_bsLine", "_bsVector","_objCorner", "_objLine"];
	private _intersect = false;
	private _fnc_side = {
		private _n = ((_this#0) vectorCrossProduct (_this#1))#2;
		if (_n < 0) exitWith {-1};
		if (_n > 0) exitWith {1};
		0
	};
	private _fnc_line = { // TODO optimize this with existing vectors and offsets
		params ["_l0", "_l1"];
		_l0 params ["_p0", "_p1"];
		_l1 params ["_q0", "_q1"];
		private _sub0 = _p0 vectorMultiply -1;
		private _v0 = _p1 vectorAdd _sub0;
		private _c00 = _q0 vectorAdd _sub0;
		private _c01 = _q1 vectorAdd _sub0;
		private _cp00 = ((_v0 vectorCrossProduct _c00)#2) call {if (_this < 0) exitWith {-1}; if (_this > 0) exitWith {1}; 0};
		private _cp01 = ((_v0 vectorCrossProduct _c01)#2) call {if (_this < 0) exitWith {-1}; if (_this > 0) exitWith {1}; 0};
		if (_cp00 == 0) exitWith {true};
		if (_cp00 == _cp01) exitWith {false};
		private _sub1 = _q0 vectorMultiply -1;
		private _v1 = _q1 vectorAdd _sub1;
		private _c10 = _p0 vectorAdd _sub1;
		private _c11 = _p1 vectorAdd _sub1;
		private _cp10 = ((_v1 vectorCrossProduct _c10)#2) call {if (_this < 0) exitWith {-1}; if (_this > 0) exitWith {1}; 0};
		private _cp11 = ((_v1 vectorCrossProduct _c11)#2) call {if (_this < 0) exitWith {-1}; if (_this > 0) exitWith {1}; 0};
		if (_cp10 != _cp11 || {_cp10 == 0}) exitWith {true};
		false
	};
	{
		_intersect = true;
		private _corner = _x;
		{if (([_x, _corner vectorAdd (_bsOffset#_forEachIndex)] call _fnc_side) > 0) exitWith {_intersect = false;};} forEach _bsVector;
		if (_intersect) exitWith {};
	} forEach _objCorner;
	if (_intersect) exitWith {true};
	{
		_intersect = true;
		private _corner = _x;
		{
			private _objOffset = (_x#0) vectorMultiply -1;
			private _objVector = (_x#1) vectorAdd _objOffset;
			if (([_objVector, _corner vectorAdd _objOffset] call _fnc_side) > 0) exitWith {_intersect = false;};
		} forEach _objLine;
		if (_intersect) exitWith {};
	} forEach _bsCorner;
	if (_intersect) exitWith {true};
	{
		private _line = _x;
		{if ([_line, _x] call _fnc_line) exitWith {_intersect = true;};} forEach _objLine;
		if (_intersect) exitWith {};
	} forEach _bsLine;
	_intersect
};
CRQ_Lights = {
	(CRQ_LIGHT_POS getEnvSoundController "night" > CRQ_LIGHT_THOLD)
};
CRQ_WorldLocations = {
	private _axis = worldSize / 2; // worldSize is a calculation, config >> worldName might be faster? probably hardly makes a difference
	nearestLocations [[_axis, _axis], _this, 1.42 * _axis, [0, 0]]
};
CRQ_WorldTerrainObjects = {
	private _axis = worldSize / 2;
	nearestTerrainObjects [[_axis, _axis], _this, 1.42 * _axis, false, true]
};
CRQ_WorldClutter2D = {
	params ["_vec", "_radius", ["_ignore", []], ["_radiusExtra", CRQ_CLUTTER_EXTRA], ["_collision", false]];
	private _clutter = [];
	if (_radius isEqualType -1) exitWith {
		private _pos = _vec#0;
		{if (_ignore find _x == -1 && {(_pos distance2D _x) < (_radius + ((_x call CRQ_ObjectSize)#0))}) then {_clutter pushBack _x;};} forEach (nearestTerrainObjects [_pos, [], _radius + _radiusExtra, false, true]);
		_clutter
	};
	private _fnc_Corners = if (_collision) then {CRQ_ObjectCollisionCorners2D} else {CRQ_ObjectCorners2D};
	private _areaCorners = [_vec, _radius] call CRQ_AreaCorners;
	private _areaOffsets = _areaCorners apply {(_x vectorMultiply -1)};
	private _areaLines = _areaCorners call {[[_this#0, _this#1], [_this#1, _this#2], [_this#2, _this#3], [_this#3, _this#0]]};
	private _areaVectors = _areaLines apply {(_x#1) vectorAdd ((_x#0) vectorMultiply -1)};
	{
		private _obj = _x;
		if (_ignore find _obj == -1) then {
			private _intersect = false;
			private _objCorners = _obj call _fnc_Corners;
			private _objLines = _objCorners call {[[_this#0, _this#1], [_this#1, _this#2], [_this#2, _this#3], [_this#3, _this#0]]};
			if ([_areaCorners, _areaOffsets, _areaLines, _areaVectors, _objCorners, _objLines] call CRQ_AreaIntersect) then {_clutter pushBack _obj;};
		};
	} forEach (nearestTerrainObjects [_vec#0, [], (selectMax _radius) + _radiusExtra, false, true]);
	_clutter
	
};
CRQ_LocationCreate = {
	params ["_vec", "_name", "_label", ["_type", CRQ_LOCATION_TYPE], ["_size", CRQ_LOCATION_SIZE]];
	private _location = createLocation [_type, _vec#0, _size#0, _size#1];
	_location setRectangular true;
	_location setDirection (_vec#1);
	_location setName _name;
	_location setText _label;
	_location
};
CRQ_ObjectCorners2D = {
	(_this call CRQ_Pos2D) params ["_objX", "_objY"];
	(_this call CRQ_ObjectSize) params ["_radius", "_size"];
	private _angle = ((_size#0) atan2 (_size#1));
	private _dir0 = getDir _this;
	private _dir1 = _dir0 + 180;
	[_dir0 - _angle, _dir0 + _angle, _dir1 - _angle, _dir1 + _angle] apply {[_objX + sin _x * _radius, _objY + cos _x * _radius]}
};
CRQ_ObjectCollisionCorners2D = { // TODO does not work with Razor Wire -- is this by design, or is the razor wire too finely meshed?
	if (_this isEqualTo objNull) exitWith {[]};
	
	private _model = toLowerANSI (_this call CRQ_ObjectModel);
	private _scale = getObjectScale _this;
	private _existing = gCQ_ObjectAreas getOrDefault [_model, []];
	if (_existing isNotEqualTo []) exitWith {[_this call CRQ_Vec2D, [(_existing#0) * _scale, (_existing#1) * _scale]] call CRQ_AreaCorners};
	
	(getPosWorld _this) params ["_objX", "_objY", "_objZ"];
	((_this call CRQ_ObjectSize)#1) params ["_objL", "_objW", "_objH"];
	private _top = _objZ + _objH;
	private _bot = _objZ - _objH;
	private _dir0 = getDir _this;
	private _dir1 = _dir0 + 180;
	
	_objL = _objL / 2;
	_objW = _objW / 2;
	
	private _facL = [_dir0, _dir1] apply {[cos _x, sin _x]};
	private _facW = [_dir0, _dir1] apply {[sin _x, cos _x]};
	private _l = _objL / 2;
	private _w = _objW / 2;
	
	private _points = [];
	
	{
		_x params ["_dim", "_fac", "_fnc_fac", "_fnc_inc"];
		private _f = 0.5;
		private _fC = 0;
		private _fNC = 1;
		for "_i" from 0 to (ceil ((ln (_dim / CRQ_COLLISION_RES)) / (ln 2))) do { // TODO not entirely sure if ceil, round or floor
			private _angle = _l atan2 _w;
			private _d = sqrt (_l ^ 2 + _w ^ 2);
			_points = ([_dir0 - _angle, _dir0 + _angle, _dir1 - _angle, _dir1 + _angle] apply {[sin _x, cos _x]}) apply {[_objX + (_x#0) * _d, _objY + (_x#1) * _d]};
			private _collision = false;
			{{if (_x isEqualTo _this) exitWith {_collision = true;};} forEach (lineIntersectsObjs _x);} forEach (((_fac apply _fnc_fac) + _points) apply {[_x + [_top], _x + [_bot], objNull, objNull, false, 32]});
			if (_collision) then {_fC = _f;} else {_fNC = _f;};
			_f = (_fNC + _fC) / 2;
			[] call _fnc_inc;
		};
	} forEach [[_objL, _facL, {[_objX + (_x#0) * _l, _objY + (_x#1) * _l]}, {_l = _f * _objL;}], [_objW, _facW, {[_objX + (_x#0) * _w, _objY + (_x#1) * _w]}, {_w = _f * _objW;}]];
	
	_scale = _scale * 2;
	gCQ_ObjectAreas set [_model, [((_points#0) distance2D (_points#1)) / _scale, ((_points#3) distance2D (_points#0)) / _scale]];
	
	_points
};
/*
CRQ_ObjectCollisionCorners2D = { // TODO does not work with Razor Wire -- is this by design, or is the razor wire too finely meshed?
	if (_this isEqualTo objNull) exitWith {[]};
	(getPosWorld _this) params ["_objX", "_objY", "_objZ"];
	(_this call CRQ_ObjectSize) params ["_radius", "_size"];
	_size params ["_objL", "_objW", "_objH"];
	private _top = _objZ + _objH;
	private _bot = _objZ - _objH;
	private _dir0 = getDir _this;
	private _dir1 = _dir0 + 180;
	private _angle = _objL atan2 _objW;
	private _factors = [_dir0 - _angle, _dir0 + _angle, _dir1 - _angle, _dir1 + _angle] apply {[sin _x, cos _x]};
	private _n = 1;
	private _f = 1;
	private _d = _radius;
	private _points = [];
	for "_i" from 0 to (ceil ((ln (_radius / 0.01)) / (ln 2))) do { // TODO not entirely sure if ceil, round or floor
		_points = _factors apply {[_objX + (_x#0) * _d, _objY + (_x#1) * _d]};
		private _reduce = true;
		{{if (_x isEqualTo _this) exitWith {_reduce = false;};} forEach (lineIntersectsObjs _x);} forEach (_points apply {[_x + [_top], _x + [_bot], objNull, objNull, false, 32]});
		_n = _n / 2;
		_f = 1 min (if (_reduce) then {_f - _n} else {_f + _n});
		_d = _radius * _f;
	};
	_points
};
*/
CRQ_ConfigParents = { // derived from BIS_fnc_returnParents
	private _parents = [];
	while {isClass _this} do {
		_parents pushBack _this;
		_this = inheritsFrom _this;
	};
	_parents
};
CRQ_ConfigChildren = {
	private _children = [];
	private _hierarchy = [[_this]];
	private _index = 0;
	private _level = 0;
	private _nextLevel = 1;
	private _continue = true;
	while {_continue} do {
		private _current = "true" configClasses (_hierarchy#_level#_index);
		_children append _current;
		if (count (_hierarchy) <= _nextLevel) then {_hierarchy pushBack _current;} else {(_hierarchy#_nextLevel) append _current;};
		_index = _index + 1;
		if (count (_hierarchy#_level) <= _index) then {
			if ((_hierarchy#_nextLevel) isNotEqualTo []) then {
				_index = 0;
				_level = _level + 1;
				_nextLevel = _nextLevel + 1;
			} else {
				_continue = false;
			};
		};
	};
	_children
};
CRQ_ConfigVehicleTurrets = { // derived from BIS_fnc_getTurrets
	private _turrets = [_this];
	private _fnc_getTurrets = {{_turrets pushBack _x; if (isClass (_x >> "Turrets")) then {_x call _fnc_getTurrets;};} forEach ("true" configClasses (_this >> "Turrets"));};
	_this call _fnc_getTurrets;
	_turrets
};
CRQ_ConfigWeaponBase = { // derived from BIS_fnc_baseWeapon
	private _predefined = gCQ_CfgWeapons >> (getText (_this >> "baseWeapon"));
	if (isClass _predefined) exitwith {_predefined};
	private _base = _this;
	{if (count (_x >> "linkeditems") == 0) exitwith {_base = _x;};} forEach (_this call CRQ_ConfigParents);
	_base
};
CRQ_ConfigWeaponMagazines = {
	if (_this isEqualType "") then {_this = gCQ_CfgWeapons >> _this;};
	private _mags = (getArray (_this >> "magazines"));
	{{_mags append (getArray _x);} forEach (configProperties [gCQ_CfgMagazineWells >> _x]);} forEach (getArray (_this >> "magazineWell"));
	(_mags arrayIntersect _mags)
};
CRQ_ClassModel = {
	private _path = (getText (gCQ_CfgVehicles >> _this >> "model")) splitString "\";
	private _last = (count _path - 1);
	if (_last >= 0) exitWith {_path#_last};
	""
};
CRQ_ClassSize = {
	private _obj = _this call CRQ_ObjectDummy;
	private _return = _obj call CRQ_ObjectSize;
	deleteVehicle _obj;
	_return
};
CRQ_ClassCenter = {
	private _obj = _this call CRQ_ObjectDummy;
	private _return = boundingCenter _obj;
	deleteVehicle _obj;
	_return
};
CRQ_ObjectDummy = {
	private _obj = createSimpleObject [_this , CRQ_POS_DUMMY, true];
	_obj enableSimulation false;
	_obj allowDamage false;
	hideObject _obj;
	_obj
};
CRQ_ObjectModel = {
	((getModelInfo _this)#0)
};
CRQ_ObjectSize = {
	(boundingBoxReal _this) params ["_min","_max"];//, "_diameter"];
	private _size = [(_max#0) - (_min#0), (_max#1) - (_min#1), (_max#2) - (_min#2)]; // examples show using abs() here?
	private _radius = (sqrt (((_size#0) ^ 2) + ((_size#1) ^ 2))) / 2;
	[_radius, _size]
};
CRQ_ObjectSpawn = {
	params ["_type", "_vec", ["_special", "CAN_COLLIDE"]];
	private _object = createVehicle [_type, _vec#0, [], 0, _special];
	_object setDir (_vec#1);
	_object setPosWorld [_vec#0#0, _vec#0#1, (getPosWorld _object)#2];
	_object
};
CRQ_PropRasterize = {
	params ["_setup", "_sources"];
	_setup call CRQ_VecUtilSetup;
	(_sources apply {[_x#0, (_x#1) call CRQ_VecUtil]})
};
CRQ_PropSpawn = {
	private _props = [];
	{
		_x params ["_type", "_vec"];
		if (_type isNotEqualTo "") then {
			private _object = [_type, _vec] call CRQ_ObjectSpawn;
			_object allowDamage false;
			if (maxLoad _object > 0) then {_object lockInventory true;};
			_props pushBack _object;
		} else {
			_props pushBack objNull;
		};
	} forEach _this;
	_props
};
CRQ_PropDespawn = {
	{deleteVehicle _x;} forEach _this; // TODO it really doesn't matter if passing objNull?
};
CRQ_Side = {
	if (_this isEqualType -1) exitWith {if (_this < 0) exitWith {sideUnknown}; CRQ_SIDES#_this};
	if (_this isEqualType objNull || {_this isEqualType grpNull || {_this isEqualType locationNull}}) then {_this = side _this;};
	if (_this isEqualType sideUnknown) exitWith {
		if (_this isEqualTo opfor) exitWith {CRQ_SIDE_OPFOR};
		if (_this isEqualTo independent) exitWith {CRQ_SIDE_IDFOR};
		if (_this isEqualTo blufor) exitWith {CRQ_SIDE_BLUFOR};
		if (_this isEqualTo civilian) exitWith {CRQ_SIDE_CIVFOR};
		CRQ_SIDE_UNKNOWN
	};
	CRQ_SIDE_UNKNOWN
};
CRQ_fnc_SD_Matrix = {
	private _friend = CRQ_SIDES apply {private _side = _x; CRQ_SIDES apply {_side getFriend _x}};
	private _enemy = _friend apply {_x apply {1 - _x}};
	private _dmF = _friend apply {_x apply {_x^2.0}};
	private _dmE = _enemy apply {_x apply {_x^0.5}};
	[_friend, _enemy, _dmF, _dmE]
};

CRQ_SideLabel = {
	if (!(_this isEqualType -1)) then {_this = _this call CRQ_Side;};
	if (_this >= 0) exitWith {CQM_SIDE_LABELS#_this};
	CQM_SIDE_LABEL_UNKNOWN
};
CRQ_SideAlly = {
	_this = CRQ__BISIDE(_this);
	private _allies = [];
	{if (_this getFriend _x >= CRQ_RELATIONS_FRIEND) then {_allies pushBack _forEachIndex;};} forEach CRQ_SIDES;
	_allies
};
CRQ_SideEnemy = {
	_this = CRQ__BISIDE(_this);
	private _enemies = [];
	{if (_this getFriend _x < CRQ_RELATIONS_NEUTRAL) then {_enemies pushBack _forEachIndex;};} forEach CRQ_SIDES;
	_enemies
};
CRQ_SideNeutral = {
	_this = CRQ__BISIDE(_this);
	private _neutral = [];
	{if (_this getFriend _x >= CRQ_RELATIONS_NEUTRAL && {_this getFriend _x < CRQ_RELATIONS_FRIEND}) then {_neutral pushBack _forEachIndex;};} forEach CRQ_SIDES;
	_neutral
};
CRQ_SideRelation = {
	params ["_self", "_other"];
	private _relation = CRQ__BISIDE(_self) getFriend CRQ__BISIDE(_other);
	if (_relation < CRQ_RELATIONS_NEUTRAL) exitWith {CRQ_RELATION_HOSTILE};
	if (_relation < CRQ_RELATIONS_FRIEND) exitWith {CRQ_RELATION_NEUTRAL};
	CRQ_RELATION_FRIENDLY
};
CRQ_SideBilateral = {
	params ["_side0", "_side1", "_relation"];
	_side0 = CRQ__BISIDE(_side0);
	_side1 = CRQ__BISIDE(_side1);
	_side0 setFriend [_side1, _relation];
	_side1 setFriend [_side0, _relation];
};
CRQ_GroupCreate = {
	private _group = createGroup [(_this call CRQ_Side), false];
	deleteWaypoint [_group, 0];
	_group
};
CRQ_WaypointClear = {
	for "_i" from ((count (waypoints _this)) - 1) to 0 step -1 do {deleteWaypoint [_this, _i];};
};
CRQ_WaypointAdd = {
	params ["_group", "_vec", ["_completion", 0], ["_type", ""], ["_timeout", []]];
	private _wp = _group addWaypoint [AGLToASL (_vec#0), -1];
	if (_type isNotEqualTo "") then {_wp setWaypointType _type;};
	if (_completion != 0) then {_wp setWaypointCompletionRadius _completion;};
	if (_timeout isNotEqualTo []) then {_wp setWaypointTimeout _timeout;};
	_wp
};
CRQ_WaypointScripted = {
	params ["_group", "_vec", "_pattern"];
	private _wpArg = [AGLToASL (_vec#0), -1];
	{
		private _wp = _group addWaypoint _wpArg;
		_wp setWaypointType "SCRIPTED";
		_wp setWaypointScript (if (_x isEqualType []) then {CRQ_AI_SCRIPT_SOURCE + str ([_vec] + _x)} else {CRQ_AI_SCRIPT_SOURCE + str ([_vec, _x])});
	} forEach _pattern;
};
CRQ_WaypointInfantryGarrison = {
	params ["_group", "_wpVec"];
	if (_wpVec isEqualTo []) exitWith {};
	[_group, _wpVec#0] call CRQ_WaypointAdd;
	[_group, _wpVec#0, selectRandom CRQ_AI_PATTERN_GARRISON] call CRQ_WaypointScripted;
	[_group, _wpVec#0] call CRQ_WaypointAdd;
	[_group, _wpVec#0, 0, "CYCLE"] call CRQ_WaypointAdd;
};
CRQ_WaypointInfantrySpot = {
	params ["_group", "_wpVec"];
	if (_wpVec isEqualTo []) exitWith {};
	[_group, _wpVec#0, selectRandom CRQ_AI_PATTERN_SPOT] call CRQ_WaypointScripted;
};
CRQ_WaypointInfantryPatrol = {
	params ["_group", "_wpVec"];
	if (_wpVec isEqualTo []) exitWith {};
	private _closest = [_group call CRQ_VecGroup2D, _wpVec] call CRQ_VecClosest2D;
	private _count = count _wpVec;
	for "_i" from 0 to (_count - 1) do {
		private _vec = _wpVec#((_closest + _i) % _count);
		[_group, _vec] call CRQ_WaypointAdd;
		[_group, _vec, selectRandom CRQ_AI_PATTERN_PATROL] call CRQ_WaypointScripted;
	};
	[_group, _wpVec#_closest] call CRQ_WaypointAdd;
	[_group, _wpVec#_closest, 0, "CYCLE"] call CRQ_WaypointAdd;
};
CRQ_WaypointVehiclePatrol = {
	params ["_group", "_wpVec"];
	if (_wpVec isEqualTo []) exitWith {};
	private _closest = [_group call CRQ_VecGroup2D, _wpVec] call CRQ_VecClosest2D;
	private _count = count _wpVec;
	for "_i" from 0 to (_count - 1) do {
		private _vec = _wpVec#((_closest + _i) % _count);
		[_group, _vec, CRQ_AI_RADIUS_MOVE_VEHICLE] call CRQ_WaypointAdd;
		[_group, _vec, selectRandom CRQ_AI_PATTERN_VEHICLE] call CRQ_WaypointScripted;
	};
	[_group, _wpVec#_closest, CRQ_AI_RADIUS_MOVE_VEHICLE] call CRQ_WaypointAdd;
	[_group, _wpVec#_closest, 0, "CYCLE"] call CRQ_WaypointAdd;
};
CRQ_WaypointVehicleTravel = {
	params ["_group", "_wpVec"];
	{[_group, _x, CRQ_AI_RADIUS_MOVE_VEHICLE] call CRQ_WaypointAdd;} forEach _wpVec;
};
CRQ_ClearArea = {
	params ["_pos", "_radius", "_clutter"];
	{
		private _clutterPos = _x call CRQ_Pos2D;
		private _clutterRadius = (_x call CRQ_ObjectSize)#0;
		private _safeDistance = _radius + _clutterRadius;
		if ((_pos distance2D _clutterPos) < _safeDistance) then {_x setPos (_pos getPos [_safeDistance, _pos getDir _clutterPos]);};
	} forEach _clutter;
};
CRQ_IdentityApply = {
	params ["_unit", "_identity"];
	_identity params ["_face", "_voice", "_name", "_callsign", "_pitch"];
	if (_face isNotEqualTo "") then {_unit setFace _face;};
	if (_voice isNotEqualTo "") then {_unit setSpeaker _voice;};
	_unit setName _name;
	_unit setNameSound _callsign;
	_unit setPitch _pitch;
};
CRQ_LoadoutApply = {
	params ["_unit", "_loadout"];
	_unit setUnitLoadout _loadout;
	if (alive _unit) then {_unit switchMove "";};
};
CRQ_LoadoutBlank = {
	if (_this isEqualType objNull) exitWith {[[],[],[],[uniform _this, []],[],[],"","",[],["","","","","",""]]};
	params ["_unit", ["_naked", false]];
	if (_naked) exitWith {[[],[],[],[],[],[],"","",[],["","","","","",""]]};
	[[],[],[],[uniform _unit, []],[],[],"","",[],["","","","","",""]]
};
CRQ_InventoryAppend = {
	params ["_inventory", "_append"];
	(_inventory#0#0) append (_append#0#0);
	(_inventory#0#1) append (_append#0#1);
	(_inventory#0#2) append (_append#0#2);
	(_inventory#1) append (_append#1);
	_inventory
};
/*
CRQ_InventoryBox = {
	private _items = itemCargo _this;
	private _mags = magazinesAmmoCargo _this;
	private _weapons = weaponsItemsCargo _this;
	private _containers = [];
	{_containers pushBack [_x#0, [itemCargo (_x#1), magazinesAmmoCargo (_x#1), weaponsItemsCargo (_x#1), backpackCargo (_x#1)]];} forEach (everyContainer _this);
	{
		private _index = _items find (_x#0);
		if (_index != -1) then {_items deleteAt _index;};
	} forEach _containers;
	[[_items, _mags, _weapons], _containers]
};
*/
CRQ_InventoryBox = {
	private _containers = (everyContainer _this) apply {[_x#0, [itemCargo (_x#1), magazinesAmmoCargo (_x#1), weaponsItemsCargo (_x#1), backpackCargo (_x#1)]]};
	[[(itemCargo _this) - (_containers apply {_x#0}), magazinesAmmoCargo _this, weaponsItemsCargo _this], _containers]
};
CRQ_InventoryBoxClear = {
	clearMagazineCargoGlobal _this;
	clearItemCargoGlobal _this;
	clearWeaponCargoGlobal _this;
	clearBackpackCargoGlobal _this;
};
CRQ_InventoryBoxAppend = {
	params ["_target", "_content"];
	{_target addItemCargoGlobal [_x, 1];} forEach (_content#0#0);
	{_target addMagazineAmmoCargo [_x#0, 1, _x#1];} forEach (_content#0#1);
	{_target addWeaponWithAttachmentsCargoGlobal [_x, 1];} forEach (_content#0#2);
	{
		private _container = [_target, _x#0] call CRQ_InventoryBoxAddContainer;
		if (!isNull _container) then {
			_container call CRQ_InventoryBoxClear; // because of this can't optimize
			{_container addItemCargoGlobal [_x, 1];} forEach (_x#1#0);
			{_container addMagazineAmmoCargo [_x#0, 1, _x#1];} forEach (_x#1#1);
			{_container addWeaponWithAttachmentsCargoGlobal [_x, 1];} forEach (_x#1#2);
			// backpacks in root already included as a container, backpacks in containers guaranteed by game to not have contents themselves
			{_container addBackpackCargoGlobal [_x, 1];} forEach (_x#1#3); // TODO what if this creates a backpack with items?
		};
	} forEach (_content#1);
};
CRQ_InventoryBoxOrganize = {
	private _content = _this call CRQ_InventoryBox;
	(_content call CRQ_InventoryContainerStrip) params ["_root", "_containers"];
	_root params ["_items", "_mags", "_weapons"];
	(_weapons call CRQ_InventoryWeaponStrip) params ["_weaponItems", "_weaponMags", "_weaponStripped"];
	_items append _weaponItems;
	_mags append _weaponMags;
	_weapons = _weaponStripped;
	_mags = _mags call CRQ_InventoryMagRepack;
	_items sort true;
	_mags sort false;
	_weapons sort true;
	_containers sort true;
	_this call CRQ_InventoryBoxClear;
	[_this, [[_items, _mags, _weapons], _containers]] call CRQ_InventoryBoxAppend;
};
CRQ_InventoryBoxTransfer = {
	params ["_source", "_target"];
	private _content = _source call CRQ_InventoryBox;
	_source call CRQ_InventoryBoxClear;
	[_target, _content] call CRQ_InventoryBoxAppend;
};
CRQ_InventoryBoxAddContainer = {
	params ["_target", "_type"];
	private _container = objNull;
	if (_type isKindOf "Bag_Base") then {
		private _existing = everyBackpack _target;
		reverse _existing;
		_target addBackpackCargoGlobal [_type, 1];
		private _current = everyBackpack _target;
		reverse _current;
		{if ((_existing find (_x)) == -1) exitWith {_container = _x;};} forEach _current; // OPTIMIZE reverse?
	} else {
		private _existing = [];
		{_existing pushBack (_x#1);} forEach (everyContainer _target);
		reverse _existing;
		_target addItemCargoGlobal [_type, 1];
		private _current = (everyContainer _target);
		reverse _current;
		{if ((_existing find (_x#1)) == -1) exitWith {_container = _x#1;};} forEach _current; // OPTIMIZE reverse?
	};
	_container
};
CRQ_InventoryUnit = {
	params ["_unit", ["_preserve", true], ["_includeUniform", true]];
	private _loadout = getUnitLoadout _unit;
	private _items = [];
	private _mags = [];
	private _weapons = [];
	{if (_x isNotEqualTo "") then {_items pushBack _x;};} forEach ([_loadout#6, _loadout#7] + (_loadout#9));
	{if (_x isNotEqualTo []) then {_weapons pushBack _x;};} forEach [_loadout#0, _loadout#1, _loadout#2, _loadout#8];
	private _containers = [];
	{
		if ((_x#0) isNotEqualTo "") then {
			private _containerItems = itemCargo (_x#1);
			private _containerMags = magazinesAmmoCargo (_x#1);
			private _containerWeapons = weaponsItemsCargo (_x#1);
			private _containerBackpacks = backpackCargo (_x#1);
			private _includeContainer = ((_forEachIndex > 0) || _includeUniform);
			if (_preserve && _includeContainer)  then {
				_containers pushBack [_x#0, [_containerItems, _containerMags, _containerWeapons, _containerBackpacks]];
			} else {
				if (_includeContainer) then {_containers pushBack [_x#0, [[], [], [], []]];};
				if (_containerItems isNotEqualTo []) then {_items append _containerItems;};
				if (_containerMags isNotEqualTo []) then {_mags append _containerMags;};
				if (_containerWeapons isNotEqualTo []) then {_weapons append _containerWeapons;};
				{_containers pushBack [_x, [[], [], [], []]];} forEach _containerBackpacks;
			}
		};
	} forEach [[uniform _unit, uniformContainer _unit], [vest _unit, vestContainer _unit], [backpack _unit, backpackContainer _unit]];
	if (!_preserve) then {
		(_weapons call CRQ_InventoryWeaponStrip) params ["_weaponItems", "_weaponMags", "_weaponStripped"];
		_items append _weaponItems;
		_mags append _weaponMags;
		_weapons = _weaponStripped;
		_mags = _mags call CRQ_InventoryMagRepack;
	};
	[[_items, _mags, _weapons], _containers]
};
CRQ_InventoryUnitTransfer = {
	params ["_unit", "_target", ["_preserve", true], ["_uniform", false]];
	private _content = [_unit, _preserve, _uniform] call CRQ_InventoryUnit;
	[_unit, [_unit, _uniform] call CRQ_LoadoutBlank] call CRQ_LoadoutApply;
	[_target, _content] call CRQ_InventoryBoxAppend;
};
CRQ_InventoryMagRepack = {
	private _mags = [];
	private _types = [];
	private _rounds = [];
	{
		_x params ["_magType", "_magRounds"];
		private _index = _types find _magType;
		if (_index != -1) then {
			_rounds set [_index, (_rounds#_index) + _magRounds];
		} else {
			_types pushBack _magType;
			_rounds pushBack _magRounds;
		};
	} forEach _this;
	{
		private _roundsTotal = _rounds#_forEachIndex;
		private _roundsFull = getNumber (gCQ_CfgMagazines >> _x >> "count");
		private _countMags = floor (_roundsTotal / _roundsFull);
		for "_i" from 1 to _countMags do {_mags pushBack [_x, _roundsFull];};
		private _roundsRemainder = _roundsTotal % _roundsFull;
		if (_roundsRemainder > 0) then {_mags pushBack [_x, _roundsRemainder];};
	} forEach _types;
	_mags
};
CRQ_InventoryContainerStrip = {
	params ["_root", "_containers"];
	_root params ["_items", "_mags", "_weapons"];
	private _stripped = [];
	{
		(_x#1) params ["_containerItems", "_containerMags", "_containerWeapons", "_containerBackpacks"];
		_items append _containerItems;
		_mags append _containerMags;
		_weapons append _containerWeapons;
		_stripped pushBack [_x#0, [[],[],[],[]]];
		{_stripped pushBack [_x, [[],[],[],[]]];} forEach _containerBackpacks;
	} forEach _containers;
	[[_items, _mags, _weapons], _stripped]
};
CRQ_InventoryWeaponStrip = {
	private _items = [];
	private _mags = [];
	private _weapons = [];
	{
		_x params ["_type", "_muzzle", "_laser", "_optic", "_ammoPrimary", "_ammoSecondary", "_bipod"];
		if (_muzzle isNotEqualTo "") then {_items pushBack _muzzle;};
		if (_laser isNotEqualTo "") then {_items pushBack _laser;};
		if (_optic isNotEqualTo "") then {_items pushBack _optic;};
		if (_bipod isNotEqualTo "") then {_items pushBack _bipod;};
		if (_ammoPrimary isNotEqualTo []) then {_mags pushBack _ammoPrimary;};
		if (_ammoSecondary isNotEqualTo []) then {_mags pushBack _ammoSecondary;};
		_weapons pushBack [_type, "", "", "", [], [], ""];
	} forEach _this;
	[_items, _mags, _weapons]
};
CRQ_InventoryLoadoutAppend = { // TODO check load state, existing weapon, etc...
	params ["_loadout", "_inventory"];
	{
		(getNumber (gCQ_CfgWeapons >> (_x#0) >> "type")) call {
			if (_this == 1) exitWith {_loadout set [0, _x];};
			if (_this == 2) exitWith {_loadout set [2, _x];};
			if (_this == 4) exitWith {_loadout set [1, _x];};
			if (_this == 4096) exitWith {_loadout set [8, _x];};
		};
	} forEach (_inventory#0#2);
	private _items = (_inventory#0#0) call CRQ_InventoryItemCompress;
	if ((_loadout#5) isNotEqualTo []) then {
		{(_loadout#5#1) pushBack _x;} forEach _items;
	} else {
		if ((_loadout#4) isNotEqualTo []) then {
			{(_loadout#4#1) pushBack _x;} forEach _items;
		} else {
			if ((_loadout#3) isNotEqualTo []) then {
				{(_loadout#3#1) pushBack _x;} forEach _items;
			};
		};
	};
	private _container = [4,3,5] select {(_loadout#_x) isNotEqualTo []};
	{
		private _target = [];
		{switch (_x) do {case 801: {_target pushBack 3;}; case 701: {_target pushBack 4;}; case 901: {_target pushBack 5;}; default {};};} forEach (getArray (gCQ_CfgMagazines >> (_x#0) >> "allowedSlots"));
		if (_target isNotEqualTo []) then {_target = _target arrayIntersect _container;} else {_target = _container;};
		if (_target isNotEqualTo []) then {(_loadout#(_target#0)#1) pushBack _x;};
	} forEach ((_inventory#0#1) call CRQ_InventoryMagCompress);
	_loadout
};
CRQ_InventoryMagCompress = {
	private _compressed = [];
	{
		private _name = _x#0;
		private _rounds = _x#1;
		private _new = true;
		{if (_rounds isEqualTo (_x#2) && {_name isEqualTo (_x#0)}) exitWith {_x set [1, (_x#1) + 1]; _new = false;};} forEach _compressed;
		if (_new) then {_compressed pushBack [_name, 1, _rounds];};
	} forEach _this;
	_compressed
};
CRQ_InventoryItemCompress = {
	private _compressed = [];
	{
		private _name = _x;
		private _new = true;
		{if (_name isEqualTo (_x#0)) exitWith {_x set [1, (_x#1) + 1]; _new = false;};} forEach _compressed;
		if (_new) then {_compressed pushBack [_name, 1];};
	} forEach _this;
	_compressed
};
CRQ_VehiclesFind = {
	params ["_pos", "_radius", ["_mode2D", true]];
	/*
	private _vehicles = [];
	{
		private _obj = _x;
		{if (_obj isKindOf _x) exitWith {_vehicles pushBack _obj;};} forEach CRQ_CLASS_VEHICLE;
	} forEach (_pos nearObjects _radius);
	*/
	nearestObjects [_pos, CRQ_CLASS_VEHICLE, _radius, _mode2D]
};
CRQ_WrecksFind = {
	private _wrecks = [];
	{if (!alive _x) then {_wrecks pushBack _x;};} forEach (_this call CRQ_VehiclesFind);
	_wrecks
};
CRQ_UnitCreate = {
	params ["_group", "_type", "_vec", ["_loadout", []], ["_skill", -1], ["_damage", 0]];
	private _unit = _group createUnit [_type, _vec#0, [], 0, "CAN_COLLIDE"];
	_unit setDir (_vec#1);
	_unit setPosWorld [_vec#0#0, _vec#0#1, (getPosWorld _unit)#2];
	if (_loadout isNotEqualTo []) then {[_unit, _loadout] call CRQ_LoadoutApply;};
	if (_skill != -1) then {
		_unit setSkill _skill;
		{[_unit, _skill] call _x;} forEach pCQ_AI_Adjust;
	};
	if (_damage > 0) then {_unit setDamage _damage;};
	//#ifdef CRQ_DEFINE_SERVER
	_unit addEventHandler ["Killed", CRQ_EHS_UnitKilled];
	//#endif
	_unit
};
CRQ_UnitDelete = {
	if ((objectParent _this) isNotEqualTo objNull) then {moveOut _this;}; // TODO something, something deleteVehicleCrew
	deleteVehicle _this;
};
CRQ_UnitHibernate = {
	[typeOf _this, _this call CRQ_Vec3D, getUnitLoadout _this, skill _this, damage _this]
};
CRQ_UnitVehicleAssign = {
	params ["_role", "_unit", "_vehicle", ["_turret", []]];
	if (_role == CRQ_CREW_TURRET) then {
		if (_turret isEqualTo [-1]) exitWith {_role = CRQ_CREW_DRIVER;};
		if (_turret isEqualTo []) exitWith {_role = CRQ_CREW_CARGO;};
	};
	(group _unit) addVehicle _vehicle;
	[_unit] allowGetIn true;
	[] call ([{_unit assignAsCommander _vehicle;}, {_unit assignAsGunner _vehicle;}, {_unit assignAsDriver _vehicle;}, {_unit assignAsCargo _vehicle;}, {_unit assignAsTurret [_vehicle, _turret];}]#_role);
	[_unit] orderGetIn true;
	[] call ([{_unit moveInCommander _vehicle;}, {_unit moveInGunner _vehicle;}, {_unit moveInDriver _vehicle;}, {_unit moveInAny _vehicle;}, {_unit moveInTurret [_vehicle, _turret];}]#_role);
};
CRQ_ClassAirborne = {
	((toLowerANSI (getText (gCQ_CfgVehicles >> _type >> "simulation"))) call {_this isEqualTo "airplanex" || {_this isEqualTo "helicopterx" || {_this isEqualTo "helicopterrtd"}}})
};
CRQ_VehicleCreate = {
	params ["_type", "_vec", ["_inventory", []], ["_state", []], ["_textures", []]];
	private _airborne = (count (_vec#0) > 2) && {(_vec#0#2) >= CRQ_FLIGHT_ALTITUDE && {_type call CRQ_ClassAirborne}};
	private _vehicle = if (_airborne) then {
		private _vehicle = [_type, _vec, "FLY"] call CRQ_ObjectSpawn;
		_vehicle setVelocity [60 * (sin (_vec#1)), 60 * (cos (_vec#1)), 0];
		_vehicle
	} else {
		[_type, _vec] call CRQ_ObjectSpawn
	};
	if (_inventory isNotEqualTo []) then {_vehicle call CRQ_InventoryBoxClear; [_vehicle, _inventory] call CRQ_InventoryBoxAppend;};
	if (_state isNotEqualTo []) then {
		_state params ["_damage", ["_ammo", []], ["_fuel", -1]];
		if (_fuel != -1) then {_vehicle setFuel _fuel;};
		if (_damage isEqualType -1) exitWith {_vehicle setDamage _damage;};
		{_vehicle setHitIndex [_x#0, _x#1, false, objNull];} forEach _damage;
	};
	if (_textures isNotEqualTo []) then {_vehicle setVariable ["BIS_enableRandomization", false]; {_vehicle setObjectTextureGlobal _x;} forEach _textures;};
	//#ifdef CRQ_DEFINE_SERVER
	// TODO disassembled? may be caught by verifying asset is not suddenly null
	_vehicle addEventHandler ["Killed", CRQ_EHS_VehicleKilled];
	//#endif
	_vehicle
};
CRQ_VehicleDelete = {
	//if (!isNull _this) then {
	{moveOut _x;} forEach (crew _this);
	deleteVehicle _this;
	//};
};
CRQ_VehicleThaw = {
	private _vehicle = (_this#0) call CRQ_VehicleCreate;
	[_vehicle, _this#1] call CRQ_VarRestore;
	_vehicle
};

// magazinesAllTurrets _vehicle // TODO asses what happens if person turrets present
// before: [["500Rnd_65x39_Belt_Tracer_Green_Splash",[0],197,1.00025e+007,2],["500Rnd_65x39_Belt_Tracer_Green_Splash",[0],500,1.00025e+007,2],["500Rnd_65x39_Belt_Tracer_Green_Splash",[0],500,1.00025e+007,2]]
// after: [["500Rnd_65x39_Belt_Tracer_Green_Splash",[0],0,1.00025e+007,2],["500Rnd_65x39_Belt_Tracer_Green_Splash",[0],0,1.00025e+007,2],["500Rnd_65x39_Belt_Tracer_Green_Splash",[0],500,1.00025e+007,2]]
CRQ_VehicleHibernate = {
	private _damage = (getAllHitPointsDamage _this) call {if (_this isEqualTo []) exitWith {[]}; private _dam = []; {if (_x > 0) then {_dam pushBack [_forEachIndex, _x];};} forEach (_this#2); _dam};
	private _fuel = fuel _this;
	private _textures = [];
	{_textures pushBack [_forEachIndex, _x];} forEach (getObjectTextures _this);
	[[typeOf _this, _this call CRQ_Vec3D, _this call CRQ_InventoryBox, [_damage, [], _fuel], _textures], _this call CRQ_VarRetrieve]
};

#define CRQ_LNK_NONE []
#define CRQ_LNK_ID_GLOBAL ""

gCQ_LNK_LIST = missionNamespace getVariable ["gCQ_LNK_LIST", createHashMap];
gCQ_LNK_FNCH = missionNamespace getVariable ["gCQ_LNK_FNCH", [{(_this#0) getOrDefault ["CRQP_NGLNK", _this#1]}, {(_this#0) set ["CRQP_NGLNK", _this#1]}, {(_this#0) deleteAt "CRQP_NGLNK"}]];
gCQ_LNK_FNCO = missionNamespace getVariable ["gCQ_LNK_FNCO", [{(_this#0) getVariable ["CRQP_NGLNK", _this#1]}, {(_this#0) setVariable ["CRQP_NGLNK", _this#1]}, {(_this#0) set ["CRQP_NGLNK", nil]}]];
CRQ_fnc_LNK_Create = {
	params ["_data", ["_id", CRQ_LNK_ID_GLOBAL]];
	gCQ_LNK_LIST set [_id, _data apply {_x#0}];
	{
		_x params ["_obj", "_value"];
		private _fnc = [gCQ_LNK_FNCO, gCQ_LNK_FNCH] select (_obj isEqualType createHashMap);
		private _links = [_obj, CRQ_LNK_NONE] call (_fnc#0);
		if (!(count _links > 0)) then {
			_links = createHashMap;
			[_obj, _links] call (_fnc#1);
		};
		_links set [_id, _value];
	} forEach _data;
};
CRQ_fnc_LNK_Get = {
	if (_this isEqualType "") exitWith {(gCQ_LNK_LIST getOrDefault [_this, CRQ_LNK_NONE])};
	if (_this isEqualType createHashMap) exitWith {[_this, CRQ_LNK_NONE] call (gCQ_LNK_FNCH#0)};
	[_this, CRQ_LNK_NONE] call (gCQ_LNK_FNCO#0)
};
CRQ_fnc_LNK_Free = {
	if (_this isEqualType "") exitWith {(gCQ_LNK_LIST deleteAt _this)};
	if (_this isEqualType []) exitWith {[_this] call (gCQ_LNK_FNCH#2)};
	private _data = [_this, CRQ_LNK_NONE] call (gCQ_LNK_FNCO#0);
	[_this] call (gCQ_LNK_FNCO#2);
	_data
};
CRQ_LinkCreate = {
	(_this#0) params ["_ent0", ["_index0", -1], ["_data0", []]];
	(_this#1) params ["_ent1", ["_index1", -1], ["_data1", []]];
	private _link0 = _ent0 getVariable ["CRQP_LNK", []];
	private _link1 = _ent1 getVariable ["CRQP_LNK", []];
	if (_index0 < 0) then {_index0 = count _link0;};
	if (_index1 < 0) then {_index1 = count _link1;};
	_link0 set [_index0, [_ent1, _index1, _data0]];
	_link1 set [_index1, [_ent0, _index0, _data1]];
	_ent0 setVariable ["CRQP_LNK", _link0];
	_ent1 setVariable ["CRQP_LNK", _link1];
};
CRQ_LinkVars = {
	params ["_vars", ["_default", []]];
	([_vars, "CRQP_LNK", _default] call CRQ_VarGet)
};
CRQ_LinkFree = {
	params ["_source", ["_index", -1], ["_default", []]]; // TODO make compatible with array source // should be done?
	private _fnc_free = {
		params [["_target", []], ["_tgIndex", -1]];
		if (_target isNotEqualTo [] && {_tgIndex != -1}) then {
			private _tgLinked = if (_target isEqualType []) then {_target} else {_target getVariable ["CRQP_LNK", []]};
			if (_tgIndex < count _tgLinked) then {
				if ((_tgLinked#_tgIndex#0) isNotEqualTo _source) exitWith {};
				(_tgLinked#_tgIndex) set [0, _default];
				(_tgLinked#_tgIndex) set [1, -1];
				//_target setVariable ["CRQP_LNK", _tgLinked]; // TODO *should* be redundant // seems to be the case, yes
			};
		};
	};
	private _link = if (_source isEqualType []) then {_source} else {_source getVariable ["CRQP_LNK", []]};
	if (_index isEqualType -1) exitWith {
		if (_index < 0) exitWith {
			{_x call _fnc_free} forEach _link;
			if (_source isEqualType []) then {for "_i" from ((count _source) - 1) to 0 step -1 do {_source deleteAt _i;};} else {_source setVariable ["CRQP_LNK", []]};
		};
		(_link#_index) call _fnc_free;
		_link deleteAt _index;
		//_source setVariable ["CRQP_LNK", _link]; // TODO *should* be redundant
	};
	if (_index isEqualType []) exitWith {};
	private _delete = -1;
	{if ((_x#0) isEqualTo _index) exitWith {_x call _fnc_free; _delete = _forEachIndex;};} forEach _link;
	_link deleteAt _delete;
	//_source setVariable ["CRQP_LNK", _link]; // TODO *should* be redundant
};
CRQ_LinkSource = {
	params ["_old", "_new"];
	private _link = if (_old isEqualType []) then {_old} else {_old getVariable ["CRQP_LNK", []]};
	{
		_x params ["_target", "_tgIndex"];
		if (_target isNotEqualTo [] && {_tgIndex != -1}) then {
			private _tgLinked = if (_target isEqualType []) then {_target} else {_target getVariable ["CRQP_LNK", []]};
			if (_tgIndex < count _tgLinked) then {
				if ((_tgLinked#_tgIndex#0) isNotEqualTo _old) exitWith {};
				(_tgLinked#_tgIndex) set [0, _new];
				//_target setVariable ["CRQP_LNK", _tgLinked]; // TODO *should* be redundant
			};
		};
	} forEach _link;
};
CRQ_LinkDataRead = {
	params ["_source", ["_index", -1]];
	private _link = if (_source isEqualType []) then {_source} else {_source getVariable ["CRQP_LNK", []]};
	if (_index isEqualType -1) exitWith {
		if (_index < 0) exitWith {(_link apply {[_x#0, _x#2]})};
		if (_index >= count _link) exitWith {[]};
		[_link#_index#0, _link#_index#2]
	};
	if (_index isEqualType []) exitWith {[]};
	{if ((_x#0) isEqualTo _index) exitWith {[_x#0, _x#2]};} forEach _link;
};
CRQ_LinkDataBroadcast = {
	params ["_source", "_data"];
	private _link = if (_source isEqualType []) then {_source} else {_source getVariable ["CRQP_LNK", []]};
	{
		_x params ["_target", "_tgIndex"];
		if (_target isNotEqualTo [] && {_tgIndex != -1}) then {
			private _tgLinked = if (_target isEqualType []) then {_target} else {_target getVariable ["CRQP_LNK", []]};
			if (_tgIndex < count _tgLinked) then {
				if ((_tgLinked#_tgIndex#0) isNotEqualTo _source) exitWith {};
				(_tgLinked#_tgIndex) set [2, _data];
				//_target setVariable ["CRQP_LNK", _tgLinked]; // TODO *should* be redundant
			};
		};
	} forEach _link;
};
CRQ_fnc_RD_Type = {
	((getRoadInfo _this)#0)
};
CRQ_fnc_RD_IsBridge = {
	((getRoadInfo _this)#8)
};
CRQ_fnc_RD_IsRoad = {
	private _type = (getRoadInfo _this)#0;
	(_type isEqualTo "ROAD" || {_type isEqualTo "TRACK" || {_type isEqualTo "MAIN ROAD"}})
};
CRQ_RoadPath = {
	params ["_rdNow", "_rdExclude", "_refPos", "_refRadius"];
	private _rdPath = [];
	private _limit = ceil (_refRadius / CRQ_ROAD_PATH_SEGMENTATION);
	private _counter = 0;
	private _branches = [];
	private _branchCurrent = -1;
	private _unknown = createHashMap;
	{_unknown set [netId _x, false];} forEach _rdExclude; // NOTE: there's a getObjectID since v2.10...?
	private _break = false;
	while {true} do {
		_unknown set [netId _rdNow, false];
		_rdPath pushBack _rdNow;
		
		private _options = [];
		{if (_x call CRQ_fnc_RD_IsRoad && {_unknown getOrDefault [netId _x, true]}) then {_options pushBack _x;};} forEach (roadsConnectedTo _rdNow);
		
		private _countOptions = count _options;
		if (_counter < _limit && _countOptions > 0) then {
			_counter = _counter + 1;
			if (_countOptions > 1) then {
				_rdNow = _options deleteAt (floor (random _countOptions));
				_branchCurrent = _branchCurrent + 1;
				_branches set [_branchCurrent, [_counter, _options]];
			} else {
				_rdNow = _options#0;
			};
			if (_refPos distance2D _rdNow >= _refRadius) then {_break = true;};
		} else {
			while {true} do {
				if (_branchCurrent < 0) exitWith {
					_rdPath = [];
					_break = true;
				};
				(_branches#_branchCurrent) params ["_brCounter", "_brOptions"];
				if (_brOptions isNotEqualTo []) then {
					_rdNow = _brOptions deleteAt (floor (random (count _brOptions)));
					_counter = _brCounter;
					_rdPath resize (_counter); // OPTIMIZE resize history too?
				} else {
					_branchCurrent = _branchCurrent - 1;
				};
			};
		};
		if (_break || {_counter >= _limit}) exitWith {};
	};
	_rdPath
};
CRQ_RoadWaypoints = {
	private _waypoints = [];
	private _lastWaypoint = 0;
	private _indexLast = (count _this) - 1;
	private _indexMin = CRA_ROAD_WAYPOINT_ANALYSIS + 2;
	private _indexMax = _indexLast - (CRA_ROAD_WAYPOINT_ANALYSIS + 1);
	{
		if (_forEachIndex > _indexMin && {_forEachIndex < _indexMax && {(_forEachIndex - _lastWaypoint) > CRA_ROAD_WAYPOINT_SPACING}}) then { // TODO might be an off by one here, idk
			if (count (roadsConnectedTo _x) > 2) then { // TODO explicitly exclude bridges, implicitly this is probably inherent through fact that no existing bridge has a junction
				private _lower1 = _forEachIndex - 2;
				private _upper0 = _forEachIndex + 1;
				private _lower0 = _lower1 - CRA_ROAD_WAYPOINT_ANALYSIS;
				private _upper1 = _upper0 + CRA_ROAD_WAYPOINT_ANALYSIS;
				private _prev = [];
				private _next = [];
				//for [{private _i = _lower0}, {_i <= _lower1}, {_i = _i + 1}] do {
				for "_i" from _lower0 to _lower1 do {
					private _road0 = (_this#_i);
					private _road1 = (_this#(_i + 1));
					_prev pushBack [(_road0 getDir _road1), (_road0 distance2D _road1)];
				};
				//for [{private _i = _upper0}, {_i <= _upper1}, {_i = _i + 1}] do {
				for "_i" from _upper0 to _upper1 do {
					private _road0 = (_this#_i);
					private _road1 = (_this#(_i + 1));
					_next pushBack [(_road0 getDir _road1), (_road0 distance2D _road1)];
				};
				if (([_prev call CRQ_AngleAvg, _next call CRQ_AngleAvg] call CRQ_Angle) > CRA_ROAD_WAYPOINT_ANGLE_MIN) then {_waypoints pushBack (_x call CRQ_Vec3D);};
			};
		};
	} forEach _this;
	_waypoints pushBack ((_this#_indexLast) call CRQ_Vec3D);
	_waypoints
};
CRQ_FlightStart = {
	params ["_pos", "_perimeter", ["_altitude", CRQ_FLIGHT_ALTITUDE], ["_angle", CRQ_FLIGHT_ANGLE], ["_offset", 60]];
	private _off0 = _offset / -2;
	private _azi = random 360;
	[_pos vectorAdd [_off0 + random _offset + (sin _azi) * _perimeter, _off0 + random _offset + (cos _azi) * _perimeter, _altitude], _azi + 180 + _angle / -2 + random _angle]
};
CRQ_FlightPath = {
	params ["_vec", "_range", ["_count", 1], ["_angle", CRQ_FLIGHT_ANGLE]];
	private _aziBase = (_vec#1) + _angle / -2;
	private _pos = _vec#0;
	private _azi = _vec#1;
	private _path = [];
	for "_i" from 1 to _count do {
		_pos = _pos vectorAdd [sin _azi * _range, cos _azi * _range, 0];
		_azi = _aziBase + random _angle;
		_path pushBack [_pos, _azi];
	};
	_path
};
