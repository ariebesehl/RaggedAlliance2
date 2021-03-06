
#define CRQ_AI_SCRIPT_RESTART -1
#define CRQ_AI_SCRIPT_WAIT 0
#define CRQ_AI_SCRIPT_REGROUP 1
#define CRQ_AI_SCRIPT_SCATTER 2
#define CRQ_AI_SCRIPT_REST 4
#define CRQ_AI_SCRIPT_STOP 6

#define CRQ_AI_RADIUS_MOVE_INFANTRY 3
#define CRQ_AI_RADIUS_MOVE_VEHICLE 6
#define CRQ_AI_RADIUS_MOVE_VEHICLE_COMPLETE 24

#define CRQ_AI_SCATTER_PROB 0.5
#define CRQ_AI_SCATTER_DIST_MIN 2
#define CRQ_AI_SCATTER_DIST_AVG 16
#define CRQ_AI_SCATTER_DIST_MAX 30

#define CRQ_AI_REST_PROB 0.5

#define CRQ_AI_TIMEOUT_COMBAT [8,16,24]
/*
#define CRQ_AI_TIMEOUT_WAIT [[4,4,4]]
#define CRQ_AI_TIMEOUT_REGROUP [[4,4,4]]
#define CRQ_AI_TIMEOUT_SCATTER [[4,4,4]]
#define CRQ_AI_TIMEOUT_REST [[4,4,4]]
#define CRQ_AI_TIMEOUT_STOP [[4,4,4]]
*/

#define CRQ_AI_TIMEOUT_WAIT [[2,6,10],[4,12,20],[8,16,24]]
#define CRQ_AI_TIMEOUT_REGROUP [[3,4,5],[5,8,12],[10,15,20]]
#define CRQ_AI_TIMEOUT_SCATTER [[3,5,9],[6,8,16],[12,18,24]]
#define CRQ_AI_TIMEOUT_REST [[10,16,18],[8,16,24],[12,15,30]]
#define CRQ_AI_TIMEOUT_STOP [[2,5,8],[9,13,16],[12,16,18]]

#define CRQ_AI_PATTERN_GARRISON [\
[CRQ_AI_SCRIPT_SCATTER,CRQ_AI_SCRIPT_WAIT,CRQ_AI_SCRIPT_REST,CRQ_AI_SCRIPT_WAIT,CRQ_AI_SCRIPT_REST,CRQ_AI_SCRIPT_WAIT,CRQ_AI_SCRIPT_REGROUP]]
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