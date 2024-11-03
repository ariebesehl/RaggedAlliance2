
#include "CRA__DEF__Shared.sqf"

#include "CRA__FNC__Shared.sqf"

pRA_Themes = missionNamespace getVariable ["pRA_Themes", createHashMapFromArray CRA_THEMES];
pRA_Locations = missionNamespace getVariable ["pRA_Locations", []];
pRA_LocationSafe = missionNamespace getVariable ["pRA_LocationSafe", []];
pRA_LoadMessage = missionNamespace getVariable ["pRA_LoadMessage", 0];
pRA_LoadIndex = missionNamespace getVariable ["pRA_LoadIndex", 0];
pRA_LoadTotal = missionNamespace getVariable ["pRA_LoadTotal", 0];
pRA_Initializing = missionNamespace getVariable ["pRA_Initializing", true];
