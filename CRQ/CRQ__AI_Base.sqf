
#define CRQ_AIVAR_ORGANIZED "CRQ_AIVAR_000"
#define CRQ_AI_RESTART_DELAY 1
#define CRQ_AI_TIMEOUT_COMBAT [[8,16,24],[12,16,24],[16,32,48],[32,48,64]]
#define CRQ_AI_TIMEOUTS [\
[[2,6,10],[4,12,20],[8,16,24]],\
[[3,4,5],[5,8,12],[10,15,20]],\
[[3,5,9],[6,8,16],[12,18,24]],\
[[10,16,18],[8,16,24],[12,15,30]],\
[[2,5,8],[9,13,16],[12,16,18]],\
[[1,2,4],[2,4,16],[4,8,16]],\
[[1,2,4],[2,4,16]],\
[[4,10,16],[8,12,24],[12,16,32]]]
//#define CRQ_AI_TIMEOUTS [[[4,4,4]],[[4,4,4]],[[4,4,4]],[[4,4,4]],[[4,4,4]],[[4,4,4]],[[4,4,4]],[[4,4,4]]]
//changing either FORM or MODE from "UNCHANGED" to "NO CHANGE" will cause game crash via division by zero
#define CRQ_AI_MODE_UNCHANGED 0
#define CRQ_AI_MODES ["UNCHANGED","STEALTH","COMBAT","AWARE","SAFE","CARELESS"]
#define CRQ_AI_SPEED_UNCHANGED 0
#define CRQ_AI_SPEEDS ["UNCHANGED","NORMAL","FULL","LIMITED"]
#define CRQ_AI_FORM_RANDOM -1
#define CRQ_AI_FORM_UNCHANGED 0
#define CRQ_AI_FORM_LIST ["UNCHANGED","COLUMN","STAG COLUMN","WEDGE","ECH LEFT","ECH RIGHT","VEE","LINE","FILE","DIAMOND"]
#define CRQ_AI_FORM_WEIGHT [0.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0]
#define CRQ_AI_REGROUP_FORM_PROB 0.5
#define CRQ_AI_SCATTER_PROB 0.5
#define CRQ_AI_SCATTER_DIST [2,16,30]
#define CRQ_AI_REST_PROB 0.5
#define CRQ_AI_LOOK_DIST [25,125,225]
#define CRQ_AI_LOOK_DIR [-360,0,360]
#define CRQ_AI_RETURN_PROB 0.5
#define CRQ_AI_RETURN_SCATTER_0 -2.5
#define CRQ_AI_RETURN_SCATTER_1 5
