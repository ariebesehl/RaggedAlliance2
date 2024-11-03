
CRA_Temp = {
	private _location = if (_this isEqualType -1) then {gRA_LC_List#(gRA_LC_IndexBase + _this)} else {_this};
	private _units = _location getVariable [CRA_SVAR_LOCATION_UNIT_PERSONNEL, []];
	{_x setDamage 1;} forEach _units;
	{[_x, _location] call CRA_PlayerTeleport;} forEach gRA_PL_Units;
};
CRA_Temp2 = {
	(gRA_LC_List apply {[_x getVariable ["CRA_SVAR_LOCATION_INDEX",-1], text _x]})
};
CRA_ActionRelayReceive = {
	params ["_object", "_invoker", "_id", "_args"];
	//_args params ["_type", "_typeArgs"];
	switch (_args#0) do {
		case CRA_ACTION_ID_PLAYER_TELEPORT: {remoteExec ["CRA_LocalPlayerRequestTeleport", owner _invoker];};
		case CRA_ACTION_ID_PLAYER_PARADROP: {remoteExec ["CRA_LocalPlayerRequestParadrop", owner _invoker];};
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
CRA_fnc_PG_InitPre = {
	
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
		{[gRA_PM_PG_EnemyCountPlayerInit, gRA_PG_SpanEnemyCountPlayer, gRA_PM_PG_EnemyCountPlayerFactor, (((gRA_PL_Count) - 1) max 0) * gRA_PG_CoeffEnemyCountPlayer] call CRA_fnc_PG_GrowthLinear},
		{[gRA_PM_PG_EnemyCountPlayerInit, gRA_PG_SpanEnemyCountPlayer, gRA_PM_PG_EnemyCountPlayerFactor, (((gRA_PL_Count) - 1) max 0) * gRA_PG_CoeffEnemyCountPlayer] call CRA_fnc_PG_GrowthParabolic},
		{[gRA_PM_PG_EnemyCountPlayerFinal, -gRA_PG_SpanEnemyCountPlayer, gRA_PM_PG_EnemyCountPlayerFactor, 1 - (((gRA_PL_Count) - 1) max 0) * gRA_PG_CoeffEnemyCountPlayer] call CRA_fnc_PG_GrowthLinear},
		{[gRA_PM_PG_EnemyCountPlayerFinal, -gRA_PG_SpanEnemyCountPlayer, gRA_PM_PG_EnemyCountPlayerFactor, 1 - (((gRA_PL_Count) - 1) max 0) * gRA_PG_CoeffEnemyCountPlayer] call CRA_fnc_PG_GrowthParabolic}
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
CRA_fnc_PG_InitPost = {
	gRA_PG_Value = 0;
	{gRA_PG_Value = gRA_PG_Value + (_x getVariable [CRA_SVAR_LOCATION_VALUE, 0]);} forEach gRA_LC_List;
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
CRA_PlayerInit = {
	private _last = (playableSlotsNumber (CRA_PLAYER_SIDE call CRQ_Side)) - 1;
	for "_i" from 0 to _last do {
		private _var = CRA_PLAYER_VAR + str _i;
		gRA_PL_Reg pushBack false;
		gRA_PL_Init pushBack false;
		gRA_PL_Dist pushBack false;
		gRA_PL_PrePos pushBack [];
		gRA_PL_Index set [_var, _i];
		gRA_PL_Var pushBack _var;
		gRA_PL_Inventory pushBack [];
		gRA_PL_Mail pushBack [];
		gRA_PL_Asset pushBack objNull;
	};
};
CRA_PlayerGetIndex = {
	(gRA_PL_Index getOrDefault [vehicleVarName _this, -1])
};
CRA_PlayerGetUnit = {
	missionNamespace getVariable [gRA_PL_Var#_this, objNull]
};
CRA_PlayerGetOwner = {
	(owner (_this call CRA_PlayerGetUnit))
};
CRA_fnc_PL_MailRead = {
	params ["_unit", "_mailIndex"];
	private _playerIndex = _unit call CRA_PlayerGetIndex;
	if (_playerIndex == -1) exitWith {};
	(gRA_PL_Mail#_playerIndex#_mailIndex) set [0, true];
};
CRA_PlayerMailSend = {
	params ["_recipient", "_mail"];
	//_mail params ["_read", "_attachment", "_date", "_sender", "_subject", "_text"];
	if (_recipient isEqualTo []) then {_recipient = gRA_PL_Index apply {_y};};
	{
		private _mailbox = (gRA_PL_Mail#_x);
		private _index = count _mailbox;
		_mailbox pushBack (+_mail);
		private _owner = _x call CRA_PlayerGetOwner;
		if (_owner != 0) then {[CRA_PVAR_PLAYER_MAILBOX, _index, _mail, _owner] call CRQ_SyncArrayIndex;};
	} forEach _recipient;
};
CRA_fnc_PL_Loop = {
	gRA_PL_Units = (allPlayers select {gRA_PL_Init#(_x call CRA_PlayerGetIndex)});
	gRA_PL_Count = count gRA_PL_Units;
	gRA_PL_Pos = (gRA_PL_Units apply {_x call CRQ_Pos2D});//TODO all necessary for  + (gRA_PL_PrePos select {_x isNotEqualTo []});
	{
		private _asset = objectParent _x;
		if (_asset isNotEqualTo objNull) then {
			private _index = _x call CRA_PlayerGetIndex;
			if (_index < 0) exitWith {};
			gRA_PL_Asset set [_index, _asset];
		};
	} forEach gRA_PL_Units;
};
CRA_PlayerGreet = {
	[[], [false, [], date, [CRA_TEXT_GENERIC_DICT,[CRA_DICT_PROTAGONIST_MAIL]], [CRA_TEXT_MAIL_SUBJECT_GREET,[-1]], [CRA_TEXT_MAIL_TEXT_GREET,[-1,CRA_DICT_ANTAGONIST_SHORT,-1,CRA_DICT_PROTAGONIST_FULL]]]] call CRA_PlayerMailSend;
};
CRA_PlayerHide = {
	gRA_PL_Dist set [_this call CRA_PlayerGetIndex, false];
	_this hideObjectGlobal true;
};
CRA_PlayerShow = {
	private _index = _this call CRA_PlayerGetIndex;
	gRA_PL_Init set [_index, true];
	gRA_PL_Dist set [_index, true];
	_this hideObjectGlobal false;
};
CRA_PlayerRegister = { // Sometimes spawn before connect, sometimes other way around
	
};
CRA_PlayerConnect = {
//systemChat "CRA_PlayerConnect";
	params ["_unit", "_id", "_uid", "_name", "_jip"];
	private _index = _unit call CRA_PlayerGetIndex;
	if (_index == -1) exitWith {};
	gRA_PL_Init set [_index, false];
	gRA_PL_Dist set [_index, false];
	[CRA_PVAR_PLAYER_MAILBOX, gRA_PL_Mail#_index, owner _unit] call CRQ_SyncArrayFull;
};
CRA_PlayerDisconnect = {
	params ["_unit", "_id", "_uid", "_name"];
	private _loadout = getUnitLoadout _unit;
	private _index = _unit call CRA_PlayerGetIndex;
	_unit call CRQ_UnitDelete;
	if (_index == -1) exitWith {};
	gRA_PL_Init set [_index, false];
	gRA_PL_Dist set [_index, false];
	gRA_PL_Inventory set [_index, _loadout];
};
CRA_PlayerSpawn = {
//systemChat "CRA_PlayerSpawn";
	params ["_unit", "_respawn"];
	_unit call CRA_PlayerHide;
	_unit call CRA_PlayerLoadout;
	_unit call CRA_fnc_PL_RQI_Spawn;
	// remoteExec ["CRA_LocalPlayerRequestSpawn", owner _unit];
};
CRA_fnc_PL_RQI_Spawn = {
	remoteExec ["CRA_LocalPlayerRequestSpawn", owner _this];
};
CRA_fnc_PL_RQR_Spawn = {
	params ["_unit", "_index", ["_vec", []]];
	private _valid = true; // TODO
	if (_index < 0) then {
		[_unit, _vec] call CRA_PlayerParadrop;
	} else {
		[_unit, (gRA_LC_List#_index)] call CRA_PlayerTeleport;
	};
	if (_valid) exitWith {
		_unit call CRA_PlayerShow;
		_unit call CRQ_fnc_CL_Restore;
	};
	_unit call CRA_fnc_PL_RQI_Spawn;
};
CRA_fnc_PL_RQR_Teleport = {
	params ["_unit", "_index"];
	if (_index == -1) exitWith {};
	if (gRA_LC_Safe getOrDefault [_index, false]) exitWith {[_unit, gRA_LC_List#_index] call CRA_PlayerTeleport;};
	[CRA_TEXT_EVENT_LOCATION_INSECURE, [_index], owner _unit] call CRA_PlayerInfoMessage;
};
CRA_fnc_PL_RQR_Paradrop = {
	params ["_unit", "_vec"];
	private _valid = true; // TODO
	if (_valid) exitWith {[_unit, _vec] call CRA_PlayerParadrop;};
};
CRA_PlayerTeleport = {
	params ["_unit", "_location"];
	private _vec = _location getVariable [CRA_SVAR_LOCATION_BASE_PLAYER, []];
	if (_vec isEqualTo []) then {_vec = [locationPosition _location, random 360];};
	[_unit, _vec] remoteExec ["CRA_Teleport", owner _unit]; // setting Dir only works locally
};
CRA_PlayerParadrop = {
	params ["_unit", "_vec"];
	_this remoteExec ["CRA_Paradrop", owner _unit];
	//[_vector#0, [0,0,0], CRA_PARADROP_HEIGHT + 20, "FULL", "B_CTRG_Heli_Transport_01_tropic_F", west] call BIS_fnc_ambientFlyBy;
};
/*
CRA_PlayerInRange = {
	params ["_pos", "_range"];
	private _trigger = false;
	{if (_pos distance2D _x <= _range) exitWith {_trigger = true;};} forEach gRA_PL_Pos;
	_trigger
};
*/
CRA_PlayerActivity = {
	params ["_vec", "_range", ["_prev", 0], ["_min", -1e10], ["_max", 1e10]];
	private _pos = _vec#0;
	private _dist = 1e10;
	{_dist = _dist min (_pos distance2D _x);} forEach gRA_PL_Pos;
	private _activity = (CRA_ACTIVITY_COEF * _range / (1 max _dist)) max _prev;
	private _decay = CRA_ACTIVITY_COEF * _dist / (_range + CRA_ACTIVITY_HYSTERESIS);
	(((_activity - _decay) max _min) min _max)
};
CRA_PlayerLoadout = {
	private _index = _this call CRA_PlayerGetIndex;
	private _identity = if (gRA_PM_PL_Identity && {_index != -1}) then {dCRA_PLAYER_IDENTITY#_index} else {[]};
	private _loadout = [];
	if (_index != -1) then {
		_loadout = +(gRA_PL_Inventory#_index);
		if (_loadout isNotEqualTo []) then {
			gRA_PL_Inventory set [_index, []];
		} else {
			_loadout = (_index call CRA_UnitGenerate)#1;
		};
	} else {
		_loadout = (CRA_UNIT_PLAYER_DEFAULT call CRA_UnitGenerate)#1;
	};
	[_this, _identity, _loadout] remoteExec ["CRQ_fnc_PLL_IdentityLoadout", owner _this];
};
CRA_PlayerInfoMessage = {
	params ["_message", "_arg", ["_target", gCS_MP_Broadcast]];
	[_message, _arg] remoteExec ["CRA_LocalPlayerInfoMessage", _target];
};
CRA_PlayerInfoNotify = {
	params ["_message", "_arg", ["_target", gCS_MP_Broadcast]];
	[_message, _arg] remoteExec ["CRA_LocalPlayerInfoNotify", _target];
};
CRA_PlayerActionBase = {
	private _location = gRA_LC_List#(_this#1);
	if (true) then { // TODO
		switch (_this#0) do {
			case CRA_ACTION_ID_INVENTORY_SORT: {
				_location call CRA_LocationInventorySort;
				[CRA_TEXT_INFO_BASE_INVENTORY_SORT,[_this#1]] call CRA_PlayerInfoMessage;
			};
			case CRA_ACTION_ID_INVENTORY_GATHER: {
				([_location, _this#2] call CRA_LocationInventoryGather) params ["_countItems", "_countMags", "_countWeapons", "_countContainers"];
				[CRA_TEXT_INFO_BASE_INVENTORY_GATHER,[_this#1, _this#2]] call CRA_PlayerInfoMessage;
				[CRA_TEXT_INFO_BASE_INVENTORY_GATHER_RESULT,[_this#1, _countWeapons, _countMags, _countContainers, _countItems]] call CRA_PlayerInfoMessage;
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
					[CRA_TEXT_INFO_INTEL_GATHER,[_this#1, _range, _info]] call CRA_PlayerInfoMessage;
				} else {
					[CRA_TEXT_INFO_INTEL_NONE,[_this#1, _range]] call CRA_PlayerInfoMessage;
				};
			};
			default {};
		};
	} else {
		[CRA_TEXT_EVENT_LOCATION_INSECURE,[_this#1]] call CRA_PlayerInfoMessage;
	};
};
CRA_PlayerLocationSafe = {
	private _safe = createHashMap;
	private _locations = [];
	{
		if ((_x call CRA_fnc_LC_Owner) == CRA_PLAYER_SIDE) then {
			private _index = _x getVariable [CRA_SVAR_LOCATION_INDEX, -1];
			if (_index == -1) exitWith {};
			_safe set [_index, true];
			_locations pushBackUnique _index;
		};
	} forEach gRA_LC_History;
	gRA_LC_Safe = _safe;
	missionNamespace setVariable ["pRA_LocationSafe", _locations, true];
};
CRA_PlayerLocationEnter = {
	private _index = _this getVariable [CRA_SVAR_LOCATION_INDEX, -1];
	if (_index == -1) exitWith {};
	private _type = _this getVariable [CRA_SVAR_LOCATION_TYPE, CRA_LC_TYPE_OUTPOST];
	if ([CRA_LC_TYPE_OUTPOST, CRA_LC_TYPE_ROADBLOCK] find _type == -1) then {
		[CRA_TEXT_EVENT_LOCATION_ANNOUNCE_FULL, [_index, _this call CRA_fnc_LC_Owner]] call CRA_PlayerInfoMessage;
	} else {
		[CRA_TEXT_EVENT_LOCATION_ANNOUNCE_SHORT, [_index]] call CRA_PlayerInfoMessage;
	};
};
CRA_PlayerLocationCapture = {
	private _index = _this getVariable [CRA_SVAR_LOCATION_INDEX, -1];
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
	_message call CRA_PlayerInfoMessage;
	private _player = false;
	if (_ownerPrev isEqualTo CRA_PLAYER_SIDE) then {_this call CRA_PlayerLocationLost; _player = true;};
	if (_owner isEqualTo CRA_PLAYER_SIDE) then {_this call CRA_PlayerLocationWin; _player = true;};
	if (_player) then {[] call CRA_PlayerLocationSafe;};
};
CRA_PlayerLocationWin = {
	remoteExec ["CRA_LocalPlayerLocationWin", gCS_MP_Broadcast];
	if (_this getVariable [CRA_SVAR_LOCATION_UNCAPTURED, false]) then {
		(_this getVariable [CRA_SVAR_LOCATION_VALUE, 0]) call CRA_fnc_PG_Award;
		_this setVariable [CRA_SVAR_LOCATION_UNCAPTURED, false];
		gRA_LC_History pushBack _this;
	};
	private _index = _this getVariable [CRA_SVAR_LOCATION_INDEX, -1];
	if (_index == -1) exitWith {};
	[CRA_TEXT_NOTIFY_LOCATION_GAIN, [_index]] call CRA_PlayerInfoNotify;
};
CRA_PlayerLocationLost = {
	remoteExec ["CRA_LocalPlayerLocationLost", gCS_MP_Broadcast];
	private _index = _this getVariable [CRA_SVAR_LOCATION_INDEX, -1];
	if (_index == -1) exitWith {};
	[CRA_TEXT_NOTIFY_LOCATION_LOST, [_index]] call CRA_PlayerInfoNotify;
};
CRA_LocationLoop = {
	{
		_x call {
			private _vec = _this getVariable [CRA_SVAR_VEC, []];
			if (_vec isEqualTo []) exitWith {};
			
			private _act = [_vec, gRA_PG_Activation, _this getVariable [CRA_SVAR_ACTIVITY, 0], CRA_ACTIVITY_MIN, CRA_ACTIVITY_MAX] call CRA_PlayerActivity;
			_this setVariable [CRA_SVAR_ACTIVITY, _act];
			
			private _fncMain = _this getVariable [CRA_SVAR_FNC_MAIN, CRA_LC_FNC_MAIN_NONE];
			private _state = _this getVariable [CRA_SVAR_LOCATION_STATE, -1];
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
	private _activity = _this getVariable [CRA_SVAR_ACTIVITY, 0];
	if (_activity <= 0) exitWith {};
	(_this getVariable [CRA_SVAR_TRIGGER, CRA_LC_FNC_TRIG_NONE]) params ["_trigger", "_cache"];
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
	_this call CRA_LocationBaseRadioNext;
	[_this, call CRQ_Lights] call CRA_LocationBaseLights;
	
	private _init = (_this getVariable [CRA_SVAR_LOCATION_STATE, -1]) == CRA_STATE_INIT;
	
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
	_this call CRA_LocationBaseRadioLoop;
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
	if (_this getVariable [CRA_SVAR_LOCATION_STATE, -1] != CRA_STATE_INIT) exitWith {};
	for "_i" from 0 to ((count (_this getVariable [CRA_SVAR_LOCATION_ASSET_SPAWN, []])) - 1) do {[_this, _i] call CRA_DepotSpawn;};
};
// CRA_LocationDepotActive = {
	// {
		// (_x#1) params [["_removed", false], ["_timeDeath", -1], ["_timeAbandon", -1]];
		// if (_removed) then {
			// private _inhibit = gRA_PM_AS_RespawnAbandon == -1 || {_timeAbandon == -1 || {([_timeAbandon, gCS_TM_Now] call CRQ_fnc_TimeDelta) < gRA_PM_AS_RespawnAbandon}};
			// _inhibit = _inhibit && {gRA_PM_AS_RespawnWreck == -1 || {_timeDeath == -1 || {([_timeDeath, gCS_TM_Now] call CRQ_fnc_TimeDelta) < gRA_PM_AS_RespawnWreck}}};
			// if (_inhibit) exitWith {};
			// [_this, _forEachIndex] call CRA_DepotSpawn;
		// };
	// } forEach ([_this] call CRQ_LinkDataRead);
// };
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
	_location setVariable [CRA_SVAR_LOCATION_STATE, _state];
	if (_location getVariable [CRA_SVAR_LOCATION_DISCOVER, false]) then {_location call CRA_LocationMarkerState;};
};
CRA_fnc_LC_Owner = {
	if (_this isEqualType locationNull) exitWith {((_this getVariable ["CRAS_LC_OWN", [[CRQ_SD_UNKNOWN]]])#0) select -1};
	params ["_location", ["_history", 0]];
	(_location getVariable ["CRAS_LC_OWN", [[CRQ_SD_UNKNOWN]]]) params [["_owLog", []], ["_owFav", []]];//, ["_owRoll", [0,0,0,1]]];
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
CRA_LocationOwnerInit = {
	params ["_location", ["_side", CRQ_SD_UNKNOWN]];
	_location setVariable ["CRAS_LC_OWN", [[_side], [_side, CRA_GV_OW_MAX], (dCRA_SD_INDEX) apply {if (_x isEqualTo _side) then {CRA_GV_OW_MAX} else {CRA_GV_OW_MIN}}]];
};
CRA_LocationCaptureLoop = {
	
	private _allowed = _this getVariable [CRA_SVAR_LOCATION_CAPTUREABLE, [CRQ_SD_CIV]];
	
	(_this getVariable ["CRAS_LC_OWN", []]) params [["_ownerLog", [CRQ_SD_CIV]], ["_ownerFavor", [CRQ_SD_UNKNOWN, 0]], ["_owspRolling", [0,0,0,1]]];
	private _ownerPresent = _ownerLog select -1;//(_this call CRA_fnc_LC_Owner) call {if (_this isEqualTo -1) then {CRQ_SD_CIV} else {_this};};
	if (_ownerPresent == CRQ_SD_CIV && {_allowed isEqualTo CRA_LC_CAPT_NONE}) exitWith {};
	
	
	private _pos = (_this getVariable [CRA_SVAR_VEC, [[]]])#0;
	if (_pos isEqualTo []) then {_pos = locationPosition _this;};
	private _radius = ((size _this)#0) + CRA_BASE_ORBIT;
	
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
	_this setVariable ["CRAS_LC_OWN", [_ownerLog, _ownerFavor, _owspRolling]];
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
CRA_LocationRoadblockInit = {
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
		params ["_roads", ["_proximity", []], ["_tryMax", CRA_LCRB_SCAN_ATTEMPTS], ["_try_fnc_Init", {}]];
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
					private _res = [_scanRoads, _scanProx, CRA_LCRB_SCAN_ATTEMPTS] call _fnc_analysis;
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
			private _poolMax = ceil ((sqrt CRA_LCRB_SCAN_ATTEMPTS) * gRA_PM_LC_RB_Density * gRA_PM_LC_RB_Density);
			private _poolRem = _poolMax;
			private _poolLoad = 0.5 * _scanDensity * _scanDensity / _poolMax;
			while {_poolRem > 0} do {
				private _res = [_scanRoads, _scanProx, _poolRem, {_poolRem = _poolRem - 1;}] call _fnc_analysis;
				if (_res isNotEqualTo []) then {
					_scanResults pushBack _res;
					(_scanProx#2#1) pushBack (_res#0);
				};
				CRA_LOAD_INDEX(0.5 + _poolLoad * (_poolMax - _poolRem));
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
		gRA_LC_List pushBack ([[_index, _vec, _name, "", objNull], CRA_LC_TYPE_ROADBLOCK, selectRandom _bases] call CRA_LocationGenerate);
	} forEach _scanResults;
};
CRA_LocationOutpostInit = {
	private _bases = [];
	{_bases append _x;} forEach (dCRA_LC_TYPES#CRA_LC_TYPE_OUTPOST#3#1);
	
	private _outpostTypes = createHashMap;
	{private _bsIndex = _x; {_outpostTypes set [toLowerANSI _x, _bsIndex];} forEach (dCRA_BASE_INDEX#_bsIndex#0#0);} forEach _bases;
	private _count = 0;
	{_count = _count + count _x;} forEach gRA_MAP_House;
	CRA_LOAD_NEXT(0, _count);
	private _proximity = [
		[CRA_LC_PROX_DEPOT, (gRA_LC_List select [gRA_LC_IndexDepot, gRA_LC_IndexBase - gRA_LC_IndexDepot]) apply {locationPosition _x}],
		[CRA_LC_PROX_LOCATION, gRA_LC_List select [gRA_LC_IndexBase, gRA_LC_IndexRoadblock - gRA_LC_IndexBase] apply {locationPosition _x}],
		[CRA_LC_PROX_ROADBLOCK, gRA_LC_List select [gRA_LC_IndexRoadblock] apply {locationPosition _x}]
	];
	private _candidates = [];
	{
		{
			CRA_LOAD_INDEX(_forEachIndex);
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
	_candidates = _candidates call CRQ_ArrayRandomize;
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
			_outposts pushBack ([[gRA_LC_IndexOutpost + _index, _vec, str _index, "", _obj], CRA_LC_TYPE_OUTPOST, _bsIndex] call CRA_LocationGenerate);
			_index = _index + 1;
		};
	} forEach _candidates;
	gRA_LC_List append _outposts;
};
CRA_LocationInit = {
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
		{_lcBaseSource append (_x call CRQ_ArrayRandomize);} forEach (dCRA_LC_TYPES#_lcType#3#1); // TODO location override optional bases
		{
			private _bsIndex = _x;
			[_scVec, _lcRadius] call CRQ_VecUtilSetup;
			private _vec = (gRA_BS_Types#_bsIndex) call CRQ_VecUtil;
			private _pos = _vec#0;
			private _include = [] call CRQ_VecUtilValid;
			{if (!_include) exitWith {}; private _dist = _x#0; {if (_x distance2D _pos < _dist) exitWith {_include = false};} forEach (_x#1);} forEach _proximity;
			if (_include) exitWith {
				gRA_LC_List pushBack ([[_scIndex, _vec, _lcName, _lcLabel, [] call CRQ_VecUtilObject], _lcType, _bsIndex] call CRA_LocationGenerate);
				(_proximity#1#1) pushBack _pos;
			};
		} forEach _lcBaseSource;
	} forEach _worldLocations;
	[] call CRA_LocationRoadblockInit;
	[] call CRA_LocationOutpostInit;
	[] call CRA_LocationSync;
};
CRA_LocationSync = {
	CRA_LOAD_NEXT(0, 0);
	private _sync = gRA_LC_List apply {private _vec = _x getVariable [CRA_SVAR_VEC, [[0,0,0],0]]; [text _x, [_vec#0#0, _vec#0#1]]};
	missionNamespace setVariable ["pRA_Locations", _sync, true];
};
CRA_LocationGenerate = {
	params ["_data", "_type", "_base", ["_owner", -1], ["_vars", []]];
	_data params ["_index", "_vec", "_name", "_label", ["_anchor", objNull]];
	
	if (typeOf (_anchor) == "Land_MultistoryBuilding_01_F") then {gRA_Temp2 pushBack (_index - gRA_LC_IndexBase);};
	
	(if (_type isEqualType -1) then {dCRA_LC_TYPES#_type} else {_type}) params ["_lcConfig", "_lcFnc", "_lcPersonnel", "_lcBases"];
	_lcConfig params ["_lcType", "", "_lc_fnc_Name", "_lc_fnc_Label", "", "_lcValue", "_lcCapture", "_lcMarkerType", "_lc_fnc_MarkerLabel"];
	
	(if (_base isEqualType -1) then {dCRA_BASE_INDEX#_base} else {_base}) params ["_bsData", ["_bsInst", []], ["_bsProp", []], ["_bsPersonnel", []]];
	_bsData params ["", "_bsArea", "_bsPlayer", ["_bsClutter", true]]; // TODO flip clutter and player around
	
	private _lcName = [_name, _label, _index, _vec] call _lc_fnc_Name;
	private _lcLabel = [_name, _label, _index, _vec] call _lc_fnc_Label;
	
	if (_bsArea isEqualType -1) then {_bsArea = ((sqrt (0.5)) * _bsArea) call {[[_this, _this],[0,0]]};};
	private _bsSize = _bsArea call CRQ_AreaMinMax;
	private _bsRadius = sqrt ((_bsSize#1#0) ^ 2 + (_bsSize#1#1) ^ 2);
	
	private _location = [_vec, _lcName, _lcLabel, _lcType, [(_bsSize#1#0) * 2, (_bsSize#1#1) * 2]] call CRQ_LocationCreate;
	_location setVariable ["CRAS_ID", name _location];
	
	_location setVariable [CRA_SVAR_VEC, _vec];
	
	_location setVariable [CRA_SVAR_FNC_MAIN, _lcFnc#0];
	_location setVariable [CRA_SVAR_TRIGGER, [_lcFnc#1, (_lcFnc#1) apply {0}]];
	
	if (_bsPlayer isNotEqualTo []) then {
		[_vec, _bsRadius] call CRQ_VecUtilSetup;
		_location setVariable [CRA_SVAR_LOCATION_BASE_PLAYER, _bsPlayer call CRQ_VecUtil];
	};
	_location setVariable [CRA_SVAR_LOCATION_INDEX, _index];
	
	// TODO CRITICAL this very temporary workaround (?)
	[_location, _owner] call CRA_LocationOwnerInit;
	
	_location setVariable [CRA_SVAR_LOCATION_STATE, CRA_STATE_INIT];
	_location setVariable [CRA_SVAR_LOCATION_UNCAPTURED, true];
	_location setVariable [CRA_SVAR_LOCATION_DISCOVER, false];
	_location setVariable [CRA_SVAR_LOCATION_TYPE, _type];
	_location setVariable [CRA_SVAR_LOCATION_VALUE, _lcValue];
	_location setVariable [CRA_SVAR_LOCATION_CAPTUREABLE, _lcCapture];
	
	private _bsMarker = if (_lcMarkerType isNotEqualTo []) then {createMarker [_name, _vec#0]} else {""};
	_bsMarker setMarkerTextLocal ([_name, _label, _index, _vec] call _lc_fnc_MarkerLabel);
	_location setVariable [CRA_SVAR_LOCATION_MARKER_TYPES, _lcMarkerType];
	_location setVariable [CRA_SVAR_LOCATION_MARKER, _bsMarker];
	
	if (_bsClutter) then {
		private _bsOffVec = [(_vec#0) vectorAdd ([_bsArea#1, _vec#1] call CRQ_AreaOffsetRotate), _vec#1];
		_location setVariable [CRA_SVAR_LOCATION_CLUTTER, [_bsOffVec, _bsArea#0, if (_anchor isEqualTo objNull) then {[]} else {[_anchor]}, 24, gRA_PM_SystemClutterDetect] call CRQ_WorldClutter2D];
	};
	
	private _installations = [];
	{if (_x) then {_installations pushBack (_bsInst#_forEachIndex);} else {_installations pushBack ['',[]];};} forEach ((_lcBases#0) call CRQ_fnc_ByteDecode);
	_location setVariable [CRA_SVAR_LOCATION_BASE_INST, [[_vec, _bsRadius], _installations] call CRQ_PropRasterize];
	_location setVariable [CRA_SVAR_LOCATION_BASE_PROP, [[_vec, _bsRadius], _bsProp] call CRQ_PropRasterize];
	
	if (_lcPersonnel isNotEqualTo []) then {
		private _psCount = (_lcPersonnel#1) apply {0};
		private _wpTypes = dCRA_GP_WP_LOCATION#_type;
		private _wpCount = dRA_WaypointCount#_type;
		private _psSource = _bsPersonnel apply {
			private _role = _x#0#0;
			private _waypoints = _x#1;
			private _count = count _waypoints;
			[_psCount, _role, 1] call CRQ_ArrayIncrement;
			[_x#0, _waypoints + ((_wpTypes#_role) select [_count, (_wpCount#_role) - _count])]
		};
		{for "_i" from _x to ((_lcPersonnel#1#_forEachIndex) - 1) do {_psSource pushBack [CRA_PERSONNEL_TYPES#_forEachIndex, _wpTypes#_forEachIndex];};} forEach _psCount;
		private _personnel = [];
		{
			private _waypoints = [[_vec, _bsRadius], _x#1] call CRQ_VecRasterize;
			if (_waypoints isNotEqualTo []) then {_personnel pushBack [_x#0, _waypoints];};
		} forEach _psSource;
		private _psStrength = [];
		{_psStrength pushBack (_x * (CRA_STRENGTH#_forEachIndex));} forEach (_lcPersonnel#0);
		_location setVariable [CRA_SVAR_LOCATION_STRENGTH, _psStrength];
		_location setVariable [CRA_SVAR_LOCATION_BASE_PERSONNEL, _personnel];
	};
	
	{_location setVariable _x;} forEach _vars;
	
	_location
};
CRA_LocationBaseRadioLoop = {
	if (([_this getVariable [CRA_SVAR_LOCATION_RADIO_START, gCS_TM_Now], gCS_TM_Now] call CRQ_fnc_TimeDelta) > (_this getVariable [CRA_SVAR_LOCATION_RADIO_LENGTH, 1])) then {_this call CRA_LocationBaseRadioNext;};
};
CRA_LocationBaseRadioNext = {
	private _radio = _this getVariable [CRA_SVAR_LOCATION_UNIT_INST_RADIO, objNull];
	if (_radio isEqualTo objNull) exitWith {};
	private _index = _this getVariable [CRA_SVAR_LOCATION_RADIO_TRACK, -1];
	_index = (_index + 1) % (count CRA_BASE_RADIO_TRACKS);
	private _track = (CRA_BASE_RADIO_TRACKS#_index);
	// binding sound to object does not cause sound to be stopped when object deleted
	playSound3D [getMissionPath (_track#0), objNull, false, getPosASL _radio, _track#2,_track#3, CRA_BASE_RADIO_RANGE];
	_this setVariable [CRA_SVAR_LOCATION_RADIO_TRACK, _index];
	_this setVariable [CRA_SVAR_LOCATION_RADIO_START, gCS_TM_Now];
	_this setVariable [CRA_SVAR_LOCATION_RADIO_LENGTH, (_track#1) + CRA_BASE_RADIO_GRACE];
};
CRA_LocationBaseLights = {
	params ["_location", "_state"];
	private _fire = _location getVariable [CRA_SVAR_LOCATION_UNIT_INST_FIRE, objNull];
	if (_fire isNotEqualTo objNull) then {_fire inflame _state;};
};
CRA_LocationBaseSpawn = {
	{_x hideObjectGlobal true;} forEach (_this getVariable [CRA_SVAR_LOCATION_CLUTTER, []]);
	{
		_this setVariable [_x#1, [_this getVariable [_x#0, []], true, true] call CRQ_PropSpawn];
	} forEach [[CRA_SVAR_LOCATION_BASE_PROP,CRA_SVAR_LOCATION_UNIT_PROP]];
	{
		_this setVariable [_x#1, [_this getVariable [_x#0, []], false, false] call CRQ_PropSpawn];
	} forEach [[CRA_SVAR_LOCATION_BASE_INST,CRA_SVAR_LOCATION_UNIT_INST]];
	private _installations = _this getVariable [CRA_SVAR_LOCATION_UNIT_INST, CRA_BASE_INST_EMPTY];
	_this setVariable [CRA_SVAR_LOCATION_UNIT_INST_MAP, _installations#0];
	_this setVariable [CRA_SVAR_LOCATION_UNIT_INST_BOX, _installations#1];
	_this setVariable [CRA_SVAR_LOCATION_UNIT_INST_BOX_AUX, _installations#2];
	_this setVariable [CRA_SVAR_LOCATION_UNIT_INST_RADIO, _installations#3];
	_this setVariable [CRA_SVAR_LOCATION_UNIT_INST_FIRE, _installations#4];
	_this setVariable [CRA_SVAR_LOCATION_UNIT_INST_GATE, _installations#5];
	_this setVariable [CRA_SVAR_LOCATION_UNIT_INST_FLAG, _installations#6];
	(_installations#1) lockInventory false;
	(_installations#1) setMaxLoad CRA_BASE_INVENTORY_SIZE;
};
CRA_LocationBaseDespawn = {
	_this setVariable [CRA_SVAR_LOCATION_UNIT_INST_MAP, objNull];
	_this setVariable [CRA_SVAR_LOCATION_UNIT_INST_BOX, objNull];
	_this setVariable [CRA_SVAR_LOCATION_UNIT_INST_BOX_AUX, objNull];
	_this setVariable [CRA_SVAR_LOCATION_UNIT_INST_RADIO, objNull];
	_this setVariable [CRA_SVAR_LOCATION_UNIT_INST_FIRE, objNull];
	_this setVariable [CRA_SVAR_LOCATION_UNIT_INST_GATE, objNull];
	_this setVariable [CRA_SVAR_LOCATION_UNIT_INST_FLAG, objNull];
	{(_this getVariable [_x, []]) call CRQ_PropDespawn; _this setVariable [_x, []];} forEach [CRA_SVAR_LOCATION_UNIT_INST,CRA_SVAR_LOCATION_UNIT_PROP];
	{_x hideObjectGlobal false;} forEach (_this getVariable [CRA_SVAR_LOCATION_CLUTTER, []]);
};
CRA_LocationActionCreate = {
	private _map = _this getVariable [CRA_SVAR_LOCATION_UNIT_INST_MAP, objNull];
	private _box = _this getVariable [CRA_SVAR_LOCATION_UNIT_INST_BOX, objNull];
	private _index = _this getVariable [CRA_SVAR_LOCATION_INDEX, -1];
	if (_index == -1) exitWith {};
	[_map, "Teleport", [CRA_ACTION_ID_PLAYER_TELEPORT]] call CRA_ActionRelayAdd;
	[_map, "Paradrop", [CRA_ACTION_ID_PLAYER_PARADROP]] call CRA_ActionRelayAdd;
	//[_map, "Train Militia", [CRA_ACTION_ID_MILITIA_TRAIN]] call CRA_ActionRelayAdd;
	[_map, "Gather Intel", [CRA_ACTION_ID_INTEL_GATHER, _index]] call CRA_ActionRelayAdd;
	[_box, "Unload, Repack, Sort", [CRA_ACTION_ID_INVENTORY_SORT, _index]] call CRA_ActionRelayAdd;
	[_box, format ["Gather Items (%1m)", CRA_BASE_INVENTORY_GATHER_RANGE], [CRA_ACTION_ID_INVENTORY_GATHER, _index, CRA_BASE_INVENTORY_GATHER_RANGE]] call CRA_ActionRelayAdd;
};
CRA_LocationActionRemove = {
	{(_this getVariable [_x, objNull]) call {if (isNull _this) exitWith {}; _this call CRQ_fnc_AC_RemoveAll};} forEach [CRA_SVAR_LOCATION_UNIT_INST_MAP, CRA_SVAR_LOCATION_UNIT_INST_BOX];
};
CRA_LocationIntelGather = {
	private _range = CRA_BASE_INTEL_RANGE * (_this getVariable [CRA_SVAR_LOCATION_VALUE, 0]);
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
	private _flagObj = _location getVariable [CRA_SVAR_LOCATION_UNIT_INST_FLAG, objNull];
	if (_flagObj isEqualTo objNull) exitWith {};
	([_location, -1] call CRA_fnc_LC_Owner) params [["_favO", CRQ_SD_UNKNOWN], ["_favV", 0]];
	if (_favO isEqualTo CRQ_SD_UNKNOWN) exitWith {};
	
	_flagObj setFlagTexture (CQM_TX_SD_FLAGS#_favO);
	
	private _flagAnim = ("true" configClasses (configFile >> "CfgVehicles" >> (typeOf _flagObj) >> "AnimationSources")) apply {configName _x};
	if (_flagAnim isNotEqualTo []) exitWith {_flagObj animateSource [_flagAnim#0, _favV, true];};
	[_flagObj, _favV] remoteExec ["setFlagAnimationPhase", gCS_MP_All];
};
CRA_LocationInventoryInit = {
	private _box = _this getVariable [CRA_SVAR_LOCATION_UNIT_INST_BOX, objNull];
	if (_box isEqualTo objNull) exitWith {};
	_this setVariable [CRA_SVAR_LOCATION_INVENTORY, [[[CRA_ITEM_WP_ALL], (-0.03125 + random 0.125) call CRA_fnc_IT_Quality] call CRA_fnc_IT_Random, false, false] call CRA_fnc_IT_WeaponRasterize];
};
CRA_LocationInventorySave = {
	private _box = _this getVariable [CRA_SVAR_LOCATION_UNIT_INST_BOX, objNull];
	if (_box isEqualTo objNull) exitWith {};
	_this setVariable [CRA_SVAR_LOCATION_INVENTORY, _box call CRQ_InventoryBox];
};
CRA_LocationInventoryLoad = {
	private _box = _this getVariable [CRA_SVAR_LOCATION_UNIT_INST_BOX, objNull];
	if (_box isEqualTo objNull) exitWith {};
	_box call CRQ_InventoryBoxClear;
	[_box, _this getVariable [CRA_SVAR_LOCATION_INVENTORY, [[[],[],[]],[]]]] call CRQ_InventoryBoxAppend;
};
CRA_LocationInventorySort = {
	private _box = _this getVariable [CRA_SVAR_LOCATION_UNIT_INST_BOX, objNull];
	if (_box isEqualTo objNull) exitWith {};
	_box call CRQ_InventoryBoxOrganize;
};
CRA_LocationInventoryGather = {
	params ["_location", "_range"];
	private _vec = _location getVariable [CRA_SVAR_VEC, []];
	private _box = _location getVariable [CRA_SVAR_LOCATION_UNIT_INST_BOX, objNull];
	if (_box isEqualTo objNull || {_vec isEqualTo []}) exitWith {[0,0,0,0]};
	private _inventory = [[[],[],[]],[]];
	private _corpses = [];
	private _boxes = [];
	{
		(typeOf _x) call {
			if (_this isEqualTo "Man") exitWith {_corpses pushBack _x;};
			if (_this isEqualTo "WeaponHolderSimulated") exitWith {_boxes pushBack _x;};
			if (_this isEqualTo "GroundWeaponHolder") exitWith {_boxes pushBack _x;};
			// must be vehicle then
			private _include = true;
			private _crew = crew _x;
			{if (alive _x) exitWith {_include = false;};} forEach _crew; // TODO this will unintentionally exclude if any player is in vehicle too
			if (_include) then {_corpses append _crew;};
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
	[_box, _inventory] call CRQ_InventoryBoxAppend;
	[count (_inventory#0#0), count (_inventory#0#1), count (_inventory#0#2), count (_inventory#1)]
};
CRA_LocationMarkerState = {
	private _marker = _this getVariable [CRA_SVAR_LOCATION_MARKER, ""];
	if (_marker isEqualTo "") exitWith {};
	private _types = _this getVariable [CRA_SVAR_LOCATION_MARKER_TYPES, []];
	if (_types isEqualTo []) exitWith {};
	private _state = _this getVariable [CRA_SVAR_LOCATION_STATE, -1];
	if (_state == -1) exitWith {};
	private _owner = _this call CRA_fnc_LC_Owner;
	_marker setMarkerAlphaLocal (CRA_MARKER_ALPHA#_state);
	if (_owner != -1) then {_marker setMarkerType (_types#_owner);} else {_marker setMarkerType CRA_MARKER_UNKNOWN;};
};
CRA_LocationPersonnelSpawn = {
	private _owner = _this call CRA_fnc_LC_Owner;
	private _factions = switch (_owner) do { // TODO does this -1 fix really fix it?
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
	(_group getVariable [CRA_SVAR_SCRIPT_HANDLE, []]) params [["_tskType", CRA_GP_TSK_UNKNOWN], ["_tskTime", gCS_TM_Now - _timeOut], ["_tskAI", scriptNull]];
	if (_tskAI isEqualTo scriptNull || {([_tskTime, gCS_TM_Now] call CRQ_fnc_TimeDelta) < CRA_SCRIPT_TIMEOUT}) exitWith {false};
	terminate _tskAI;
	true
};
CRA_fnc_GP_TSK_AI_Spawn = {
	params [["_tskGroup", grpNull], ["_tskType", CRA_GP_TSK_UNKNOWN], ["_tskFunc", {}]];
	if (_tskGroup isEqualTo grpNull) exitWith {};
	_tskGroup setVariable [CRA_SVAR_SCRIPT_HANDLE, [_tskType, gCS_TM_Now, _tskGroup spawn _tskFunc]];
};
CRA_fnc_GP_TSK_WH_CRUISE_FIND = {
	private _path1 = [];
	private _path0 = _this getVariable [CRA_SVAR_GROUP_PATH, []];
	private _rd0Last0 = count _path0 - 1;
	private _rd0Last1 = _rd0Last0 - 1;
	if (!(_rd0Last1 < 0)) then {
		private _rdLast = _path0#_rd0Last0;
		{_path1 = [_rdLast, [_path0#_rd0Last1], _rdLast call CRQ_Pos2D, _x] call CRQ_RoadPath; if (_path1 isNotEqualTo []) exitWith {};} forEach CRA_CIVILIAN_EXTENSIONS;
		if (_path1 isEqualTo []) exitWith {};
		[_this, _path1 call CRQ_RoadWaypoints] call CRQ_WaypointVehicleTravel;
	};
	_this setVariable [CRA_SVAR_GROUP_PATH, _path1];
};
CRA_fnc_GP_TSK_FW_CRUISE_FIND = {
	private _path0 = _this getVariable [CRA_SVAR_GROUP_PATH, []];
	if (_path0 isEqualTo []) then { // TODO shouldn't happen, find out why?
		_path0 = [_this call CRQ_VecGroup3D];
		_this setVariable [CRA_SVAR_GROUP_PATH, _path0]
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
	_group setVariable ["CRAS_ID", call CRA_fnc_GP_Ticket];
	_group
};
CRA_fnc_GP_Register = { // TODO implement me
	gRA_GP_List set [_group getVariable "CRAS_ID", if (_this isEqualType []) then {_this} else {[
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
	private _vehicle = ((_group getVariable "CRAS_ID") call CRQ_fnc_LNK_Get) call {if (_this isEqualType createHashMap) then {objNull} else {_this#0#0};};
	
	if (_vehicle isEqualType objNull) then {
		if (_vehicle isEqualTo objNull) exitWith {_active = false;};
		if (_units isEqualTo []) exitWith {_disembark = true;};
		_activity = _vehicle getVariable [CRA_SVAR_ACTIVITY, 0];
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
			private _path = _group getVariable [CRA_SVAR_GROUP_PATH, []];
			if (_path isEqualTo []) exitWith {_disembark = true;};
			_active = !(_group call CRA_fnc_GP_TSK_AI_Terminate); // returns true if forced terminated from timeout
			if ([[(_path#-1) call CRQ_Pos2D, 0], gRA_PG_Activation, 0, CRA_ACTIVITY_MIN, CRA_ACTIVITY_MAX] call CRA_PlayerActivity > 0) exitWith {
				[_group, CRA_GP_TSK_WH_CRUISE_FIND, CRA_fnc_GP_TSK_WH_CRUISE_FIND] call CRA_fnc_GP_TSK_AI_Spawn;
			};
		};
		if (_type == CRA_ASSET_WINGED || {_type == CRA_ASSET_ROTOR}) exitWith {
			private _actBase = (_vehicle getVariable [CRA_SVAR_ACTIVITY_BASE, gRA_PG_Activation]) call {if (_this < 0) then {-_this * gRA_PG_Activation} else {_this}};
			
			(_group call CRQ_fnc_WP_Status) params ["_waypoints", "_wpNow", "_wpLast"];
			
			_active = !(_group call CRA_fnc_GP_TSK_AI_Terminate); // returns true if forced terminated from timeout
			if (_wpNow < _wpLast && {[[waypointPosition [_group, _wpLast], 0], _actBase, 0, CRA_ACTIVITY_MIN, CRA_ACTIVITY_MAX] call CRA_PlayerActivity <= 0}) exitWith {};
			[_group, CRA_GP_TSK_FW_CRUISE_FIND, CRA_fnc_GP_TSK_FW_CRUISE_FIND] call CRA_fnc_GP_TSK_AI_Spawn;
		};
	} else {
		// TODO hibernated vehicle
	};
	
	if (_disembark) then {
		_group leaveVehicle _vehicle;
		//[_group, 0, grpNull] call CRQ_LinkFree;
		(_group getVariable "CRAS_ID") call CRQ_fnc_LNK_Free; // TODO keep link alive for fleeing civs?
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
	} forEach (_roads call CRQ_ArrayRandomize);
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
	[gRA_CivilianAssetCount, _type] call CRQ_ArrayIncrement;
	_group call CRA_fnc_GP_Register;
};
CRA_CivilianAssetDespawn = {
	[gRA_CivilianAssetCount, _this, -1] call CRQ_ArrayIncrement;
};
CRA_CivilianCarSpawn = {
	params ["_pos"];
	private _path = [_pos, gRA_PG_Activation * CRA_PATHGENERATOR_RADIUS, gRA_PG_Activation] call CRA_CivilianCarPath;
	if (count _path < 1 || {((getRoadInfo (_path#0))#8) || {((getRoadInfo (_path#-1))#8)}}) exitWith {grpNull};
	([[(_path#0) call CRQ_Pos2D, (_path#0) getDir (_path#1)], [[CRQ_SD_CIV,CRA_ASSET_WHEELED,CRA_VEHICLE_UNARMED]], _path call CRQ_RoadWaypoints] call CRA_CivilianAssetCreate) params [["_group", grpNull], ["_asset", objNull]];
	if (_group isEqualTo grpNull) exitWith {grpNull};
	_group setVariable [CRA_SVAR_GROUP_PATH, _path];
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
	_asset setVariable [CRA_SVAR_ACTIVITY, 0.5];
	_asset setVariable [CRA_SVAR_ACTIVITY_BASE, -2];
	_group setVariable [CRA_SVAR_GROUP_PATH, _flPath];
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
	[_group getVariable "CRAS_ID", [[_asset, 0], [_group]], [[false, -1, -1]]] call CRQ_fnc_LNK_Create;
	
	[_asset, true, false, false, _vec] call CRA_fnc_AS_Register;
	// TODO why on asset, not group? attempting to disable day 295...
	//_asset disableAi "AUTOTARGET";
	//_asset disableAi "TARGET";
	// TODO these were previously commented out
	//_asset setCaptive true;
	//_group allowFleeing 0;
	[_group, _asset]
};
CRA_CivilianLoop = {
	[] call CRA_fnc_GP_Loop;
	if (!(gRA_PL_Count > 0)) exitWith {};
	
	{
		private _type = _x;
		if (([gRA_CivilianAssetTime#_type, gCS_TM_Now] call CRQ_fnc_TimeDelta) >= CRA_CIVILIAN_SPAWN_TIMER) then {
			if ((gRA_CivilianAssetCount#_type) < (gRA_CivilianAssetLimit#_type) && {random 1 < (gRA_CivilianAssetProb#_type)}) then {
				if ((gRA_CivilianAssetSpawn#_type) isNotEqualTo scriptNull) exitWith {}; // TODO error-handling
				gRA_CivilianAssetSpawn set [_type, [selectRandom gRA_PL_Pos, _type] spawn CRA_CivilianAssetSpawn];
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
CRA_fnc_SD_Init = {
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
CRA_fnc_EN_LightsOn = {
	{if (_x getVariable [CRA_SVAR_LOCATION_STATE, -1] == CRA_STATE_ACTIVE) then {[_x, true] call CRA_LocationBaseLights;};} forEach gRA_LC_List;
};
CRA_fnc_EN_LightsOff = {
	{if (_x getVariable [CRA_SVAR_LOCATION_STATE, -1] == CRA_STATE_ACTIVE) then {[_x, false] call CRA_LocationBaseLights;};} forEach gRA_LC_List;
};
CRA_fnc_InitLoad = {
	private _tickInitPost = diag_tickTime;
	if (gRA_PM_SystemHotLoad) then {CRQ_BS_TM_SYNC spawn {while {pRA_Initializing} do {publicVariable "pRA_LoadMessage"; publicVariable "pRA_LoadIndex"; publicVariable "pRA_LoadTotal"; sleep _this;};};};
	
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
	private _tickInitDepot = diag_tickTime;
	[] call CRA_DepotInit;
	gRA_TickInitDepot = diag_tickTime - _tickInitDepot;
	private _tickInitLocation = diag_tickTime;
	[] call CRA_LocationInit;
	gRA_TickInitLocation = diag_tickTime - _tickInitLocation;
	[] call CRA_fnc_PG_InitPost;
	missionNamespace setVariable ["pRA_Initializing", false, true];
	gRA_TickInitPost = diag_tickTime - _tickInitPost;
	[] call CRA_PlayerGreet;
};
CRA_fnc_InitZero = {
	private _tickInitPre = diag_tickTime;
	[true] call CRQ_CatalogInit;
	[] call CRA_PlayerInit;
	[] call CRA_fnc_SD_Init;
	[] call CRA_fnc_IT_Init;
	[] call CRA_fnc_AS_InitZero;
	[] call CRA_fnc_PG_InitPre;
	[] call CRA_CivilianInit;
	gRA_TickInitPre = diag_tickTime - _tickInitPre;
	if (gRA_PM_SystemHotLoad) exitWith {};
	[] call CRA_fnc_InitLoad;
};
CRA_fnc_InitMain = {
	if (!gRA_PM_SystemHotLoad) exitWith {};
	[] spawn CRA_fnc_InitLoad;
};
CRA_fnc_MainLoop = {
	if (pRA_Initializing) exitWith {};
	private _tickLoop = diag_tickTime;
	[] call CRA_fnc_SD_Loop;
	[] call CRA_fnc_PL_Loop;
	[] call CRA_fnc_AS_Loop;
	[] call CRA_CivilianLoop;
	[] call CRA_LocationLoop;
	gRA_TickLoop = diag_tickTime - _tickLoop;
};
