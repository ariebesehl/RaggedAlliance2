
#include "CRA__Client.sqf"

gLC_PlayerMusic = objNull;

CRA_LocalIntroFirst = {
	CRA_INTRO_MUSIC_TIMESTART call CRQ_Wait;
	"introFirst" call CRA_LocalPlayerMusic;
};
CRA_LocalIntroSecond = {
	"introSecond" call CRA_LocalPlayerMusic;
};
CRA_LocalBattleWin = {
	"battleWin" call CRA_LocalPlayerMusic;
};
CRA_LocalPlayerDeath = {
	"playerDeath" call CRA_LocalPlayerMusic;
};
CRA_LocalPlayerMusic = {
	if (!isNull gLC_PlayerMusic) then {deleteVehicle gLC_PlayerMusic;};
	gLC_PlayerMusic = playSound _this;
};
CRA_LocalActionRelayTransmit = {
	_this remoteExec ["CRA_ActionRelayReceive", 2];
};