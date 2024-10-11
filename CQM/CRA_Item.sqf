
dCRA_UNIT_UNIFORM_CIVILIAN = missionNamespace getVariable ["dCRA_UNIT_UNIFORM_CIVILIAN", CRA_UNIT_UNIFORM_CIVILIAN];
dCRA_UNIT_UNIFORM_MEDIC = missionNamespace getVariable ["dCRA_UNIT_UNIFORM_MEDIC", CRA_UNIT_UNIFORM_MEDIC];
dCRA_UNIT_UNIFORM_UTILITY = missionNamespace getVariable ["dCRA_UNIT_UNIFORM_UTILITY", CRA_UNIT_UNIFORM_UTILITY];
dCRA_UNIT_UNIFORM_LOOTER = missionNamespace getVariable ["dCRA_UNIT_UNIFORM_LOOTER", CRA_UNIT_UNIFORM_LOOTER];
dCRA_UNIT_UNIFORM_CARTEL = missionNamespace getVariable ["dCRA_UNIT_UNIFORM_CARTEL", CRA_UNIT_UNIFORM_CARTEL];
dCRA_UNIT_UNIFORM_ARMY = missionNamespace getVariable ["dCRA_UNIT_UNIFORM_ARMY", CRA_UNIT_UNIFORM_ARMY];
dCRA_UNIT_UNIFORM_ARMY_LEADER = missionNamespace getVariable ["dCRA_UNIT_UNIFORM_ARMY_LEADER", CRA_UNIT_UNIFORM_ARMY_LEADER];

dCRA_UNIT_INDEX = missionNamespace getVariable ["dCRA_UNIT_INDEX", CRA_UNIT_INDEX];

gRA_ItemIndex = missionNamespace getVariable ["gRA_ItemIndex", []];

