
dCRA_DEPOT_TYPES = missionNamespace getVariable ["dCRA_DEPOT_TYPES", CRA_DEPOT_TYPES];
dCRA_ASSET_INVENTORY = missionNamespace getVariable ["dCRA_ASSET_INVENTORY", CRA_ASSET_INVENTORY];

gRA_SettingDepotRespawnWreck = ["CRA_VehicleRespawnWreck", 180] call BIS_fnc_getParamValue;
gRA_SettingDepotRespawnAbandon = ["CRA_VehicleRespawnAbandon", 0] call BIS_fnc_getParamValue;
gRA_SettingDepotAbandonMode = ["CRA_VehicleAbandonMode", 0] call BIS_fnc_getParamValue;
gRA_SettingDepotAbandonTime = ["CRA_VehicleAbandonTime", 180] call BIS_fnc_getParamValue;

gRA_AssetIndex = missionNamespace getVariable ["gRA_AssetIndex", []];
gRA_AssetDimensions = missionNamespace getVariable ["gRA_AssetDimensions", []];

gRA_DepotTypes = missionNamespace getVariable ["gRA_DepotTypes", []];
gRA_fnc_DepotAbandonMode = missionNamespace getVariable ["gRA_fnc_DepotAbandonMode", {true}];

gRA_Assets = [];

