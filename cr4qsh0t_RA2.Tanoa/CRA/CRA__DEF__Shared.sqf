
#include "CRA__DEF__Var.sqf"


#ifdef CRQ_DBG_ENABLE
#define CRA_DBG_ENABLE
#else
// #define CRA_DBG_ENABLE // TODO undefine me
#endif

#define CRA_VERSION [2024,11,05]

#define CRA_PARADROP_HEIGHT 42

#define CRA_TEXT_PARAM_PASS 0
#define CRA_TEXT_PARAM_NUMBER 1
#define CRA_TEXT_PARAM_DICT 2
#define CRA_TEXT_PARAM_PLAYER_NAME 100
#define CRA_TEXT_PARAM_SIDE 110
#define CRA_TEXT_PARAM_WORLD 120
#define CRA_TEXT_PARAM_LOCATION 121
#define CRA_TEXT_PARAM_ISO8601 130
#define CRA_TEXT_PARAM_DATE_FULL 131
#define CRA_TEXT_PARAM_DATE_SHORT 132


#define CRA_DICT_INDEX [\
"noreply@reconsvc.com",\
"info@robbybayse13E7eN3t.onion",\
"e.picadori@photon.net",\
"Enriques Picadori",\
"E. Picadori",\
"Picadori",\
"Bregavanna",\
"Bregavanna",\
"Bregavanna"\
]
#define CRA_DICT_RECONSVC_MAIL 0
#define CRA_DICT_ROBBYBAYS_MAIL 1
#define CRA_DICT_PROTAGONIST_MAIL 2
#define CRA_DICT_PROTAGONIST_FULL 3
#define CRA_DICT_PROTAGONIST_ABBR 4
#define CRA_DICT_PROTAGONIST_SHORT 5
#define CRA_DICT_ANTAGONIST_FULL 6
#define CRA_DICT_ANTAGONIST_ABBR 7
#define CRA_DICT_ANTAGONIST_SHORT 8

#define CRA_TEXT_INDEX [\
["%1", [CRA_TEXT_PARAM_PASS]],\
["%1", [CRA_TEXT_PARAM_DICT]],\
["%1: %2 are known to be present",[CRA_TEXT_PARAM_LOCATION,CRA_TEXT_PARAM_SIDE]],\
["%1: %2 have lost control",[CRA_TEXT_PARAM_LOCATION,CRA_TEXT_PARAM_SIDE]],\
["%1: %2 have gained control",[CRA_TEXT_PARAM_LOCATION,CRA_TEXT_PARAM_SIDE]],\
["%1: %2 have gained control from %3",[CRA_TEXT_PARAM_LOCATION,CRA_TEXT_PARAM_SIDE,CRA_TEXT_PARAM_SIDE]],\
["%1: This area has not been secured!",[CRA_TEXT_PARAM_LOCATION]],\
["%1: Inventory has been sorted",[CRA_TEXT_PARAM_LOCATION]],\
["%1: Items have been gathered in a %2m radius",[CRA_TEXT_PARAM_LOCATION,CRA_TEXT_PARAM_NUMBER]],\
["%1: %2x weapons, %3x mags, %4x vests/backpacks, and %5x items were added to the base's inventory box",[CRA_TEXT_PARAM_LOCATION,CRA_TEXT_PARAM_NUMBER,CRA_TEXT_PARAM_NUMBER,CRA_TEXT_PARAM_NUMBER,CRA_TEXT_PARAM_NUMBER]],\
["%1 has been secured!",[CRA_TEXT_PARAM_LOCATION]],\
["%1 has been seized!",[CRA_TEXT_PARAM_LOCATION]],\
["Good luck in %1!",[CRA_TEXT_PARAM_WORLD]],\
["I was glad to hear you have decided to take up the task and are already en route to %1. It will most certainly not be easy. %2's men are composed of some of the most elite mercenaries, the toughest veterans and some of the most savage criminals he could find from all over the world. He pays them well and they are loyal to him. He has spent years fortifying his position and training his men. Such as it is, they will not go down easily.\n\nFurthermore, despite his strong army, he focuses on protecting himself and not the country and its people, and so, crime is rampant and the drug trade is flourishing. Beware of the looters, bandits and cartells that litter the country, they will also encumber your efforts when encountered.\n\nNevertheless, I am confident you will succeed in our quest of bringing peace and prosperity to %3.\n\nI look forward to hearing of your progress.\n\nI wish you the best of luck, though of course I hope you will not need it.\n\nSincerely,\n%4",[CRA_TEXT_PARAM_WORLD,CRA_TEXT_PARAM_DICT,CRA_TEXT_PARAM_WORLD,CRA_TEXT_PARAM_DICT]],\
["%1: Location discovered", [CRA_TEXT_PARAM_LOCATION]],\
["Hello %1!", [CRA_TEXT_PARAM_PLAYER_NAME]],\
["Welcome to Ragged Alliance 2 v%1!", [CRA_TEXT_PARAM_DATE_SHORT]],\
["%1: Intel reveals within %2m there are %3", [CRA_TEXT_PARAM_LOCATION,CRA_TEXT_PARAM_NUMBER,CRA_TEXT_PARAM_PASS]],\
["%1: Intel reveals no points-of-interest within %2m", [CRA_TEXT_PARAM_LOCATION,CRA_TEXT_PARAM_NUMBER]]\
]

