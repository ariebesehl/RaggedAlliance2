
CRA_LocalActionRelayTransmit = {
	_this remoteExec ["CRA_ActionRelayReceive", 2];
};
CRA_LocalTextParam = {
	params ["_textIndex", "_arg"];
	private _data = dCRA_TEXT_INDEX#_textIndex;
	private _message = [_data#0];
	{
		_message pushBack (switch (_x) do {
			case CRA_TEXT_PARAM_PASS: {_arg#_forEachIndex};
			case CRA_TEXT_PARAM_NUMBER: {str (_arg#_forEachIndex)};
			case CRA_TEXT_PARAM_DICT: {CRA_DICT_INDEX#(_arg#_forEachIndex)};
			case CRA_TEXT_PARAM_PLAYER_NAME: {profileName};
			case CRA_TEXT_PARAM_SIDE: {(_arg#_forEachIndex) call CRQ_SideLabel};
			case CRA_TEXT_PARAM_WORLD: {worldName};
			case CRA_TEXT_PARAM_LOCATION: {pRA_Locations#(_arg#_forEachIndex)#0};
			case CRA_TEXT_PARAM_ISO8601;
			case CRA_TEXT_PARAM_DATE_FULL: {(_arg#_forEachIndex) call CRQ_ISO8601Full};
			case CRA_TEXT_PARAM_DATE_SHORT: {(_arg#_forEachIndex) call CRQ_ISO8601Short};
			default {""};
		});
	} forEach (_data#1);
	(format _message)
};
CRA_LocalClientConnect = {
	[] spawn CRA_DisplayInit;
	[] spawn CRA_LocalClientLoading;
	[] spawn CRA_LocalClientIntro;
};
CRA_LocalClientIntro = {
	sleep 2.4;
	["CRA_RES_MUSIC_ORIG_INTRO"] call CRA_LocalMusicForce;
	sleep 2.4;
	[CRA_TEXT_PLAYER_GREET, [-1]] call CRA_fnc_PLL_InfoMessage;
	[CRA_TEXT_PLAYER_VERSION, [[CRA_VERSION,"",false]]] call CRA_fnc_PLL_InfoMessage;
};
CRA_LocalClientLoading = {
	if (!pRA_Initializing) exitWith {};
	private _stages = count CRA_LOADING_MESSAGE_STAGES;
	while {pRA_Initializing} do {
		private _message = if (pRA_LoadTotal > 0) then {
			format [CRA_LOADING_MESSAGE_INFO_PROGRESS, pRA_LoadMessage + 1, _stages, (CRA_LOADING_MESSAGE_STAGES#pRA_LoadMessage), floor ((pRA_LoadIndex / pRA_LoadTotal) * 100), "%"]
		} else {
			format [CRA_LOADING_MESSAGE_INFO_BASIC, pRA_LoadMessage + 1, _stages, (CRA_LOADING_MESSAGE_STAGES#pRA_LoadMessage)]
		};
		_message call CRQ_fnc_HUD_InfoText;
		sleep CRQ_BS_TM_SYNC;
	};
	CRA_LOADING_MESSAGE_INFO_FINISH call CRQ_fnc_HUD_InfoText;
	sleep CRA_LOADING_DELAY_EXIT;
	CRA_LOADING_MESSAGE_INFO_EXIT call CRQ_fnc_HUD_InfoText;
};
CRA_LocalSoundUI = {
	params ["_id"];//, ["_volume", 1], ["_pitch", 1], ["_effect", false], ["_offset", 0]];
	private _now = time;
	if ((_now - (lRA_SoundUI getOrDefault [_id, _now - CRA_SOUND_UI_GRACE])) < CRA_SOUND_UI_GRACE) exitWith {};
	lRA_SoundUI set [_id, _now];
	playSoundUI _this
};
CRA_LocalMusicKill = {
	lRA_MusicPlayer = _this;
	if (["isInitialized"] call BIS_fnc_jukebox) then {["terminate"] call BIS_fnc_jukebox;};
};
CRA_LocalMusicRestore = {
	lRA_MusicPlayer = _this;
	["initialize", (((pRA_Themes getOrDefault [lRA_PlayerTheme, CRA_THEME_NONE])#1) + CRA_MUSIC_JUKEBOX_PARAM)] call BIS_fnc_jukebox;
};
CRA_LocalMusicForce = {
	if (lRA_MusicPlayer isEqualType scriptNull && {lRA_MusicPlayer isNotEqualTo scriptNull}) exitWith {}; // rare case, at least it should be
	if (lRA_MusicPlayer isEqualType -1) then {
		removeMusicEventHandler ["MusicStop", lRA_MusicPlayer];
	} else {
		scriptNull call CRA_LocalMusicKill;
	};
	// playMusic "";
	lRA_MusicPlayer = _this spawn {
		sleep CRA_SOUND_UI_GRACE;
		playMusic (_this#0);
		lRA_MusicPlayer = addMusicEventHandler ["MusicStop", {removeMusicEventHandler ["MusicStop", _this#1]; scriptNull call CRA_LocalMusicRestore;}];
	};
};
CRA_fnc_PLL_Death = {
	["CRA_RES_MUSIC_ORIG_LOSS"] call CRA_LocalMusicForce;
};
CRA_fnc_PLL_LocationWin = {
	["CRA_RES_MUSIC_ORIG_WIN"] call CRA_LocalMusicForce;
};
CRA_fnc_PLL_LocationLost = {
	["CRA_RES_MUSIC_ORIG_LOSS"] call CRA_LocalMusicForce;
};
CRA_fnc_PLL_InfoMessage = {
	systemChat (_this call CRA_LocalTextParam);
	["CRA_RES_SOUND_UI_MESSAGE"] call CRA_LocalSoundUI;
};
CRA_fnc_PLL_InfoNotify = {
	(_this call CRA_LocalTextParam) call CRQ_fnc_HUD_InfoText;
	["CRA_RES_SOUND_UI_NOTIFY"] call CRA_LocalSoundUI;
};
CRA_fnc_PLL_MailRead = {
	private _mailbox = missionNamespace getVariable [CRA_PVAR_PLAYER_MAILBOX, []];
	(_mailbox#_this) set [0, true];
	[player, _this] remoteExec ["CRA_fnc_PL_MailRead", 2];
};
CRA_fnc_PLL_RQR_Spawn = {
	CRA_DISPLAY_MAP_MODE_SPAWN call CRA_DisplayMapCreate;
};
CRA_fnc_PLL_RQR_Teleport = {
	CRA_DISPLAY_MAP_MODE_TELEPORT call CRA_DisplayMapCreate;
};
CRA_fnc_PLL_RQR_Paradrop = {
	CRA_DISPLAY_MAP_MODE_PARADROP call CRA_DisplayMapCreate;
};
CRA_DisplayInit = {
	(findDisplay 46) displayAddEventHandler ["KeyDown", "if ((_this#1) == 22 && {!dialog}) then {call CRA_DisplayLaptopInit;};"];
	(findDisplay 46) displayAddEventHandler ["KeyUp", "if ((_this#1) == 22) then {lRA_DisplayLaptopInit = -1;};"];
};
CRA_DisplayLaptopInit = {
	if (lRA_DisplayLaptopInit == -1) then {lRA_DisplayLaptopInit = time;};
	if (time - lRA_DisplayLaptopInit < 1.0) exitWith {};
	lRA_DisplayLaptopInit = -1;
	[] call CRA_DisplayLaptopCreate;
};
CRA_DisplayLaptopCreate = {
	[] call CRQ_DisplayLaptopCreate;
};
CRA_DisplayLaptopExit = {
	params ["_display", "_type"];
	private _children = [];
	private _child = displayChild (findDisplay 46);
	while {_child isNotEqualTo displayNull} do {
		_children pushBack _child;
		_child = displayChild _child;
	};
	reverse _children;
	{_x closeDisplay CRA_DISPLAY_QUIT;} forEach _children;
};
CRA_DisplayLaptopTile = {
	params ["_display", "_index"];
	switch (_index) do {
		default {};
		case 2: {call CRA_DisplayLaptopMailCreate;};
		case 15: {_display closeDisplay 2;};
	};
};
CRA_DisplayLaptopMailCreate = {
	((findDisplay 46) createDisplay CRQ_STRING(CRA_GUI_DISP_MAIL_ROOT)) call CRA_DisplayLaptopMailPopulate;
};
CRA_DisplayLaptopMailExit = {
	params ["_display", "_type"];
	if (_type == CRA_DISPLAY_QUIT) exitWith {};
};
CRA_DisplayLaptopMailPopulate = {
	private _mail = +(missionNamespace getVariable [CRA_PVAR_PLAYER_MAILBOX, []]);
	reverse _mail;
	uiNamespace setVariable [CRA_CVAR_DISPLAY_MAIL_DATA, _mail];
	(_this displayCtrl CRA_GUI_ID_MAIL_TITLE) ctrlSetText CRA_DISPLAY_MAIL_TITLE;
	private _list = _this displayCtrl CRA_GUI_ID_MAIL_LIST;
	lnbClear _list;
	_list lnbAddColumn 1;
	_list lnbAddColumn 1;
	_list lnbAddColumn 1;
	_list lnbAddColumn 1;
	_list lnbSetColumnsPos [0.00,0.05,0.10,0.25,0.50];
	{
		_x params ["_read", "_attach", "_date", "_sender", "_subject"];
		private _row = _forEachIndex;
		_list lnbAddRow ["", "", [_date] call CRQ_ISO8601Full, _sender call CRA_LocalTextParam, _subject call CRA_LocalTextParam];
		if (_attach isNotEqualTo []) then {_list lnbSetPicture [[_row, 0], "res\CQM-ui-icon-attachment.paa"];};
		if (_read) then {
			_list lnbSetPicture [[_row, 1], "res\CQM-ui-icon-read.paa"];
		} else {
			_list lnbSetPicture [[_row, 1], "res\CQM-ui-icon-unread.paa"];
			{_list lnbSetPictureColor [[_row, _x], [1,1,0,1]];} forEach [0,1];
			{_list lnbSetColor [[_row, _x], [1,1,0,1]];} forEach [2,3,4];
		};
	} forEach _mail;
};
CRA_DisplayLaptopMailSelect = {
	params ["_ctrl", "_index"];
	[ctrlParent _ctrl, _index] call CRA_DisplayLaptopMessageCreate;
};
CRA_DisplayLaptopMessageCreate = {
	params ["_root", "_index"];
	private _mail = uiNamespace getVariable [CRA_CVAR_DISPLAY_MAIL_DATA, []];
	if (_mail isEqualTo []) exitWith {};
	private _display = _root createDisplay CRQ_STRING(CRA_GUI_DISP_MESSAGE_ROOT);
	(_mail#_index) params ["_read", "_attach", "_date", "_senderData", "_subjectData", "_textData"];
	private _sender = _senderData call CRA_LocalTextParam;
	private _subject = _subjectData call CRA_LocalTextParam;
	private _text = _textData call CRA_LocalTextParam;
	(_display displayCtrl CRA_GUI_ID_MESSAGE_TITLE) ctrlSetText (_sender + ": " + _subject);
	private _list = _display displayCtrl CRA_GUI_ID_MESSAGE_LIST;
	_list lnbAddColumn 1;
	_list lnbSetColumnsPos [0.00,0.25];
	_list lnbAddRow ["Date:", [_date] call CRQ_ISO8601Full];
	_list lnbAddRow ["Sender:", _sender];
	_list lnbAddRow ["Subject:", _subject];
	(_display displayCtrl CRA_GUI_ID_MESSAGE_TEXT) ctrlSetText _text;
	(count _mail - 1 - _index) call CRA_fnc_PLL_MailRead;
};
CRA_DisplayLaptopMessageExit = {
	params ["_display", "_type"];
	if (_type == CRA_DISPLAY_QUIT) exitWith {};
	(displayParent _display) call CRA_DisplayLaptopMailPopulate;
};
CRA_DisplayMapCreate = {
	if (lRA_PlayerParadrop isEqualTo []) then {lRA_PlayerParadrop = [player call CRQ_Pos2D, getDir player];};
	(switch (_this) do {
		case CRA_DISPLAY_MAP_MODE_SPAWN: {
			private _destinations = pRA_LocationSafe + [-1];
			reverse _destinations;
			private _labelList = _destinations apply {if (_x != -1) then {pRA_Locations#_x#0} else {CRA_DISPLAY_MAP_LABEL_PARADROP}};
			[CRA_DISPLAY_MAP_MODE_SPAWN, _destinations, CRA_DISPLAY_MAP_TITLE_SPAWN, _labelList] + (if (count _destinations > 1) then {
				private _pos = pRA_Locations#(_destinations#1)#1;
				["tele", CRA_PATH_UI_TELEPORT, [_pos, 0], CRA_DISPLAY_MAP_ICON_SHOW] call CRQ_fnc_UI_MapIconAdd;
				["para", CRA_PATH_UI_PARADROP, lRA_PlayerParadrop, CRA_DISPLAY_MAP_ICON_HIDE] call CRQ_fnc_UI_MapIconAdd;
				[1, _pos, ["tele", "para"]]
			} else {
				["tele", CRA_PATH_UI_TELEPORT, lRA_PlayerParadrop, CRA_DISPLAY_MAP_ICON_HIDE] call CRQ_fnc_UI_MapIconAdd;
				["para", CRA_PATH_UI_PARADROP, lRA_PlayerParadrop, CRA_DISPLAY_MAP_ICON_SHOW] call CRQ_fnc_UI_MapIconAdd;
				[0, lRA_PlayerParadrop#0, ["tele", "para"]]
			})
		};
		case CRA_DISPLAY_MAP_MODE_TELEPORT: {
			[] call CRQ_fnc_PLL_UI_Enter;
			private _destinations = +pRA_LocationSafe;
			if (_destinations isEqualTo []) exitWith {[]};
			reverse _destinations;
			private _labelList = _destinations apply {pRA_Locations#_x#0};
			private _pos = pRA_Locations#(_destinations#0)#1;
			["tele", CRA_PATH_UI_TELEPORT, [_pos, 0], CRA_DISPLAY_MAP_ICON_SHOW] call CRQ_fnc_UI_MapIconAdd;
			[CRA_DISPLAY_MAP_MODE_TELEPORT, _destinations, CRA_DISPLAY_MAP_TITLE_TELEPORT, _labelList, -1, _pos, ["tele", ""]]
		};
		case CRA_DISPLAY_MAP_MODE_PARADROP: {
			[] call CRQ_fnc_PLL_UI_Enter;
			["para", CRA_PATH_UI_PARADROP, lRA_PlayerParadrop, CRA_DISPLAY_MAP_ICON_SHOW] call CRQ_fnc_UI_MapIconAdd;
			[CRA_DISPLAY_MAP_MODE_PARADROP, [], CRA_DISPLAY_MAP_TITLE_PARADROP, [], -1, lRA_PlayerParadrop#0, ["", "para"]]
		};
		default {[]};
	}) params [["_mode", -1], ["_data", []], ["_labelCtrl", []], ["_labelList", []], ["_index", -1], ["_pos", []], ["_iconMap", []]];
	if (_mode < 0) exitWith {};
	uiNamespace setVariable [CRA_CVAR_DISPLAY_MAP_MODE, _mode];
	uiNamespace setVariable [CRA_CVAR_DISPLAY_MAP_DATA, _data];
	uiNamespace setVariable [CRA_CVAR_DISPLAY_MAP_ICON, _iconMap];
	[_labelCtrl, _labelList, _index, _pos] call CRQ_fnc_UI_MapCreate;
	openMap [false, true];
};
CRA_DisplayMapExit = {
	params ["_display", "_type"];
	private _retrigger = false;
	switch (uiNamespace getVariable [CRA_CVAR_DISPLAY_MAP_MODE, -1]) do {
		case CRA_DISPLAY_MAP_MODE_SPAWN: {
			_retrigger = [] call {
				if (_type != 1) exitWith {true;};
				private _selected = _display call CRQ_fnc_UI_MapGetIndex;
				private _destinations = uiNamespace getVariable [CRA_CVAR_DISPLAY_MAP_DATA, []];
				if (_selected == -1 || _destinations isEqualTo []) exitWith {true};
				[player, _destinations#_selected, lRA_PlayerParadrop] remoteExec ["CRA_fnc_PL_RQR_Spawn", 2];
				false
			};
		};
		case CRA_DISPLAY_MAP_MODE_TELEPORT: {
			[] call CRQ_fnc_PLL_UI_Exit;
			if (_type != 1) exitWith {};
			private _selected = _display call CRQ_fnc_UI_MapGetIndex;
			private _destinations = uiNamespace getVariable [CRA_CVAR_DISPLAY_MAP_DATA, []];
			if (_selected == -1 || _destinations isEqualTo []) exitWith {};
			[player, _destinations#_selected] remoteExec ["CRA_fnc_PL_RQR_Teleport", 2];
		};
		case CRA_DISPLAY_MAP_MODE_PARADROP: {
			[] call CRQ_fnc_PLL_UI_Exit;
			if (_type != 1) exitWith {};
			[player, lRA_PlayerParadrop] remoteExec ["CRA_fnc_PL_RQR_Paradrop", 2];
		};
		default {};
	};
	{_x call CRQ_fnc_UI_MapIconRemove;} forEach (uiNamespace getVariable [CRA_CVAR_DISPLAY_MAP_ICON, []]);
	uiNamespace setVariable [CRA_CVAR_DISPLAY_MAP_ICON, []];
	uiNamespace setVariable [CRA_CVAR_DISPLAY_MAP_DATA, []];
	uiNamespace setVariable [CRA_CVAR_DISPLAY_MAP_MODE, -1];
	openMap [false, false];
	if (_retrigger) then { // TODO QD workaround
		[] spawn {
			[] call CRQ_fnc_CLL_PauseForce;
			waitUntil {sleep CRA_DISPLAY_MAP_RETRIGGER; ([] call CRQ_fnc_CLL_PauseState) isNotEqualTo true};
			CRA_DISPLAY_MAP_MODE_SPAWN call CRA_DisplayMapCreate;
		};
	};
};
CRA_DisplayMapSelectMap = {
	params ["_display", "_pos", "_button"];
	(uiNamespace getVariable [CRA_CVAR_DISPLAY_MAP_ICON, []]) params [["_iconTele", ""], ["_iconPara", ""]];
	
	private _mode = uiNamespace getVariable [CRA_CVAR_DISPLAY_MAP_MODE, -1];
	
	if (_button == 1) exitWith {
		if (_mode == CRA_DISPLAY_MAP_MODE_TELEPORT) exitWith {};
		private _dir = (lRA_PlayerParadrop#0) getDir _pos;
		lRA_PlayerParadrop set [1, _dir];
		[_iconPara, _dir] call CRQ_fnc_UI_MapIconSetDir;
	};
	
	if (_mode == CRA_DISPLAY_MAP_MODE_PARADROP) exitWith {
		lRA_PlayerParadrop set [0, _pos];
		[_iconPara, _pos] call CRQ_fnc_UI_MapIconSetPos;
	};
	
	private _destinations = uiNamespace getVariable [CRA_CVAR_DISPLAY_MAP_DATA, []];
	private _candidates = [];
	{
		if (_x != -1) then {
			private _distance = _pos distance2D (pRA_Locations#_x#1);
			if (_distance < CRA_DISPLAY_MAP_CAPTURE_CLICK) then {_candidates pushBack [_distance, _forEachIndex, _x];};
		};
	} forEach _destinations;
	
	if (_candidates isNotEqualTo []) then {
		_candidates sort true;
		[_display, (_candidates#0#1)] call CRQ_fnc_UI_MapIndex;
	} else {
		if (_mode == CRA_DISPLAY_MAP_MODE_TELEPORT) exitWith {};
		lRA_PlayerParadrop set [0, _pos];
		[_display, 0] call CRQ_fnc_UI_MapIndex;
	};
};
CRA_DisplayMapSelectList = {
	params ["_display", "_index"];
	if (_index == -1) exitWith {};
	
	private _destinations = uiNamespace getVariable [CRA_CVAR_DISPLAY_MAP_DATA, []];
	if (_destinations isEqualTo []) exitWith {};
	
	private _destIndex = _destinations#_index;
	
	(uiNamespace getVariable [CRA_CVAR_DISPLAY_MAP_ICON, []]) params [["_iconTele", ""], ["_iconPara", ""]];
	
	if (_destIndex != -1) then {
		private _pos = pRA_Locations#_destIndex#1;
		[_iconTele, CRA_DISPLAY_MAP_ICON_SHOW] call CRQ_fnc_UI_MapIconSetColor;
		[_iconPara, CRA_DISPLAY_MAP_ICON_HIDE] call CRQ_fnc_UI_MapIconSetColor;
		[_iconTele, _pos] call CRQ_fnc_UI_MapIconSetPos;
		[_display, _pos] call CRQ_fnc_UI_MapPos;
	} else {
		private _pos = lRA_PlayerParadrop#0;
		[_iconTele, CRA_DISPLAY_MAP_ICON_HIDE] call CRQ_fnc_UI_MapIconSetColor;
		[_iconPara, CRA_DISPLAY_MAP_ICON_SHOW] call CRQ_fnc_UI_MapIconSetColor;
		[_iconPara, _pos] call CRQ_fnc_UI_MapIconSetPos;
		//[_display, _pos] call CRQ_fnc_UI_MapPos;
	};
};
