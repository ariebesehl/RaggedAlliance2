
#include "CRA__Display.hpp"
#include "CRA__Res.hpp"

#define CRA_MUSIC_INTRO_DELAY 2

#define CRA_DISPLAY_QUIT 3
#define CRA_DISPLAY_MAIL_TITLE "E-Mail"
#define CRA_DISPLAY_MAP_MODE_SPAWN 0
#define CRA_DISPLAY_MAP_MODE_TELEPORT 1
#define CRA_DISPLAY_MAP_MODE_PARADROP 2
#define CRA_DISPLAY_MAP_TITLE_SPAWN "Select Deployment"
#define CRA_DISPLAY_MAP_TITLE_TELEPORT "Select Destination"
#define CRA_DISPLAY_MAP_TITLE_PARADROP "Select Insertion"
#define CRA_DISPLAY_MAP_LABEL_PARADROP " --- Paradrop"
#define CRA_DISPLAY_MAP_CAPTURE_CLICK 100
#define CRA_DISPLAY_MAP_ICON_SHOW [0,0,0,1]
#define CRA_DISPLAY_MAP_ICON_HIDE [0,0,0,0]
#define CRA_DISPLAY_MAP_RETRIGGER 1

#define CRA_LOADING_DELAY_EXIT 2
#define CRA_LOADING_MESSAGE_INFO_BASIC "Loading:\n[%1/%2] %3"
#define CRA_LOADING_MESSAGE_INFO_PROGRESS "Loading:\n[%1/%2] %3 [%4%5]"
#define CRA_LOADING_MESSAGE_INFO_FINISH "Loading:\nDone!"
#define CRA_LOADING_MESSAGE_INFO_EXIT "Have fun!"
#define CRA_LOADING_MESSAGE_STAGES [\
"Standby...",\
"Depot Candidate",\
"Depot Object",\
"Depot Group",\
"Depot Preparation, Generated",\
"Depot Preparation, Custom",\
"Depot Creation",\
"Base Types",\
"Base Generation",\
"Road-Block Sectors",\
"Road-Block Generation",\
"Outpost Candidate",\
"Outpost Generation",\
"Synchronization"]

