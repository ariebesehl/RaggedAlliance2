
#define CRA_VEHICLE_CAR 0
#define CRA_VEHICLE_PLANE 1
#define CRA_VEHICLE_BOAT 2
#define CRA_VEHICLE_HELI 3
#define CRA_VEHICLE_STATIC 100
#define CRA_VEHICLE_TYPE_FUEL 1
#define CRA_VEHICLE_TYPE_SUPPLY 2
#define CRA_VEHICLE_TYPE_REPAIR 4
#define CRA_VEHICLE_TYPE_MEDIC 8
#define CRA_VEHICLE_TYPE_ARMED 16
#define CRA_VEHICLES_EXCLUDE ["C_Kart_01_F", "C_Kart_01_Fuel_F", "C_Kart_01_Blu_F", "C_Kart_01_Red_F", "C_Kart_01_Vrana_F","B_SDV_01_F","O_SDV_01_F","I_SDV_01_F","C_Boat_Civil_01_rescue_F","C_Boat_Civil_01_police_F","I_Truck_02_MRL_F","I_E_Truck_02_MRL_F"]
#define CRA_VEHICLES_WEAPON_EXCLUDE ["FakeHorn","SmokeLauncher","Laserdesignator_vehicle","Laserdesignator_mounted"]
#define CRA_VEHICLE_INVENTORY_FIRSTAID [0.35,1.15,1.75]
#define CRA_VEHICLE_INVENTORY_MEDKIT [0.35,1.15,1.75]
#define CRA_VEHICLE_INVENTORY_TOOLKIT [0.35,1.15,1.75]
#define CRA_VEHICLE_INVENTORY_PARACHUTE [1.5,3.0,4.5]
#define CRA_VEHICLE_WAYPOINT_SPACING 3
#define CRA_VEHICLE_WAYPOINT_ANALYSIS 3 // NO LESS THAN 1
#define CRA_VEHICLE_WAYPOINT_ANGLE_MIN 45

#define CRA_STATIC_MG_LOW 0
#define CRA_STATIC_MG_HIGH 1 
#define CRA_STATIC_MORTAR 2
#define CRA_STATIC_RPG 3

#define CRA_VEHICLE_CREW_BASIC_BLUFOR []
#define CRA_VEHICLE_CREW_BASIC_IDFOR [CRA_UNIT_CARTEL_GRUNT_0]
#define CRA_VEHICLE_CREW_BASIC_OPFOR [CRA_UNIT_ARMY_GRUNT_0]
#define CRA_VEHICLE_CREW_BASIC_CIVFOR [CRA_UNIT_CIVILIAN_0]
#define CRA_VEHICLE_CREW_REPAIR_BLUFOR []
#define CRA_VEHICLE_CREW_REPAIR_IDFOR [CRA_UNIT_CARTEL_GRUNT_0]
#define CRA_VEHICLE_CREW_REPAIR_OPFOR [CRA_UNIT_ARMY_ENG_0]
#define CRA_VEHICLE_CREW_REPAIR_CIVFOR [CRA_UNIT_CIVILIAN_UTILITY]
#define CRA_VEHICLE_CREW_MEDIC_BLUFOR []
#define CRA_VEHICLE_CREW_MEDIC_IDFOR [CRA_UNIT_CARTEL_MED_0]
#define CRA_VEHICLE_CREW_MEDIC_OPFOR [CRA_UNIT_ARMY_MED_0]
#define CRA_VEHICLE_CREW_MEDIC_CIVFOR [CRA_UNIT_CIVILIAN_MEDIC]
#define CRA_VEHICLE_CREW_BLUFOR [CRA_VEHICLE_CREW_BASIC_BLUFOR,CRA_VEHICLE_CREW_REPAIR_BLUFOR,CRA_VEHICLE_CREW_MEDIC_BLUFOR]
#define CRA_VEHICLE_CREW_IDFOR [CRA_VEHICLE_CREW_BASIC_IDFOR,CRA_VEHICLE_CREW_REPAIR_IDFOR,CRA_VEHICLE_CREW_MEDIC_IDFOR]
#define CRA_VEHICLE_CREW_OPFOR [CRA_VEHICLE_CREW_BASIC_OPFOR,CRA_VEHICLE_CREW_REPAIR_OPFOR,CRA_VEHICLE_CREW_MEDIC_OPFOR]
#define CRA_VEHICLE_CREW_CIVFOR [CRA_VEHICLE_CREW_BASIC_CIVFOR,CRA_VEHICLE_CREW_REPAIR_CIVFOR,CRA_VEHICLE_CREW_MEDIC_CIVFOR]
#define CRA_VEHICLE_CREW [CRA_VEHICLE_CREW_BLUFOR,CRA_VEHICLE_CREW_IDFOR,CRA_VEHICLE_CREW_OPFOR,CRA_VEHICLE_CREW_CIVFOR]

