
#include "CRA__DEF__Display.hpp"
#include "CRA__DEF__Res.hpp"

#define CRA_SOUND_UI_GRACE 0.125
#define CRA_MUSIC_JUKEBOX_PARAM [0.421, 2.4, 480, 2.4, false] // volume (0.2), fadein/out (5), ao-radius (500), checktime (5), norepeat (true)

#define CRA_DISPLAY_QUIT 3
#define CRA_DISPLAY_MAIL_TITLE "Mail"
#define CRA_DISPLAY_MAP_MODE_SPAWN 0
#define CRA_DISPLAY_MAP_MODE_TELEPORT 1
#define CRA_DISPLAY_MAP_MODE_PARADROP 2
#define CRA_DISPLAY_MAP_TITLE_SPAWN ["Spawn", "Select spawn location from list or LMB on empty area to set paradrop location, RMB to set direction/move map, MWHEEL to zoom."]
#define CRA_DISPLAY_MAP_TITLE_TELEPORT ["Teleport", "Select destination from list or map, RMB to move map, MWHEEL to zoom."]
#define CRA_DISPLAY_MAP_TITLE_PARADROP ["Paradrop", "Select location, LMB to place, RMB to set direction/move map, MWHEEL to zoom."]
#define CRA_DISPLAY_MAP_LABEL_PARADROP "[--- Paradrop ---]"
#define CRA_DISPLAY_MAP_CAPTURE_CLICK 100
#define CRA_DISPLAY_MAP_ICON_SHOW [0,0,0,1]
#define CRA_DISPLAY_MAP_ICON_HIDE [0,0,0,0]
#define CRA_DISPLAY_MAP_RETRIGGER 0.125

#define CRA_LOADING_DELAY_EXIT 2
#define CRA_LOADING_MESSAGE_STAGES ["Standby...","Topography Analysis","Topography Finalization","World Structures","Depot Candidate","Depot Object","Depot Group","Depot Preparation, Generated","Depot Preparation, Custom","Depot Creation","Base Types","Base Generation","Road-Block Sectors","Road-Block Generation","Outpost Candidate","Outpost Generation","Synchronization"]
#define CRA_LOADING_MESSAGE_INFO_BASIC "Loading: [%1/%2] %3"
#define CRA_LOADING_MESSAGE_INFO_PROGRESS "Loading: [%1/%2] %3 [%4%5]"
#define CRA_LOADING_MESSAGE_INFO_FINISH "Loading: Done!"
#define CRA_LOADING_MESSAGE_INFO_EXIT "Have fun!"
