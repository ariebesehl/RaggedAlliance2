
#ifdef CRA_DBG_ENABLE
#define CRA_LC_HIDE "Name"
#else
#define CRA_LC_HIDE "Invisible"
#endif
#define CRA_LC_REJUVENATION 0.01 // TODO: reimplement?

// TODO replace these with individual prox values derived from base size (might need to check back with depot sizing?)
#define CRA_LC_PROX_DEPOT 5 // D308: "YOLO"
#define CRA_LC_PROX_LOCATION 250
#define CRA_LC_PROX_ROADBLOCK 550
#define CRA_LC_PROX_OUTPOST 450

#define CRA_LC_VALUE_HIGH 12
#define CRA_LC_VALUE_MED 6
#define CRA_LC_VALUE_LOW 3
#define CRA_LC_VALUE_NONE 0

#define CRA_LC_CAPT_NONE [CRQ_SD_CIV]
#define CRA_LC_CAPT_SIDE [CRQ_SD_BLU,CRQ_SD_IND,CRQ_SD_OPF]
#define CRA_LC_CAPT_ALL [CRQ_SD_BLU,CRQ_SD_IND,CRQ_SD_OPF,CRQ_SD_CIV]

#define CRA_LC_LBL_NONE ""
#define CRA_LC_LBL_ROAD "Checkpoint"
#define CRA_LC_LBL_POST "Outpost"
#define CRA_LC_LBL_DEPO "Depot"
#define CRA_LC_LBL_BASE "Base"

#define CRA_LC_MRKR_NONE   []
#define CRA_LC_MRKR_BASE   ["b_hq","n_hq","o_hq","c_unknown"]
#define CRA_LC_MRKR_ROAD   ["b_recon","n_recon","o_recon","c_unknown"]
#define CRA_LC_MRKR_POST   ["b_support","n_support","o_support","c_unknown"]
#define CRA_LC_MRKR_DWHEEL ["b_motor_inf","n_motor_inf","o_motor_inf","c_car"]
#define CRA_LC_MRKR_DTRACK ["b_armor","n_armor","o_armor","c_car"]
#define CRA_LC_MRKR_DWING  ["b_plane","n_plane","o_plane","c_plane"]
#define CRA_LC_MRKR_DBOAT  ["b_naval","n_naval","o_naval","c_ship"]
#define CRA_LC_MRKR_DROTOR ["b_air","n_air","o_air","c_air"]

#define CRA_LC_ID_PREFIX "CRA_"
#define CRA_LC_ID_BASE (CRA_LC_ID_PREFIX + "HQ_")
#define CRA_LC_ID_ROAD (CRA_LC_ID_PREFIX + "RB_")
#define CRA_LC_ID_DEPO (CRA_LC_ID_PREFIX + "DP_")
#define CRA_LC_ID_POST (CRA_LC_ID_PREFIX + "OP_")
#define CRA_LC_FNC_ID_BASE {CRA_LC_ID_BASE + (_this select 0)}
#define CRA_LC_FNC_ID_ROAD {CRA_LC_ID_ROAD + (_this select 0)}
#define CRA_LC_FNC_ID_POST {CRA_LC_ID_POST + (_this select 0)}
#define CRA_LC_FNC_ID_DEPO {CRA_LC_ID_DEPO + (_this select 0)}
#define CRA_LC_FNC_LBL_NONE {""} // TODO: Determine whether, philosophically, the contents should actually be CRA_LC_LBL_NONE or remain ""
#define CRA_LC_FNC_LBL_BASE {(_this select 1) + " [HQ]"}
#define CRA_LC_FNC_LBL_ROAD {CRA_LC_LBL_ROAD + " [" + (mapGridPosition (_this select 3 select 0)) + "]"}
#define CRA_LC_FNC_LBL_POST {CRA_LC_LBL_POST + " [" + (mapGridPosition (_this select 3 select 0)) + "]"}
#define CRA_LC_FNC_LBL_DEPO {CRA_LC_LBL_DEPO}
#define CRA_LC_FNC_MRKR_BASE CRA_LC_FNC_LBL_NONE
#define CRA_LC_FNC_MRKR_POST CRA_LC_FNC_LBL_ROAD
#define CRA_LC_FNC_MRKR_ROAD CRA_LC_FNC_LBL_POST
#define CRA_LC_FNC_MRKR_DEPO CRA_LC_FNC_LBL_NONE
#define CRA_LC_FNC_MAIN_NONE [{},{},{}] // ENTER, ACTIVE, LEAVE
#define CRA_LC_FNC_MAIN_BASE [{_this call CRA_LocationBaseEnter},{_this call CRA_LocationBaseActive},{_this call CRA_LocationBaseLeave}]
#define CRA_LC_FNC_MAIN_DEPO [{_this call CRA_LocationDepotEnter},{_this call CRA_LocationDepotActive},{_this call CRA_LocationDepotLeave}]
#define CRA_LC_FNC_TRIG_NONE [] // ACTIVITY, TRIGGER (-1: always, 0: disabled, 1: once, 2: twice, 3: thrice, etc.), CODE // D308: Not sure that comment makes sense?
#define CRA_LC_FNC_TRIG_BASE [[1,{(_this select 1) >= 1},{[_this,false] call CRA_LocationDiscover}]]
#define CRA_LC_FNC_TRIG_ROAD [[1,{(_this select 1) >= 8},{[_this,false] call CRA_LocationDiscover}]]
#define CRA_LC_FNC_TRIG_POST [[1,{(_this select 1) >= 8},{[_this,false] call CRA_LocationDiscover}]]
#define CRA_LC_FNC_TRIG_DEPO [[1,{(_this select 1) >= 1},{[_this, true] call CRA_LocationDiscover}]]

