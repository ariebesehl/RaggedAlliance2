
// #define CRQ_NOTIFY(MESSAGE) [(MESSAGE)] remoteExec ["hint", gCS_MP_Broadcast]
// #define CRQ_MESSAGE(MESSAGE) [(MESSAGE)] remoteExec ["systemChat", gCS_MP_Broadcast]

#define CRQ_DT_PARAMS [-0.975,0.075,0.425,0.650,0.975,-0.125]

#define CRQ_GC_DELETE 15
#define CRQ_GC_EXPRESS 0.9

#define CRQ_MN_LOOP [[1,-0.875],[2,-1.750],[4,-3.625],[8,-7.500],[16,-15.375],[32,-31.250],[64,-63.125],[128,-127.000]]
#define CRQ_MN_INIT 0.008
#define CRQ_MN_SLEEP_0 0.004
#define CRQ_MN_SLEEP_1 0.063

#define CRQ_AC_SYNC 0 // D299 This was probably a remnant from early systems, attempting to zero...
