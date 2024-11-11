
CRA_fnc_AS_Available = {
	params ["_args", ["_bounds", [0,1]]];
	private _vehicles = [];
	while {true} do {
		{_vehicles append ([_bounds, gRA_AS_Catalog#(_x#0)#(_x#1)#(_x#2)] call CRQ_CatalogQualityMapItem);} forEach _args;
		if (_vehicles isNotEqualTo [] || {(_bounds#0) <= 0}) exitWith {};
		_bounds set [0, 0 max ((_bounds#0) - 0.0625)];
	};
	_vehicles
};
CRA_fnc_AS_Random = {
	private _assets = _this call CRA_fnc_AS_Available;
	if (_assets isNotEqualTo []) then {selectRandom _assets} else {-1};
};
CRA_fnc_AS_Create = {
	params ["_index", "_vec", ["_crew", []]];
	(pCQ_CT_Item#_index) params ["_vhName", "_vhCategory", "_vhQuality", "_vhData", "_vhDim", "_vhCaps", "_vhSeats", ["_vhInventory", []]];
	
	private _inventory = [[[],[],[]],[]];
	
	if (_vhInventory isNotEqualTo []) then {
		private _indexInventory = [[],[],[],[]];
		{
			private _index = _forEachIndex;
			{
				_x params ["_itemCategory", "_itemQuality", "_itemCount"];
				private _count = floor (random _itemCount);
				for "_i" from 1 to _count do {
					private _item = [_itemCategory, _itemQuality call CRA_fnc_IT_Quality] call CRA_fnc_IT_Random;
					if (_item != -1) then {(_indexInventory#_index) pushBack _item;};
				};
			} forEach _x;
		} forEach _vhInventory;
		{(_inventory#0#0) pushBack (pCQ_CT_Item#_x#0);} forEach (_indexInventory#0);
		{private _mag = pCQ_CT_Item#_x; (_inventory#0#1) pushBack [_mag#0, _mag#4];} forEach (_indexInventory#1); // TODO test me!
		{(_inventory#1) pushBack [pCQ_CT_Item#_x#0, [[],[],[],[]]];} forEach (_indexInventory#3);
		{[_inventory, [_x, false, false] call CRA_fnc_IT_WeaponRasterize] call CRQ_InventoryAppend;} forEach (_indexInventory#2);
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
		private _relation = _group call CRA_fnc_SD_RelationPlayer;
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
CRA_fnc_AS_Register = {
	params ["_asset", ["_touched", false], ["_abandon", true], ["_hibernate", true], ["_vecLast", []], ["_timeLast", -1]];
	_asset setVariable [CRA_SVAR_VEC, if (_vecLast isNotEqualTo []) then {_vecLast} else {_asset call CRQ_Vec2D}];
	_asset setVariable [CRA_SVAR_TIME, _timeLast];
	_asset setVariable [CRA_SVAR_VEHICLE_TOUCHED, _touched];
	_asset setVariable [CRA_SVAR_VEHICLE_ABANDON, _abandon];
	_asset setVariable [CRA_SVAR_VEHICLE_HIBERNATE, _hibernate];
	gRA_AS_List pushBack _asset;
};
CRA_fnc_AS_AbandonEnable = {
	_this setVariable [CRA_SVAR_VEHICLE_ABANDON, true];
};
CRA_fnc_AS_AbandonDisable = {
	_this setVariable [CRA_SVAR_VEHICLE_ABANDON, false];
};
CRA_fnc_AS_HibernateEnable = {
	_this setVariable [CRA_SVAR_VEHICLE_HIBERNATE, true];
};
CRA_fnc_AS_HibernateDisable = {
	_this setVariable [CRA_SVAR_VEHICLE_HIBERNATE, false];
};
CRA_fnc_AS_Log = {
	([
		[{(_this#0) getVariable [_this#1, _this#2]}, {(_this#0) setVariable [_this#1, _this#2]}, {_this call CRQ_Vec2D}, {(crew _this) findIf {alive _x} == -1}],
		[{_this call CRQ_VarGet}, {_this call CRQ_VarSet}, {[_this, CRA_SVAR_VEC, []] call CRQ_VarGet}, {true}]
	]#(if (_this isEqualType objNull) then {0} else {1})) params ["_fnc_get", "_fnc_set", "_fnc_vec", "_fnc_empty"];
	
	private _vec = _this call _fnc_vec;
	if (_vec isEqualTo []) exitWith {};
	
	private _actNow = [_this, CRA_SVAR_ACT_NOW, 0] call _fnc_get;
	private _actBase = [_this, CRA_SVAR_ACT_BASE, gRA_PG_Activation] call _fnc_get;
	[_this, CRA_SVAR_ACT_NOW, [_vec, (if (_actBase < 0) then {-_actBase * gRA_PG_Activation} else {_actBase}), _actNow, CRA_ACTIVITY_MIN, CRA_ACTIVITY_MAX] call CRA_PlayerActivity] call _fnc_set;
	
	private _empty = _this call _fnc_empty;
	if (!_empty) then {[_this, CRA_SVAR_TIME, gCS_TM_Now] call _fnc_set;};
	if ([_this, CRA_SVAR_VEHICLE_TOUCHED, false] call _fnc_get) exitWith {[_this, CRA_SVAR_VEC, _vec] call _fnc_set;};
	if (_empty && {([_this, CRA_SVAR_VEC, []] call _fnc_get) call {_this isEqualTo [] || {[_this, _vec] call CRQ_VecDist2D < CRA_ASSET_MOVED_DIST}}}) exitWith {};
	[_this, CRA_SVAR_VEC, _vec] call _fnc_set;
	[_this, CRA_SVAR_VEHICLE_TOUCHED, true] call _fnc_set;
};
CRA_fnc_AS_Abandon = {
	([
		[CRA_SVAR_VEHICLE_ABANDON, false],
		[CRA_SVAR_VEHICLE_TOUCHED, false],
		[CRA_SVAR_TIME, -1],
		[CRA_SVAR_ACT_NOW, 0]
	] apply (if (_this isEqualType objNull) then {{_this getVariable _x}} else {{([_this] + _x) call CRQ_VarGet}})) params ["_abandon", "_touched", "_lastUsed", "_actNow"];
	if (_abandon && {_touched}) exitWith {[_lastUsed != -1 && {([_lastUsed, gCS_TM_Now] call CRQ_fnc_TimeDelta) >= gRA_PM_AS_AbandonTime}, _actNow <= 0] call gRA_AS_FuncAbandonMode};
	false
};
CRA_fnc_AS_InitMain = {
	private _dimensions = CRA_ASSET_CLASSES apply {[]};
	{
		private _side = _forEachIndex;
		{
			private _class = _forEachIndex;
			{
				{
					(pCQ_CT_Item#_x#4) params ["_radius", "_size", "_center"];
					private _index = (_dimensions#_class) findIf {_size isEqualTo (_x#2)};
					if (_index == -1) then {
						_index = count (_dimensions#_class);
						(_dimensions#_class) pushBack [[[],[],[],[]], _radius, _size, _center];
					};
					(_dimensions#_class#_index#0#_side) pushBackUnique _x;
				} forEach (_x#0);
			} forEach _x;
		} forEach _x;
	} forEach gRA_AS_Catalog;
	gRA_AS_Dimensions = _dimensions apply {[_x, [], {(_x#1)}, "DESCEND"] call BIS_fnc_sortBy};
};
CRA_fnc_AS_InitZero = {
	// for "_side" from 0 to ((count CRA_ASSET_SIDES) - 1) do {
		// private _assetSide = [];
		// for "_class" from 0 to ((count CRA_ASSET_CLASSES) - 1) do {
			// _assetSide pushBack ((CRA_ASSET_TYPES#_class) apply {[]});
		// };
		// gRA_AS_Catalog pushBack _assetSide;
	// };
	gRA_AS_Catalog = CRA_ASSET_SIDES apply {
		private _assetSide = [];
		for "_class" from 0 to ((count CRA_ASSET_CLASSES) - 1) do {_assetSide pushBack ((CRA_ASSET_TYPES#_class) apply {[]});};
		_assetSide
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
					private _index = (pCQ_CT_Item#(_x#1)) call _type;
					if (_index != -1) then {(_classTypes#_index#1) pushBack _x; _assetsUnique pushBackUnique (_x#1);};
				} forEach ([([_catSide, _catClass] + _categories) call CRQ_CatalogListMatching, _quality, _weight] call CRQ_CatalogListQuality);
			} forEach (CRA_ASSET_TYPE_ASSETS#_class);
			
			{
				(_x#1) sort true;
				//(gRA_AS_Catalog#_side#_class) set [_forEachIndex, [_x#0, _x#1] call CRQ_CatalogQualityMapGenerate];
				(gRA_AS_Catalog#_side#_class) set [_forEachIndex, _x call CRQ_CatalogQualityMapGenerate];
			} forEach _classTypes;
			
		} forEach CRA_ASSET_CLASSES;
	} forEach CRA_ASSET_SIDES;
	{
		private _asset = (pCQ_CT_Item#_x);
		_asset params ["_name", "_category", "_quality", "_data"];
		private _capabilities = [CRQ_CDAT_CAPABILITIES, _data] call CRQ_CatalogArrayData;
		private _load = [CRQ_CDAT_LOAD, _data] call CRQ_CatalogArrayData;
		_asset set [4, ([CRQ_CDAT_SIZE, _data] call CRQ_CatalogArrayData) + [[CRQ_CDAT_CENTER, _data] call CRQ_CatalogArrayData]];
		_asset set [5, _capabilities];
		_asset set [6, [CRQ_CDAT_SEATS, _data] call CRQ_CatalogArrayData];
		if (_load > 0) then {
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
	} forEach _assetsUnique;
	
	gRA_AS_FuncAbandonMode = [
		{false},
		{(_this#0) || (_this#1)},
		{(_this#0) && (_this#1)},
		{(_this#0)},
		{(_this#1)}
	]#gRA_PM_AS_AbandonMode;
};
CRA_fnc_AS_Loop = {
	private _fnc_wrecked = {
		{private _data = (_x call CRQ_fnc_LNK_Get)#1#_y; _data set [0, true]; _data set [1, gCS_TM_Now];} forEach ((_this#0) call CRQ_fnc_LNK_Get);
	};
	private _fnc_abandon = {
		{private _data = (_x call CRQ_fnc_LNK_Get)#1#_y; _data set [0, true]; _data set [2, gCS_TM_Now];} forEach ((_this#0) call CRQ_fnc_LNK_Get);
	};
	private _fnc_suspend = {
		{((_x call CRQ_fnc_LNK_Get)#0) set [_y, _this#1];} forEach ((_this#0) call CRQ_fnc_LNK_Get);
	};
	private _remove = [];
	{
		if (_x isEqualType objNull) then {
			if (_x isEqualTo objNull) exitWith {_remove pushBack _forEachIndex};
			if (alive _x) exitWith {
				_x call CRA_fnc_AS_Log;
				if (gRA_PL_Asset find _x != -1) exitWith {};
				if (_x call CRA_fnc_AS_Abandon) exitWith {
					[_x, _x] call _fnc_abandon;
					_x call CRQ_VehicleDelete;
					_remove pushBack _forEachIndex;
				};
				if (_x getVariable [CRA_SVAR_VEHICLE_HIBERNATE, false]) exitWith {
					if (_x getVariable [CRA_SVAR_ACT_NOW, 0] <= 0) then {
						private _hibernated = _x call CRQ_VehicleHibernate;
						//[_x, _hibernated#1, _x, [_hibernated#1, objNull] call CRQ_LinkVars] call _fnc_suspend;
						[_x, _hibernated#1] call _fnc_suspend;
						gRA_AS_List set [_forEachIndex, _hibernated];
						_x call CRQ_VehicleDelete;
					};
				};
			};
			[_x, _x] call _fnc_wrecked;
			_remove pushBack _forEachIndex;
		} else {
			_x params ["_data", "_vars"];
			_vars call CRA_fnc_AS_Log;
			if (_vars call CRA_fnc_AS_Abandon) exitWith {
				[_vars] call _fnc_abandon;
				_remove pushBack _forEachIndex;
			};
			if ([_vars, CRA_SVAR_ACT_NOW, 0] call CRQ_VarGet < 1) exitWith {};
			private _vehicle = _x call CRQ_VehicleThaw;
			[_vars, _vehicle] call _fnc_suspend;
			gRA_AS_List set [_forEachIndex, _vehicle];
		};
	} forEach gRA_AS_List;
	reverse _remove;
	{gRA_AS_List deleteAt _x;} forEach _remove;
};