#define CRA_LC_PERS_CAPITAL  [[2.00,1,1.50],[-1,-1,3,1,-1]]
#define CRA_LC_PERS_CITY     [[1.00,1,0.75],[-1,-1,3,1,-1]]
#define CRA_LC_PERS_VILLAGE  [[0.60,1,0.75],[-1,-1,2,1,-1]]
#define CRA_LC_PERS_LOCALITY [[0.40,1,0.75],[-1,-1,2,1,-1]]
#define CRA_LC_PERS_AIRPORT  [[0.80,1,0.75],[-1,-1,3,1,-1]]
#define CRA_LC_PERS_ROAD     [[0.40,1,0.75],[-1,-1,1,0,-1]]
#define CRA_LC_PERS_POST     [[0.40,1,0.75],[-1,-1,1,0,-1]]
#define CRA_LC_PERS_DEPO     []

#define CRA_LC_BASE_CAPITAL  [123,[CRA_BASES_CITY,(CRA_BASES_INDUSTRY_L + CRA_BASES_MISC_L), CRA_BASES_HOUSE_L,CRA_BASES_GENERIC_L]]
#define CRA_LC_BASE_CITY     [123,[(CRA_BASES_CITY + CRA_BASES_INDUSTRY_L + CRA_BASES_MISC_L + CRA_BASES_HOUSE_L),(CRA_BASES_HOUSE_S + CRA_BASES_HOUSE_S),CRA_BASES_GENERIC_L]]
#define CRA_LC_BASE_VILLAGE  [123,[(CRA_BASES_MISC_L + CRA_BASES_HOUSE_L + CRA_BASES_HOUSE_S),CRA_BASES_INDUSTRY_L + CRA_BASES_INDUSTRY_S,CRA_BASES_GENERIC_S]]
#define CRA_LC_BASE_LOCALITY [123,[(CRA_BASES_INDUSTRY_L + CRA_BASES_INDUSTRY_S + CRA_BASES_MISC_L + CRA_BASES_MISC_S),(CRA_BASES_CITY + CRA_BASES_HOUSE_L + CRA_BASES_HOUSE_S),CRA_BASES_GENERIC_S]]
#define CRA_LC_BASE_AIRPORT  [123,[CRA_BASES_AIRPORT,(CRA_BASES_CITY + CRA_BASES_MISC_L + CRA_BASES_INDUSTRY_L),CRA_BASES_GENERIC_L]]
#define CRA_LC_BASE_ROAD     [122,[CRA_BASES_ROADBLOCK]]
#define CRA_LC_BASE_POST     [122,[CRA_BASES_HOUSE_S,CRA_BASES_MISC_S]]
#define CRA_LC_BASE_DEPO     [  0,[]]

#define CRA_LC_TYPE_CAPITAL 0
#define CRA_LC_TYPE_CITY 1
#define CRA_LC_TYPE_VILLAGE 2
#define CRA_LC_TYPE_LOCALITY 3
#define CRA_LC_TYPE_AIRPORT 4
#define CRA_LC_TYPE_ROADBLOCK 5
#define CRA_LC_TYPE_OUTPOST 6
#define CRA_LC_TYPE_DWHEEL 7
#define CRA_LC_TYPE_DTRACK 8
#define CRA_LC_TYPE_DWING 9
#define CRA_LC_TYPE_DBOAT 10
#define CRA_LC_TYPE_DROTOR 11

