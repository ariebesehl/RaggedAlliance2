
#define CRQ__BISIDE(INPUT) (INPUT call {\
	if (_this isEqualType -1) exitWith {if (_this < 0) then {sideUnknown} else {CRQ_SIDES select _this};};\
	if (_this isEqualType objNull || {_this isEqualType grpNull || {_this isEqualType locationNull}}) exitWith {side _this};\
	if (_this isEqualType sideUnknown) exitWith {_this};\
	sideUnknown\
})

#define CRQ_STRING(TEXT) #TEXT

#define CRQ_BS_DWRD [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31]
#define CRQ_BS_WORD [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]
#define CRQ_BS_BYTE [0,1,2,3,4,5,6,7]

#define CRQ_CRC_INIT 13337
#define CRQ_CRC_MODULO 65536

#define CRQ_TIME_WAIT 0.125
#define CRQ_TIME_SYNC 0.125

#define CRQ_VU_RADIUS 50
#define CRQ_VU_RESOLUTION 5
#define CRQ_VU_ATTEMPTS_FIND 8
#define CRQ_VU_ATTEMPTS_EMPTY 1024

#define CRQ_VUP_ABS 0
#define CRQ_VUP_REL 1
#define CRQ_VUP_VEC 2
#define CRQ_VUP_VEC_GROUND 3
#define CRQ_VUP_VEC_LEVEL 4
#define CRQ_VUP_FIND 5
#define CRQ_VUP_EMPTY 6
#define CRQ_VUP_HOUSE 7

#define CRQ_VUD_ABS 0
#define CRQ_VUD_REL 1
#define CRQ_VUD_RANDOM 2
#define CRQ_VUD_ROAD 3

#define CRQ_CLUTTER_EXTRA 50
#define CRQ_COLLISION_RES 0.01

#define CRQ_SIDE_UNKNOWN -1
#define CRQ_SIDE_BLUFOR 0
#define CRQ_SIDE_IDFOR 1
#define CRQ_SIDE_OPFOR 2
#define CRQ_SIDE_CIVFOR 3
#define CRQ_SIDES [blufor,independent,opfor,civilian]

#define CRQ_RELATIONS_NEUTRAL 0.6
#define CRQ_RELATIONS_FRIEND 0.8

#define CRQ_RELATION_HOSTILE 0
#define CRQ_RELATION_NEUTRAL 1
#define CRQ_RELATION_FRIENDLY 2

#define CRQ_CLASS_VEHICLE ["car","tank","helicopter","plane","ship"]

#define CRQ_CREW_COMMANDER 0
#define CRQ_CREW_GUNNER 1
#define CRQ_CREW_DRIVER 2
#define CRQ_CREW_CARGO 3
#define CRQ_CREW_TURRET 4

#define CRQ_LIGHT_POS [0,0,0]
#define CRQ_LIGHT_THOLD 0.7
#define CRQ_POS_DUMMY [0,0,0]

#define CRQ_LOCATION_TYPE "Invisible"
#define CRQ_LOCATION_SIZE [25,25]

#define CRQ_FLIGHT_ALTITUDE 50
#define CRQ_FLIGHT_ANGLE 30

#define CRQ_ROAD_PATH_SEGMENTATION 8
#define CRA_ROAD_WAYPOINT_SPACING 3
#define CRA_ROAD_WAYPOINT_ANALYSIS 3 // NO LESS THAN 1
#define CRA_ROAD_WAYPOINT_ANGLE_MIN 45