CRA_ItemInit = {
	for "_i" from 1 to CRA_ITEM_COUNT do {gRA_ItemIndex pushBack [];};
	{
		_x params ["_index", "_categories", ["_steps", 0], ["_quality", []], ["_weights", []]];
		private _items = [_categories call CRQ_CatalogListAny, _quality, _weights] call CRQ_CatalogListQuality;
		gRA_ItemIndex set [_index, [_steps, _items] call CRQ_CatalogQualityMapGenerate];
	} forEach CRA_ITEM_CATEGORIES;
	{
		private _mag = gCQ_CatalogItem#_x;
		_mag set [4, 1 max ([CRQ_CDAT_MAG_COUNT, _mag#3] call CRQ_CatalogArrayData)];
	} forEach ([CRQ_CATALOG_THROW, CRQ_CATALOG_PUT, CRQ_CATALOG_MAGAZINE_HANDHELD] call CRQ_CatalogListAny);
	{
		private _weapon = gCQ_CatalogItem#_x;
		_weapon params ["", "_wpCat", "", "_wpData"];
		private _cfgIndex = CRA_WEAPON_CONFIGS findIf {_wpCat find (_x#0) != -1};
		_weapon set [4, [CRQ_CDAT_MAGAZINES, _wpData] call CRQ_CatalogArrayData];
		_weapon set [5, [CRQ_CDAT_ATTACHMENTS, _wpData] call CRQ_CatalogArrayData];
		_weapon set [6, if (_cfgIndex != -1) then {CRA_WEAPON_CONFIGS#_cfgIndex#1} else {CRA_WEAPON_CONFIG_DEFAULT}];
		_weapon set [7, [CRQ_CDAT_SLOT, _wpData] call CRQ_CatalogArrayData];
	} forEach ([CRQ_CATALOG_BINOCULAR,CRQ_CATALOG_WEAPON] call CRQ_CatalogListAny);
};
CRA_ItemQuality = {
	if (_this isEqualType -1) then {
		((0 max (1 min ((gRA_ProgressEquipment call CRQ_CatalogQualityRandom) + _this))) call CRQ_CatalogQualityBounds)
	} else {
		params [["_offset", 0], ["_lower", true], ["_upper", true]];
		([0 max (1 min ((gRA_ProgressEquipment call CRQ_CatalogQualityRandom) + _offset)), _lower, _upper] call CRQ_CatalogQualityBounds)
	};
};
CRA_ItemList = {
	params ["_types", ["_bounds", [0,1]]];
	private _items = [];
	while {true} do {
		{_items append ([_bounds, gRA_ItemIndex#_x] call CRQ_CatalogQualityMapItem);} forEach _types;
		if (_items isNotEqualTo [] || {(_bounds#0) == 0}) exitWith {};
		_bounds set [0, 0 max ((_bounds#0) - 0.0625)];
	};
	_items
};
CRA_ItemRandom = {
	private _items = _this call CRA_ItemList;
	if (_items isNotEqualTo []) then {selectRandom (_items)} else {-1};
};
CRA_ItemWeaponRasterize = {
	params ["_index", ["_loaded", true], ["_attached", true]];
	(gCQ_CatalogItem#_index) params ["_wpName", "", "", "", "_wpMag", "_wpAtt", "_wpCfg"];
	_wpMag params ["_wpPri", ["_wpSec", []]];
	
	private _rsAttach = [];
	private _attProb = (_wpCfg#0) call CRA_fnc_ItemFactorWeight;
	private _attQual = (_wpCfg#1) apply {_x call CRA_fnc_ItemFactorQuality};
	{
		if (random 1 < (_attProb#_forEachIndex)) then {
			private _attList = ([[_x], (_attQual#_forEachIndex) call CRA_ItemQuality] call CRA_ItemList) arrayIntersect (_wpAtt#_forEachIndex);
			_rsAttach pushBack (if (_attList isNotEqualTo []) then {gCQ_CatalogItem#(selectRandom _attList)#0} else {""});
		} else {
			_rsAttach pushback "";
		};
	} forEach [CRA_ITEM_MUZZLE, CRA_ITEM_LASER, CRA_ITEM_OPTIC, CRA_ITEM_BIPOD];
	
	private _rsWeapon = [_wpName];
	
	private _rsBipod = _rsAttach deleteAt 3;
	_rsWeapon append (if (_attached) then {_rsAttach} else {["", "", ""]});
	
	private _rsMag = [];
	{
		_x params ["_mgWeapon", "_mgConfig"];
		if (_mgWeapon isNotEqualTo [] && {_mgConfig isNotEqualTo []}) then {
			_mgConfig params ["_mgAlt", "_mgClips", "_mgTotal"];
			(gCQ_CatalogItem#(if (random 1 < _mgAlt) then {selectRandom _mgWeapon} else {_mgWeapon#0})) params ["_mgName", "", "", "", "_mgRounds"]; // TODO index guaranteed not -1?
			private _mgCount = (_mgClips#0) max ((_mgClips#1) min (round ((random _mgTotal) / _mgRounds))); // _mgRounds guaranteed to be >=1
			for "_i" from (if (_loaded && {_mgCount > 0}) then {_rsWeapon pushBack [_mgName, _mgRounds]; 2} else {_rsWeapon pushBack []; 1}) to _mgCount do {_rsMag pushBack [_mgName, _mgRounds];};
		} else {
			_rsWeapon pushBack [];
		};
	} forEach [[_wpPri, _wpCfg#2], [_wpSec, _wpCfg#3]];
	
	[[if (_attached) then {_rsWeapon pushBack _rsBipod; []} else {_rsWeapon pushBack ""; ((_rsAttach + [_rsBipod]) select {_x isNotEqualTo ""})}, _rsMag, [_rsWeapon]], []]
};
CRA_fnc_ItemFactorWeight = {
	_this apply {
		if (_x isEqualType -1) then {_x} else {
			if (_x isEqualType []) exitWith {(_x#0) + gRA_ProgressEquipment * ((_x#1) - (_x#0))};
			if (_x isEqualType {}) exitWith {gRA_ProgressEquipment call _x};
			0
		};
	}
};
CRA_fnc_ItemFactorQuality = {
	if (_this isEqualType -1) exitWith {_this};
	if (_this isEqualType []) exitWith {
		_this apply {
			if (_x isEqualType -1) then {_x} else {
				if (_x isEqualType false) exitWith {_x};
				if (_x isEqualType []) exitWith {(_x#0) + gRA_ProgressEquipment * ((_x#1) - (_x#0))};
				if (_x isEqualType {}) exitWith {gRA_ProgressEquipment call _x};
				_x
			};
		}
	};
	if (_this isEqualType {}) exitWith {gRA_ProgressEquipment call _this};
	_this
};
CRA_fnc_ItemSelectRandom = {
	if (_this isEqualTo []) exitWith {-1};
	[(_this#1), ((_this#0) call CRA_fnc_ItemFactorQuality) call CRA_ItemQuality] call CRA_ItemRandom
};
CRA_fnc_ItemSelectWeighted = {
	params ["_weights", "_items"];
	if (_weights isEqualTo []) exitWith {selectRandom _items};
	_items selectRandomWeighted (_weights call CRA_fnc_ItemFactorWeight)
};
CRA_fnc_ItemSelectionIndex = {
	if (_this isNotEqualTo []) then {(_this call CRA_fnc_ItemSelectWeighted) call CRA_fnc_ItemSelectRandom} else {-1};
};
CRA_fnc_ItemSelectionRasterized = {
	private _select = if (_this isNotEqualTo []) then {_this call CRA_fnc_ItemSelectWeighted} else {""};
	if (_select isEqualType "") then {
		_select
	} else {
		private _index = _select call CRA_fnc_ItemSelectRandom;
		if (_index != -1) exitWith {gCQ_CatalogItem#_index#0};
		""
	};
};
CRA_UnitGenerate = {
	private _weapons = [];
	while {true} do {
		(dCRA_UNIT_INDEX#_this#1) params ["_fallback", "_require"];
		_weapons = (dCRA_UNIT_INDEX#_this#2) apply {_x call CRA_fnc_ItemSelectionIndex};
		private _exit = true;
		{if (_x && {(_weapons#_forEachIndex) == -1}) exitWith {_exit = false;};} forEach _require;
		if (_exit) exitWith {};
		if (_fallback isEqualType []) exitWith {
			{
				if (_x isEqualType []) then {
					_weapons set [_forEachIndex, _x call CRA_fnc_ItemSelectionIndex];
				} else {
					if (_x) then {_weapons set [_forEachIndex, -1];};
				};
			} forEach _fallback;
		};
		_this = _fallback;
	};
	[dCRA_UNIT_INDEX#_this#0, [_this, _weapons] call CRA_UnitLoadoutGenerate]
};
CRA_UnitLoadoutGenerate = {
	params ["_type", "_weapons"];
	
	private _unData = dCRA_UNIT_INDEX#_type;
	_unData params ["", "", "", "_unUni", "_unVst", "_unBag", "_unHlm", "_unGls", "_unLnk"];
	
	private _loadout = [[],[],[]];
	{if (_x isNotEqualTo "") then {_loadout pushBack [_x, []];} else {_loadout pushBack [];};} forEach ([_unUni#0, _unVst#0, _unBag#0] apply {_x call CRA_fnc_ItemSelectionRasterized});
	{_loadout pushBack _x;} forEach ([_unHlm, _unGls] apply {_x call CRA_fnc_ItemSelectionRasterized});
	_loadout pushBack []; // binoculars
	_loadout pushBack (_unLnk apply {_x call CRA_fnc_ItemSelectionRasterized});
	
	{
		private _container = _loadout#_x;
		if (_container isNotEqualTo []) then {
			private _target = _container#1;
			private _source = _unData#_x;
			{
				private _num = floor (random ((_x#0) call CRA_fnc_ItemFactorWeight));
				for "_i" from 1 to _num do {
					private _item = (_x#1) call CRA_fnc_ItemSelectRandom;
					if (_item != -1) then {_target pushBack [gCQ_CatalogItem#_item#0, 1];};
				};
			} forEach (_source#1);
			{
				private _num = floor (random ((_x#0) call CRA_fnc_ItemFactorWeight));
				for "_i" from 1 to _num do {
					private _item = (_x#1) call CRA_fnc_ItemSelectRandom;
					if (_item != -1) then {private _mag = gCQ_CatalogItem#_item; _target pushBack [_mag#0, 1, _mag#4];}
				};
			} forEach (_source#2);
		};
	} forEach [3,4,5];
	
	private _weaponInventory = [[[],[],[]],[]];
	private _slots = [];
	{
		private _slot = gCQ_CatalogItem#_x#7;
		if (_slots find _slot == -1) then {
			_slots pushBack _slot;
			[_weaponInventory, [_x] call CRA_ItemWeaponRasterize] call CRQ_InventoryAppend;
		};
	} forEach (_weapons select {_x != -1});
	[_loadout, _weaponInventory] call CRQ_InventoryLoadoutAppend;
	
	_loadout
};
