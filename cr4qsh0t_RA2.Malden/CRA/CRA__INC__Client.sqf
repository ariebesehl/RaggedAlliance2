
#include "CRA__DEF__Client.sqf"

#include "CRA__FNC__Client.sqf"

dCRA_TEXT_INDEX = missionNamespace getVariable ["dCRA_TEXT_INDEX", CRA_TEXT_INDEX];

lRA_PlayerTheme = missionNamespace getVariable ["lRA_PlayerTheme", "ORIG"];
lRA_MusicPlayer = missionNamespace getVariable ["lRA_MusicPlayer", scriptNull];
lRA_SoundUI = missionNamespace getVariable ["lRA_SoundUI", createHashMap];
lRA_DisplayLaptopInit = missionNamespace getVariable ["lRA_DisplayLaptopInit", -1];
lRA_PlayerParadrop = missionNamespace getVariable ["lRA_PlayerParadrop", []];
