
#define CRQ_NOTIFY(MESSAGE) [(MESSAGE)] remoteExec ["hint", gCS_Broadcast]
#define CRQ_MESSAGE(MESSAGE) [(MESSAGE)] remoteExec ["systemChat", gCS_Broadcast]

#define CRQ_LOOP_TIMER [[1,-0.875],[2,-1.750],[4,-3.625],[8,-7.500],[16,-15.375],[32,-31.250],[64,-63.125],[128,-127.000]]
#define CRQ_LOOP_RESOLUTION 0.1

#define CRQ_DAYTIME_TIMER [-0.975,0.075,0.425,0.650,0.975,-0.125]

#define CRQ_CORPSE_EXPEDITE 0.9
#define CRQ_CORPSE_DELETE 10

#define CRQ_ACTION_SYNC 1
