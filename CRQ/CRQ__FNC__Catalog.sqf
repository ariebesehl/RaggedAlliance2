

CRQ_CatalogListAny = {
	if (_this isEqualType -1) then {_this = [_this];};
	private _indexes = [];
	{_indexes append (pCQ_CT_Category#_x);} forEach _this;
	(_indexes arrayIntersect _indexes)
};
CRQ_CatalogListMatching = {
	if (_this isEqualType -1) then {_this = [_this];};
	private _indexes = [];
	{if (_forEachIndex > 0) then {_indexes = _indexes arrayIntersect (pCQ_CT_Category#_x);} else {_indexes append (pCQ_CT_Category#_x);};} forEach _this;
	_indexes
};
CRQ_CatalogListQuality = {
	params ["_items", "_criteria", ["_weights", []]];
	if (_criteria isEqualType -1) then {_criteria = [_criteria];};
	if (_criteria isNotEqualTo [] && {_weights isEqualTo []}) then {
		private _factor = 1 / (count _criteria);
		_weights = _criteria apply {_factor};
	};
	private _list = [];
	{
		(pCQ_CT_Item#_x) params ["_itemName", "_itemCategory", "_itemQuality"];
		private _quality = 0;
		{
			private _index = _itemCategory find _x;
			if (_index != -1) then {_quality = _quality + (_weights#_forEachIndex) * (_itemQuality#_index);};
		} forEach _criteria;
		_list pushBack [_quality, _x];
	} forEach _items;
	_list sort true;
	_list
};
CRQ_CatalogFind = {
	if (_this isEqualType "") exitWith {(pCQ_CT_FindItem getOrDefault [toLowerANSI _this, [-1]])#0};
	params ["_name", ["_category", []]];
	private _result = pCQ_CT_FindItem getOrDefault [toLowerANSI _name, [-1]];
	if (_category isEqualTo []) exitWith {_result#0};
	private _filter = [];
	{if (_x != -1) then {private _match = count ((pCQ_CT_Item#_x#1) arrayIntersect _category); if (_match > 0) then {_filter pushBack [_match, _x];};};} forEach _result;
	if (_filter isNotEqualTo []) exitWith {_filter sort false; _filter#0#1};
	-1
	/*if (_category isEqualTo []) then {
		(pCQ_CT_Item findIf {_name == (_x#0)})
	} else {
		private _indexes = [];
		if (count _category > 1) then {
			{_indexes append (pCQ_CT_Category#_x);} forEach _category;
			_indexes = _indexes arrayIntersect _indexes;
		} else {
			_indexes = (pCQ_CT_Category#(_category#0));
		};
		private _found = _indexes findIf {_name == (pCQ_CT_Item#_x#0)};
		if (_found != -1) then {_indexes#_found} else {-1};
	};*/
};
CRQ_CatalogQualityRandom = {
	_this = 1.1 * _this + random 0.05;
	(_this - (random 0.1 * _this) - (random 1 * random 0.2 * _this) - (random 1 * random 1 * random 0.7 * _this))
};
CRQ_CatalogQualityBounds = {
	if (_this isEqualType -1) then {
		_this = 1 min (0 max _this);
		[_this / 2, (1 - _this) / 6 + _this]
	} else {
		params ["_base", ["_autoL", true], ["_autoH", true]];
		_base = 1 min (0 max _base);
		private _lower = if (_autoL isEqualType false) then {if (_autoL) then {_base / 2} else {0};} else {_autoL};
		private _upper = if (_autoH isEqualType false) then {if (_autoH) then {(1 - _base) / 6 + _base} else {1};} else {_autoH};
		[_lower, _upper]
	};
};
CRQ_CatalogQualityMapGenerate = {
	params ["_step", "_source"];
	if (_source isEqualTo []) exitWith {[[]]};
	private _items = _source apply {_x#1};
	if (_step < 1) exitWith {[_items]};
	private _quality = _source apply {(_x#0) * _step};
	private _map = [];
	private _index = 0;
	private _count = count _quality;
	for "_level" from 0 to _step do {
		for "_i" from _index to _count do {
			if (_i == _count) exitWith {_index = _count;};
			if ((_quality#_i) >= _level) exitWith {_index = _i;};
		};
		_map pushBack _index;
	};
	[_items, _step, _map]
};
CRQ_CatalogQualityMapItem = {
	(_this#1) params [["_items", []], ["_step", 0], ["_map", []]];
	if (_step == 0 || {_items isEqualTo []}) exitWith {_items};
	(_this#0) params ["_boundLow", "_boundHigh"];
	private _lower = _step * (1 min (0 max _boundLow));
	private _upper = _step * (1 min (0 max _boundHigh));
	private _index = _map#_lower;
	private _length = (_map#_upper) - _index;
	_items select [_index, _length];
};
CRQ_CatalogDataItem = {
	params ["_index", "_attribute"];
	([_attribute, pCQ_CT_Item#_index#3] call CRQ_CatalogArrayData)
};
CRQ_CatalogArrayData = {
	params ["_attribute", ["_data", []]];
	private _index = _data findIf {_attribute == (_x#0)};
	if (_index != -1) then {_data#_index#1} else {dCRQ_CDAT_DEFAULTS#_attribute};
};
CRQ_CatalogRegister = {
	pCQ_CT_CounterItem = pCQ_CT_CounterItem + 1;
	
	pCQ_CT_Item pushBack _this;
	{(pCQ_CT_Category#_x) pushBack pCQ_CT_CounterItem;} forEach (_this#1);
	
	private _name = toLowerANSI (_this#0);
	pCQ_CT_FindItem set [_name, (pCQ_CT_FindItem getOrDefault [_name, []]) + [pCQ_CT_CounterItem], false];
	
	pCQ_CT_CounterItem
};

CRQ_CatalogQualityData = {
	params ["_attribute", ["_data", []], ["_default", nil]];
	private _index = _data findIf {_attribute == (_x#0)};
	if (_index != -1) then {_data#_index#1} else {if (isNil {_default}) then {dCRQ_QDAT_DEFAULTS#_attribute} else {_default}};
};
CRQ_CatalogQualityInit = {
	for "_i" from 0 to (CRQ_CATALOG_CATEGORIES - 1) do {
		/*private _defined = dCQM_QUALITY_PARAMS findIf {_i == (_x#0)};
		if (_defined != -1) then {
			pCQ_CT_QualityParams pushBack (dCQM_QUALITY_PARAMS#_defined#1);
		} else {
			pCQ_CT_QualityParams pushBack [];
		};*/
		pCQ_CT_QualityParams pushBack (dCQM_QUALITY_PARAMS getOrDefault [_i, []]);
	};
};
CRQ_CatalogQualityCalculate = {
	{
		_x params ["_itemName", "_itemCategory", "_itemQuality", "_itemData"];
		if (count _itemCategory != count _itemQuality) then {_x set [2, [_itemCategory, _itemData] call CRQ_CatalogQualityAnalysis];};
	} forEach pCQ_CT_Item;
};
CRQ_CatalogQualityAnalysis = {
	params ["_itemCategory", "_itemData"];
	private _itemQuality = [];
	private _crossReference = [];
	{
		private _categoryQuality = 0;
		private _categoryParams = pCQ_CT_QualityParams#_x;//_x call CRQ_CatalogQualityCategory;
		if (_categoryParams isNotEqualTo []) then {
			private _qualityXref = [CRQ_QDAT_XREF, _categoryParams] call CRQ_CatalogQualityData;
			if (_qualityXref isNotEqualTo []) exitWith {
				private _currentIndex = _forEachIndex;
				{
					private _sourceCategory = _x;
					private _sourceIndex = _itemCategory find _sourceCategory;
					if (_sourceIndex != -1 && {_sourceIndex != _currentIndex}) exitWith {
						if (_sourceIndex < _currentIndex && {_crossReference findIf {_sourceCategory == (_itemCategory#(_x#0))} == -1}) exitWith {
							_categoryQuality = _itemQuality#_sourceIndex;
						};
						_crossReference pushBack [_currentIndex, _sourceIndex];
					};
				} forEach _qualityXref;
			};
			private _quality = 0;
			private _qualityAttr = [CRQ_QDAT_ATTR, _categoryParams] call CRQ_CatalogQualityData;
			{
				private _attrWSB = [CRQ_QDAT_WSB, _x] call CRQ_CatalogQualityData;
				private _attrQuality = 0;
				private _attrSource = if (_attrWSB isNotEqualTo []) then {_attrWSB#1} else {[CRQ_QDAT_SOURCE, _x] call CRQ_CatalogQualityData};
				private "_attrInput";
				switch (true) do {
					case (_attrSource isEqualType -1): {_attrInput = if (_attrSource != -1) then {[_attrSource, _itemData] call CRQ_CatalogArrayData} else {0};};
					case (_attrSource isEqualType []): {_attrInput = []; {_attrInput pushBack ([_x, _itemData] call CRQ_CatalogArrayData);} forEach _attrSource;};
					case (_attrSource isEqualType {}): {_attrInput = _itemData call _attrSource;};
					default {_attrInput = 0;};
				};
				private _attrBase = if (_attrWSB isNotEqualTo []) then {_attrWSB#2} else {[CRQ_QDAT_BASE, _x] call CRQ_CatalogQualityData};
				if (_attrBase isEqualType {}) then {
					_attrQuality = _attrInput call _attrBase;
				} else {
					private _attrMode = [CRQ_QDAT_MODE, _x] call CRQ_CatalogQualityData;
					switch (_attrMode) do {
						case CRQ_QMOD_SCALAR: {
							private _attrValue = 0;
							switch (true) do {
								case (_attrInput isEqualType false): {_attrValue = if (_attrInput) then {1} else {0};};
								case (_attrInput isEqualType -1): {_attrValue = _attrInput;};
								default {};
							};
							switch (true) do {
								case (_attrBase isEqualType -1): {_attrQuality = _attrValue / _attrBase;};
								case (_attrBase isEqualType []): {_attrQuality = (_attrValue - (_attrBase#0)) / ((_attrBase#1) - (_attrBase#0));};
								default {};
							};
						};
						case CRQ_QMOD_BITFLAG: {
							private _attrValue = [];
							switch (true) do {
								case (_attrInput isEqualType -1): {_attrValue = _attrInput call CRQ_fnc_ByteDecode;};
								case (_attrInput isEqualType []): {_attrValue = _attrInput;};
								default {};
							};
							switch (true) do {
								case (_attrBase isEqualType -1): {
									private _bitWeights = _attrBase call CRQ_fnc_ByteDecode;
									private _bitSum = _bitWeights call CRQ_fnc_ByteSum;
									if (_bitSum == 0) exitWith {};
									{
										private _bit = _attrValue#_forEachIndex;
										if (isNil {_bit}) exitWith {};
										if (_bit && {_x}) then {_attrQuality = _attrQuality + 1;};
									} forEach _bitWeights;
									_attrQuality = _attrQuality / _bitSum;
								};
								case (_attrBase isEqualType []): {
									{
										private _bit = _attrValue#_forEachIndex;
										if (isNil {_bit}) exitWith {};
										if (_bit) then {_attrQuality = _attrQuality + _x;};
									} forEach _attrBase;
								};
								default {};
							};
						};
						default {};
					};
				};
				private _attrClamp = [CRQ_QDAT_CLAMP, _x] call CRQ_CatalogQualityData;
				if (_attrClamp isNotEqualTo []) then {
					if (_attrQuality < (_attrClamp#0)) exitWith {_attrQuality = (_attrClamp#0);};
					if (_attrQuality > (_attrClamp#1)) exitWith {_attrQuality = (_attrClamp#1);};
				};
				private _attrWeight = if (_attrWSB isNotEqualTo []) then {_attrWSB#0} else {[CRQ_QDAT_WEIGHT, _x] call CRQ_CatalogQualityData};
				_quality = _quality + _attrWeight * _attrQuality;
			} forEach _qualityAttr;
			private _qualityBase = [CRQ_QDAT_BASE, _categoryParams] call CRQ_CatalogQualityData;
			if (_qualityBase isEqualType {}) then {
				_categoryQuality = _quality call _qualityBase;
			} else {
				if (_qualityBase isEqualType -1) then {_qualityBase = [0, _qualityBase];};
				private _qualityMode = [CRQ_QDAT_MODE, _categoryParams] call CRQ_CatalogQualityData;
				switch (_qualityMode) do {
					case CRQ_QMOD_LINEAR: {_categoryQuality = (_qualityBase#0) + _quality * ((_qualityBase#1) - (_qualityBase#0));};
					case CRQ_QMOD_ALT: {_categoryQuality = (((_qualityBase#1) + (_qualityBase#0)) / 2) + (((_qualityBase#1) - (_qualityBase#0)) * 2 * (_quality - 1));};
					default {};
				};
			};
			private _qualityClamp = [CRQ_QDAT_CLAMP, _categoryParams, [0,1]] call CRQ_CatalogQualityData;
			if (_qualityClamp isNotEqualTo []) then {
				if (_categoryQuality < (_qualityClamp#0)) exitWith {_categoryQuality = (_qualityClamp#0);};
				if (_categoryQuality > (_qualityClamp#1)) exitWith {_categoryQuality = (_qualityClamp#1);};
			};
		};
		_itemQuality pushBack _categoryQuality;
	} forEach _itemCategory;
	while {_crossReference isNotEqualTo []} do {
		private _available = [];
		private _pending = [];
		{
			private _sourceCategory = _itemCategory#(_x#1);
			private _index = _crossReference findIf {_sourceCategory == (_itemCategory#(_x#0))};
			if (_index != -1) then {_pending pushBack _x;} else {_available pushBack _x;};
		} forEach _crossReference;
		if (_available isEqualTo []) exitWith {}; // else infinite loop
		{_itemQuality set [_x#0, _itemQuality#(_x#1)];} forEach _available;
		_crossReference = _pending;
	};
	_itemQuality
};
CRQ_CatalogInit = {
	params ["_identity", ["_items", false]];
	
	for "_i" from 1 to CRQ_CATALOG_CATEGORIES do {pCQ_CT_Category pushBack [];};
	
	if (_identity) then {[] call CRQ_CatalogIdentityInit;};
	missionNamespace setVariable ["pCQ_CT_Client", pCQ_CT_Item apply {[_x#0]}, true];
	
	[] call CRQ_CatalogQualityInit;
	
	private _firstaid = [];
	private _medkit = [];
	private _toolkit = [];
	private _minedetector = [];
	private _gps = [];
	private _map = [];
	private _compass = [];
	private _radio = [];
	private _watch = [];
	private _nightvision = [];
	private _terminal = [];
	private _binocular = [];
	private _throw = [];
	private _put = [];
	private _weapons = [];
	private _glasses = ("getNumber (_x >> 'scope') == 2" configClasses pCQ_CFG_Glasses);
	private _helmets = [];
	private _vests = [];
	private _backpacks = [];
	private _vehicles = [];
	{
		switch (getNumber (_x >> "type")) do {
			case CRQ_BITYPE_RIFLE;
			case CRQ_BITYPE_PISTOL;
			case CRQ_BITYPE_LAUNCHER: {
				private _base = _x call CRQ_ConfigWeaponBase;
				if (_weapons find _base == -1) then {_weapons pushBack _base;};
			};
			case CRQ_BITYPE_BINOCULAR: {
				switch (toLowerANSI (getText (_x >> "simulation"))) do {
					case "weapon"; // laser designator
					case "binocular": {_binocular pushBack _x;};
					case "nvgoggles": {_nightvision pushBack _x;};
					default {};
				};
			};
			case CRQ_BITYPE_ITEM: {
				switch (getNumber (_x >> "ItemInfo" >> "type")) do {
					case CRQ_BITYPE_FIRSTAID: {_firstaid pushBack _x;};
					case CRQ_BITYPE_HELMET: {_helmets pushBack _x;};
					case CRQ_BITYPE_MEDIKIT: {_medkit pushBack _x;};
					case CRQ_BITYPE_TOOLKIT: {_toolkit pushBack _x;};
					case CRQ_BITYPE_TERMINAL: {_terminal pushBack _x;};
					case CRQ_BITYPE_VEST: {_vests pushBack _x;};
					default {
						switch (toLowerANSI (getText (_x >> "simulation"))) do {
							case "itemwatch": {_watch pushBack _x;};
							case "itemgps": {_gps pushBack _x;};
							case "itemmap": {_map pushBack _x;};
							case "itemcompass": {_compass pushBack _x;};
							case "itemradio": {_radio pushBack _x;};
							case "itemminedetector": {_minedetector pushBack _x;};
							default {};
						};
					};
				};
			};
			default {};
		};
	} forEach ("getNumber (_x >> 'scope') == 2" configClasses pCQ_CFG_Weapons);
	{
		_x params ["_source", "_target"];
		{
			{
				private _config = pCQ_CFG_Magazines >> _x;
				if (getNumber (_config >> "scope") == 2) then {_target pushBack _config;};
			} forEach (getArray (_source >> _x >> "magazines"))
		} forEach (getArray (_source >> "muzzles"));
	} forEach [[pCQ_CFG_WeaponThrow, _throw], [pCQ_CFG_WeaponPut, _put]];
	private _vehicleClasses = CRQ_CLASS_VEHICLE + ["StaticWeapon"];
	{
		if (getNumber (_x >> "isBackpack") > 0) then {
			_backpacks pushBack _x;
		} else {
			private _config = _x;
			private _name = configName _x;
			{if (_name isKindOf _x) exitWith {_vehicles pushBack _config;};} forEach _vehicleClasses;
		};
	} forEach ("getNumber (_x >> 'scope') == 2" configClasses pCQ_CFG_Vehicles);
	
	_firstaid call CRQ_CatalogFirstAidInit;
	_medkit call CRQ_CatalogMedkitInit;
	_toolkit call CRQ_CatalogToolkitInit;
	_minedetector call CRQ_CatalogMineDetectorInit;
	_gps call CRQ_CatalogGPSInit;
	_map call CRQ_CatalogMapInit;
	_compass call CRQ_CatalogCompassInit;
	_radio call CRQ_CatalogRadioInit;
	_watch call CRQ_CatalogWatchInit;
	_nightvision call CRQ_CatalogNVGInit;
	_terminal call CRQ_CatalogTerminalInit;
	_binocular call CRQ_CatalogBinocularInit;
	_throw call CRQ_CatalogThrowInit;
	_put call CRQ_CatalogPutInit;
	_weapons call CRQ_CatalogWeaponInit;
	_glasses call CRQ_CatalogGlassesInit;
	_helmets call CRQ_CatalogHelmetInit;
	_vests call CRQ_CatalogVestInit;
	_backpacks call CRQ_CatalogBackpackInit;
	
	_vehicles call CRQ_CatalogAssetInit;
	
	[] call CRQ_CatalogQualityCalculate;
	
};
CRQ_CatalogIdentityInit = {
	{
		private _category = ([[CRQ_CATALOG_ID_NAME_HOSTILE],[CRQ_CATALOG_ID_NAME_NEUTRAL],[CRQ_CATALOG_ID_NAME_FRIENDLY]]#_forEachIndex) + [CRQ_CATALOG_ID_NAME];
		{[_x, _category, [], []] call CRQ_CatalogRegister;} forEach _x;
	} forEach CQM_IDENTITY_NAMES;
	{
		private _name = (configName _x);
		if (CQM_IDENTITY_FACE_EXCLUDE findIf {_name == _x} == -1) then {[_name, [CRQ_CATALOG_ID_FACE], [], []] call CRQ_CatalogRegister;};
	} forEach ("getNumber (_x >> 'disabled') == 0" configClasses (configfile >> "CfgFaces" >> "Man_A3"));
	{
		private _name = (configName _x);
		if (CQM_IDENTITY_VOICE_EXCLUDE findIf {_name == _x} == -1) then {[_name, [CRQ_CATALOG_ID_VOICE], [], []] call CRQ_CatalogRegister;};
	} forEach ("getNumber (_x >> 'scope') == 2" configClasses (configfile >> "CfgVoice"));
};
CRQ_CatalogIdentityGenerate = {
	private _name = [CRQ_CATALOG_ID_NAME_HOSTILE,CRQ_CATALOG_ID_NAME_NEUTRAL,CRQ_CATALOG_ID_NAME_FRIENDLY,CRQ_CATALOG_ID_NAME]#_this;
	[selectRandom (pCQ_CT_Category#_name), selectRandom (pCQ_CT_Category#CRQ_CATALOG_ID_FACE), selectRandom (pCQ_CT_Category#CRQ_CATALOG_ID_VOICE), CQM_IDENTITY_PITCH_MIN + random CQM_IDENTITY_PITCH_VARIANCE];
};
CRQ_CatalogIdentityRetrieve = {
	private _identity = [];
	_identity pushBack ((name _this) call CRQ_CatalogFind);
	_identity pushBack ((face _this) call CRQ_CatalogFind);
	_identity pushBack ((speaker _this) call CRQ_CatalogFind);
	_identity pushBack (pitch _this);
	_identity
};
CRQ_CatalogIdentityApply = {
	_this remoteExec ["CRQ_CatalogIdentityBroadcast", gCS_MP_Broadcast];
};
CRQ_CatalogIdentityBroadcast = {
	params ["_unit", "_identity"];
	_identity params ["_name", "_face", "_voice", "_pitch"];
	private _rasterized = [];
	_rasterized pushBack (if (_face != -1) then {(pCQ_CT_Client#_face#0)} else {""});
	_rasterized pushBack (if (_voice != -1) then {(pCQ_CT_Client#_voice#0)} else {""});
	_rasterized pushBack (if (_name != -1) then {[(pCQ_CT_Client#_name#0), "", ""]} else {["", "", ""]});
	_rasterized pushBack "";
	_rasterized pushBack _pitch;
	[_unit, _rasterized] call CRQ_IdentityApply;
};
CRQ_CatalogFirstAidInit = {
	{
		private _name = configName _x;
		private _categories = [];
		if (CQM_ITEM_FIRSTAID_EXCLUDE findIf {_name == _x} == -1 && {_categories isEqualTo [] || {CQM_ITEM_FIRSTAID_INCLUDE findIf {_name == _x} != -1}}) then {
			_categories pushBack CRQ_CATALOG_FIRSTAID;
		};
		if (_categories isNotEqualTo []) then {
			[_name, _categories, [], []] call CRQ_CatalogRegister;
		} else {
			[_name, [CRQ_CATALOG_NONE], [], []] call CRQ_CatalogRegister;
		};
	} forEach _this;
};
CRQ_CatalogMedkitInit = {
	{
		private _name = configName _x;
		private _categories = [];
		if (CQM_ITEM_MEDKIT_EXCLUDE findIf {_name == _x} == -1 && {_categories isEqualTo [] || {CQM_ITEM_MEDKIT_INCLUDE findIf {_name == _x} != -1}}) then {
			_categories pushBack CRQ_CATALOG_MEDKIT;
		};
		if (_categories isNotEqualTo []) then {
			[_name, _categories, [], []] call CRQ_CatalogRegister;
		} else {
			[_name, [CRQ_CATALOG_NONE], [], []] call CRQ_CatalogRegister;
		};
	} forEach _this;
};
CRQ_CatalogToolkitInit = {
	{
		private _name = configName _x;
		private _categories = [];
		if (CQM_ITEM_TOOLKIT_EXCLUDE findIf {_name == _x} == -1 && {_categories isEqualTo [] || {CQM_ITEM_TOOLKIT_INCLUDE findIf {_name == _x} != -1}}) then {
			_categories pushBack CRQ_CATALOG_TOOLKIT;
		};
		if (_categories isNotEqualTo []) then {
			[_name, _categories, [], []] call CRQ_CatalogRegister;
		} else {
			[_name, [CRQ_CATALOG_NONE], [], []] call CRQ_CatalogRegister;
		};
	} forEach _this;
};
CRQ_CatalogMineDetectorInit = {
	{
		private _name = configName _x;
		private _categories = [];
		if (CQM_ITEM_MINE_DETECTOR_EXCLUDE findIf {_name == _x} == -1 && {_categories isEqualTo [] || {CQM_ITEM_MINE_DETECTOR_INCLUDE findIf {_name == _x} != -1}}) then {
			_categories pushBack CRQ_CATALOG_MINE_DETECTOR;
		};
		if (_categories isNotEqualTo []) then {
			[_name, _categories, [], []] call CRQ_CatalogRegister;
		} else {
			[_name, [CRQ_CATALOG_NONE], [], []] call CRQ_CatalogRegister;
		};
	} forEach _this;
};
CRQ_CatalogGPSInit = {
	{
		private _name = configName _x;
		private _categories = [];
		if (CQM_ITEM_GPS_EXCLUDE findIf {_name == _x} == -1 && {_categories isEqualTo [] || {CQM_ITEM_GPS_INCLUDE findIf {_name == _x} != -1}}) then {
			_categories pushBack CRQ_CATALOG_GPS;
		};
		if (_categories isNotEqualTo []) then {
			[_name, _categories, [], []] call CRQ_CatalogRegister;
		} else {
			[_name, [CRQ_CATALOG_NONE], [], []] call CRQ_CatalogRegister;
		};
	} forEach _this;
};
CRQ_CatalogMapInit = {
	{
		private _name = configName _x;
		private _categories = [];
		if (CQM_ITEM_MAP_EXCLUDE findIf {_name == _x} == -1 && {_categories isEqualTo [] || {CQM_ITEM_MAP_INCLUDE findIf {_name == _x} != -1}}) then {
			_categories pushBack CRQ_CATALOG_MAP;
		};
		if (_categories isNotEqualTo []) then {
			[_name, _categories, [], []] call CRQ_CatalogRegister;
		} else {
			[_name, [CRQ_CATALOG_NONE], [], []] call CRQ_CatalogRegister;
		};
	} forEach _this;
};
CRQ_CatalogCompassInit = {
	{
		private _name = configName _x;
		private _categories = [];
		if (CQM_ITEM_COMPASS_EXCLUDE findIf {_name == _x} == -1 && {_categories isEqualTo [] || {CQM_ITEM_COMPASS_INCLUDE findIf {_name == _x} != -1}}) then {
			_categories pushBack CRQ_CATALOG_COMPASS;
		};
		if (_categories isNotEqualTo []) then {
			[_name, _categories, [], []] call CRQ_CatalogRegister;
		} else {
			[_name, [CRQ_CATALOG_NONE], [], []] call CRQ_CatalogRegister;
		};
	} forEach _this;
};
CRQ_CatalogRadioInit = {
	{
		private _name = configName _x;
		private _categories = [];
		if (CQM_ITEM_RADIO_EXCLUDE findIf {_name == _x} == -1 && {_categories isEqualTo [] || {CQM_ITEM_RADIO_INCLUDE findIf {_name == _x} != -1}}) then {
			_categories pushBack CRQ_CATALOG_RADIO;
		};
		if (_categories isNotEqualTo []) then {
			[_name, _categories, [], []] call CRQ_CatalogRegister;
		} else {
			[_name, [CRQ_CATALOG_NONE], [], []] call CRQ_CatalogRegister;
		};
	} forEach _this;
};
CRQ_CatalogWatchInit = {
	{
		private _name = configName _x;
		private _categories = [];
		if (CQM_ITEM_WATCH_CBRN findIf {_name == _x} != -1) then {_categories pushBack CRQ_CATALOG_WATCH_CBRN;};
		if (CQM_ITEM_WATCH_EXCLUDE findIf {_name == _x} == -1 && {_categories isEqualTo [] || {CQM_ITEM_WATCH_INCLUDE findIf {_name == _x} != -1}}) then {
			_categories pushBack CRQ_CATALOG_WATCH_BASIC;
		};
		if (_categories isNotEqualTo []) then {
		_categories pushBack CRQ_CATALOG_WATCH;
			[_name, _categories, [], []] call CRQ_CatalogRegister;
		} else {
			[_name, [CRQ_CATALOG_NONE], [], []] call CRQ_CatalogRegister;
		};
	} forEach _this;
};
CRQ_CatalogNVGInit = {
	{
		private _name = configName _x;
		private _data = _x call CRQ_CatalogNVGAnalysis;
		private _categories = [];
		if (CQM_ITEM_NVG_EXCLUDE findIf {_name == _x} == -1 && {_categories isEqualTo [] || {CQM_ITEM_NVG_INCLUDE findIf {_name == _x} != -1}}) then {
			(([CRQ_CDAT_VISION_MODE, _data] call CRQ_CatalogArrayData) call CRQ_fnc_ByteDecode) params [["_hasNormal", false], ["_hasNVG", false], ["_hasTI", false]];
			if (!_hasNVG) exitWith {};
			if (_hasTI) exitWith {_categories pushBack CRQ_CATALOG_NVG_THERMAL};
			_categories pushBack CRQ_CATALOG_NVG_BASIC;
		};
		if (_categories isNotEqualTo []) then {
			_categories pushBack CRQ_CATALOG_NVG;
			[_name, _categories, [], _data] call CRQ_CatalogRegister;
		} else {
			[_name, [CRQ_CATALOG_NVG_OTHER,CRQ_CATALOG_NONE], [], _data] call CRQ_CatalogRegister;
		};
	} forEach _this;
};
CRQ_CatalogBinocularInit = {
	{
		private _name = configName _x;
		private _data = _x call CRQ_CatalogBinocularAnalysis;
		private _categories = [];
		if (CQM_ITEM_BINOCULAR_EXCLUDE findIf {_name == _x} == -1 && {_categories isEqualTo [] || {CQM_ITEM_BINOCULAR_INCLUDE findIf {_name == _x} != -1}}) then {
			if ([CRQ_CDAT_LASER, _data] call CRQ_CatalogArrayData) exitWith {_categories pushBack CRQ_CATALOG_BINOCULAR_LASER;};
			if ([CRQ_CDAT_RANGEFINDER, _data] call CRQ_CatalogArrayData) exitWith {_categories pushBack CRQ_CATALOG_BINOCULAR_RANGE;};
			_categories pushBack CRQ_CATALOG_BINOCULAR_BASIC;
		};
		if (_categories isNotEqualTo []) then {
			_categories pushBack CRQ_CATALOG_BINOCULAR;
			[_name, _categories, [], _data] call CRQ_CatalogRegister;
		} else {
			[_name, [CRQ_CATALOG_BINOCULAR_OTHER,CRQ_CATALOG_NONE], [], _data] call CRQ_CatalogRegister;
		};
	} forEach _this;
};
CRQ_CatalogTerminalInit = {
	{
		private _name = configName _x;
		private _data = _x call CRQ_CatalogTerminalAnalysis;
		private _categories = [];
		if (CQM_ITEM_TERMINAL_EXCLUDE findIf {_name == _x} == -1 && {_categories isEqualTo [] || {CQM_ITEM_TERMINAL_INCLUDE findIf {_name == _x} != -1}}) then {
			switch ([CRQ_CDAT_SIDE, _data] call CRQ_CatalogArrayData) do {
				case CRQ_SD_BLU: {_categories pushBack CRQ_CATALOG_TERMINAL_BLUFOR;};
				case CRQ_SD_IND: {_categories pushBack CRQ_CATALOG_TERMINAL_OPFOR;};
				case CRQ_SD_OPF: {_categories pushBack CRQ_CATALOG_TERMINAL_IDFOR;};
				case CRQ_SD_CIV: {_categories pushBack CRQ_CATALOG_TERMINAL_CIVFOR;};
				default {};
			};
		};
		if (_categories isNotEqualTo []) then {
			_categories pushBack CRQ_CATALOG_TERMINAL;
			[_name, _categories, [], _data] call CRQ_CatalogRegister;
		} else {
			[_name, [CRQ_CATALOG_TERMINAL_OTHER,CRQ_CATALOG_NONE], [], _data] call CRQ_CatalogRegister;
		};
	} forEach _this;
};
CRQ_CatalogThrowInit = {
	{
		private _name = configName _x;
		private _categories = [];
		private _data = _x call CRQ_CatalogMagazineAnalysis;
		if (CQM_ITEM_THROW_EXCLUDE findIf {_name == _x} == -1 && {_categories isEqualTo [] || {CQM_ITEM_THROW_INCLUDE findIf {_name == _x} != -1}}) then {
			([_data] call CRQ_CatalogUtilThrowType) params ["_thCategories", "_thParam"];
			_categories append _thCategories;
			_data append _thParam;
		};
		if (_categories isNotEqualTo []) then {
			_categories pushBack CRQ_CATALOG_THROW;
			[_name, _categories, [], _data] call CRQ_CatalogRegister;
		} else {
			[_name, [CRQ_CATALOG_THROW_OTHER,CRQ_CATALOG_NONE], [], _data] call CRQ_CatalogRegister;
		};
	} forEach _this;
};
CRQ_CatalogPutInit = {
	{
		private _name = configName _x;
		private _categories = [];
		private _data = _x call CRQ_CatalogMagazineAnalysis;
		if (CQM_ITEM_PUT_EXCLUDE findIf {_name == _x} == -1 && {_categories isEqualTo [] || {CQM_ITEM_PUT_INCLUDE findIf {_name == _x} != -1}}) then {
			([_data] call CRQ_CatalogUtilPutType) params ["_putCategories", "_putParam"];
			_categories append _putCategories;
			_data append _putParam;
		};
		if (_categories isNotEqualTo []) then {
			_categories pushBack CRQ_CATALOG_PUT;
			[_name, _categories, [], _data] call CRQ_CatalogRegister;
		} else {
			[_name, [CRQ_CATALOG_PUT_OTHER,CRQ_CATALOG_NONE], [], _data] call CRQ_CatalogRegister;
		};
	} forEach _this;
};
CRQ_CatalogBackpackInit = {
	private _counter = 0;
	private _bags = [];
	private _bagBases = [];
	{
		private _name = (configName _x);
		private _data = _x call CRQ_CatalogBackpackAnalysis;
		private _categories = [];
		if (CQM_ITEM_BACKPACK_CIVILIAN findIf {_name == _x} != -1) then {_categories pushBack CRQ_CATALOG_BACKPACK_CIVILIAN;};
		if (CQM_ITEM_BACKPACK_MEDIC findIf {_name == _x} != -1) then {_categories pushBack CRQ_CATALOG_BACKPACK_MEDIC;};
		if (CQM_ITEM_BACKPACK_UTILITY findIf {_name == _x} != -1) then {_categories pushBack CRQ_CATALOG_BACKPACK_UTILITY;};
		if (CQM_ITEM_BACKPACK_PRESS findIf {_name == _x} != -1) then {_categories pushBack CRQ_CATALOG_BACKPACK_PRESS;};
		if (CQM_ITEM_BACKPACK_POLICE findIf {_name == _x} != -1) then {_categories pushBack CRQ_CATALOG_BACKPACK_POLICE;};
		if (CQM_ITEM_BACKPACK_CBRN findIf {_name == _x} != -1) then {_categories pushBack CRQ_CATALOG_BACKPACK_CBRN;};
		if (CQM_ITEM_BACKPACK_RADIO findIf {_name == _x} != -1) then {_categories pushBack CRQ_CATALOG_BACKPACK_RADIO;};
		if (CQM_ITEM_BACKPACK_EXCLUDE findIf {_name == _x} == -1 && {_categories isEqualTo [] || {CQM_ITEM_BACKPACK_INCLUDE findIf {_name == _x} != -1}}) then {
			if ([CRQ_CDAT_PARACHUTE, _data] call CRQ_CatalogArrayData) exitWith {_categories pushBack CRQ_CATALOG_BACKPACK_PARACHUTE;};
			if (([CRQ_CDAT_ASM_TARGET, _data] call CRQ_CatalogArrayData) isNotEqualTo "") exitWith {_categories pushBack CRQ_CATALOG_BACKPACK_ASSEMBLY_MAIN;};
			private _load = [CRQ_CDAT_LOAD, _data] call CRQ_CatalogArrayData;
			if (_load <= 0) exitWith {};
			if (_load >= (CQM_ITEM_BACKPACK_S#0) && {_load <= (CQM_ITEM_BACKPACK_S#1)}) then {_categories pushBack CRQ_CATALOG_BACKPACK_S;};
			if (_load >= (CQM_ITEM_BACKPACK_M#0) && {_load <= (CQM_ITEM_BACKPACK_M#1)}) then {_categories pushBack CRQ_CATALOG_BACKPACK_M;};
			if (_load >= (CQM_ITEM_BACKPACK_L#0) && {_load <= (CQM_ITEM_BACKPACK_L#1)}) then {_categories pushBack CRQ_CATALOG_BACKPACK_L;};
		};
		if (_categories isNotEqualTo []) then {
			_categories pushBack CRQ_CATALOG_BACKPACK;
			_bags pushBack [_name, _categories, [], _data];
			private _asmBase = [CRQ_CDAT_ASM_BASE, _data] call CRQ_CatalogArrayData;
			if (_asmBase isNotEqualTo []) then {_bagBases append _asmBase;};
		} else {
			_bags pushBack [_name, [CRQ_CATALOG_BACKPACK_OTHER,CRQ_CATALOG_NONE], [], _data]
		};
		_counter = _counter + 1;
	} forEach _this;
	_bagBases = _bagBases arrayIntersect _bagBases;
	{
		private _name = _x;
		private _index = _bags findIf {_name == (_x#0)};
		if (_index != -1) then {
			private _categories = [CRQ_CATALOG_BACKPACK_ASSEMBLY_BASE,CRQ_CATALOG_BACKPACK];
			{if ([CRQ_CATALOG_BACKPACK_OTHER,CRQ_CATALOG_NONE] find _x == -1) then {_categories pushBack _x;};} forEach (_bags#_index#1);
			(_bags#_index) set [1, _categories];
		} else {
			// should not occur
		};
	} forEach _bagBases;
	private _indexAsmMain = [];
	private _indexAsmBase = [];
	{
		_x params ["_name", "_type", "_quality", "_data"];
		private _index = _x call CRQ_CatalogRegister;
		if (([CRQ_CDAT_ASM_BASE, _data] call CRQ_CatalogArrayData) isNotEqualTo []) then {_indexAsmMain pushBack _index;};
		if (_bagBases findIf {_name == _x} != -1) then {_indexAsmBase pushBack [_name, _index];};
	} forEach _bags;
	{
		private _data = [_x, CRQ_CDAT_ASM_BASE] call CRQ_CatalogDataItem;
		{
			private _name = _x;
			private _index = _indexAsmBase findIf {_name == (_x#0)};
			if (_index != -1) then {_data set [_forEachIndex, _indexAsmBase#_index#1];};
		} forEach _data;
	} forEach _indexAsmMain;
};
CRQ_CatalogVestInit = {
	{
		private _name = (configName _x);
		private _data = _x call CRQ_CatalogVestAnalysis;
		private _categories = [];
		if (CQM_ITEM_VEST_CIVILIAN findIf {_name == _x} != -1) then {_categories pushBack CRQ_CATALOG_VEST_CIVILIAN;};
		if (CQM_ITEM_VEST_MEDIC findIf {_name == _x} != -1) then {_categories pushBack CRQ_CATALOG_VEST_MEDIC;};
		if (CQM_ITEM_VEST_UTILITY findIf {_name == _x} != -1) then {_categories pushBack CRQ_CATALOG_VEST_UTILITY;};
		if (CQM_ITEM_VEST_PRESS findIf {_name == _x} != -1) then {_categories pushBack CRQ_CATALOG_VEST_PRESS;};
		if (CQM_ITEM_VEST_POLICE findIf {_name == _x} != -1) then {_categories pushBack CRQ_CATALOG_VEST_POLICE;};
		if (CQM_ITEM_VEST_CREW_CARRIER findIf {_name == _x} != -1) then {_categories pushBack CRQ_CATALOG_VEST_CREW_CARRIER;};
		if (CQM_ITEM_VEST_EOD findIf {_name == _x} != -1) then {_categories pushBack CRQ_CATALOG_VEST_EOD;};
		if (CQM_ITEM_VEST_EXCLUDE findIf {_name == _x} == -1 && {_categories isEqualTo [] || {CQM_ITEM_VEST_INCLUDE findIf {_name == _x} != -1}}) then {
			if ([CRQ_CDAT_REBREATHER, _data] call CRQ_CatalogArrayData) exitWith {_categories pushBack CRQ_CATALOG_VEST_REBREATHER;};
			if (([CRQ_CDAT_ARMOR, _data] call CRQ_CatalogArrayData) > 0) exitWith {_categories pushBack CRQ_CATALOG_VEST_ARMOR;};
			private _load = [CRQ_CDAT_LOAD, _data] call CRQ_CatalogArrayData;
			if (_load >= (CQM_ITEM_VEST_PLAIN#0) && {_load <= (CQM_ITEM_VEST_PLAIN#1)}) then {_categories pushBack CRQ_CATALOG_VEST_PLAIN;};
			if (_load >= (CQM_ITEM_VEST_RIG#0) && {_load <= (CQM_ITEM_VEST_RIG#1)}) then {_categories pushBack CRQ_CATALOG_VEST_RIG;};
		};
		if (_categories isNotEqualTo []) then {
			_categories pushBack CRQ_CATALOG_VEST;
			[_name, _categories, [], _data] call CRQ_CatalogRegister;
		} else {
			[_name, [CRQ_CATALOG_VEST_OTHER,CRQ_CATALOG_NONE], [], _data] call CRQ_CatalogRegister;
		};
	} forEach _this;
};
CRQ_CatalogHelmetInit = {
	{
		private _name = (configName _x);
		private _data = _x call CRQ_CatalogHelmetAnalysis;
		private _categories = [];
		if (CQM_ITEM_HELMET_CIVILIAN findIf {_name == _x} != -1) then {_categories pushBack CRQ_CATALOG_HELMET_CIVILIAN;};
		if (CQM_ITEM_HELMET_MEDIC findIf {_name == _x} != -1) then {_categories pushBack CRQ_CATALOG_HELMET_MEDIC;};
		if (CQM_ITEM_HELMET_UTILITY findIf {_name == _x} != -1) then {_categories pushBack CRQ_CATALOG_HELMET_UTILITY;};
		if (CQM_ITEM_HELMET_PRESS findIf {_name == _x} != -1) then {_categories pushBack CRQ_CATALOG_HELMET_PRESS;};
		if (CQM_ITEM_HELMET_POLICE findIf {_name == _x} != -1) then {_categories pushBack CRQ_CATALOG_HELMET_POLICE;};
		if (CQM_ITEM_HELMET_CREW_ARMOR findIf {_name == _x} != -1) then {_categories pushBack CRQ_CATALOG_HELMET_CREW_ARMOR;};
		if (CQM_ITEM_HELMET_CREW_HELI findIf {_name == _x} != -1) then {_categories pushBack CRQ_CATALOG_HELMET_CREW_HELI;};
		if (CQM_ITEM_HELMET_PILOT_HELI findIf {_name == _x} != -1) then {_categories pushBack CRQ_CATALOG_HELMET_PILOT_HELI;};
		if (CQM_ITEM_HELMET_PILOT_JET findIf {_name == _x} != -1) then {_categories pushBack CRQ_CATALOG_HELMET_PILOT_JET;};
		if (CQM_ITEM_HELMET_RACING findIf {_name == _x} != -1) then {_categories pushBack CRQ_CATALOG_HELMET_RACING;};
		if (CQM_ITEM_HELMET_PATIENT findIf {_name == _x} != -1) then {_categories pushBack CRQ_CATALOG_HELMET_PATIENT;};
		if (CQM_ITEM_HELMET_CEREMONIAL findIf {_name == _x} != -1) then {_categories pushBack CRQ_CATALOG_HELMET_CEREMONIAL;};
		if (CQM_ITEM_HELMET_LEADER findIf {_name == _x} != -1) then {_categories pushBack CRQ_CATALOG_HELMET_LEADER;};
		if (CQM_ITEM_HELMET_EXCLUDE findIf {_name == _x} == -1 && {_categories isEqualTo [] || {CQM_ITEM_HELMET_INCLUDE findIf {_name == _x} != -1}}) then {
			(([CRQ_CDAT_VISION_MODE, _data] call CRQ_CatalogArrayData) call CRQ_fnc_ByteDecode) params [["_hasNormal", false], ["_hasNVG", false], ["_hasTI", false]];
			if (_hasNVG || {_hasTI}) exitWith {_categories pushBack CRQ_CATALOG_HELMET_NVG;};
			if (([CRQ_CDAT_ARMOR, _data] call CRQ_CatalogArrayData) > 0) exitWith {_categories pushBack CRQ_CATALOG_HELMET_ARMOR;};
			_categories pushBack CRQ_CATALOG_HELMET_HAT;
		};
		if (_categories isNotEqualTo []) then {
			_categories pushBack CRQ_CATALOG_HELMET;
			[_name, _categories, [], _data] call CRQ_CatalogRegister;
		} else {
			[_name, [CRQ_CATALOG_HELMET_OTHER,CRQ_CATALOG_NONE], [], _data] call CRQ_CatalogRegister;
		};
	} forEach _this;
};
CRQ_CatalogGlassesInit = {
	{
		private _name = configName _x;
		private _categories = [];
		if (CQM_ITEM_GLASSES_CIVILIAN findIf {_name == _x} != -1) then {_categories pushBack CRQ_CATALOG_GLASSES_CIVILIAN;};
		if (CQM_ITEM_GLASSES_HOSTAGE findIf {_name == _x} != -1) then {_categories pushBack CRQ_CATALOG_GLASSES_HOSTAGE;};
		if (CQM_ITEM_GLASSES_MASK findIf {_name == _x} != -1) then {_categories pushBack CRQ_CATALOG_GLASSES_MASK;};
		if (CQM_ITEM_GLASSES_CBRN findIf {_name == _x} != -1) then {_categories pushBack CRQ_CATALOG_GLASSES_CBRN;};
		if (CQM_ITEM_GLASSES_SCIENTIST findIf {_name == _x} != -1) then {_categories pushBack CRQ_CATALOG_GLASSES_SCIENTIST;};
		if (CQM_ITEM_GLASSES_DIVING findIf {_name == _x} != -1) then {_categories pushBack CRQ_CATALOG_GLASSES_DIVING;};
		if (CQM_ITEM_GLASSES_VR findIf {_name == _x} != -1) then {_categories pushBack CRQ_CATALOG_GLASSES_VR;};
		if (CQM_ITEM_GLASSES_EXCLUDE findIf {_name == _x} == -1 && {_categories isEqualTo [] || {CQM_ITEM_GLASSES_INCLUDE findIf {_name == _x} != -1}}) then {
			_categories pushBack CRQ_CATALOG_GLASSES_BASIC;
		};
		if (_categories isNotEqualTo []) then {
			_categories pushBack CRQ_CATALOG_GLASSES;
			[_name, _categories, [], []] call CRQ_CatalogRegister;
		} else {
			[_name, [CRQ_CATALOG_GLASSES_OTHER,CRQ_CATALOG_NONE], [], []] call CRQ_CatalogRegister;
		};
	} forEach _this;
};
CRQ_CatalogWeaponInit = {
	private _weapons = [];
	{
		private _name = configName _x;
		private _type = getNumber (_x >> "type");
		private _data = [_type, _x] call CRQ_CatalogWeaponAnalysis;
		private _categories = [];
		if (CQM_ITEM_WEAPON_EXCLUDE findIf {_name == _x} == -1 && {_categories isEqualTo [] || {CQM_ITEM_WEAPON_INCLUDE findIf {_name == _x} != -1}}) then {
			([_type, _data] call CRQ_CatalogUtilWeaponType) params ["_wpCategories", "_wpParams"];
			_categories append _wpCategories;
			_data append _wpParams;
		};
		if (_categories isNotEqualTo []) then {
			_categories pushBack CRQ_CATALOG_WEAPON;
			_weapons pushBack [_name, _categories, [], _data];
		} else {
			_weapons pushBack [_name, [CRQ_CATALOG_WEAPON_OTHER,CRQ_CATALOG_NONE], [], _data];
		};
	} forEach _this;
	{_x call CRQ_CatalogWeaponAttachmentInit;} forEach _weapons;
	{_x call CRQ_CatalogRegister;} forEach _weapons;
};
CRQ_CatalogAssetInit = {
	{
		private _name = configName _x;
		private _data = _x call CRQ_CatalogAssetAnalysis;
		private _categories = [];
		if (CQM_ASSET_EXCLUDE findIf {_name == _x} == -1 && {_categories isEqualTo [] || {CQM_ASSET_INCLUDE findIf {_name == _x} != -1}}) then {
			([_name, _data] call CRQ_CatalogUtilAssetType) params ["_asCategories", "_asParams"];
			_categories append _asCategories;
			_data append _asParams;
		};
		if (_categories isNotEqualTo []) then {
			_categories pushBack CRQ_CATALOG_ASSET;
			[_name, _categories, [], _data] call CRQ_CatalogRegister;
		} else {
			[_name, [CRQ_CATALOG_ASSET_OTHER,CRQ_CATALOG_NONE], [], _data] call CRQ_CatalogRegister;
		};
	} forEach _this;
};
CRQ_CatalogArrayDataBase = {
	private _base = [];
	{if ((_x#0) > 9) then {_base pushBack _x;};} forEach _this;
	_base
};
CRQ_CatalogAssetAnalysis = {
	private _name = if (_this isEqualType "") then {_this} else {configName _this};
	if (_this isEqualType "") then {_this = pCQ_CFG_Vehicles >> _this;};
	private _data = [];
	private _side = switch (getNumber (_x >> "side")) do {
		case 0: {CRQ_SD_OPF};
		case 1: {CRQ_SD_BLU};
		case 2: {CRQ_SD_IND};
		case 3: {CRQ_SD_CIV};
		default {CRQ_SD_UNKNOWN};
	};
	
	private _turrets = _this call CRQ_CatalogUtilAssetTurrets;
	private _seats = _turrets#0;
	private _armament = [];
	{
		_x params ["_wpTurret", "_wpMags"];
		private _wpMagIndex = if (_wpTurret isNotEqualTo []) then {[CRQ_BITYPE_ARMAMENT, _wpMags] call CRQ_CatalogMagazineRegister} else {[]};
		{
			private _wpName = _x;
			
			private _wpIndex = [_wpName, [CRQ_CATALOG_ARMAMENT]] call CRQ_CatalogFind;
			if (_wpIndex == -1) then {
				if ([_wpName, [CRQ_CATALOG_ARMAMENT_OTHER]] call CRQ_CatalogFind != -1) exitWith {};
				private _wpCfg = pCQ_CFG_Weapons >> _wpName;
				if (!isClass _wpCfg || {getNumber (_wpCfg >> "type") == 0}) exitWith {};
				private _wpData = [CRQ_BITYPE_ARMAMENT, _wpCfg] call CRQ_CatalogWeaponAnalysis;
				([CRQ_BITYPE_ARMAMENT, _wpData] call CRQ_CatalogUtilWeaponType) params ["_wpCategories", "_wpParams"];
				_wpCategories append (if (_wpCategories isNotEqualTo []) then {[CRQ_CATALOG_ARMAMENT]} else {[CRQ_CATALOG_ARMAMENT_OTHER,CRQ_CATALOG_NONE]});
				_wpData append _wpParams;
				_wpIndex = [_wpName, _wpCategories, [], _wpData] call CRQ_CatalogRegister;
			};
			
			if (_wpIndex != -1) then {
				private _wpData = (pCQ_CT_Item#_wpIndex#3) call CRQ_CatalogArrayDataBase;
				([CRQ_BITYPE_ARMAMENT, _wpData, _wpMagIndex] call CRQ_CatalogUtilWeaponType) params ["_wpCategories", "_wpParams"];
				_wpData append _wpParams;
				_armament pushBack [_wpIndex, _wpCategories, [_wpCategories, _wpData] call CRQ_CatalogQualityAnalysis];
			};
		} forEach _wpTurret;
	} forEach (_turrets#1); // TODO pylons, artillery, etc., e.g. (_x >> "Components" >> "TransportPylonsComponent")
	
	private _cpFuel = getNumber (_x >> "transportFuel") > 0;
	private _cpSupply = getNumber (_x >> "transportAmmo") > 0;
	private _cpRepair = getNumber (_x >> "transportRepair") > 0;
	private _cpHeal = getNumber (_x >> "attendant") > 0;
	private _capabilities = [_cpFuel, _cpSupply, _cpRepair, _cpHeal] call CRQ_fnc_ByteEncode;
	
	private _uav = (getNumber (_this >> "isUAV")) > 0;
	
	private _load = getNumber (_x >> "maximumLoad");
	private _armor = getNumber (_x >> "armor"); // TODO this seems too easy... aren't there compnonents with differing values?
	
	private _size = _name call CRQ_ClassSize;
	private _center = _name call CRQ_ClassCenter;
	
	_data pushBack [CRQ_CDAT_SIZE, _size];
	_data pushBack [CRQ_CDAT_SEATS, _seats];
	_data pushBack [CRQ_CDAT_CAPABILITIES, _capabilities];
	_data pushBack [CRQ_CDAT_CENTER, _center];
	_data pushBack [CRQ_CDAT_SIDE, _side];
	_data pushBack [CRQ_CDAT_LOAD, _load];
	_data pushBack [CRQ_CDAT_ARMOR, _armor];
	_data pushBack [CRQ_CDAT_WEAPONS, _armament];
	if (_uav) then {_data pushBack [CRQ_CDAT_AUTONOMOUS, true];};
	_data
};
CRQ_CatalogWeaponAnalysis = {
	params ["_type", "_weapon"];
	if (_weapon isEqualType "") then {_weapon = pCQ_CFG_Weapons >> _weapon;};
	private _data = [];
	private _cpDisabled = getNumber (_weapon >> "enableAttack") < 1;
	private _cpUnderwater = (getNumber (_weapon >> "canShootInWater")) > 0;
	private _cpRangefinder = _weapon call CRQ_CatalogUtilWeaponRangefinder;
	private _cpLock = (getNumber (_weapon >> "canLock")) > 1;
	private _speed = getNumber (_weapon >> "initSpeed");
	private _visionModes = _weapon call CRQ_CatalogUtilWeaponVisionModes;
	private _mags = [[_type, _weapon call CRQ_ConfigWeaponMagazines] call CRQ_CatalogMagazineRegister];
	
	{
		if (_x != "this") then {_mags pushBack ([_type, (_weapon >> _x) call CRQ_ConfigWeaponMagazines] call CRQ_CatalogMagazineRegister);};
	} forEach (getArray (_weapon >> "muzzles"));
	
	private _auto = false;
	private _burst = false;
	private _minDispersion = 1e10;
	private _maxRate = 0;
	{
		private _mode = (_weapon >> _x);
		if ((getNumber (_mode >> "showToPlayer")) == 1) then {
			private _dispersion = getNumber (_mode >> "dispersion");
			private _rate = getNumber (_mode >> "reloadTime");
			if (_rate != 0) then {_rate = 60 / _rate};
			if (_rate > _maxRate) then {_maxRate = _rate;};
			if (_dispersion < _minDispersion) then {_minDispersion = _dispersion;};
			if (getNumber (_mode >> "autoFire") > 0) then {_auto = true;};
			if (getNumber (_mode >> "burst") > 1) then {_burst = true;};
		};
	} forEach (getArray (_weapon >> "modes"));
	
	private _capabilities = [_cpDisabled, _cpUnderwater, _cpRangefinder, _cpLock] call CRQ_fnc_ByteEncode;
	
	_data pushBack [CRQ_CDAT_ATTACHMENTS, [[],[],[],[]]];
	_data pushBack [CRQ_CDAT_MAGAZINES, _mags];
	if (_speed != 0) then {_data pushBack [CRQ_CDAT_SPEED, _speed];};
	if (_capabilities > 0) then {_data pushBack [CRQ_CDAT_CAPABILITIES, _capabilities];};
	if (_auto) then {_data pushBack [CRQ_CDAT_AUTO, true];};
	if (_burst) then {_data pushBack [CRQ_CDAT_BURST, true];};
	if (_maxRate != 0) then {_data pushBack [CRQ_CDAT_RATE, _maxRate];};
	if (_minDispersion != 1e10) then {_data pushBack [CRQ_CDAT_DISPERSION, _minDispersion];};
	if (_visionModes != CRQ_VISION_NORMAL) then {_data pushBack [CRQ_CDAT_VISION_MODE, _visionModes];};
	_data pushBack [CRQ_CDAT_SLOT, _type];
	_data
};
CRQ_CatalogBackpackAnalysis = {
	if (_this isEqualType "") then {_this = pCQ_CFG_Vehicles >> _this;};
	if (getNumber (_this >> "isBackpack") != 1) exitWith {[]};
	private _data = [];
	private _load = getNumber (_this >> "maximumLoad");
	if (_load > 0) then {_data pushBack [CRQ_CDAT_LOAD, _load];};
	if ((getText (_this >> "backpackSimulation")) == "parachutesteerable") then {_data pushBack [CRQ_CDAT_PARACHUTE, true];};
	private _cfgAsm = _this >> "assembleInfo";
	if (isClass _cfgAsm) then {
		private _cfgAsmPri = _cfgAsm >> "primary";
		private _cfgAsmTo = _cfgAsm >> "assembleTo";
		private _cfgAsmBase = _cfgAsm >> "base";
		private _primary = if (isNumber _cfgAsmPri) then {getNumber _cfgAsmPri} else {-1};
		if (_primary != 1) exitWith {};
		private _assembleTo = getText _cfgAsmTo;
		if (_assembleTo isEqualTo "" || {getNumber (pCQ_CFG_Vehicles >> _assembleTo >> "scope") != 2}) exitWith {};
		_data pushBack [CRQ_CDAT_ASM_TARGET, _assembleTo];
		private _basesRaw = if (isText _cfgAsmBase) then {[getText _cfgAsmBase]} else {getArray _cfgAsmBase};
		private _basesFiltered = []; // TODO this might potentially make bags unassembleable if all bases are not scope 2...
		{if (_x isNotEqualTo "" && {getNumber (pCQ_CFG_Vehicles >> _x >> "scope") == 2}) then {_basesFiltered pushBack _x;};} forEach _basesRaw;
		if (_basesFiltered isNotEqualTo []) then {_data pushBack [CRQ_CDAT_ASM_BASE, _basesFiltered];};
	};
	_data
};
CRQ_CatalogVestAnalysis = {
	if (_this isEqualType "") then {_this = pCQ_CFG_Weapons >> _this;};
	if (getNumber (_this >> "ItemInfo" >> "type") != CRQ_BITYPE_VEST) exitWith {[]};
	private _data = [];
	private _cfgContainer = _this >> "ItemInfo" >> "containerClass";
	private _cfgProtection = _this >> "ItemInfo" >> "HitpointsProtectionInfo";
	private _cfgType = _this >> "ItemInfo" >> "vestType";
	if (isText _cfgContainer) then {
		private _load = getNumber (pCQ_CFG_Vehicles >> (getText _cfgContainer) >> "maximumLoad");
		if (_load > 0) then {_data pushBack [CRQ_CDAT_LOAD, _load];};
	};
	if (isClass _cfgProtection) then {
		private _protection = [];
		{
			private _cfgPart = _cfgProtection >> _x;
			if (isClass _cfgPart) then {
				private _cfgArmor = _cfgPart >> "armor";
				private _cfgPassthrough = _cfgPart >> "passThrough";
				private _armor = getNumber _cfgArmor;
				private _passthrough = getNumber _cfgPassthrough;
				if (_armor != 0) then {_protection pushBack [_armor, _passthrough];} else {_protection pushBack [];};
			} else {
				_protection pushBack [];
			};
		} forEach ["Abdomen","Arms","Chest","Diaphragm","Neck","Pelvis"];
		if (_protection isNotEqualTo [[],[],[],[],[],[]]) then {
			private _totalArmor = 0;
			{
				(_protection#_forEachIndex) params [["_armor", 0], ["_passthrough", 1]];
				if (_passthrough == 0) then {_passthrough = 1;};
				_totalArmor = _totalArmor + _x * (_armor / _passthrough);
			} forEach [0.20,0.10,0.30,0.20,0.05,0.15];
			_totalArmor = sqrt _totalArmor;
			_data pushBack [CRQ_CDAT_ARMOR, _totalArmor];
			_data pushBack [CRQ_CDAT_PROTECTION, _protection];
		};
	};
	if (isText _cfgType && {getText _cfgType == "rebreather"}) then {_data pushBack [CRQ_CDAT_REBREATHER, true];};
	_data
};
CRQ_CatalogHelmetAnalysis = {
	if (_this isEqualType "") then {_this = pCQ_CFG_Weapons >> _this;};
	if (getNumber (_this >> "ItemInfo" >> "type") != 605) exitWith {[]};
	private _data = [];
	private _cfgProtection = _this >> "ItemInfo" >> "HitpointsProtectionInfo";
	private _cfgSubItems = _this >> "subItems";
	if (isClass _cfgProtection) then {
		private _protection = [];
		{
			private _cfgPart = _cfgProtection >> _x;
			if (isClass _cfgPart) then {
				private _cfgArmor = _cfgPart >> "armor";
				private _cfgPassthrough = _cfgPart >> "passThrough";
				private _armor = getNumber _cfgArmor;
				private _passthrough = getNumber _cfgPassthrough;
				if (_armor != 0) then {_protection pushBack [_armor, _passthrough];} else {_protection pushBack [];};
			} else {
				_protection pushBack [];
			};
		} forEach ["Head","Face"];
		if (_protection isNotEqualTo [[],[]]) then {
			private _totalArmor = 0;
			{
				(_protection#_forEachIndex) params [["_armor", 0], ["_passthrough", 1]];
				if (_passthrough == 0) then {_passthrough = 1;};
				_totalArmor = _totalArmor + _x * (_armor / _passthrough);
			} forEach [0.85,0.15];
			_totalArmor = sqrt _totalArmor;
			_data pushBack [CRQ_CDAT_ARMOR, _totalArmor];
			_data pushBack [CRQ_CDAT_PROTECTION, _protection];
		};
	};
	if (isArray _cfgSubItems) then {
		private _visionModes = CRQ_VISION_NORMAL;
		{
			private _cfgItem = pCQ_CFG_Weapons >> _x;
			if (_forEachIndex > 0) then {
				[_visionModes, _cfgItem call CRQ_CatalogUtilVisionModes] call CRQ_fnc_ByteOr;
			} else {
				_visionModes = _cfgItem call CRQ_CatalogUtilVisionModes;
			};
		} forEach (getArray _cfgSubItems);
		if (_visionModes != CRQ_VISION_NORMAL) then {_data pushBack [CRQ_CDAT_VISION_MODE, _visionModes];};
	};
	_data
};
CRQ_CatalogNVGAnalysis = {
	if (_this isEqualType "") then {_this = pCQ_CFG_Weapons >> _this;};
	//if (getNumber (_this >> "ItemInfo" >> "type") != 616) exitWith {[]}; // TODO unsure if 616 truly is for NVG
	private _data = [];
	private _visionModes = _this call CRQ_CatalogUtilVisionModes;
	if (_visionModes != CRQ_VISION_NORMAL) then {_data pushBack [CRQ_CDAT_VISION_MODE, _visionModes];};
	_data
};
CRQ_CatalogBinocularAnalysis = {
	if (_this isEqualType "") then {_this = pCQ_CFG_Weapons >> _this;};
	private _data = [];
	private _zoom = _this call CRQ_CatalogUtilWeaponOpticsZoom;
	if (_zoom isNotEqualTo []) then {_data pushBack [CRQ_CDAT_ZOOM_MAX, _zoom#1];};
	if (_this call CRQ_CatalogUtilWeaponRangefinder) then {_data pushBack [CRQ_CDAT_RANGEFINDER, true];};
	private _visionModes = _this call CRQ_CatalogUtilVisionModes;
	if (_visionModes != CRQ_VISION_NORMAL) then {_data pushBack [CRQ_CDAT_VISION_MODE, _visionModes];};
	if (getNumber (_this >> "Laser") == 1) then {_data pushBack [CRQ_CDAT_LASER, true];}; // TODO laserbatteries - Done! ...kinda. More correct to assess laser from ammo?
	private _mags = [CRQ_BITYPE_BINOCULAR, _this call CRQ_ConfigWeaponMagazines] call CRQ_CatalogMagazineRegister;
	if (_mags isNotEqualTo []) then {_data pushBack [CRQ_CDAT_MAGAZINES, [_mags]];};
	_data
};
CRQ_CatalogTerminalAnalysis = {
	if (_this isEqualType "") then {_this = pCQ_CFG_Weapons >> _this;};
	if (getNumber (_this >> "ItemInfo" >> "type") != CRQ_BITYPE_TERMINAL) exitWith {[]};
	private _data = [];
	private _side = switch (getNumber (_this >> "ItemInfo" >> "side")) do {
		case 0: {CRQ_SD_OPF};
		case 1: {CRQ_SD_BLU};
		case 2: {CRQ_SD_IND};
		case 3: {CRQ_SD_CIV};
		default {CRQ_SD_UNKNOWN};
	};
	if (_side != CRQ_SD_UNKNOWN) then {_data pushBack [CRQ_CDAT_SIDE, _side];};
	_data
};
CRQ_CatalogWeaponAttachmentInit = {
	params ["_weaponName", "_weaponCategories", "_weaponQualities", "_weaponData"];
	
	private _attachmentCategories = [];
	{_attachmentCategories pushBack (dCRQ_WEAPON_ATTACHMENT_TYPE getOrDefault [_x, nil]);} forEach _weaponCategories;
	
	private _attachmentsAllowed = if (_attachmentCategories isEqualTo []) then {
		CRQ_WEAPON_ATTACHMENT_DEFAULT
	} else {
		private _attach = [CRQ_MUZZLE_NONE,CRQ_LASER_NONE,CRQ_OPTIC_NONE,CRQ_UNDERBARREL_NONE];
		{{_attach set [_forEachIndex, [_attach#_forEachIndex, _x] call CRQ_fnc_ByteOr];} forEach _x;} forEach _attachmentCategories;
		_attach
	};
	
	private _weaponAttachments = [CRQ_CDAT_ATTACHMENTS, _weaponData] call CRQ_CatalogArrayData;
	private _cfgAttachments = pCQ_CFG_Weapons >> _weaponName >> "WeaponSlotsInfo";
	{
		private _cfgSlot = _cfgAttachments >> (_x#0) >> "compatibleItems";
		if (!isNull _cfgSlot) then {
			private _slotType = (_x#1);
			private _slotAttachments = _weaponAttachments#_forEachIndex;
			private _slotAllowed = _attachmentsAllowed#_forEachIndex;
			{
				if ((getNumber _x) > 0) then {
					private _index = (configName _x) call CRQ_CatalogAttachmentRegister; // configName, because _x != gCQ_Weapons >> _x
					if (([_slotAllowed, [_index, _slotType] call CRQ_CatalogDataItem] call CRQ_fnc_ByteAnd) != 0) then {_slotAttachments pushBack _index;};
				};
			} forEach (configProperties [_cfgSlot, "true", true]);
		};
	} forEach [["MuzzleSlot", CRQ_CDAT_MUZZLE_TYPE], ["PointerSlot", CRQ_CDAT_LASER_TYPE], ["CowsSlot", CRQ_CDAT_OPTIC_TYPE], ["UnderBarrelSlot", CRQ_CDAT_UNDERBARREL_TYPE]];
};
CRQ_CatalogAttachmentRegister = {
	private _name = if (_this isEqualType "") then {_this} else {configName _this};
	if (_this isEqualType "") then {_this = pCQ_CFG_Weapons >> _this;};
	private _existing = _name call CRQ_CatalogFind;
	if (_existing != -1) exitWith {_existing};
	private _categories = [];
	private _data = [];
	switch (getNumber (_this >> "ItemInfo" >> "type")) do {
		case CRQ_BITYPE_OPTIC: {
			_data = _this call CRA_CatalogOpticAnalysis;
			private _type = [CRQ_CDAT_OPTIC_TYPE, _data] call CRQ_CatalogArrayData;
			if (([_type, CRQ_OPTIC_NEAR] call CRQ_fnc_ByteAnd) > 0) then {_categories pushBack CRQ_CATALOG_ATTACHMENT_OPTIC_NEAR;};
			if (([_type, CRQ_OPTIC_MID] call CRQ_fnc_ByteAnd) > 0) then {_categories pushBack CRQ_CATALOG_ATTACHMENT_OPTIC_MID;};
			if (([_type, CRQ_OPTIC_FAR] call CRQ_fnc_ByteAnd) > 0) then {_categories pushBack CRQ_CATALOG_ATTACHMENT_OPTIC_FAR;};
			_categories pushBack CRQ_CATALOG_ATTACHMENT_OPTIC;
		};
		case CRQ_BITYPE_LASER: {
			_data = _this call CRQ_CatalogLaserAnalysis;
			private _type = [CRQ_CDAT_LASER_TYPE, _data] call CRQ_CatalogArrayData;
			if (([_type, CRQ_LASER_LIGHT] call CRQ_fnc_ByteAnd) > 0) then {_categories pushBack CRQ_CATALOG_ATTACHMENT_LASER_LIGHT;};
			if (([_type, CRQ_LASER_IR] call CRQ_fnc_ByteAnd) > 0) then {_categories pushBack CRQ_CATALOG_ATTACHMENT_LASER_IR;};
			_categories pushBack CRQ_CATALOG_ATTACHMENT_LASER;
		};
		case CRQ_BITYPE_MUZZLE: {
			_data = _this call CRQ_CatalogMuzzleAnalysis;
			private _type = [CRQ_CDAT_MUZZLE_TYPE, _data] call CRQ_CatalogArrayData;
			if (([_type, CRQ_MUZZLE_SURPRESSOR] call CRQ_fnc_ByteAnd) > 0) then {_categories pushBack CRQ_CATALOG_ATTACHMENT_MUZZLE_SURPRESSOR;};
			_categories pushBack CRQ_CATALOG_ATTACHMENT_MUZZLE;
		};
		case CRQ_BITYPE_BIPOD: {
			_data = _this call CRQ_CatalogBipodAnalysis;
			private _type = [CRQ_CDAT_UNDERBARREL_TYPE, _data] call CRQ_CatalogArrayData;
			if (([_type, CRQ_UNDERBARREL_BIPOD] call CRQ_fnc_ByteAnd) > 0) then {_categories pushBack CRQ_CATALOG_ATTACHMENT_UNDERBARREL_BIPOD;};
			_categories pushBack CRQ_CATALOG_ATTACHMENT_UNDERBARREL;
		};
		default {};
	};
	if (_categories isNotEqualTo []) then {
		_categories pushBack CRQ_CATALOG_ATTACHMENT;
		([_name, _categories, [], _data] call CRQ_CatalogRegister)
	} else {
		([_name, [CRQ_CATALOG_ATTACHMENT_OTHER,CRQ_CATALOG_NONE], [], _data] call CRQ_CatalogRegister)
	};
};
CRA_CatalogOpticAnalysis = {
	if (_this isEqualType "") then {_this = pCQ_CFG_Weapons >> _this};
	if (!isClass _this || {getNumber (_this >> "ItemInfo" >> "type") != CRQ_BITYPE_OPTIC}) exitWith {[]};
	private _data = [];
	private _rangefinder = _this call CRQ_CatalogUtilWeaponRangefinder;
	_this = _this >> "ItemInfo";
	private _type = switch (getNumber (_this >> "opticType")) do {
		case 0: {CRQ_OPTIC_NEAR};
		case 1: {CRQ_OPTIC_MID};
		case 2: {CRQ_OPTIC_FAR};
		default {CRQ_OPTIC_NONE};
	};
	private _scopes = 0;
	private _visionModes = CRQ_VISION_NORMAL;
	private _range = [];
	private _zoomMax = 1;
	{
		_scopes = _scopes + 1;
		_zoomMax = _zoomMax max (selectMax (_x call CRQ_CatalogUtilWeaponOpticsZoom));
		if (_forEachIndex > 0) then {[_visionModes, _x call CRQ_CatalogUtilVisionModes] call CRQ_fnc_ByteOr;} else {_visionModes = _x call CRQ_CatalogUtilVisionModes;};
		private _zeroing = getArray (_x >> "discreteDistance");
		if (_zeroing isEqualTo []) then {
			_range pushBack ((getNumber (_x >> "distanceZoomMax") + getNumber (_x >> "distanceZoomMin")) / 2);
		} else {
			_range pushBack (if (_type != CRQ_OPTIC_NEAR) then {((selectMax _zeroing) + (selectMin _zeroing)) / 2} else {_zeroing#(getNumber (_x >> "discreteDistanceInitIndex"))});
		};
	} forEach (configProperties [_this >> "OpticsModes", "true", false]);
	if (_type != CRQ_OPTIC_NONE) then {_data pushBack [CRQ_CDAT_OPTIC_TYPE, _type];};
	if (_scopes != 0) then {_data pushBack [CRQ_CDAT_OPTIC_SCOPES, _scopes];};
	if (_zoomMax != 1) then {_data pushBack [CRQ_CDAT_ZOOM_MAX, _zoomMax];};
	if (_range isNotEqualTo []) then {_data pushBack [CRQ_CDAT_OPTIC_RANGE, selectMax _range];};
	if (_visionModes != CRQ_VISION_NORMAL) then {_data pushBack [CRQ_CDAT_VISION_MODE, _visionModes];};
	if (_rangefinder) then {_data pushBack [CRQ_CDAT_RANGEFINDER, true];};
	_data
};
CRQ_CatalogLaserAnalysis = {
	_this = if (_this isEqualType "") then {pCQ_CFG_Weapons >> _this >> "ItemInfo"} else {_this >> "ItemInfo"};
	if (!isClass _this || {getNumber (_this >> "type") != CRQ_BITYPE_LASER}) exitWith {[]};
	private _data = [];
	private _type = CRQ_LASER_NONE;
	if ((getNumber (_this >> "Flashlight" >> "intensity")) > 0) then {_type = _type + CRQ_LASER_LIGHT;};
	if ((getNumber (_this >> "Pointer" >> "irDistance")) > 0) then {_type = _type + CRQ_LASER_IR;};
	if (_type != CRQ_LASER_NONE) then {_data pushBack [CRQ_CDAT_LASER_TYPE, _type];};
	_data
};
CRQ_CatalogMuzzleAnalysis = {
	_this = if (_this isEqualType "") then {pCQ_CFG_Weapons >> _this >> "ItemInfo"} else {_this >> "ItemInfo"};
	if (!isClass _this || {getNumber (_this >> "type") != CRQ_BITYPE_MUZZLE}) exitWith {[]};
	private _data = [];
	private _type = CRQ_MUZZLE_NONE;
	if ((getNumber (_this >> "soundTypeIndex")) > 0) then {_type = _type + CRQ_MUZZLE_SURPRESSOR;};
	if (_type != CRQ_MUZZLE_NONE) then {_data pushBack [CRQ_CDAT_MUZZLE_TYPE, _type];};
	_data
};
CRQ_CatalogBipodAnalysis = {
	_this = if (_this isEqualType "") then {pCQ_CFG_Weapons >> _this >> "ItemInfo"} else {_this >> "ItemInfo"};
	if (!isClass _this || {getNumber (_this >> "type") != CRQ_BITYPE_BIPOD}) exitWith {[]};
	private _data = [];
	private _type = CRQ_UNDERBARREL_NONE;
	if ((getNumber (_this >> "hasBipod")) > 0) then {_type = _type + CRQ_UNDERBARREL_BIPOD;};
	if (_type != CRQ_UNDERBARREL_NONE) then {_data pushBack [CRQ_CDAT_UNDERBARREL_TYPE, _type];};
	_data
};
CRQ_CatalogMagazineRegister = {
	params ["_type", "_magazine"];
	private _category = if (_type != CRQ_BITYPE_ARMAMENT) then {[CRQ_CATALOG_MAGAZINE_HANDHELD,CRQ_CATALOG_MAGAZINE]} else {[CRQ_CATALOG_MAGAZINE_ARMAMENT,CRQ_CATALOG_MAGAZINE]};
	private _mgIndex = [];
	{
		private _name = if (_x isEqualType "") then {_x} else {configName _x};
		if (_x isEqualType "") then {_x = pCQ_CFG_Magazines >> _x;};
		if (isClass _x) then {
			private _existing = _name call CRQ_CatalogFind;
			if (_existing != -1) then {
				_mgIndex pushBack _existing;
			} else {
				private _data = _x call CRQ_CatalogMagazineAnalysis;
				_mgIndex pushBack ([_name, +_category, [], _data] call CRQ_CatalogRegister);
			};
		};
	} forEach _magazine;
	_mgIndex
};
CRQ_CatalogMagazineAnalysis = {
	if (_this isEqualType "") then {_this = pCQ_CFG_Magazines >> _this;};
	
	private _data = [];
	
	private _mgCount = getNumber (_this >> "count");
	private _mgSpeed = getNumber (_this >> "initSpeed");
	if (_mgCount != 0) then {_data pushBack [CRQ_CDAT_MAG_COUNT, _mgCount];};
	if (_mgSpeed != 0) then {_data pushBack [CRQ_CDAT_MAG_SPEED, _mgSpeed];};
	
	private _mgAmmo = getText (_this >> "ammo");
	if (_mgAmmo isNotEqualTo "") then {
		private _amIndex = [_mgAmmo, true] call CRQ_CatalogAmmoRegister;
		if (_amIndex == -1) exitWith {};
		_data pushBack [CRQ_CDAT_MAG_AMMO, _amIndex];
		private _amData = pCQ_CT_Ammo#_amIndex#3;
		_data pushBack [CRQ_CDAT_0, [CRQ_CDAT_0, _amData] call CRQ_CatalogArrayData];
		_data pushBack [CRQ_CDAT_1, [CRQ_CDAT_1, _amData] call CRQ_CatalogArrayData];
	};
	
	_data
};
CRQ_CatalogAmmoRegister = {
	params ["_ammo", "_extended"];
	private _name = if (_ammo isEqualType "") then {_ammo} else {configName _ammo};
	if (_ammo isEqualType "") then {_ammo = pCQ_CFG_Ammo >> _ammo;};
	
	if (!isClass _ammo) exitWith {-1};
	
	private _lcName = toLowerANSI _name;
	private _existing = pCQ_CT_FindAmmo getOrDefault [_lcName, -1];//findIf {_name == (_x#0)};
	if (_existing != -1) exitWith {_existing};
	
	private _data = _ammo call CRQ_CatalogAmmoAnalysisBasic; // due to recursion, MUST call prior to increment
	
	pCQ_CT_CounterAmmo = pCQ_CT_CounterAmmo + 1;
	pCQ_CT_Ammo pushBack _data;
	pCQ_CT_FindAmmo set [_lcName, pCQ_CT_CounterAmmo];
	
	if (_extended) then {pCQ_CT_CounterAmmo call CRQ_CatalogAmmoAnalysisExtended;};
	
	pCQ_CT_CounterAmmo
};
CRQ_CatalogAmmoAnalysisExtended = {
	private _ammo = _this call CRQ_CatalogUtilAmmoDeploy;
	private _lethality = 0;
	private _envelope = _ammo apply {_x#1};
	private _type = _ammo call (dCRQ_AMMO_TYPES getOrDefault [_envelope, {-1}]);
	{if ((_x#0) find _type != -1) exitWith {_lethality = _ammo call (_x#1);};} forEach dCRQ_AMMO_LETHALITY;
	(pCQ_CT_Ammo#_this#3) append [[CRQ_CDAT_0, _type],[CRQ_CDAT_1, _lethality]];
};
CRQ_CatalogAmmoAnalysisBasic = {
	private _name = if (_this isEqualType "") then {_this} else {configName _this};
	if (_this isEqualType "") then {_this = pCQ_CFG_Ammo >> _this;};
	private _data = [];
	
	private _subMunition = (_this >> "submunitionAmmo") call {
		if (isText _this) exitWith {getText _this};
		if (isArray _this) exitWith { // TODO if array, first is type, second is probability, third is second type, etc...
			private _array = getArray _this;
			if (_array isNotEqualTo [] && {(_array#0) isEqualType ""}) then {_array#0} else {""};
		};
		""
	};
	private _count = 1; // TODO
	if (_subMunition isNotEqualTo "") then {
		private _smIndex = [_subMunition, false] call CRQ_CatalogAmmoRegister;
		if (_smIndex == -1) exitWith {};
		_data pushBack [CRQ_CDAT_AMMO_SUBMUNITION, _smIndex];
		private _cfgCount = _this >> "submunitionConeType";
		if (isArray _cfgCount) exitWith {_count = (getArray _cfgCount)#1;};
		_cfgCount = _this >> "submunitionCount";
		if (isNumber _cfgCount) exitWith {_count = getNumber _cfgCount;};
	};
	if (_count != 1) then {_data pushBack [CRQ_CDAT_AMMO_COUNT, _count];};
	
	private _type = CRQ_BIAMMO_TYPES find (toLowerANSI (getText (_this >> "simulation")));
	{
		if ((_x#2) find _type != -1) then {
			private _value = _this call (_x#1);
			if (_value isNotEqualTo (dCRQ_CDAT_DEFAULTS#(_x#0))) then {_data pushBack [_x#0, _value];};
		};
	} forEach dCRQ_AMMO_DATA;
	
	[_name, _type, 0, _data]
};
CRQ_CatalogUtilAmmoGuidance = {
	if (_this isEqualType "") then {_this = pCQ_CFG_Ammo >> _this;};
	// TODO there's irLock, laserLock, lockType, weaponLockSystem, manualControl and Components as a subclass...
	private _cfgGuidance = _this >> "weaponLockSystem";
	if (isNumber _cfgGuidance) exitWith {getNumber _cfgGuidance};
	if (isText _cfgGuidance) exitWith {call (compile (getText _cfgGuidance));};
	0
};
CRQ_CatalogUtilAmmoFX = { // TODO properly flag this
	if (_this isEqualType "") then {_this = pCQ_CFG_Ammo >> _this;};
	private _cfgSmoke = configFile >> (getText (_this >> "effectsSmoke"));
	if (!isClass _cfgSmoke) exitWith {0};
	private _smoke = false;
	private _illumination = false;
	{
		switch (toLowerANSI (getText (_x >> "simulation"))) do {
			case "particles": {_smoke = true;};
			case "light": {_illumination = true;};
			default {};
		};
	} forEach (configProperties [_cfgSmoke]);
	([_smoke, _illumination] call CRQ_fnc_ByteEncode)
};
CRQ_CatalogUtilAmmoTrigger = {
	if (_this isEqualType "") then {_this = pCQ_CFG_Ammo >> _this;};
	switch (toLowerANSI (getText (_this >> "mineTrigger"))) do {
		//case "rangetrigger": {0}; // default for everything
		//case "rangetriggerdrone": {0};
		//case "rangetriggerdrone_dummy": {0};
		//case "uxotrigger1": {0};
		//case "uxotrigger2": {0};
		//case "uxotrigger3": {0};
		//case "uxotrigger4": {0};
		case "remotetrigger": {CRQ_MINE_TRIGGER_REMOTE};
		case "rangetriggerbounding";
		case "rangetriggershort";
		case "wiretrigger": {CRQ_MINE_TRIGGER_PERSON};
		case "irtrigger";
		case "tanktriggermagnetic": {CRQ_MINE_TRIGGER_VEHICLE};
		case "underwaterrangetriggermagnetic";
		case "underwaterrangetriggermagneticshort": {CRQ_MINE_TRIGGER_SHIP};
		default {0};
	};
};
CRQ_CatalogUtilWeaponRangefinder = {
	private _name = if (_this isEqualType "") then {_this} else {configName _this};
	if (_this isEqualType "") then {_this = pCQ_CFG_Weapons >> _this;};
	if ((CRQ_UTIL_RANGEFINDER_EXCLUDE findIf {_name == _x}) != -1) exitWith {false};
	private _IGUI = getText (_this >> "weaponInfoType");
	if (_IGUI isEqualTo "") exitWith {false};
	private _config = pCQ_CFG_IGUI >> _IGUI;
	if (!isClass _config) exitWith {false};
	private _rangefinder = false;
	{
		private _idc = getNumber (_x >> "idc");
		if (_idc == 198 || {_idc == 151}) exitWith {_rangefinder = true;};
	} forEach (_config call CRQ_ConfigChildren); // TODO there is a controls array that lists relevant classes...?
	_rangefinder
};
CRQ_CatalogUtilVisionModes = {
	private _normal = CRQ_VISION_NORMAL;
	private _nvg = 0;
	private _ti = 0;
	{
		if (_forEachIndex == 0) then {_normal = 0;};
		switch (toLowerANSI (_x)) do {
			case "normal": {_normal = CRQ_VISION_NORMAL;};
			case "nvg": {_nvg = CRQ_VISION_NVG;};
			case "ti": {_ti = CRQ_VISION_TI;};
			default {};
		};
	} forEach (getArray (_this >> "visionMode"));
	(_normal + _nvg + _ti)
};
CRQ_CatalogUtilWeaponVisionModes = {
	if (_this isEqualType "") then {_this = pCQ_CFG_Weapons >> _this;};
	private _visionModes = 0;
	{
		if (_forEachIndex > 0) then {
			[_visionModes, _x call CRQ_CatalogUtilVisionModes] call CRQ_fnc_ByteOr;
		} else {
			_visionModes = _x call CRQ_CatalogUtilVisionModes;
		};
	} forEach (configProperties [_this >> "OpticsModes", "true", false]);
	_visionModes
};
CRQ_CatalogUtilWeaponOpticsZoom = {
	if (_this isEqualType "") then {_this = pCQ_CFG_Weapons >> _this;};
	private _cfgMin = _this >> "opticsZoomMax";
	private _cfgMax = _this >> "opticsZoomMin";
	if (!isNumber _cfgMin || {!isNumber _cfgMax}) exitWith {[]};
	private _min = (getNumber _cfgMin);
	private _max = (getNumber _cfgMax);
	if (_min == 0) then {_min = 1;};
	if (_max == 0) then {_max = 1;};
	[0.25 / _min, 0.25 / _max]
};
CRQ_CatalogUtilWeaponMagAll = {
	if (_this isEqualType -1) then {_this = pCQ_CT_Item#_this#3;};
	private _mags = [];
	{_mags append _x;} forEach ([CRQ_CDAT_MAGAZINES, _this] call CRQ_CatalogArrayData);
	_mags
};
CRQ_CatalogUtilAmmoDeploy = {
	private _ammo = [];
	while {_this != -1} do {
		_ammo pushBack (pCQ_CT_Ammo#_this);
		_this = [CRQ_CDAT_AMMO_SUBMUNITION, pCQ_CT_Ammo#_this#3] call CRQ_CatalogArrayData;
	};
	_ammo
};
CRQ_CatalogUtilMagazineAmmo = {
	if (_this isEqualType -1) then {_this = pCQ_CT_Item#_this#3;};
	(([CRQ_CDAT_MAG_AMMO, _this] call CRQ_CatalogArrayData) call CRQ_CatalogUtilAmmoDeploy)
};
CRQ_CatalogUtilThrowType = {
	params ["_data"];
	private _categories = [];
	private _params = [];
	([CRQ_CDAT_0, _data] call CRQ_CatalogArrayData) call {
		if (_this == CRQ_MAG_SMOKE) exitWith {_categories pushBack CRQ_CATALOG_THROW_SMOKE;};
		if (_this == CRQ_MAG_LIGHT) exitWith {_categories pushBack CRQ_CATALOG_THROW_LIGHT;};
		if (_this == CRQ_MAG_STROBE) exitWith {_categories pushBack CRQ_CATALOG_THROW_STROBE;};
		if (_this == CRQ_MAG_GRENADE) exitWith {_categories pushBack CRQ_CATALOG_THROW_GRENADE;};
	};
	[_categories, _params]
};
CRQ_CatalogUtilPutType = {
	params ["_data"];
	private _categories = [];
	private _params = [];
	([CRQ_CDAT_0, _data] call CRQ_CatalogArrayData) call {
		if (_this == CRQ_MAG_DEMO) exitWith {_categories pushBack CRQ_CATALOG_PUT_DEMO;};
		if (_this == CRQ_MAG_MINE) exitWith {
			private _source = ((_data call CRQ_CatalogUtilMagazineAmmo) apply {[CRQ_CDAT_AMMO_TRIGGER, _x#3] call CRQ_CatalogArrayData});
			private _trigger = 0;
			{if (_forEachIndex > 0) then {_trigger = [_trigger, _x] call CRQ_fnc_ByteOr;} else {_trigger = _x;};} forEach _source;
			(_trigger call CRQ_fnc_ByteDecode) params [["_remote", false], ["_person", false], ["_vehicle", false], ["_ship", false]];
			if (_remote) then {_categories pushBack CRQ_CATALOG_PUT_MINE_REMOTE;};
			if (_person) then {_categories pushBack CRQ_CATALOG_PUT_MINE_AP;};
			if (_vehicle) then {_categories pushBack CRQ_CATALOG_PUT_MINE_AT;};
			if (_ship) then {_categories pushBack CRQ_CATALOG_PUT_MINE_AS;};
			_categories pushBack CRQ_CATALOG_PUT_MINE;
		};
	};
	[_categories, _params]
};
CRQ_CatalogUtilWeaponType = {
	params ["_type", "_data", ["_mags", []]];
	private _categories = [];
	private _params = [];
	switch (_type) do {
		case CRQ_BITYPE_RIFLE;
		case CRQ_BITYPE_PISTOL: {
			private _firearm = false;
			call {
				(_data call CRQ_CatalogUtilWeaponCapabilities) params [["_disabled",false],["_underwater",false],["_rangefinder",false],["_lock",false]];
				if (_mags isEqualTo []) then {_mags = [CRQ_CDAT_MAGAZINES, _data] call CRQ_CatalogArrayData;};
				private _priMags = _mags#0;
				if (_disabled || {_priMags isEqualTo []}) exitWith {_categories pushBack CRQ_CATALOG_WEAPON_DUMMY;};
				
				private _priAmmo = [];
				{_priAmmo pushBackUnique ([CRQ_CDAT_0, pCQ_CT_Item#_x#3] call CRQ_CatalogArrayData);} forEach _priMags;
				if (_priAmmo isEqualTo [CRQ_MAG_FLARE]) exitWith {_categories pushBack CRQ_CATALOG_WEAPON_FLARE;};
				if (_priAmmo isNotEqualTo [CRQ_MAG_BULLET_SINGLE] && {_priAmmo find CRQ_MAG_BULLET_BUCK == -1}) exitWith {};
				
				private _refMag = pCQ_CT_Item#(_priMags#0);
				private _refAmmo = pCQ_CT_Ammo#([CRQ_CDAT_MAG_AMMO, _refMag#3] call CRQ_CatalogArrayData);
				
				private _amLeth = [CRQ_CDAT_1, _refAmmo#3] call CRQ_CatalogArrayData;
				private _amSpeed = [CRQ_CDAT_AMMO_SPEED, _refAmmo#3] call CRQ_CatalogArrayData;
				private _mgClip = [CRQ_CDAT_MAG_COUNT, _refMag#3] call CRQ_CatalogArrayData;
				private _mgSpeed = [CRQ_CDAT_MAG_SPEED, _refMag#3] call CRQ_CatalogArrayData;
				private _wpSpeed = [CRQ_CDAT_SPEED, _data] call CRQ_CatalogArrayData;
				
				if (_wpSpeed < 0) then {_wpSpeed = -_wpSpeed * _mgSpeed;} else {if (_wpSpeed == 0) then {_wpSpeed = _mgSpeed;};};
				private _speed = if (_amSpeed != 0) then {_wpSpeed / _amSpeed} else {_wpSpeed / _mgSpeed};
				
				_params pushBack [CRQ_CDAT_0, [_amLeth, _speed]];
				_params pushBack [CRQ_CDAT_1, _mgClip];
				
				if (_underwater) exitWith {_categories pushBack CRQ_CATALOG_WEAPON_UW;};
				_firearm = true;
				if (_type == CRQ_BITYPE_PISTOL) exitWith {_categories pushBack CRQ_CATALOG_WEAPON_HG;};
				if (_priAmmo find CRQ_MAG_BULLET_BUCK != -1) exitWith {_categories pushBack CRQ_CATALOG_WEAPON_SG;};
				if (count _mags > 1) exitWith {
					private _secAmmo = [];
					{_secAmmo pushBackUnique ([CRQ_CDAT_0, pCQ_CT_Item#_x#3] call CRQ_CatalogArrayData);} forEach (_mags#1);
					if (_secAmmo find CRQ_MAG_SHELL_GRENADE_HE != -1) exitWith {_categories pushBack CRQ_CATALOG_WEAPON_ARGL;};
					_categories pushBack CRQ_CATALOG_WEAPON_ARSO;
				};
				
				if (_amLeth <= CRQ_METRIC_CALIBER_SUB) exitWith {_categories pushBack CRQ_CATALOG_WEAPON_SMG;};
				if (_amLeth <= CRQ_METRIC_CALIBER_LOW) exitWith {
					if (_mgClip > 100) exitWith {_categories pushBack CRQ_CATALOG_WEAPON_LMG;};
					if (_mgClip > 30) exitWith {_categories pushBack CRQ_CATALOG_WEAPON_ARSW;};
					if (_speed < 0.925) exitWith {_categories pushBack CRQ_CATALOG_WEAPON_CAR;};
					if (_speed > 1.075) exitWith {_categories pushBack CRQ_CATALOG_WEAPON_ARM;};
					_categories pushBack CRQ_CATALOG_WEAPON_AR;
				};
				if (_amLeth <= CRQ_METRIC_CALIBER_MED) exitWith {
					if (_mgClip > 30) exitWith {_categories pushBack CRQ_CATALOG_WEAPON_MMG;};
					_categories pushBack CRQ_CATALOG_WEAPON_SRM;
				};
				if (_amLeth <= CRQ_METRIC_CALIBER_HI) exitWith {
					if (_mgClip > 30) exitWith {_categories pushBack CRQ_CATALOG_WEAPON_MMG;};
					_categories pushBack CRQ_CATALOG_WEAPON_SRSO;
				};
				if ([CRQ_CDAT_AUTO, _data] call CRQ_CatalogArrayData) exitWith {_categories pushBack CRQ_CATALOG_WEAPON_MMG;};
				_categories pushBack CRQ_CATALOG_WEAPON_SRL;
			};
			if (_firearm) then {_categories pushBack CRQ_CATALOG_WEAPON_FIREARM;};
		};
		case CRQ_BITYPE_LAUNCHER: {
			(_data call CRQ_CatalogUtilWeaponCapabilities) params [["_disabled",false],["_underwater",false],["_rangefinder",false],["_lock",false]];
			if (_mags isEqualTo []) then {_mags = _data call CRQ_CatalogUtilWeaponMagAll;};
			if (_disabled || {_mags isEqualTo []}) exitWith {_categories pushBack CRQ_CATALOG_WEAPON_DUMMY;};
			
			private _mgLeth = 0;
			private _mgAmmo = [];
			{
				private _mgData = pCQ_CT_Item#_x#3;
				_mgAmmo pushBackUnique ([CRQ_CDAT_0, _mgData] call CRQ_CatalogArrayData);
				_mgLeth = _mgLeth max ([CRQ_CDAT_1, _mgData] call CRQ_CatalogArrayData);
			} forEach _mags;
			
			private _missile = false;
			{if ((_mgAmmo arrayIntersect (_x#2)) isNotEqualTo []) then {_categories pushBack (_x#0); _missile = _missile || (_x#1);};} forEach [
				[CRQ_CATALOG_WEAPON_AA, true, [CRQ_MAG_MISSILE_AA]],
				[CRQ_CATALOG_WEAPON_AT, true, [CRQ_MAG_MISSILE_AT, CRQ_MAG_MISSILE_AP]],
				[CRQ_CATALOG_WEAPON_AT, false, [CRQ_MAG_ROCKET_AT, CRQ_MAG_ROCKET_AP]]
			];
			_categories pushBack CRQ_CATALOG_WEAPON_LAUNCHER;
			
			_params pushBack [CRQ_CDAT_0, _mgLeth];
			_params pushBack [CRQ_CDAT_1, [_missile, _lock]];
		};
		case CRQ_BITYPE_ARMAMENT: {
			(_data call CRQ_CatalogUtilWeaponCapabilities) params [["_disabled",false],["_underwater",false],["_rangefinder",false],["_lock",false]];
			if (_mags isEqualTo []) then {_mags = _data call CRQ_CatalogUtilWeaponMagAll;} else {_mags = _mags arrayIntersect (_data call CRQ_CatalogUtilWeaponMagAll);};
			if (_mags isEqualTo [] || {_disabled}) exitWith {_categories pushBack CRQ_CATALOG_ARMAMENT_DUMMY;};
			
			private _mgLeth = 0;
			private _mgAmmo = [];
			{
				private _mgData = pCQ_CT_Item#_x#3;
				_mgAmmo pushBackUnique ([CRQ_CDAT_0, _mgData] call CRQ_CatalogArrayData);
				_mgLeth = _mgLeth max ([CRQ_CDAT_1, _mgData] call CRQ_CatalogArrayData);
			} forEach _mags;
			
			if ((_mgAmmo arrayIntersect [CRQ_MAG_COUNTER]) isNotEqualTo []) then {_categories pushBack CRQ_CATALOG_ARMAMENT_COUNTER;};
			if ((_mgAmmo arrayIntersect [CRQ_MAG_LASER]) isNotEqualTo []) then {_categories pushBack CRQ_CATALOG_ARMAMENT_LASER;};
			if ((_mgAmmo arrayIntersect [CRQ_MAG_SHELL_ARTY_HE,CRQ_MAG_SHELL_ARTY_GUIDED,CRQ_MAG_SHELL_ARTY_CLUSTER,CRQ_MAG_SHELL_ARTY_MINE]) isNotEqualTo []) then {_categories pushBack CRQ_CATALOG_ARMAMENT_ARTY;};
			if ((_mgAmmo arrayIntersect [CRQ_MAG_SHELL_CANNON_HE,CRQ_MAG_SHELL_CANNON_HEAT,CRQ_MAG_SHELL_CANNON_APDS]) isNotEqualTo []) then {_categories pushBack CRQ_CATALOG_ARMAMENT_CANNON;};
			if ((_mgAmmo arrayIntersect [CRQ_MAG_MISSILE_CRUISE]) isNotEqualTo []) then {_categories pushBack CRQ_CATALOG_ARMAMENT_VLS;};
			if ((_mgAmmo arrayIntersect [CRQ_MAG_MISSILE_AA]) isNotEqualTo []) then {_categories pushBack CRQ_CATALOG_ARMAMENT_RPG_AA;};
			if ((_mgAmmo arrayIntersect [CRQ_MAG_SHELL_GRENADE_HE]) isNotEqualTo []) then {_categories pushBack CRQ_CATALOG_ARMAMENT_GMG;};
			if ((_mgAmmo arrayIntersect [CRQ_MAG_MISSILE_AT,CRQ_MAG_MISSILE_AP,CRQ_MAG_ROCKET_AT,CRQ_MAG_ROCKET_AP]) isNotEqualTo []) then {_categories pushBack CRQ_CATALOG_ARMAMENT_RPG_AT;};
			if ((_mgAmmo arrayIntersect [CRQ_MAG_BULLET_SINGLE,CRQ_MAG_BULLET_BUCK]) isNotEqualTo []) then {
				call {
					if (_mgLeth <= 0.03) exitWith {_categories pushBack CRQ_CATALOG_ARMAMENT_DUMMY;}; // e.g. shotgun-pelter on demining drone
					if (_mgLeth <= 0.30) exitWith {_categories pushBack CRQ_CATALOG_ARMAMENT_LMG;};
					if (_mgLeth <= 0.75) exitWith {_categories pushBack CRQ_CATALOG_ARMAMENT_MMG;};
					if (_mgLeth <= 1.33) exitWith {_categories pushBack CRQ_CATALOG_ARMAMENT_HMG;};
					_categories pushBack CRQ_CATALOG_ARMAMENT_AC;
				};
			};
			_params pushBack [CRQ_CDAT_0, _mgLeth];
			_params pushBack [CRQ_CDAT_1, [false, false]];
		};
		default {};
	};
	[_categories, _params]
};
CRQ_CatalogUtilWeaponCapabilities = {
	if (_this isEqualType -1) then {_this = pCQ_CT_Item#_this#3;};
	(([CRQ_CDAT_CAPABILITIES, _this] call CRQ_CatalogArrayData) call CRQ_fnc_ByteDecode)
};
CRQ_CatalogUtilAssetTurrets = {
	private _drivers = 0;
	private _passengers = 0;
	private _gunners = 0;
	private _commanders = 0;
	private _armament = [];
	{
		_drivers = _drivers + getNumber (_x >> "hasDriver");
		_passengers = _passengers + getNumber (_x >> "transportSoldier");
		//if (getNumber (_x >> "primaryObserver") == 1 || getNumber (_x >> "isCoPilot") == 1) then {
		if (getNumber (_x >> "primaryObserver") > 0) then {
			_commanders = _commanders + 1;
		} else {
			if (getNumber (_x >> "isCoPilot") > 0) exitWith {_passengers = _passengers + 1;};
			switch (toLowerANSI (getText (_x >> "proxyType"))) do {
				case "cpcargo": {if (getNumber (_x >> "isPersonTurret") == 0 && getText (_x >> "gun") isNotEqualTo "") then {_gunners = _gunners + 1;} else {_passengers = _passengers + 1;};};
				case "cpgunner": {_gunners = _gunners + 1;};
				case "cpcommander": {_commanders = _commanders + 1;}; // should've been catched above by "primaryObserver"
				default {};
			};
		};
		_armament pushBack [getArray (_x >> "weapons"), _x call CRQ_ConfigWeaponMagazines];
	} forEach (_this call CRQ_ConfigVehicleTurrets);
	[[_commanders, _gunners, _drivers, _passengers], _armament]
};
CRQ_CatalogUtilAssetType = {
	params ["_name", "_data"];
	private _categories = [];
	private _params = [];
	
	private _lethality = 0;
	{
		_x params ["_wpIndex", "_wpCategories", "_wpLeth"];
		{_categories pushBackUnique (dCRQ_CATEGORY_ASSET_ARMAMENT getOrDefault [_x, nil]);} forEach _wpCategories;
		_lethality = _lethality max (selectMax _wpLeth);
	} forEach ([CRQ_CDAT_WEAPONS, _data] call CRQ_CatalogArrayData);
	
	private _armorThreshold = 1e10;
	private _armorMax = 1000;
	switch (true) do {
		case (_name isKindOf "staticweapon"): {
			if (([CRQ_CDAT_LOAD, _data] call CRQ_CatalogArrayData) > 0) then {
				//_categories pushBack CRQ_CATALOG_ASSET_AIR; // ???
				_categories pushBack CRQ_CATALOG_ASSET_POD;
			} else {
				_categories pushBack CRQ_CATALOG_ASSET_LAND;
				_categories pushBack CRQ_CATALOG_ASSET_STATIC;
			};
		};
		case (_name isKindOf "car"): {
			_armorThreshold = 200;
			_armorMax = 500;
			_categories pushBack CRQ_CATALOG_ASSET_WHEELED;
			_categories pushBack CRQ_CATALOG_ASSET_LAND;
			_categories pushBack CRQ_CATALOG_ASSET_VEHICLE;
		};
		case (_name isKindOf "tank"): {
			_armorThreshold = 100;
			_categories pushBack CRQ_CATALOG_ASSET_TRACKED;
			_categories pushBack CRQ_CATALOG_ASSET_LAND;
			_categories pushBack CRQ_CATALOG_ASSET_VEHICLE;
		};
		case (_name isKindOf "plane"): {
			_categories pushBack CRQ_CATALOG_ASSET_WINGED;
			_categories pushBack CRQ_CATALOG_ASSET_AIR;
			_categories pushBack CRQ_CATALOG_ASSET_VEHICLE;
		};
		case (_name isKindOf "helicopter"): {
			_categories pushBack CRQ_CATALOG_ASSET_ROTOR;
			_categories pushBack CRQ_CATALOG_ASSET_AIR;
			_categories pushBack CRQ_CATALOG_ASSET_VEHICLE;
		};
		case (_name isKindOf "ship"): {
			if (getText (pCQ_CFG_Vehicles >> _name >> "simulation") != "submarinex") then {
				_categories pushBack CRQ_CATALOG_ASSET_BOAT;
			} else {
				_categories pushBack CRQ_CATALOG_ASSET_SUB;
			};
			_categories pushBack CRQ_CATALOG_ASSET_SEA;
			_categories pushBack CRQ_CATALOG_ASSET_VEHICLE;
		};
		default {};
	};
	[] call {
		if (_armorThreshold == 1e10) exitWith {_categories pushBack CRQ_CATALOG_ASSET_UNARMORED;};
		if (_armorThreshold == 0) exitWith {_categories pushBack CRQ_CATALOG_ASSET_ARMORED;};
		private _armorValue = [CRQ_CDAT_ARMOR, _data] call CRQ_CatalogArrayData;
		private _armorNormalized = 0;
		if (_armorValue > _armorThreshold) then {
			_armorNormalized = _armorValue / _armorMax;
			_categories pushBack CRQ_CATALOG_ASSET_ARMORED;
		} else {
			_armorNormalized = _armorValue / _armorMax;
			_categories pushBack CRQ_CATALOG_ASSET_UNARMORED;
		};
		if (_armorNormalized != 0) then {_params pushBack [CRQ_CDAT_0, _armorNormalized];};
	};
	
	if (_lethality > 0.05) then {
		_categories pushBack CRQ_CATALOG_ASSET_ARMED;
		_params pushBack [CRQ_CDAT_1, _lethality];
	} else {
		_categories pushBack CRQ_CATALOG_ASSET_UNARMED;
	};
	
	_categories pushBack (if ([CRQ_CDAT_AUTONOMOUS, _data] call CRQ_CatalogArrayData) then {CRQ_CATALOG_ASSET_AUTONOMOUS} else {CRQ_CATALOG_ASSET_MANNED});
	
	_categories pushBack (switch ([CRQ_CDAT_SIDE, _data] call CRQ_CatalogArrayData) do {
		case CRQ_SD_BLU: {CRQ_CATALOG_ASSET_BLUFOR};
		case CRQ_SD_IND: {CRQ_CATALOG_ASSET_IDFOR};
		case CRQ_SD_OPF: {CRQ_CATALOG_ASSET_OPFOR};
		default {CRQ_CATALOG_ASSET_CIVFOR};
	});
	
	[_categories, _params]
};
CRQ_DBG_RPGList = {
	private _list = [CRQ_CATALOG_WEAPON_AT call CRQ_CatalogListAny, CRQ_CATALOG_WEAPON] call CRQ_CatalogListQuality;
	(_list apply {[_x#0, (pCQ_CT_Item#(_x#1))]})
};
CRQ_DBG_OpticsList = {
	private _list = [CRQ_CATALOG_ATTACHMENT_OPTIC call CRQ_CatalogListAny, CRQ_CATALOG_ATTACHMENT_OPTIC] call CRQ_CatalogListQuality;
	(_list apply {[_x#0, (pCQ_CT_Item#(_x#1))]})
};
/*
pCQ_CT_Temp = missionNamespace getVariable ["pCQ_CT_Temp", []];
pCQ_CT_Temp2 = missionNamespace getVariable ["pCQ_CT_Temp2", []];
CRQ_DBG_CategoryAny = {
	private _index = _this call CRQ_CatalogListAny;
	private _list = [];
	{_list pushBack (pCQ_CT_Item#_x);} forEach _index;
	_list
};
CRQ_DBG_CategoryMatching = {
	private _index = _this call CRQ_CatalogListMatching;
	private _list = [];
	{_list pushBack (pCQ_CT_Item#_x);} forEach _index;
	_list
};
CRQ_DBG_WeaponsList = {
	private _list = [CRQ_CATALOG_WEAPON call CRQ_CatalogListAny, CRQ_CATALOG_WEAPON] call CRQ_CatalogListQuality;
	(_list apply {[_x#0, (pCQ_CT_Item#(_x#1)#0)]})
};
CRQ_DBG_ArmamentList = {
	private _list = [CRQ_CATALOG_ARMAMENT call CRQ_CatalogListAny, CRQ_CATALOG_ARMAMENT] call CRQ_CatalogListQuality;
	(_list apply {[_x#0, (pCQ_CT_Item#(_x#1)#0)]})
};
CRQ_DBG_TestSpeed = {
	([[CRQ_CATALOG_WEAPON_FIREARM] call CRQ_CatalogListAny, [CRQ_CATALOG_WEAPON_FIREARM]] call CRQ_CatalogListQuality)
};
CRQ_DBG_VehicleArmed = {
	private _itemList = [CRQ_CATALOG_ASSET_WHEELED,CRQ_CATALOG_ASSET_ARMED,CRQ_CATALOG_ASSET_MANNED] call CRQ_CatalogListMatching;
	_itemList append ([CRQ_CATALOG_ASSET_TRACKED,CRQ_CATALOG_ASSET_ARMED,CRQ_CATALOG_ASSET_MANNED] call CRQ_CatalogListMatching);
	private _quality = [_itemList, [CRQ_CATALOG_ASSET_ARMED]] call CRQ_CatalogListQuality;
	(_quality apply {[_x#0, pCQ_CT_Item#(_x#1)#0]})
	//private _qualityList = [_itemList, [CRQ_CATALOG_ASSET_ARMED,CRQ_CATALOG_ASSET_ARMORED],[0.5,0.5]] call CRQ_CatalogListQuality;
	//(_qualityList apply {[_x#0, (pCQ_CT_Item#(_x#1)#0)]})
};
CRQ_DBG_ListStatic = {
	private _list = [[CRQ_CATALOG_ASSET_STATIC,CRQ_CATALOG_ASSET_MANNED] call CRQ_CatalogListMatching, [CRQ_CATALOG_ASSET_ARMED]] call CRQ_CatalogListQuality;
	(_list apply {[_x#0, (pCQ_CT_Item#(_x#1)#0)]})
};
CRQ_DBG_ListArmed = {
	private _list = [];
	{
		private _type = _x;
		{
			private _side = _x;
			_list append ([[_type,CRQ_CATALOG_ASSET_ARMED,CRQ_CATALOG_ASSET_MANNED,_side] call CRQ_CatalogListMatching, [CRQ_CATALOG_ASSET_ARMED]] call CRQ_CatalogListQuality);
		} forEach [CRQ_CATALOG_ASSET_BLUFOR,CRQ_CATALOG_ASSET_IDFOR,CRQ_CATALOG_ASSET_OPFOR,CRQ_CATALOG_ASSET_CIVFOR];
	} forEach [CRQ_CATALOG_ASSET_WHEELED,CRQ_CATALOG_ASSET_TRACKED,CRQ_CATALOG_ASSET_WINGED,CRQ_CATALOG_ASSET_BOAT,CRQ_CATALOG_ASSET_ROTOR,CRQ_CATALOG_ASSET_STATIC];
	(_list apply {[_x#0, (pCQ_CT_Item#(_x#1)#0)]})
};
*/