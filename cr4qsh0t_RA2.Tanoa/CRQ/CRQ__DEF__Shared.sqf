
#define CRQ_VERSION [2024,12,02]
//#define CRQ_DBG_ENABLE // TODO Undefine me!

#define CRQ__BISIDE(INPUT) (INPUT call {\
	if (_this isEqualType -1) exitWith {if (_this < 0) then {sideUnknown} else {CRQ_SD_TYPES select _this};};\
	if (_this isEqualType objNull || {_this isEqualType grpNull || {_this isEqualType locationNull}}) exitWith {side _this};\
	if (_this isEqualType sideUnknown) exitWith {_this};\
	sideUnknown\
})

#define CRQ_STRING(TEXT) #TEXT

#define CRQ_BS_DWRD [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31]
#define CRQ_BS_WORD [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]
#define CRQ_BS_BYTE [0,1,2,3,4,5,6,7]
#define CRQ_BS_CRC_IV 13337
#define CRQ_BS_CRC_MOD 65536
#define CRQ_BS_TM_WAIT 0.125
#define CRQ_BS_TM_SYNC 0.125

#define CRQ_UT_VU_RADIUS 50
#define CRQ_UT_VU_RESOLUTION 5
#define CRQ_UT_VU_ATTEMPTS_FIND 8
#define CRQ_UT_VU_ATTEMPTS_EMPTY 1024
#define CRQ_VU_PABS 0
#define CRQ_VU_PREL 1
#define CRQ_VU_PVEC 2
#define CRQ_VU_PVTL 3
#define CRQ_VU_PVWL 4
#define CRQ_VU_PFND 5
#define CRQ_VU_PEMP 6
#define CRQ_VU_PHSE 7
#define CRQ_VU_DABS 0
#define CRQ_VU_DREL 1
#define CRQ_VU_DRND 2
#define CRQ_VU_DROD 3

#define CRQ_SD_TYPES [blufor,independent,opfor,civilian]
#define CRQ_SD_UNKNOWN -1
#define CRQ_SD_BLU 0
#define CRQ_SD_IND 1
#define CRQ_SD_OPF 2
#define CRQ_SD_CIV 3
#define CRQ_SD_LEVEL_NEUTRAL 0.6
#define CRQ_SD_LEVEL_FRIEND 0.8
#define CRQ_SD_REL_HOSTILE 0
#define CRQ_SD_REL_NEUTRAL 1
#define CRQ_SD_REL_FRIENDLY 2

#define CRQ_CLASS_VEHICLE ["car","tank","helicopter","plane","ship"]

#define CRQ_LC_CLASS "Invisible"
#define CRQ_LC_SIZE [25,25]

#define CRQ_EN_LT_POS [0,0,0]
#define CRQ_EN_LT_SWITCH 0.7

#define CRQ_PT_RD_SEGMENTATION 8
#define CRQ_PT_FL_ALTITUDE 50
#define CRQ_PT_FL_ANGLE 30

#define CRQ_OBJ_DUMMY_POS [0,0,0]
#define CRQ_OBJ_COLLISION 0.01
#define CRQ_OBJ_CLUTTER 50

#define CRQ_PL_TRAITS ["medic","engineer","explosiveSpecialist","UAVHacker"]

#define CRQ_CREW_COMMANDER 0
#define CRQ_CREW_GUNNER 1
#define CRQ_CREW_DRIVER 2
#define CRQ_CREW_CARGO 3
#define CRQ_CREW_TURRET 4

#define CRQ_WP_RD_SPACING 3
#define CRQ_WP_RD_ANALYSIS 3 // NO LESS THAN 1
#define CRQ_WP_RD_ANGLE_MIN 45

#define CRQ_LNK_NONE createHashMap
#define CRQ_mac_LNK_ANSI_0(ID) (toLowerANSI (ID))
#define CRQ_mac_LNK_ANSI_1(ID) ID = CRQ_mac_LNK_ANSI_0(ID)

#define CRQ_TERRAIN_TRAVERSE -0.421
#define CRQ_TERRAIN_RESOLUTION 100
