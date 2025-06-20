
CRA_Temp = {
	private _location = if (_this isEqualType -1) then {gRA_LC_List#(gRA_LC_IndexBase + _this)} else {_this};
	private _units = _location getVariable [CRA_SVAR_LOCATION_UNIT_PERSONNEL, []];
	{_x setDamage 1;} forEach _units;
	{[_x, _location] call CRA_fnc_PL_Teleport;} forEach gRA_PL_SYS_UnitExec;
};
CRA_Temp2 = {
	(gRA_LC_List apply {[_x getVariable ["CRA_SVAR_LC_INDEX",-1], text _x]})
};
CRA_ActionRelayReceive = {
	params ["_object", "_invoker", "_id", "_args"];
	//_args params ["_type", "_typeArgs"];
	switch (_args#0) do {
		// case CRA_ACTION_ID_PLAYER_TELEPORT: {remoteExec ["CRA_fnc_PLL_RQR_Teleport", owner _invoker];};
		// case CRA_ACTION_ID_PLAYER_PARADROP: {remoteExec ["CRA_fnc_PLL_RQR_Paradrop", owner _invoker];};
		case CRA_ACTION_ID_PLAYER_TELEPORT: {_invoker call CRA_fnc_PL_RQT_Teleport;};
		case CRA_ACTION_ID_PLAYER_PARADROP: {_invoker call CRA_fnc_PL_RQT_Paradrop;};
		case CRA_ACTION_ID_MILITIA_TRAIN: {["Train Militia: Coming soon!"] remoteExec ["systemChat", owner _invoker];};
		case CRA_ACTION_ID_INTEL_GATHER: {_args call CRA_PlayerActionBase;};
		case CRA_ACTION_ID_INVENTORY_SORT: {_args call CRA_PlayerActionBase;};
		case CRA_ACTION_ID_INVENTORY_GATHER: {_args call CRA_PlayerActionBase;};
		default {};
	};
};
CRA_ActionRelayAdd = {
	params ["_object", "_label", "_args", ["_priority", CRA_ACTION_PRIORITY], ["_range", CRA_ACTION_RANGE]];
	if (_object isEqualTo objNull) exitWith {};
	private _label = "<t color='#" + CRA_ACTION_COLOR + "'>" + _label + "</t>";
	[_object, [_label, {_this call CRA_LocalActionRelayTransmit;}, _args, _priority, true, true, "", "true", _range, false]] call CRQ_fnc_AC_Add;
};
CRA_fnc_PG_GrowthLinear = {
	params ["_base", "_span", "_factor", "_progress"];
	(_base + _span * (((_progress * _factor) min 1) max 0))
};
CRA_fnc_PG_GrowthParabolic = {
	params ["_base", "_span", "_factor", "_progress"];
	(_base + _span * (((_progress ^ _factor) min 1) max 0))
};
CRA_fnc_PG_InitZero = {
	
	gRA_PG_Value = 1;
	gRA_PG_Gain = 0;
	
	gRA_PG_FuncMission = [
		{gRA_PM_PG_MissionInit},
		{[gRA_PM_PG_MissionInit, gRA_PG_SpanMission, gRA_PM_PG_MissionFactor, gRA_PG_Gain / gRA_PG_Value] call CRA_fnc_PG_GrowthLinear},
		{[gRA_PM_PG_MissionInit, gRA_PG_SpanMission, gRA_PM_PG_MissionFactor, gRA_PG_Gain / gRA_PG_Value] call CRA_fnc_PG_GrowthParabolic},
		{[gRA_PM_PG_MissionFinal, -gRA_PG_SpanMission, gRA_PM_PG_MissionFactor, 1 - gRA_PG_Gain / gRA_PG_Value] call CRA_fnc_PG_GrowthLinear},
		{[gRA_PM_PG_MissionFinal, -gRA_PG_SpanMission, gRA_PM_PG_MissionFactor, 1 - gRA_PG_Gain / gRA_PG_Value] call CRA_fnc_PG_GrowthParabolic}
	]#gRA_PM_PG_MissionMode;
	
	gRA_PG_FuncEquipment = [
		{gRA_PM_PG_EquipmentInit},
		{[gRA_PM_PG_EquipmentInit, gRA_PG_SpanEquipment, gRA_PM_PG_EquipmentFactor, gRA_PG_Mission] call CRA_fnc_PG_GrowthLinear},
		{[gRA_PM_PG_EquipmentInit, gRA_PG_SpanEquipment, gRA_PM_PG_EquipmentFactor, gRA_PG_Mission] call CRA_fnc_PG_GrowthParabolic},
		{[gRA_PM_PG_EquipmentFinal, -gRA_PG_SpanEquipment, gRA_PM_PG_EquipmentFactor, 1 - gRA_PG_Mission] call CRA_fnc_PG_GrowthLinear},
		{[gRA_PM_PG_EquipmentFinal, -gRA_PG_SpanEquipment, gRA_PM_PG_EquipmentFactor, 1 - gRA_PG_Mission] call CRA_fnc_PG_GrowthParabolic}
	]#gRA_PM_PG_EquipmentMode;
	
	gRA_PG_FuncActivation = [
		{gRA_PM_PG_ActivationInit},
		{[gRA_PM_PG_ActivationInit, gRA_PG_SpanActivation, gRA_PM_PG_ActivationFactor, gRA_PG_Mission] call CRA_fnc_PG_GrowthLinear},
		{[gRA_PM_PG_ActivationInit, gRA_PG_SpanActivation, gRA_PM_PG_ActivationFactor, gRA_PG_Mission] call CRA_fnc_PG_GrowthParabolic},
		{[gRA_PM_PG_ActivationFinal, -gRA_PG_SpanActivation, gRA_PM_PG_ActivationFactor, 1 - gRA_PG_Mission] call CRA_fnc_PG_GrowthLinear},
		{[gRA_PM_PG_ActivationFinal, -gRA_PG_SpanActivation, gRA_PM_PG_ActivationFactor, 1 - gRA_PG_Mission] call CRA_fnc_PG_GrowthParabolic}
	]#gRA_PM_PG_ActivationMode;
	
	gRA_PG_FuncEnemyArmy = [
		{gRA_PM_PG_EnemyArmyInit},
		{[gRA_PM_PG_EnemyArmyInit, gRA_PG_SpanEnemyArmy, gRA_PM_PG_EnemyArmyFactor, gRA_PG_Mission] call CRA_fnc_PG_GrowthLinear},
		{[gRA_PM_PG_EnemyArmyInit, gRA_PG_SpanEnemyArmy, gRA_PM_PG_EnemyArmyFactor, gRA_PG_Mission] call CRA_fnc_PG_GrowthParabolic},
		{[gRA_PM_PG_EnemyArmyFinal, -gRA_PG_SpanEnemyArmy, gRA_PM_PG_EnemyArmyFactor, 1 - gRA_PG_Mission] call CRA_fnc_PG_GrowthLinear},
		{[gRA_PM_PG_EnemyArmyFinal, -gRA_PG_SpanEnemyArmy, gRA_PM_PG_EnemyArmyFactor, 1 - gRA_PG_Mission] call CRA_fnc_PG_GrowthParabolic}
	]#gRA_PM_PG_EnemyArmyMode;
	
	gRA_PG_FuncEnemyCountBase = [
		{gRA_PM_PG_EnemyCountInit},
		{[gRA_PM_PG_EnemyCountInit, gRA_PG_SpanEnemyCountBase, gRA_PM_PG_EnemyCountFactor, gRA_PG_Mission] call CRA_fnc_PG_GrowthLinear},
		{[gRA_PM_PG_EnemyCountInit, gRA_PG_SpanEnemyCountBase, gRA_PM_PG_EnemyCountFactor, gRA_PG_Mission] call CRA_fnc_PG_GrowthParabolic},
		{[gRA_PM_PG_EnemyCountFinal, -gRA_PG_SpanEnemyCountBase, gRA_PM_PG_EnemyCountFactor, 1 - gRA_PG_Mission] call CRA_fnc_PG_GrowthLinear},
		{[gRA_PM_PG_EnemyCountFinal, -gRA_PG_SpanEnemyCountBase, gRA_PM_PG_EnemyCountFactor, 1 - gRA_PG_Mission] call CRA_fnc_PG_GrowthParabolic}
	]#gRA_PM_PG_EnemyCountMode;
	
	gRA_PG_FuncEnemyCountVarianceBase = [
		{gRA_PM_PG_EnemyCountVarianceInit},
		{[gRA_PM_PG_EnemyCountVarianceInit, gRA_PG_SpanEnemyCountVariance, gRA_PM_PG_EnemyCountVarianceFactor, gRA_PG_Mission] call CRA_fnc_PG_GrowthLinear},
		{[gRA_PM_PG_EnemyCountVarianceInit, gRA_PG_SpanEnemyCountVariance, gRA_PM_PG_EnemyCountVarianceFactor, gRA_PG_Mission] call CRA_fnc_PG_GrowthParabolic},
		{[gRA_PM_PG_EnemyCountVarianceFinal, -gRA_PG_SpanEnemyCountVariance, gRA_PM_PG_EnemyCountVarianceFactor, 1 - gRA_PG_Mission] call CRA_fnc_PG_GrowthLinear},
		{[gRA_PM_PG_EnemyCountVarianceFinal, -gRA_PG_SpanEnemyCountVariance, gRA_PM_PG_EnemyCountVarianceFactor, 1 - gRA_PG_Mission] call CRA_fnc_PG_GrowthParabolic}
	]#gRA_PM_PG_EnemyCountVarianceMode;
	gRA_PG_FuncEnemyCountVarianceDist = [
		{[1 - _this, 2 * _this, 0]},
		{[1 - _this, 1, 1 + _this]}
	]#gRA_PM_PG_EnemyCountVarianceDist;
	
	
	gRA_PG_FuncEnemySkillBase = [
		{gRA_PM_PG_EnemySkillInit},
		{[gRA_PM_PG_EnemySkillInit, gRA_PG_SpanEnemySkillBase, gRA_PM_PG_EnemySkillFactor, gRA_PG_Mission] call CRA_fnc_PG_GrowthLinear},
		{[gRA_PM_PG_EnemySkillInit, gRA_PG_SpanEnemySkillBase, gRA_PM_PG_EnemySkillFactor, gRA_PG_Mission] call CRA_fnc_PG_GrowthParabolic},
		{[gRA_PM_PG_EnemySkillFinal, -gRA_PG_SpanEnemySkillBase, gRA_PM_PG_EnemySkillFactor, 1 - gRA_PG_Mission] call CRA_fnc_PG_GrowthLinear},
		{[gRA_PM_PG_EnemySkillFinal, -gRA_PG_SpanEnemySkillBase, gRA_PM_PG_EnemySkillFactor, 1 - gRA_PG_Mission] call CRA_fnc_PG_GrowthParabolic}
	]#gRA_PM_PG_EnemySkillMode;
	
	gRA_PG_FuncEnemySkillVarianceBase = [
		{gRA_PM_PG_EnemySkillVarianceInit},
		{[gRA_PM_PG_EnemySkillVarianceInit, gRA_PG_SpanEnemySkillVariance, gRA_PM_PG_EnemySkillVarianceFactor, gRA_PG_Mission] call CRA_fnc_PG_GrowthLinear},
		{[gRA_PM_PG_EnemySkillVarianceInit, gRA_PG_SpanEnemySkillVariance, gRA_PM_PG_EnemySkillVarianceFactor, gRA_PG_Mission] call CRA_fnc_PG_GrowthParabolic},
		{[gRA_PM_PG_EnemySkillVarianceFinal, -gRA_PG_SpanEnemySkillVariance, gRA_PM_PG_EnemySkillVarianceFactor, 1 - gRA_PG_Mission] call CRA_fnc_PG_GrowthLinear},
		{[gRA_PM_PG_EnemySkillVarianceFinal, -gRA_PG_SpanEnemySkillVariance, gRA_PM_PG_EnemySkillVarianceFactor, 1 - gRA_PG_Mission] call CRA_fnc_PG_GrowthParabolic}
	]#gRA_PM_PG_EnemySkillVarianceMode;
	gRA_PG_FuncEnemySkillVarianceDist = [
		{[1 - _this, 2 * _this, 0]},
		{[1 - _this, 1, 1 + _this]}
	]#gRA_PM_PG_EnemySkillVarianceDist;
	
	gRA_PG_CoeffEnemyCountPlayer = 1 / (1 max (playableSlotsNumber (CRA_PLAYER_SIDE call CRQ_Side) - 1));
	gRA_PG_FuncEnemyCountPlayer = [
		{gRA_PM_PG_EnemyCountPlayerInit},
		{[gRA_PM_PG_EnemyCountPlayerInit, gRA_PG_SpanEnemyCountPlayer, gRA_PM_PG_EnemyCountPlayerFactor, (((gRA_PL_SYS_Count) - 1) max 0) * gRA_PG_CoeffEnemyCountPlayer] call CRA_fnc_PG_GrowthLinear},
		{[gRA_PM_PG_EnemyCountPlayerInit, gRA_PG_SpanEnemyCountPlayer, gRA_PM_PG_EnemyCountPlayerFactor, (((gRA_PL_SYS_Count) - 1) max 0) * gRA_PG_CoeffEnemyCountPlayer] call CRA_fnc_PG_GrowthParabolic},
		{[gRA_PM_PG_EnemyCountPlayerFinal, -gRA_PG_SpanEnemyCountPlayer, gRA_PM_PG_EnemyCountPlayerFactor, 1 - (((gRA_PL_SYS_Count) - 1) max 0) * gRA_PG_CoeffEnemyCountPlayer] call CRA_fnc_PG_GrowthLinear},
		{[gRA_PM_PG_EnemyCountPlayerFinal, -gRA_PG_SpanEnemyCountPlayer, gRA_PM_PG_EnemyCountPlayerFactor, 1 - (((gRA_PL_SYS_Count) - 1) max 0) * gRA_PG_CoeffEnemyCountPlayer] call CRA_fnc_PG_GrowthParabolic}
	]#gRA_PM_PG_EnemyCountPlayerMode;
	
	gRA_PG_FuncVarianceEnemyCount = [
		{(gRA_PG_EnemyCountVariance#0) + random (gRA_PG_EnemyCountVariance#1)},
		{random gRA_PG_EnemyCountVariance}
	]#gRA_PM_PG_EnemyCountVarianceDist;
	gRA_PG_FuncVarianceEnemySkill = [
		{(gRA_PG_EnemySkillVariance#0) + random (gRA_PG_EnemySkillVariance#1)},
		{random gRA_PG_EnemySkillVariance}
	]#gRA_PM_PG_EnemySkillVarianceDist;
	
	[] call CRA_fnc_PG_Calculate;
};
CRA_fnc_PG_InitMain = {
	gRA_PG_Value = 0;
	{gRA_PG_Value = gRA_PG_Value + (_x getVariable [CRA_SVAR_LC_VALUE, 0]);} forEach gRA_LC_List;
	gRA_PG_Value = 1 max gRA_PG_Value;
};
CRA_fnc_PG_Calculate = {
	gRA_PG_Mission = [] call gRA_PG_FuncMission;
	gRA_PG_Equipment = [] call gRA_PG_FuncEquipment;
	gRA_PG_Activation = [] call gRA_PG_FuncActivation;
	gRA_PG_EnemyArmy = [] call gRA_PG_FuncEnemyArmy;
	gRA_PG_EnemyCountBase = [] call gRA_PG_FuncEnemyCountBase;
	gRA_PG_EnemySkillBase = [] call gRA_PG_FuncEnemySkillBase;
	gRA_PG_EnemyCountVariance = ([] call gRA_PG_FuncEnemyCountVarianceBase) call gRA_PG_FuncEnemyCountVarianceDist;
	gRA_PG_EnemySkillVariance = ([] call gRA_PG_FuncEnemySkillVarianceBase) call gRA_PG_FuncEnemySkillVarianceDist;
};
CRA_fnc_PG_Award = {
	gRA_PG_Gain = gRA_PG_Gain + _this;
	[] call CRA_fnc_PG_Calculate;
};
CRA_fnc_PL_InitZero = {
	gRA_PL_MapIndex = createHashMap;
	private _index = 0;
	{
		private _side = _forEachIndex;
		private _vars = [];
		private _data = [];
		for "_i" from 0 to (_x - 1) do {
			private _name = toLowerANSI(CRA_PLAYER_VAR + str _index);
			_vars pushBack _name;
			gRA_PL_MapIndex set [_name, [_side, _i]];
			_data pushBack (createHashMapFromArray [
				["_stInit", false],
				["_stTrvl", false],
				["_stExec", false],
				["_unit", objNull],
				["_inv", []],
				["_mail", []],
				["_cache", []]
			]);
			_index = _index + 1;
		};
		gRA_PL_MapVars set [_side, _vars];
		gRA_PL_Data set [_side, _data];
	} forEach (CRQ_SD_TYPES apply {playableSlotsNumber _x});
};
CRA_fnc_PL_InitMain = {
	[
		gRA_PL_MapIndex apply {_y},
		[false, [], date, [CRA_TEXT_GENERIC_DICT,[CRA_DICT_PROTAGONIST_MAIL]], [CRA_TEXT_MAIL_SUBJECT_GREET,[-1]], [CRA_TEXT_MAIL_TEXT_GREET,[-1,CRA_DICT_ANTAGONIST_SHORT,-1,CRA_DICT_PROTAGONIST_FULL]]]
	] call CRA_fnc_PL_MailSend;
};
CRA_fnc_PL_Loop = {
	private _plAssets = gRA_PL_SYS_Asset select {_x isNotEqualTo objNull}; // TODO: And is alive?
	gRA_PL_SYS_Pos = [];
	gRA_PL_SYS_UnitInit = [];
	gRA_PL_SYS_UnitExec = [];
	{
		private _plSide = _forEachIndex;
		{
			(values _x) params (keys _x);
			if (_stInit && {_unit isNotEqualTo objNull}) then {
				gRA_PL_SYS_UnitInit pushBack _unit;
				private _pos = _unit call CRQ_Pos2D;
				gRA_PL_SYS_Pos pushBack (
				if (_stTrvl) then {
					_cache params ["_wait", "_dist", "_cacheVec"];
					if (_wait > 0 && {(_pos distance2D (_cacheVec#0)) > _dist}) then {
						_cache set [0, _wait - 1];
						_cacheVec#0
					} else {
						// _unit call CRA_fnc_PL_Show; // this is actually being called elsewhere... client sync issue?
						_x set ["_stTrvl", false];
						_x set ["_cache", []];
						_pos
					};
				} else {
					if (_stExec) then {gRA_PL_SYS_UnitExec pushBack _unit;};
					private _asset = _unit call CRA_fnc_AS_Player;
					if (_asset isNotEqualTo objNull) then {_plAssets pushBackUnique _asset;};
					_pos
				});
			};
		} forEach _x;
	} forEach gRA_PL_Data;
	gRA_PL_SYS_Count = count gRA_PL_SYS_UnitInit;
	gRA_PL_SYS_Asset = (count _plAssets) call {_plAssets select ([[0, _this], [_this - CRA_PLAYER_ASSETS , CRA_PLAYER_ASSETS]] select (_this > CRA_PLAYER_ASSETS))};
};
CRA_fnc_PL_GetUnit = {
	params [["_side", -1], ["_index", -1]];
	if (_side < 0 || {_index < 0}) exitWith {objNull};
	missionNamespace getVariable [gRA_PL_MapVars#_side#_index, objNull]
};
CRA_fnc_PL_GetIndex = {
	(gRA_PL_MapIndex getOrDefault [toLowerANSI vehicleVarName _this, [-1, -1]])
};
CRA_fnc_PL_GetData = {
	(_this call CRA_fnc_PL_GetIndex) params ["_side", "_index"];
	if (_side < 0 || {_index < 0}) exitWith {createHashMap};
	(gRA_PL_Data#_side#_index)
};
CRA_fnc_PL_Hide = {
	_this hideObjectGlobal true;
	(_this call CRA_fnc_PL_GetData) set ["_stExec", false];
};
CRA_fnc_PL_Show = {
	_this hideObjectGlobal false;
	(_this call CRA_fnc_PL_GetData) set ["_stExec", true];
};
CRA_fnc_PL_MailRead = {
	params ["_unit", "_mlIndex", ["_mlRead", true]];
	private _mlBox = (_unit call CRA_fnc_PL_GetData) getOrDefault ["_mail", []];
	if (_mlIndex < 0 || {!(_mlIndex < count _mlBox)}) exitWith {};
	(_mlBox#_mlIndex) set [0, _mlRead];
};
CRA_fnc_PL_MailSend = {
	params ["_recipient", "_mlData"];
	//_mlData params ["_read", "_attachment", "_date", "_sender", "_subject", "_text"];
	{
		_x params ["_side", "_index"];
		if (!(_side < 0 || {_index < 0})) then {
			private _mlBox = (gRA_PL_Data#_side#_index) getOrDefault ["_mail", []];
			private _mlIndex = count _mlBox;
			_mlBox pushBack (+_mlData);
			private _owner = owner (_x call CRA_fnc_PL_GetUnit);
			if (_owner > 0) then {[CRA_PVAR_PLAYER_MAILBOX, _mlIndex, _mlData, _owner] call CRQ_SyncArrayIndex;};
		};
	} forEach _recipient;
};
CRA_fnc_PL_Connect = {
//systemChat "CRA_fnc_PL_Connect";
	params ["_unit", "_id", "_uid", "_name", "_jip"];
	private _data = _unit call CRA_fnc_PL_GetData;
	_data set ["_unit", _unit];
	_data set ["_stInit", false];
	_data set ["_stTrvl", false];
	_data set ["_stExec", false];
	[CRA_PVAR_PLAYER_MAILBOX, _data getOrDefault ["_mail", []], owner _unit] call CRQ_SyncArrayFull;
};
CRA_fnc_PL_Disconnect = {
	params ["_unit", "_id", "_uid", "_name"];
	private _loadout = getUnitLoadout _unit;
	private _data = _unit call CRA_fnc_PL_GetData;
	_unit call CRQ_UnitDelete;
	_data set ["_unit", objNull];
	_data set ["_stInit", false];
	_data set ["_stTrvl", false];
	_data set ["_stExec", false];
	_data set ["_inv", _loadout];
};
CRA_fnc_PL_Spawn = {
	params ["_unit", "_corpse"];
	if (_corpse isNotEqualTo objNull) then {(_unit call CRA_fnc_PL_GetData) set ["_unit", _unit];};
	_unit call CRA_fnc_PL_Hide;
	_unit call CRA_fnc_PL_Loadout;
	_unit call CRA_fnc_PL_RQT_Spawn;
};
CRA_fnc_PL_Register = { // TODO(?): Sometimes spawn before connect, sometimes other way around
	
};
CRA_fnc_PL_Teleport = {
	params ["_unit", "_location"];
	private _vec = _location getVariable [CRA_SVAR_LC_SPAWN_PLAYER, []];
	if (_vec isEqualTo []) then {_vec = [locationPosition _location, random 360];};
	[_unit, _vec] remoteExec ["CRA_fnc_PLL_Teleport", owner _unit]; // setting Dir only works locally
	[_unit, _vec, 8, 50] call CRA_fnc_PL_Travel;
};
CRA_fnc_PL_Paradrop = {
	// params ["_unit", "_vec"];
	_this remoteExec ["CRA_fnc_PLL_Paradrop", owner _unit];
	_this call CRA_fnc_PL_Travel;
};
CRA_fnc_PL_Travel = {
	params ["_unit", "_vec", ["_wait", 4], ["_dist", 500]];
	private _data = _unit call CRA_fnc_PL_GetData;
	_data set ["_stTrvl", true];
	_data set ["_cache", [_wait, _dist, _vec]];
};
CRA_fnc_PL_RQT_Spawn = {
	remoteExec ["CRA_fnc_PLL_RQR_Spawn", owner _this];
};
CRA_fnc_PL_RQT_Teleport = {
	remoteExec ["CRA_fnc_PLL_RQR_Teleport", owner _this];
};
CRA_fnc_PL_RQT_Paradrop = {
	remoteExec ["CRA_fnc_PLL_RQR_Paradrop", owner _this];
};
CRA_fnc_PL_RQR_Spawn = {
	params ["_unit", "_index", ["_vec", []]];
	private _valid = true; // TODO
	if (_valid) exitWith {
		if (_index < 0) then {
			[_unit, _vec] call CRA_fnc_PL_Paradrop;
		} else {
			[_unit, (gRA_LC_List#_index)] call CRA_fnc_PL_Teleport;
		};
		(_unit call CRA_fnc_PL_GetData) set ["_stInit", true];
		_unit call CRA_fnc_PL_Show;
		_unit call CRQ_fnc_CL_Restore;
	};
	_unit call CRA_fnc_PL_RQT_Spawn;
};
CRA_fnc_PL_RQR_Teleport = {
	params ["_unit", "_index"];
	if (_index == -1) exitWith {};
	if (gRA_LC_Safe getOrDefault [_index, false]) exitWith {[_unit, gRA_LC_List#_index] call CRA_fnc_PL_Teleport;};
	[CRA_TEXT_EVENT_LOCATION_INSECURE, [_index], owner _unit] call CRA_fnc_PL_InfoMessage;
};
CRA_fnc_PL_RQR_Paradrop = {
	params ["_unit", "_vec"];
	private _valid = true; // TODO
	if (_valid) exitWith {[_unit, _vec] call CRA_fnc_PL_Paradrop;};
};
CRA_fnc_PL_Activity = {
	params ["_vec", "_range", ["_prev", 0], ["_min", -1e10], ["_max", 1e10]];
	private _pos = _vec#0;
	if (gRA_PL_SYS_Pos isEqualTo []) exitWith {_min};
	private _dist = gRA_PL_SYS_Pos apply {_pos distance2D _x};
	if (_dist isEqualTo []) exitWith {_min};
	private _closest = selectMin _dist;
	private _activity = (CRA_ACTIVITY_COEF * _range / (1 max _closest)) max _prev;
	private _decay = CRA_ACTIVITY_COEF * _closest / (_range + CRA_ACTIVITY_HYSTERESIS);
	(((_activity - _decay) max _min) min _max)
};
CRA_fnc_PL_Loadout = {
	(_this call CRA_fnc_PL_GetIndex) params ["_side", "_index"];
	private _loadout = [];
	if (_side < 0 || {_index < 0}) then {
		_loadout = (CRA_UNIT_PLAYER_DEFAULT call CRA_UnitGenerate)#1;
	} else {
		private _data = (gRA_PL_Data#_side#_index);
		_loadout = +(_data getOrDefault ["_inv", []]);
		if (_loadout isNotEqualTo []) then {
			_data set ["_inv", []];
		} else {
			_loadout = (_index call CRA_UnitGenerate)#1;
		};
	};
	private _identity = if (gRA_PM_PL_Identity && {_index != -1}) then {dCRA_PLAYER_IDENTITY#_index} else {[]};
	[_this, _identity, _loadout] remoteExec ["CRQ_fnc_PLL_IdentityLoadout", owner _this];
};
CRA_fnc_PL_InfoMessage = {
	params ["_message", "_arg", ["_target", gCS_MP_Broadcast]];
	[_message, _arg] remoteExec ["CRA_fnc_PLL_InfoMessage", _target];
};
CRA_fnc_PL_InfoNotify = {
	params ["_message", "_arg", ["_target", gCS_MP_Broadcast]];
	[_message, _arg] remoteExec ["CRA_fnc_PLL_InfoNotify", _target];
};
CRA_PlayerActionBase = {
	private _location = gRA_LC_List#(_this#1);
	if (true) then { // TODO
		switch (_this#0) do {
			case CRA_ACTION_ID_INVENTORY_SORT: {
				_location call CRA_LocationInventorySort;
				[CRA_TEXT_INFO_BASE_INVENTORY_SORT,[_this#1]] call CRA_fnc_PL_InfoMessage;
			};
			case CRA_ACTION_ID_INVENTORY_GATHER: {
				([_location, _this#2] call CRA_LocationInventoryGather) params ["_countItems", "_countMags", "_countWeapons", "_countContainers"];
				[CRA_TEXT_INFO_BASE_INVENTORY_GATHER,[_this#1, _this#2]] call CRA_fnc_PL_InfoMessage;
				[CRA_TEXT_INFO_BASE_INVENTORY_GATHER_RESULT,[_this#1, _countWeapons, _countMags, _countContainers, _countItems]] call CRA_fnc_PL_InfoMessage;
			};
			case CRA_ACTION_ID_INTEL_GATHER: {
				(_location call CRA_LocationIntelGather) params [["_range", 0], ["_intel", []]];
				if (_range <= 0) exitWith {};
				private _info = "";
				{
					private _label = str _y + "x" + _x;
					if (_forEachIndex > 0) then {_info = _info + ", " + _label;} else {_info = _label;};
				} forEach _intel;
				if (_info isNotEqualTo "") then {
					[CRA_TEXT_INFO_INTEL_GATHER,[_this#1, _range, _info]] call CRA_fnc_PL_InfoMessage;
				} else {
					[CRA_TEXT_INFO_INTEL_NONE,[_this#1, _range]] call CRA_fnc_PL_InfoMessage;
				};
			};
			default {};
		};
	} else {
		[CRA_TEXT_EVENT_LOCATION_INSECURE,[_this#1]] call CRA_fnc_PL_InfoMessage;
	};
};
CRA_PlayerLocationSafe = {
	private _safe = createHashMap;
	private _locations = [];
	{
		if ((_x call CRA_fnc_LC_Owner) == CRA_PLAYER_SIDE) then {
			private _index = _x getVariable [CRA_SVAR_LC_INDEX, -1];
			if (_index == -1) exitWith {};
			_safe set [_index, true];
			_locations pushBackUnique _index;
		};
	} forEach gRA_LC_History;
	gRA_LC_Safe = _safe;
	missionNamespace setVariable ["pRA_LocationSafe", _locations, true];
};
CRA_PlayerLocationEnter = {
	private _index = _this getVariable [CRA_SVAR_LC_INDEX, -1];
	if (_index == -1) exitWith {};
	(if ([CRA_LC_TYPE_OUTPOST, CRA_LC_TYPE_ROADBLOCK] find (_this getVariable [CRA_SVAR_LOCATION_TYPE, CRA_LC_TYPE_OUTPOST]) != -1) then {
		[CRA_TEXT_EVENT_LOCATION_ANNOUNCE_SHORT, [_index]]
	} else {
		[CRA_TEXT_EVENT_LOCATION_ANNOUNCE_FULL, [_index, _this call CRA_fnc_LC_Owner]]
	}) call CRA_fnc_PL_InfoMessage;
};
CRA_PlayerLocationCapture = {
	private _index = _this getVariable [CRA_SVAR_LC_INDEX, -1];
	if (_index == -1) exitWith {};
	private _owner = _this call CRA_fnc_LC_Owner;
	private _ownerPrev = [_this, 1] call CRA_fnc_LC_Owner;
	private _message = if (_owner != CRQ_SD_CIV) then {
		if (_ownerPrev != CRQ_SD_CIV) then {
			[CRA_TEXT_EVENT_LOCATION_CAPTURE_FROM, [_index, _owner, _ownerPrev]]
		} else {
			[CRA_TEXT_EVENT_LOCATION_CAPTURE, [_index, _owner]]
		};
	} else {
		[CRA_TEXT_EVENT_LOCATION_LOST, [_index, _ownerPrev]]
	};
	_message call CRA_fnc_PL_InfoMessage;
	private _player = false;
	if (_ownerPrev isEqualTo CRA_PLAYER_SIDE) then {_this call CRA_PlayerLocationLost; _player = true;};
	if (_owner isEqualTo CRA_PLAYER_SIDE) then {_this call CRA_PlayerLocationWin; _player = true;};
	if (_player) then {[] call CRA_PlayerLocationSafe;};
};
CRA_PlayerLocationWin = {
	if (_this getVariable [CRA_SVAR_LOCATION_UNCAPTURED, false]) then {
		(_this getVariable [CRA_SVAR_LC_VALUE, 0]) call CRA_fnc_PG_Award;
		_this setVariable [CRA_SVAR_LOCATION_UNCAPTURED, false];
		gRA_LC_History pushBack _this;
	};
	private _index = _this getVariable [CRA_SVAR_LC_INDEX, -1];
	if (_index == -1) exitWith {};
	[CRA_TEXT_NOTIFY_LOCATION_GAIN, [_index]] call CRA_fnc_PL_InfoNotify;
	remoteExec ["CRA_fnc_PLL_LocationWin", gCS_MP_Broadcast];
};
CRA_PlayerLocationLost = {
	private _index = _this getVariable [CRA_SVAR_LC_INDEX, -1];
	if (_index == -1) exitWith {};
	[CRA_TEXT_NOTIFY_LOCATION_LOST, [_index]] call CRA_fnc_PL_InfoNotify;
	remoteExec ["CRA_fnc_PLL_LocationLost", gCS_MP_Broadcast];
};
CRA_LocationPersonnelSpawn = {
	private _owner = _this call CRA_fnc_LC_Owner;
	private _factions = switch (_owner) do { // TODO does this -1 fix really fix it? D338: I think it does and is correct?
		case CRQ_SD_OPF: {CRA_FACTION_OPFOR#(floor (gRA_PG_Mission * (count CRA_FACTION_OPFOR - 1)))};
		case CRQ_SD_IND: {CRA_FACTION_IDFOR#(floor (gRA_PG_Mission * (count CRA_FACTION_IDFOR - 1)))};
		default {[]};
	};
	private _faction = (_factions#1) selectRandomWeighted (_factions#0);
	private _strength = _this getVariable [CRA_SVAR_LOCATION_STRENGTH, [1,1,1]];
	private _groups = [];
	private _units = [];
	private _vehicles = [];
	{
		(_x#0) params ["_role", "_count", "_args"];
		private _group = grpNull;
		switch (_role) do {
			case CRA_GP_T_GUARD: {
				if (_count < 0) then {_count = -(_count) * (_strength#0);};
				_group = _owner call CRA_fnc_GP_Create;
				_units append ([_group, selectRandom (_x#1), [_faction, _count, _args] call CRA_UnitList] call CRA_GroupPopulate);
			};
			case CRA_GP_T_SPOT: {
				if (_count < 0)  then {_count = -(_count) * (_strength#1);};
				_group = _owner call CRA_fnc_GP_Create;
				_units append ([_group, selectRandom (_x#1), [_faction, _count, _args, [0,360]] call CRA_UnitList] call CRA_GroupPopulate);
			};
			case CRA_GP_T_PATROL: {
				if (_count < 0)  then {_count = -(_count) * (_strength#2);};
				_group = _owner call CRA_fnc_GP_Create;
				_units append ([_group, selectRandom (_x#1), [_faction, _count, _args] call CRA_UnitList] call CRA_GroupPopulate);
			};
			case CRA_GP_T_VEHICLE: {
				private _vehicleTypes = _args apply {if (_x#0 != CRQ_SD_UNKNOWN) then {_x} else {[_owner, _x#1, _x#2]}};
				private _vehicleIndex = [_vehicleTypes, 0 call CRA_fnc_IT_Quality] call CRA_fnc_AS_Random;
				if (_vehicleIndex != -1) then {
					_group = _owner call CRA_fnc_GP_Create;
					_vehicles pushBack ([_vehicleIndex, [(selectRandom (_x#1))#0, random 360], [_group, [-1, -1, -1, random -1]]] call CRA_fnc_AS_Create);
					_units append (units _group);
				};
			};
			case CRA_GP_T_STATIC: {
				private _staticIndex = [[[_owner,CRA_ASSET_STATIC,_args#0]], 0 call CRA_fnc_IT_Quality] call CRA_fnc_AS_Random;
				if (_staticIndex != -1) then {
					_group = _owner call CRA_fnc_GP_Create;
					_vehicles pushBack ([_staticIndex, selectRandom (_x#1), [_group, [-1, -1, -1, 0]]] call CRA_fnc_AS_Create);
					_units append (units _group);
				};
			};
			default {};
		};
		_groups pushBack _group;
	} forEach (_this getVariable [CRA_SVAR_LOCATION_BASE_PERSONNEL, []]);
	_this setVariable [CRA_SVAR_LOCATION_GROUP_PERSONNEL, _groups];
	_this setVariable [CRA_SVAR_LOCATION_UNIT_PERSONNEL, _units];
	_this setVariable [CRA_SVAR_LOCATION_UNIT_VEHICLE, _vehicles];
	_this setVariable [CRA_SVAR_LOCATION_COUNT_PERSONNEL, count _units];
	_this setVariable [CRA_SVAR_LOCATION_COUNT_VEHICLE, count _vehicles];
};
CRA_LocationPersonnelClear = {
	_this setVariable [CRA_SVAR_LOCATION_HIBERNATE_GROUPS, []];
	_this setVariable [CRA_SVAR_LOCATION_HIBERNATE_UNITS, []];
	_this setVariable [CRA_SVAR_LOCATION_HIBERNATE_VEHICLES, []];
	{if (_x isNotEqualTo objNull) then {[_x, true] call CRA_fnc_AS_Register;};} forEach (_this getVariable [CRA_SVAR_LOCATION_UNIT_VEHICLE, []]);
	_this setVariable [CRA_SVAR_LOCATION_UNIT_VEHICLE, []];
	_this setVariable [CRA_SVAR_LOCATION_COUNT_PERSONNEL, 0];
	_this setVariable [CRA_SVAR_LOCATION_COUNT_VEHICLE, 0];
};
CRA_LocationPersonnelDespawn = {
	{if (!isNull _x) then {_x call CRQ_VehicleDelete;};} forEach (_this getVariable [CRA_SVAR_LOCATION_UNIT_VEHICLE, []]);
	{if (!isNull _x) then {_x call CRQ_UnitDelete;};} forEach (_this getVariable [CRA_SVAR_LOCATION_UNIT_PERSONNEL, []]);
	{if (!isNull _x) then {deleteGroup _x;};} forEach (_this getVariable [CRA_SVAR_LOCATION_GROUP_PERSONNEL, []]);
	_this setVariable [CRA_SVAR_LOCATION_UNIT_VEHICLE, []];
	_this setVariable [CRA_SVAR_LOCATION_UNIT_PERSONNEL, []];
	_this setVariable [CRA_SVAR_LOCATION_GROUP_PERSONNEL, []];
};
CRA_LocationPersonnelOrders = {
	private _data = _this getVariable [CRA_SVAR_LOCATION_BASE_PERSONNEL, []];
	{
		if (_x isNotEqualTo grpNull) then {
			(_data#_forEachIndex) params ["_config", "_waypoints"];
			[_x, CRQ_AI_F_RAND, CRQ_AI_M_SAFE, CRQ_AI_S_LIMITED] call CRQ_fnc_AI_STS;
			[_x, _waypoints] call ([CRQ_WaypointInfantryGarrison,CRQ_WaypointInfantrySpot,CRQ_WaypointInfantryPatrol,CRQ_WaypointVehiclePatrol,{}]#(_config#0));
		};
	} forEach (_this getVariable [CRA_SVAR_LOCATION_GROUP_PERSONNEL, []]);
};
CRA_LocationPersonnelLoop = {
	private _units = _this getVariable [CRA_SVAR_LOCATION_UNIT_PERSONNEL, []];
	private _vehicles = _this getVariable [CRA_SVAR_LOCATION_UNIT_VEHICLE, []];
	private _groups = _this getVariable [CRA_SVAR_LOCATION_GROUP_PERSONNEL, []];
	{if (!isNull _x && {!alive _x}) then {_units set [_forEachIndex, objNull];};} forEach _units;
	{if (!isNull _x && {!alive _x}) then {_vehicles set [_forEachIndex, objNull];};} forEach _vehicles;
	{if (!isNull _x && {units _x isEqualTo []}) then {deleteGroup _x; _groups set [_forEachIndex, grpNull];};} forEach _groups; // TODO: GC-collect groups too, I guess?
	_this setVariable [CRA_SVAR_LOCATION_UNIT_PERSONNEL, _units];
	_this setVariable [CRA_SVAR_LOCATION_UNIT_VEHICLE, _vehicles];
	_this setVariable [CRA_SVAR_LOCATION_GROUP_PERSONNEL, _groups];
};
CRA_UnitSkill = {
	(1 min (gRA_PG_EnemySkillBase * ([] call gRA_PG_FuncVarianceEnemySkill)))
};
CRA_UnitList = {
	params ["_faction", "_count", "_args"];
	private _sqSource = dCRA_SQUADS#_faction;
	
	private _sqIndex = _args#0;
	(_sqSource#_sqIndex) params [["_sqConfig", [0, [[1,1e10],-1]]]];
	_sqConfig params ["_sqFallback", "_sqCount"];
	
	while {_sqFallback >= 0} do {
		_sqIndex = _sqFallback;
		_sqFallback = _sqSource#_sqIndex#0#0;
	};
	
	_sqCount params ["_cntClamp", "_cntMod"];
	private _cntBase = if (_cntMod < 0) then {-_cntMod * _count} else {_cntMod};
	private _cntProg = round (_cntBase * gRA_PG_EnemyCountBase * ([] call gRA_PG_FuncEnemyCountPlayer) * ([] call gRA_PG_FuncVarianceEnemyCount));
	private _cntFinal =  (_cntClamp#0) max ((_cntClamp#1) min _cntProg);
	
	(_sqSource#_sqIndex#1) params ["_ldWeight", "_ldType", "_sqWeight", "_sqType"];
	private _units = [(_ldType selectRandomWeighted _ldWeight) call CRA_UnitGenerate];
	for "_i" from 2 to _cntFinal do {_units pushBack (((_sqType selectRandomWeighted _sqWeight) call {(_this#1) selectRandomWeighted (_this#0)}) call CRA_UnitGenerate);};
	
	_units
};
CRA_GroupPopulate = {
	params ["_group", "_vec", "_types", ["_scatter", [3, 360]]];
	private _scPos = _scatter#0;
	private _scDir = _scatter#1;
	private _pos = (_vec#0) vectorAdd [_scPos / -2, _scPos / -2, 0];
	private _dir = (_vec#1) - _scDir / -2;
	private _units = _types apply {[_group, _x#0, [_pos vectorAdd [random _scPos, random _scPos, 0], _dir + random _scDir], _x#1, [] call CRA_UnitSkill] call CRQ_UnitCreate};
	private _relation = _group call CRA_fnc_SD_RelationPlayer;
	{[_x, _relation call CRQ_CatalogIdentityGenerate] call CRQ_CatalogIdentityApply;} forEach _units;
	_units
};

CRA_fnc_GP_TSK_AI_Terminate = {
	(if (_this isEqualType grpNull) then {[_this]} else {_this}) params [["_group", grpNull], ["_timeOut", CRA_GP_TSK_AI_TIMEOUT]];
	(_group getVariable [CRA_SVAR_GP_TASK, []]) params [["_tskType", CRA_GP_TSK_UNKNOWN], ["_tskTime", gCS_TM_Now - _timeOut], ["_tskAI", scriptNull]];
	if (_tskAI isEqualTo scriptNull || {([_tskTime, gCS_TM_Now] call CRQ_fnc_TimeDelta) < CRA_SCRIPT_TIMEOUT}) exitWith {false};
	terminate _tskAI;
	true
};
CRA_fnc_GP_TSK_AI_Spawn = {
	params [["_tskGroup", grpNull], ["_tskType", CRA_GP_TSK_UNKNOWN], ["_tskFunc", {}]];
	if (_tskGroup isEqualTo grpNull) exitWith {};
	_tskGroup setVariable [CRA_SVAR_GP_TASK, [_tskType, gCS_TM_Now, _tskGroup spawn _tskFunc]];
};
CRA_fnc_GP_TSK_WH_CRUISE_FIND = {
	private _path1 = [];
	private _path0 = _this getVariable [CRA_SVAR_GP_PATH, []];
	private _rd0Last0 = count _path0 - 1;
	private _rd0Last1 = _rd0Last0 - 1;
	if (!(_rd0Last1 < 0)) then {
		private _rdLast = _path0#_rd0Last0;
		{_path1 = [_rdLast, [_path0#_rd0Last1], _rdLast call CRQ_Pos2D, _x] call CRQ_RoadPath; if (_path1 isNotEqualTo []) exitWith {};} forEach CRA_CIVILIAN_EXTENSIONS;
		if (_path1 isEqualTo []) exitWith {};
		[_this, _path1 call CRQ_RoadWaypoints] call CRQ_WaypointVehicleTravel;
	};
	_this setVariable [CRA_SVAR_GP_PATH, _path1];
};
CRA_fnc_GP_TSK_FW_CRUISE_FIND = {
	private _path0 = _this getVariable [CRA_SVAR_GP_PATH, []];
	if (_path0 isEqualTo []) then { // TODO shouldn't happen, find out why?
		_path0 = [_this call CRQ_VecGroup3D];
		_this setVariable [CRA_SVAR_GP_PATH, _path0]
	};
	private _path1 = [_path0#-1, gRA_PG_Activation] call CRQ_FlightPath;
	_path0 append _path1;
	[_this, _path1] call CRQ_WaypointVehicleTravel;
};
CRA_fnc_GP_Ticket = {
	gRA_GP_Ticket = (gRA_GP_Ticket + 1) % CRA_GP_TICKET_MAX;
	(format [CRA_GP_TICKET_ID, gRA_GP_Ticket])
};
CRA_fnc_GP_Create = {
	private _group = _this call CRQ_GroupCreate;
	_group setVariable [CRA_SVAR_ID, call CRA_fnc_GP_Ticket];
	_group
};
CRA_fnc_GP_Register = { // TODO implement me
	gRA_GP_List set [_group getVariable CRA_SVAR_ID, if (_this isEqualType []) then {_this} else {[
		_this,
		_this call CRQ_Side,
		[]
	]}];
	_this
};
CRA_fnc_GP_Loop = {
	private _remove = [];
	{
		_y params ["_group", "_side", "_task"];
		if (_group isEqualType grpNull) then {
			private _fnc = _group getVariable [CRA_SVAR_FNC_MAIN, [{false},{}]];
			(_group call (_fnc#0)) params ["_active", ["_units", []], ["_corpses", []]];
			if (_active isEqualTo false) then {
				_remove pushBack _x;
				_group call (_fnc#1);
				if (_units isEqualTo []) then {_units = units _group;};
				{_x call CRQ_UnitDelete;} forEach _units;
				deleteGroup _group;
			};
		} else { // TODO hibernated
		};
	} forEach gRA_GP_List;
	{gRA_GP_List deleteAt _x;} forEach _remove;
};

CRA_CivilianAssetActive = {
	params ["_group", "_type"];
	private _active = true;
	private _disembark = false;
	private _activity = 0;
	
	private _units = (units _group) select {alive _x};
	//{if (alive _x) then {_units pushBack _x;};} forEach (units _group);
	private _vehicle = ((_group getVariable CRA_SVAR_ID) call CRQ_fnc_LNK_Get) call {if (_this isEqualType createHashMap) then {objNull} else {_this#0#0};};
	
	if (_vehicle isEqualType objNull) then {
		if (_vehicle isEqualTo objNull) exitWith {_active = false;};
		if (_units isEqualTo []) exitWith {_disembark = true;};
		_activity = _vehicle getVariable [CRA_SVAR_ACT_NOW, 0];
		(_group call CRQ_fnc_WP_Status) params ["_waypoints", "_wpNow", "_wpLast"];
		if (_type == CRA_ASSET_WHEELED || {_type == CRA_ASSET_TRACKED}) exitWith {
			if (_wpNow > _wpLast) exitWith {if (_activity < 1) then {_active = false;} else {_disembark = true;};};
			private _alighted = false;
			{if ((objectParent _x) isNotEqualTo _vehicle) exitWith {_alighted = true;};} forEach _units;
			if (_alighted) exitWith {_disembark = true;};
			private _hijacked = false;
			{if ((alive _x) && {_units find _x == -1}) exitWith {_hijacked = true;};} forEach (crew _vehicle);
			if (_hijacked) exitWith {_disembark = true;};
			if (_vehicle distance2D (waypointPosition (_waypoints#_wpLast)) >= CRA_CIVILIAN_EXTEND) exitWith {};
			private _path = _group getVariable [CRA_SVAR_GP_PATH, []];
			if (_path isEqualTo []) exitWith {_disembark = true;};
			_active = !(_group call CRA_fnc_GP_TSK_AI_Terminate); // returns true if forced terminated from timeout
			if ([[(_path#-1) call CRQ_Pos2D, 0], gRA_PG_Activation, 0, CRA_ACTIVITY_MIN, CRA_ACTIVITY_MAX] call CRA_fnc_PL_Activity > 0) exitWith {
				[_group, CRA_GP_TSK_WH_CRUISE_FIND, CRA_fnc_GP_TSK_WH_CRUISE_FIND] call CRA_fnc_GP_TSK_AI_Spawn;
			};
		};
		if (_type == CRA_ASSET_WINGED || {_type == CRA_ASSET_ROTOR}) exitWith {
			private _actBase = (_vehicle getVariable [CRA_SVAR_ACT_BASE, gRA_PG_Activation]) call {if (_this < 0) then {-_this * gRA_PG_Activation} else {_this}};
			
			(_group call CRQ_fnc_WP_Status) params ["_waypoints", "_wpNow", "_wpLast"];
			
			_active = !(_group call CRA_fnc_GP_TSK_AI_Terminate); // returns true if forced terminated from timeout
			if (_wpNow < _wpLast && {[[waypointPosition [_group, _wpLast], 0], _actBase, 0, CRA_ACTIVITY_MIN, CRA_ACTIVITY_MAX] call CRA_fnc_PL_Activity <= 0}) exitWith {};
			[_group, CRA_GP_TSK_FW_CRUISE_FIND, CRA_fnc_GP_TSK_FW_CRUISE_FIND] call CRA_fnc_GP_TSK_AI_Spawn;
		};
	} else {
		// TODO hibernated vehicle
	};
	
	if (_disembark) then {
		_group leaveVehicle _vehicle;
		//[_group, 0, grpNull] call CRQ_LinkFree;
		(_group getVariable CRA_SVAR_ID) call CRQ_fnc_LNK_Free; // TODO keep link alive for fleeing civs?
		_vehicle call CRA_fnc_AS_AbandonEnable;
		_vehicle call CRA_fnc_AS_HibernateEnable;
		_vehicle = objNull;
	};
	
	if (_active && {_activity > 0}) exitWith {[true, _units]};
	if (_vehicle isEqualType objNull && {_vehicle isNotEqualTo objNull}) then {_vehicle call CRQ_VehicleDelete;};
	[false, _units]
};
CRA_CivilianCarPath = {
	params ["_pos", "_radiusSearch", "_radiusEdge"];
	private _roads = [];
	{if (_x call CRQ_fnc_RD_IsRoad) then {_roads pushBack _x;};} forEach (_pos nearRoads _radiusSearch);
	private _path = [];
	{
		private _path0 = [_x, [], _pos, _radiusEdge] call CRQ_RoadPath;
		private _length = count _path0;
		private _path1 = if (_length > 0) then {[_x, if (_length > 1) then {[_path0#1]} else {[]}, _pos, _radiusEdge] call CRQ_RoadPath} else {[]};
		if (_path1 isNotEqualTo []) exitWith {
			reverse _path0;
			_path0 deleteAt (_length - 1);
			_path = _path0 + _path1;
		};
	} forEach (_roads call CRQ_fnc_ArrayRandomize);
	_path
};
CRA_CivilianAssetSpawn = {
	params ["_pos", "_type"];
	private _group = [] call {
		if (_type == CRA_ASSET_WHEELED) exitWith {[_pos, _type] call CRA_CivilianCarSpawn};
		if (_type == CRA_ASSET_WINGED || _type == CRA_ASSET_ROTOR) exitWith {[_pos, _type] call CRA_CivilianAirSpawn};
		grpNull;
	};
	if (_group isEqualTo grpNull) exitWith {};
	[gRA_CivilianAssetCount, _type] call CRQ_fnc_ArrayIncrement;
	_group call CRA_fnc_GP_Register;
};
CRA_CivilianAssetDespawn = {
	[gRA_CivilianAssetCount, _this, -1] call CRQ_fnc_ArrayIncrement;
};
CRA_CivilianCarSpawn = {
	params ["_pos"];
	private _path = [_pos, gRA_PG_Activation * CRA_PATHGENERATOR_RADIUS, gRA_PG_Activation] call CRA_CivilianCarPath;
	if (count _path < 1 || {((getRoadInfo (_path#0))#8) || {((getRoadInfo (_path#-1))#8)}}) exitWith {grpNull};
	([[(_path#0) call CRQ_Pos2D, (_path#0) getDir (_path#1)], [[CRQ_SD_CIV,CRA_ASSET_WHEELED,CRA_VEHICLE_UNARMED]], _path call CRQ_RoadWaypoints] call CRA_CivilianAssetCreate) params [["_group", grpNull], ["_asset", objNull]];
	if (_group isEqualTo grpNull) exitWith {grpNull};
	_group setVariable [CRA_SVAR_GP_PATH, _path];
	_group setVariable [CRA_SVAR_FNC_MAIN, [{[_this, CRA_ASSET_WHEELED] call CRA_CivilianAssetActive}, {CRA_ASSET_WHEELED call CRA_CivilianAssetDespawn}]];
	_group
};
CRA_CivilianAirSpawn = {
	params ["_pos", "_type"];
	private _flAlt = CRQ_PT_FL_ALTITUDE + random (if (_type == CRA_ASSET_ROTOR) then {CRA_CIVILIAN_ALTITUDE_ROTOR} else {CRA_CIVILIAN_ALTITUDE_WING});
	private _flStart = [_pos, gRA_PG_Activation * 2, _flAlt] call CRQ_FlightStart;
	private _flPath = [_flStart, gRA_PG_Activation] call CRQ_FlightPath;
	([_flStart, [[CRQ_SD_CIV,_type,CRA_VEHICLE_UNARMED]], _flPath] call CRA_CivilianAssetCreate) params [["_group", grpNull], ["_asset", objNull]];
	if (_group isEqualTo grpNull) exitWith {grpNull};
	_asset flyInHeight _flAlt;
	_asset setVariable [CRA_SVAR_ACT_NOW, 0.5];
	_asset setVariable [CRA_SVAR_ACT_BASE, -2];
	_group setVariable [CRA_SVAR_GP_PATH, _flPath];
	if (_type == CRA_ASSET_ROTOR) then { // I suppose I need "compile" if I want to refactor this seemingly unnecessary construct
		_group setVariable [CRA_SVAR_FNC_MAIN, [{[_this, CRA_ASSET_ROTOR] call CRA_CivilianAssetActive}, {CRA_ASSET_ROTOR call CRA_CivilianAssetDespawn}]];
	} else {
		_group setVariable [CRA_SVAR_FNC_MAIN, [{[_this, CRA_ASSET_WINGED] call CRA_CivilianAssetActive}, {CRA_ASSET_WINGED call CRA_CivilianAssetDespawn}]];
	};
	_group
};
CRA_CivilianAssetCreate = {
	params ["_vec", "_type", "_waypoints", ["_crew", [-1, -1, -1, random -1]]];
	private _asIndex = [_type] call CRA_fnc_AS_Random;
	if (_asIndex == -1 || {([_vec#0, CRA_CIVILIAN_SPAWN_CLEARANCE, false] call CRQ_VehiclesFind) isNotEqualTo []}) exitWith {[]};
	private _group = CRQ_SD_CIV call CRA_fnc_GP_Create;
	private _asset = [_asIndex, _vec, [_group, _crew]] call CRA_fnc_AS_Create;
	[_group, CRQ_AI_F_RAND, CRQ_AI_M_SAFE, CRQ_AI_S_LIMITED] call CRQ_fnc_AI_STS;
	[_group, _waypoints] call CRQ_WaypointVehicleTravel;
	
	//[[_group, 0, [false, -1, -1]], [_asset, 0]] call CRQ_LinkCreate;
	[_group getVariable CRA_SVAR_ID, [[_asset, 0], [_group]], [[false, -1, -1]]] call CRQ_fnc_LNK_Create;
	
	[_asset, true, false, false, _vec] call CRA_fnc_AS_Register;
	// TODO why on asset, not group? attempting to disable D295...
	//_asset disableAi "AUTOTARGET";
	//_asset disableAi "TARGET";
	// TODO these were previously commented out
	//_asset setCaptive true;
	//_group allowFleeing 0;
	[_group, _asset]
};
CRA_CivilianLoop = {
	[] call CRA_fnc_GP_Loop;
	if (!(gRA_PL_SYS_Count > 0)) exitWith {};
	
	{
		private _type = _x;
		if (([gRA_CivilianAssetTime#_type, gCS_TM_Now] call CRQ_fnc_TimeDelta) >= CRA_CIVILIAN_SPAWN_TIMER) then {
			if ((gRA_CivilianAssetCount#_type) < (gRA_CivilianAssetLimit#_type) && {random 1 < (gRA_CivilianAssetProb#_type)}) then {
				if ((gRA_CivilianAssetSpawn#_type) isNotEqualTo scriptNull) exitWith {}; // TODO error-handling
				gRA_CivilianAssetSpawn set [_type, [selectRandom gRA_PL_SYS_Pos, _type] spawn CRA_CivilianAssetSpawn];
			};
			gRA_CivilianAssetTime set [_type, gCS_TM_Now];
		};
	} forEach [CRA_ASSET_WHEELED,CRA_ASSET_WINGED,CRA_ASSET_ROTOR];
	
};
CRA_CivilianInit = {
	private _params = [
		[gRA_PM_CivilianCarCount,gRA_PM_CivilianCarProb],
		[0,0],
		[gRA_PM_CivilianPlaneCount,gRA_PM_CivilianPlaneProb],
		[0,0],
		[gRA_PM_CivilianHeliCount,gRA_PM_CivilianHeliProb],
		[0,0]
	];
	private _timer = -CRA_CIVILIAN_SPAWN_TIMER / (count _params);
	private _prob = CRA_CIVILIAN_SPAWN_TIMER / 60;
	{
		gRA_CivilianAssetLimit set [_forEachIndex, _x#0];
		gRA_CivilianAssetProb set [_forEachIndex, 1 - ((1 - (_x#1)) ^ _prob)];
		gRA_CivilianAssetTime set [_forEachIndex, (gCS_TM_Now + (_forEachIndex * _timer)) call CRQ_fnc_TimeCoerce];
	} forEach _params;
};

CRA_fnc_SD_RelationPlayer = {
	([CRA_PLAYER_SIDE, _this] call CRQ_SideRelation)
};
CRA_fnc_SD_InitZero = {
	private _relation = (CRQ_SD_LEVEL_NEUTRAL + CRQ_SD_LEVEL_FRIEND) / 2;
	[CRQ_SD_BLU, CRQ_SD_CIV, _relation] call CRQ_SideBilateral;
	[CRQ_SD_IND,  CRQ_SD_CIV, _relation] call CRQ_SideBilateral;
	[CRQ_SD_OPF,  CRQ_SD_CIV, _relation] call CRQ_SideBilateral;
};
CRA_fnc_SD_Loop = {
	(call CRQ_fnc_SD_Matrix) call {
		{
			private _row = [];
			private _self = _forEachIndex;
			{
				private _sfF = (0.5 + (_this#2#_self#_forEachIndex));
				private _sfE = (0.5 + (_this#3#_self#_forEachIndex));
				private _owF = (0.5 + (_this#2#_forEachIndex#_self));
				private _owE = (0.5 + (_this#3#_forEachIndex#_self));
				_row pushBack (_sfF * _owF * _sfE * _owE);
			} forEach CRQ_SD_TYPES;
			gRA_SD_Matrix set [_self, _row];
		} forEach CRQ_SD_TYPES;
	};
};
CRA_fnc_EN_LightSwitch = {
	{if (_x getVariable [CRA_SVAR_LC_STATE, -1] == CRA_STATE_ACTIVE) then {[_x, _this] call CRA_LocationBaseLights;};} forEach gRA_LC_List;
};
CRA_fnc_MN_InitLoad = {
	// private _tickInitPost = diag_tickTime;
	if (gRA_PM_MN_Load) then {CRQ_BS_TM_SYNC spawn {while {pRA_Initializing} do {publicVariable "pRA_LoadMessage"; publicVariable "pRA_LoadIndex"; publicVariable "pRA_LoadTotal"; sleep _this;};};};
	
	CRA_LOAD_NEXT(0, 100);
	([CRQ_TERRAIN_TRAVERSE, CRQ_TERRAIN_RESOLUTION, {CRA_LOAD_INDEX(_this * 100)}] call CRQ_fnc_MAP_TerrainPoints) params ["_grid", "_mass"];
	
	CRA_LOAD_NEXT(0, count _grid);
	private _replace = createHashMap;
	{_replace set [_x, _forEachIndex]; gRA_MAP_Mass pushBack (_y apply {CRA_LOAD_INCREMENT(); mapGridPosition ((parseSimpleArray _x) vectorAdd [50, 50])});} forEach _mass;
	{gRA_MAP_Grid set [mapGridPosition ((parseSimpleArray _x) vectorAdd [50, 50]), _replace get _y];} forEach _grid;
	
	// {
		// private _marker = createMarker ["CRA_ISLAND" + str _forEachIndex, _x#0];
        // _marker setMarkerType "mil_dot";
		// _marker setMarkerText str (_x#1);
	// } forEach ((gRA_MAP_Mass) apply {[(_x apply {(_x call CRQ_fnc_MAP_GridToPos) vectorAdd [50, 50]}) call CRQ_PosAvg, count _x]});
	
	private _house = ["HOUSE"] call CRQ_WorldTerrainObjects;
	CRA_LOAD_NEXT(0, count _house);
	gRA_MAP_House = (gRA_MAP_Mass apply {[]}) + [[]];
	{(gRA_MAP_House#(gRA_MAP_Grid getOrDefault [([_x call CRQ_Pos2D] call CRQ_fnc_MAP_PosToGrid), -1])) pushBack _x; CRA_LOAD_INCREMENT();} forEach _house;
	
	[] call CRA_fnc_AS_InitMain;
	// private _tickInitDepot = diag_tickTime;
	// gRA_TickInitDepot = diag_tickTime - _tickInitDepot;
	// private _tickInitLocation = diag_tickTime;
	[] call CRA_fnc_LC_InitMain;
	// gRA_TickInitLocation = diag_tickTime - _tickInitLocation;
	[] call CRA_fnc_PG_InitMain;
	missionNamespace setVariable ["pRA_Initializing", false, true];
	// gRA_TickInitPost = diag_tickTime - _tickInitPost;
	[] call CRA_fnc_PL_InitMain;
};
CRA_fnc_MN_InitMain = {
	if (!gRA_PM_MN_Load) exitWith {};
	[] spawn CRA_fnc_MN_InitLoad;
};
CRA_fnc_MN_InitZero = {
	// private _tickInitPre = diag_tickTime;
	[true] call CRQ_CatalogInit;
	[] call CRA_fnc_PL_InitZero;
	[] call CRA_fnc_SD_InitZero;
	[] call CRA_fnc_IT_InitZero;
	[] call CRA_fnc_AS_InitZero;
	[] call CRA_fnc_PG_InitZero;
	[] call CRA_CivilianInit;
	// gRA_TickInitPre = diag_tickTime - _tickInitPre;
	if (gRA_PM_MN_Load) exitWith {};
	[] call CRA_fnc_MN_InitLoad;
};
CRA_fnc_MN_Loop = {
	if (pRA_Initializing) exitWith {};
	private _tickLoop = diag_tickTime;
	[] call CRA_fnc_SD_Loop;
	[] call CRA_fnc_PL_Loop;
	[] call CRA_fnc_AS_Loop;
	[] call CRA_CivilianLoop;
	[] call CRA_fnc_LC_Loop;
	gRA_TickLoop = diag_tickTime - _tickLoop;
};
