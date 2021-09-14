
#define CRQ_DELAY_LOOP 0.2
#define CRQ_CORPSE_DELETE 10

#define CRQ_LOOP_TIMER_DELAY [1,2,4,8,16,32,64,128]
#define CRQ_LOOP_TIMER_INIT [0,0,0,-7.5,0,0,0,0]

#define CRQ_PLAYER_ACTION_SYNC_DELAY 1

#define CRQ_NOTIFY(TEXT) [(TEXT)] remoteExec ["hint", gCS_Broadcast]
#define CRQ_MESSAGE(TEXT) [(TEXT)] remoteExec ["systemChat", gCS_Broadcast]
