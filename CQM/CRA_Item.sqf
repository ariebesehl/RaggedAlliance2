
gRA_IdentityFaces = missionNamespace getVariable ["gRA_IdentityFaces", []];
gRA_IdentityVoice = missionNamespace getVariable ["gRA_IdentityVoice", []];

gRA_ItemIndexCounter = missionNamespace getVariable ["gRA_ItemIndexCounter", -1];
gRA_ItemIndex = missionNamespace getVariable ["gRA_ItemIndex", []];

gRA_ItemAmmoCounter = missionNamespace getVariable ["gRA_ItemAmmoCounter", -1];
gRA_ItemAmmo = missionNamespace getVariable ["gRA_ItemAmmo", []];

gRA_ItemLevels = missionNamespace getVariable ["gRA_ItemLevels", 16];
gRA_ItemLevelBounds = missionNamespace getVariable ["gRA_ItemLevelBounds", []];

gRA_InventoryAttachment = missionNamespace getVariable ["gRA_InventoryAttachment", []];
gRA_InventoryBackpackSmall = missionNamespace getVariable ["gRA_InventoryBackpackSmall", []];
gRA_InventoryBackpackMedium = missionNamespace getVariable ["gRA_InventoryBackpackMedium", []];
gRA_InventoryBackpackLarge = missionNamespace getVariable ["gRA_InventoryBackpackLarge", []];
gRA_InventoryBackpackCivilian = missionNamespace getVariable ["gRA_InventoryBackpackCivilian", []];
gRA_InventoryBackpackCivilianMedic = missionNamespace getVariable ["gRA_InventoryBackpackCivilianMedic", []];
gRA_InventoryBackpackCivilianUtility = missionNamespace getVariable ["gRA_InventoryBackpackCivilianUtility", []];
gRA_InventoryHeadgearHat = missionNamespace getVariable ["gRA_InventoryHeadgearHat", []];
gRA_InventoryHeadgearHelmet = missionNamespace getVariable ["gRA_InventoryHeadgearHelmet", []];
gRA_InventoryHeadgearLeader = missionNamespace getVariable ["gRA_InventoryHeadgearLeader", []];
gRA_InventoryHeadgearCivilian = missionNamespace getVariable ["gRA_InventoryHeadgearCivilian", []];
gRA_InventoryHeadgearCivilianMedic = missionNamespace getVariable ["gRA_InventoryHeadgearCivilianMedic", []];
gRA_InventoryHeadgearCivilianUtility = missionNamespace getVariable ["gRA_InventoryHeadgearCivilianUtility", []];
gRA_InventoryGlasses = missionNamespace getVariable ["gRA_InventoryGlasses", []];
gRA_InventoryVestPlain = missionNamespace getVariable ["gRA_InventoryVestPlain", []];
gRA_InventoryVestRig = missionNamespace getVariable ["gRA_InventoryVestRig", []];
gRA_InventoryVestArmor = missionNamespace getVariable ["gRA_InventoryVestArmor", []];
gRA_InventoryVestCivilian = missionNamespace getVariable ["gRA_InventoryVestCivilian", []];
gRA_InventoryVestCivilianMedic = missionNamespace getVariable ["gRA_InventoryVestCivilianMedic", []];
gRA_InventoryVestCivilianUtility = missionNamespace getVariable ["gRA_InventoryVestCivilianUtility", []];
gRA_InventoryThrowUtil = missionNamespace getVariable ["gRA_InventoryThrowUtil", []];
gRA_InventoryThrowGrenade = missionNamespace getVariable ["gRA_InventoryThrowGrenade", []];
gRA_InventoryFirstAidKit = missionNamespace getVariable ["gRA_InventoryFirstAidKit", []];
gRA_InventoryMedikit = missionNamespace getVariable ["gRA_InventoryMedikit", []];
gRA_InventoryToolkit = missionNamespace getVariable ["gRA_InventoryToolkit", []];
gRA_InventoryMagazines = missionNamespace getVariable ["gRA_InventoryMagazines", []];
gRA_InventoryMines = missionNamespace getVariable ["gRA_InventoryMines", []];
gRA_InventoryOptic = missionNamespace getVariable ["gRA_InventoryOptic", []];
gRA_InventoryLaser = missionNamespace getVariable ["gRA_InventoryLaser", []];
gRA_InventoryMuzzle = missionNamespace getVariable ["gRA_InventoryMuzzle", []];
gRA_InventoryBipod = missionNamespace getVariable ["gRA_InventoryBipod", []];
gRA_InventoryParachute = missionNamespace getVariable ["gRA_InventoryParachute", []];