#define CRA_TEXT_GENERIC_PASS 0
#define CRA_TEXT_GENERIC_DICT 1
#define CRA_TEXT_EVENT_LOCATION_ANNOUNCE_FULL 2
#define CRA_TEXT_EVENT_LOCATION_LOST 3
#define CRA_TEXT_EVENT_LOCATION_CAPTURE 4
#define CRA_TEXT_EVENT_LOCATION_CAPTURE_FROM 5
#define CRA_TEXT_EVENT_LOCATION_INSECURE 6
#define CRA_TEXT_INFO_BASE_INVENTORY_SORT 7
#define CRA_TEXT_INFO_BASE_INVENTORY_GATHER 8
#define CRA_TEXT_INFO_BASE_INVENTORY_GATHER_RESULT 9
#define CRA_TEXT_NOTIFY_LOCATION_GAIN 10
#define CRA_TEXT_NOTIFY_LOCATION_LOST 11
#define CRA_TEXT_MAIL_SUBJECT_GREET 12
#define CRA_TEXT_MAIL_TEXT_GREET 13
#define CRA_TEXT_EVENT_LOCATION_ANNOUNCE_SHORT 14
#define CRA_TEXT_PLAYER_GREET 15
#define CRA_TEXT_PLAYER_VERSION 16
#define CRA_TEXT_INFO_INTEL_GATHER 17
#define CRA_TEXT_INFO_INTEL_NONE 18

// CRA__Theme.sqf
// ARMA
#define CRA_RADEF_TRACKS_STEALTH ["LeadTrack01c_F", "LeadTrack06_F", "LeadTrack04_F", "LeadTrack04a_F", "LeadTrack02_F", "AmbientTrack04_F", "AmbientTrack04a_F", "AmbientTrack01a_F"]
#define CRA_RADEF_TRACKS_COMBAT ["LeadTrack01c_F", "LeadTrack06_F", "LeadTrack04_F", "LeadTrack04a_F", "LeadTrack03_F", "LeadTrack05_F"] //, "LeadTrack01_F_Orange"]
#define CRA_RADEF_TRACKS_SAFE ["AmbientTrack03_F", "AmbientTrack04a_F", "BackgroundTrack01_F", "BackgroundTrack02_F", "BackgroundTrack01a_F", "BackgroundTrack03_F"]
#define CRA_RADEF_TRACKS_UI CRA_RADEF_TRACKS_SAFE
#define CRA_RADEF_NAME "Arma 3"
// "ALASKAN GLITCH" https://steamcommunity.com/app/107410/discussions/0/143387886728301734/#c2993171056503664166
#define CRA_AGLT_TRACKS_STEALTH ["Track11_StageB_stealth", "BackgroundTrack01_F_EPB"]
#define CRA_AGLT_TRACKS_COMBAT ["Track_O_16", "LeadTrack05_F", "Track10_StageB_action"] 
#define CRA_AGLT_TRACKS_SAFE ["Track_C_03", "Track_C_12", "Track_C_20", "Track_O_08"] 
#define CRA_AGLT_TRACKS_UI CRA_AGLT_TRACKS_SAFE
#define CRA_AGLT_NAME "Alaskan Glitch"
// ORIGINAL
#define CRA_ORIG_TRACKS_STEALTH ["CRA_RES_MUSIC_ORIG_MODE_STEALTH_A", "CRA_RES_MUSIC_ORIG_MODE_STEALTH_B", "CRA_RES_MUSIC_ORIG_MODE_STEALTH_C"]
#define CRA_ORIG_TRACKS_COMBAT ["CRA_RES_MUSIC_ORIG_MODE_COMBAT_A"]
#define CRA_ORIG_TRACKS_SAFE ["CRA_RES_MUSIC_ORIG_MODE_SAFE_A", "CRA_RES_MUSIC_ORIG_MODE_SAFE_B", "CRA_RES_MUSIC_ORIG_MODE_SAFE_C", "CRA_RES_MUSIC_ORIG_MODE_SAFE_D"]
#define CRA_ORIG_TRACKS_UI ["CRA_RES_MUSIC_ORIG_UI"]
#define CRA_ORIG_NAME "Original"

#define CRA_THEME_NONE ["None", ["", "", ""]]

#define CRA_THEMES [\
	["NULL", CRA_THEME_NONE],\
	["ARMA", [CRA_RADEF_NAME, [CRA_RADEF_TRACKS_STEALTH, CRA_RADEF_TRACKS_COMBAT, CRA_RADEF_TRACKS_SAFE]]],\
	["AGLT", [CRA_AGLT_NAME, [CRA_AGLT_TRACKS_STEALTH, CRA_AGLT_TRACKS_COMBAT, CRA_AGLT_TRACKS_SAFE]]],\
	["ORIG", [CRA_ORIG_NAME, [CRA_ORIG_TRACKS_STEALTH, CRA_ORIG_TRACKS_STEALTH + CRA_ORIG_TRACKS_COMBAT, CRA_ORIG_TRACKS_UI + CRA_ORIG_TRACKS_SAFE]]]\
]
//#define CRA_THEME_TRACKS CRA_RADEF_TRACKS