#define CRA_LC_CFG_CAPITAL  [CRA_LC_HIDE,CRA_LC_LBL_BASE,CRA_LC_FNC_ID_BASE,CRA_LC_FNC_LBL_BASE, -1,CRA_LC_VALUE_HIGH,CRA_LC_CAPT_SIDE,CRA_LC_MRKR_BASE,CRA_LC_FNC_MRKR_BASE]
#define CRA_LC_CFG_CITY     [CRA_LC_HIDE,CRA_LC_LBL_BASE,CRA_LC_FNC_ID_BASE,CRA_LC_FNC_LBL_BASE, -1,CRA_LC_VALUE_MED, CRA_LC_CAPT_SIDE,CRA_LC_MRKR_BASE,CRA_LC_FNC_MRKR_BASE]
#define CRA_LC_CFG_VILLAGE  [CRA_LC_HIDE,CRA_LC_LBL_BASE,CRA_LC_FNC_ID_BASE,CRA_LC_FNC_LBL_BASE, -1,CRA_LC_VALUE_LOW, CRA_LC_CAPT_SIDE,CRA_LC_MRKR_BASE,CRA_LC_FNC_MRKR_BASE]
#define CRA_LC_CFG_LOCALITY [CRA_LC_HIDE,CRA_LC_LBL_BASE,CRA_LC_FNC_ID_BASE,CRA_LC_FNC_LBL_BASE, -1,CRA_LC_VALUE_LOW, CRA_LC_CAPT_SIDE,CRA_LC_MRKR_BASE,CRA_LC_FNC_MRKR_BASE]
#define CRA_LC_CFG_AIRPORT  [CRA_LC_HIDE,CRA_LC_LBL_BASE,CRA_LC_FNC_ID_BASE,CRA_LC_FNC_LBL_BASE, -1,CRA_LC_VALUE_HIGH,CRA_LC_CAPT_SIDE,CRA_LC_MRKR_BASE,CRA_LC_FNC_MRKR_BASE]
#define CRA_LC_CFG_ROAD     [CRA_LC_HIDE,CRA_LC_LBL_ROAD,CRA_LC_FNC_ID_ROAD,CRA_LC_FNC_LBL_ROAD,100,CRA_LC_VALUE_NONE,CRA_LC_CAPT_NONE,CRA_LC_MRKR_ROAD,CRA_LC_FNC_MRKR_ROAD]
#define CRA_LC_CFG_POST     [CRA_LC_HIDE,CRA_LC_LBL_POST,CRA_LC_FNC_ID_POST,CRA_LC_FNC_LBL_POST,100,CRA_LC_VALUE_NONE,CRA_LC_CAPT_NONE,CRA_LC_MRKR_POST,CRA_LC_FNC_MRKR_POST]
#define CRA_LC_CFG_DWHEEL   [CRA_LC_HIDE,CRA_LC_LBL_DEPO,CRA_LC_FNC_ID_DEPO,CRA_LC_FNC_LBL_DEPO,  0,CRA_LC_VALUE_NONE,CRA_LC_CAPT_NONE,CRA_LC_MRKR_DWHEEL,CRA_LC_FNC_MRKR_DEPO]
#define CRA_LC_CFG_DTRACK   [CRA_LC_HIDE,CRA_LC_LBL_DEPO,CRA_LC_FNC_ID_DEPO,CRA_LC_FNC_LBL_DEPO,  0,CRA_LC_VALUE_NONE,CRA_LC_CAPT_NONE,CRA_LC_MRKR_DTRACK,CRA_LC_FNC_MRKR_DEPO]
#define CRA_LC_CFG_DWING    [CRA_LC_HIDE,CRA_LC_LBL_DEPO,CRA_LC_FNC_ID_DEPO,CRA_LC_FNC_LBL_DEPO,  0,CRA_LC_VALUE_NONE,CRA_LC_CAPT_NONE,CRA_LC_MRKR_DWING,CRA_LC_FNC_MRKR_DEPO]
#define CRA_LC_CFG_DBOAT    [CRA_LC_HIDE,CRA_LC_LBL_DEPO,CRA_LC_FNC_ID_DEPO,CRA_LC_FNC_LBL_DEPO,  0,CRA_LC_VALUE_NONE,CRA_LC_CAPT_NONE,CRA_LC_MRKR_DBOAT,CRA_LC_FNC_MRKR_DEPO]
#define CRA_LC_CFG_DROTOR   [CRA_LC_HIDE,CRA_LC_LBL_DEPO,CRA_LC_FNC_ID_DEPO,CRA_LC_FNC_LBL_DEPO,  0,CRA_LC_VALUE_NONE,CRA_LC_CAPT_NONE,CRA_LC_MRKR_DROTOR,CRA_LC_FNC_MRKR_DEPO]

