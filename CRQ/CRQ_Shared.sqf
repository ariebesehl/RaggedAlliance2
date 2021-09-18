
#include "CRQ__Shared.sqf"
#include "CRQ_AI.sqf"

#include "..\CQM\CQM_Shared.sqf"

gCQ_CfgAmmo = configFile >> "CfgAmmo";
gCQ_CfgGlasses = configFile >> "CfgGlasses";
gCQ_CfgMagazines = configFile >> "CfgMagazines";
gCQ_CfgMagazineWells = configFile >> "CfgMagazineWells";
gCQ_CfgVehicles = configFile >> "CfgVehicles";
gCQ_CfgWeapons = configFile >> "CfgWeapons";

gCQ_PosUtil = missionNamespace getVariable ["gCQ_PosUtil", [[0,0,0],0,CRQ_POS_UTIL_RADIUS,CRQ_POS_UTIL_RESOLUTION]];
gCQ_VecUtil = missionNamespace getVariable ["gCQ_VecUtil", [[[0,0,0],0],CRQ_POS_UTIL_RADIUS,CRQ_POS_UTIL_RESOLUTION,true,[]]];

CRQ_ByteDecode = {
	private _bits = [];
	{if (_this >= _x) then {_bits pushBack true; _this = _this - _x;} else {_bits pushBack false;};} forEach [128,64,32,16,8,4,2,1];
	reverse _bits;
	_bits
};
CRQ_ByteEncode = {
	private _byte = 0;
	private _bit = 1;
	{if (_x) then {_byte = _byte + _bit;}; _bit = _bit * 2;} forEach _this;
	_byte
};
CRQ_CRC = {
	params ["_crc", "_data"];
	{_crc = (_crc + _x) % CRQ_CRC_MODULO;} forEach (toArray (str _data));
	_crc
};
CRQ_CacheLoad = {
	params ["_crc", "_source", "_target", "_default"];
	private _var = profileNamespace getVariable [_source, _default];
	missionNamespace setVariable [_target, _var];
	([_crc, _var] call CRQ_CRC)
};
CRQ_CacheSave = {
	params ["_crc", "_source", "_target", "_default"];
	private _var = missionNamespace getVariable [_source, _default];
	profileNamespace setVariable [_target, _var];
	([_crc, _var] call CRQ_CRC)
};
CRQ_Wait = {
	private _start = time;
	while {(time - _start) <  _this} do {sleep CRQ_WAIT_RESOLUTION;};
};
CRQ_ArrayIncrement = {
	params ["_array", "_index", "_increment"];
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
	params ["_dir1", "_dir2"];
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
CRQ_PosRasterize = {
	params ["_vec", "_positions"];
	[_vec#0, _vec#1, 0, 0] call CRQ_PosUtilSetup;
	private _rasterized = [];
	{_rasterized pushBack (_x call CRQ_PosUtil);} forEach _positions;
	_rasterized
};
CRQ_PosUtilSetup = {
	params ["_base", "_dir", "_radius", "_resolution"];
	gCQ_PosUtil = [if (count _base > 2) then {_base} else {_base + [0]}, _dir, if (_radius > 0) then {_radius} else {CRQ_POS_UTIL_RADIUS}, if (_resolution > 0) then {_resolution} else {CRQ_POS_UTIL_RESOLUTION}];
};
CRQ_PosUtil = { // TODO deprecated, replace with VecUtil
	params ["_iMode", "_iArg"];
	private _pos = gCQ_PosUtil#0;
	private _modes = [];
	private _args = [];
	if (_iMode isEqualType -1) then {
		_modes = [_iMode];
		_args = [_iArg];
	} else {
		_modes = _iMode;
		_args = _iArg;
	};
	{
		private _argv = _args#_forEachIndex;
		private _argc = count _argv;
		switch (_x) do {
			case CRQ_POS_ABS: {
				if (_argc > 1) then {
					_pos set [0, _argv#0];
					_pos set [1, _argv#1];
					if (_argc > 2) then {_pos set [2, _argv#2];} else {_pos set [2, 0];};
				} else {
					if (_argc > 0) then {
						_pos = _argv#0;
					};
				};
			};
			case CRQ_POS_REL: {
				if (_argc > 1) then {
					_pos set [0, (_pos#0) + (_argv#0)];
					_pos set [1, (_pos#1) + (_argv#1)];
					if (_argc > 2) then {_pos set [2, (_pos#2) + (_argv#2)];} else {_pos set [2, 0];};
				} else {
					if (_argc > 0) then {
						_pos set [0, (_pos#0) + (_argv#0#0)];
						_pos set [1, (_pos#1) + (_argv#0#1)];
						if (count (_argv#0) > 2) then {_pos set [2, (_pos#2) + (_argv#0#2)];};// else {_pos set [2, 0];};
					};
				};
			};
			case CRQ_POS_VEC: {
				if (_argc > 1) then {
					_pos = _pos getPos [_argv#0, (gCQ_PosUtil#1) + (_argv#1)];
				};
			};
			case CRQ_POS_VECZ: {
				if (_argc > 2) then {
					_pos = _pos getPos [_argv#0, (gCQ_PosUtil#1) + (_argv#1)];
					_pos set [2, (_pos#2) + (_argv#2)];
				};
			};
			case CRQ_POS_FIND: {
				if (_argc > 0) then {
					private _radius = if (_argc > 1) then {_argv#1} else {(gCQ_PosUtil#2)};
					private _resolution = if (_argc > 2) then {_argv#2} else {(gCQ_PosUtil#3)};
					private _attempt = 0;
					while {_attempt < 8} do {
						private _options = selectBestPlaces [_pos, _radius, _argv#0, _resolution, 1];
						if (_options isNotEqualTo []) exitWith {_pos = _options#0#0;};
						_attempt = _attempt + 1;
					};
				};
			};
			case CRQ_POS_EMPTY : {
				if (_argc > 0) then {
					private _radius = if (_argc > 1) then {_argv#1} else {(gCQ_PosUtil#2)};
					_pos = [_pos, 0, _radius, _argv#0, 0, 0, 0, [], [(gCQ_PosUtil#0), (gCQ_PosUtil#0)]] call BIS_fnc_findSafePos;
				};
			};
			default {};
		};
	} forEach _modes;
	_pos
};
CRQ_VecUtilSetup = {
	params ["_vec", "_radius", "_resolution"];
	gCQ_VecUtil = [if (count (_vec#0) > 2) then {_vec} else {[(_vec#0) + [0], _vec#1]}, if (_radius > 0) then {_radius} else {CRQ_VEC_UTIL_RADIUS}, if (_resolution > 0) then {_resolution} else {CRQ_VEC_UTIL_RESOLUTION},true,objNull];
};
CRQ_VecUtilValid = {
	(gCQ_VecUtil#3)
};
CRQ_VecUtilObject = {
	(gCQ_VecUtil#4)
};
CRQ_VecUtil = {
	params ["_iMode", "_iArg"];
	private _vec = +(gCQ_VecUtil#0);
	private _modes = [];
	private _args = [];
	if (_iMode isEqualType -1) then {
		_modes = [_iMode];
		_args = [_iArg];
	} else {
		_modes = _iMode;
		_args = _iArg;
	};
	{
		private _argv = _args#_forEachIndex;
		private _argc = count _argv;
		switch (_x) do {
			case CRQ_POS_ABS: {
				if (_argc > 1) then {
					(_vec#0) set [0, _argv#0];
					(_vec#0) set [1, _argv#1];
					if (_argc > 2) then {(_vec#0) set [2, _argv#2];} else {(_vec#0) set [2, 0];};
				} else {
					if (_argc > 0) then {
						_vec set [0, _argv#0];
					};
				};
			};
			case CRQ_VEC_ABS: {
				if (_argc > 1) then {
					(_vec#0) set [0, _argv#0#0];
					(_vec#0) set [1, _argv#0#1];
					if (count (_argv#0) > 2) then {(_vec#0) set [2, _argv#0#2];} else {(_vec#0) set [2, 0];};
					_vec set [1, _argv#1];
				};
			};
			case CRQ_POS_REL: {
				if (_argc > 1) then {
					(_vec#0) set [0, (_vec#0#0) + (_argv#0)];
					(_vec#0) set [1, (_vec#0#1) + (_argv#1)];
					if (_argc > 2) then {(_vec#0) set [2, (_vec#0#2) + (_argv#2)];} else {(_vec#0) set [2, 0];};
				} else {
					if (_argc > 0) then {
						(_vec#0) set [0, ((_vec#0)#0) + (_argv#0#0)];
						(_vec#0) set [1, ((_vec#0)#1) + (_argv#0#1)];
						if (count (_argv#0) > 2) then {(_vec#0) set [2, ((_vec#0)#2) + (_argv#0#2)];};
					};
				};
			};
			case CRQ_VEC_REL: {
				if (_argc > 1) then {
					(_vec#0) set [0, (_vec#0#0) + (_argv#0#0)];
					(_vec#0) set [1, (_vec#0#1) + (_argv#0#1)];
					if (count (_argv#0) > 2) then {(_vec#0) set [2, (_vec#0#2) + (_argv#0#2)];};
					_vec set [1, (_vec#1) + (_argv#1)];
				};
			};
			case CRQ_POS_VEC: {
				if (_argc > 1) then {
					_vec set [0, (_vec#0) getPos [_argv#0, (_vec#1) + (_argv#1)]];
				};
			};
			case CRQ_VEC_VEC: {
				if (_argc > 1) then {
					_vec set [0, (_vec#0) getPos [_argv#0#0, (_vec#1) + (_argv#0#1)]];
					_vec set [1, (_vec#1) + (_argv#1)];
				};
			};
			case CRQ_POS_VECZ: {
				if (_argc > 2) then {
					_vec set [0, (_vec#0) getPos [_argv#0, (_vec#1) + (_argv#1)]];
					(_vec#0) set [2, ((_vec#0)#2) + (_argv#2)];
				};
			};
			case CRQ_VEC_VECZ: {
				if (_argc > 2) then {
					_vec set [0, (_vec#0) getPos [_argv#0#0, (_vec#1) + (_argv#0#1)]];
					(_vec#0) set [2, ((_vec#0)#2) + (_argv#0#2)];
					_vec set [1, (_vec#1) + (_argv#1)];
				};
			};
			case CRQ_POS_FIND: {
				gCQ_VecUtil set [3, false];
				if (_argc > 0) then {
					private _radius = if (_argc > 1) then {_argv#1} else {(gCQ_VecUtil#1)};
					private _resolution = if (_argc > 2) then {_argv#2} else {(gCQ_VecUtil#2)};
					private _attempt = 0;
					while {_attempt < 8} do {
						private _options = selectBestPlaces [_vec#0, _radius, _argv#0, _resolution, 1];
						if (_options isNotEqualTo []) exitWith {_vec set [0, _options#0#0]; gCQ_VecUtil set [3, true];};
						_attempt = _attempt + 1;
					};
				};
			};
			case CRQ_VEC_FIND: {
				gCQ_VecUtil set [3, false];
				if (_argc > 1) then {
					(_argv#0) params ["_criteria", ["_radius", (gCQ_VecUtil#1)], ["_resolution", (gCQ_VecUtil#2)]];
					//private _radius = if (_argc > 1) then {_argv#1} else {(gCQ_VecUtil#1)};
					//private _resolution = if (_argc > 2) then {_argv#2} else {(gCQ_VecUtil#2)};
					private _attempt = 0;
					while {_attempt < 8} do {
						private _options = selectBestPlaces [_vec#0, _radius, _criteria, _resolution, 1];
						if (_options isNotEqualTo []) exitWith {
							_vec set [0, _options#0#0];
							switch (_argv#1) do {
								default {_vec set [1, _argv#1];};
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
						};
						_attempt = _attempt + 1;
					};
				};
			};
			case CRQ_POS_EMPTY : {
				if (_argc > 0) then {
					private _radius = if (_argc > 1) then {_argv#1} else {(gCQ_VecUtil#1)};
					_vec set [0, [_vec#0, 0, _radius, _argv#0, 0, 0, 0, [], [+(gCQ_VecUtil#0#0), +(gCQ_VecUtil#0#0)]] call BIS_fnc_findSafePos]; // TODO implement valid
				};
			};
			case CRQ_VEC_HOUSE: {
				gCQ_VecUtil set [3, false];
				gCQ_VecUtil set [4, objNull];
				if (_argc > 0) then {
					private _model = toLowerANSI ((_argv#0) call CRQ_ClassModel);
					private _radius = if (_argc > 1) then {_argv#1} else {(gCQ_VecUtil#1)};
					if (if (_argc > 2) then {_argv#2} else {false}) then {
						{if (_model == (_x call CRQ_ObjectModel)) exitWith {_vec = [getPosATL _x, getDir _x]; gCQ_VecUtil set [3, true]; gCQ_VecUtil set [4, _x];};} forEach (nearestTerrainObjects [_vec#0, ["HOUSE"], _radius, true, true]);
					} else {
						private _candidates = [];
						{if (_model == (_x call CRQ_ObjectModel)) then {_candidates pushBack _x;};} forEach (nearestTerrainObjects [_vec#0, ["HOUSE"], _radius, false, true]);
						if (_candidates isNotEqualTo []) then {
							private _obj = selectRandom _candidates;
							_vec = [getPosATL _obj, getDir _obj];
							gCQ_VecUtil set [3, true];
							gCQ_VecUtil set [4, _obj];
						};
					};
				};
			};
			default {};
		};
	} forEach _modes;
	_vec
};
CRQ_Nighttime = {
	private _dayTime = dayTime;
	(_dayTime >= CRQ_TIME_NIGHT_MIN || _dayTime <= CRQ_TIME_NIGHT_MAX)
};
CRQ_Daytime = {
	private _dayTime = dayTime;
	(_dayTime < CRQ_TIME_NIGHT_MIN && _dayTime > CRQ_TIME_NIGHT_MAX)
};
CRQ_Lights = {
	([0,0,0] getEnvSoundController "night" > 0.7)
};
CRQ_WorldLocations = {
	private _axis = worldSize / 2; // worldSize is a calculation, config >> worldName might be faster? probably hardly makes a difference
	nearestLocations [[_axis, _axis], _this, 1.42 * _axis, [0, 0]]
};
CRQ_WorldTerrainObjects = {
	private _axis = worldSize / 2;
	nearestTerrainObjects [[_axis, _axis], _this, 1.42 * _axis, false, true]
};
CRQ_WorldClutter = {
	params ["_pos", "_radius"];
	private _ignore = if (count _this > 2) then {_this#2} else {[]};
	private _radiusExtra = if (count _this > 3) then {_this#3} else {CRQ_CLUTTER_EXTRA};
	private _clutter = [];
	{if (_ignore find _x == -1 && {(_pos distance2D _x) < (_radius + ((_x call CRQ_ObjectSize)#0))}) then {_clutter pushBack _x;};} forEach (nearestTerrainObjects [_pos, [], _radius + _radiusExtra, false, true]);
	_clutter
};
CRQ_ClassModel = {
	private _path = (getText (gCQ_CfgVehicles >> _this >> "model")) splitString "\";
	private _last = (count _path - 1);
	if (_last < 0) then {
		""
	} else {
		(_path#_last)
	};
};
CRQ_ClassSize = {
	private _obj = createSimpleObject [_this , [0,0,0], true];
	_obj enableSimulation false;
	_obj allowDamage false;
	hideObject _obj;
	private _return = _obj call CRQ_ObjectSize;
	deleteVehicle _obj;
	_return
};
CRQ_ClassCenter = {
	private _obj = createSimpleObject [_this , [0,0,0], true];
	_obj enableSimulation false;
	_obj allowDamage false;
	hideObject _obj;
	private _return = boundingCenter _obj;
	deleteVehicle _obj;
	_return
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
CRQ_ObjectSpawnPosAdjust = {
	params ["_object", "_pos"];
	private _center = boundingCenter _object;
	if ((abs (_center#0)) > CRQ_CENTER_OFFSET_TOLERANCE || (abs (_center#1)) > CRQ_CENTER_OFFSET_TOLERANCE) then {_object setPosWorld [_pos#0, _pos#1, (getPosWorld _object)#2];};
};
CRQ_PropRasterize = {
	params ["_vec", "_sources"];
	private _basePos = _vec#0;
	private _baseDir = _vec#1;
	[_basePos, _baseDir, 0, 0] call CRQ_PosUtilSetup;
	private _rasterized = [];
	{_rasterized pushBack [_x#0, [(_x#1) call CRQ_PosUtil, _baseDir + (_x#2)]];} forEach _sources;
	_rasterized
};
CRQ_PropSpawn = {
	private _props = [];
	{
		_x params ["_type", "_vec"];
		if (_type isNotEqualTo "") then {
			private _object = createVehicle [_type, _vec#0, [], 0, "CAN_COLLIDE"];
			_object setDir (_vec#1);
			[_object, _vec#0] call CRQ_ObjectSpawnPosAdjust;
			_object allowDamage false;
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
CRQ_GetIdentity = {
	[face _this, speaker _this, name _this, nameSound _this, pitch _this]
};
CRQ_SetIdentity = {
	params ["_unit", "_identity"];
	_identity params ["_face", "_voice", "_name", "_callsign", "_pitch"];
	_unit setFace _face;
	_unit setSpeaker _voice;
	_unit setName _name;
	_unit setNameSound _callsign;
	_unit setPitch _pitch;
};
CRQ_GetLoadout = {
	getUnitLoadout _this
};
CRQ_SetLoadout = {
	params ["_unit", "_loadout"];
	_unit setUnitLoadout _loadout;
	if (alive _unit) then {_unit switchMove "";};
};
CRQ_Side = {
	switch (_this) do {
		case CRQ_SIDE_BLUFOR: {west};
		case CRQ_SIDE_IDFOR: {resistance};
		case CRQ_SIDE_OPFOR: {east};
		case CRQ_SIDE_CIVFOR: {civilian};
		case CRQ_SIDE_UNKNOWN: {sideUnknown};
		case west: {CRQ_SIDE_BLUFOR};
		case resistance: {CRQ_SIDE_IDFOR};
		case east: {CRQ_SIDE_OPFOR};
		case civilian: {CRQ_SIDE_CIVFOR};
		case sideUnknown: {CRQ_SIDE_UNKNOWN};
		default {CRQ_SIDE_UNKNOWN};
	};
};
CRQ_SideLabel = {
	switch (_this) do {
		case CRQ_SIDE_BLUFOR: {CQM_SIDE_LABEL_BLUFOR};
		case CRQ_SIDE_IDFOR: {CQM_SIDE_LABEL_IDFOR};
		case CRQ_SIDE_OPFOR: {CQM_SIDE_LABEL_OPFOR};
		case CRQ_SIDE_CIVFOR: {CQM_SIDE_LABEL_CIVFOR};
		case CRQ_SIDE_UNKNOWN: {CQM_SIDE_LABEL_UNKNOWN};
		case west: {CQM_SIDE_LABEL_BLUFOR};
		case resistance: {CQM_SIDE_LABEL_IDFOR};
		case east: {CQM_SIDE_LABEL_OPFOR};
		case civilian: {CQM_SIDE_LABEL_CIVFOR};
		case sideUnknown: {CQM_SIDE_LABEL_UNKNOWN};
		default {CQM_SIDE_LABEL_UNKNOWN};
	};
};
CRQ_GroupCreate = {
	private _group = createGroup [(_this call CRQ_Side), false];
	deleteWaypoint [_group, 0];
	_group
};
CRQ_GroupMode = {
	params ["_group", "_mode", "_form"];
	private _behaviour = switch (_mode) do {case 0: {"CARELESS"}; case 1: {"STEALTH"}; case 2: {"COMBAT"}; case 3: {"AWARE"}; case 4: {"SAFE"}; default {"UNCHANGED"};};
	private _speed = switch (_mode) do {case 0: {"LIMITED"}; case 1: {"NORMAL"}; case 2: {"FULL"}; case 3: {"NORMAL"}; case 4: {"LIMITED"}; default {"UNCHANGED"};};
	private _formation = if ((_form - 1) < 0) then {selectRandom CRQ_GROUP_FORMATION} else {CRQ_GROUP_FORMATION#(_form - 1)};
	_group setFormation _formation;
	_group setSpeedMode _speed;
	_group setBehaviour _behaviour;
	//_group setBehaviourStrong _mode;
	//{_x setSpeedMode _speed; _x setBehaviour _mode; //_x setBehaviourStrong _mode;} forEach units _group;
};
CRQ_GroupWaypointsClear = {
	for [{private _i = ((count (waypoints _this)) - 1)}, {_i >= 0}, {_i = _i - 1}] do {deleteWaypoint [_this, _i];};
};
CRQ_GroupWaypointsInfantryGarrison = {
	params ["_group", "_points"];
	if ((!isNull _group ) && (_points isNotEqualTo [])) then {
		private _waypoint = [];
		_waypoint = _group addWaypoint [_points#0, CRQ_AI_RADIUS_MOVE_INFANTRY];
		_waypoint setWaypointType "MOVE";
		private _pattern = selectRandom CRQ_AI_PATTERN_GARRISON;
		{
			_waypoint = _group addWaypoint [_points#0, CRQ_AI_RADIUS_MOVE_INFANTRY];
			_waypoint setWaypointType "SCRIPTED";
			_waypoint setWaypointScript ("CRQ\CRQ_AI_Group.sqf " + str ([_x]));
		} forEach _pattern;
		_waypoint = _group addWaypoint [_points#0, CRQ_AI_RADIUS_MOVE_INFANTRY];
		_waypoint setWaypointType "MOVE";
		_waypoint = _group addWaypoint [_points#0, CRQ_AI_RADIUS_MOVE_INFANTRY];
		_waypoint setWaypointType "CYCLE";
	};
};
CRQ_GroupWaypointsInfantryPatrol = {
	params ["_group", "_points"];
	if ((!isNull _group ) && (_points isNotEqualTo [])) then {
		private _pos = _group call CRQ_PosGroup;
		private _closest = [_pos, _points] call CRQ_PosClosest;
		private _count = count _points;
		private _waypoint = [];
		for [{private _i = 0;},{_i < _count},{_i = _i + 1;}] do {
			private _pos = _points#((_closest + _i) % _count);
			_waypoint = _group addWaypoint [_pos, CRQ_AI_RADIUS_MOVE_INFANTRY];
			_waypoint setWaypointType "MOVE";
			private _pattern = selectRandom CRQ_AI_PATTERN_PATROL;
			{
				_waypoint = _group addWaypoint [_pos, CRQ_AI_RADIUS_MOVE_INFANTRY];
				_waypoint setWaypointType "SCRIPTED";
				_waypoint setWaypointScript ("CRQ\CRQ_AI_Group.sqf " + str ([_x]));
			} forEach _pattern;
		};
		_waypoint = _group addWaypoint [_points#_closest, CRQ_AI_RADIUS_MOVE_INFANTRY];
		_waypoint setWaypointType "MOVE";
		_waypoint = _group addWaypoint [_points#_closest, CRQ_AI_RADIUS_MOVE_INFANTRY];
		_waypoint setWaypointType "CYCLE";
	};
};
CRQ_GroupWaypointsVehicleTravel = {
	params ["_group", "_points"];
	{
		private _waypoint = _group addWaypoint [_x, CRQ_AI_RADIUS_MOVE_VEHICLE];
		_waypoint setWaypointType "MOVE";
		_waypoint setWaypointCompletionRadius CRQ_AI_RADIUS_MOVE_VEHICLE_COMPLETE;
		_waypoint setWaypointTimeout [0,0,0];
	} forEach _points;
};
CRQ_GroupWaypointsVehiclePatrol = {
	params ["_group", "_points"];
	if ((!isNull _group ) && (_points isNotEqualTo [])) then {
		private _pos = _group call CRQ_PosGroup;
		private _closest = [_pos, _points] call CRQ_PosClosest;
		private _count = count _points;
		private _waypoint = [];
		for [{private _i = 0;},{_i < _count},{_i = _i + 1;}] do {
			private _pos = _points#((_closest + _i) % _count);
			_waypoint = _group addWaypoint [_pos, CRQ_AI_RADIUS_MOVE_VEHICLE];
			_waypoint setWaypointType "MOVE";
			_waypoint setWaypointCompletionRadius CRQ_AI_RADIUS_MOVE_VEHICLE_COMPLETE;
			private _pattern = selectRandom CRQ_AI_PATTERN_VEHICLE;
			{
				_waypoint = _group addWaypoint [_pos, CRQ_AI_RADIUS_MOVE_VEHICLE];
				_waypoint setWaypointType "SCRIPTED";
				_waypoint setWaypointScript ("CRQ\CRQ_AI_Group.sqf " + str ([_x]));
			} forEach _pattern;
		};
		_waypoint = _group addWaypoint [_points#_closest, CRQ_AI_RADIUS_MOVE_VEHICLE];
		_waypoint setWaypointType "MOVE";
		_waypoint setWaypointCompletionRadius CRQ_AI_RADIUS_MOVE_VEHICLE_COMPLETE;
		_waypoint = _group addWaypoint [_points#_closest, CRQ_AI_RADIUS_MOVE_VEHICLE];
		_waypoint setWaypointType "CYCLE";
	};
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
CRQ_InventoryAppend = {
	params ["_inventory", "_append"];
	(_inventory#0#0) append (_append#0#0);
	(_inventory#0#1) append (_append#0#1);
	(_inventory#0#2) append (_append#0#2);
	(_inventory#1) append (_append#1);
	_inventory
};
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
CRQ_InventoryBoxClear = {
	clearItemCargoGlobal _this;
	clearMagazineCargoGlobal _this;
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
	params ["_unit", "_preserve", "_includeUniform"];
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
	params ["_unit", "_target"];
	private _content = [_unit, false, false] call CRQ_InventoryUnit;
	[_unit, _unit call CRQ_UnitLoadoutBlank] call CRQ_SetLoadout;
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
		for [{private _i = 0}, {_i < _countMags}, {_i = _i + 1}] do {_mags pushBack [_x, _roundsFull];};
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
		switch (getNumber (gCQ_CfgWeapons >> (_x#0) >> "type")) do {
			case 1: {_loadout set [0, _x];};
			case 2: {_loadout set [2, _x];};
			case 4: {_loadout set [1, _x];};
			default {};
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
	private _container = [];
	{if ((_loadout#_x) isNotEqualTo []) then {_container pushBack _x;};} forEach [4,3,5];
	{
		private _target = [];
		{switch (_x) do { case 801: {_target pushBack 3;}; case 701: {_target pushBack 4;}; case 901: {_target pushBack 5;}; default {};};} forEach (getArray (gCQ_CfgMagazines >> (_x#0) >> "allowedSlots"));
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
CRQ_InventoryLoadoutMinAmmo = { // TODO
	params ["_loadout", "_primary"];
	private _secondary = if (count _this > 2) then {_this#2} else {-1};
	private _handgun = if (count _this > 3) then {_this#3} else {-1};
};
CRQ_VehiclesFind = {
	params ["_pos", "_radius"];
	private _vehicles = [];
	{
		private _obj = _x;
		{if (_obj isKindOf _x) exitWith {_vehicles pushBack _obj;};} forEach ["car","tank","helicopter","plane","ship"];
	} forEach (_pos nearObjects _radius);
	_vehicles
};
CRQ_WrecksFind = {
	private _vehicles = _this call CRQ_VehiclesFind;
	private _wrecks = [];
	{if (!alive _x) then {_wrecks pushBack _x;};} forEach _vehicles;
	_wrecks
};

CRQ_UnitCreate = {
	params ["_group", "_type", "_vector"];
	private _argc = count _this;
	private _unit = _group createUnit [_type, _vector#0, [], 0, "CAN_COLLIDE"];
	_unit setDir (_vector#1);
	if (_argc > 3 && {(_this#3) isNotEqualTo []}) then {[_unit, _this#3] call CRQ_SetLoadout;};
	if (_argc > 4 && {(_this#4) isNotEqualTo []}) then {[_unit, _this#4] remoteExec ["CRQ_SetIdentity", gCS_Broadcast];};
	if (_argc > 5) then {_unit setSkill (_this#5);};
	if (_argc > 6) then {_unit setDamage (_this#6);};
	_unit
};
CRQ_UnitDelete = {
	if (!isNull _this) then { // apparently, hideBody might/will cause corpse to automatically be deleted anyways?
		private _vehicle = objectParent _this;
		if (!isNull _vehicle) then {moveOut _this;}; // TODO something, something deleteVehicleCrew
		deleteVehicle _this;
	};
};
CRQ_UnitLoadoutBlank = {
	private _unit = if (_this isEqualType objNull) then {_this} else {_this#0};
	private _naked = if (_this isEqualType [] && {count _this > 1}) then {_this#1} else {false};
	if (_naked) then {
		[[],[],[],[],[],[],"","",[],["","","","","",""]]
	} else {
		[[],[],[],[uniform _unit, []],[],[],"","",[],["","","","","",""]]
	};
};
CRQ_VehicleCreate = {
	params ["_type", "_vector"];
	private _argc = count _this;
	private _vehicle = createVehicle [_type, _vector#0, [], 0, "CAN_COLLIDE"];
	[_vehicle, _vector#0] call CRQ_ObjectSpawnPosAdjust;
	_vehicle setDir (_vector#1); // TODO setPosWorld?
	if (_argc > 2 && {(_this#2) isNotEqualTo []}) then {_vehicle call CRQ_InventoryBoxClear; [_vehicle, _this#2] call CRQ_InventoryBoxAppend;};
	if (_argc > 3) then {_vehicle setDamage (_this#3);};
	_vehicle
};
CRQ_VehicleDelete = {
	if (!isNull _this) then {
		{moveOut _x;} forEach (crew _this);
		deleteVehicle _this;
	};
};


