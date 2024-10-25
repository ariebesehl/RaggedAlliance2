
#define CRQ_AI_SCRIPT_SOURCE "CRQ\CRQAIS.sqf " // MUST INCLUDE TRAILING WHITESPACE! (optimization)

//#define CRQ_AI_TIMEOUTS [[[4,4,4]],[[4,4,4]],[[4,4,4]],[[4,4,4]],[[4,4,4]],[[4,4,4]],[[4,4,4]],[[4,4,4]]]
#define CRQ_AI_SCRIPT_FNC [\
	"",\
	"_g call CRQ_fnc_AI_BHRG;",\
	"[_g, _v, _this#0] call CRQ_fnc_AI_BHXO;",\
	"[_g, _this#0] call CRQ_fnc_AI_BHRS;",\
	"_g call CRQ_fnc_AI_STOP;",\
	"[_g, _v, _this#0] call CRQ_fnc_AI_BHLK;",\
	"_g call CRQ_fnc_AI_BHBN;",\
	"[_g, _v, _this#0] call CRQ_fnc_AI_BHRT;"\
]
#define CRQ_AI_TIMEOUTS [\
	[[2,6,10],[4,12,20],[8,16,24]],\
	[[3,4,5],[5,8,12],[10,15,20]],\
	[[3,5,9],[6,8,16],[12,18,24]],\
	[[10,16,18],[8,16,24],[12,15,30]],\
	[[2,5,8],[9,13,16],[12,16,18]],\
	[[1,2,4],[2,4,16],[4,8,16]],\
	[[1,2,4],[2,4,16]],\
	[[4,10,16],[8,12,24],[12,16,32]]\
]
#define CRQ_AI_TIMEOUT_COMBAT [[8,16,24],[12,16,24],[16,32,48],[32,48,64]]
#define CRQ_AI_MODES ["UNCHANGED","STEALTH","COMBAT","AWARE","SAFE","CARELESS"]
#define CRQ_AI_SPEEDS ["UNCHANGED","NORMAL","FULL","LIMITED"]
#define CRQ_AI_FORM_LIST ["UNCHANGED","COLUMN","STAG COLUMN","WEDGE","ECH LEFT","ECH RIGHT","VEE","LINE","FILE","DIAMOND"]

#define CRQ_AI_SCRIPT_RESTART -1
#define CRQ_AI_SCRIPT_WAIT 0
#define CRQ_AI_SCRIPT_REGROUP 1
#define CRQ_AI_SCRIPT_SCATTER 2
#define CRQ_AI_SCRIPT_REST 3
#define CRQ_AI_SCRIPT_STOP 4
#define CRQ_AI_SCRIPT_LOOK 5
#define CRQ_AI_SCRIPT_BINO 6
#define CRQ_AI_SCRIPT_RETURN 7

#define CRQ_AI_F_RAND -1
#define CRQ_AI_F_NULL 0
#define CRQ_AI_F_COLUMN 1
#define CRQ_AI_F_STAG_COLUMN 2
#define CRQ_AI_F_WEDGE 3
#define CRQ_AI_F_ECH_LEFT 4
#define CRQ_AI_F_ECH_RIGHT 5
#define CRQ_AI_F_ECH_VEE 6
#define CRQ_AI_F_LINE 7
#define CRQ_AI_F_FILE 8
#define CRQ_AI_F_DIAMOND 9

#define CRQ_AI_M_RAND -1
#define CRQ_AI_M_NULL 0
#define CRQ_AI_M_STEALTH 1
#define CRQ_AI_M_COMBAT 2
#define CRQ_AI_M_AWARE 3
#define CRQ_AI_M_SAFE 4
#define CRQ_AI_M_CARELESS 5

#define CRQ_AI_S_RAND -1
#define CRQ_AI_S_NULL 0
#define CRQ_AI_S_NORMAL 1
#define CRQ_AI_S_FULL 2
#define CRQ_AI_S_LIMITED 3

#define CRQ_AI_RADIUS_MOVE_INFANTRY 3
#define CRQ_AI_RADIUS_MOVE_VEHICLE 24

#define CRQ_AI_PATTERN_GARRISON [\
[CRQ_AI_SCRIPT_SCATTER,CRQ_AI_SCRIPT_WAIT,CRQ_AI_SCRIPT_REST,CRQ_AI_SCRIPT_WAIT,CRQ_AI_SCRIPT_REST,CRQ_AI_SCRIPT_WAIT,CRQ_AI_SCRIPT_RETURN,CRQ_AI_SCRIPT_REGROUP]]

#define CRQ_AI_PATTERN_SPOT [\
[CRQ_AI_SCRIPT_LOOK,CRQ_AI_SCRIPT_RESTART]]

#define CRQ_AI_PATTERN_PATROL [\
[CRQ_AI_SCRIPT_WAIT,CRQ_AI_SCRIPT_SCATTER,CRQ_AI_SCRIPT_SCATTER,CRQ_AI_SCRIPT_REGROUP],\
[CRQ_AI_SCRIPT_SCATTER,CRQ_AI_SCRIPT_REST,CRQ_AI_SCRIPT_REGROUP],\
[CRQ_AI_SCRIPT_WAIT,CRQ_AI_SCRIPT_WAIT,CRQ_AI_SCRIPT_REGROUP],\
[CRQ_AI_SCRIPT_WAIT,CRQ_AI_SCRIPT_REST,CRQ_AI_SCRIPT_REST,CRQ_AI_SCRIPT_REGROUP],\
[CRQ_AI_SCRIPT_SCATTER,CRQ_AI_SCRIPT_SCATTER,CRQ_AI_SCRIPT_SCATTER,CRQ_AI_SCRIPT_REGROUP]]

#define CRQ_AI_PATTERN_VEHICLE [\
[CRQ_AI_SCRIPT_WAIT,CRQ_AI_SCRIPT_WAIT,CRQ_AI_SCRIPT_WAIT],\
[CRQ_AI_SCRIPT_WAIT,CRQ_AI_SCRIPT_WAIT],\
[CRQ_AI_SCRIPT_WAIT]]