#define CRA_LC_TYPES [\
[CRA_LC_CFG_CAPITAL, [CRA_LC_FNC_MAIN_BASE,CRA_LC_FNC_TRIG_BASE], CRA_LC_PERS_CAPITAL, CRA_LC_BASE_CAPITAL],\
[CRA_LC_CFG_CITY,    [CRA_LC_FNC_MAIN_BASE,CRA_LC_FNC_TRIG_BASE], CRA_LC_PERS_CITY,    CRA_LC_BASE_CITY],\
[CRA_LC_CFG_VILLAGE, [CRA_LC_FNC_MAIN_BASE,CRA_LC_FNC_TRIG_BASE], CRA_LC_PERS_VILLAGE, CRA_LC_BASE_VILLAGE],\
[CRA_LC_CFG_LOCALITY,[CRA_LC_FNC_MAIN_BASE,CRA_LC_FNC_TRIG_BASE], CRA_LC_PERS_LOCALITY,CRA_LC_BASE_LOCALITY],\
[CRA_LC_CFG_AIRPORT, [CRA_LC_FNC_MAIN_BASE,CRA_LC_FNC_TRIG_BASE], CRA_LC_PERS_AIRPORT, CRA_LC_BASE_AIRPORT],\
[CRA_LC_CFG_ROAD,    [CRA_LC_FNC_MAIN_BASE,CRA_LC_FNC_TRIG_ROAD], CRA_LC_PERS_ROAD,    CRA_LC_BASE_ROAD],\
[CRA_LC_CFG_POST,    [CRA_LC_FNC_MAIN_BASE,CRA_LC_FNC_TRIG_POST], CRA_LC_PERS_POST,    CRA_LC_BASE_POST],\
[CRA_LC_CFG_DWHEEL,  [CRA_LC_FNC_MAIN_DEPO,CRA_LC_FNC_TRIG_DEPO], CRA_LC_PERS_DEPO,    CRA_LC_BASE_DEPO],\
[CRA_LC_CFG_DTRACK,  [CRA_LC_FNC_MAIN_DEPO,CRA_LC_FNC_TRIG_DEPO], CRA_LC_PERS_DEPO,    CRA_LC_BASE_DEPO],\
[CRA_LC_CFG_DWING,   [CRA_LC_FNC_MAIN_DEPO,CRA_LC_FNC_TRIG_DEPO], CRA_LC_PERS_DEPO,    CRA_LC_BASE_DEPO],\
[CRA_LC_CFG_DBOAT,   [CRA_LC_FNC_MAIN_DEPO,CRA_LC_FNC_TRIG_DEPO], CRA_LC_PERS_DEPO,    CRA_LC_BASE_DEPO],\
[CRA_LC_CFG_DROTOR,  [CRA_LC_FNC_MAIN_DEPO,CRA_LC_FNC_TRIG_DEPO], CRA_LC_PERS_DEPO,    CRA_LC_BASE_DEPO]]

#define CRA_LC_SCAN [\
["NameCityCapital",	[CRA_LC_TYPE_CAPITAL, [],[650,650],"",""]],\
["NameCity",		[CRA_LC_TYPE_CITY,    [],[550,550],"",""]],\
["NameVillage",		[CRA_LC_TYPE_VILLAGE, [],[325,325],"",""]],\
["NameLocal",		[CRA_LC_TYPE_LOCALITY,[],[375,375],"",""]],\
["Airport",			[CRA_LC_TYPE_AIRPORT, [],[600,600],"",""]]]
#define CRA_LC_OVERRIDE []

#define CRA_LCRB_SCAN_ATTEMPTS 25
#define CRA_LCRB_TYPES ["MAIN ROAD", "ROAD", "TRACK"]
#define CRA_LCRB_WEIGHTS [0.40, 0.25, 0.15]
#define CRA_LCRB_LENGTH 120
#define CRA_LCRB_SEGMENTS 4
#define CRA_LCRB_ANGLE 10
#define CRA_LCOP_COUNT 120