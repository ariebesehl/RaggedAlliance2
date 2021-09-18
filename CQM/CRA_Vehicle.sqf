
gRA_SettingDepotRespawnWreck = ["CRA_VehicleRespawnWreck", 180] call BIS_fnc_getParamValue;
gRA_SettingDepotRespawnAbandon = ["CRA_VehicleRespawnAbandon", 0] call BIS_fnc_getParamValue;
gRA_SettingDepotAbandonMode = ["CRA_VehicleAbandonMode", 0] call BIS_fnc_getParamValue;
gRA_SettingDepotAbandonTime = ["CRA_VehicleAbandonTime", 180] call BIS_fnc_getParamValue;
gRA_SettingDepotAbandonRangeMode = ["CRA_VehicleAbandonRangeMode", 0] call BIS_fnc_getParamValue;
gRA_SettingDepotAbandonRange = (["CRA_VehicleAbandonRange", 100] call BIS_fnc_getParamValue) / 100;

gRA_VehicleIndexCounter = missionNamespace getVariable ["gRA_VehicleIndexCounter", -1];
gRA_VehicleIndex = missionNamespace getVariable ["gRA_VehicleIndex", []];
gRA_VehicleTypes = missionNamespace getVariable ["gRA_VehicleTypes", [[],[],[],[]]];
gRA_VehicleArmed = missionNamespace getVariable ["gRA_VehicleArmed", []];
gRA_VehicleUnarmed = missionNamespace getVariable ["gRA_VehicleUnarmed", [[[],[],[],[]],[[],[],[],[]],[[],[],[],[]],[[],[],[],[]]]];
gRA_Vehicles = [];

gRA_StaticTypes = missionNamespace getVariable ["gRA_StaticTypes", [[],[],[],[]]];
gRA_Statics = missionNamespace getVariable ["gRA_Statics", []];

gRA_DepotTypes = missionNamespace getVariable ["gRA_DepotTypes", []];
gRA_DepotData = missionNamespace getVariable ["gRA_DepotData", []];
gRA_Depots = missionNamespace getVariable ["gRA_Depots", []];
gRA_DepotEnter = missionNamespace getVariable ["gRA_DepotEnter", 800];
gRA_DepotLeave = missionNamespace getVariable ["gRA_DepotLeave", 800 + CRA_TRIGGER_HYSTERESIS];
gRA_DepotAbandonRange = missionNamespace getVariable ["gRA_DepotAbandonRange", 800];

