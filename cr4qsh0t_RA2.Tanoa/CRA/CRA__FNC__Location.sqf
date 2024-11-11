
CRA_fnc_LC_Owner = {
	if (_this isEqualType locationNull) exitWith {((_this getVariable [CRA_SVAR_LC_OWNER, [[CRQ_SD_UNKNOWN]]])#0) select -1};
	params ["_location", ["_history", 0]];
	(_location getVariable [CRA_SVAR_LC_OWNER, [[CRQ_SD_UNKNOWN]]]) params [["_owLog", []], ["_owFav", []]];//, ["_owRoll", [0,0,0,1]]];
	if (_history < 0) exitWith {
		if (_owFav isEqualTo []) exitWith {[CRQ_SD_UNKNOWN, 0]};
		_owFav
	};
	if (_owLog isEqualTo []) exitWith {CRQ_SD_UNKNOWN};
	if (_history > 0) exitWith {
		private _count = count _owLog;
		_owLog#(_count - 1 - (_history % _count))
	};
	(_owLog select -1)
};
CRA_fnc_LC_Generate = {
	params ["_inData", "_inType", "_inBase", ["_inOwner", -1], ["_inVars", []]];
	_inData params ["_inIndex", "_inVec", "_inName", "_inLabel", ["_inAnchorObj", objNull]];
	(if (_inType isEqualType -1) then {dCRA_LC_TYPES#_inType} else {_inType}) params ["_lcConfig", "_lcFnc", "_lcPersonnel", "_lcBases"];
	(if (_inBase isEqualType -1) then {dCRA_BASE_INDEX#_inBase} else {_inBase}) params ["_bsData", ["_bsInst", []], ["_bsProp", []], ["_bsPersonnel", []]];
	
	_lcConfig params ["_lcType", "", "_lc_fnc_ID", "_lc_fnc_label", "", "_lcValue", "_lcCapture", "_lcMarkerConfig"];
	
	private _lcName = [_inName, _inLabel, _inIndex, _inVec] call _lc_fnc_ID;
	private _lcLabel = [_inName, _inLabel, _inIndex, _inVec] call _lc_fnc_label;
	
	_bsData params ["", "_bsArea", "_bsPlayer", ["_bsClutter", true]]; // TODO flip clutter and player around
	if (_bsArea isEqualType -1) then {_bsArea = ((sqrt (0.5)) * _bsArea) call {[[_this, _this],[0,0]]};};
	private _bsSize = _bsArea call CRQ_AreaMinMax;
	private _bsRadius = sqrt ((_bsSize#1#0) ^ 2 + (_bsSize#1#1) ^ 2);
	
	private _lcNew = [_inVec, _lcName, _lcLabel, _lcType, [(_bsSize#1#0) * 2, (_bsSize#1#1) * 2]] call CRQ_LocationCreate;
	_lcNew setVariable [CRA_SVAR_ID, name _lcNew]; // TODO verify returned name and requested name same, else error
	_lcNew setVariable [CRA_SVAR_VEC, _inVec];
	
	_lcMarkerConfig params [["_lc_fnc_marker", [{""}, {""}]], ["_lcMarkerType", []]];
	private _lcMarkerID = [[_inName, _inLabel, _inIndex, _inVec] call (_lc_fnc_marker#0), [_inName, _inLabel, _inIndex, _inVec] call (_lc_fnc_marker#1)];
	_lcNew setVariable [CRA_SVAR_LC_MARKER, [_lcMarkerID, _lcMarkerType]];
	if ((_lcMarkerID#0) isNotEqualTo "" && {(createMarker [(_lcMarkerID#0), _inVec#0]) isNotEqualTo ""}) then {(_lcMarkerID#0) setMarkerTextLocal (_lcMarkerID#1);};
	
	_lcNew setVariable [CRA_SVAR_FNC_MAIN, _lcFnc#0];
	_lcNew setVariable [CRA_SVAR_FNC_TRIG, [_lcFnc#1, (_lcFnc#1) apply {0}]];
	
	if (_bsPlayer isNotEqualTo []) then {
		[_inVec, _bsRadius] call CRQ_VecUtilSetup;
		_lcNew setVariable [CRA_SVAR_LC_SPAWN_PLAYER, _bsPlayer call CRQ_VecUtil];
	};
	_lcNew setVariable [CRA_SVAR_LC_INDEX, _inIndex];
	
	// TODO CRITICAL this very temporary workaround (?)
	// D310: Not sure if above is still actually critical and may have already been fixed?
	[_lcNew, _inOwner] call CRA_LocationOwnerInit;
	
	_lcNew setVariable [CRA_SVAR_LC_STATE, CRA_STATE_INIT];
	_lcNew setVariable [CRA_SVAR_LOCATION_UNCAPTURED, true];
	_lcNew setVariable [CRA_SVAR_LOCATION_DISCOVER, false];
	_lcNew setVariable [CRA_SVAR_LOCATION_TYPE, _inType];
	_lcNew setVariable [CRA_SVAR_LC_VALUE, _lcValue];
	_lcNew setVariable [CRA_SVAR_LOCATION_CAPTUREABLE, _lcCapture];
	
	
	
	if (_bsClutter) then {
		private _bsOffVec = [(_inVec#0) vectorAdd ([_bsArea#1, _inVec#1] call CRQ_AreaOffsetRotate), _inVec#1];
		_lcNew setVariable [CRA_SVAR_LOCATION_CLUTTER, [_bsOffVec, _bsArea#0, if (_inAnchorObj isEqualTo objNull) then {[]} else {[_inAnchorObj]}, 24, gRA_PM_SystemClutterDetect] call CRQ_WorldClutter2D];
	};
	
	private _installations = [];
	{if (_x) then {_installations pushBack (_bsInst#_forEachIndex);} else {_installations pushBack ['',[]];};} forEach ((_lcBases#0) call CRQ_fnc_ByteDecode);
	_lcNew setVariable [CRA_SVAR_LOCATION_BASE_INST, [[_inVec, _bsRadius], _installations] call CRQ_PropRasterize];
	_lcNew setVariable [CRA_SVAR_LOCATION_BASE_PROP, [[_inVec, _bsRadius], _bsProp] call CRQ_PropRasterize];
	
	if (_lcPersonnel isNotEqualTo []) then {
		private _psCount = (_lcPersonnel#1) apply {0};
		private _wpTypes = dCRA_GP_WP_LOCATION#_inType; // TODO D310 these inTypes will fail if they are arrays!
		private _wpCount = dRA_WaypointCount#_inType;
		private _psSource = _bsPersonnel apply {
			private _role = _x#0#0;
			private _waypoints = _x#1;
			private _count = count _waypoints;
			[_psCount, _role, 1] call CRQ_fnc_ArrayIncrement;
			[_x#0, _waypoints + ((_wpTypes#_role) select [_count, (_wpCount#_role) - _count])]
		};
		{for "_i" from _x to ((_lcPersonnel#1#_forEachIndex) - 1) do {_psSource pushBack [CRA_PERSONNEL_TYPES#_forEachIndex, _wpTypes#_forEachIndex];};} forEach _psCount;
		private _personnel = [];
		{
			private _waypoints = [[_inVec, _bsRadius], _x#1] call CRQ_VecRasterize;
			if (_waypoints isNotEqualTo []) then {_personnel pushBack [_x#0, _waypoints];};
		} forEach _psSource;
		private _psStrength = [];
		{_psStrength pushBack (_x * (CRA_STRENGTH#_forEachIndex));} forEach (_lcPersonnel#0);
		_lcNew setVariable [CRA_SVAR_LOCATION_STRENGTH, _psStrength];
		_lcNew setVariable [CRA_SVAR_LOCATION_BASE_PERSONNEL, _personnel];
	};
	
	[_lcNew, createHashMapFromArray _inVars] call CRQ_VarRestore;
	
	_lcNew
};

CRA_fnc_LC_InitDepot = {
	private _fnc_boundsCalculate = {
		params ["_depot", "_type", "_spawn"];
		private _class = "";
		private _model = "";
		private _size = [];
		if (_depot isEqualType "") then {
			_class = _depot;
			_model = toLowerANSI (_depot call CRQ_ClassModel);
			_size = _depot call CRQ_ClassSize;
		} else {
			_size = _depot;
		};
		private _rasterized = _spawn apply {
			_x params ["_spMode", "_spType", "_spBounds", "_spDir"];
			private _spRasterized = switch (_spType) do {
				case CRA_DEPOT_POS_INSIDE: {private _bounds = []; {_bounds pushBack (if (_x < 0) then {-_x * (_size#1#_forEachIndex)} else {_x});} forEach _spBounds; _bounds};
				case CRA_DEPOT_POS_BOAT: {[(_size#0) * (_spBounds#0) * CRA_DEPOT_PIER_CLEARANCE, _spBounds#1]};
				default {[]};
			};
			[_spMode, _spType, _spRasterized, _spDir]
		};
		[_class, _model, _type, _size, _rasterized]
	};
	private _fnc_customCreate = {
		private _index = (_this#0);
		(_this#1) params ["_dpVec", "_dpData", ["_dpProps", []]];
		private _dpBounds = _dpData call {
			if (_this isEqualType -1) exitWith {
				_dpProps = [[gRA_DepotTypes#_this#0,[[CRQ_VU_PREL]]]] + _dpProps;
				gRA_DepotTypes#_this
			};
			if (_this isEqualType []) exitWith {
				if ((_this#0) isEqualType "") then {_dpProps = [[_this#0,[[CRQ_VU_PREL]]]] + _dpProps;};
				_this call _fnc_boundsCalculate
			};
			[]
		};
		[
			[gRA_LC_IndexDepot + _index, _dpVec, str _index, ""],
			CRA_ASSET_DEPOTS#(_dpBounds#2),
			[[[] ,[[(_dpBounds#3#1#0) / 2, (_dpBounds#3#1#1) / 2], [0, 0]], [], true], [], _dpProps],
			[_dpVec, _dpBounds] call CRA_DepotAnalysis
		]
	};
	gRA_DepotTypes = dCRA_DEPOT_TYPES apply {_x call _fnc_boundsCalculate};
	gRA_DepotModels = createHashMap;
	{gRA_DepotModels set [_x#1, _forEachIndex];} forEach gRA_DepotTypes;
	private _cntHouse = 0;
	{_cntHouse = _cntHouse + count _x;} forEach gRA_MAP_House;
	CRA_LOAD_NEXT(0, _cntHouse);
	private _candidates = [];
	{
		{
			CRA_LOAD_INDEX(_forEachIndex);
			private _model = gRA_DepotModels getOrDefault [toLowerANSI (_x call CRQ_ObjectModel), -1];
			if (_model != -1 && {((vectorUp _x)#2) / (getObjectScale _x) >= CRA_DEPOT_VECTORUP_MIN}) then {_candidates pushBack [_x, _model];};
		} forEach _x;
	} forEach gRA_MAP_House;
	
	CRA_LOAD_NEXT(0, count _candidates);
	private _depotTypes = CRA_ASSET_CLASSES apply {createHashMap};
	private _countObj = 0;
	{
		CRA_LOAD_INDEX(_forEachIndex);
		_x params ["_obj", "_model"];
		([_x#0, gRA_DepotTypes#_model] call CRA_DepotAnalysis) call {
			if (_this isNotEqualTo []) then {
				private _type = (gRA_DepotTypes#_model#2);
				private _tgt = (_depotTypes#_type);
				_tgt set [count _tgt, [_obj, _type, _this]];
				_countObj = _countObj + 1;
			};
		};
	} forEach _candidates;
	
	CRA_LOAD_NEXT(0, 2 * _countObj);
	private _depotGrp = CRA_ASSET_CLASSES apply {[]};
	private _loading = 0;
	{
		private _tgt = _depotGrp#_forEachIndex;
		private _proximity = CRA_DEPOT_GROUPING#_forEachIndex;
		private _depots = _x;
		private _indexes = _x apply {_x};
		{
			private _vehicles = [];
			{
				CRA_LOAD_INDEX(_loading);
				_loading = _loading + 1;
				(_depots get _x) params ["", "", "_spawn"];
				if (_vehicles isEqualTo []) then {
					_vehicles = [_spawn#0, _spawn#1];
				} else {
					private _offset = count (_vehicles#1);
					(_vehicles#1) append (_spawn#1);
					{
						private _vSide = _vehicles#0#_forEachIndex;
						{
							private _vType = _x#0;
							private _vSpawn = (_x#1) apply {_offset + _x};
							private _vExist = _vSide findIf {_vType == (_x#0)};
							if (_vExist != -1) then {
								(_vSide#_vExist#1) append _vSpawn;
							} else {
								_vSide pushBack [_vType, _vSpawn];
							};
						} forEach _x;
					} forEach (_spawn#0);
				};
			} forEach _y;
			_tgt pushBack [(_y apply {((_depots get _x)#0) call CRQ_Pos2D}) call CRQ_PosAvg, _vehicles];
		} forEach (([
			_indexes,
			{_this},
			{CRA_LOAD_INDEX(_loading); _loading = _loading + 1; ((_depots get _this)#0) call CRQ_Pos2D},
			{(_this#2) distance2D (((_depots get (_this#0))#0) call CRQ_Pos2D) < _proximity}
		] call CRQ_fnc_MAP_Group)#1);
	} forEach _depotTypes;
	
	CRA_LOAD_NEXT(0, 0);
	private _depots = [];
	private _index = 0;
	gRA_LC_IndexDepot = count gRA_LC_List;
	{
		private _type = CRA_ASSET_DEPOTS#_forEachIndex;
		{
			_depots pushBack [[gRA_LC_IndexDepot + _index, [_x#0, 0], str _index, ""], _type, [[[],CRA_DEPOT_SIZE,[],false],[],[]], _x#1];
			_index  = _index + 1;
		} forEach _x;
	} forEach _depotGrp;
	CRA_LOAD_NEXT(0, 0);
	{
		_depots pushBack ([_index, _x] call _fnc_customCreate);
		_index  = _index + 1;
	} forEach CRA_DEPOT_CUSTOM;
	CRA_LOAD_NEXT(0, 0);
	{
		_x params ["_lcData", "_lcType", "_lcBase", "_dpSpawn"];
		private _location = [_lcData, _lcType, _lcBase, CRQ_SD_CIV, [[CRA_SVAR_LC_SPAWN_ASSET, [_dpSpawn]]]] call CRA_fnc_LC_Generate;
		private _linkObj = [];
		private _linkData = [];
		{_linkObj pushBack [objNull, _forEachIndex]; _linkData pushBack [false, -1, -1];} forEach _dpSpawn;
		_linkObj pushBack [_location];
		[name _location, _linkObj, _linkData] call CRQ_fnc_LNK_Create;
		gRA_LC_List pushBack _location;
	} forEach _depots;
};
CRA_fnc_LC_InitBase = {
	CRA_LOAD_NEXT(0, 0);
	
	{
		private _anchors = _x#0#0;
		gRA_BS_Types pushBack (if (_anchors isNotEqualTo []) then {[[CRQ_VU_PHSE,[_anchors]]]} else {[[CRQ_VU_PFND,["meadow"],-2]]});
	} forEach dCRA_BASE_INDEX;
	
	private _srcTypes = dCRA_LC_SCAN apply {_x#0};
	
	private _worldLocations = (_srcTypes call CRQ_WorldLocations);
	
	CRA_LOAD_NEXT(0, count _worldLocations);
	private _proximity = [
		[CRA_LC_PROX_DEPOT, (gRA_LC_List select [gRA_LC_IndexDepot]) apply {locationPosition _x}],
		[CRA_LC_PROX_LOCATION, []]
	];
	gRA_LC_IndexBase = count gRA_LC_List;
	{
		CRA_LOAD_INDEX(_forEachIndex);
		private _scIndex = gRA_LC_IndexBase + _forEachIndex;
		private _scSource = _x;
		private _scName = className _scSource;
		private _scType = (type _scSource) call {_srcTypes findIf {_this == _x}}; // guaranteed not -1
		
		private _ovIndex = dCRA_LC_OVERRIDE findIf {_scName == (_x#0)};
		
		(if (_ovIndex != -1) then {
			dCRA_LC_OVERRIDE#_ovIndex#1
		} else {
			dCRA_LC_SCAN#_scType#1
		}) params ["_lcType", "_lcVec", "_lcSize", "_lcName", "_lcLabel"];
		
		if (_lcName isEqualTo "") then {_lcName = _scName;};
		if (_lcLabel isEqualTo "") then {_lcLabel = text _scSource;};
		
		private _lcRadius = ((if (_lcSize isEqualTo []) then {0} else {selectMax _lcSize}) + ((size _scSource)#0)) / 2;
		private _scVec = if (_lcVec isEqualTo []) then {
			[locationPosition _scSource, 0]
		} else {
			[[locationPosition _scSource, 0], _lcRadius] call CRQ_VecUtilSetup;
			_lcVec call CRQ_VecUtil
		};
		
		private _lcBaseSource = [];
		{_lcBaseSource append (_x call CRQ_fnc_ArrayRandomize);} forEach (dCRA_LC_TYPES#_lcType#3#1); // TODO location override optional bases
		{
			private _bsIndex = _x;
			[_scVec, _lcRadius] call CRQ_VecUtilSetup;
			private _vec = (gRA_BS_Types#_bsIndex) call CRQ_VecUtil;
			private _pos = _vec#0;
			private _include = [] call CRQ_VecUtilValid;
			{if (!_include) exitWith {}; private _dist = _x#0; {if (_x distance2D _pos < _dist) exitWith {_include = false};} forEach (_x#1);} forEach _proximity;
			if (_include) exitWith {
				gRA_LC_List pushBack ([[_scIndex, _vec, _lcName, _lcLabel, [] call CRQ_VecUtilObject], _lcType, _bsIndex] call CRA_fnc_LC_Generate);
				(_proximity#1#1) pushBack _pos;
			};
		} forEach _lcBaseSource;
	} forEach _worldLocations;
};
CRA_fnc_LC_InitRoadBlock = {
	private _rdTypeLast = count CRA_LCRB_TYPES - 1;
	private _rdTypeIndex = createHashMap;
	{_rdTypeIndex set [_x, _forEachIndex];} forEach CRA_LCRB_TYPES;
	private _fnc_path = {
		params ["_rdObj", "_rdPos"];
		private _path = [];
		private _path0 = [_rdObj, [], _rdPos, CRA_LCRB_LENGTH] call CRQ_RoadPath;
		private _noBridge = true;
		{if ((getRoadInfo _x)#8) exitWith {_noBridge = false};} forEach _path0;
		if (_noBridge && {count _path0 > 1}) then {
			private _path1 = [_rdObj, [_path0#1], _rdPos, CRA_LCRB_LENGTH] call CRQ_RoadPath;
			{if ((getRoadInfo _x)#8) exitWith {_noBridge = false};} forEach _path1;
			if (_noBridge && {count _path1 > 1}) then {
				for "_i" from (count _path0 - 1) to 1 step -1 do {_path pushBack (_path0#_i);};
				_path append _path1
			};
		};
		_path
	};
	private _fnc_analysis = {
		params ["_roads", ["_proximity", []], ["_tryMax", CRA_LCRB_SCANS], ["_try_fnc_Init", {}]];
		private _return = [];
		private _tryCount = 0;
		while {_tryCount < _tryMax && {_return isEqualTo []}} do {
			_tryCount = _tryCount + 1;
			_tryCount call _try_fnc_Init;
			private _rdType = CRA_LCRB_TYPES selectRandomWeighted CRA_LCRB_WEIGHTS;
			private _rdData = while {true} do {
				private _rdList = _roads getOrDefault [_rdType, []];
				if (_rdList isNotEqualTo []) exitWith {_rdList deleteAt (floor (random (count _rdList)))};
				if (!((_rdTypeIndex get _rdType) < _rdTypeLast)) exitWith {[]};
				_rdType = CRA_LCRB_TYPES#((_rdTypeIndex get _rdType) + 1);
			};
			if (_rdData isEqualTo []) exitWith {};
			if (true) then {
				_rdData params ["_rdObj", "_rdPos"];
				private _discard = false;
				{if (_discard) exitWith {}; private _dist = _x#0; {if (_rdPos distance2D _x < _dist) exitWith {_discard = true;};} forEach (_x#1);} forEach _proximity;
				if (_discard) exitWith {};
				private _path = [_rdObj, _rdPos] call _fnc_path;
				if (_path isEqualTo []) exitWith {};
				private _segments = [];
				for "_i" from 1 to (count _path - CRA_LCRB_SEGMENTS - 1) do {
					private _segment0 = _path#(_i - 1);
					private _segment1 = _path#_i;
					private _straight = true;
					private _angles = [];
					private _dirs = [];
					for "_n" from 1 to CRA_LCRB_SEGMENTS do {
						private _distance0 = _segment0 distance2D _segment1;
						private _dir0 = _segment0 getDir _segment1;
						_segment0 = _segment1;
						_segment1 = _path#(_i + _n);
						private _distance1 = _segment0 distance2D _segment1;
						private _dir1 = _segment0 getDir _segment1;
						private _angle = [_dir0, _dir1] call CRQ_Angle;
						if (_angle > CRA_LCRB_ANGLE) exitWith {_straight = false;};
						_angles pushBack [_angle, _distance0 + _distance1];
						_dirs pushBack [_dir0, _distance0];
						_dirs pushBack [_dir1, _distance1];
					};
					if (_straight) exitWith {_segments pushback [_angles call CRQ_AngleAvg, _i, _dirs call CRQ_AngleAvg];};
				};
				if (_segments isEqualTo []) exitWith {};
				_segments sort true;
				_return = [_path#((_segments#0#1) + floor (CRA_LCRB_SEGMENTS / 2)), _segments#0#2];
			};
		};
		_return
	};
	private _scanProx = [
		[CRA_LC_PROX_DEPOT, gRA_LC_List select [gRA_LC_IndexDepot, gRA_LC_IndexBase - gRA_LC_IndexDepot] apply {locationPosition _x}],
		[CRA_LC_PROX_LOCATION, gRA_LC_List select [gRA_LC_IndexBase] apply {locationPosition _x}],
		[CRA_LC_PROX_ROADBLOCK, []]
	];
	private _scanFull = (worldSize / gRA_PM_LC_RB_Density);
	private _scanHalf = _scanFull / 2;
	private _scanRadius = 1.42 * _scanFull;
	private _scanDensity = gRA_PM_LC_RB_Density + 1; // NOTE: additional + 1 due to random offset
	private _scanResults = [];
	private ["_scanRoads"];
	switch (gRA_PM_LC_RB_Mode) do {
		case 2: {
			CRA_LOAD_NEXT(0, 2 * _scanDensity * _scanDensity);
			_scanRoads = createHashMapFromArray (CRA_LCRB_TYPES apply {[_x, []]});
		};
		default {
			CRA_LOAD_NEXT(0, _scanDensity * _scanDensity);
		};
	};
	private _scanPos = [random _scanHalf, random _scanHalf];
	for "_iY" from 1 to _scanDensity do {
		for "_iX" from 1 to _scanDensity do {
			switch (gRA_PM_LC_RB_Mode) do {
				case 1: {_scanRoads = createHashMapFromArray (CRA_LCRB_TYPES apply {[_x, []]});};
				default {};
			};
			{
				private _target = _scanRoads get ((getRoadInfo _x)#0);
				if (!isNil "_target") then {
					private _rdPos = _x call CRQ_Pos2D;
					if (_rdPos inArea [_scanPos, _scanHalf, _scanHalf, 0, true]) then {_target pushBack [_x, _rdPos];};
				};
			} forEach (_scanPos nearRoads _scanRadius);
			switch (gRA_PM_LC_RB_Mode) do {
				case 1: {
					private _res = [_scanRoads, _scanProx, CRA_LCRB_SCANS] call _fnc_analysis;
					if (_res isNotEqualTo []) then {
						_scanResults pushBack _res;
						(_scanProx#2#1) pushBack (_res#0);
					};
				};
				default {};
			};
			_scanPos = _scanPos vectorAdd [_scanFull, 0];
			CRA_LOAD_INCREMENT();
		};
		_scanPos = (_scanPos vectorAdd [0, _scanFull]) vectorDiff [_scanDensity * _scanFull, 0];
	};
	switch (gRA_PM_LC_RB_Mode) do {
		case 2: {
			private _poolMax = ceil ((sqrt CRA_LCRB_SCANS) * gRA_PM_LC_RB_Density * gRA_PM_LC_RB_Density);
			private _poolRem = _poolMax;
			private _poolLoadOff = _scanDensity * _scanDensity;
			private _poolLoadFac = _scanDensity * _scanDensity / _poolMax;
			while {_poolRem > 0} do {
				private _res = [_scanRoads, _scanProx, _poolRem, {_poolRem = _poolRem - 1;}] call _fnc_analysis;
				if (_res isNotEqualTo []) then {
					_scanResults pushBack _res;
					(_scanProx#2#1) pushBack (_res#0);
				};
				CRA_LOAD_INDEX(_poolLoadOff + _poolLoadFac * (_poolMax - _poolRem));
			};
		};
		default {};
	};
	private _bases = [];
	{_bases append _x;} forEach (dCRA_LC_TYPES#CRA_LC_TYPE_ROADBLOCK#3#1);
	gRA_LC_IndexRoadblock = count gRA_LC_List;
	CRA_LOAD_NEXT(0, count _scanResults);
	{
		CRA_LOAD_INDEX(_forEachIndex);
		private _vec = [(_x#0) call CRQ_Pos2D, _x#1];
		private _index = gRA_LC_IndexRoadblock + _forEachIndex;
		private _name = str _forEachIndex;
		gRA_LC_List pushBack ([[_index, _vec, _name, "", objNull], CRA_LC_TYPE_ROADBLOCK, selectRandom _bases] call CRA_fnc_LC_Generate);
	} forEach _scanResults;
};
CRA_fnc_LC_InitOutpost = {
	private _bases = [];
	{_bases append _x;} forEach (dCRA_LC_TYPES#CRA_LC_TYPE_OUTPOST#3#1);
	
	private _outpostTypes = createHashMap;
	{private _bsIndex = _x; {_outpostTypes set [toLowerANSI _x, _bsIndex];} forEach (dCRA_BASE_INDEX#_bsIndex#0#0);} forEach _bases;
	private _count = 0;
	{_count = _count + count _x;} forEach gRA_MAP_House;
	CRA_LOAD_NEXT(0, _count);
	_count = 0;
	private _proximity = [
		[CRA_LC_PROX_DEPOT, (gRA_LC_List select [gRA_LC_IndexDepot, gRA_LC_IndexBase - gRA_LC_IndexDepot]) apply {locationPosition _x}],
		[CRA_LC_PROX_LOCATION, gRA_LC_List select [gRA_LC_IndexBase, gRA_LC_IndexRoadblock - gRA_LC_IndexBase] apply {locationPosition _x}],
		[CRA_LC_PROX_ROADBLOCK, gRA_LC_List select [gRA_LC_IndexRoadblock] apply {locationPosition _x}]
	];
	private _candidates = [];
	{
		{
			_count = _count + 1;
			CRA_LOAD_INDEX(_count);
			private _bsIndex = _outpostTypes getOrDefault [toLowerANSI (typeOf _x), -1];
			if (_bsIndex != -1) then {
				private _obj = _x;
				private _pos = _obj call CRQ_Pos3D;
				private _include = true;
				{if (!_include) exitWith {}; private _dist = _x#0; {if (_pos distance2D _x < _dist) exitWith {_include = false;};} forEach (_x#1);} forEach _proximity;
				if (_include) then {_candidates pushBack [_obj, [_pos, getDir _obj], _bsIndex];};
			};
		} forEach _x;
	} forEach gRA_MAP_House;
	
	if (_candidates isEqualTo []) exitWith {};
	CRA_LOAD_NEXT(0, count _candidates);
	_candidates = _candidates call CRQ_fnc_ArrayRandomize;
	private _probability = CRA_LCOP_COUNT / (count _candidates);
	private _proxDist = CRA_LC_PROX_OUTPOST;
	private _proxOutp = [];
	gRA_LC_IndexOutpost = count gRA_LC_List;
	private _index = 0;
	private _outposts = [];
	{
		CRA_LOAD_INDEX(_forEachIndex);
		if (random 1 < _probability) then {
			_x params ["_obj", "_vec", "_bsIndex"];
			private _pos = _vec#0;
			private _exclude = false;
			{if (_pos distance2D _x < _proxDist) exitWith {_exclude = true;};} forEach _proxOutp;
			if (_exclude) exitWith {};
			_proxOutp pushBack _pos;
			_outposts pushBack ([[gRA_LC_IndexOutpost + _index, _vec, str _index, "", _obj], CRA_LC_TYPE_OUTPOST, _bsIndex] call CRA_fnc_LC_Generate);
			_index = _index + 1;
		};
	} forEach _candidates;
	gRA_LC_List append _outposts;
};
CRA_fnc_LC_Loop = {
	{
		_x call {
			private _vec = _this getVariable [CRA_SVAR_VEC, []];
			if (_vec isEqualTo []) exitWith {};
			
			private _act = [_vec, gRA_PG_Activation, _this getVariable [CRA_SVAR_ACT_NOW, 0], CRA_ACTIVITY_MIN, CRA_ACTIVITY_MAX] call CRA_PlayerActivity;
			_this setVariable [CRA_SVAR_ACT_NOW, _act];
			
			private _fncMain = _this getVariable [CRA_SVAR_FNC_MAIN, CRA_LC_FNC_MAIN_NONE];
			private _state = _this getVariable [CRA_SVAR_LC_STATE, -1];
			if (_state == CRA_STATE_ACTIVE) exitWith {
				if (_act <= 0) exitWith {
					_this call (_fncMain#2);
					[_this, CRA_STATE_HIBERNATE] call CRA_LocationState;
				};
				_this call (_fncMain#1);
			};
			if (_act < 1) exitWith {};
			_this call (_fncMain#0);
			[_this, CRA_STATE_ACTIVE] call CRA_LocationState;
		};
		_x call CRA_LocationTrigger;
	} forEach gRA_LC_List;
};
CRA_LocationTrigger = {
	private _activity = _this getVariable [CRA_SVAR_ACT_NOW, 0];
	if (_activity <= 0) exitWith {};
	(_this getVariable [CRA_SVAR_FNC_TRIG, CRA_LC_FNC_TRIG_NONE]) params ["_trigger", "_cache"];
	{
		_x params ["_type", "_fnc_cond", "_fnc_trigger"];
		private _state = _cache#_forEachIndex;
		if (_type - _state != 0 && {[_this, _activity] call _fnc_cond}) then {
			_this call _fnc_trigger;
			if (_type > 0) then {_cache set [_forEachIndex, _state + 1]};
		};
	} forEach _trigger;
};
CRA_LocationDiscover = {
	params ["_location", "_silent"];
	if (_location getVariable [CRA_SVAR_LOCATION_DISCOVER, true]) exitWith {};
	_location setVariable [CRA_SVAR_LOCATION_DISCOVER, true];
	_location call CRA_LocationMarkerState;
	if (_silent) exitWith {};
	_location call CRA_PlayerLocationEnter;
};
CRA_LocationBaseEnter = { // TODO find a proper name!
	_this call CRA_LocationBaseSpawn;
	// _this call CRA_LocationBaseRadioNext;
	[_this, call CRQ_Lights] call CRA_LocationBaseLights;
	
	private _init = (_this getVariable [CRA_SVAR_LC_STATE, -1]) == CRA_STATE_INIT;
	
	private _timeDelta = [_this getVariable [CRA_SVAR_LOCATION_HIBERNATE_TIME, gCS_TM_Now], gCS_TM_Now] call CRQ_fnc_TimeDelta;
	private _rejuvenation = (_timeDelta / 60) * CRA_LC_REJUVENATION;
	private _damageUnit = (_this getVariable [CRA_SVAR_LOCATION_DAMAGE_PERSONNEL, 0]) - _rejuvenation;
	private _damageVehicle = (_this getVariable [CRA_SVAR_LOCATION_DAMAGE_VEHICLE, 0]) - _rejuvenation;
	
	private _hostile = (CRA_PLAYER_SIDE call CRQ_SideEnemy) find (_this call CRA_fnc_LC_Owner) != -1;
	if (_init || _hostile && {_damageUnit <= 0 && _damageVehicle <= 0}) then {
		if (_init || {random 1 < _rejuvenation}) then {
			[_this, ([CRQ_SD_OPF, CRQ_SD_IND] selectRandomWeighted [gRA_PG_EnemyArmy, 1 - gRA_PG_EnemyArmy])] call CRA_LocationOwnerInit; // TODO partial rejuvenation
			_this call CRA_LocationInventoryInit;
		};
		_this call CRA_LocationPersonnelSpawn;
	} else {
		_this call CRA_LocationThaw;
	};
	
	_this call CRA_LocationPersonnelOrders;
	
	_this call CRA_LocationInventoryLoad;
	_this call CRA_LocationActionCreate;
	_this call CRA_LocationFlagUpdate;
};
CRA_LocationBaseActive = {
	_this call CRA_LocationPersonnelLoop;
	_this call CRA_LocationCaptureLoop;
	// _this call CRA_LocationBaseRadioLoop;
};
CRA_LocationBaseLeave = { // TODO find a proper name!
	_this call CRA_LocationHibernate;
	_this call CRA_LocationPersonnelDespawn;
	_this call CRA_LocationActionRemove;
	_this call CRA_LocationInventorySave;
	_this call CRA_LocationBaseDespawn;
};
CRA_LocationDepotEnter = {
	_this call CRA_LocationBaseSpawn;
	if (_this getVariable [CRA_SVAR_LC_STATE, -1] != CRA_STATE_INIT) exitWith {};
	for "_i" from 0 to ((count (_this getVariable [CRA_SVAR_LC_SPAWN_ASSET, []])) - 1) do {[_this, _i] call CRA_DepotSpawn;};
};
CRA_LocationDepotActive = {
	{
		{
			_x params [["_removed", false], ["_timeDeath", -1], ["_timeAbandon", -1]];
			if (_removed) then {
				private _inhibit = gRA_PM_AS_RespawnAbandon == -1 || {_timeAbandon == -1 || {([_timeAbandon, gCS_TM_Now] call CRQ_fnc_TimeDelta) < gRA_PM_AS_RespawnAbandon}};
				_inhibit = _inhibit && {gRA_PM_AS_RespawnWreck == -1 || {_timeDeath == -1 || {([_timeDeath, gCS_TM_Now] call CRQ_fnc_TimeDelta) < gRA_PM_AS_RespawnWreck}}};
				if (_inhibit) exitWith {};
				[_this, _forEachIndex] call CRA_DepotSpawn;
			};
		} forEach ((_x call CRQ_fnc_LNK_Get)#1);
	} forEach (_this call CRQ_fnc_LNK_Get);
};
CRA_LocationDepotLeave = {
	_this call CRA_LocationBaseDespawn;
};
CRA_LocationState = {
	params ["_location", "_state"];
	_location setVariable [CRA_SVAR_LC_STATE, _state];
	if (_location getVariable [CRA_SVAR_LOCATION_DISCOVER, false]) then {_location call CRA_LocationMarkerState;};
};
CRA_LocationOwnerInit = {
	params ["_location", ["_side", CRQ_SD_UNKNOWN]];
	_location setVariable [CRA_SVAR_LC_OWNER, [[_side], [_side, CRA_GV_OW_MAX], (dCRA_SD_INDEX) apply {if (_x isEqualTo _side) then {CRA_GV_OW_MAX} else {CRA_GV_OW_MIN}}]];
};
CRA_LocationCaptureLoop = {
	
	private _allowed = _this getVariable [CRA_SVAR_LOCATION_CAPTUREABLE, [CRQ_SD_CIV]];
	
	(_this getVariable [CRA_SVAR_LC_OWNER, []]) params [["_ownerLog", [CRQ_SD_CIV]], ["_ownerFavor", [CRQ_SD_UNKNOWN, 0]], ["_owspRolling", [0,0,0,1]]];
	private _ownerPresent = _ownerLog select -1;
	if (_ownerPresent == CRQ_SD_CIV && {_allowed isEqualTo CRA_LC_CAPT_NONE}) exitWith {};
	
	
	private _pos = (_this getVariable [CRA_SVAR_VEC, [[]]])#0;
	if (_pos isEqualTo []) then {_pos = locationPosition _this;};
	private _radius = ((size _this)#0) + CRA_LC_CAPT_RANGE;
	
	private _fnc_unitInclude = {alive _this && {!(isPlayer _this) || {!(captive _this) && {gRA_PL_Dist#(_this call CRA_PlayerGetIndex)}}}};
	private _units = (_pos nearEntities [["Man"], _radius]) select {_x call _fnc_unitInclude};
	{{if (_x call _fnc_unitInclude) then {_units pushBack _x;};} forEach (crew _x);} forEach (_pos nearEntities [["Car", "Tank"], _radius]);
	
	private _unitCount = +dCRA_SD_COUNT;
	{(_x call CRQ_Side) call {if (_this isNotEqualTo CRQ_SD_UNKNOWN) exitWith {_unitCount set [_this, (_unitCount#_this) + 1];};};} forEach _units;
	private _unitTotal = 0;
	{_unitTotal = _unitTotal + _x;} forEach _unitCount;
	
	private _unitShare = if (_unitTotal > 0) then {_unitCount apply {_x / _unitTotal}} else {_unitCount apply {0}};
	private _vP = _unitShare apply {-(2^_x) + _x + _x^0.5 + 1}; // Presence; highest in favor for most numerous, but positively biased to lower counts
	private _vC = _owspRolling apply {(2^_x - _x^0.5 - _x)}; // Contestance; lowest for highest ownership, biased positively to low as well
	private _vSum = 0;
	{
		private _side = _forEachIndex;
		private _v0 = _x;
		private _vG = CRA_GV_OW_RATE_GROWTH * (_vP#_side) * (_vC#_side);
		private _vD = CRA_GV_OW_RATE_DECAY;
		{if (_x > 0) then {_vD = _vD * (gRA_SD_Matrix#_forEachIndex#_side);};} forEach _unitCount;
		private _v1 = CRA_GV_OW_MIN max (CRA_GV_OW_MAX min (_v0 - _vD + _vG));
		_owspRolling set [_side, _v1];
		_vSum = _vSum + _v1;
	} forEach _owspRolling;
	
	if (!(_vSum > 0)) exitWith {};
	private _owspRelative = _owspRolling apply {_x / _vSum};
	private _owspRanked = [];
	{
		if ((_x#0) > 0 && {(_x#1) isNotEqualTo CRQ_SD_CIV && {true}}) then {
			_owspRanked pushBack _x;
		};
	} forEach (dCRA_SD_INDEX apply {[_owspRelative#_x, _x]});
	_owspRanked sort false;
	
	private _ownerGain = if (_owspRanked isNotEqualTo []) then {
		private _vContSum = 0;
		{_vContSum = _vContSum + (_x#0);} forEach _owspRanked;
		private _owspContestant = +dCRA_SD_COUNT;
		{_owspContestant set [_x#1, (_x#0) / _vContSum];} forEach _owspRanked;
		private _owDominant = _owspRanked#0#1;
		private _owRepresant = if (_allowed find (_owDominant) != -1) then {_owDominant} else {CRQ_SD_CIV};
		if (_owDominant isNotEqualTo CRQ_SD_UNKNOWN) exitWith {
			private _flagUpdate = false;
			if ((_ownerFavor#0) isNotEqualTo _owDominant) then {_ownerFavor set [0, _owRepresant];};
			private _owspDefendant = +_owspContestant;
			private _vContest = _owspDefendant deleteAt _owDominant;
			private _vDominant = if (_owspDefendant isNotEqualTo []) then {(_vContest - (selectMax _owspDefendant))^(1 / (count _owspDefendant + 1))} else {1};
			if ((_ownerFavor#1) isNotEqualTo _vDominant) then {
				_flagUpdate = true;
				_ownerFavor set [1, _vDominant];
			};
			
			if (_ownerPresent isNotEqualTo _owDominant && {!((_owspContestant#_owDominant) < CRA_GV_OW_MAX)}) exitWith {
				_flagUpdate = true;
				_owRepresant
			};
			if (_flagUpdate) then {_this call CRA_LocationFlagUpdate;};
			CRQ_SD_UNKNOWN
		};
		CRQ_SD_UNKNOWN
	} else {
		CRQ_SD_UNKNOWN
	};
	private _ownerLoss = if (!((_owspRelative#_ownerPresent) > CRA_GV_OW_MIN) && {_allowed find CRQ_SD_CIV != -1}) then {
		CRQ_SD_CIV
	} else {
		CRQ_SD_UNKNOWN
	};
	if ([_ownerLoss, _ownerGain] isNotEqualTo [CRQ_SD_UNKNOWN, CRQ_SD_UNKNOWN]) then {
		private _ownerNew = if (_ownerGain isNotEqualTo CRQ_SD_UNKNOWN) then {_ownerGain} else {_ownerLoss};
		_ownerLog pushBack _ownerNew;
		_this call CRA_LocationCapture;
	};
	_this setVariable [CRA_SVAR_LC_OWNER, [_ownerLog, _ownerFavor, _owspRolling]];
};
CRA_LocationCapture = {
	_this call CRA_LocationMarkerState;
	_this call CRA_LocationFlagUpdate;
	_this call CRA_LocationPersonnelClear;
	_this call CRA_LocationPersonnelDespawn;
	_this call CRA_PlayerLocationCapture;
};
CRA_LocationHibernate = {
	private _hibUnits = [];
	private _hibVehicles = [];
	private _hibGroups = [];
	private _groups = _this getVariable [CRA_SVAR_LOCATION_GROUP_PERSONNEL, []];
	private _units = _this getVariable [CRA_SVAR_LOCATION_UNIT_PERSONNEL, []];
	private _vehicles = _this getVariable [CRA_SVAR_LOCATION_UNIT_VEHICLE, []];
	private _countUnit = _this getVariable [CRA_SVAR_LOCATION_COUNT_PERSONNEL, -1];
	private _countVehicle = _this getVariable [CRA_SVAR_LOCATION_COUNT_VEHICLE, -1];
	private _unitDamage = 0;
	private _vehicleDamage = 0;
	{
		if (isNull _x) then {
			_unitDamage = _unitDamage + 1;
			_hibUnits pushBack [];
		} else {
			private _vehicle = objectParent _x;
			private _turret = if (_vehicle isNotEqualTo objNull) then {[_vehicles find _vehicle, _vehicle unitTurret _x]} else {[]};
			private _group = (_groups find (group _x));
			private _hibernated = [_x call CRQ_UnitHibernate, _x call CRQ_CatalogIdentityRetrieve];
			_unitDamage = _unitDamage + damage _x;
			_hibUnits pushBack [_group, _turret, _hibernated#0, _hibernated#1];
		};
	} forEach _units;
	{
		if (isNull _x) then {
			_vehicleDamage = _vehicleDamage + 1;
			_hibVehicles pushBack [];
		} else {
			private _hibernated = _x call CRQ_VehicleHibernate;
			_vehicleDamage = _vehicleDamage + damage _x;
			_hibVehicles pushBack _hibernated;
		};
	} forEach _vehicles;
	{if (isNull _x) then {_hibGroups pushBack -1;} else {_hibGroups pushBack _forEachIndex;};} forEach _groups;
	_this setVariable [CRA_SVAR_LOCATION_HIBERNATE_GROUPS, _hibGroups];
	_this setVariable [CRA_SVAR_LOCATION_HIBERNATE_VEHICLES, _hibVehicles];
	_this setVariable [CRA_SVAR_LOCATION_HIBERNATE_UNITS, _hibUnits];
	_this setVariable [CRA_SVAR_LOCATION_HIBERNATE_TIME, gCS_TM_Now];
	_this setVariable [CRA_SVAR_LOCATION_DAMAGE_PERSONNEL, if (_countUnit > 0) then {_unitDamage / _countUnit} else {0}];
	_this setVariable [CRA_SVAR_LOCATION_DAMAGE_VEHICLE, if (_countVehicle > 0) then {_vehicleDamage / _countVehicle} else {0}];
};
CRA_LocationThaw = {
	private _groups = [];
	private _vehicles = [];
	private _units = [];
	private _identities = [];
	private _owner = _this call CRA_fnc_LC_Owner;
	{if (_x != -1) then {_groups pushBack (_owner call CRA_fnc_GP_Create);} else {_groups pushBack grpNull;};} forEach (_this getVariable [CRA_SVAR_LOCATION_HIBERNATE_GROUPS, []]);
	{if (_x isNotEqualTo []) then {_vehicles pushBack (_x call CRQ_VehicleThaw);} else {_vehicles pushBack objNull;};} forEach (_this getVariable [CRA_SVAR_LOCATION_HIBERNATE_VEHICLES, []]);
	{
		if (_x isEqualTo []) then {
			_units pushBack objNull;
		} else {
			_x params ["_groupIndex", "_vehicleIndex", "_data", "_identity"];
			private _unit = ([_groups#_groupIndex] + _data) call CRQ_UnitCreate;
			_units pushBack _unit;
			_identities pushBack [_unit, _identity];
			if (_vehicleIndex isNotEqualTo []) then {[CRQ_CREW_TURRET, _unit, _vehicles#(_vehicleIndex#0), _vehicleIndex#1] call CRQ_UnitVehicleAssign;};
		};
	} forEach (_this getVariable [CRA_SVAR_LOCATION_HIBERNATE_UNITS, []]);
	{_x call CRQ_CatalogIdentityApply;} forEach _identities;
	_this setVariable [CRA_SVAR_LOCATION_GROUP_PERSONNEL, _groups];
	_this setVariable [CRA_SVAR_LOCATION_UNIT_VEHICLE, _vehicles];
	_this setVariable [CRA_SVAR_LOCATION_UNIT_PERSONNEL, _units];
	_this setVariable [CRA_SVAR_LOCATION_HIBERNATE_GROUPS, []];
	_this setVariable [CRA_SVAR_LOCATION_HIBERNATE_VEHICLES, []];
	_this setVariable [CRA_SVAR_LOCATION_HIBERNATE_UNITS, []];
};
CRA_fnc_LC_InitMain = {
	private _fnc_sync = {
		CRA_LOAD_NEXT(0, 0);
		private _sync = gRA_LC_List apply {private _vec = _x getVariable [CRA_SVAR_VEC, [[0,0,0],0]]; [text _x, [_vec#0#0, _vec#0#1]]};
		missionNamespace setVariable ["pRA_Locations", _sync, true];
	};
	[] call CRA_fnc_LC_InitDepot;
	[] call CRA_fnc_LC_InitBase;
	[] call CRA_fnc_LC_InitRoadBlock;
	[] call CRA_fnc_LC_InitOutpost;
	[] call _fnc_sync;
};
// CRA_LocationBaseRadioLoop = {
	// if (([_this getVariable [CRA_SVAR_LOCATION_RADIO_START, gCS_TM_Now], gCS_TM_Now] call CRQ_fnc_TimeDelta) > (_this getVariable [CRA_SVAR_LOCATION_RADIO_LENGTH, 1])) then {_this call CRA_LocationBaseRadioNext;};
// };
// CRA_LocationBaseRadioNext = {
	// private _radio = _this getVariable [CRA_SVAR_LOCATION_UNIT_INST_RADIO, objNull];
	// if (_radio isEqualTo objNull) exitWith {};
	// private _index = _this getVariable [CRA_SVAR_LOCATION_RADIO_TRACK, -1];
	// _index = (_index + 1) % (count CRA_BASE_RADIO_TRACKS);
	// private _track = (CRA_BASE_RADIO_TRACKS#_index);
	// // binding sound to object does not cause sound to be stopped when object deleted
	// playSound3D [getMissionPath (_track#0), objNull, false, getPosASL _radio, _track#2,_track#3, CRA_BASE_RADIO_RANGE];
	// _this setVariable [CRA_SVAR_LOCATION_RADIO_TRACK, _index];
	// _this setVariable [CRA_SVAR_LOCATION_RADIO_START, gCS_TM_Now];
	// _this setVariable [CRA_SVAR_LOCATION_RADIO_LENGTH, (_track#1) + CRA_BASE_RADIO_GRACE];
// };
CRA_LocationBaseLights = {
	params ["_location", "_state"];
	private _objFire = (_location getVariable [CRA_SVAR_LOCATION_UNIT_INST, dCRA_BS_INST_NULL])#CRA_BS_INST_T_FIRE;
	if (_objFire isNotEqualTo objNull) then {_objFire inflame _state;};
};
CRA_LocationBaseSpawn = {
	{_x hideObjectGlobal true;} forEach (_this getVariable [CRA_SVAR_LOCATION_CLUTTER, []]);
	{_this setVariable [_x#1, [_this getVariable [_x#0, []], true, true] call CRQ_PropSpawn];} forEach [[CRA_SVAR_LOCATION_BASE_PROP,CRA_SVAR_LOCATION_UNIT_PROP]];
	{_this setVariable [_x#1, [_this getVariable [_x#0, []], false, false] call CRQ_PropSpawn];} forEach [[CRA_SVAR_LOCATION_BASE_INST,CRA_SVAR_LOCATION_UNIT_INST]];
	// private _installations = _this getVariable [CRA_SVAR_LOCATION_UNIT_INST, CRA_BASE_INST_EMPTY];
	// _this setVariable [CRA_SVAR_LOCATION_UNIT_INST_MAP, _installations#0];
	// _this setVariable [CRA_SVAR_LOCATION_UNIT_INST_BOX, _installations#1];
	// _this setVariable [CRA_SVAR_LOCATION_UNIT_INST_BOX_AUX, _installations#2];
	// _this setVariable [CRA_SVAR_LOCATION_UNIT_INST_RADIO, _installations#3];
	// _this setVariable [CRA_SVAR_LOCATION_UNIT_INST_FIRE, _installations#4];
	// _this setVariable [CRA_SVAR_LOCATION_UNIT_INST_GATE, _installations#5];
	// _this setVariable [CRA_SVAR_LOCATION_UNIT_INST_FLAG, _installations#6];
	_this call CRA_fnc_LC_INV_Spawn;
};
CRA_fnc_LC_INV_Spawn = {
	private _objBox = (_this getVariable [CRA_SVAR_LOCATION_UNIT_INST, dCRA_BS_INST_NULL])#CRA_BS_INST_T_BOX;
	_objBox lockInventory false;
	_objBox setMaxLoad CRA_LC_INV_SIZE;
};
CRA_LocationBaseDespawn = {
	// _this setVariable [CRA_SVAR_LOCATION_UNIT_INST_MAP, objNull];
	// _this setVariable [CRA_SVAR_LOCATION_UNIT_INST_BOX, objNull];
	// _this setVariable [CRA_SVAR_LOCATION_UNIT_INST_BOX_AUX, objNull];
	// _this setVariable [CRA_SVAR_LOCATION_UNIT_INST_RADIO, objNull];
	// _this setVariable [CRA_SVAR_LOCATION_UNIT_INST_FIRE, objNull];
	// _this setVariable [CRA_SVAR_LOCATION_UNIT_INST_GATE, objNull];
	// _this setVariable [CRA_SVAR_LOCATION_UNIT_INST_FLAG, objNull];
	{(_this getVariable [_x, []]) call CRQ_PropDespawn; _this setVariable [_x, []];} forEach [CRA_SVAR_LOCATION_UNIT_INST,CRA_SVAR_LOCATION_UNIT_PROP];
	{_x hideObjectGlobal false;} forEach (_this getVariable [CRA_SVAR_LOCATION_CLUTTER, []]);
};
CRA_LocationActionCreate = {
	private _lcIndex = _this getVariable [CRA_SVAR_LC_INDEX, -1];
	if (_lcIndex == -1) exitWith {};
	private _objInst = _this getVariable [CRA_SVAR_LOCATION_UNIT_INST, dCRA_BS_INST_NULL];
	[
		[_objInst#CRA_BS_INST_T_MAP, [
			["Teleport", [CRA_ACTION_ID_PLAYER_TELEPORT]],
			["Paradrop", [CRA_ACTION_ID_PLAYER_PARADROP]],
			["Gather Intel", [CRA_ACTION_ID_INTEL_GATHER, _lcIndex]]
		]],
		[_objInst#CRA_BS_INST_T_BOX, [
			["Unload, Repack, Sort", [CRA_ACTION_ID_INVENTORY_SORT, _lcIndex]],
			[format ["Gather Items (%1m)", CRA_LC_INV_GATHER], [CRA_ACTION_ID_INVENTORY_GATHER, _lcIndex, CRA_LC_INV_GATHER]]
		]]
	] call {{if ((_x#0) isNotEqualTo objNull) then {private _obj = [_x#0]; {(_obj + _x) call CRA_ActionRelayAdd;} forEach (_x#1);};} forEach _this;};
	// [_objMap, "Teleport", [CRA_ACTION_ID_PLAYER_TELEPORT]] call CRA_ActionRelayAdd;
	// [_objMap, "Paradrop", [CRA_ACTION_ID_PLAYER_PARADROP]] call CRA_ActionRelayAdd;
	// [_objMap, "Gather Intel", [CRA_ACTION_ID_INTEL_GATHER, _lcIndex]] call CRA_ActionRelayAdd;
	// [_objBox, "Unload, Repack, Sort", [CRA_ACTION_ID_INVENTORY_SORT, _lcIndex]] call CRA_ActionRelayAdd;
	// [_objBox, format ["Gather Items (%1m)", CRA_LC_INV_GATHER], [CRA_ACTION_ID_INVENTORY_GATHER, _lcIndex, CRA_LC_INV_GATHER]] call CRA_ActionRelayAdd;
};
CRA_LocationActionRemove = {
	private _objInst = _this getVariable [CRA_SVAR_LOCATION_UNIT_INST, dCRA_BS_INST_NULL];
	{if (_x isNotEqualTo objNull) then {_x call CRQ_fnc_AC_RemoveAll;};} forEach [_objInst#CRA_BS_INST_T_MAP, _objInst#CRA_BS_INST_T_BOX];
};
CRA_LocationIntelGather = {
	private _range = CRA_LC_INTEL_RANGE * (_this getVariable [CRA_SVAR_LC_VALUE, 0]);
	if (_range <= 0) exitWith {[]};
	private _vec = _this getVariable [CRA_SVAR_VEC, []];
	if (_vec isEqualTo []) exitWith {[]};
	private _pos = _vec#0;
	private _intel = createHashMap;
	{
		private _lcVec = _x getVariable [CRA_SVAR_VEC, []];
		if (_lcVec isNotEqualTo [] && {_pos distance2D (_lcVec#0) <= _range && {_x isNotEqualTo _this}}) then {
			private _type = _x getVariable [CRA_SVAR_LOCATION_TYPE, -1];
			if (_type != -1) then {
				private _label = dCRA_LC_TYPES#_type#0#1;
				private _count = _intel getOrDefault [_label, 0];
				_count = _count + 1;
				_intel set [_label, _count, false];
			};
			[_x, true] call CRA_LocationDiscover;
		};
	} forEach gRA_LC_List;
	[_range, _intel]
};
CRA_LocationFlagUpdate = {
	(if (_this isEqualType locationNull) then {[_this]} else {_this}) params [["_location", locationNull]];//, ["_texture", ""], ["_level", 1]];
	private _objFlag = (_location getVariable [CRA_SVAR_LOCATION_UNIT_INST, dCRA_BS_INST_NULL])#CRA_BS_INST_T_FLAG;
	if (_objFlag isEqualTo objNull) exitWith {};
	([_location, -1] call CRA_fnc_LC_Owner) params [["_favO", CRQ_SD_UNKNOWN], ["_favV", 0]];
	if (_favO isEqualTo CRQ_SD_UNKNOWN) exitWith {};
	
	_objFlag setFlagTexture (CQM_TX_SD_FLAGS#_favO);
	
	private _flagAnim = ("true" configClasses (configFile >> "CfgVehicles" >> (typeOf _objFlag) >> "AnimationSources")) apply {configName _x};
	if (_flagAnim isNotEqualTo []) exitWith {_objFlag animateSource [_flagAnim#0, _favV, true];};
	[_objFlag, _favV] remoteExec ["setFlagAnimationPhase", gCS_MP_All];
};
CRA_LocationInventoryInit = {
	private _objBox = (_this getVariable [CRA_SVAR_LOCATION_UNIT_INST, dCRA_BS_INST_NULL])#CRA_BS_INST_T_BOX;
	if (_objBox isEqualTo objNull) exitWith {};
	_this setVariable [CRA_SVAR_LOCATION_INVENTORY, [[[CRA_ITEM_WP_ALL], (-0.03125 + random 0.125) call CRA_fnc_IT_Quality] call CRA_fnc_IT_Random, false, false] call CRA_fnc_IT_WeaponRasterize];
};
CRA_LocationInventorySave = {
	private _objBox = (_this getVariable [CRA_SVAR_LOCATION_UNIT_INST, dCRA_BS_INST_NULL])#CRA_BS_INST_T_BOX;
	if (_objBox isEqualTo objNull) exitWith {};
	_this setVariable [CRA_SVAR_LOCATION_INVENTORY, _objBox call CRQ_InventoryBox];
};
CRA_LocationInventoryLoad = {
	private _objBox = (_this getVariable [CRA_SVAR_LOCATION_UNIT_INST, dCRA_BS_INST_NULL])#CRA_BS_INST_T_BOX;
	if (_objBox isEqualTo objNull) exitWith {};
	_objBox call CRQ_InventoryBoxClear;
	[_objBox, _this getVariable [CRA_SVAR_LOCATION_INVENTORY, [[[],[],[]],[]]]] call CRQ_InventoryBoxAppend;
};
CRA_LocationInventorySort = {
	private _objBox = (_this getVariable [CRA_SVAR_LOCATION_UNIT_INST, dCRA_BS_INST_NULL])#CRA_BS_INST_T_BOX;
	if (_objBox isEqualTo objNull) exitWith {};
	_objBox call CRQ_InventoryBoxOrganize;
};
CRA_LocationInventoryGather = {
	params ["_location", "_range"];
	private _vec = _location getVariable [CRA_SVAR_VEC, []];
	private _objBox = (_location getVariable [CRA_SVAR_LOCATION_UNIT_INST, dCRA_BS_INST_NULL])#CRA_BS_INST_T_BOX;
	if (_objBox isEqualTo objNull || {_vec isEqualTo []}) exitWith {[0,0,0,0]};
	private _inventory = [[[],[],[]],[]];
	private _corpses = [];
	private _boxes = [];
	{
		(typeOf _x) call {
			if (_this isEqualTo "Man") exitWith {_corpses pushBack _x;};
			if (_this isEqualTo "WeaponHolderSimulated") exitWith {_boxes pushBack _x;};
			if (_this isEqualTo "GroundWeaponHolder") exitWith {_boxes pushBack _x;};
			// must be vehicle then
			private _crew = crew _x;
			if (_crew findIf {alive _x} == -1) then {_corpses append _crew;}; // TODO this will unintentionally also exclude if any player is in vehicle too
			// private _include = true;
			// {if (alive _x) exitWith {_include = false;};} forEach _crew;
		};
	} forEach (nearestObjects [(_vec#0), dRA_InventoryGatherSources, _range]);
	{
		[_inventory, [_x, true, false] call CRQ_InventoryUnit] call CRQ_InventoryAppend;
		[_x, _x call CRQ_LoadoutBlank] call CRQ_LoadoutApply;
		_x call CRQ_fnc_CorpseExpedite;
	} forEach _corpses;
	{
		[_inventory, _x call CRQ_InventoryBox] call CRQ_InventoryAppend;
		deleteVehicle _x;
	} forEach _boxes;
	[_objBox, _inventory] call CRQ_InventoryBoxAppend;
	[count (_inventory#0#0), count (_inventory#0#1), count (_inventory#0#2), count (_inventory#1)]
};
CRA_LocationMarkerState = {
	((_this getVariable [CRA_SVAR_LC_MARKER, [[], []]]) + [_this getVariable [CRA_SVAR_LC_STATE, -1], _this call CRA_fnc_LC_Owner]) params ["_marker", "_type", "_state", "_owner"];
	if (_marker isEqualTo [] || {(_marker#0) isEqualTo "" || {_type isEqualTo [] || {_state isEqualTo -1}}}) exitWith {};
	_marker = _marker#0;
	_marker setMarkerAlphaLocal (CRA_MARKER_ALPHA#_state);
	_marker setMarkerType (if (_owner isEqualTo CRQ_SD_UNKNOWN) then {CRA_MARKER_UNKNOWN} else {_type#_owner});
};
CRA_DepotSpawn = {
	params ["_location", "_index"];
	private _owner = _location call CRA_fnc_LC_Owner;
	if (_owner isEqualTo CRQ_SD_UNKNOWN) exitWith {};
	
	private _spawn = _location getVariable [CRA_SVAR_LC_SPAWN_ASSET, []];
	if (!(_index < count _spawn)) exitWith {};
	_spawn = _spawn#_index;
	if ((_spawn#0#_owner) isEqualTo []) then {_owner = 3;};
	if ((_spawn#0#_owner) isEqualTo []) exitWith {};
	(selectRandom (_spawn#0#_owner)) params ["_vhIndex", "_spIndex"];
	(_spawn#1#(selectRandom _spIndex)) params ["_spPos", "_spDir"];
	
	(pCQ_CT_Item#_vhIndex#4) params ["_vhRadius"];
	
	[_spPos, _vhRadius, [_spPos, _vhRadius] call CRQ_WrecksFind] call CRQ_ClearArea;
	
	private _asset = [_vhIndex, [_spPos, selectRandom _spDir]] call CRA_fnc_AS_Create;
	
	[_asset] call CRA_fnc_AS_Register;
	_asset setVariable [CRA_SVAR_ACT_NOW, _location getVariable [CRA_SVAR_ACT_NOW, 0]];
	
	private _linkID = name _location;
	(_linkID call CRQ_fnc_LNK_Get) params ["_linkObj", "_linkData"];
	_linkData set [_index, [false, -1, -1]];
	[(_linkObj#_index), _linkID] call CRQ_fnc_LNK_Free;
	[_linkID, _index, _asset] call CRQ_fnc_LNK_Free;
	[_asset, _linkID, _index] call CRQ_fnc_LNK_Add;
};

CRA_DepotAnalysis = {
	params ["_depot", "_dpSource"];
	private _dpType = _dpSource#2;
	private _dpRadius = _dpSource#3#0;
	//private _dpSize = _dpSource#3#1; // TODO objectScale?
	private _dpSpawn = _dpSource#4;
	
	private _dpSkipOcclusion = if (_depot isEqualType objNull) then {
		[_depot call CRQ_Vec2D, _dpRadius] call CRQ_VecUtilSetup; // TODO sure this is Pos2D?
		false
	} else {
		[_depot, _dpRadius] call CRQ_VecUtilSetup;
		true
	};
	
	private _dpVehicles = [[[],[],[],[]],[]];
	
	{
		_x params ["_spMode", "_spType", "_spBounds", "_spDirs"];
		(_spMode call CRQ_VecUtil) params ["_spPos", "_spDir"];
		private _vhDir = _spDirs apply {_x + _spDir};
		private _vhMaxR = -1;
		//private _vhMaxX = -1;
		//private _vhMaxY = -1;
		private _vhMaxZ = -1;
		switch (_spType) do {
			case CRA_DEPOT_POS_INSIDE: {
				private _spVehicles = [[],[],[],[]];
				
				private _vhPos = _spPos;
				private _clutter = ((nearestTerrainObjects [_vhPos, CRA_DEPOT_OBSTRUCTORS, _dpRadius, true, true]) - [_depot]) apply {[_x call CRQ_Pos2D, (_x call CRQ_ObjectSize)#0]};
				_spBounds params ["_spX", "_spY", "_spZ"];
				{
					_x params ["_vhIndex", "_vhRadius", "_vhSize"];
					_vhSize params ["", "", "_vhZ"];
					
					private _unobstructed = true;
					
					//if (_vhMaxX < _vhX || {_vhMaxY < _vhY || {_vhMaxZ < _vhZ}}) then {
					if (_vhMaxR < _vhRadius || {_vhMaxZ < _vhZ}) then {
						if (_vhRadius > _spX || {_vhRadius > _spY || {_vhZ > _spZ}}) exitWith {_unobstructed = false;};
						if (_dpSkipOcclusion) exitWith {};
						{if ((_vhPos distance2D (_x#0)) < _vhRadius + (_x#1)) exitWith {_unobstructed = false;};} forEach _clutter;
					};
					
					if (_unobstructed) then {
						{(_spVehicles#_forEachIndex) append _x;} forEach _vhIndex;
						_vhMaxR = _vhMaxR max _vhRadius;
						_vhMaxZ = _vhMaxZ max _vhZ;
					};
				} forEach (gRA_AS_Dimensions#_dpType);
				
				if (_spVehicles isEqualTo [[],[],[],[]]) exitWith {};
				private _spIndex = count (_dpVehicles#1);
				(_dpVehicles#1) pushBack [_vhPos, _vhDir];
				{
					private _vhSide = _dpVehicles#0#_forEachIndex;
					{
						private _veh = _x;
						private _existing = _vhSide findIf {_veh == _x#0};
						if (_existing != -1) then {(_vhSide#_existing#1) pushBack _spIndex;} else {_vhSide pushBack [_x, [_spIndex]];};
					} forEach _x;
				} forEach _spVehicles;
			};
			case CRA_DEPOT_POS_BOAT: {
				_spBounds params ["_spVecDist", "_spVecDir"];
				_spDir = _spDir + _spVecDir;
				private _clutter = (nearestTerrainObjects [_spPos, CRA_DEPOT_PIER_OBSTRUCTORS, CRA_DEPOT_PIER_SCAN_RANGE, true, true]) - [_depot];
				private _vhPos = [];
				{
					_x params ["_vhIndex", "_vhRadius", "_vhSize", "_vhCenter"];
					_vhSize params ["", "", "_vhZ"];
					
					private _unobstructed = true;
					
					_vhPos = _spPos getPos [_spVecDist + _vhRadius * CRA_DEPOT_PIER_CLEARANCE, _spDir];
					if (_forEachIndex == 0 && {!_dpSkipOcclusion}) then {
						{if (_x isNotEqualTo _depot) then {_clutter pushBackUnique _x;}} forEach (nearestTerrainObjects [_vhPos, CRA_DEPOT_PIER_OBSTRUCTORS, CRA_DEPOT_PIER_SCAN_RANGE, true, true]);
						_clutter = _clutter apply {[_x call CRQ_Pos2D, (_x call CRQ_ObjectSize)#0]};
					};
					if (_vhMaxR < _vhRadius || {_vhMaxZ < _vhZ}) then {
						//if ((_vhPos#2) > (-(_vhCenter#2)) || {!surfaceIsWater _vhPos}) exitWith {_unobstructed = false;};
						if ((_vhPos#2) > -(_vhCenter#2)) exitWith {_unobstructed = false;};
						if (_vhMaxR > _vhRadius || {_dpSkipOcclusion}) exitWith {};
						{if ((_vhPos distance2D (_x#0)) < _vhRadius + (_x#1)) exitWith {_unobstructed = false;};} forEach _clutter;
					};
					_vhPos set [2, (_vhCenter#2) * CRA_DEPOT_PIER_ZADJ];
					
					if (_unobstructed) then {
						private _spIndex = count (_dpVehicles#1);
						(_dpVehicles#1) pushBack [_vhPos, _vhDir];
						
						{
							private _vhSide = _dpVehicles#0#_forEachIndex;
							{
								private _veh = _x;
								private _existing = _vhSide findIf {_veh == _x#0};
								if (_existing != -1) then {(_vhSide#_existing#1) pushBack _spIndex;} else {_vhSide pushBack [_x, [_spIndex]];};
							} forEach _x;
						} forEach _vhIndex;
				
						_vhMaxR = _vhMaxR max _vhRadius;
						_vhMaxZ = _vhMaxZ max _vhZ;
					};
				} forEach (gRA_AS_Dimensions#_dpType);
			};
			
			//case CRA_DEPOT_POS_OUTSIDE: { // TODO verify this
				//_vhPos = (_optionVec#0) getPos [(_spBounds#0) + _vhRadius, (_optionVec#1) + (_spBounds#1)];
				//_vhPos = _spPos getPos [(_spBounds#0) + _vhRadius, _spDir + (_spBounds#1)];
				//if (_depotOcclusion) then {{if ((_x != _depot) && ((_vhPos distance2D (_x call CRQ_Pos2D)) < _vhRadius)) exitWith {_unobstructed = false;};} forEach nearestTerrainObjects [_vhPos, CRA_DEPOT_OBSTRUCTORS, _vehicleRadius, true, false];};
			//};
			
			default {};
		};
	} forEach _dpSpawn;
	
	if (_dpVehicles isNotEqualTo [[[],[],[],[]],[]]) then {_dpVehicles} else {[]};
};