gRA_InventoryWeaponAll = missionNamespace getVariable ["gRA_InventoryWeaponAll", []];
gRA_InventoryWeaponAA = missionNamespace getVariable ["gRA_InventoryWeaponAA", []];
gRA_InventoryWeaponAR = missionNamespace getVariable ["gRA_InventoryWeaponAR", []];
gRA_InventoryWeaponARGL = missionNamespace getVariable ["gRA_InventoryWeaponARGL", []];
gRA_InventoryWeaponARM = missionNamespace getVariable ["gRA_InventoryWeaponARM", []];
gRA_InventoryWeaponARSO = missionNamespace getVariable ["gRA_InventoryWeaponARSO", []];
gRA_InventoryWeaponARSW = missionNamespace getVariable ["gRA_InventoryWeaponARSW", []];
gRA_InventoryWeaponAT = missionNamespace getVariable ["gRA_InventoryWeaponAT", []];
gRA_InventoryWeaponCAR = missionNamespace getVariable ["gRA_InventoryWeaponCAR", []];
gRA_InventoryWeaponHG = missionNamespace getVariable ["gRA_InventoryWeaponHG", []];
gRA_InventoryWeaponLMG = missionNamespace getVariable ["gRA_InventoryWeaponLMG", []];
gRA_InventoryWeaponMMG = missionNamespace getVariable ["gRA_InventoryWeaponMMG", []];
gRA_InventoryWeaponSG = missionNamespace getVariable ["gRA_InventoryWeaponSG", []];
gRA_InventoryWeaponSMG = missionNamespace getVariable ["gRA_InventoryWeaponSMG", []];
gRA_InventoryWeaponSRL = missionNamespace getVariable ["gRA_InventoryWeaponSRL", []];
gRA_InventoryWeaponSRM = missionNamespace getVariable ["gRA_InventoryWeaponSRM", []];
gRA_InventoryWeaponSRSO = missionNamespace getVariable ["gRA_InventoryWeaponSRSO", []];
gRA_InventoryWeaponUW = missionNamespace getVariable ["gRA_InventoryWeaponUW", []];
/*
gRA_TempInventory = missionNamespace getVariable ["gRA_TempInventory", []];
gRA_TempInventory2 = missionNamespace getVariable ["gRA_TempInventory2", []];
gRA_TempInventory3 = missionNamespace getVariable ["gRA_TempInventory3", []];
*/
CRA_ItemReset = {
	gRA_IdentityFaces = [];
	gRA_IdentityVoice = [];
	gRA_ItemIndexCounter = -1;
	gRA_ItemIndex = [];
	gRA_ItemAmmoCounter = -1;
	gRA_ItemAmmo = [];
	gRA_ItemLevels = 16;
	gRA_ItemLevelBounds = [];
	gRA_InventoryAttachment = [];
	gRA_InventoryBackpackSmall = [];
	gRA_InventoryBackpackMedium = [];
	gRA_InventoryBackpackLarge = [];
	gRA_InventoryBackpackCivilian = [];
	gRA_InventoryBackpackCivilianMedic = [];
	gRA_InventoryBackpackCivilianUtility = [];
	gRA_InventoryHeadgearHat = [];
	gRA_InventoryHeadgearHelmet = [];
	gRA_InventoryHeadgearLeader = [];
	gRA_InventoryHeadgearCivilian = [];
	gRA_InventoryHeadgearCivilianMedic = [];
	gRA_InventoryHeadgearCivilianUtility = [];
	gRA_InventoryGlasses = [];
	gRA_InventoryVestPlain = [];
	gRA_InventoryVestRig = [];
	gRA_InventoryVestArmor = [];
	gRA_InventoryVestCivilian = [];
	gRA_InventoryVestCivilianMedic = [];
	gRA_InventoryVestCivilianUtility = [];
	gRA_InventoryThrowUtil = [];
	gRA_InventoryThrowGrenade = [];
	gRA_InventoryFirstAidKit = [];
	gRA_InventoryMedikit = [];
	gRA_InventoryToolkit = [];
	gRA_InventoryMagazines = [];
	gRA_InventoryMines = [];
	gRA_InventoryOptic = [];
	gRA_InventoryLaser = [];
	gRA_InventoryMuzzle = [];
	gRA_InventoryBipod = [];
	gRA_InventoryParachute = [];
	gRA_InventoryWeaponAll = [];
	gRA_InventoryWeaponAA = [];
	gRA_InventoryWeaponAR = [];
	gRA_InventoryWeaponARGL = [];
	gRA_InventoryWeaponARM = [];
	gRA_InventoryWeaponARSO = [];
	gRA_InventoryWeaponARSW = [];
	gRA_InventoryWeaponAT = [];
	gRA_InventoryWeaponCAR = [];
	gRA_InventoryWeaponHG = [];
	gRA_InventoryWeaponLMG = [];
	gRA_InventoryWeaponMMG = [];
	gRA_InventoryWeaponSG = [];
	gRA_InventoryWeaponSMG = [];
	gRA_InventoryWeaponSRL = [];
	gRA_InventoryWeaponSRM = [];
	gRA_InventoryWeaponSRSO = [];
	gRA_InventoryWeaponUW = [];
};
CRA_ItemInit = {
	gRA_ItemLevels = 16;
	private _indexMax = gRA_ItemLevels - 1;
	for [{private _i = 0}, {_i < gRA_ItemLevels}, {_i = _i + 1}] do {
		gRA_ItemLevelBounds pushBack [floor(_i / 2), _i + (ceil ((_indexMax - _i) / 6))];
		gRA_InventoryBackpackSmall pushBack [];
		gRA_InventoryBackpackMedium pushBack [];
		gRA_InventoryBackpackLarge pushBack [];
		gRA_InventoryHeadgearHelmet pushBack [];
		gRA_InventoryVestArmor pushBack [];
		gRA_InventoryOptic pushBack [];
		
		gRA_InventoryWeaponAll pushBack [];
		gRA_InventoryWeaponAA pushBack [];
		gRA_InventoryWeaponAR pushBack [];
		gRA_InventoryWeaponARGL pushBack [];
		gRA_InventoryWeaponARM pushBack [];
		gRA_InventoryWeaponARSO pushBack [];
		gRA_InventoryWeaponARSW pushBack [];
		gRA_InventoryWeaponAT pushBack [];
		gRA_InventoryWeaponCAR pushBack [];
		gRA_InventoryWeaponHG pushBack [];
		gRA_InventoryWeaponLMG pushBack [];
		gRA_InventoryWeaponMMG pushBack [];
		gRA_InventoryWeaponSG pushBack [];
		gRA_InventoryWeaponSMG pushBack [];
		gRA_InventoryWeaponSRL pushBack [];
		gRA_InventoryWeaponSRM pushBack [];
		gRA_InventoryWeaponSRSO pushBack [];
		gRA_InventoryWeaponUW pushBack [];
	};
	private _spanBackpackSmall = (CRA_ITEM_BACKPACK_SMALL_MAX - CRA_ITEM_BACKPACK_SMALL_MIN);
	private _spanBackpackMedium = (CRA_ITEM_BACKPACK_MEDIUM_MAX - CRA_ITEM_BACKPACK_MEDIUM_MIN);
	private _spanBackpackLarge = (CRA_ITEM_BACKPACK_LARGE_MAX - CRA_ITEM_BACKPACK_LARGE_MIN);
	private _spanHeadgearHelmet = CRA_ITEM_HEADGEAR_HELMET_MAX - CRA_ITEM_HEADGEAR_HELMET_MIN;
	private _spanVestArmor = CRA_ITEM_VEST_ARMOR_MAX - CRA_ITEM_VEST_ARMOR_MIN;
	{
		private _name = (configName _x);
		private _load = getNumber (_x >> "maximumLoad");
		if (_load > 0 && {CRA_ITEM_BACKPACK_EXCLUDE find _name == -1}) then {
			private _index = _name call CRA_ItemAdd;
			if (_load <= CRA_ITEM_BACKPACK_SMALL_MAX) then {[CRA_INDEX_BACKPACK_SMALL, _index, (_load - CRA_ITEM_BACKPACK_SMALL_MIN) / _spanBackpackSmall] call CRA_ItemRegister;};
			if (_load >= CRA_ITEM_BACKPACK_MEDIUM_MIN && _load <= CRA_ITEM_BACKPACK_MEDIUM_MAX) then {[CRA_INDEX_BACKPACK_MEDIUM, _index, (_load - CRA_ITEM_BACKPACK_MEDIUM_MIN) / _spanBackpackMedium] call CRA_ItemRegister;};
			if (_load >= CRA_ITEM_BACKPACK_LARGE_MIN) then {[CRA_INDEX_BACKPACK_LARGE, _index, (_load - CRA_ITEM_BACKPACK_LARGE_MIN) / _spanBackpackLarge] call CRA_ItemRegister;};
		};
	} forEach ("getNumber (_x >> 'scope') == 2 && getNumber (_x >> 'isBackpack') == 1" configClasses gCQ_CfgVehicles);
	{
		private _name = (configName _x);
		if (CRA_ITEM_HEADGEAR_EXCLUDE find _name == -1) then {
			private _index = _name call CRA_ItemAdd;
			private _armor = _x call CRA_ItemArmorUtil;
			if (_armor < CRA_ITEM_HEADGEAR_HELMET_MIN) then {
				[CRA_INDEX_HEADGEAR_HAT, _index, 0] call CRA_ItemRegister;
			} else {
				[CRA_INDEX_HEADGEAR_HELMET, _index, (_armor - CRA_ITEM_HEADGEAR_HELMET_MIN) / _spanHeadgearHelmet] call CRA_ItemRegister;
			};
		};
	} forEach ("getNumber (_x >> 'scope') == 2 && getNumber (_x >> 'ItemInfo' >> 'type') == 605" configClasses gCQ_CfgWeapons);
	{
		private _name = configName _x;
		if (CRA_ITEM_VEST_EXCLUDE find _name == -1) then {
			private _index = _name call CRA_ItemAdd;
			private _armor = _x call CRA_ItemArmorUtil;
			if (_armor < CRA_ITEM_VEST_ARMOR_MIN) then {
				private _load = getNumber (gCQ_CfgVehicles >> (getText (_x >> "ItemInfo" >> "containerClass")) >> "maximumLoad");
				if (_load <= CRA_ITEM_VEST_PLAIN_MAX) then {[CRA_INDEX_VEST_PLAIN, _index, 0] call CRA_ItemRegister;};
				if (_load >= CRA_ITEM_VEST_RIG_MIN) then {[CRA_INDEX_VEST_RIG, _index, 0] call CRA_ItemRegister;};
			} else {
				[CRA_INDEX_VEST_ARMOR, _index, (_armor - CRA_ITEM_VEST_ARMOR_MIN) / _spanVestArmor] call CRA_ItemRegister;
			};
		};
	} forEach ("getNumber (_x >> 'scope') == 2 && getNumber (_x >> 'ItemInfo' >> 'type') == 701" configClasses gCQ_CfgWeapons);
	{
		private _name = configName _x;
		if (CRA_ITEM_GLASSES_EXCLUDE find _name == -1) then {[CRA_INDEX_GLASSES, _name call CRA_ItemAdd, 0] call CRA_ItemRegister;};
	} forEach ("getNumber (_x >> 'scope') == 2" configClasses gCQ_CfgGlasses);
	{[CRA_INDEX_BACKPACK_CIVILIAN, _x call CRA_ItemAdd, 0] call CRA_ItemRegister;} forEach CRA_ITEM_BACKPACK_CIVILIAN;
	{[CRA_INDEX_BACKPACK_CIVILIAN_MEDIC, _x call CRA_ItemAdd, 0] call CRA_ItemRegister;} forEach CRA_ITEM_BACKPACK_CIVILIAN_MEDIC;
	{[CRA_INDEX_BACKPACK_CIVILIAN_UTILITY, _x call CRA_ItemAdd, 0] call CRA_ItemRegister;} forEach CRA_ITEM_BACKPACK_CIVILIAN_UTILITY;
	{[CRA_INDEX_VEST_CIVILIAN, _x call CRA_ItemAdd, 0] call CRA_ItemRegister;} forEach CRA_ITEM_VEST_CIVILIAN;
	{[CRA_INDEX_VEST_CIVILIAN_MEDIC, _x call CRA_ItemAdd, 0] call CRA_ItemRegister;} forEach CRA_ITEM_VEST_CIVILIAN_MEDIC;
	{[CRA_INDEX_VEST_CIVILIAN_UTILITY, _x call CRA_ItemAdd, 0] call CRA_ItemRegister;} forEach CRA_ITEM_VEST_CIVILIAN_UTILITY;
	{[CRA_INDEX_HEADGEAR_CIVILIAN, _x call CRA_ItemAdd, 0] call CRA_ItemRegister;} forEach CRA_ITEM_HEADGEAR_CIVILIAN;
	{[CRA_INDEX_HEADGEAR_CIVILIAN_MEDIC, _x call CRA_ItemAdd, 0] call CRA_ItemRegister;} forEach CRA_ITEM_HEADGEAR_CIVILIAN_MEDIC;
	{[CRA_INDEX_HEADGEAR_CIVILIAN_UTILITY, _x call CRA_ItemAdd, 0] call CRA_ItemRegister;} forEach CRA_ITEM_HEADGEAR_CIVILIAN_UTILITY;
	{[CRA_INDEX_HEADGEAR_LEADER, _x call CRA_ItemAdd, 0] call CRA_ItemRegister;} forEach CRA_ITEM_HEADGEAR_LEADER;
	{[CRA_INDEX_FIRSTAIDKIT, _x call CRA_ItemAdd, 0] call CRA_ItemRegister;} forEach ["FirstAidKit"];
	{[CRA_INDEX_MEDIKIT, _x call CRA_ItemAdd, 0] call CRA_ItemRegister;} forEach ["Medikit"];
	{[CRA_INDEX_TOOLKIT, _x call CRA_ItemAdd, 0] call CRA_ItemRegister;} forEach ["Toolkit"];
	{[CRA_INDEX_PARACHUTE, _x call CRA_ItemAdd, 0] call CRA_ItemRegister;} forEach ["B_Parachute"];
	private _configThrow = gCQ_CfgWeapons >> "Throw";
	{
		{
			private _configGrenade = gCQ_CfgMagazines >> _x;
			if (getNumber (_configGrenade >> "scope") == 2 && {CRA_ITEM_THROW_EXCLUDE find _x == -1}) then { // TODO IR Grenades come in side flavors, (how) does this have to be assessed? EDIT: excluded for now
				private _type = if (getNumber (gCQ_CfgAmmo >> (getText (_configGrenade >> "ammo")) >> "hit") > 0) then {CRA_INDEX_THROW_GRENADE} else {CRA_INDEX_THROW_UTIL};
				[_type, _configGrenade call CRA_ItemMagAdd, 0] call CRA_ItemRegister;
			};
		} forEach (getArray (_configThrow >> _x >> "magazines"));
	} forEach (getArray (_configThrow >> "muzzles"));
	private _configMine = gCQ_CfgWeapons >> "Put";
	{
		{
			private _configMine = gCQ_CfgMagazines >> _x;
			if (getNumber (_configMine >> "scope") == 2) then {[CRA_INDEX_MINE, _configMine call CRA_ItemMagAdd, 0] call CRA_ItemRegister;};
		} forEach (getArray (_configMine >> _x >> "magazines"));
	} forEach (getArray (_configMine >> "muzzles"));
	
	private _cache = [];
	{
		private _type = getNumber (_x >> "type");
		if (_type == 1 || {_type == 2 || {_type == 4}}) then {
			private _name = (configName _x) call BIS_fnc_baseWeapon; 
			if (_cache find _name != -1 || {CRA_WEAPON_EXCLUDE find _name != -1}) exitWith {};
			private _weapon = (gCQ_CfgWeapons >> _name) call CRA_ItemWeaponAnalysis;
			private _index = _weapon call CRA_ItemAdd;
			private _type = _weapon#1#0;
			[_type, _index, _weapon#1#1] call CRA_ItemRegister;
			if (_type != CRA_INDEX_WEAPON_AA && _type != CRA_INDEX_WEAPON_AT) then {[CRA_INDEX_WEAPON_ALL, _index, _weapon#1#1] call CRA_ItemRegister;};
		};
	} forEach ("getNumber (_x >> 'scope') == 2" configClasses (gCQ_CfgWeapons));
	/*
	{
		private _config = _x;
		{
			if (CRA_WEAPON_FILTER find (configName _x) == -1) exitWith {
				private _name = configName _config;
				if (CRA_WEAPON_EXCLUDE find _name != -1) exitWith {};
				private _weapon = _config call CRA_ItemWeaponAnalysis;
				private _index = _weapon call CRA_ItemAdd;
				private _type = _weapon#1#0;
				[_type, _index, _weapon#1#1] call CRA_ItemRegister;
				if (_type != CRA_INDEX_WEAPON_AA && _type != CRA_INDEX_WEAPON_AT) then {[CRA_INDEX_WEAPON_ALL, _index, _weapon#1#1] call CRA_ItemRegister;};
			};
		} forEach (configProperties [_config, "true", false]);
	} forEach ("getNumber (_x >> 'scope') == 2 && (getNumber (_x >> 'type') == 1 || getNumber (_x >> 'type') == 2 || getNumber (_x >> 'type') == 4)" configClasses (gCQ_CfgWeapons));
	*/
};
CRA_ItemAdd = {
	gRA_ItemIndexCounter = gRA_ItemIndexCounter + 1;
	gRA_ItemIndex pushBack _this;
	gRA_ItemIndexCounter
};
CRA_ItemMagAdd = {
	private _name = configName _this;
	private _count = getNumber (_this >> "count");
	private _speed = getNumber (_this >> "initSpeed");
	([_name, _count, (getText (_this >> "ammo")) call CRA_ItemAmmoAnalysis, _speed] call CRA_ItemAdd)
	
};

CRA_ItemMagAnalysis = {
	private _index = -1;
	{if (_this == (gRA_ItemIndex#_x#0)) exitWith {_index = _x;};} forEach gRA_InventoryMagazines;
	if (_index == -1) then {
		_index = ((gCQ_CfgMagazines >> _this) call CRA_ItemMagAdd);
		[CRA_INDEX_MAGAZINE, _index, 0] call CRA_ItemRegister;
	};
	_index
};
CRA_ItemAmmoAnalysis = {
	private _index = -1;
	{if (_this == (_x#0)) exitWith {_index = _forEachIndex;};} forEach gRA_ItemAmmo;
	if (_index == -1) then {
		private _config = gCQ_CfgAmmo >> _this;
		private _data = switch (getText (_config >> "simulation")) do {
			case "shotBullet": {[_this, CRA_AMMO_BULLET]};
			case "shotMissile": {[_this, CRA_AMMO_MISSILE]};
			case "shotRocket": {[_this, CRA_AMMO_ROCKET]};
			case "shotSmokeX"; case "shotGrenade": {[_this, CRA_AMMO_GRENADE]};
			case "shotSmoke"; case "shotShell": {[_this, CRA_AMMO_SHELL]};
			case "shotCM": {[_this, CRA_AMMO_COUNTER]};
			case "laserDesignate": {[_this, CRA_AMMO_LASER]};
			default {[_this, -1]};
		};
		switch (_data#1) do {
			case CRA_AMMO_BULLET: {
				private _count = 1;
				private _submunition = getText (_config >> "submunitionAmmo");
				if (_submunition isNotEqualTo "") then {
					_count = (getArray (_config >> "submunitionConeType"))#1;
					_config = gCQ_CfgAmmo >> _submunition;
				};
				private _hit = getNumber (_config >> "hit");
				private _caliber = getNumber (_config >> "caliber");
				private _speed = getNumber (_config >> "typicalSpeed");
				private _friction = (sqrt (-1 * (getNumber (_config >> "airFriction")))) * 1000000;
				private _quality = _hit * _caliber * _speed / _friction;
				_data append [_quality, _count, _hit, _caliber, _speed, _friction];
			};
			case CRA_AMMO_SHELL: {
				private _hit = getNumber (_config >> "hit");
				private _caliber = getNumber (_config >> "caliber");
				private _indirectHit = getNumber (_config >> "indirectHit");
				private _indirectRange = getNumber (_config >> "indirectHitRange");
				private _penetratorHit = 0;
				private _penetratorCaliber = 0;
				private _penetrator = getText (_config >> "submunitionAmmo");
				if (_penetrator isNotEqualTo "") then {
					private _configPenetrator = gCQ_CfgAmmo >> _penetrator;
					_penetratorHit = getNumber (_configPenetrator >> "hit");
					_penetratorCaliber = getNumber (_configPenetrator >> "caliber");
				};
				private _quality = (_hit * (_caliber / 10) + (_indirectHit * (_indirectRange / 10)) + _penetratorHit * (_penetratorCaliber / 100)) / 600;
				_data append [_quality];
			};
			case CRA_AMMO_MISSILE;
			case CRA_AMMO_ROCKET: {
				private _antiAir = (getNumber (_config >> "airLock")) == 2;
				private _hit = getNumber (_config >> "hit");
				private _indirectHit = getNumber (_config >> "indirectHit");
				private _indirectRange = getNumber (_config >> "indirectHitRange");
				private _penetratorHit = 0;
				private _penetratorCaliber = 0;
				private _penetrator = getText (_config >> "submunitionAmmo");
				if (_penetrator isNotEqualTo "") then {
					private _configPenetrator = gCQ_CfgAmmo >> _penetrator;
					_penetratorHit = getNumber (_configPenetrator >> "hit");
					_penetratorCaliber = getNumber (_configPenetrator >> "caliber");
				};
				private _quality = (_hit + (_indirectHit * (_indirectRange / 10)) + _penetratorHit * (_penetratorCaliber / 100)) / 600;
				_data append [_quality, _antiAir];
			};
			default {
				_data append [0];
			};
		};
		gRA_ItemAmmoCounter = gRA_ItemAmmoCounter + 1;
		gRA_ItemAmmo pushBack _data;
		_index = gRA_ItemAmmoCounter;
	};
	_index
};
CRA_ItemWeaponMagAnalysis = {
	private _magazines = (getArray (_this >> "magazines"));
	{
		private _configWell = gCQ_CfgMagazineWells >> _x;
		_magazines append (getArray (_configWell >> "BI_Magazines"));
		_magazines append (getArray (_configWell >> "BI_Enoch_Magazines"));
	} forEach (getArray (_this >> "magazineWell"));
	_magazines = _magazines arrayIntersect _magazines;
	private _primaryMags = [];
	{_primaryMags pushBack (_x call CRA_ItemMagAnalysis);} forEach _magazines;
	_primaryMags
};
CRA_DebugWeapon = {
	private _weapons = [];
	{_weapons append _x;} forEach _this;
	_weapons = _weapons arrayIntersect _weapons;
	private _output = [];
	{_output pushBack (gRA_ItemIndex#_x);} forEach _weapons;
	_output
};
CRA_ItemWeaponAnalysis = {
	private _name = configName _this;
	
	private _primaryMags = _this call CRA_ItemWeaponMagAnalysis;
	private _secondaryMags = [];
	private _prefMag = if (_primaryMags isNotEqualTo []) then {gRA_ItemIndex#(_primaryMags#0)} else {[]};
	private _prefAmmo = if (_prefMag isNotEqualTo []) then {gRA_ItemAmmo#(_prefMag#2)} else {[]};
	
	private _type = -1;
	private _quality = 0;
	private _attachments = [[],[],[],[]];
	private _biType = getNumber (_this >> "type");
	{if ((_x#0) == _name) exitWith {_biType = _x#1;};} forEach CRA_WEAPON_TYPE_OVERRIDE;
	switch (_biType) do {
		default {};
		case 0: { // appears as if all GLs have this type
			_type = CRA_INDEX_WEAPON_GL;
		};
		case 2: {
			if (getNumber (_this >> "canShootInWater") == 1) exitWith {_type = CRA_INDEX_WEAPON_UW;};
			_type = CRA_INDEX_WEAPON_HG;
		};
		case 1: {
			if (getNumber (_this >> "canShootInWater") == 1) exitWith {_type = CRA_INDEX_WEAPON_UW;};
			
			{if (((gRA_ItemAmmo#(gRA_ItemIndex#_x#2))#3) > 1) exitWith {_type = CRA_INDEX_WEAPON_SG;};} forEach _primaryMags;
			if (_type != -1) exitWith {};
			
			private _muzzles = getArray (_this >> "muzzles");
			if (count _muzzles > 1) exitWith {
				_type = CRA_INDEX_WEAPON_ARSO;
				{
					if (_x != "this") then {
						private _muzzleWeapon = (_this >> _x) call CRA_ItemWeaponAnalysis;
						if ((_muzzleWeapon#1#0) == CRA_INDEX_WEAPON_GL) then {_type = CRA_INDEX_WEAPON_ARGL;};
						_secondaryMags append (_muzzleWeapon#3);
					};
				} forEach _muzzles;
			};
			
	
			private _impact = (_prefAmmo#2);
			private _options = switch (true) do {
				case (_impact <= 0.10): {[CRA_INDEX_WEAPON_SMG]};
				case (_impact > 0.10 && _impact <= 0.40): {[CRA_INDEX_WEAPON_AR,CRA_INDEX_WEAPON_ARM,CRA_INDEX_WEAPON_ARSW,CRA_INDEX_WEAPON_CAR,CRA_INDEX_WEAPON_LMG]};
				case (_impact > 0.40 && _impact <= 0.60): {[CRA_INDEX_WEAPON_MMG,CRA_INDEX_WEAPON_SRM]};
				case (_impact > 0.60 && _impact <= 1.50): {[CRA_INDEX_WEAPON_MMG,CRA_INDEX_WEAPON_SRSO]};
				case (_impact > 1.50): {[CRA_INDEX_WEAPON_MMG,CRA_INDEX_WEAPON_SRL]};
				default {[]};
			};
			
			private _modes = [];
			{
				private _configMode = (_this >> _x);
				if ((getNumber (_configMode >> "showToPlayer")) == 1) then {
					private _type = if (getNumber (_configMode >> "autoFire") == 1) then {CRA_WEAPON_MODE_AUTO} else {if (getNumber (_configMode >> "burst") > 1) then {CRA_WEAPON_MODE_BURST} else {CRA_WEAPON_MODE_SINGLE}};
					_modes pushBack _type;
				};
			} forEach (getArray (_this >> "modes"));
			if (_modes find CRA_WEAPON_MODE_AUTO == -1) then {
				_options = _options - [CRA_INDEX_WEAPON_ARSW,CRA_INDEX_WEAPON_LMG,CRA_INDEX_WEAPON_MMG,CRA_INDEX_WEAPON_SMG];
			} else {
				_options = _options - [CRA_INDEX_WEAPON_SRL];
			};
			
			private _rounds = (_prefMag#1);
			if (_rounds > 100) then {_options = _options arrayIntersect [CRA_INDEX_WEAPON_LMG,CRA_INDEX_WEAPON_MMG];};
			if (_rounds > 30 && _rounds <= 100) then {_options = _options arrayIntersect [CRA_INDEX_WEAPON_ARSW,CRA_INDEX_WEAPON_SMG];};
			if (_rounds <= 30) then {_options = _options arrayIntersect [CRA_INDEX_WEAPON_AR,CRA_INDEX_WEAPON_ARGL,CRA_INDEX_WEAPON_ARM,CRA_INDEX_WEAPON_ARSO,CRA_INDEX_WEAPON_CAR,CRA_INDEX_WEAPON_SG,CRA_INDEX_WEAPON_SMG,CRA_INDEX_WEAPON_SRM,CRA_INDEX_WEAPON_SRL,CRA_INDEX_WEAPON_SRSO];};
			
			private _initSpeed = getNumber (_this >> "initSpeed");
			if (_initSpeed <= 0) then {_initSpeed = if (_initSpeed < 0) then {-1 * _initSpeed * (_prefMag#3)} else {(_prefMag#3)};};
			private _qualitySpeed = _initSpeed / (_prefAmmo#6);
			if (_qualitySpeed < 0.925) then {_options = _options - [CRA_INDEX_WEAPON_AR];};
			if (_qualitySpeed < 1.075) then {_options = _options - [CRA_INDEX_WEAPON_ARM];};
			if (_qualitySpeed > 0.925) then {_options = _options - [CRA_INDEX_WEAPON_CAR];};
			if (_qualitySpeed > 1.075) then {_options = _options - [CRA_INDEX_WEAPON_AR];};
			
			if (_options isNotEqualTo []) then {_type = _options#0;};
		};
		case 4: {
			private _antiAir = false;
			{if ((gRA_ItemAmmo#(gRA_ItemIndex#_x#2))#3) exitWith {_antiAir = true;};} forEach _primaryMags;
			_type = if (_antiAir) then {CRA_INDEX_WEAPON_AA} else {CRA_INDEX_WEAPON_AT};
		};
		case 65536: {
			private _impact = 0;
			if (_primaryMags isEqualTo []) then {
				{if (_x != "this") then {_primaryMags append ((_this >> _x) call CRA_ItemWeaponMagAnalysis);};} forEach (getArray (_this >> "muzzles"));
			};
			private _bestMag = -1;
			private _bestImpact = -1;
			{
				private _ammo = gRA_ItemAmmo#(gRA_ItemIndex#_x#2);
				if ((_ammo#2) > _bestImpact) then {_bestImpact = _ammo#2; _bestMag = _x;};
			} forEach _primaryMags;
			_prefMag = if (_bestMag != -1) then {gRA_ItemIndex#(_bestMag)} else {[]};
			_prefAmmo = if (_prefMag isNotEqualTo []) then {gRA_ItemAmmo#(_prefMag#2)} else {[]};
			if (_prefAmmo isNotEqualTo []) then {
				_impact = _prefAmmo#2;
				switch (_prefAmmo#1) do {
					case CRA_AMMO_BULLET: {
						_type = switch (true) do {
							case (_impact <= 0.40): {CRA_INDEX_VWEAPON_LMG};
							case (_impact > 0.40 && _impact <= 1.50): {CRA_INDEX_VWEAPON_MMG};
							case (_impact > 1.50 && _impact <= 3.00): {CRA_INDEX_VWEAPON_HMG};
							case (_impact > 3.00 && _impact <= 50.00): {CRA_INDEX_VWEAPON_GAT_HE};
							case (_impact > 50.00): {CRA_INDEX_VWEAPON_GAT_AP};
							default {[]};
						};
					};
					case CRA_AMMO_SHELL: {
						_type = switch (true) do {
							case (_impact <= 0.12): {CRA_INDEX_VWEAPON_GMG};
							case (_impact > 0.12): {CRA_INDEX_VWEAPON_CAN};
							default {[]};
						};
					};
					case CRA_AMMO_ROCKET;
					case CRA_AMMO_MISSILE: {
						private _antiAir = false;
						{if ((gRA_ItemAmmo#(gRA_ItemIndex#_x#2))#3) exitWith {_antiAir = true;};} forEach _primaryMags;
						_type = if (_antiAir) then {CRA_INDEX_VWEAPON_RPG_AA} else {CRA_INDEX_VWEAPON_RPG_AT};
					};
					case CRA_AMMO_LASER;
					case CRA_AMMO_COUNTER: {
						_type = CRA_INDEX_VWEAPON_IGNORE;
					};
				};
			} else {
				_type = CRA_INDEX_VWEAPON_IGNORE; // probably car horn
			};
			_quality = _impact;
		};
	};
	switch (_type) do {
		default {};
		case CRA_INDEX_WEAPON_AA;
		case CRA_INDEX_WEAPON_AR;
		case CRA_INDEX_WEAPON_ARGL;
		case CRA_INDEX_WEAPON_ARM;
		case CRA_INDEX_WEAPON_ARSO;
		case CRA_INDEX_WEAPON_ARSW;
		case CRA_INDEX_WEAPON_AT;
		case CRA_INDEX_WEAPON_CAR;
		case CRA_INDEX_WEAPON_HG;
		case CRA_INDEX_WEAPON_LMG;
		case CRA_INDEX_WEAPON_MMG;
		case CRA_INDEX_WEAPON_SG;
		case CRA_INDEX_WEAPON_SMG;
		case CRA_INDEX_WEAPON_SRL;
		case CRA_INDEX_WEAPON_SRM;
		case CRA_INDEX_WEAPON_SRSO;
		case CRA_INDEX_WEAPON_UW: {
			private _base = CRA_WEAPON_ATTACHMENT;
			switch (_type) do {
				case CRA_INDEX_WEAPON_ARM: {_base = CRA_WEAPON_ATTACHMENT_SR;};
				case CRA_INDEX_WEAPON_CAR: {_base = CRA_WEAPON_ATTACHMENT_CAR;};
				case CRA_INDEX_WEAPON_HG: {_base = CRA_WEAPON_ATTACHMENT_HG;};
				case CRA_INDEX_WEAPON_SG: {_base = CRA_WEAPON_ATTACHMENT_SG;};
				case CRA_INDEX_WEAPON_SMG: {_base = CRA_WEAPON_ATTACHMENT_SMG;};
				case CRA_INDEX_WEAPON_SRL: {_base = CRA_WEAPON_ATTACHMENT_SR;};
				case CRA_INDEX_WEAPON_SRM: {_base = CRA_WEAPON_ATTACHMENT_SR;};
				case CRA_INDEX_WEAPON_SRSO: {_base = CRA_WEAPON_ATTACHMENT_SR;};
				default {};
			};
			
			private _configSlots = _this >> "WeaponSlotsInfo";
			{
				private _config = _configSlots >> _x >> "compatibleItems";
				if (!isNull _config) then {
					private _slotIndex = _forEachIndex;
					{
						if (getNumber _x == 1) then {
							private _attachmentIndex = (configName _x) call CRA_ItemAttachmentAnalysis;
							private _attachment = gRA_ItemIndex#_attachmentIndex;
							if ((_base#_slotIndex) find (_attachment#2#0) != -1) then {(_attachments#_slotIndex) pushBack _attachmentIndex;};
						};
					} forEach (configProperties [_config, "true", false]);
				};
			} forEach ["CowsSlot", "PointerSlot", "MuzzleSlot", "UnderBarrelSlot"];
			
			/*
			{
				private _attachmentIndex = _x call CRA_ItemAttachmentAnalysis;
				private _attachment = gRA_ItemIndex#_attachmentIndex;
				private _slotIndex = switch (_attachment#1#0) do {case CRA_INDEX_OPTIC: {0}; case CRA_INDEX_LASER: {1}; case CRA_INDEX_MUZZLE: {2}; case CRA_INDEX_BIPOD: {3}; default {-1};};
				if ((_base#_slotIndex) find (_attachment#2#0) != -1) then {(_attachments#_slotIndex) pushBack _attachmentIndex;};
			} forEach (_name call BIS_fnc_compatibleItems);
			*/
		};
	};
	switch (_type) do {
		default {};
		case CRA_INDEX_VWEAPON_GMG;
		case CRA_INDEX_VWEAPON_CAN: {
			private _impact = 0;
			{
				private _ammo = gRA_ItemAmmo#(gRA_ItemIndex#_x#2);
				if ((_ammo#2) > _impact) then {_impact = _ammo#2;};
			} forEach _primaryMags;
			private _base =  switch (_type) do {
				case CRA_INDEX_VWEAPON_GMG: {CRA_VWEAPON_QUALITY_GMG};
				case CRA_INDEX_VWEAPON_CAN: {CRA_VWEAPON_QUALITY_CAN};
				default {CRA_VWEAPON_QUALITY};
			};
			private _factors = [_impact];
			_quality = [_base, _factors] call CRA_ItemQuality;
		};
		case CRA_INDEX_VWEAPON_RPG_AT;
		case CRA_INDEX_VWEAPON_RPG_AA;
		case CRA_INDEX_WEAPON_AA;
		case CRA_INDEX_WEAPON_AT: { // TODO optics, etc.
			private _lock = if (getNumber (_this >> "canLock") == 2) then {1} else {0};
			private _missile = 0;
			private _impact = 0;
			{
				private _ammo = gRA_ItemAmmo#(gRA_ItemIndex#_x#2);
				if ((_ammo#1) == CRA_AMMO_MISSILE) then {_missile = 1;};
				if ((_ammo#2) > _impact) then {_impact = _ammo#2;};
			} forEach _primaryMags;
			private _base =  switch (_type) do {
				case CRA_INDEX_WEAPON_AA: {CRA_WEAPON_QUALITY_RPG_AA};
				case CRA_INDEX_WEAPON_AT: {CRA_WEAPON_QUALITY_RPG_AT};
				case CRA_INDEX_VWEAPON_RPG_AA: {CRA_VWEAPON_QUALITY_RPG_AA};
				case CRA_INDEX_VWEAPON_RPG_AT: {CRA_VWEAPON_QUALITY_RPG_AT};
				default {CRA_WEAPON_QUALITY_RPG};
			};
			private _factors = [_impact, sqrt (_missile + _lock), 0];
			_quality = [_base, _factors] call CRA_ItemQuality;
		};
		case CRA_INDEX_WEAPON_AR;
		case CRA_INDEX_WEAPON_ARGL;
		case CRA_INDEX_WEAPON_ARM;
		case CRA_INDEX_WEAPON_ARSO;
		case CRA_INDEX_WEAPON_ARSW;
		case CRA_INDEX_WEAPON_CAR;
		case CRA_INDEX_WEAPON_HG;
		case CRA_INDEX_WEAPON_LMG;
		case CRA_INDEX_WEAPON_MMG;
		case CRA_INDEX_WEAPON_SG;
		case CRA_INDEX_WEAPON_SMG;
		case CRA_INDEX_WEAPON_SRL;
		case CRA_INDEX_WEAPON_SRM;
		case CRA_INDEX_WEAPON_SRSO;
		case CRA_INDEX_WEAPON_UW: { // TODO handling, ROF, etc.
			private _impact = (_prefAmmo#2);
			private _initSpeed = getNumber (_this >> "initSpeed");
			if (_initSpeed <= 0) then {_initSpeed = if (_initSpeed < 0) then {-1 * _initSpeed * (_prefMag#3)} else {(_prefMag#3)};};
			private _qualitySpeed = _initSpeed / (_prefAmmo#6);
			private _qualityImpact = _qualitySpeed * _impact;
			private _factors = [_qualityImpact, _prefMag#1];
			private _base = switch (_type) do {
				case CRA_INDEX_WEAPON_AR: {CRA_WEAPON_QUALITY_AR};
				case CRA_INDEX_WEAPON_ARGL: {CRA_WEAPON_QUALITY_ARGL};
				case CRA_INDEX_WEAPON_ARM: {CRA_WEAPON_QUALITY_ARM};
				case CRA_INDEX_WEAPON_ARSO: {CRA_WEAPON_QUALITY_ARSO};
				case CRA_INDEX_WEAPON_ARSW: {CRA_WEAPON_QUALITY_ARSW};
				case CRA_INDEX_WEAPON_CAR: {CRA_WEAPON_QUALITY_CAR};
				case CRA_INDEX_WEAPON_HG: {CRA_WEAPON_QUALITY_HG};
				case CRA_INDEX_WEAPON_LMG: {CRA_WEAPON_QUALITY_LMG};
				case CRA_INDEX_WEAPON_MMG: {CRA_WEAPON_QUALITY_MMG};
				case CRA_INDEX_WEAPON_SG: {CRA_WEAPON_QUALITY_SG};
				case CRA_INDEX_WEAPON_SMG: {CRA_WEAPON_QUALITY_SMG};
				case CRA_INDEX_WEAPON_SRL: {CRA_WEAPON_QUALITY_SRL};
				case CRA_INDEX_WEAPON_SRM: {CRA_WEAPON_QUALITY_SRM};
				case CRA_INDEX_WEAPON_SRSO: {CRA_WEAPON_QUALITY_SRSO};
				case CRA_INDEX_WEAPON_UW: {CRA_WEAPON_QUALITY_UW};
				default {CRA_WEAPON_QUALITY};
			};
			_quality = [_base, _factors] call CRA_ItemQuality;
		};
		case CRA_INDEX_VWEAPON_LMG;
		case CRA_INDEX_VWEAPON_MMG;
		case CRA_INDEX_VWEAPON_HMG;
		case CRA_INDEX_VWEAPON_GAT_HE;
		case CRA_INDEX_VWEAPON_GAT_AP: {
			private _impact = (_prefAmmo#2);
			private _initSpeed = getNumber (_this >> "initSpeed");
			if (_initSpeed <= 0) then {_initSpeed = if (_initSpeed < 0) then {-1 * _initSpeed * (_prefMag#3)} else {(_prefMag#3)};};
			private _qualitySpeed = _initSpeed / (_prefAmmo#6);
			private _qualityImpact = _qualitySpeed * _impact;
			private _factors = [_qualityImpact];
			private _base = switch (_type) do {
				case CRA_INDEX_VWEAPON_LMG: {CRA_VWEAPON_QUALITY_LMG};
				case CRA_INDEX_VWEAPON_MMG: {CRA_VWEAPON_QUALITY_MMG};
				case CRA_INDEX_VWEAPON_HMG: {CRA_VWEAPON_QUALITY_HMG};
				case CRA_INDEX_VWEAPON_GAT_HE: {CRA_VWEAPON_QUALITY_GAT_HE};
				case CRA_INDEX_VWEAPON_GAT_AP: {CRA_VWEAPON_QUALITY_GAT_AP};
				default {CRA_VWEAPON_QUALITY};
			};
			_quality = [_base, _factors] call CRA_ItemQuality;
		};
	};
	[_name, [_type, _quality], _attachments, _primaryMags, _secondaryMags]
};
CRA_ItemQuality = {
	params ["_base", "_factors"];
	_quality = 0;
	{_quality = _quality + ((_x#0) * ((_factors#_forEachIndex) / (_x#1)));} forEach (_base#1);
	((((_base#0#1) + (_base#0#0)) / 2) + (((_base#0#1) - (_base#0#0)) * 2 * (_quality - 1)))
};
CRA_ItemWeaponHandling = {
	[(getNumber (_this >> "dexterity")), (getNumber (_this >> "inertia")), (getNumber (_this >> "WeaponSlotsInfo" >> "mass"))]
};
CRA_ItemWeaponModes = {
	private _mode = [];
	private _rate = [];
	private _disp = [];
	{
		private _configMode = (_this >> _x);
		if ((getNumber (_configMode >> "showToPlayer")) == 1) then {
			private _type = if (getNumber (_configMode >> "autoFire") == 1) then {CRA_WEAPON_MODE_AUTO} else {if (getNumber (_configMode >> "burst") > 1) then {CRA_WEAPON_MODE_BURST} else {CRA_WEAPON_MODE_SINGLE}};
			_mode pushBack _type;
			_rate pushBack (60 / (getNumber (_configMode >> "reloadTime")));
			_disp pushBack (getNumber (_configMode >> "dispersion"));
		};
	} forEach (getArray (_this >> "modes"));
	[_mode, _rate, _disp]
};
CRA_ItemAttachmentAdd = {
	private _name = configName _this;
	private _configItem = _this >> "ItemInfo";
	private _type = -1;
	private _quality = 0;
	private _data = [];
	switch (getNumber (_configItem >> "type")) do {
		case 201: {
			_type = CRA_INDEX_OPTIC;
			_data pushBack getNumber (_configItem >> "opticType");
			_data pushBack [];
			{
				private _zeroing = getArray (_x >> "discreteDistance");
				private _zoomMin = getNumber (_x >> "distanceZoomMin");
				private _zoomMax = getNumber (_x >> "distanceZoomMax");
				private _range = [];
				if (_zeroing isEqualTo []) then {
					_range pushBack _zoomMin;
					_range pushBack ((_zoomMin + _zoomMax) / 2);
					_range pushBack _zoomMax;
				} else {
					private _min = selectMin _zeroing;
					private _max = selectMax _zeroing;
					_range pushBack _min;
					if ((_data#0) != 0) then {
						_range pushBack ((_min + _max) /2);
					} else {
						_range pushBack (_zeroing#(getNumber (_x >> "discreteDistanceInitIndex")));
					};
					_range pushBack _max;
				};
				private _modeNVG = 0;
				private _modeTI = 0;
				{switch (true) do {case (_x == "NVG"): {_modeNVG = CRA_OPTIC_NVG;}; case (_x == "Ti"): {_modeTI = CRA_OPTIC_TI;}; default {};};} forEach (getArray (_x >> "visionMode"));
				(_data#1) pushBack [(_modeNVG + _modeTI), _range];
			} forEach (configProperties [_configItem >> "OpticsModes", "true", false]);
			
			private _base = switch (_data#0) do {default {CRA_OPTIC_QUALITY_0}; case 1: {CRA_OPTIC_QUALITY_1}; case 2: {CRA_OPTIC_QUALITY_2};};
			private _bestMode = 0;
			private _bestRange = 0;
			private _baseRange = (_base#1#1#1);
			{
				if ((_x#0) > _bestMode) then {_bestMode = _x#0;};
				private _range = (_x#1#1) / _baseRange;
				if (_range > _bestRange) then {_bestRange = _range;};
			} forEach (_data#1);
			private _factors = [sqrt (count (_data#1)), (sqrt _bestRange) * _baseRange, sqrt _bestMode];
			_quality = [_base, _factors] call CRA_ItemQuality;
		};
		case 301: {
			_type = CRA_INDEX_LASER;
			_data pushBack 0;
		};
		case 101: {
			_type = CRA_INDEX_MUZZLE;
			_data pushBack 0;
		};
		case 302: {
			_type = CRA_INDEX_BIPOD;
			_data pushBack 0;
		};
		default {};
	};
	private _index = [_name, [_type, _quality], _data] call CRA_ItemAdd;
	gRA_InventoryAttachment pushBack _index;
	_index
};
CRA_ItemAttachmentAnalysis = {
	private _index = -1;
	{if (_this == (gRA_ItemIndex#_x#0)) exitWith {_index = _x;};} forEach gRA_InventoryAttachment;
	if (_index == -1) then {
		_index = ((gCQ_CfgWeapons >> _this) call CRA_ItemAttachmentAdd);
		private _attachment = gRA_ItemIndex#_index;
		[_attachment#1#0, _index, _attachment#1#1] call CRA_ItemRegister;
	};
	_index
};

CRA_ItemRegister = {
	params ["_type", "_index", "_argv"];
	switch (_type) do {
		case CRA_INDEX_HEADGEAR_HAT: {gRA_InventoryHeadgearHat pushBack _index;};
		case CRA_INDEX_HEADGEAR_LEADER: {gRA_InventoryHeadgearLeader pushBack _index;};
		case CRA_INDEX_GLASSES: {gRA_InventoryGlasses pushBack _index;};
		case CRA_INDEX_VEST_PLAIN: {gRA_InventoryVestPlain pushBack _index;};
		case CRA_INDEX_VEST_RIG: {gRA_InventoryVestRig pushBack _index;};
		case CRA_INDEX_THROW_UTIL: {gRA_InventoryThrowUtil pushBack _index;};
		case CRA_INDEX_THROW_GRENADE: {gRA_InventoryThrowGrenade pushBack _index;};
		case CRA_INDEX_FIRSTAIDKIT: {gRA_InventoryFirstAidKit pushBack _index;};
		case CRA_INDEX_MEDIKIT: {gRA_InventoryMedikit pushBack _index;};
		case CRA_INDEX_TOOLKIT: {gRA_InventoryToolkit pushBack _index;};
		case CRA_INDEX_MAGAZINE: {gRA_InventoryMagazines pushBack _index;};
		case CRA_INDEX_MINE: {gRA_InventoryMines pushBack _index;};
		case CRA_INDEX_LASER: {gRA_InventoryLaser pushBack _index;};
		case CRA_INDEX_MUZZLE: {gRA_InventoryMuzzle pushBack _index;};
		case CRA_INDEX_BIPOD: {gRA_InventoryBipod pushBack _index;};
		case CRA_INDEX_PARACHUTE: {gRA_InventoryParachute pushBack _index;};
		case CRA_INDEX_BACKPACK_CIVILIAN: {gRA_InventoryBackpackCivilian pushBack _index;};
		case CRA_INDEX_BACKPACK_CIVILIAN_MEDIC: {gRA_InventoryBackpackCivilianMedic pushBack _index;};
		case CRA_INDEX_BACKPACK_CIVILIAN_UTILITY: {gRA_InventoryBackpackCivilianUtility pushBack _index;};
		case CRA_INDEX_VEST_CIVILIAN: {gRA_InventoryVestCivilian pushBack _index;};
		case CRA_INDEX_VEST_CIVILIAN_MEDIC: {gRA_InventoryVestCivilianMedic pushBack _index;};
		case CRA_INDEX_VEST_CIVILIAN_UTILITY: {gRA_InventoryVestCivilianUtility pushBack _index;};
		case CRA_INDEX_HEADGEAR_CIVILIAN: {gRA_InventoryHeadgearCivilian pushBack _index;};
		case CRA_INDEX_HEADGEAR_CIVILIAN_MEDIC: {gRA_InventoryHeadgearCivilianMedic pushBack _index;};
		case CRA_INDEX_HEADGEAR_CIVILIAN_UTILITY: {gRA_InventoryHeadgearCivilianUtility pushBack _index;};
		default {
			if (_argv < 0) then {_argv = 0;};
			private _level = floor (_argv * gRA_ItemLevels);
			if (_level >= gRA_ItemLevels) then {_level = gRA_ItemLevels - 1;};
			switch (_type) do {
				case CRA_INDEX_BACKPACK_SMALL: {for [{private _i = 0}, {_i < gRA_ItemLevels}, {_i = _i + 1}] do {if (_level >= (gRA_ItemLevelBounds#_i#0) && _level <= (gRA_ItemLevelBounds#_i#1)) then {(gRA_InventoryBackpackSmall#_i) pushBack _index;};};};
				case CRA_INDEX_BACKPACK_MEDIUM: {for [{private _i = 0}, {_i < gRA_ItemLevels}, {_i = _i + 1}] do {if (_level >= (gRA_ItemLevelBounds#_i#0) && _level <= (gRA_ItemLevelBounds#_i#1)) then {(gRA_InventoryBackpackMedium#_i) pushBack _index;};};};
				case CRA_INDEX_BACKPACK_LARGE: {for [{private _i = 0}, {_i < gRA_ItemLevels}, {_i = _i + 1}] do {if (_level >= (gRA_ItemLevelBounds#_i#0) && _level <= (gRA_ItemLevelBounds#_i#1)) then {(gRA_InventoryBackpackLarge#_i) pushBack _index;};};};
				case CRA_INDEX_HEADGEAR_HELMET: {for [{private _i = 0}, {_i < gRA_ItemLevels}, {_i = _i + 1}] do {if (_level >= (gRA_ItemLevelBounds#_i#0) && _level <= (gRA_ItemLevelBounds#_i#1)) then {(gRA_InventoryHeadgearHelmet#_i) pushBack _index;};};};
				case CRA_INDEX_VEST_ARMOR: {for [{private _i = 0}, {_i < gRA_ItemLevels}, {_i = _i + 1}] do {if (_level >= (gRA_ItemLevelBounds#_i#0) && _level <= (gRA_ItemLevelBounds#_i#1)) then {(gRA_InventoryVestArmor#_i) pushBack _index;};};};
				case CRA_INDEX_OPTIC: {for [{private _i = 0}, {_i < gRA_ItemLevels}, {_i = _i + 1}] do {if (_level >= (gRA_ItemLevelBounds#_i#0) && _level <= (gRA_ItemLevelBounds#_i#1)) then {(gRA_InventoryOptic#_i) pushBack _index;};};};
				
				case CRA_INDEX_WEAPON_AA: {for [{private _i = 0}, {_i < gRA_ItemLevels}, {_i = _i + 1}] do {if (_level >= (gRA_ItemLevelBounds#_i#0) && _level <= (gRA_ItemLevelBounds#_i#1)) then {(gRA_InventoryWeaponAA#_i) pushBack _index;};};};
				case CRA_INDEX_WEAPON_AR: {for [{private _i = 0}, {_i < gRA_ItemLevels}, {_i = _i + 1}] do {if (_level >= (gRA_ItemLevelBounds#_i#0) && _level <= (gRA_ItemLevelBounds#_i#1)) then {(gRA_InventoryWeaponAR#_i) pushBack _index;};};};
				case CRA_INDEX_WEAPON_ARGL: {for [{private _i = 0}, {_i < gRA_ItemLevels}, {_i = _i + 1}] do {if (_level >= (gRA_ItemLevelBounds#_i#0) && _level <= (gRA_ItemLevelBounds#_i#1)) then {(gRA_InventoryWeaponARGL#_i) pushBack _index;};};};
				case CRA_INDEX_WEAPON_ARM: {for [{private _i = 0}, {_i < gRA_ItemLevels}, {_i = _i + 1}] do {if (_level >= (gRA_ItemLevelBounds#_i#0) && _level <= (gRA_ItemLevelBounds#_i#1)) then {(gRA_InventoryWeaponARM#_i) pushBack _index;};};};
				case CRA_INDEX_WEAPON_ARSO: {for [{private _i = 0}, {_i < gRA_ItemLevels}, {_i = _i + 1}] do {if (_level >= (gRA_ItemLevelBounds#_i#0) && _level <= (gRA_ItemLevelBounds#_i#1)) then {(gRA_InventoryWeaponARSO#_i) pushBack _index;};};};
				case CRA_INDEX_WEAPON_ARSW: {for [{private _i = 0}, {_i < gRA_ItemLevels}, {_i = _i + 1}] do {if (_level >= (gRA_ItemLevelBounds#_i#0) && _level <= (gRA_ItemLevelBounds#_i#1)) then {(gRA_InventoryWeaponARSW#_i) pushBack _index;};};};
				case CRA_INDEX_WEAPON_AT: {for [{private _i = 0}, {_i < gRA_ItemLevels}, {_i = _i + 1}] do {if (_level >= (gRA_ItemLevelBounds#_i#0) && _level <= (gRA_ItemLevelBounds#_i#1)) then {(gRA_InventoryWeaponAT#_i) pushBack _index;};};};
				case CRA_INDEX_WEAPON_CAR: {for [{private _i = 0}, {_i < gRA_ItemLevels}, {_i = _i + 1}] do {if (_level >= (gRA_ItemLevelBounds#_i#0) && _level <= (gRA_ItemLevelBounds#_i#1)) then {(gRA_InventoryWeaponCAR#_i) pushBack _index;};};};
				case CRA_INDEX_WEAPON_HG: {for [{private _i = 0}, {_i < gRA_ItemLevels}, {_i = _i + 1}] do {if (_level >= (gRA_ItemLevelBounds#_i#0) && _level <= (gRA_ItemLevelBounds#_i#1)) then {(gRA_InventoryWeaponHG#_i) pushBack _index;};};};
				case CRA_INDEX_WEAPON_LMG: {for [{private _i = 0}, {_i < gRA_ItemLevels}, {_i = _i + 1}] do {if (_level >= (gRA_ItemLevelBounds#_i#0) && _level <= (gRA_ItemLevelBounds#_i#1)) then {(gRA_InventoryWeaponLMG#_i) pushBack _index;};};};
				case CRA_INDEX_WEAPON_MMG: {for [{private _i = 0}, {_i < gRA_ItemLevels}, {_i = _i + 1}] do {if (_level >= (gRA_ItemLevelBounds#_i#0) && _level <= (gRA_ItemLevelBounds#_i#1)) then {(gRA_InventoryWeaponMMG#_i) pushBack _index;};};};
				case CRA_INDEX_WEAPON_SG: {for [{private _i = 0}, {_i < gRA_ItemLevels}, {_i = _i + 1}] do {if (_level >= (gRA_ItemLevelBounds#_i#0) && _level <= (gRA_ItemLevelBounds#_i#1)) then {(gRA_InventoryWeaponSG#_i) pushBack _index;};};};
				case CRA_INDEX_WEAPON_SMG: {for [{private _i = 0}, {_i < gRA_ItemLevels}, {_i = _i + 1}] do {if (_level >= (gRA_ItemLevelBounds#_i#0) && _level <= (gRA_ItemLevelBounds#_i#1)) then {(gRA_InventoryWeaponSMG#_i) pushBack _index;};};};
				case CRA_INDEX_WEAPON_SRL: {for [{private _i = 0}, {_i < gRA_ItemLevels}, {_i = _i + 1}] do {if (_level >= (gRA_ItemLevelBounds#_i#0) && _level <= (gRA_ItemLevelBounds#_i#1)) then {(gRA_InventoryWeaponSRL#_i) pushBack _index;};};};
				case CRA_INDEX_WEAPON_SRM: {for [{private _i = 0}, {_i < gRA_ItemLevels}, {_i = _i + 1}] do {if (_level >= (gRA_ItemLevelBounds#_i#0) && _level <= (gRA_ItemLevelBounds#_i#1)) then {(gRA_InventoryWeaponSRM#_i) pushBack _index;};};};
				case CRA_INDEX_WEAPON_SRSO: {for [{private _i = 0}, {_i < gRA_ItemLevels}, {_i = _i + 1}] do {if (_level >= (gRA_ItemLevelBounds#_i#0) && _level <= (gRA_ItemLevelBounds#_i#1)) then {(gRA_InventoryWeaponSRSO#_i) pushBack _index;};};};
				case CRA_INDEX_WEAPON_UW: {for [{private _i = 0}, {_i < gRA_ItemLevels}, {_i = _i + 1}] do {if (_level >= (gRA_ItemLevelBounds#_i#0) && _level <= (gRA_ItemLevelBounds#_i#1)) then {(gRA_InventoryWeaponUW#_i) pushBack _index;};};};
				case CRA_INDEX_WEAPON_ALL: {for [{private _i = 0}, {_i < gRA_ItemLevels}, {_i = _i + 1}] do {if (_level >= (gRA_ItemLevelBounds#_i#0) && _level <= (gRA_ItemLevelBounds#_i#1)) then {(gRA_InventoryWeaponAll#_i) pushBack _index;};};};
				default {};
			};
		};
	};
};
CRA_ItemLevel = {
	private _offset = if (_this isEqualType -1) then {_this} else {0};
	private _base = gRA_PlayerProgress + (random 0.05 + gRA_PlayerProgress * 0.1);
	private _quality = (_base - random 1 * (_base * 0.1) - random 1 * random 1 * (_base * 0.2) - random 1 * random 1 * random 1 * (_base * 0.7));
	if (_quality > 1) then {_quality = 1;};
	private _level = floor (_quality * gRA_ItemLevels + _offset);
	if (_level < gRA_ItemLevels) then {if (_level < 0) then {0} else {_level}} else {gRA_ItemLevels - 1};
};
CRA_ItemArmorUtil = {
	private _source = [];
	switch (getNumber (_this >> "ItemInfo" >> "type")) do {
		case 605: {_source = CRA_ITEM_ARMOR_HEADGEAR;};
		case 701: {_source = CRA_ITEM_ARMOR_VEST;};
		default {};
	};
	if (_source isNotEqualTo []) then {
		private _armor = 0;
		private _config = _this >> "ItemInfo" >> "HitpointsProtectionInfo";
		{
			private _value = getNumber (_config >> (_x#0) >> "armor");
			private _mod = getNumber (_config >> (_x#0) >> "passThrough");
			if (_mod > 0) then {_value = _value / _mod;};
			_armor = _armor + _value * (_x#1);
		} forEach _source;
		sqrt (_armor)
	} else {
		nil
	};
};
CRA_ItemList = {
	params ["_level", "_type"];
	private _items = [];
	if (_type isNotEqualTo []) then {
		while {_level >= 0} do {
			{
				switch (_x) do {
					case CRA_INDEX_HEADGEAR_HAT: {_items append gRA_InventoryHeadgearHat;};
					case CRA_INDEX_HEADGEAR_LEADER: {_items append gRA_InventoryHeadgearLeader;};
					case CRA_INDEX_GLASSES: {_items append gRA_InventoryGlasses;};
					case CRA_INDEX_VEST_PLAIN: {_items append gRA_InventoryVestPlain;};
					case CRA_INDEX_VEST_RIG: {_items append gRA_InventoryVestRig;};
					case CRA_INDEX_THROW_UTIL: {_items append gRA_InventoryThrowUtil;};
					case CRA_INDEX_THROW_GRENADE: {_items append gRA_InventoryThrowGrenade;};
					case CRA_INDEX_FIRSTAIDKIT: {_items append gRA_InventoryFirstAidKit;};
					case CRA_INDEX_MEDIKIT: {_items append gRA_InventoryMedikit;};
					case CRA_INDEX_TOOLKIT: {_items append gRA_InventoryToolkit;};
					case CRA_INDEX_MAGAZINE: {_items append gRA_InventoryMagazines;};
					case CRA_INDEX_MINE: {_items append gRA_InventoryMines;};
					case CRA_INDEX_LASER: {_items append gRA_InventoryLaser;};
					case CRA_INDEX_MUZZLE: {_items append gRA_InventoryMuzzle;};
					case CRA_INDEX_BIPOD: {_items append gRA_InventoryBipod;};
					case CRA_INDEX_PARACHUTE: {_items append gRA_InventoryParachute;};
					
					case CRA_INDEX_BACKPACK_CIVILIAN: {_items append gRA_InventoryBackpackCivilian;};
					case CRA_INDEX_BACKPACK_CIVILIAN_MEDIC: {_items append gRA_InventoryBackpackCivilianMedic;};
					case CRA_INDEX_BACKPACK_CIVILIAN_UTILITY: {_items append gRA_InventoryBackpackCivilianUtility;};
					case CRA_INDEX_VEST_CIVILIAN: {_items append gRA_InventoryVestCivilian;};
					case CRA_INDEX_VEST_CIVILIAN_MEDIC: {_items append gRA_InventoryVestCivilianMedic;};
					case CRA_INDEX_VEST_CIVILIAN_UTILITY: {_items append gRA_InventoryVestCivilianUtility;};
					case CRA_INDEX_HEADGEAR_CIVILIAN: {_items append gRA_InventoryHeadgearCivilian;};
					case CRA_INDEX_HEADGEAR_CIVILIAN_MEDIC: {_items append gRA_InventoryHeadgearCivilianMedic;};
					case CRA_INDEX_HEADGEAR_CIVILIAN_UTILITY: {_items append gRA_InventoryHeadgearCivilianUtility;};
					
					case CRA_INDEX_BACKPACK_SMALL: {_items append (gRA_InventoryBackpackSmall#_level);};
					case CRA_INDEX_BACKPACK_MEDIUM: {_items append (gRA_InventoryBackpackMedium#_level);};
					case CRA_INDEX_BACKPACK_LARGE: {_items append (gRA_InventoryBackpackLarge#_level);};
					case CRA_INDEX_HEADGEAR_HELMET: {_items append (gRA_InventoryHeadgearHelmet#_level);};
					case CRA_INDEX_VEST_ARMOR: {_items append (gRA_InventoryVestArmor#_level);};
					case CRA_INDEX_OPTIC: {_items append (gRA_InventoryOptic#_level);};
					
					case CRA_INDEX_WEAPON_AA: {_items append (gRA_InventoryWeaponAA#_level);};
					case CRA_INDEX_WEAPON_AR: {_items append (gRA_InventoryWeaponAR#_level);};
					case CRA_INDEX_WEAPON_ARGL: {_items append (gRA_InventoryWeaponARGL#_level);};
					case CRA_INDEX_WEAPON_ARM: {_items append (gRA_InventoryWeaponARM#_level);};
					case CRA_INDEX_WEAPON_ARSO: {_items append (gRA_InventoryWeaponARSO#_level);};
					case CRA_INDEX_WEAPON_ARSW: {_items append (gRA_InventoryWeaponARSW#_level);};
					case CRA_INDEX_WEAPON_AT: {_items append (gRA_InventoryWeaponAT#_level);};
					case CRA_INDEX_WEAPON_CAR: {_items append (gRA_InventoryWeaponCAR#_level);};
					case CRA_INDEX_WEAPON_HG: {_items append (gRA_InventoryWeaponHG#_level);};
					case CRA_INDEX_WEAPON_LMG: {_items append (gRA_InventoryWeaponLMG#_level);};
					case CRA_INDEX_WEAPON_MMG: {_items append (gRA_InventoryWeaponMMG#_level);};
					case CRA_INDEX_WEAPON_SG: {_items append (gRA_InventoryWeaponSG#_level);};
					case CRA_INDEX_WEAPON_SMG: {_items append (gRA_InventoryWeaponSMG#_level);};
					case CRA_INDEX_WEAPON_SRL: {_items append (gRA_InventoryWeaponSRL#_level);};
					case CRA_INDEX_WEAPON_SRM: {_items append (gRA_InventoryWeaponSRM#_level);};
					case CRA_INDEX_WEAPON_SRSO: {_items append (gRA_InventoryWeaponSRSO#_level);};
					case CRA_INDEX_WEAPON_UW: {_items append (gRA_InventoryWeaponUW#_level);};
					case CRA_INDEX_WEAPON_ALL: {_items append (gRA_InventoryWeaponAll#_level);};
					default {};
				};
			} forEach _type;
			if (_items isNotEqualTo []) exitWith {};
			_items = [];
			_level = _level - 1;
		};
	};
	_items
};
CRA_Item = {
	private _items = _this call CRA_ItemList;
	if (_items isNotEqualTo []) then {selectRandom (_items)} else {-1};
};
CRA_ItemWeaponRasterize = {
	params ["_index", "_loaded", "_attached"];
	private _source = gRA_ItemIndex#_index;
	private _config = switch (_source#1#0) do {
		case CRA_INDEX_WEAPON_AA: {CRA_WEAPON_CONFIG_AA};
		case CRA_INDEX_WEAPON_AR: {CRA_WEAPON_CONFIG_AR};
		case CRA_INDEX_WEAPON_ARGL: {CRA_WEAPON_CONFIG_ARGL};
		case CRA_INDEX_WEAPON_ARM: {CRA_WEAPON_CONFIG_ARM};
		case CRA_INDEX_WEAPON_ARSO: {CRA_WEAPON_CONFIG_ARSO};
		case CRA_INDEX_WEAPON_ARSW: {CRA_WEAPON_CONFIG_ARSW};
		case CRA_INDEX_WEAPON_AT: {CRA_WEAPON_CONFIG_AT};
		case CRA_INDEX_WEAPON_CAR: {CRA_WEAPON_CONFIG_CAR};
		case CRA_INDEX_WEAPON_HG: {CRA_WEAPON_CONFIG_HG};
		case CRA_INDEX_WEAPON_LMG: {CRA_WEAPON_CONFIG_LMG};
		case CRA_INDEX_WEAPON_MMG: {CRA_WEAPON_CONFIG_MMG};
		case CRA_INDEX_WEAPON_SG: {CRA_WEAPON_CONFIG_SG};
		case CRA_INDEX_WEAPON_SMG: {CRA_WEAPON_CONFIG_SMG};
		case CRA_INDEX_WEAPON_SRL: {CRA_WEAPON_CONFIG_SRL};
		case CRA_INDEX_WEAPON_SRM: {CRA_WEAPON_CONFIG_SRM};
		case CRA_INDEX_WEAPON_SRSO: {CRA_WEAPON_CONFIG_SRSO};
		case CRA_INDEX_WEAPON_UW: {CRA_WEAPON_CONFIG_UW};
		default {CRA_WEAPON_CONFIG};
	};
	private _attachments = [];
	{
		if (random 1 < ((_config#0)#_forEachIndex)) then {
			private _attachmentList = ([call CRA_ItemLevel, [_x]] call CRA_ItemList) arrayIntersect (_source#2#_forEachIndex);
			if (_attachmentList isNotEqualTo []) then {_attachments pushBack ((gRA_ItemIndex#(selectRandom _attachmentList))#0);} else {_attachments pushback "";};
		} else {
			_attachments pushback "";
		};
	} forEach [CRA_INDEX_OPTIC, CRA_INDEX_LASER, CRA_INDEX_MUZZLE, CRA_INDEX_BIPOD];
	private _weapon = [];
	private _mags = [];
	private _items = [];
	_weapon pushBack (_source#0);
	
	if (_attached) then {
		_weapon pushBack (_attachments#2);
		_weapon pushBack (_attachments#1);
		_weapon pushBack (_attachments#0);
	} else {
		_weapon pushBack "";
		_weapon pushBack "";
		_weapon pushBack "";
		if ((_attachments#2) != "") then {_items pushBack (_attachments#2);};
		if ((_attachments#1) != "") then {_items pushBack (_attachments#1);},
		if ((_attachments#0) != "") then {_items pushBack (_attachments#0);};
	};
	
	{
		if ((_x#0) isNotEqualTo []) then {
			private _index = if (random 1 < (_x#1#0)) then {selectRandom (_x#0)} else {_x#0#0};
			private _magazine = gRA_ItemIndex#_index;
			private _count = floor random (_x#1#1);
			if (_loaded && _count > 0) then {
				_weapon pushBack [_magazine#0, _magazine#1];
				_count = _count - 1;
			} else {
				_weapon pushBack [];
			};
			for [{private _i = 0}, {_i < _count}, {_i = _i + 1}] do {_mags pushBack [_magazine#0, _magazine#1];};
		} else {
			_weapon pushBack [];
		};
	} forEach [[_source#3, _config#1], [_source#4, _config#2]];
	
	if (_attached) then {
		_weapon pushBack (_attachments#3);
	} else {
		_weapon pushBack "";
		if ((_attachments#3) != "") then {_items pushBack (_attachments#3);};
	};
	[[_items, _mags, [_weapon]],[]]
};
CRA_UnitIdentityInit = {
	{
		private _name = (configName _x);
		if (CRA_UNIT_FACES_EXCLUDE find _name == -1) then {gRA_IdentityFaces pushBack _name;};
	} forEach ("getNumber (_x >> 'disabled') == 0" configClasses (configfile >> "CfgFaces" >> "Man_A3"));
	{
		private _name = (configName _x);
		if (CRA_UNIT_VOICE_EXCLUDE find _name == -1) then {gRA_IdentityVoice pushBack _name;};
	} forEach ("getNumber (_x >> 'scope') == 2" configClasses (configfile >> "CfgVoice"));
};
CRA_UnitIdentity = {
	[selectRandom gRA_IdentityFaces, selectRandom gRA_IdentityVoice, [selectRandom CRA_UNIT_NAMES_HOSTILE, "", ""], "", CRA_UNIT_PITCH_MIN + random CRA_UNIT_PITCH_VARIANCE]
};
CRA_UnitIdentityNeutral = {
	[selectRandom gRA_IdentityFaces, selectRandom gRA_IdentityVoice, [selectRandom CRA_UNIT_NAMES_NEUTRAL, "", ""], "", CRA_UNIT_PITCH_MIN + random CRA_UNIT_PITCH_VARIANCE]
};
CRA_UnitIdentityFriendly = {
	[selectRandom gRA_IdentityFaces, selectRandom gRA_IdentityVoice, [selectRandom CRA_UNIT_NAMES_FRIENDLY, "", ""], "", CRA_UNIT_PITCH_MIN + random CRA_UNIT_PITCH_VARIANCE]
};
CRA_UnitLoadoutGenerate = {
	params ["_type", "_weapons"];
	private _loadout = [[],[],[]];
	private _srcUniform = CRA_UNIT_UNIFORM;
	
	private _srcVest = CRA_UNIT_VEST;
	private _srcBackpack = CRA_UNIT_BACKPACK;
	private _srcHelmet = CRA_UNIT_HEADGEAR;
	private _srcGlasses = CRA_UNIT_GLASSES;
	
	private _srcBino = CRA_INV_BINO;
	private _srcLinked = CRA_INV_LINKED;
	private _probBino = CRA_IPB_BINO;
	private _probLinked = CRA_IPB_LINKED;
	switch (_type) do {
		case CRA_UNIT_CIVILIAN_0: {
			_srcUniform = CRA_UNIT_UNIFORM_CIVILIAN;
			_srcVest = CRA_UNIT_VEST_CIVILIAN;
			_srcBackpack = CRA_UNIT_BACKPACK_CIVILIAN;
			_srcHelmet = CRA_UNIT_HEADGEAR_CIVILIAN;
			_srcGlasses = CRA_UNIT_GLASSES_CIVILIAN;
			_probBino = CRA_IPB_BINO_CIVILIAN;
			_probLinked = CRA_IPB_LINKED_CIVILIAN;
		};
		case CRA_UNIT_CIVILIAN_MEDIC: {
			_srcUniform = CRA_UNIT_UNIFORM_CIVILIAN_MEDIC;
			_srcVest = CRA_UNIT_VEST_CIVILIAN_MEDIC;
			_srcBackpack = CRA_UNIT_BACKPACK_CIVILIAN_MEDIC;
			_srcHelmet = CRA_UNIT_HEADGEAR_CIVILIAN_MEDIC;
			_srcGlasses = CRA_UNIT_GLASSES_CIVILIAN;
			_probBino = CRA_IPB_BINO_CIVILIAN_MEDIC;
			_probLinked = CRA_IPB_LINKED_CIVILIAN_MEDIC;
		};
		case CRA_UNIT_CIVILIAN_UTILITY: {
			_srcUniform = CRA_UNIT_UNIFORM_CIVILIAN_UTILITY;
			_srcVest = CRA_UNIT_VEST_CIVILIAN_UTILITY;
			_srcBackpack = CRA_UNIT_BACKPACK_CIVILIAN_UTILITY;
			_srcHelmet = CRA_UNIT_HEADGEAR_CIVILIAN_UTILITY;
			_srcGlasses = CRA_UNIT_GLASSES_CIVILIAN;
			_probBino = CRA_IPB_BINO_CIVILIAN_UTILITY;
			_probLinked = CRA_IPB_LINKED_CIVILIAN_UTILITY;
		};
		case CRA_UNIT_LOOTER_0;
		case CRA_UNIT_LOOTER_1;
		case CRA_UNIT_LOOTER_2;
		case CRA_UNIT_LOOTER_3: {
			_srcUniform = CRA_UNIT_UNIFORM_LOOTER;
			_srcVest = CRA_UNIT_VEST_LOOTER;
			_srcBackpack = CRA_UNIT_BACKPACK_LOOTER;
			_srcHelmet = CRA_UNIT_HEADGEAR_LOOTER;
			_srcGlasses = CRA_UNIT_GLASSES_LOOTER;
			_probBino = CRA_IPB_BINO_LOOTER;
			_probLinked = CRA_IPB_LINKED_LOOTER;
		};
		case CRA_UNIT_ARMY_LEADER_0;
		case CRA_UNIT_ARMY_LEADER_1;
		case CRA_UNIT_ARMY_LEADER_2: {
			_srcUniform = CRA_UNIT_UNIFORM_ARMY_LEADER;
			_srcVest = CRA_UNIT_VEST_ARMY;
			_srcHelmet = CRA_UNIT_HEADGEAR_ARMY_LEADER;
			_srcGlasses = CRA_UNIT_GLASSES_ARMY_LEADER;
			_probBino = CRA_IPB_BINO_ARMY_LEADER;
			_probLinked = CRA_IPB_LINKED_ARMY_LEADER;
		};
		case CRA_UNIT_ARMY_GRUNT_0;
		case CRA_UNIT_ARMY_DMM_0;
		case CRA_UNIT_ARMY_UGL_0: {
			_srcUniform = CRA_UNIT_UNIFORM_ARMY;
			_srcVest = CRA_UNIT_VEST_ARMY;
			_srcHelmet = CRA_UNIT_HEADGEAR_ARMY;
			_srcGlasses = CRA_UNIT_GLASSES_ARMY;
			_probLinked = CRA_IPB_LINKED_ARMY;
		};
		case CRA_UNIT_ARMY_MED_0;
		case CRA_UNIT_ARMY_ENG_0;
		case CRA_UNIT_ARMY_MG_0: {
			_srcUniform = CRA_UNIT_UNIFORM_ARMY;
			_srcVest = CRA_UNIT_VEST_ARMY;
			_srcBackpack = CRA_UNIT_BACKPACK_ARMY;
			_srcHelmet = CRA_UNIT_HEADGEAR_ARMY;
			_srcGlasses = CRA_UNIT_GLASSES_ARMY;
			_probLinked = CRA_IPB_LINKED_ARMY;
		};
		case CRA_UNIT_ARMY_AT_0;
		case CRA_UNIT_ARMY_AA_0: {
			_srcUniform = CRA_UNIT_UNIFORM_ARMY;
			_srcVest = CRA_UNIT_VEST_ARMY;
			_srcBackpack = CRA_UNIT_BACKPACK_ARMY_BIG;
			_srcHelmet = CRA_UNIT_HEADGEAR_ARMY;
			_srcGlasses = CRA_UNIT_GLASSES_ARMY;
			_probLinked = CRA_IPB_LINKED_ARMY;
		};
		case CRA_UNIT_CARTEL_LEADER_0: {
			_srcUniform = CRA_UNIT_UNIFORM_CARTEL;
			_srcVest = CRA_UNIT_VEST_CARTEL;
			_srcBackpack = CRA_UNIT_BACKPACK_CARTEL;
			_srcHelmet = CRA_UNIT_HEADGEAR_CARTEL_LEADER;
			_srcGlasses = CRA_UNIT_GLASSES_CARTEL_LEADER;
			_probLinked = CRA_IPB_LINKED_CARTEL_LEADER;
		};
		case CRA_UNIT_CARTEL_GRUNT_0;
		case CRA_UNIT_CARTEL_DMM_0;
		case CRA_UNIT_CARTEL_UGL_0: {
			_srcUniform = CRA_UNIT_UNIFORM_CARTEL;
			_srcVest = CRA_UNIT_VEST_CARTEL;
			_srcBackpack = CRA_UNIT_BACKPACK_CARTEL;
			_srcHelmet = CRA_UNIT_HEADGEAR_CARTEL;
			_srcGlasses = CRA_UNIT_GLASSES_CARTEL;
			_probLinked = CRA_IPB_LINKED_CARTEL;
			
		};
		case CRA_UNIT_CARTEL_MG_0;
		case CRA_UNIT_CARTEL_MED_0;
		case CRA_UNIT_CARTEL_AT_0: {
			_srcUniform = CRA_UNIT_UNIFORM_CARTEL;
			_srcVest = CRA_UNIT_VEST_CARTEL;
			_srcBackpack = CRA_UNIT_BACKPACK_CARTEL_BIG;
			_srcHelmet = CRA_UNIT_HEADGEAR_CARTEL;
			_srcGlasses = CRA_UNIT_GLASSES_CARTEL;
			_probLinked = CRA_IPB_LINKED_CARTEL;
			
		};
		default {};
	};
	private _uniform = selectRandom _srcUniform;
	if (_uniform != "") then {_loadout pushBack [_uniform, []];} else {_loadout pushBack [];};
	
	private _vestType = ([call CRA_ItemLevel, (_srcVest#1) selectRandomWeighted (_srcVest#0)] call CRA_Item);
	if (_vestType != -1) then {_loadout pushBack [gRA_ItemIndex#_vestType, []];} else {_loadout pushBack [];};
	
	private _backpackType = ([call CRA_ItemLevel, (_srcBackpack#1) selectRandomWeighted (_srcBackpack#0)] call CRA_Item);
	if (_backpackType != -1) then {_loadout pushBack [gRA_ItemIndex#_backpackType, []];} else {_loadout pushBack [];};

	private _headgear = ([call CRA_ItemLevel, (_srcHelmet#1) selectRandomWeighted (_srcHelmet#0)] call CRA_Item);
	if (_headgear != -1) then {_loadout pushBack (gRA_ItemIndex#_headgear);} else {_loadout pushBack "";};

	private _glasses = ([call CRA_ItemLevel, (_srcGlasses#1) selectRandomWeighted (_srcGlasses#0)] call CRA_Item);
	if (_glasses != -1) then {_loadout pushBack (gRA_ItemIndex#_glasses);} else {_loadout pushBack "";};

	private _bino = [];
	{if ((_x > 0.0) && {random 1.0 <= _x}) exitWith {_bino = _srcBino#_forEachIndex;};} forEach _probBino;
	_loadout pushBack _bino;
	
	private _linked = [];
	{
		private _select = "";
		private _items = _srcLinked#_forEachIndex;
		{if ((_x > 0.0) && {random 1.0 <= _x}) exitWith {_select = _items#_forEachIndex;};} forEach _x;
		_linked pushBack _select;
	} forEach _probLinked;
	_loadout pushBack _linked;
	
	_loadout = [_loadout, _type] call CRA_UnitLoadoutItem;
	private _weaponInventory = [[[],[],[]],[]];
	{[_weaponInventory, [_x, true, true] call CRA_ItemWeaponRasterize] call CRQ_InventoryAppend;} forEach _weapons;
	[_loadout, _weaponInventory] call CRQ_InventoryLoadoutAppend;
	
	_loadout
};
CRA_UnitWeapon = {
	private _weapons = [];
	private _srcPrimary = CRA_INV_PRI;
	private _srcSecondary = CRA_INV_SEC;
	private _srcTertiary = CRA_INV_TER;
	switch (_this) do {
		case CRA_UNIT_LOOTER_0: {
			_srcPrimary = CRA_INV_PRI_LOOTER_PISTOL;
		};
		case CRA_UNIT_LOOTER_1: {
			_srcPrimary = CRA_INV_PRI_LOOTER_SMG;
		};
		case CRA_UNIT_LOOTER_2: {
			_srcPrimary = CRA_INV_PRI_LOOTER_SG;
		};
		case CRA_UNIT_LOOTER_3: {
			_srcPrimary = CRA_INV_PRI_LOOTER_RIFLE;
		};
		case CRA_UNIT_ARMY_LEADER_0;
		case CRA_UNIT_ARMY_LEADER_1;
		case CRA_UNIT_ARMY_LEADER_2;
		case CRA_UNIT_ARMY_GRUNT_0;
		case CRA_UNIT_ARMY_MED_0;
		case CRA_UNIT_ARMY_ENG_0: {
			_srcPrimary = CRA_INV_PRI_ARMY;
			_srcSecondary = CRA_INV_SEC_ARMY;
		};
		case CRA_UNIT_ARMY_MG_0: {
			_srcPrimary = CRA_INV_PRI_ARMY_MG;
			_srcSecondary = CRA_INV_SEC_ARMY;
		};
		case CRA_UNIT_ARMY_DMM_0: {
			_srcPrimary = CRA_INV_PRI_ARMY_DMM;
			_srcSecondary = CRA_INV_SEC_ARMY;
		};
		case CRA_UNIT_ARMY_UGL_0: {
			_srcPrimary = CRA_INV_PRI_ARMY_UGL;
			_srcSecondary = CRA_INV_SEC_ARMY;
		};
		case CRA_UNIT_ARMY_AT_0: {
			_srcPrimary = CRA_INV_PRI_ARMY_AT;
			_srcSecondary = CRA_INV_SEC_ARMY_AT;
		};
		case CRA_UNIT_ARMY_AA_0: {
			_srcPrimary = CRA_INV_PRI_ARMY_AA;
			_srcSecondary = CRA_INV_SEC_ARMY_AT;
		};
		case CRA_UNIT_CARTEL_MED_0;
		case CRA_UNIT_CARTEL_LEADER_0;
		case CRA_UNIT_CARTEL_GRUNT_0: {
			_srcPrimary = CRA_INV_PRI_CARTEL;
			_srcSecondary = CRA_INV_SEC_CARTEL;
		};
		case CRA_UNIT_CARTEL_MG_0: {
			_srcPrimary = CRA_INV_PRI_CARTEL_MG;
			_srcSecondary = CRA_INV_SEC_CARTEL;
		};
		case CRA_UNIT_CARTEL_DMM_0: {
			_srcPrimary = CRA_INV_PRI_CARTEL_DMM;
			_srcSecondary = CRA_INV_SEC_CARTEL;
		};
		case CRA_UNIT_CARTEL_UGL_0: {
			_srcPrimary = CRA_INV_PRI_CARTEL_UGL;
			_srcSecondary = CRA_INV_SEC_CARTEL;
		};
		case CRA_UNIT_CARTEL_AT_0: {
			_srcPrimary = CRA_INV_PRI_CARTEL_AT;
			_srcSecondary = CRA_INV_SEC_CARTEL_AT;
		};
		default {};
	};
	private _cont = true;
	{
		if (_cont && count _x > 0) then {
			private _weapon = ([(_x#0) call CRA_ItemLevel, _x#1] call CRA_Item);
			if (_weapon == -1) exitWith {_cont = false;};
			_weapons pushBack _weapon;
		};
	} forEach [_srcPrimary, _srcSecondary, _srcTertiary];
	_weapons
};
CRA_UnitLoadoutItem = {
	params ["_loadout", "_type"];
	
	private _itemUniform = CRA_UNIT_ITEM_UNIFORM;
	private _itemVest = CRA_UNIT_ITEM_VEST;
	private _itemBackpack = CRA_UNIT_ITEM_BACKPACK;
	private _magUniform = CRA_UNIT_MAG_UNIFORM;
	private _magVest = CRA_UNIT_MAG_VEST;
	private _magBackpack = CRA_UNIT_MAG_BACKPACK;
	switch (_type) do {
		case CRA_UNIT_LOOTER_0;
		case CRA_UNIT_LOOTER_1;
		case CRA_UNIT_LOOTER_2;
		case CRA_UNIT_LOOTER_3: {
			_itemUniform = CRA_UNIT_ITEM_UNIFORM_LOOTER;
		};
		case CRA_UNIT_ARMY_LEADER_0;
		case CRA_UNIT_ARMY_LEADER_1;
		case CRA_UNIT_ARMY_LEADER_2;
		case CRA_UNIT_ARMY_GRUNT_0;
		case CRA_UNIT_ARMY_MG_0;
		case CRA_UNIT_ARMY_DMM_0;
		case CRA_UNIT_ARMY_AT_0;
		case CRA_UNIT_ARMY_AA_0: {
			_itemUniform = CRA_UNIT_ITEM_UNIFORM_ARMY;
			_magUniform = CRA_UNIT_MAG_UNIFORM_ARMY;
			_magVest = CRA_UNIT_MAG_VEST_ARMY;
		};
		case CRA_UNIT_ARMY_UGL_0: {
			_itemUniform = CRA_UNIT_ITEM_UNIFORM_ARMY;
			_magUniform = CRA_UNIT_MAG_UNIFORM_ARMY;
			_magVest = CRA_UNIT_MAG_VEST_ARMY_UGL;
		};
		case CRA_UNIT_ARMY_MED_0: {
			_itemUniform = CRA_UNIT_ITEM_UNIFORM_ARMY_MED;
			_itemBackpack = CRA_UNIT_ITEM_BACKPACK_ARMY_MED;
			_magUniform = CRA_UNIT_MAG_UNIFORM_ARMY;
			_magVest = CRA_UNIT_MAG_VEST_ARMY;
		};
		case CRA_UNIT_ARMY_ENG_0: {
			_itemUniform = CRA_UNIT_ITEM_UNIFORM_ARMY;
			_itemBackpack = CRA_UNIT_ITEM_BACKPACK_ARMY_ENG;
			_magUniform = CRA_UNIT_MAG_UNIFORM_ARMY;
			_magVest = CRA_UNIT_MAG_VEST_ARMY;
			_magBackpack = CRA_UNIT_MAG_BACKPACK_ARMY_ENG;
		};
		case CRA_UNIT_CARTEL_MG_0;
		case CRA_UNIT_CARTEL_DMM_0;
		case CRA_UNIT_CARTEL_AT_0;
		case CRA_UNIT_CARTEL_LEADER_0;
		case CRA_UNIT_CARTEL_GRUNT_0: {
			_itemUniform = CRA_UNIT_ITEM_UNIFORM_CARTEL;
			_magUniform = CRA_UNIT_MAG_UNIFORM_CARTEL;
			_magVest = CRA_UNIT_MAG_VEST_CARTEL;
		};
		case CRA_UNIT_CARTEL_UGL_0: {
			_itemUniform = CRA_UNIT_ITEM_UNIFORM_CARTEL;
			_magUniform = CRA_UNIT_MAG_UNIFORM_CARTEL;
			_magVest = CRA_UNIT_MAG_VEST_CARTEL_UGL;
		};
		case CRA_UNIT_CARTEL_MED_0: {
			_itemUniform = CRA_UNIT_ITEM_UNIFORM_CARTEL_MED;
			_itemBackpack = CRA_UNIT_ITEM_BACKPACK_CARTEL_MED;
			_magUniform = CRA_UNIT_MAG_UNIFORM_CARTEL;
			_magVest = CRA_UNIT_MAG_VEST_CARTEL;
		};
	};
	{
		_x params ["_index", "_probability", "_type"];
		if ((_loadout#_index) isNotEqualTo []) then {
			{
				private _num = floor (random _x);
				for [{private _i = 0}, {_i < _num}, {_i = _i + 1}] do {
					private _item = [0, _type#_forEachIndex] call CRA_Item;
					if (_item != -1) then {(_loadout#_index#1) pushBack [gRA_ItemIndex#_item, 1];};
				};
			} forEach _probability;
		};
	} forEach [[3, _itemUniform, CRA_UNIT_ITEM_UNIFORM_ITEMS],[4, _itemVest, CRA_UNIT_ITEM_VEST_ITEMS],[5, _itemBackpack, CRA_UNIT_ITEM_BACKPACK_ITEMS]];
	{
		_x params ["_index", "_probability", "_type"];
		if ((_loadout#_index) isNotEqualTo []) then {
			{
				private _num = floor (random _x);
				for [{private _i = 0}, {_i < _num}, {_i = _i + 1}] do {
					private _item = [0, _type#_forEachIndex] call CRA_Item;
					if (_item != -1) then {
						private _mag = gRA_ItemIndex#_item;
						(_loadout#_index#1) pushBack [_mag#0, 1, _mag#1];
					};
				};
			} forEach _probability;
		};
	} forEach [[3, _magUniform, CRA_UNIT_MAG_UNIFORM_MAGS],[4, _magVest, CRA_UNIT_MAG_VEST_MAGS],[5, _magBackpack, CRA_UNIT_MAG_BACKPACK_MAGS]];
	_loadout
};