CRA_VehicleCreate = {
	params ["_index", "_vec"];
	(gRA_VehicleIndex#_index) params ["_base", "_data", "_inventory"];
	private _vehicleInventory = [[[],[],[]],[]];
	{
		private _type = _forEachIndex;
		{
			private _amount = floor (random (_x#1));
			for [{private _i = 0},{_i < _amount},{_i = _i + 1}] do {
				private _index = [call CRA_ItemLevel, _x#0] call CRA_Item;
				if (_index != -1) then {
					switch (_type) do {
						case 0: {(_vehicleInventory#0#0) pushBack (gRA_ItemIndex#_index);};
						case 1: {private _mag = (gRA_ItemIndex#_index); (_vehicleInventory#0#1) pushBack [_mag#0, _mag#1];};
						case 2: {[_vehicleInventory, [_index, false, false] call CRA_ItemWeaponRasterize] call CRQ_InventoryAppend;};
						case 3: {(_vehicleInventory#1) pushBack [gRA_ItemIndex#_index, [[],[],[],[]]];};
						default {};
					};
				};
			};
		} forEach _x;
	} forEach _inventory;
	private _vehicle = [_base#0, _vec, _vehicleInventory] call CRQ_VehicleCreate;
	
	if (count _this > 2 && {(_this#2) isNotEqualTo []}) then {
		(_this#2) params ["_group", "_slot"];
		private _side = _data#1;
		private _capabilities = (_data#3) call CRQ_ByteDecode;
		private _crewIndex = switch (true) do {case (_capabilities#3): {2}; case (_capabilities#2): {1}; case (_capabilities#0): {1}; default {0};};
		private _crewType = CRA_VEHICLE_CREW#_side#_crewIndex;
		private _crewCount = [];
		{
			private _capacity = (_data#4#_forEachIndex);
			if (_capacity > 0) then {
				switch (true) do {
					case (_x < 0 || _x > 1): {_crewCount pushBack (round (random 1 * _capacity));};
					case (_x >=0 && _x <= 1): {_crewCount pushBack (round (_x * _capacity));};
					default {};
				};
			} else {
				_crewCount pushBack 0;
			};
		} forEach _slot;
		_group addVehicle _vehicle;
		private _unitVec = [(_vec#0) getPos [-(_base#1#0), (_vec#1)], _vec#1];
		{
			for [{private _i = 0},{_i < (_crewCount#_x)},{_i = _i + 1}] do {
				private _unitType = selectRandom _crewType;
				private _unit = [_group, _unitType, _unitVec, [_unitType, _unitType call CRA_UnitWeapon] call CRA_UnitLoadoutGenerate, call CRA_UnitIdentityNeutral] call CRQ_UnitCreate;
				[_unit] allowGetIn true;
				switch (_x) do {
					case 0: {_unit assignAsDriver _vehicle; [_unit] orderGetIn true; _unit moveInDriver _vehicle;};
					case 1: {_unit assignAsGunner _vehicle; [_unit] orderGetIn true; _unit moveInGunner _vehicle;};
					case 2: {_unit assignAsCommander _vehicle; [_unit] orderGetIn true; _unit moveInCommander _vehicle;};
					case 3: {_unit assignAsCargo _vehicle; [_unit] orderGetIn true; _unit moveInAny _vehicle;};
					default {};
				};
			};
		} forEach [2,0,1,3];
	};
	
	_vehicle setVariable [CRA_VAR_VEHICLE_TOUCHED, false];
	_vehicle setVariable [CRA_VAR_VEHICLE_TIME_INIT, gT_Now];
	_vehicle setVariable [CRA_VAR_VEHICLE_VEC_INIT, _this#1];
	_vehicle setVariable [CRA_VAR_VEHICLE_TIME_LAST, -1];
	_vehicle setVariable [CRA_VAR_VEHICLE_VEC_LAST, [[],0]];
	_vehicle setVariable [CRA_VAR_VEHICLE_ALLOW_ABANDON, true];
	_vehicle setVariable [CRA_VAR_VEHICLE_ALLOW_HIBERNATE, true];
	_vehicle
};
CRA_VehicleThaw = {
	private _vehicle = (_this#1) call CRQ_VehicleCreate;
	(_this#0) params ["_depot", "_group", "_touched","_timeLast","_vecLast","_timeInit","_vecInit", "_allowAbandon", "_allowHibernate"];
	_vehicle setVariable [CRA_VAR_VEHICLE_DEPOT, _depot];
	_vehicle setVariable [CRA_VAR_VEHICLE_GROUP, _group];
	_vehicle setVariable [CRA_VAR_VEHICLE_TOUCHED, _touched];
	_vehicle setVariable [CRA_VAR_VEHICLE_TIME_INIT, _timeInit];
	_vehicle setVariable [CRA_VAR_VEHICLE_VEC_INIT, _vecInit];
	_vehicle setVariable [CRA_VAR_VEHICLE_TIME_LAST, _timeLast];
	_vehicle setVariable [CRA_VAR_VEHICLE_VEC_LAST, _vecLast];
	_vehicle setVariable [CRA_VAR_VEHICLE_ALLOW_ABANDON, _allowAbandon];
	_vehicle setVariable [CRA_VAR_VEHICLE_ALLOW_HIBERNATE, _allowHibernate];
	_vehicle
};
CRA_VehicleHibernate = {
	private _depot = _this getVariable [CRA_VAR_VEHICLE_DEPOT, locationNull];
	private _group = _this getVariable [CRA_VAR_VEHICLE_GROUP, grpNull];
	private _touched = _this getVariable [CRA_VAR_VEHICLE_TOUCHED, false];
	private _timeLast = _this getVariable [CRA_VAR_VEHICLE_TIME_LAST, -1];
	private _vecLast = _this getVariable [CRA_VAR_VEHICLE_VEC_LAST, [[],0]];
	private _timeInit = _this getVariable [CRA_VAR_VEHICLE_TIME_INIT, -1];
	private _vecInit = _this getVariable [CRA_VAR_VEHICLE_VEC_INIT, [[],0]];
	private _allowAbandon = _this getVariable [CRA_VAR_VEHICLE_ALLOW_ABANDON, true];
	private _allowHibernate = _this getVariable [CRA_VAR_VEHICLE_ALLOW_HIBERNATE, true];
	private _type = typeOf _this;
	private _vec = [getPosATL _this, getDir _this];
	private _inventory = _this call CRQ_InventoryBox;
	private _damage = damage _this;
	[[_depot, _group, _touched, _timeLast, _vecLast, _timeInit, _vecInit, _allowAbandon, _allowHibernate],[_type, _vec, _inventory, _damage]]
};
CRA_VehicleLogUsage = {
	if (_this isEqualType objNull && {alive _this}) then {
		{if (alive _x) exitWith {_this setVariable [CRA_VAR_VEHICLE_TIME_LAST, gT_Now]; _this setVariable [CRA_VAR_VEHICLE_TOUCHED, true];};} forEach (crew _this);
	};
};
CRA_VehicleLogPos = {
	if (_this isEqualType objNull) then {
		private _pos = _this call CRQ_Pos2D;
		private _dir = getDir _this;
		if (!(_this getVariable [CRA_VAR_VEHICLE_TOUCHED, false])) then {
			private _posInit = (_this getVariable [CRA_VAR_VEHICLE_VEC_INIT, [[],0]])#0;
			if (_posInit isNotEqualTo [] && {_posInit distance2D _pos > 5}) then {_this setVariable [CRA_VAR_VEHICLE_TOUCHED, true];};
		};
		_this setVariable [CRA_VAR_VEHICLE_VEC_LAST, [_pos, _dir]];
	};
};
CRA_VehicleAbandon = {
	private _touched = false;
	//private _lastUsed = nil;
	private _lastUsed = -1;
	private _lastPos = [];
	private _allowAbandon = false;
	if (_this isEqualType objNull) then {
		_touched = _this getVariable [CRA_VAR_VEHICLE_TOUCHED, false];
		_lastUsed = _this getVariable [CRA_VAR_VEHICLE_TIME_LAST, -1];
		_lastPos = (_this getVariable [CRA_VAR_VEHICLE_VEC_LAST, [[]]])#0;
		_allowAbandon = _this getVariable [CRA_VAR_VEHICLE_ALLOW_ABANDON, false];
	} else {
		_touched = _this#0#2;
		_lastUsed = _this#0#3;
		_lastPos = (_this#0#4)#0;
		_allowAbandon = _this#0#7;
	};
	if (_allowAbandon && _touched) then {
		private _rangeout = if (_lastPos isEqualTo []) then {false} else {!([_lastPos, gRA_DepotAbandonRange] call CRA_PlayerInRange)};
		private _timeout = if (_lastUsed == -1) then {false} else {(gT_Now - _lastUsed) >= gRA_SettingDepotAbandonTime};
		switch (gRA_SettingDepotAbandonMode) do {
			default {false};
			case -1: {false};
			case 0: {_timeout || _rangeout};
			case 1: {_timeout && _rangeout};
			case 2: {_timeout};
			case 3: {_rangeout};
		};
	} else {
		false
	};
};
CRA_VehicleLoop = {
	private _remove = [];
	{
		private _wrecked = false;
		private _abandoned = false;
		private _thawed = false;
		private _hibernated = false;
		private _depot = locationNull;
		private _group = grpNull;
		if (_x isEqualType objNull) then {
			if (_x isEqualTo objNull) exitWith {_remove pushBack _forEachIndex};
			_depot = _x getVariable [CRA_VAR_VEHICLE_DEPOT, locationNull];
			_group = _x getVariable [CRA_VAR_VEHICLE_GROUP, grpNull];
			if (alive _x) then {
				_x call CRA_VehicleLogUsage;
				_x call CRA_VehicleLogPos;
				if (_x call CRA_VehicleAbandon) then {
					_abandoned = true;
					_x call CRQ_VehicleDelete;
					_remove pushBack _forEachIndex;
				} else {
					if (_x getVariable [CRA_VAR_VEHICLE_ALLOW_HIBERNATE, false]) then {
						private _pos = (_x getVariable [CRA_VAR_VEHICLE_VEC_LAST, [[],0]])#0;
						if (_pos isNotEqualTo [] && {!([_pos, gRA_PlayerLeave] call CRA_PlayerInRange)}) then {
							_hibernated = true;
							private _hibernated = _x call CRA_VehicleHibernate;
							_x call CRQ_VehicleDelete;
							gRA_Vehicles set [_forEachIndex, _hibernated];
						};
					};
				};
			} else {
				_wrecked = true;
				_x call CRQ_WreckRegister;
				_remove pushBack _forEachIndex;
			};
		} else {
			_depot = _x#0#0;
			_group = _x#0#1;
			if (_x call CRA_VehicleAbandon) then {
				_abandoned = true;
				_remove pushBack _forEachIndex;
			} else {
				private _pos = _x#1#1#0;
				if (_pos isNotEqualTo [] && {[_pos, gRA_PlayerEnter] call CRA_PlayerInRange}) then {
					_thawed = true;
					private _vehicle = _x call CRA_VehicleThaw;
					gRA_Vehicles set [_forEachIndex, _vehicle];
				};
			};
		};
		if (_wrecked) then {
			if (!isNull _depot) then {_depot setVariable [CRA_VAR_DEPOT_VEHICLE, objNull]; _depot setVariable [CRA_VAR_DEPOT_VEHICLE_TIME_DEATH, gT_Now];};
			if (!isNull _group) then {_group setVariable [CRA_VAR_GROUP_VEHICLE, objNull]; _group setVariable [CRA_VAR_GROUP_VEHICLE_TIME_DEATH, gT_Now];};
		};
		if (_abandoned) then {
			if (!isNull _depot) then {_depot setVariable [CRA_VAR_DEPOT_VEHICLE, objNull]; _depot setVariable [CRA_VAR_DEPOT_VEHICLE_TIME_ABANDON, gT_Now];};
			if (!isNull _group) then {_group setVariable [CRA_VAR_GROUP_VEHICLE, objNull]; _group setVariable [CRA_VAR_GROUP_VEHICLE_TIME_ABANDON, gT_Now];};
		};
		if (_thawed || _hibernated) then {
			if (!isNull _depot) then {_depot setVariable [CRA_VAR_DEPOT_VEHICLE, gRA_Vehicles#_forEachIndex];};
			if (!isNull _group) then {_group setVariable [CRA_VAR_GROUP_VEHICLE, gRA_Vehicles#_forEachIndex];};
		};
	} forEach gRA_Vehicles;
	reverse _remove;
	{gRA_Vehicles deleteAt _x;} forEach _remove;
};
CRA_VehicleSeats = {
	private _crewDriver = 0;
	private _crewPassenger = 0;
	private _crewGunner = 0;
	private _crewCommander = 0;
	private _weapons = [];
	{
		_weapons append (getArray (_x >> "weapons"));
		_crewDriver = _crewDriver + getNumber (_x >> "hasDriver");
		_crewPassenger = _crewPassenger + getNumber (_x >> "transportSoldier");
		if (getNumber (_x >> "primaryObserver") == 1 || getNumber (_x >> "isCoPilot") == 1) then {
			_crewCommander = _crewCommander + 1;
		} else {
			switch (getText (_x >> "proxyType")) do {
				case "CPCargo": {if (getNumber (_x >> "isPersonTurret") == 0 && getText (_x >> "gun") isNotEqualTo "") then {_crewGunner = _crewGunner + 1;} else {_crewPassenger = _crewPassenger + 1;};};
				case "CPGunner": {_crewGunner = _crewGunner + 1;};
				case "CPCommander": {_crewCommander = _crewCommander + 1;}; // should've been catched above by "primaryObserver"
				default {};
			};
		};
	} forEach ([_this, configNull] call BIS_fnc_getTurrets);
	[_weapons, [_crewDriver, _crewGunner, _crewCommander, _crewPassenger]]
};
CRA_VehicleAdd = {
	gRA_VehicleIndexCounter = gRA_VehicleIndexCounter + 1;
	gRA_VehicleIndex pushBack _this;
	gRA_VehicleIndexCounter
};
CRA_VehicleRegister = {
	params ["_type","_side","_quality","_index"];
	if (_quality < 0) then {_quality = 0;};
	if (_quality > 0) then {
		private _level = floor (_quality * gRA_ItemLevels);
		if (_level >= gRA_ItemLevels) then {_level = gRA_ItemLevels - 1;};
		for [{private _i = 0}, {_i < gRA_ItemLevels}, {_i = _i + 1}] do {
			if (_level >= (gRA_ItemLevelBounds#_i#0) && _level <= (gRA_ItemLevelBounds#_i#1)) then {
				(gRA_VehicleArmed#_i#_type#_side) pushBack _index;
			};
		};
	} else {
		(gRA_VehicleUnarmed#_type#_side) pushBack _index;
	};
	(gRA_VehicleTypes#_type) pushBack _index;
};
CRA_StaticRegister = {
	params ["_type","_side","_quality","_index"];
	if (_quality < 0) then {_quality = 0;};
	private _level = floor (_quality * gRA_ItemLevels);
	if (_level >= gRA_ItemLevels) then {_level = gRA_ItemLevels - 1;};
	for [{private _i = 0}, {_i < gRA_ItemLevels}, {_i = _i + 1}] do {
		if (_level >= (gRA_ItemLevelBounds#_i#0) && _level <= (gRA_ItemLevelBounds#_i#1)) then {
			(gRA_Statics#_i#_type#_side) pushBack _index;
		};
	};
	(gRA_StaticTypes#_type) pushBack _index;
};
gRA_VehicleTemp = missionNamespace getVariable ["gRA_VehicleTemp", []];
CRA_VehicleInit = {
	for [{private _i = 0}, {_i < gRA_ItemLevels}, {_i = _i + 1}] do {
		gRA_VehicleArmed pushBack [[[],[],[],[]],[[],[],[],[]],[[],[],[],[]],[[],[],[],[]]];
		gRA_Statics pushBack [[[],[],[],[]],[[],[],[],[]],[[],[],[],[]],[[],[],[],[]]];
	};
	{
		private _name = configName _x;
		private _type = switch (true) do {case (_name isKindOf "car"): {CRA_VEHICLE_CAR}; case (_name isKindOf "plane"): {CRA_VEHICLE_PLANE}; case (_name isKindOf "ship"): {CRA_VEHICLE_BOAT}; case (_name isKindOf "helicopter"): {CRA_VEHICLE_HELI}; case (_name isKindOf "StaticWeapon"): {CRA_VEHICLE_STATIC}; default {-1};};
		if (_type != -1) then {
			if (getNumber (_x >> "isUAV") != 0) exitWith {};
			private _side = switch (getNumber (_x >> "side")) do {case 0: {CRQ_SIDE_OPFOR}; case 1: {CRQ_SIDE_BLUFOR}; case 2: {CRQ_SIDE_IDFOR}; case 3: {CRQ_SIDE_CIVFOR}; default {CRQ_SIDE_UNKNOWN};};
			if (_side == CRQ_SIDE_UNKNOWN) exitWith {};
			if (CRA_VEHICLES_EXCLUDE find _name != -1) exitWith {};
			//if (_type == CRA_VEHICLE_STATIC) exitWith {}; // TODO implement statics
			
			private _vehicleSeats = _name call CRA_VehicleSeats;
			if (_type == CRA_VEHICLE_STATIC && {(_vehicleSeats#1#1) == 0}) exitWith {};
			//private _weapons = []; // TODO pylons, artillery  !isNull (_x >> "Components" >> "TransportPylonsComponent")
			private _lethal = 0;
			if (_type != CRA_VEHICLE_STATIC) then {
				{
					private _weapon = ((gCQ_CfgWeapons >> _x) call CRA_ItemWeaponAnalysis);
					if ((_weapon#1#1) > _lethal) then {_lethal = _weapon#1#1;};
				} forEach (_vehicleSeats#0);
				
				private _armor = getNumber (_x >> "armor");
				private _fuel = getNumber (_x >> "transportFuel") > 0;
				private _supply = getNumber (_x >> "transportAmmo") > 0;
				private _repair = getNumber (_x >> "transportRepair") > 0;
				private _medical = getNumber (_x >> "attendant") > 0;
				private _armed = _lethal > 0;
				
				private _capabilities = [_fuel, _supply, _repair, _medical, _armed] call CRQ_ByteEncode;
				
				private _factorLoad = (sqrt (getNumber (_x >> "maximumLoad"))) / 20;
				private _inventory = [[],[],[],[]];
				private _containers = [];
				if (_factorLoad > 0) then {
					private _itemFA = [];
					private _itemMK = [];
					private _itemTK = [];
					private _factorMedkit = if (_medical) then {_factorLoad} else {0};
					private _factorToolkit = if (_repair) then {_factorLoad} else {0};
					{_itemFA pushBack (_x * (_factorLoad + 2 * _factorMedkit));} forEach CRA_VEHICLE_INVENTORY_FIRSTAID;
					{_itemMK pushBack (_x * _factorMedkit);} forEach CRA_VEHICLE_INVENTORY_MEDKIT;
					{_itemTK pushBack (_x * _factorToolkit);} forEach CRA_VEHICLE_INVENTORY_TOOLKIT;
					(_inventory#0) pushBack [[CRA_INDEX_FIRSTAIDKIT], _itemFA];
					if (_factorMedkit > 0) then {(_inventory#0) pushBack [[CRA_INDEX_MEDIKIT], _itemMK];};
					if (_factorToolkit > 0) then {(_inventory#0) pushBack [[CRA_INDEX_TOOLKIT], _itemTK];};
					if (_type == CRA_VEHICLE_PLANE || _type == CRA_VEHICLE_HELI) then {
						private _itemPC = [];
						{_itemPC pushBack (_x * _factorLoad);} forEach CRA_VEHICLE_INVENTORY_PARACHUTE;
						(_inventory#3) pushBack [[CRA_INDEX_PARACHUTE], _itemPC];
					};
				};
				private _quality = 0.00;
				if (_armed) then {
					private _base = switch (_type) do {
						case CRA_VEHICLE_CAR: {
							switch (true) do {
								case (_armor <= 100): {CRA_VEHICLE_QUALITY_CAR};
								case (_armor > 100 && _armor <= 250): {CRA_VEHICLE_QUALITY_MRAP};
								case (_armor > 250): {CRA_VEHICLE_QUALITY_APC};
								default {CRA_VEHICLE_QUALITY};
							};
						};
						case CRA_VEHICLE_PLANE: {CRA_VEHICLE_QUALITY_PLANE};
						case CRA_VEHICLE_BOAT: {CRA_VEHICLE_QUALITY_BOAT};
						case CRA_VEHICLE_HELI: {CRA_VEHICLE_QUALITY_HELI};
						default {CRA_VEHICLE_QUALITY};
					};
					private _factors = [_lethal, _armor];
					_quality = [_base, _factors] call CRA_ItemQuality;
				};
				private _index = [[_name, _name call CRQ_ClassSize, _name call CRQ_ClassCenter],[_type, _side, _quality, _capabilities, _vehicleSeats#1],_inventory] call CRA_VehicleAdd;
				[_type, _side, _quality, _index] call CRA_VehicleRegister;
			} else {
				private _size = _name call CRQ_ClassSize;
				{
					private _weapon = ((gCQ_CfgWeapons >> _x) call CRA_ItemWeaponAnalysis);
					if ((_weapon#1#1) > _lethal) then {_lethal = _weapon#1#1;};
					_type = switch (_weapon#1#0) do {
						default {-1};
						case CRA_INDEX_VWEAPON_LMG;
						case CRA_INDEX_VWEAPON_MMG;
						case CRA_INDEX_VWEAPON_HMG;
						case CRA_INDEX_VWEAPON_GMG: {if ((_size#1#2) > 3) then {CRA_STATIC_MG_HIGH} else {CRA_STATIC_MG_LOW};};
						case CRA_INDEX_VWEAPON_CAN: {CRA_STATIC_MORTAR};
						case CRA_INDEX_VWEAPON_RPG_AA;
						case CRA_INDEX_VWEAPON_RPG_AT: {CRA_STATIC_RPG};
					};
				} forEach (_vehicleSeats#0);
				private _index = [[_name, _size, _name call CRQ_ClassCenter],[_type, _side, _lethal, 0, _vehicleSeats#1],[]] call CRA_VehicleAdd;
				[_type, _side, _lethal, _index] call CRA_StaticRegister;
			};
		};
	} forEach ("getNumber (_x >> 'scope') == 2" configClasses gCQ_CfgVehicles);
};
CRA_DepotLoop = {
	{
		switch (_x getVariable [CRA_VAR_DEPOT_STATE, -1]) do {
			case CRA_STATE_INIT: {if ([locationPosition _x, gRA_PlayerEnter] call CRA_PlayerInRange) then {_x call CRA_DepotEnter;};};
			case CRA_STATE_HIBERNATE: {if ([locationPosition _x, gRA_PlayerEnter] call CRA_PlayerInRange) then {_x call CRA_DepotEnter;};};
			case CRA_STATE_ACTIVE: {_x call CRA_DepotActive;};
			default {};
		};
	} forEach gRA_Depots;
};
CRA_DepotActive = {
	private _pos = locationPosition _this;
	if ([_pos, gRA_PlayerLeave] call CRA_PlayerInRange) then {
		_vehicle = _this getVariable [CRA_VAR_DEPOT_VEHICLE, objNull];
		if (_vehicle isEqualType objNull && {isNull _vehicle}) then {
			if (gRA_SettingDepotRespawnWreck != -1) then {
				private _timeDeath = _this getVariable [CRA_VAR_DEPOT_VEHICLE_TIME_DEATH, nil];
				if (!isNil {_timeDeath} && {(gT_Now - _timeDeath) >= gRA_SettingDepotRespawnWreck}) then {_this call CRA_DepotSpawn;};
			};
			if (gRA_SettingDepotRespawnAbandon != -1) then {
				private _timeAbandon = _this getVariable [CRA_VAR_DEPOT_VEHICLE_TIME_ABANDON, nil];
				if (!isNil {_timeAbandon} && {(gT_Now - _timeAbandon) >= gRA_SettingDepotRespawnAbandon}) then {_this call CRA_DepotSpawn;};
			};
		};
	} else {
		[_this, CRA_STATE_HIBERNATE] call CRA_DepotState;
	};
};
CRA_DepotEnter = {
	switch (_this getVariable [CRA_VAR_DEPOT_STATE, -1]) do {
		case CRA_STATE_INIT: {
			{_x hideObjectGlobal true;} forEach (_this getVariable [CRA_VAR_DEPOT_CLUTTER, []]);
			_this setVariable [CRA_VAR_DEPOT_UNIT_PROPS, (_this getVariable [CRA_VAR_DEPOT_PROPS, []]) call CRQ_PropSpawn];
			_this call CRA_DepotSpawn;
			_this call CRA_DepotMarkerCreate;
		};
		default {};
	};
	[_this, CRA_STATE_ACTIVE] call CRA_DepotState;
};
CRA_DepotSpawn = {
	private _owner = _this getVariable [CRA_VAR_DEPOT_OWNER, -1];
	private _type = _this getVariable [CRA_VAR_DEPOT_TYPE, -1];
	private _vehiclesAll = selectRandom (_this getVariable [CRA_VAR_DEPOT_SPAWN, [[[],[],[],[]]]]);
	if (_type != -1 && _owner != -1) then {
		if ((_vehiclesAll#_owner) isEqualTo []) then {_owner = 3;};
		if ((_vehiclesAll#_owner) isNotEqualTo []) then {
			(selectRandom (_vehiclesAll#_owner)) params ["_index", "_options"];
			(selectRandom _options) params ["_pos", "_dir"];
			private _vehicleRadius = gRA_VehicleIndex#_index#0#1#0;
			[_pos, _vehicleRadius, [_pos, _vehicleRadius] call CRQ_WrecksFind] call CRQ_ClearArea;
			
			private _vehicle = [_index, [_pos, selectRandom _dir]] call CRA_VehicleCreate;
			
			_vehicle setVariable [CRA_VAR_VEHICLE_DEPOT, _this];
			gRA_Vehicles pushBack _vehicle;
			
			_this setVariable [CRA_VAR_DEPOT_VEHICLE, _vehicle];
			_this setVariable [CRA_VAR_DEPOT_VEHICLE_TIME_DEATH, nil];
			_this setVariable [CRA_VAR_DEPOT_VEHICLE_TIME_ABANDON, nil];
			
		};
	};
};
CRA_DepotMarkerCreate = {
	if (_this getVariable [CRA_VAR_DEPOT_MARKER, ""] isEqualTo "") then {
		private _marker = createMarker ["CRA_Depot_" + str (_this getVariable [CRA_VAR_DEPOT_INDEX, -1]), locationPosition _this];
		_this setVariable [CRA_VAR_DEPOT_MARKER, _marker];
	};
};
CRA_DepotMarkerState = {
	private _marker = _this getVariable [CRA_VAR_DEPOT_MARKER, ""];
	if (_marker isNotEqualTo "") then {
		private _state = _this getVariable [CRA_VAR_DEPOT_STATE, -1];
		private _type = _this getVariable [CRA_VAR_DEPOT_TYPE, -1];
		private _owner = _this getVariable [CRA_VAR_DEPOT_OWNER, -1];
		if (_state != -1) then {_marker setMarkerAlpha (CRA_ALPHA_STATE#_state);};
		if (_type != -1 && _owner != -1) then {_marker setMarkerType (CRA_DEPOT_MARKER#_type#_owner);};
	};
};
CRA_DepotState = {
	params ["_depot", "_state"];
	_depot setVariable [CRA_VAR_DEPOT_STATE, _state];
	_depot call CRA_DepotMarkerState;
};
CRA_DepotAnalysis = {
	params ["_depot", "_depotVec"];
	_depotVec params ["_depotPos","_depotDir"];
	private _depotOcclusion = if (_depot isNotEqualTo objNull) then {true} else {false};
	private _depotSource = if ((_this#2) isEqualType -1) then {gRA_DepotTypes#(_this#2)} else {_this#2};
	private _depotType = _depotSource#1;
	private _depotRadius = _depotSource#2#0;
	private _depotSize = _depotSource#2#1; // TODO objectScale?
	private _depotOptions = _depotSource#3;
	
	[_depotPos, _depotDir, _depotRadius, 0] call CRQ_PosUtilSetup;
	private _depotVehicles = [[],[],[],[]];
	{
		private _vehicle = gRA_VehicleIndex#_x;
		private _vehicleSide = _vehicle#1#1;
		private _vehicleRadius = _vehicle#0#1#0;
		private _vehicleSize = _vehicle#0#1#1;
		private _vehicleCenter = _vehicle#0#2;
		private _vehiclesOption = [];
		{
			_x params ["_optionMode", "_optionArg", "_optionLocation", "_optionBounding", "_optionDirections"];
			private _optionPos = [_optionMode, _optionArg] call CRQ_PosUtil;
			private _vehcPos = [];
			private _vehcDir = [];
			{_vehcDir pushBack (_x + _depotDir);} forEach _optionDirections;
			private _obstructed = false;
			switch (_optionLocation) do {
				case CRA_DEPOT_POS_INSIDE: {
					_vehcPos = _optionPos;
					if (_vehicleRadius > (_optionBounding#0) || {_vehicleRadius > (_optionBounding#1) || {(_vehicleSize#2) > (_optionBounding#2)}}) exitWith {_obstructed = true;};
					if (_depotOcclusion) then {{if (_x != _depot && {(_vehcPos distance2D (_x call CRQ_Pos2D)) < _vehicleRadius + ((_x call CRQ_ObjectSize)#0)}) exitWith {_obstructed = true;};} forEach nearestTerrainObjects [_vehcPos, CRA_DEPOT_OBSTRUCTORS, _depotRadius, true, false];};
				};
				case CRA_DEPOT_POS_OUTSIDE: { // TODO verify this
					_vehcPos = _optionPos getPos [(_optionBounding#0) + _vehicleRadius, _depotDir + _optionBounding#1];
					if (_depotOcclusion) then {{if ((_x != _depot) && ((_vehcPos distance2D (_x call CRQ_Pos2D)) < _vehicleRadius)) exitWith {_obstructed = true;};} forEach nearestTerrainObjects [_vehcPos, CRA_DEPOT_OBSTRUCTORS, _vehicleRadius, true, false];};
				};
				case CRA_DEPOT_POS_BOAT: {
					private _optionRadius = (_optionBounding#0) + _vehicleRadius * CRA_DEPOT_PIER_CLEARANCE;
					_vehcPos = _optionPos getPos [_optionRadius, _depotDir + (_optionBounding#1)];
					if ((_vehcPos#2) > (-(_vehicleCenter#2)) || {!surfaceIsWater _vehcPos}) exitWith {_obstructed = true;};
					if (_depotOcclusion) then {{if (_x != _depot && {(_vehcPos distance2D (_x call CRQ_Pos2D)) < _vehicleRadius + ((_x call CRQ_ObjectSize)#0)}) exitWith {_obstructed = true;};} forEach nearestTerrainObjects [_vehcPos, CRA_DEPOT_PIER_OBSTRUCTORS, CRA_DEPOT_PIER_SCAN_RANGE, true, true];};
					_vehcPos deleteAt 2;
				};
				default {};
			};
			if (!_obstructed && {_vehcPos isNotEqualTo [] && {_vehcDir isNotEqualTo []}}) then {_vehiclesOption pushBack [_vehcPos, _vehcDir];};
		} forEach _depotOptions;
		if (_vehiclesOption isNotEqualTo []) then {(_depotVehicles#_vehicleSide) pushBack [_x, _vehiclesOption];};
	} forEach (gRA_VehicleTypes#_depotType);
	_depotVehicles
};
CRA_DepotCustomCreate = {
	params ["_depotVec", "_depotData", "_depotProps"];
	private _depotPos = _depotVec#0;
	private _depot = _depotData#0;
	private _depotType = -1;
	private _depotRadius = 0;
	private _depotBounds = [];
	private _propSources = [];
	switch (true) do {
		case (_depot isEqualType -1): {
			_depotBounds = _depot;
			private _proto = CRA_DEPOT_TYPES#_depot;
			_propSources = [[_proto#0,[CRQ_POS_REL,[0,0,0]],0]] + _depotProps;
			_depotType = _proto#1;
		};
		case (_depot isEqualType []): {
			_depotBounds = _depotData call CRA_DepotBounds;
			_propSources = _depotProps;
			_depotType = _depotData#1;
			_depotRadius = _depotBounds#2#0;
		};
		default {
			_depotBounds = _depotData call CRA_DepotBounds;
			_propSources = [[_depotData#0,[CRQ_POS_REL,[0,0,0]],0]] + _depotProps;
			_depotType = _depotData#1;
			_depotRadius = _depotBounds#2#0;
		};
	};
	private _depotVehicles = [objNull, _depotVec, _depotBounds] call CRA_DepotAnalysis;
	private _props = [_depotVec, _propSources] call CRQ_PropRasterize;
	private _clutter = [_depotPos, _depotRadius] call CRQ_WorldClutter;
	[-1, _depotType, _depotVec#0, CRQ_SIDE_CIVFOR, _clutter, _props, [_depotVehicles]]
};

CRA_DepotBounds = {
	params ["_class", "_type", "_options"];
	private _model = "";
	private _size = [];
	if (_class isEqualType "") then {
		_model = toLowerANSI (_class call CRQ_ClassModel);
		_size = _class call CRQ_ClassSize;
	} else {
		_size = _class;
	};
	private _rasterized = [];
	{
		_x params ["_optionMode", "_optionArg", "_optionLocation", "_optionBounding", "_optionDirections"];
		private _boundingRasterized = [];
		switch (_optionLocation) do {
			case CRA_DEPOT_POS_INSIDE: {_boundingRasterized = [(_size#1#0) * (_optionBounding#0), (_size#1#1) * (_optionBounding#1), (_size#1#2) * (_optionBounding#2)];};
			case CRA_DEPOT_POS_OUTSIDE: {_boundingRasterized = [(_size#0) * (_optionBounding#0), _optionBounding#1];};
			case CRA_DEPOT_POS_BOAT: {_boundingRasterized = [(_size#0) * (_optionBounding#0) * CRA_DEPOT_PIER_CLEARANCE, _optionBounding#1];};
			default {};
		};
		_rasterized pushBack [_optionMode, _optionArg, _optionLocation, _boundingRasterized, _optionDirections];
	} forEach _options;
	[_model, _type, _size, _rasterized]
};
CRA_DepotInit = {
	{_x call CRA_DepotCreate;} forEach gRA_DepotData;
	gRA_DepotData = nil;
};
CRA_DepotGenerate = {

	{gRA_DepotTypes pushBack (_x call CRA_DepotBounds);} forEach CRA_DEPOT_TYPES;
	
	private _depotCandidates = [];
	{
		private _obj = _x;
		private _name = _obj call CRQ_ObjectModel;
		{if (_name isEqualTo (_x#0) && {(((vectorUp _obj)#2) / (getObjectScale _obj)) >= CRA_DEPOT_VECTORUP_MIN}) exitWith {_depotCandidates pushBack [_obj, _forEachIndex];};} forEach gRA_DepotTypes;
	} forEach (["HOUSE"] call CRQ_WorldTerrainObjects);
	
	private _depotsAll = [];
	{
		private _depotVehicles = [_x#0, [(_x#0) call CRQ_Pos2D, getDir (_x#0)], _x#1] call CRA_DepotAnalysis;
		if (_depotVehicles isNotEqualTo [[],[],[],[]]) then {_depotsAll pushBack [_x#0, gRA_DepotTypes#(_x#1)#1, _depotVehicles];};
	} forEach _depotCandidates;
	
	private _depotGroups = [[],[],[],[]];
	{
		_x params ["_depot", "_type", "_vehicles"];
		private _depotPos = _depot call CRQ_Pos2D;
		private _found = -1;
		{if (_depotPos distance2D (_x#0) < (CRA_DEPOT_GROUPING#_type)) exitWith {_found = _forEachIndex;};} forEach (_depotGroups#_type);
		if (_found != -1) then {
			(_depotGroups#_type#_found#2) pushBack _vehicles;
			(_depotGroups#_type#_found#1) pushBack _depotPos;
			(_depotGroups#_type#_found) set [0, (_depotGroups#_type#_found#1) call CRQ_PosAvg];
		} else {
			(_depotGroups#_type) pushBack [_depotPos, [_depotPos], [_vehicles]];
		};
	} forEach _depotsAll;
	
	private _index = 0;
	{
		private _type = _forEachIndex;
		{
			gRA_DepotData pushBack [_index, _type, _x#0, CRQ_SIDE_CIVFOR, [], [], _x#2];
			_index  = _index + 1;
		} forEach _x;
	} forEach _depotGroups;
	
	{gRA_DepotData pushBack (_x call CRA_DepotCustomCreate);} forEach CRA_DEPOT_CUSTOM;
};
CRA_DepotCreate = {
	params ["_index", "_type", "_pos", "_owner", "_clutter", "_props", "_spawn"];
	if (_index == -1) then {_index = count gRA_Depots;};
	private _owner = 3;
	private _depot = createLocation [CRA_DEPOT_LOCATION_TYPE#_type, _pos, CRA_DEPOT_LOCATION_SIZE, CRA_DEPOT_LOCATION_SIZE];
	_depot setVariable [CRA_VAR_DEPOT_INDEX, _index];
	_depot setVariable [CRA_VAR_DEPOT_STATE, CRA_STATE_INIT];
	_depot setVariable [CRA_VAR_DEPOT_TYPE, _type];
	_depot setVariable [CRA_VAR_DEPOT_POS, _pos];
	_depot setVariable [CRA_VAR_DEPOT_OWNER, _owner];
	_depot setVariable [CRA_VAR_DEPOT_MARKER, ""];
	_depot setVariable [CRA_VAR_DEPOT_CLUTTER, _clutter];
	_depot setVariable [CRA_VAR_DEPOT_PROPS, _props];
	_depot setVariable [CRA_VAR_DEPOT_SPAWN, _spawn];
	_depot setVariable [CRA_VAR_DEPOT_VEHICLE, objNull];
	_depot setName ("CRA_Depot_" + str _index);
	_depot setText ("CRA_Depot_" + str _index);
	gRA_Depots pushBack _depot;
};

CRA_DepotSave = {
	_this = [_this, gRA_DepotTypes] call CRQ_CRC;
	profileNamespace setVariable [CRA_VAR_CACHE_DEPOT_TYPES, gRA_DepotTypes];
	private _data = [];
	{
		private _copy = +_x;
		_copy set [4, []];
		{(_copy#4) pushBack (netId _x);} forEach (_x#4);
		_data pushBack _copy;
		_this = [_this, _copy] call CRQ_CRC;
	} forEach gRA_DepotData;
	profileNamespace setVariable [CRA_VAR_CACHE_DEPOT_DATA, _data];
	_this
};
CRA_DepotLoad = {
	gRA_DepotTypes = profileNamespace getVariable [CRA_VAR_CACHE_DEPOT_TYPES, []];
	_this = [_this, gRA_DepotTypes] call CRQ_CRC;
	{
		_this = [_this, _x] call CRQ_CRC;
		private _copy = +_x;
		_copy set [4, []];
		{(_copy#4) pushBack (objectFromNetId _x);} forEach (_x#4);
		gRA_DepotData pushBack _copy;
	} forEach (profileNamespace getVariable [CRA_VAR_CACHE_DEPOT_DATA, []]);
	_this
};
CRA_DepotReset = {
	gRA_DepotTypes = [];
	gRA_DepotData = [];
};