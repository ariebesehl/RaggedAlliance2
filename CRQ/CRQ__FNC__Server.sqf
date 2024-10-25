
CRQ_EHS_GroupUnitLeft = { // TODO
};
CRQ_EHS_UnitKilled = {
	(_this#0) removeEventHandler [_thisEvent, _thisEventHandler];
	(gCS_GC_Queue#0) pushBack (_this#0);
};
CRQ_EHS_VehicleKilled = {
	(_this#0) removeEventHandler [_thisEvent, _thisEventHandler];
	(gCS_GC_Queue#1) pushBack (_this#0);
};
CRQ_EHS_ClientDisconnect = {
	_this call CQM_ClientDisconnect;
	false
};
CRQ_EHS_ClientRespawn = {
	(_this#1) setVehicleVarName "";
	(gCS_GC_Queue#0) pushBack (_this#1);
	_this call CRQ_fnc_CL_Spawn;
};
CRQ_SyncArrayCRCFull = {
	params ["_name", "_array"];
	private _crc = _array apply {_x call CRQ_CRC};
	private _existing = gCS_SyncArrays getOrDefault [_name, []];
	if (_existing isNotEqualTo []) then {
		_existing set [0, _crc];
		_existing set [1, _crc call CRQ_CRC];
	} else {
		gCS_SyncArrays set [_name, [_crc, _crc call CRQ_CRC]];
	};
};
CRQ_SyncArrayCRCIndex = {
	params ["_name", "_index", "_data"];
	private _existing = gCS_SyncArrays getOrDefault [_name, []];
	if (_existing isEqualTo []) exitWith {};
	(_existing#0) set [_index, _data call CRQ_CRC];
	(_existing) set [1, (_existing#0) call CRQ_CRC];
};

CRQ_SyncArrayClear = {
	params ["_name", ["_target", gCS_MP_Broadcast]];
	[_name] remoteExec ["CRQ_LocalSyncArrayClear", _target];
};
CRQ_SyncArrayIndex = {
	params ["_name", "_index", "_data", ["_target", gCS_MP_Broadcast]];
	[_name, _index, _data] remoteExec ["CRQ_LocalSyncArrayIndex", _target];
};
CRQ_SyncArrayFull = {
	params ["_name", "_array", ["_target", gCS_MP_Broadcast]];
	[_name] remoteExec ["CRQ_LocalSyncArrayClear", _target];
	_this spawn {
		params ["_name", "_array", ["_target", gCS_MP_Broadcast]];
		{[_name, _forEachIndex, _x] remoteExec ["CRQ_LocalSyncArrayIndex", _target]; sleep 0.004;} forEach _array;
	};
};

CRQ_fnc_AC_RemoveAll = {
	if (_this isEqualTo objNull) exitWith {};
	[_this] remoteExec ["removeAllActions", gCS_MP_Broadcast];
	private _remove = [];
	{if (_this == (_x#0)) then {_remove pushBack _forEachIndex;};} forEach gCS_Action;
	reverse _remove;
	{gCS_Action deleteAt _x;} forEach _remove;
};
CRQ_fnc_AC_Add = {
	if ((_this#0) isEqualTo objNull) exitWith {};
	gCS_Action pushBack _this;
	[gCS_MP_Broadcast, _this] call CRQ_fnc_AC_Broadcast;
};
CRQ_fnc_AC_Broadcast = {
	params ["_target", "_action"];
	[_action#0, _action#1] remoteExec ["addAction", _target];
};
CRQ_fnc_AC_Sync = {
	sleep CRQ_AC_SYNC;
	{[_this, _x] call CRQ_fnc_AC_Broadcast;} forEach gCS_Action;
};
CRQ_fnc_CL_Connect = { // TODO there is now getUserInfo that includes clientStateNumber and player unit
	params ["_unit", "_id", "_uid", "_name", "_jip"];
	[_unit, objNull] call CRQ_fnc_CL_Spawn;
	if (_jip) then {(owner _unit) spawn CRQ_fnc_AC_Sync;};
	_this call CQM_CL_CONN;
};
CRQ_fnc_CL_Spawn = {
	params ["_unit", "_corpse"];
	_this call CQM_CL_SPAWN;
	remoteExec ["CRQ_fnc_CLL_SpawnResolve", owner _unit];
};
CRQ_fnc_PL_Incapacitated = {
	params ["_unit", "_state"];
	["DEBUG: " + (str _unit) + " is " + (if (_state) then {"incapacitated."} else {"revived/respawned."})] remoteExec ["systemChat", gCS_MP_Broadcast];
	// private _marker = "CRQ_INCAP-" + vehicleVarName _unit;
	// private _vec = _unit call CRQ_Vec2D;
	// if ((createMarker [_marker, (_vec#0), -1, _unit]) isEqualTo "") then {
		// _marker setMarkerPos (_vec#0);
	// };
	// _marker setMarkerDir (_vec#1);
};
CRQ_fnc_GC_Timestamp = { // TODO Variance
	[_this, (_this getVariable ["CRQS_GCT", -1])] call {
		if ((_this#1) < 0) then {
			private _timer = gCS_TM_Now;
			(_this#0) setVariable ["CRQS_GCT", _timer];
			_timer
		} else {
			(_this#1)
		};
	};
};
CRQ_fnc_GC_DisposeObject = {
	params ["_obj", "_hide", "_delete"];
	private _unit = _obj call CRQ_fnc_ObjectIsUnit;
	if (_hide && {!(_obj getVariable ["CRQS_GCH", false])}) then {
		_obj setVariable ["CRQS_GCH", true];
		if (_unit) then {hideBody _x;};
	};
	if (_delete) then {
		(_obj getVariable ["CRQP_AI", scriptNull]) call {if (_this isNotEqualTo scriptNull) then {terminate _this;};};
		_obj setVariable ["CRQP_AI", nil];
		_obj setVariable ["CRQS_GCT", nil];
		_obj setVariable ["CRQS_GCH", nil];
		if (_unit) then {_obj call CRQ_UnitDelete;} else {_obj call CRQ_VehicleDelete;};
		true
	} else {
		false
	};
};
CRQ_fnc_GC_ListRegister = {
	if (_this isEqualTo objNull) exitWith {};
	private _unit = if (_this call CRQ_fnc_ObjectIsUnit) then {if ((group _this) isNotEqualTo grpNull) then {[_this] join gCS_GC_Group;}; true} else {false};
	if ([_this, "CRQS_GCT"] call CRQ_fnc_VarAvailable) then {_this setVariable ["CRQS_GCT", gCS_TM_Now];};
	if ([_this, "CRQS_GCH"] call CRQ_fnc_VarAvailable) then {_this setVariable ["CRQS_GCH", false];};
	private _target = if (_unit) then {gCS_GC_Items#0} else {gCS_GC_Items#1};
	private _counter = _target#0;
	private _prev = _target#1#_counter;
	if (_prev isNotEqualTo objNull) then {[_prev, true, true] call CRQ_fnc_GC_DisposeObject;};
	(_target#1) set [_counter, _this];
	_target set [0, (_counter + 1) % (if (_unit) then {gCS_PM_GC_CountCorpse} else {gCS_PM_GC_CountWreck})];
};
CRQ_fnc_CorpseExpedite = {
	private _timer = _this call CRQ_fnc_GC_Timestamp;
	if (([_timer, gCS_TM_Now] call CRQ_fnc_TimeDelta) < gCS_GC_DecayExpress) exitWith {_this setVariable ["CRQS_GCT", ((_timer - gCS_GC_DecayExpress) call CRQ_fnc_TimeCoerce)];};
};
CRQ_fnc_GC_CollectorLoop = {
	private _queue = [gCS_GC_Queue#0, gCS_GC_Queue#1];
	gCS_GC_Queue = [[], []];
	{_x call CRQ_fnc_GC_ListRegister; sleep (random [0.00, 0.050, 0.100]);} forEach ((_queue#0) + (_queue#1));
	{
		private _list = gCS_GC_Items#_x#1;
		private _limit = [[gCS_PM_GC_DecayCorpse, gCS_GC_DecayDelete], [gCS_PM_GC_DecayWreck, gCS_PM_GC_DecayWreck]]#_x;
		{
			if (_x isNotEqualTo objNull) then {
				private _timer = [_x call CRQ_fnc_GC_Timestamp, gCS_TM_Now] call CRQ_fnc_TimeDelta;
				if ([_x, !(_timer < (_limit#0)), !(_timer < (_limit#1))] call CRQ_fnc_GC_DisposeObject) then {_list set [_forEachIndex, objNull];};
			};
		} forEach _list;
	} forEach [0, 1];
};
CRQ_fnc_GC_CollectorInit = {
	(gCS_GC_Items#0#1) resize [gCS_PM_GC_CountCorpse, objNull];
	(gCS_GC_Items#1#1) resize [gCS_PM_GC_CountWreck, objNull];
	gCS_GC_Group = CRQ_SD_CIVFOR call CRQ_GroupCreate;
	gCS_GC_Group setGroupIdGlobal [CQM_CORPSE_GROUP];
};
CRQ_fnc_CL_SyncConnect = {
	publicVariable "pCQ_CL_Connect";
};
CRQ_fnc_CL_Sync = {
	if ((_this isEqualType []) && {count _this > 1}) then {
		missionNamespace setVariable ["CRQP_SYN", [_this, pCQ_CL_Data#(_this#0)#(_this#1)], true];
		remoteExec ["CRQ_fnc_CLL_Sync", gCS_MP_Broadcast];
	} else {
		publicVariable "pCQ_CL_Data";
	};
};
CRQ_fnc_CL_Init = {
	// TODO remove AI players if not explicitly disabled in description.ext
	// ADD I probably need to enable AI on all playable slots to rotate through all editor placed slots because i cant find any way to get eden editor slots in scripts, no?
	// CONCL there's loadcfg, use that to load mission.sqm
	// ADD D298 I still haven't found a way to clearly map player slot to player unit. what gives? how does editor entity id map to player object? i want this without setting unit varnames
	private _total = 0;
	{
		private _count = playableSlotsNumber _x;
		_total = _total + _count;
		(pCQ_CL_Data#_forEachIndex) resize [_count, [objNull, false]];
		(pCQ_CL_Connect#_forEachIndex) resize [_count, false];
	} forEach CRQ_SD_TYPES;
	[] call CRQ_fnc_CL_SyncConnect;
	[] call CRQ_fnc_CL_Sync;
};
CRQ_fnc_CL_Restore = {
	remoteExec ["CRQ_fnc_CLL_Restore", owner _this];
};
CRQ_fnc_DT_Date = {
	params ["_year", "_month", "_day"];
	private _local = systemTime;
	private _utc = systemTimeUTC;
	private _date = date;
	private _dtYear = (if (_year < -2) then {
		(switch (_year) do {
			default {[0, 68]};
		}) call {(_this#0) + random (if ((_this#0) > (_this#1)) then {68 - (_this#0) + (_this#1)} else {(_this#1) - (_this#0)})}
	} else {
		if (_year > 0) exitWith {floor (_year)};
		if (_year < -1) exitWith {floor ((_utc#0) - 1970)};
		if (_year <  0) exitWith {floor ((_local#0) - 1970)};
		floor ((_date#0) - 1970)
	}) % 68;
	/*
	private _dtMonth = (if (_month < -2) then {
		if (_hour < -2) then {
			0
		} else {
			floor (random 60)
		}
	} else {
		if (_minute > 0) exitWith {floor (_minute)};
		if (_minute < -1) exitWith {floor (_utc#4)};
		if (_minute < 0) exitWith {floor (_local#4)};
		floor ((_dtNow - (floor _dtNow)) * 60)
	}) % 60;
	*/
	private _dtDate = random 1;
	[1970 + _dtYear, _dtDate]
};
CRQ_fnc_DT_Time = {
	params ["_hour", "_minute", "_params"];
	private _local = systemTime;
	private _utc = systemTimeUTC;
	private _dtNow = dayTime;
	private _dtHour = (if (_hour < -2) then {
		(switch (_hour) do {
			case -4: {[_params#0, _params#1]};
			case -5: {[_params#1, _params#2]};
			case -6: {[_params#2, _params#3]};
			case -7: {[_params#3, _params#4]};
			case -8: {[_params#4, _params#5]};
			case -9: {[_params#5, _params#0]};
			default {[0, 24]};
		}) call {(_this#0) + random (if ((_this#0) > (_this#1)) then {24 - (_this#0) + (_this#1)} else {(_this#1) - (_this#0)})}
	} else {
		if (_hour > 0) exitWith {floor (_hour)};
		if (_hour < -1) exitWith {floor (_utc#3)};
		if (_hour <  0) exitWith {floor (_local#3)};
		floor _dtNow
	}) % 24;
	private _dtMinute = (if (_minute < -2) then {
		if (_hour < -2) then {
			0
		} else {
			floor (random 60)
		}
	} else {
		if (_minute > 0) exitWith {floor (_minute)};
		if (_minute < -1) exitWith {floor (_utc#4)};
		if (_minute < 0) exitWith {floor (_local#4)};
		floor ((_dtNow - (floor _dtNow)) * 60)
	}) % 60;
	(_dtHour + _dtMinute / 60)
};
CRQ_fnc_DT_ParamsGenerate = {
	private _sunrise = 0;
	private _sunset = 0;
	params ["_date", ["_params", CRQ_DT_PARAMS]];
	((_date call BIS_fnc_sunriseSunsetTime) call {
		if (_this isNotEqualTo [-1, 0]) then {
			if (_this isNotEqualTo [0, -1]) then {
				_sunrise = _this#0;
				_sunset = _this#1;
				[24 - _sunset + _sunrise, _sunset - _sunrise]
			} else {
				[0, 24]
			};
		} else {
			[24, 0]
		};
	}) params ["_rangeNight", "_rangeDay"];
	_params apply {if (_x < 0) then {(_sunset - _x * _rangeNight) % 24} else {_sunrise + _x * _rangeDay};}
};
CRQ_fnc_DT_Loop = {
	private _dtNow = dayTime;
	if (_dtNow < gCS_DT_Now) then {gCS_DT_Params = [date] call CRQ_fnc_DT_ParamsGenerate;};
	if (_dtNow >= (gCS_DT_Params#5) && {gCS_DT_Now < (gCS_DT_Params#5)}) then {[] call CQM_DT_NIGHT;};
	if (_dtNow > (gCS_DT_Params#0) && {gCS_DT_Now <= (gCS_DT_Params#0)}) then {[] call CQM_DT_DAY;};
	gCS_DT_Now = _dtNow;
};
CRQ_fnc_EN_LightsLoop = {
	if (gCS_EN_Light isEqualTo ([] call CRQ_Lights)) exitWith {};
	if (gCS_EN_Light) then {[] call CQM_EN_LT_OFF; gCS_EN_Light = false;} else {[] call CQM_EN_LT_ON; gCS_EN_Light = true;};
};

CRQ_fnc_AI_Init = {
	private _adjust = [];
	{
		private _bounds = getArray _x;
		if (_bounds isNotEqualTo [0,0,1,1]) then {
			_bounds params ["_minIn", "_minOut", "_maxIn", "_maxOut"];
			if (_minOut >= _maxOut) exitWith {};
			private _codeIn = if (_maxIn != 1) then {
				if (_minIn != 0) then {"(((_this select 1) max " + str _minIn + ") min " + str _maxIn + ")"} else {"((_this select 1) min " + str _maxIn + ")"};
			} else {
				if (_minIn != 0) then {"((_this select 1) max " + str _minIn + ")"} else {"(_this select 1)"};
			};
			private _codeSkill = "((" + _codeIn + " - " + str _minOut + ") max 0) * " + str (1 / (_maxOut - _minOut));
			_adjust pushBack (compile ("(_this select 0) setSkill ['" + configName _x + "', " + _codeSkill + "];"));
		};
	} forEach (configProperties [configFile >> "CfgAISkill", "true", true]);
	missionNamespace setVariable ["pCQ_AI_Adjust", _adjust, true];
};

// gCS_EnvOvercast = 0;
// gCS_EnvStamp = 0;
// gCS_EnvDelay = 0;
// CLEAR, MILD, TEMPERATE, CLOUDY, RAINY, STORMY
//#define CRQ_EN_OC_PARAM [0.000, 0.200, 0.400, 0.600, 0.800, 1.000]
CRQ_fnc_EN_ClimateLoop = { // TODO
	0 setFog 0;
	0 setOvercast 0;
	// if (([gCS_EnvStamp, gCS_TM_Now] call CRQ_fmc_TimeDelta) >= gCS_EnvDelay) then {
		// gCS_EnvStamp = gCS_TM_Now;
		// gCS_EnvDelay = 7.5 + random 5;
		// gCS_EnvOvercast = random 1;
		// gCS_EnvDelay setOvercast gCS_EnvOvercast;
		// systemChat str [gCS_EnvStamp,gCS_EnvDelay,gCS_EnvOvercast];
	// };
};
CRQ_fnc_MN_Loop = {
	while {true} do {
		gCS_TM_Now = [] call CRQ_fnc_TimeNow;
		{
			_x params ["_timer" , "_last"];
			private _delta = [_last, gCS_TM_Now] call CRQ_fnc_TimeDelta;
			if (!(_delta < _timer)) then {
				_x set [1, (gCS_TM_Now - (_delta % _timer)) call CRQ_fnc_TimeCoerce];
				_x call (gCS_MN_FNCU#_forEachIndex);
				_x call (gCS_MN_FNCS#_forEachIndex);
			};		
		} forEach gCS_MN_LOOP;
		(CRQ_MN_SLEEP_1 - ([gCS_TM_Now, [] call CRQ_fnc_TimeNow] call CRQ_fnc_TimeDelta)) call {if (_this > CRQ_MN_SLEEP_0) then {sleep _this;};};
	};
};
CRQ_fnc_MN_Init = {
	private _fnc_pre = {
		gCS_DT_Params = [date] call CRQ_fnc_DT_ParamsGenerate;
		gCS_DT_Start = [gCS_PM_MS_Hour, gCS_PM_MS_Minute, gCS_DT_Params] call CRQ_fnc_DT_Time;
		skipTime (gCS_DT_Start - dayTime);
		[] call CRQ_fnc_CL_Init;
		[] call CRQ_fnc_AI_Init;
		[] call CQM_MN_INIT_ZERO;
	};
	private _fnc_post = {
		skipTime (gCS_DT_Start - dayTime); // TODO find out why -autoInit ignores above preInit
		[] call CRQ_fnc_GC_CollectorInit;
		[] call CQM_MN_INIT_MAIN;
		gCS_DT_Now = dayTime;
		gCS_EN_Light = call CRQ_Lights;
	};
	[] call _fnc_pre;
	sleep CRQ_MN_INIT;
	[] call _fnc_post;
	gCS_MN_HNDL = [] spawn CRQ_fnc_MN_Loop;
};