#define CRA_DEPOT_LOCATION_TYPE ["respawn_motor", "respawn_plane", "respawn_naval", "respawn_air"]
#define CRA_DEPOT_LOCATION_SIZE 10
#define CRA_DEPOT_MARKER_CAR ["b_motor_inf","n_motor_inf","o_motor_inf","c_car"]
#define CRA_DEPOT_MARKER_PLANE ["b_plane","n_plane","o_plane","c_plane"]
#define CRA_DEPOT_MARKER_BOAT ["b_naval","n_naval","o_naval","c_ship"]
#define CRA_DEPOT_MARKER_HELI ["b_air","n_air","o_air","c_air"]
#define CRA_DEPOT_MARKER [CRA_DEPOT_MARKER_CAR,CRA_DEPOT_MARKER_PLANE,CRA_DEPOT_MARKER_BOAT,CRA_DEPOT_MARKER_HELI]
#define CRA_DEPOT_VECTORUP_MIN 0.96
#define CRA_DEPOT_GROUPING [50, 50, 250, 50]
#define CRA_DEPOT_OBSTRUCTORS ["HOUSE","POWER LINES","MAIN ROAD","HIDE","FENCE","RAILWAY","ROAD","ROCK"]//,"BUSH","TREE","WALL","TRACK"]
#define CRA_DEPOT_PIER_OBSTRUCTORS ["HOUSE","POWER LINES","MAIN ROAD","HIDE","FENCE","RAILWAY","ROAD","ROCK","BUSH"]//,"TREE","WALL","TRACK"]
#define CRA_DEPOT_PIER_CLEARANCE 1.25
#define CRA_DEPOT_PIER_SCAN_RANGE 20
#define CRA_DEPOT_POS_INSIDE 0
#define CRA_DEPOT_POS_OUTSIDE 1
#define CRA_DEPOT_POS_BOAT 2
#define CRA_DEPOT_TYPES [\
["Land_shed_small_f",CRA_VEHICLE_CAR,[[CRQ_POS_REL, [0,0,0],CRA_DEPOT_POS_INSIDE,[0.85,0.85,0.85],[0,180]]]],\
["Land_shed_big_f",CRA_VEHICLE_CAR,[[CRQ_POS_REL, [0,0,0],CRA_DEPOT_POS_INSIDE,[0.85,0.85,0.85],[0,90,180,270]]]],\
["Land_shed_06_f",CRA_VEHICLE_CAR,[[CRQ_POS_VEC, [2.5,180],CRA_DEPOT_POS_INSIDE,[0.85,0.5,0.85],[90,270]],[CRQ_POS_VEC, [2.5,0],CRA_DEPOT_POS_INSIDE,[0.85,0.45,0.85],[90,270]]]],\
["Land_garageshelter_01_f",CRA_VEHICLE_CAR,[[CRQ_POS_VEC, [2.25,90],CRA_DEPOT_POS_INSIDE,[0.35,0.85,0.85],[0,180]]]],\
["Land_airport_01_hangar_f",CRA_VEHICLE_PLANE,[[CRQ_POS_REL, [0,0,0],CRA_DEPOT_POS_INSIDE,[0.85,0.85,0.85],[180]]]],\
["Land_airport_02_hangar_left_f",CRA_VEHICLE_PLANE,[[CRQ_POS_VEC,[11.1803,161.5651],CRA_DEPOT_POS_INSIDE,[0.85,0.85,0.85],[180]]]],\
["Land_airport_02_hangar_right_f",CRA_VEHICLE_PLANE,[[CRQ_POS_VEC,[11.1803,198.4349],CRA_DEPOT_POS_INSIDE,[0.85,0.85,0.85],[180]]]],\
["Land_pierwooden_02_ladder_f",CRA_VEHICLE_BOAT,[[CRQ_POS_REL,[0,0,0],CRA_DEPOT_POS_BOAT,[1,0],[0,90,180,270]],[CRQ_POS_REL,[0,0,0],CRA_DEPOT_POS_BOAT,[0.627201,90],[0,90,180,270]],[CRQ_POS_REL,[0,0,0],CRA_DEPOT_POS_BOAT,[1,180],[0,90,180,270]],[CRQ_POS_REL,[0,0,0],CRA_DEPOT_POS_BOAT,[0.627201,270],[0,90,180,270]]]],\
["Land_pierwooden_03_f",CRA_VEHICLE_BOAT,[[CRQ_POS_REL,[0,0,0],CRA_DEPOT_POS_BOAT,[1,0],[0,90,180,270]],[CRQ_POS_REL,[0,0,0],CRA_DEPOT_POS_BOAT,[0.123792,90],[0,90,180,270]],[CRQ_POS_REL,[0,0,0],CRA_DEPOT_POS_BOAT,[1,180],[0,90,180,270]],[CRQ_POS_REL,[0,0,0],CRA_DEPOT_POS_BOAT,[0.123792,270],[0,90,180,270]]]],\
["Land_pierwooden_02_16m_f",CRA_VEHICLE_BOAT,[[CRQ_POS_REL,[0,0,0],CRA_DEPOT_POS_BOAT,[1,0],[0,90,180,270]],[CRQ_POS_REL,[0,0,0],CRA_DEPOT_POS_BOAT,[0.161857,90],[0,90,180,270]],[CRQ_POS_REL,[0,0,0],CRA_DEPOT_POS_BOAT,[1,180],[0,90,180,270]],[CRQ_POS_REL,[0,0,0],CRA_DEPOT_POS_BOAT,[0.161857,270],[0,90,180,270]]]],\
["Land_pierwooden_02_hut_f",CRA_VEHICLE_BOAT,[[CRQ_POS_REL,[0,0,0],CRA_DEPOT_POS_BOAT,[1,0],[0,90,180,270]],[CRQ_POS_REL,[0,0,0],CRA_DEPOT_POS_BOAT,[0.679215,90],[0,90,180,270]],[CRQ_POS_REL,[0,0,0],CRA_DEPOT_POS_BOAT,[1,180],[0,90,180,270]],[CRQ_POS_REL,[0,0,0],CRA_DEPOT_POS_BOAT,[0.679215,270],[0,90,180,270]]]],\
["Land_pierwooden_02_barrel_f",CRA_VEHICLE_BOAT,[[CRQ_POS_REL,[0,0,0],CRA_DEPOT_POS_BOAT,[1,0],[0,90,180,270]],[CRQ_POS_REL,[0,0,0],CRA_DEPOT_POS_BOAT,[0.240454,90],[0,90,180,270]],[CRQ_POS_REL,[0,0,0],CRA_DEPOT_POS_BOAT,[1,180],[0,90,180,270]],[CRQ_POS_REL,[0,0,0],CRA_DEPOT_POS_BOAT,[0.240454,270],[0,90,180,270]]]],\
["Land_quayconcrete_01_pier_f",CRA_VEHICLE_BOAT,[[CRQ_POS_REL,[0,0,0],CRA_DEPOT_POS_BOAT,[1,0],[0,90,180,270]],[CRQ_POS_REL,[0,0,0],CRA_DEPOT_POS_BOAT,[0.930479,90],[0,90,180,270]],[CRQ_POS_REL,[0,0,0],CRA_DEPOT_POS_BOAT,[1,180],[0,90,180,270]],[CRQ_POS_REL,[0,0,0],CRA_DEPOT_POS_BOAT,[0.930479,270],[0,90,180,270]]]],\
["Land_pierconcrete_01_16m_f",CRA_VEHICLE_BOAT,[[CRQ_POS_REL,[0,0,0],CRA_DEPOT_POS_BOAT,[1,0],[0,90,180,270]],[CRQ_POS_REL,[0,0,0],CRA_DEPOT_POS_BOAT,[0.560894,90],[0,90,180,270]],[CRQ_POS_REL,[0,0,0],CRA_DEPOT_POS_BOAT,[1,180],[0,90,180,270]],[CRQ_POS_REL,[0,0,0],CRA_DEPOT_POS_BOAT,[0.560894,270],[0,90,180,270]]]],\
["Land_pierconcrete_01_4m_ladders_f",CRA_VEHICLE_BOAT,[[CRQ_POS_REL,[0,0,0],CRA_DEPOT_POS_BOAT,[0.398782,0],[0,90,180,270]],[CRQ_POS_REL,[0,0,0],CRA_DEPOT_POS_BOAT,[1,90],[0,90,180,270]],[CRQ_POS_REL,[0,0,0],CRA_DEPOT_POS_BOAT,[0.398782,180],[0,90,180,270]],[CRQ_POS_REL,[0,0,0],CRA_DEPOT_POS_BOAT,[1,270],[0,90,180,270]]]],\
["Land_pierconcrete_01_steps_f",CRA_VEHICLE_BOAT,[[CRQ_POS_REL,[0,0,0],CRA_DEPOT_POS_BOAT,[1,0],[0,90,180,270]],[CRQ_POS_REL,[0,0,0],CRA_DEPOT_POS_BOAT,[0.832698,90],[0,90,180,270]],[CRQ_POS_REL,[0,0,0],CRA_DEPOT_POS_BOAT,[1,180],[0,90,180,270]],[CRQ_POS_REL,[0,0,0],CRA_DEPOT_POS_BOAT,[0.832698,270],[0,90,180,270]]]],\
["Land_pierconcrete_01_30deg_f",CRA_VEHICLE_BOAT,[[CRQ_POS_REL,[0,0,0],CRA_DEPOT_POS_BOAT,[0.710138,0],[0,90,180,270]],[CRQ_POS_REL,[0,0,0],CRA_DEPOT_POS_BOAT,[1,90],[0,90,180,270]],[CRQ_POS_REL,[0,0,0],CRA_DEPOT_POS_BOAT,[0.710138,180],[0,90,180,270]],[CRQ_POS_REL,[0,0,0],CRA_DEPOT_POS_BOAT,[1,270],[0,90,180,270]]]],\
["Land_pierconcrete_01_end_f",CRA_VEHICLE_BOAT,[[CRQ_POS_REL,[0,0,0],CRA_DEPOT_POS_BOAT,[0.838097,0],[0,90,180,270]],[CRQ_POS_REL,[0,0,0],CRA_DEPOT_POS_BOAT,[1,90],[0,90,180,270]],[CRQ_POS_REL,[0,0,0],CRA_DEPOT_POS_BOAT,[0.838097,180],[0,90,180,270]],[CRQ_POS_REL,[0,0,0],CRA_DEPOT_POS_BOAT,[1,270],[0,90,180,270]]]],\
["Land_pierwooden_02_30deg_f",CRA_VEHICLE_BOAT,[[CRQ_POS_REL,[0,0,0],CRA_DEPOT_POS_BOAT,[1,0],[0,90,180,270]],[CRQ_POS_REL,[0,0,0],CRA_DEPOT_POS_BOAT,[0.509082,90],[0,90,180,270]],[CRQ_POS_REL,[0,0,0],CRA_DEPOT_POS_BOAT,[1,180],[0,90,180,270]],[CRQ_POS_REL,[0,0,0],CRA_DEPOT_POS_BOAT,[0.509082,270],[0,90,180,270]]]],\
["Land_pierwooden_01_platform_f",CRA_VEHICLE_BOAT,[[CRQ_POS_REL,[0,0,0],CRA_DEPOT_POS_BOAT,[1,0],[0,90,180,270]],[CRQ_POS_REL,[0,0,0],CRA_DEPOT_POS_BOAT,[0.745788,90],[0,90,180,270]],[CRQ_POS_REL,[0,0,0],CRA_DEPOT_POS_BOAT,[1,180],[0,90,180,270]],[CRQ_POS_REL,[0,0,0],CRA_DEPOT_POS_BOAT,[0.745788,270],[0,90,180,270]]]],\
["Land_pierwooden_01_ladder_f",CRA_VEHICLE_BOAT,[[CRQ_POS_REL,[0,0,0],CRA_DEPOT_POS_BOAT,[1,0],[0,90,180,270]],[CRQ_POS_REL,[0,0,0],CRA_DEPOT_POS_BOAT,[0.624649,90],[0,90,180,270]],[CRQ_POS_REL,[0,0,0],CRA_DEPOT_POS_BOAT,[1,180],[0,90,180,270]],[CRQ_POS_REL,[0,0,0],CRA_DEPOT_POS_BOAT,[0.624649,270],[0,90,180,270]]]],\
["Land_pierwooden_01_16m_f",CRA_VEHICLE_BOAT,[[CRQ_POS_REL,[0,0,0],CRA_DEPOT_POS_BOAT,[1,0],[0,90,180,270]],[CRQ_POS_REL,[0,0,0],CRA_DEPOT_POS_BOAT,[0.156647,90],[0,90,180,270]],[CRQ_POS_REL,[0,0,0],CRA_DEPOT_POS_BOAT,[1,180],[0,90,180,270]],[CRQ_POS_REL,[0,0,0],CRA_DEPOT_POS_BOAT,[0.156647,270],[0,90,180,270]]]],\
["Land_pierwooden_01_dock_f",CRA_VEHICLE_BOAT,[[CRQ_POS_REL,[0,0,0],CRA_DEPOT_POS_BOAT,[1,0],[0,90,180,270]],[CRQ_POS_REL,[0,0,0],CRA_DEPOT_POS_BOAT,[0.611134,90],[0,90,180,270]],[CRQ_POS_REL,[0,0,0],CRA_DEPOT_POS_BOAT,[1,180],[0,90,180,270]],[CRQ_POS_REL,[0,0,0],CRA_DEPOT_POS_BOAT,[0.611134,270],[0,90,180,270]]]],\
["Land_pierwooden_01_10m_norails_f",CRA_VEHICLE_BOAT,[[CRQ_POS_REL,[0,0,0],CRA_DEPOT_POS_BOAT,[1,0],[0,90,180,270]],[CRQ_POS_REL,[0,0,0],CRA_DEPOT_POS_BOAT,[0.217564,90],[0,90,180,270]],[CRQ_POS_REL,[0,0,0],CRA_DEPOT_POS_BOAT,[1,180],[0,90,180,270]],[CRQ_POS_REL,[0,0,0],CRA_DEPOT_POS_BOAT,[0.217564,270],[0,90,180,270]]]],\
["Land_pierwooden_01_hut_f",CRA_VEHICLE_BOAT,[[CRQ_POS_REL,[0,0,0],CRA_DEPOT_POS_BOAT,[0.988292,0],[0,90,180,270]],[CRQ_POS_REL,[0,0,0],CRA_DEPOT_POS_BOAT,[1,90],[0,90,180,270]],[CRQ_POS_REL,[0,0,0],CRA_DEPOT_POS_BOAT,[0.988292,180],[0,90,180,270]],[CRQ_POS_REL,[0,0,0],CRA_DEPOT_POS_BOAT,[1,270],[0,90,180,270]]]]]

#define CRA_DEPOT_CUSTOM [\
[[[2130,3452],346],[[9.3005,[15,11,4]],CRA_VEHICLE_PLANE,[[CRQ_POS_REL,[0,0,0],CRA_DEPOT_POS_INSIDE,[0.85,0.85,0.85],[0]]]],[]],\
[[[2322,1909],255],[2],[]],\
[[[1795.046,1108.064],353.099],[8],[]]]

//[[[2164,3455],0],[[7.8102,[10,12,6]],CRA_VEHICLE_HELI,[[CRQ_POS_REL,[0,0,0],CRA_DEPOT_POS_INSIDE,[0.85,0.85,0.85],[0]]]],[["Land_HelipadCivil_F",[CRQ_POS_REL,[0,0,0]],0]]],\