CRA_AssetInit = {
	for "_side" from 0 to ((count CRA_ASSET_SIDES) - 1) do {
		private _assetSide = [];
		for "_class" from 0 to ((count CRA_ASSET_CLASSES) - 1) do {
			_assetSide pushBack ((CRA_ASSET_TYPES#_class) apply {[]});
		};
		gRA_AssetIndex pushBack _assetSide;
	};
	private _assetsUnique = [];
	{
		private _side = _forEachIndex;
		private _catSide = _x;
		{
			private _class = _forEachIndex;
			private _catClass = _x;
			
			private _classTypes = (CRA_ASSET_TYPES#_class) apply {[_x, []]};
			{
				_x params ["_type", "_categories", ["_quality", []], ["_weight", []]];
				{
					private _index = (gCQ_CatalogItem#(_x#1)) call _type;
					if (_index != -1) then {(_classTypes#_index#1) pushBack _x; _assetsUnique pushBackUnique (_x#1);};
				} forEach ([([_catSide, _catClass] + _categories) call CRQ_CatalogListMatching, _quality, _weight] call CRQ_CatalogListQuality);
			} forEach (CRA_ASSET_TYPE_ASSETS#_class);
			
			{
				(_x#1) sort true;
				//(gRA_AssetIndex#_side#_class) set [_forEachIndex, [_x#0, _x#1] call CRQ_CatalogQualityMapGenerate];
				(gRA_AssetIndex#_side#_class) set [_forEachIndex, _x call CRQ_CatalogQualityMapGenerate];
			} forEach _classTypes;
			
		} forEach CRA_ASSET_CLASSES;
	} forEach CRA_ASSET_SIDES;
	{_x call CRA_AssetFinalize;} forEach _assetsUnique;
	gRA_fnc_DepotAbandonMode = [
		{false},
		{(_this#0) || (_this#1)},
		{(_this#0) && (_this#1)},
		{(_this#0)},
		{(_this#1)}
	]#gRA_SettingDepotAbandonMode;
};
CRA_AssetFinalize = {
	private _asset = (gCQ_CatalogItem#_this);
	_asset params ["_name", "_category", "_quality", "_data"];
	private _capabilities = [CRQ_CDAT_CAPABILITIES, _data] call CRQ_CatalogArrayData;
	private _load = [CRQ_CDAT_LOAD, _data] call CRQ_CatalogArrayData;
	_asset set [4, ([CRQ_CDAT_SIZE, _data] call CRQ_CatalogArrayData) + [[CRQ_CDAT_CENTER, _data] call CRQ_CatalogArrayData]];
	_asset set [5, _capabilities];
	_asset set [6, [CRQ_CDAT_SEATS, _data] call CRQ_CatalogArrayData];
	if (_load <= 0) exitWith {};
	private _factorLoad = (sqrt (_load)) / 20;
	private _caps = _capabilities call CRQ_fnc_ByteDecode;
	private _inventory = [[],[],[],[]];
	{
		_x params ["_index", "_item", "_mod", "_count", "_fnc_factor"];
		private _factor = [_factorLoad, _caps, _asset] call _fnc_factor;
		if (_factor > 0) then {(_inventory#_index) pushBack [_item, _mod, _count apply {_x * _factor}];};
	} forEach dCRA_ASSET_INVENTORY;
	_asset set [7, _inventory];
};
CRA_AssetList = {
	params ["_args", ["_bounds", [0,1]]];
	private _vehicles = [];
	while {true} do {
		{_vehicles append ([_bounds, gRA_AssetIndex#(_x#0)#(_x#1)#(_x#2)] call CRQ_CatalogQualityMapItem);} forEach _args;
		if (_vehicles isNotEqualTo [] || {(_bounds#0) <= 0}) exitWith {};
		_bounds set [0, 0 max ((_bounds#0) - 0.0625)];
	};
	_vehicles
};
CRA_AssetRandom = {
	private _assets = _this call CRA_AssetList;
	if (_assets isNotEqualTo []) then {selectRandom _assets} else {-1};
};
CRA_AssetDimensions = {
	private _dimensions = CRA_ASSET_CLASSES apply {[]};
	{
		private _side = _forEachIndex;
		{
			private _class = _forEachIndex;
			{
				{
					(gCQ_CatalogItem#_x#4) params ["_radius", "_size", "_center"];
					private _index = (_dimensions#_class) findIf {_size isEqualTo (_x#2)};
					if (_index == -1) then {
						_index = count (_dimensions#_class);
						(_dimensions#_class) pushBack [[[],[],[],[]], _radius, _size, _center];
					};
					(_dimensions#_class#_index#0#_side) pushBackUnique _x;
				} forEach (_x#0);
			} forEach _x;
		} forEach _x;
	} forEach gRA_AssetIndex;
	(_dimensions apply {[_x, [], {(_x#1)}, "DESCEND"] call BIS_fnc_sortBy})
};
CRA_AssetCreate = {
	params ["_index", "_vec", ["_crew", []]];
	(gCQ_CatalogItem#_index) params ["_vhName", "_vhCategory", "_vhQuality", "_vhData", "_vhDim", "_vhCaps", "_vhSeats", ["_vhInventory", []]];
	
	private _inventory = [[[],[],[]],[]];
	
	if (_vhInventory isNotEqualTo []) then {
		private _indexInventory = [[],[],[],[]];
		{
			private _index = _forEachIndex;
			{
				_x params ["_itemCategory", "_itemQuality", "_itemCount"];
				private _count = floor (random _itemCount);
				for "_i" from 1 to _count do {
					private _item = [_itemCategory, _itemQuality call CRA_ItemQuality] call CRA_ItemRandom;
					if (_item != -1) then {(_indexInventory#_index) pushBack _item;};
				};
			} forEach _x;
		} forEach _vhInventory;
		{(_inventory#0#0) pushBack (gCQ_CatalogItem#_x#0);} forEach (_indexInventory#0);
		{private _mag = gCQ_CatalogItem#_x; (_inventory#0#1) pushBack [_mag#0, _mag#4];} forEach (_indexInventory#1); // TODO test me!
		{(_inventory#1) pushBack [gCQ_CatalogItem#_x#0, [[],[],[],[]]];} forEach (_indexInventory#3);
		{[_inventory, [_x, false, false] call CRA_ItemWeaponRasterize] call CRQ_InventoryAppend;} forEach (_indexInventory#2);
	};
		
	private _vehicle = [_vhName, _vec, _inventory] call CRQ_VehicleCreate;
	
	if (_crew isNotEqualTo []) then {
		_crew params ["_group", "_slot"];
		private _side = (side _group) call CRQ_Side;
		if (_side == CRQ_SD_UNKNOWN) exitWith {};
		private _capabilities = _vhCaps call CRQ_fnc_ByteDecode;
		private _crewIndex = switch (true) do {case (_capabilities#3): {2}; case (_capabilities#2): {1}; case (_capabilities#0): {1}; default {0};};
		private _crewType = CRA_VEHICLE_CREW#_side#_crewIndex;
		private _crewCount = [];
		{
			private _capacity = _vhSeats#_forEachIndex;
			_crewCount pushBack (if (_x < 0) then {round (-_x * _capacity)} else {_capacity min (floor _x)});
		} forEach _slot;
		private _identities = [];
		private _vhDir = _vec#1;
		private _vhRadius = -(_vhDim#0);
		private _unitVec = [(_vec#0) vectorAdd [sin _vhDir * _vhRadius, cos _vhDir * _vhRadius, 0], _vhDir];
		private _relation = _group call CRA_SideRelation;
		{
			private _role = [CRQ_CREW_COMMANDER,CRQ_CREW_GUNNER,CRQ_CREW_DRIVER,CRQ_CREW_CARGO]#_forEachIndex;
			for "_i" from 1 to _x do {
				private _unitType = (selectRandom _crewType) call CRA_UnitGenerate;
				private _unit = [_group, _unitType#0, _unitVec, _unitType#1, [] call CRA_UnitSkill] call CRQ_UnitCreate;
				[_role, _unit, _vehicle] call CRQ_UnitVehicleAssign;
				_identities pushBack [_unit, _relation call CRQ_CatalogIdentityGenerate];
			};
		} forEach _crewCount;
		{_x call CRQ_CatalogIdentityApply;} forEach _identities;
	};
	_vehicle
};
CRA_AssetRegister = {
	params ["_asset", ["_touched", false], ["_abandon", true], ["_hibernate", true], ["_vecLast", []], ["_timeLast", gCS_TM_Now]];
	_asset setVariable [CRA_SVAR_VEC, if (_vecLast isNotEqualTo []) then {_vecLast} else {_asset call CRQ_Vec2D}];
	_asset setVariable [CRA_SVAR_VEHICLE_TIME_LAST, _timeLast];
	_asset setVariable [CRA_SVAR_VEHICLE_TOUCHED, _touched];
	_asset setVariable [CRA_SVAR_VEHICLE_ABANDON, _abandon];
	_asset setVariable [CRA_SVAR_VEHICLE_HIBERNATE, _hibernate];
	gRA_Assets pushBack _asset;
};
CRA_AssetAbandonEnable = {
	_this setVariable [CRA_SVAR_VEHICLE_ABANDON, true];
};
CRA_AssetAbandonDisable = {
	_this setVariable [CRA_SVAR_VEHICLE_ABANDON, false];
};
CRA_AssetHibernateEnable = {
	_this setVariable [CRA_SVAR_VEHICLE_HIBERNATE, true];
};
CRA_AssetHibernateDisable = {
	_this setVariable [CRA_SVAR_VEHICLE_HIBERNATE, false];
};
CRA_AssetLog = {
	if (_this isEqualType objNull) then {
		private _vec = _this call CRQ_Vec2D;
		
		private _actBase = (_this getVariable [CRA_SVAR_ACTIVITY_BASE, gRA_ProgressActivation]) call {if (_this < 0) then {-_this * gRA_ProgressActivation} else {_this}};
		private _activity = [_vec, _actBase, _this getVariable [CRA_SVAR_ACTIVITY, 0], CRA_ACTIVITY_MIN, CRA_ACTIVITY_MAX] call CRA_PlayerActivity;
		_this setVariable [CRA_SVAR_ACTIVITY, _activity];
		
		private _unused = true;
		{if (alive _x) exitWith {_this setVariable [CRA_SVAR_VEHICLE_TIME_LAST, gCS_TM_Now]; _unused = false;};} forEach (crew _this);
		if (_this getVariable [CRA_SVAR_VEHICLE_TOUCHED, false]) exitWith {_this setVariable [CRA_SVAR_VEC, _vec];};
		
		if (_unused && {(_this getVariable [CRA_SVAR_VEC, []]) call {_this isEqualTo [] || {[_this, _vec] call CRQ_VecDist2D < CRA_ASSET_MOVED_DIST}}}) exitWith {};
		_this setVariable [CRA_SVAR_VEC, _vec];
		_this setVariable [CRA_SVAR_VEHICLE_TOUCHED, true];
	} else {
		private _vec = [_this, CRA_SVAR_VEC, []] call CRQ_VarGet;
		if (_vec isEqualTo []) exitWith {};
		private _actBase = ([_this, CRA_SVAR_ACTIVITY_BASE, gRA_ProgressActivation] call CRQ_VarGet) call {if (_this < 0) then {-_this * gRA_ProgressActivation} else {_this}};
		private _activity = [_vec, _actBase, [_this, CRA_SVAR_ACTIVITY, 0] call CRQ_VarGet, CRA_ACTIVITY_MIN, CRA_ACTIVITY_MAX] call CRA_PlayerActivity;
		[_this, CRA_SVAR_ACTIVITY, _activity] call CRQ_VarSet;
	};
};
CRA_AssetAbandon = {
	(if (_this isEqualType objNull) then {
		[_this getVariable [CRA_SVAR_VEHICLE_TOUCHED, false], _this getVariable [CRA_SVAR_VEHICLE_TIME_LAST, -1], _this getVariable [CRA_SVAR_ACTIVITY, 0], _this getVariable [CRA_SVAR_VEHICLE_ABANDON, false]]
	} else {
		[[_this, CRA_SVAR_VEHICLE_TOUCHED, false] call CRQ_VarGet, [_this, CRA_SVAR_VEHICLE_TIME_LAST, -1] call CRQ_VarGet, [_this, CRA_SVAR_ACTIVITY, 0] call CRQ_VarGet, [_this, CRA_SVAR_VEHICLE_ABANDON, false] call CRQ_VarGet]
	}) params ["_touched", "_lastUsed", "_activity", "_abandon"];
	if (_abandon && {_touched}) exitWith {[_lastUsed != -1 && {([_lastUsed, gCS_TM_Now] call CRQ_fnc_TimeDelta) >= gRA_SettingDepotAbandonTime}, _activity <= 0] call gRA_fnc_DepotAbandonMode};
	false
};
CRA_AssetLoop = {
	private _fnc_wrecked = {
		{private _data = (_x call CRQ_fnc_LNK_Get)#1#_y; _data set [0, true]; _data set [1, gCS_TM_Now];} forEach ((_this#0) call CRQ_fnc_LNK_Get);
		//[(_this#1), [true, gCS_TM_Now, -1]] call CRQ_LinkDataBroadcast;
		
	};
	private _fnc_abandon = {
		{private _data = (_x call CRQ_fnc_LNK_Get)#1#_y; _data set [0, true]; _data set [2, gCS_TM_Now];} forEach ((_this#0) call CRQ_fnc_LNK_Get);
		//[(_this#1), [true, -1, gCS_TM_Now]] call CRQ_LinkDataBroadcast;
	};
	private _fnc_suspend = {
		{((_x call CRQ_fnc_LNK_Get)#0) set [_y, _this#1];} forEach ((_this#0) call CRQ_fnc_LNK_Get);
		//[_this#2, _this#3] call CRQ_LinkSource;
	};
	private _remove = [];
	{
		if (_x isEqualType objNull) then {
			if (_x isEqualTo objNull) exitWith {_remove pushBack _forEachIndex};
			if (alive _x) exitWith {
				_x call CRA_AssetLog;
				if (gRA_PlayerAsset find _x != -1) exitWith {};
				if (_x call CRA_AssetAbandon) exitWith {
					[_x, _x] call _fnc_abandon;
					_x call CRQ_VehicleDelete;
					_remove pushBack _forEachIndex;
				};
				if (_x getVariable [CRA_SVAR_VEHICLE_HIBERNATE, false]) exitWith {
					if (_x getVariable [CRA_SVAR_ACTIVITY, 0] <= 0) then {
						private _hibernated = _x call CRQ_VehicleHibernate;
						//[_x, _hibernated#1, _x, [_hibernated#1, objNull] call CRQ_LinkVars] call _fnc_suspend;
						[_x, _hibernated#1] call _fnc_suspend;
						gRA_Assets set [_forEachIndex, _hibernated];
						_x call CRQ_VehicleDelete;
					};
				};
			};
			[_x, _x] call _fnc_wrecked;
			_remove pushBack _forEachIndex;
		} else {
			_x params ["_data", "_vars"];
			_vars call CRA_AssetLog;
			//private _linked = [_vars, locationNull] call CRQ_LinkVars;
			if (_vars call CRA_AssetAbandon) exitWith {
				//[_vars, _linked] call _fnc_abandon;
				[_vars] call _fnc_abandon;
				_remove pushBack _forEachIndex;
			};
			if ([_vars, CRA_SVAR_ACTIVITY, 0] call CRQ_VarGet < 1) exitWith {};
			private _vehicle = _x call CRQ_VehicleThaw;
			//[_vars, _vehicle, _linked, _vehicle] call _fnc_suspend;
			[_vars, _vehicle] call _fnc_suspend;
			gRA_Assets set [_forEachIndex, _vehicle];
		};
	} forEach gRA_Assets;
	reverse _remove;
	{gRA_Assets deleteAt _x;} forEach _remove;
};
CRA_DepotSpawn = {
	params ["_location", "_index"];
	private _owner = _location call CRA_fnc_LC_Owner;
	if (_owner isEqualTo CRQ_SD_UNKNOWN) exitWith {};
	
	private _spawn = _location getVariable [CRA_SVAR_LOCATION_ASSET_SPAWN, []];
	if (!(_index < count _spawn)) exitWith {};
	_spawn = _spawn#_index;
	if ((_spawn#0#_owner) isEqualTo []) then {_owner = 3;};
	if ((_spawn#0#_owner) isEqualTo []) exitWith {};
	(selectRandom (_spawn#0#_owner)) params ["_vhIndex", "_spIndex"];
	(_spawn#1#(selectRandom _spIndex)) params ["_spPos", "_spDir"];
	
	(gCQ_CatalogItem#_vhIndex#4) params ["_vhRadius"];
	
	[_spPos, _vhRadius, [_spPos, _vhRadius] call CRQ_WrecksFind] call CRQ_ClearArea;
	
	private _asset = [_vhIndex, [_spPos, selectRandom _spDir]] call CRA_AssetCreate;
	
	[_asset] call CRA_AssetRegister;
	_asset setVariable [CRA_SVAR_ACTIVITY, _location getVariable [CRA_SVAR_ACTIVITY, 0]];
	
	//[_location, _index, locationNull] call CRQ_LinkFree;
	//[[_location, _index, [false, -1,-1]], [_asset]] call CRQ_LinkCreate;
	
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
				} forEach (gRA_AssetDimensions#_dpType);
				
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
				} forEach (gRA_AssetDimensions#_dpType);
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

CRA_DepotBounds = {
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
CRA_DepotInit = {
	gRA_AssetDimensions = [] call CRA_AssetDimensions;
	gRA_DepotTypes = dCRA_DEPOT_TYPES apply {_x call CRA_DepotBounds};
	gRA_DepotModels = createHashMap;
	{gRA_DepotModels set [_x#1, _forEachIndex];} forEach gRA_DepotTypes;
	
	CRA_LOAD_NEXT(0, count dRA_WorldHouses);
	private _candidates = [];
	{
		CRA_LOAD_INDEX(_forEachIndex);
		private _model = gRA_DepotModels getOrDefault [toLowerANSI (_x call CRQ_ObjectModel), -1];
		if (_model != -1 && {((vectorUp _x)#2) / (getObjectScale _x) >= CRA_DEPOT_VECTORUP_MIN}) then {_candidates pushBack [_x, _model];};
	} forEach dRA_WorldHouses;
	
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
			{(_this#1) distance2D (((_depots get (_this#2))#0) call CRQ_Pos2D) < _proximity}
		] call CRQ_fnc_MAP_Group)#0);
	} forEach _depotTypes;
	
	CRA_LOAD_NEXT(0, 0);
	private _depots = [];
	private _index = 0;
	gRA_LocationIndexDepot = count gRA_Locations;
	{
		private _type = CRA_ASSET_DEPOTS#_forEachIndex;
		{
			_depots pushBack [[gRA_LocationIndexDepot + _index, [_x#0, 0], CRA_DEPOT_NAME + str _index, CRA_DEPOT_LABEL], _type, [[[],CRA_DEPOT_SIZE,[],false],[],[]], _x#1];
			_index  = _index + 1;
		} forEach _x;
	} forEach _depotGrp;
	CRA_LOAD_NEXT(0, 0);
	{
		_depots pushBack ([_index, _x] call CRA_DepotCustomCreate);
		_index  = _index + 1;
	} forEach CRA_DEPOT_CUSTOM;
	CRA_LOAD_NEXT(0, 0);
	{
		_x params ["_lcData", "_lcType", "_lcBase", "_dpSpawn"];
		private _location = [_lcData, _lcType, _lcBase, CRQ_SD_CIVFOR, [[CRA_SVAR_LOCATION_ASSET_SPAWN, [_dpSpawn]]]] call CRA_LocationGenerate;
		private _linkObj = [];
		private _linkData = [];
		{_linkObj pushBack [objNull, _forEachIndex]; _linkData pushBack [false, -1, -1];} forEach _dpSpawn;
		_linkObj pushBack [_location];
		[name _location, _linkObj, _linkData] call CRQ_fnc_LNK_Create;
		gRA_Locations pushBack _location;
	} forEach _depots;
};
CRA_DepotCustomCreate = {
	private _index = (_this#0);
	(_this#1) params ["_dpVec", "_dpData", ["_dpProps", []]];
	private _dpBounds = _dpData call {
		if (_this isEqualType -1) exitWith {
			_dpProps = [[gRA_DepotTypes#_this#0,[[CRQ_VUP_REL]]]] + _dpProps;
			gRA_DepotTypes#_this
		};
		if (_this isEqualType []) exitWith {
			if ((_this#0) isEqualType "") then {_dpProps = [[_this#0,[[CRQ_VUP_REL]]]] + _dpProps;};
			_this call CRA_DepotBounds
		};
		[]
	};
	[
		[gRA_LocationIndexDepot + _index, _dpVec, CRA_DEPOT_NAME + str _index, CRA_DEPOT_LABEL],
		CRA_ASSET_DEPOTS#(_dpBounds#2),
		[[[] ,[[(_dpBounds#3#1#0) / 2, (_dpBounds#3#1#1) / 2], [0, 0]], [], true], [], _dpProps],
		[_dpVec, _dpBounds] call CRA_DepotAnalysis
	]
};

/*
CRA_DBG_Depot = {
	private _lines = [];
	private _types = ["CRA_ASSET_WHEELED","CRA_ASSET_TRACKED","CRA_ASSET_WINGED","CRA_ASSET_BOAT","CRA_ASSET_ROTOR","CRA_ASSET_STATIC"];
	private _vec = ["CRQ_VUP_ABS","CRQ_VUP_REL","CRQ_VUP_VEC","CRQ_VUP_VEC_GROUND","CRQ_VUP_VEC_LEVEL"];
	private _spType = ["CRA_DEPOT_POS_INSIDE","CRA_DEPOT_POS_OUTSIDE","CRA_DEPOT_POS_BOAT"];
	private _fnc_Vec = {
		private _line = "[";
		{
			_line = _line + "[" + (_vec#(_x#0));
			if (count _x > 1) then {_line = _line + "," + str (_x#1);};
			if (count _x > 2) then {_line = _line + "," + str (_x#2);};
			_line = _line + (if (_forEachIndex < (count _this - 1)) then {"],"} else {"]"});
		} forEach _this;
		(_line + "]")
	};
	{
		private _line = "[" + ("'" + (_x#0) + "'") + "," + (_types#(_x#2)) + ",[";
		private _spawn = "";
		private _spLast = count (_x#4) - 1;
		{
			private _spLine = "[" + (_spType#(_x#1)) + ",";
			_spLine = _spLine + (switch (_x#1) do {
				case CRA_DEPOT_POS_INSIDE: {((_x#0) call _fnc_Vec) + ",[" + str (_x#3) + "," + str ((_x#2) apply {(round (_x * 100)) / 100}) + "]"};
				case CRA_DEPOT_POS_BOAT: {([[CRQ_VUP_VEC,_x#2]] call _fnc_Vec) + ",[" + str (_x#3) + "," + str (_x#2#1) + "]"};
				default {""};
			});
			_spLine = _spLine + "]" + (if (_forEachIndex < _spLast) then {","} else {""});
			_spawn = _spawn + _spLine;
		} forEach (_x#4);
		_line = _line + _spawn;
		_line = _line + "]]";
		_lines pushBack _line;
	} forEach gRA_DepotTypes;
	private _last = count gRA_DepotTypes - 1;
	private _output = "[";
	{_output = _output + _x + (if (_forEachIndex < _last) then {",\"} else {"]"}) + (toString [10]);} forEach _lines;
	_output
};
*/