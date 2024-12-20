
#define CRQ_BITYPE_RIFLE 1
#define CRQ_BITYPE_PISTOL 2
#define CRQ_BITYPE_LAUNCHER 4
#define CRQ_BITYPE_BINOCULAR 4096
#define CRQ_BITYPE_ARMAMENT 65536
#define CRQ_BITYPE_ITEM 131072

#define CRQ_BITYPE_OPTIC 201
#define CRQ_BITYPE_LASER 301
#define CRQ_BITYPE_MUZZLE 101
#define CRQ_BITYPE_BIPOD 302
#define CRQ_BITYPE_FIRSTAID 401
#define CRQ_BITYPE_HELMET 605
#define CRQ_BITYPE_MEDIKIT 619
#define CRQ_BITYPE_TOOLKIT 620
#define CRQ_BITYPE_TERMINAL 621
#define CRQ_BITYPE_VEST 701

#define CRQ_BIAMMO_BULLET 0
#define CRQ_BIAMMO_ROCKET 1
#define CRQ_BIAMMO_MISSILE 2
#define CRQ_BIAMMO_SHELL 3
#define CRQ_BIAMMO_LASER 4
#define CRQ_BIAMMO_STROBE 5
#define CRQ_BIAMMO_COUNTER 6
#define CRQ_BIAMMO_ILLUMINATE 7
#define CRQ_BIAMMO_SMOKE 8
#define CRQ_BIAMMO_SMOKEX 9
#define CRQ_BIAMMO_GRENADE 10
#define CRQ_BIAMMO_MINE 11
#define CRQ_BIAMMO_BOUNDING 12
#define CRQ_BIAMMO_DIRECTIONAL 13
#define CRQ_BIAMMO_SUBMUNITION 14
#define CRQ_BIAMMO_DEPLOY 15
#define CRQ_BIAMMO_TYPES ["shotbullet","shotrocket","shotmissile","shotshell","laserdesignate","shotnvgmarker","shotcm","shotilluminating","shotsmoke","shotsmokex","shotgrenade","shotmine","shotboundingmine","shotdirectionalbomb","shotsubmunitions","shotdeploy"]

#define CRQ_MAG_LASER 0
#define CRQ_MAG_FLARE 1
#define CRQ_MAG_LIGHT 2
#define CRQ_MAG_STROBE 3
#define CRQ_MAG_SMOKE 4
#define CRQ_MAG_GRENADE 5
#define CRQ_MAG_DEMO 6
#define CRQ_MAG_MINE 7
#define CRQ_MAG_COUNTER 8
#define CRQ_MAG_ROCKET_AP 9
#define CRQ_MAG_ROCKET_AT 10
#define CRQ_MAG_MISSILE_AA 11
#define CRQ_MAG_MISSILE_AP 12
#define CRQ_MAG_MISSILE_AT 13
#define CRQ_MAG_MISSILE_CRUISE 14
#define CRQ_MAG_BOMB_DUMB 15
#define CRQ_MAG_BOMB_SMART 16
#define CRQ_MAG_BULLET_SINGLE 17
#define CRQ_MAG_BULLET_BUCK 18
#define CRQ_MAG_SHELL_GRENADE_HE 19
#define CRQ_MAG_SHELL_CANNON_HE 20
#define CRQ_MAG_SHELL_CANNON_HEAT 21
#define CRQ_MAG_SHELL_CANNON_APDS 22
#define CRQ_MAG_SHELL_ARTY_HE 23
#define CRQ_MAG_SHELL_ARTY_GUIDED 24
#define CRQ_MAG_SHELL_ARTY_CLUSTER 25
#define CRQ_MAG_SHELL_ARTY_MINE 26

#define CRQ_VISION_NORMAL 1
#define CRQ_VISION_NVG 2
#define CRQ_VISION_TI 4

#define CRQ_MINE_TRIGGER_REMOTE 1
#define CRQ_MINE_TRIGGER_PERSON 2
#define CRQ_MINE_TRIGGER_VEHICLE 4
#define CRQ_MINE_TRIGGER_SHIP 8

#define CRQ_OPTIC_NONE 0
#define CRQ_OPTIC_NEAR 1
#define CRQ_OPTIC_MID 2
#define CRQ_OPTIC_FAR 4

#define CRQ_LASER_NONE 0
#define CRQ_LASER_LIGHT 1
#define CRQ_LASER_IR 2

#define CRQ_MUZZLE_NONE 0
#define CRQ_MUZZLE_SURPRESSOR 1

#define CRQ_UNDERBARREL_NONE 0
#define CRQ_UNDERBARREL_BIPOD 1

#define CRQ_CDAT_0 0
#define CRQ_CDAT_1 1
#define CRQ_CDAT_2 2
#define CRQ_CDAT_3 3
#define CRQ_CDAT_4 4
#define CRQ_CDAT_5 5
#define CRQ_CDAT_6 6
#define CRQ_CDAT_7 7
#define CRQ_CDAT_8 8
#define CRQ_CDAT_9 9
#define CRQ_CDAT_AMMO_AIRLOCK 10
#define CRQ_CDAT_AMMO_ARTLOCK 11
#define CRQ_CDAT_AMMO_CALIBER 12
#define CRQ_CDAT_AMMO_COUNT 13
#define CRQ_CDAT_AMMO_DIRECTIONAL 14
#define CRQ_CDAT_AMMO_FRICTION 15
#define CRQ_CDAT_AMMO_FX 16
#define CRQ_CDAT_AMMO_GUIDANCE 17
#define CRQ_CDAT_AMMO_HIT 18
#define CRQ_CDAT_AMMO_INCONSPICUOUSNESS 19
#define CRQ_CDAT_AMMO_INDIRECT_HIT 20
#define CRQ_CDAT_AMMO_INDIRECT_RANGE 21
#define CRQ_CDAT_AMMO_LIGHT 22
#define CRQ_CDAT_AMMO_PENETRATOR 23
#define CRQ_CDAT_AMMO_PENETRATOR_CALIBER 24
#define CRQ_CDAT_AMMO_PENETRATOR_HIT 25
#define CRQ_CDAT_AMMO_SMOKE 26
#define CRQ_CDAT_AMMO_SPEED 27
#define CRQ_CDAT_AMMO_SUBMUNITION 28
#define CRQ_CDAT_AMMO_THRUST 29
#define CRQ_CDAT_AMMO_TRIGGER 30
#define CRQ_CDAT_ARMOR 31
#define CRQ_CDAT_ASM_BASE 32
#define CRQ_CDAT_ASM_TARGET 33
#define CRQ_CDAT_ATTACHMENTS 34
#define CRQ_CDAT_AUTO 35
#define CRQ_CDAT_AUTONOMOUS 36
#define CRQ_CDAT_BURST 37
#define CRQ_CDAT_CAPABILITIES 38
#define CRQ_CDAT_CENTER 39
#define CRQ_CDAT_DEXTERITY 40
#define CRQ_CDAT_DISABLED 41
#define CRQ_CDAT_DISPERSION 42
#define CRQ_CDAT_INERTIA 43
#define CRQ_CDAT_LASER 44
#define CRQ_CDAT_LASER_TYPE 45
#define CRQ_CDAT_LOAD 46
#define CRQ_CDAT_LOCK 47
#define CRQ_CDAT_MAG_AMMO 48
#define CRQ_CDAT_MAG_COUNT 49
#define CRQ_CDAT_MAG_SPEED 50
#define CRQ_CDAT_MAGAZINES 51
#define CRQ_CDAT_MAGS_PRI 52
#define CRQ_CDAT_MAGS_SEC 53
#define CRQ_CDAT_MASS 54
#define CRQ_CDAT_MUZZLE_TYPE 55
#define CRQ_CDAT_MUZZLES 56
#define CRQ_CDAT_OPTIC_RANGE 57
#define CRQ_CDAT_OPTIC_SCOPES 58
#define CRQ_CDAT_OPTIC_TYPE 59
#define CRQ_CDAT_PARACHUTE 60
#define CRQ_CDAT_PROTECTION 61
#define CRQ_CDAT_RANGEFINDER 62
#define CRQ_CDAT_RATE 63
#define CRQ_CDAT_REBREATHER 64
#define CRQ_CDAT_SEATS 65
#define CRQ_CDAT_SIDE 66
#define CRQ_CDAT_SIZE 67
#define CRQ_CDAT_SLOT 68
#define CRQ_CDAT_SPEED 69
#define CRQ_CDAT_SYS_CAT 70
#define CRQ_CDAT_UB_GL 71
#define CRQ_CDAT_UB_OTHER 72
#define CRQ_CDAT_UNDERBARREL_TYPE 73
#define CRQ_CDAT_UNDERWATER 74
#define CRQ_CDAT_VISION_MODE 75
#define CRQ_CDAT_WEAPONS 76
#define CRQ_CDAT_ZOOM_MAX 77
#define CRQ_CDAT_ZOOM_MIN 78
#define CRQ_CDAT_DEFAULTS [[],[],[],[],[],[],[],[],[],[],false,false,0,1,false,0,0,0,0,0,0,0,false,false,0,0,false,0,-1,0,0,0,[],"",[[],[],[],[]],false,false,false,0,[],0,false,0,0,false,CRQ_LASER_NONE,0,false,-1,0,0,[[]],[],[],0,CRQ_MUZZLE_NONE,1,0,0,CRQ_OPTIC_NONE,false,[],false,0,false,[],CRQ_SD_UNKNOWN,[],0,0,[],false,false,CRQ_UNDERBARREL_NONE,false,CRQ_VISION_NORMAL,[],1,1]

#define CRQ_QDAT_ATTR 0
#define CRQ_QDAT_BASE 1
#define CRQ_QDAT_CLAMP 2
#define CRQ_QDAT_MODE 3
#define CRQ_QDAT_SOURCE 4
#define CRQ_QDAT_XREF 5
#define CRQ_QDAT_WSB 6
#define CRQ_QDAT_WEIGHT 7
#define CRQ_QDAT_DEFAULTS [[],1,[],CRQ_QMOD_LINEAR,-1,[],[],1]
// COMPOUND
#define CRQ_QMOD_LINEAR 0
#define CRQ_QMOD_ALT 1
// ATTRIBUTE
#define CRQ_QMOD_SCALAR 0
#define CRQ_QMOD_BITFLAG 1

#define CRQ_CATALOG_NONE 0
#define CRQ_CATALOG_SYSTEM 1
#define CRQ_CATALOG_ID_NAME 2
#define CRQ_CATALOG_ID_NAME_HOSTILE 3
#define CRQ_CATALOG_ID_NAME_NEUTRAL 4
#define CRQ_CATALOG_ID_NAME_FRIENDLY 5
#define CRQ_CATALOG_ID_FACE 6
#define CRQ_CATALOG_ID_VOICE 7
#define CRQ_CATALOG_BACKPACK 8
#define CRQ_CATALOG_BACKPACK_S 9
#define CRQ_CATALOG_BACKPACK_M 10
#define CRQ_CATALOG_BACKPACK_L 11
#define CRQ_CATALOG_BACKPACK_CIVILIAN 12
#define CRQ_CATALOG_BACKPACK_MEDIC 13
#define CRQ_CATALOG_BACKPACK_UTILITY 14
#define CRQ_CATALOG_BACKPACK_PRESS 15
#define CRQ_CATALOG_BACKPACK_POLICE 16
#define CRQ_CATALOG_BACKPACK_CBRN 17
#define CRQ_CATALOG_BACKPACK_RADIO 18
#define CRQ_CATALOG_BACKPACK_PARACHUTE 19
#define CRQ_CATALOG_BACKPACK_ASSEMBLY_MAIN 20
#define CRQ_CATALOG_BACKPACK_ASSEMBLY_BASE 21
#define CRQ_CATALOG_BACKPACK_OTHER 22
#define CRQ_CATALOG_VEST 23
#define CRQ_CATALOG_VEST_PLAIN 24
#define CRQ_CATALOG_VEST_RIG 25
#define CRQ_CATALOG_VEST_ARMOR 26
#define CRQ_CATALOG_VEST_REBREATHER 27
#define CRQ_CATALOG_VEST_CIVILIAN 28
#define CRQ_CATALOG_VEST_MEDIC 29
#define CRQ_CATALOG_VEST_UTILITY 30
#define CRQ_CATALOG_VEST_PRESS 31
#define CRQ_CATALOG_VEST_POLICE 32
#define CRQ_CATALOG_VEST_CREW_CARRIER 33
#define CRQ_CATALOG_VEST_EOD 34
#define CRQ_CATALOG_VEST_OTHER 35
#define CRQ_CATALOG_HELMET 36
#define CRQ_CATALOG_HELMET_HAT 37
#define CRQ_CATALOG_HELMET_ARMOR 38
#define CRQ_CATALOG_HELMET_NVG 39
#define CRQ_CATALOG_HELMET_CIVILIAN 40
#define CRQ_CATALOG_HELMET_MEDIC 41
#define CRQ_CATALOG_HELMET_UTILITY 42
#define CRQ_CATALOG_HELMET_PRESS 43
#define CRQ_CATALOG_HELMET_POLICE 44
#define CRQ_CATALOG_HELMET_CREW_ARMOR 45
#define CRQ_CATALOG_HELMET_CREW_HELI 46
#define CRQ_CATALOG_HELMET_PILOT_HELI 47
#define CRQ_CATALOG_HELMET_PILOT_JET 48
#define CRQ_CATALOG_HELMET_RACING 49
#define CRQ_CATALOG_HELMET_PATIENT 50
#define CRQ_CATALOG_HELMET_CEREMONIAL 51
#define CRQ_CATALOG_HELMET_LEADER 52
#define CRQ_CATALOG_HELMET_OTHER 53
#define CRQ_CATALOG_GLASSES 54
#define CRQ_CATALOG_GLASSES_BASIC 55
#define CRQ_CATALOG_GLASSES_CIVILIAN 56
#define CRQ_CATALOG_GLASSES_HOSTAGE 57
#define CRQ_CATALOG_GLASSES_MASK 58
#define CRQ_CATALOG_GLASSES_CBRN 59
#define CRQ_CATALOG_GLASSES_SCIENTIST 60
#define CRQ_CATALOG_GLASSES_DIVING 61
#define CRQ_CATALOG_GLASSES_VR 62
#define CRQ_CATALOG_GLASSES_OTHER 63
#define CRQ_CATALOG_FIRSTAID 64
#define CRQ_CATALOG_MEDKIT 65
#define CRQ_CATALOG_TOOLKIT 66
#define CRQ_CATALOG_WATCH 67
#define CRQ_CATALOG_WATCH_BASIC 68
#define CRQ_CATALOG_WATCH_CBRN 69
#define CRQ_CATALOG_GPS 70
#define CRQ_CATALOG_MAP 71
#define CRQ_CATALOG_COMPASS 72
#define CRQ_CATALOG_RADIO 73
#define CRQ_CATALOG_TERMINAL 74
#define CRQ_CATALOG_TERMINAL_BLUFOR 75
#define CRQ_CATALOG_TERMINAL_IDFOR 76
#define CRQ_CATALOG_TERMINAL_OPFOR 77
#define CRQ_CATALOG_TERMINAL_CIVFOR 78
#define CRQ_CATALOG_TERMINAL_OTHER 79
#define CRQ_CATALOG_BINOCULAR 80
#define CRQ_CATALOG_BINOCULAR_BASIC 81
#define CRQ_CATALOG_BINOCULAR_RANGE 82
#define CRQ_CATALOG_BINOCULAR_LASER 83
#define CRQ_CATALOG_BINOCULAR_OTHER 84
#define CRQ_CATALOG_NVG 85
#define CRQ_CATALOG_NVG_BASIC 86
#define CRQ_CATALOG_NVG_THERMAL 87
#define CRQ_CATALOG_NVG_OTHER 88
#define CRQ_CATALOG_THROW 89
#define CRQ_CATALOG_THROW_GRENADE 90
#define CRQ_CATALOG_THROW_SMOKE 91
#define CRQ_CATALOG_THROW_LIGHT 92
#define CRQ_CATALOG_THROW_STROBE 93
#define CRQ_CATALOG_THROW_OTHER 94
#define CRQ_CATALOG_PUT 95
#define CRQ_CATALOG_PUT_DEMO 96
#define CRQ_CATALOG_PUT_MINE 97
#define CRQ_CATALOG_PUT_MINE_AP 98
#define CRQ_CATALOG_PUT_MINE_AT 99
#define CRQ_CATALOG_PUT_MINE_AS 100
#define CRQ_CATALOG_PUT_MINE_REMOTE 101
#define CRQ_CATALOG_PUT_OTHER 102
#define CRQ_CATALOG_MINE_DETECTOR 103
#define CRQ_CATALOG_MAGAZINE 104
#define CRQ_CATALOG_MAGAZINE_HANDHELD 105
#define CRQ_CATALOG_MAGAZINE_ARMAMENT 106
#define CRQ_CATALOG_WEAPON 107
#define CRQ_CATALOG_WEAPON_DUMMY 108
#define CRQ_CATALOG_WEAPON_FIREARM 109
#define CRQ_CATALOG_WEAPON_LAUNCHER 110
#define CRQ_CATALOG_WEAPON_AA 111
#define CRQ_CATALOG_WEAPON_AR 112
#define CRQ_CATALOG_WEAPON_ARGL 113
#define CRQ_CATALOG_WEAPON_ARM 114
#define CRQ_CATALOG_WEAPON_ARSO 115
#define CRQ_CATALOG_WEAPON_ARSW 116
#define CRQ_CATALOG_WEAPON_AT 117
#define CRQ_CATALOG_WEAPON_CAR 118
#define CRQ_CATALOG_WEAPON_FLARE 119
#define CRQ_CATALOG_WEAPON_HG 120
#define CRQ_CATALOG_WEAPON_LMG 121
#define CRQ_CATALOG_WEAPON_MMG 122
#define CRQ_CATALOG_WEAPON_SG 123
#define CRQ_CATALOG_WEAPON_SMG 124
#define CRQ_CATALOG_WEAPON_SRL 125
#define CRQ_CATALOG_WEAPON_SRM 126
#define CRQ_CATALOG_WEAPON_SRSO 127
#define CRQ_CATALOG_WEAPON_UW 128
#define CRQ_CATALOG_WEAPON_OTHER 129
#define CRQ_CATALOG_ATTACHMENT 130
#define CRQ_CATALOG_ATTACHMENT_OPTIC 131
#define CRQ_CATALOG_ATTACHMENT_OPTIC_NEAR 132
#define CRQ_CATALOG_ATTACHMENT_OPTIC_MID 133
#define CRQ_CATALOG_ATTACHMENT_OPTIC_FAR 134
#define CRQ_CATALOG_ATTACHMENT_LASER 135
#define CRQ_CATALOG_ATTACHMENT_LASER_LIGHT 136
#define CRQ_CATALOG_ATTACHMENT_LASER_IR 137
#define CRQ_CATALOG_ATTACHMENT_MUZZLE 138
#define CRQ_CATALOG_ATTACHMENT_MUZZLE_SURPRESSOR 139
#define CRQ_CATALOG_ATTACHMENT_UNDERBARREL 140
#define CRQ_CATALOG_ATTACHMENT_UNDERBARREL_BIPOD 141
#define CRQ_CATALOG_ATTACHMENT_OTHER 142
#define CRQ_CATALOG_ASSET 143
#define CRQ_CATALOG_ASSET_OTHER 144
#define CRQ_CATALOG_ASSET_BLUFOR 145
#define CRQ_CATALOG_ASSET_IDFOR 146
#define CRQ_CATALOG_ASSET_OPFOR 147
#define CRQ_CATALOG_ASSET_CIVFOR 148
#define CRQ_CATALOG_ASSET_AUTONOMOUS 149
#define CRQ_CATALOG_ASSET_MANNED 150
#define CRQ_CATALOG_ASSET_ARMED 151
#define CRQ_CATALOG_ASSET_UNARMED 152
#define CRQ_CATALOG_ASSET_ARMORED 153
#define CRQ_CATALOG_ASSET_UNARMORED 154
#define CRQ_CATALOG_ASSET_POD 155
#define CRQ_CATALOG_ASSET_STATIC 156
#define CRQ_CATALOG_ASSET_VEHICLE 157
#define CRQ_CATALOG_ASSET_AIR 158
#define CRQ_CATALOG_ASSET_LAND 159
#define CRQ_CATALOG_ASSET_SEA 160
#define CRQ_CATALOG_ASSET_WHEELED 161
#define CRQ_CATALOG_ASSET_TRACKED 162
#define CRQ_CATALOG_ASSET_ROTOR 163
#define CRQ_CATALOG_ASSET_WINGED 164
#define CRQ_CATALOG_ASSET_BOAT 165
#define CRQ_CATALOG_ASSET_SUB 166
#define CRQ_CATALOG_ASSET_CAP_FUEL 167
#define CRQ_CATALOG_ASSET_CAP_REPAIR 168
#define CRQ_CATALOG_ASSET_CAP_AMMO 169
#define CRQ_CATALOG_ASSET_CAP_HEAL 170
#define CRQ_CATALOG_ASSET_ARM_MG 171
#define CRQ_CATALOG_ASSET_ARM_GMG 172
#define CRQ_CATALOG_ASSET_ARM_AC 173
#define CRQ_CATALOG_ASSET_ARM_CN 174
#define CRQ_CATALOG_ASSET_ARM_ART 175
#define CRQ_CATALOG_ASSET_ARM_RPG_AA 176
#define CRQ_CATALOG_ASSET_ARM_RPG_AT 177
#define CRQ_CATALOG_ASSET_ARM_VLS 178
#define CRQ_CATALOG_ASSET_ARM_LS 179
#define CRQ_CATALOG_ASSET_ARM_CM 180
#define CRQ_CATALOG_ARMAMENT 181
#define CRQ_CATALOG_ARMAMENT_OTHER 182
#define CRQ_CATALOG_ARMAMENT_DUMMY 183
#define CRQ_CATALOG_ARMAMENT_LMG 184
#define CRQ_CATALOG_ARMAMENT_MMG 185
#define CRQ_CATALOG_ARMAMENT_HMG 186
#define CRQ_CATALOG_ARMAMENT_AC 187
#define CRQ_CATALOG_ARMAMENT_GMG 188
#define CRQ_CATALOG_ARMAMENT_CANNON 189
#define CRQ_CATALOG_ARMAMENT_ARTY 190
#define CRQ_CATALOG_ARMAMENT_RPG_AA 191
#define CRQ_CATALOG_ARMAMENT_RPG_AT 192
#define CRQ_CATALOG_ARMAMENT_VLS 193
#define CRQ_CATALOG_ARMAMENT_LASER 194
#define CRQ_CATALOG_ARMAMENT_COUNTER 195
#define CRQ_CATALOG_CATEGORIES 196

#define CRQ_AMMO_DATA [\
[CRQ_CDAT_AMMO_HIT,{getNumber (_this >> "hit")},[CRQ_BIAMMO_BULLET,CRQ_BIAMMO_SHELL,CRQ_BIAMMO_ROCKET,CRQ_BIAMMO_MISSILE,CRQ_BIAMMO_MINE,CRQ_BIAMMO_BOUNDING,CRQ_BIAMMO_DIRECTIONAL]],\
[CRQ_CDAT_AMMO_CALIBER,{getNumber (_this >> "caliber")},[CRQ_BIAMMO_BULLET,CRQ_BIAMMO_SHELL]],\
[CRQ_CDAT_AMMO_SPEED,{getNumber (_this >> "typicalSpeed")},[CRQ_BIAMMO_BULLET,CRQ_BIAMMO_SHELL]],\
[CRQ_CDAT_AMMO_FRICTION,{getNumber (_this >> "airFriction")},[CRQ_BIAMMO_BULLET]],\
[CRQ_CDAT_AMMO_INDIRECT_HIT,{getNumber (_this >> "indirectHit")},[CRQ_BIAMMO_BULLET,CRQ_BIAMMO_SHELL,CRQ_BIAMMO_ROCKET,CRQ_BIAMMO_MISSILE,CRQ_BIAMMO_MINE,CRQ_BIAMMO_BOUNDING,CRQ_BIAMMO_DIRECTIONAL]],\
[CRQ_CDAT_AMMO_INDIRECT_RANGE,{getNumber (_this >> "indirectHitRange")},[CRQ_BIAMMO_BULLET,CRQ_BIAMMO_SHELL,CRQ_BIAMMO_ROCKET,CRQ_BIAMMO_MISSILE,CRQ_BIAMMO_MINE,CRQ_BIAMMO_BOUNDING,CRQ_BIAMMO_DIRECTIONAL]],\
[CRQ_CDAT_AMMO_THRUST,{getNumber (_this >> "thrust")},[CRQ_BIAMMO_MISSILE]],\
[CRQ_CDAT_AMMO_INCONSPICUOUSNESS,{getNumber (_this >> "mineInconspicuousness")},[CRQ_BIAMMO_MINE,CRQ_BIAMMO_BOUNDING,CRQ_BIAMMO_DIRECTIONAL]],\
[CRQ_CDAT_AMMO_TRIGGER,{_this call CRQ_CatalogUtilAmmoTrigger},[CRQ_BIAMMO_MINE,CRQ_BIAMMO_BOUNDING,CRQ_BIAMMO_DIRECTIONAL]],\
[CRQ_CDAT_AMMO_DIRECTIONAL,{(getNumber (_this >> "directionalExplosion")) > 0},[CRQ_BIAMMO_MINE,CRQ_BIAMMO_BOUNDING,CRQ_BIAMMO_DIRECTIONAL]],\
[CRQ_CDAT_AMMO_AIRLOCK,{(getNumber (_this >> "airLock")) > 1},[CRQ_BIAMMO_MISSILE]],\
[CRQ_CDAT_AMMO_ARTLOCK,{(getNumber (_this >> "artilleryLock")) > 0},[CRQ_BIAMMO_MISSILE,CRQ_BIAMMO_SHELL,CRQ_BIAMMO_SUBMUNITION,CRQ_BIAMMO_DEPLOY]],\
[CRQ_CDAT_AMMO_GUIDANCE,{_this call CRQ_CatalogUtilAmmoGuidance},[CRQ_BIAMMO_MISSILE,CRQ_BIAMMO_SHELL,CRQ_BIAMMO_SUBMUNITION,CRQ_BIAMMO_DEPLOY]],\
[CRQ_CDAT_AMMO_FX,{_this call CRQ_CatalogUtilAmmoFX},[CRQ_BIAMMO_SMOKE,CRQ_BIAMMO_SMOKEX]]]

#define CRQ_AMMO_TYPES [\
[[CRQ_BIAMMO_BULLET],{CRQ_MAG_BULLET_SINGLE}],\
[[CRQ_BIAMMO_MISSILE,CRQ_BIAMMO_SHELL],{\
	private _msData = _this select 0 select 3;\
	if (([CRQ_CDAT_AMMO_HIT, _msData] call CRQ_CatalogArrayData) > 3000) exitWith {CRQ_MAG_MISSILE_CRUISE};\
	CRQ_MAG_MISSILE_AT\
}],\
[[CRQ_BIAMMO_MISSILE],{\
	private _msData = _this select 0 select 3;\
	if (([CRQ_CDAT_AMMO_THRUST, _msData] call CRQ_CatalogArrayData) == 0) exitWith {CRQ_MAG_BOMB_DUMB};\
	if (([CRQ_CDAT_AMMO_HIT, _msData] call CRQ_CatalogArrayData) > 3000) exitWith {CRQ_MAG_MISSILE_CRUISE};\
	if ([CRQ_CDAT_AMMO_AIRLOCK, _msData] call CRQ_CatalogArrayData) exitWith {CRQ_MAG_MISSILE_AA};\
	CRQ_MAG_MISSILE_AP\
}],\
[[CRQ_BIAMMO_SHELL],{\
	private _shData = _this select 0 select 3;\
	if ([CRQ_CDAT_AMMO_ARTLOCK, _shData] call CRQ_CatalogArrayData) exitWith {CRQ_MAG_SHELL_ARTY_HE};\
	if (([CRQ_CDAT_AMMO_SPEED, _shData] call CRQ_CatalogArrayData) < 360) exitWith {CRQ_MAG_SHELL_GRENADE_HE};\
	if (([CRQ_CDAT_AMMO_CALIBER, _shData] call CRQ_CatalogArrayData) > 16) exitWith {CRQ_MAG_SHELL_CANNON_APDS};\
	CRQ_MAG_SHELL_CANNON_HE\
}],\
[[CRQ_BIAMMO_SMOKEX],{\
	private _smData = _this select 0 select 3;\
	(([CRQ_CDAT_AMMO_FX, _smData] call CRQ_CatalogArrayData) call CRQ_fnc_ByteDecode) params [["_smoke", false], ["_light", false]];\
	if (_light) then {CRQ_MAG_LIGHT} else {CRQ_MAG_SMOKE};\
}],\
[[CRQ_BIAMMO_SHELL,CRQ_BIAMMO_SHELL],{CRQ_MAG_SHELL_CANNON_HEAT}],\
[[CRQ_BIAMMO_MINE],{\
	private _mnData = _this select 0 select 3;\
	if (([CRQ_CDAT_AMMO_INCONSPICUOUSNESS, _mnData] call CRQ_CatalogArrayData) > 10) exitWith {CRQ_MAG_MINE};\
	CRQ_MAG_DEMO\
}],\
[[CRQ_BIAMMO_ILLUMINATE],{CRQ_MAG_FLARE}],\
[[CRQ_BIAMMO_ROCKET],{CRQ_MAG_ROCKET_AP}],\
[[CRQ_BIAMMO_ROCKET,CRQ_BIAMMO_SHELL],{CRQ_MAG_ROCKET_AT}],\
[[CRQ_BIAMMO_SUBMUNITION,CRQ_BIAMMO_MISSILE],{CRQ_MAG_SHELL_ARTY_GUIDED}],\
[[CRQ_BIAMMO_SUBMUNITION,CRQ_BIAMMO_DEPLOY,CRQ_BIAMMO_MINE],{CRQ_MAG_SHELL_ARTY_MINE}],\
[[CRQ_BIAMMO_SUBMUNITION,CRQ_BIAMMO_SHELL],{\
	private _shData = _this select 0 select 3;\
	if (([CRQ_CDAT_AMMO_COUNT, _shData] call CRQ_CatalogArrayData) > 1) exitWith {CRQ_MAG_SHELL_ARTY_CLUSTER};\
	CRQ_MAG_SHELL_ARTY_HE\
}],\
[[CRQ_BIAMMO_STROBE],{CRQ_MAG_STROBE}],\
[[CRQ_BIAMMO_COUNTER],{CRQ_MAG_COUNTER}],\
[[CRQ_BIAMMO_DIRECTIONAL],{CRQ_MAG_MINE}],\
[[CRQ_BIAMMO_SUBMUNITION,CRQ_BIAMMO_SMOKE],{CRQ_MAG_SMOKE}],\
[[CRQ_BIAMMO_DEPLOY,CRQ_BIAMMO_SMOKE],{CRQ_MAG_SMOKE}],\
[[CRQ_BIAMMO_BULLET,CRQ_BIAMMO_BULLET],{CRQ_MAG_BULLET_BUCK}],\
[[CRQ_BIAMMO_SUBMUNITION,CRQ_BIAMMO_ILLUMINATE],{CRQ_MAG_FLARE}],\
[[CRQ_BIAMMO_GRENADE],{CRQ_MAG_GRENADE}],\
[[CRQ_BIAMMO_BOUNDING],{CRQ_MAG_MINE}],\
[[CRQ_BIAMMO_MINE,CRQ_BIAMMO_DEPLOY,CRQ_BIAMMO_MINE],{CRQ_MAG_MINE}],\
[[CRQ_BIAMMO_LASER],{CRQ_MAG_LASER}]]

#define CRQ_AMMO_LETHALITY [\
[[CRQ_MAG_BULLET_SINGLE,CRQ_MAG_BULLET_BUCK],{\
	params ["_bullet", ["_buck", []]];\
	private _btData = if (_buck isEqualTo []) then {_bullet select 3} else {_buck select 3};\
	private _hit = [CRQ_CDAT_AMMO_HIT, _btData] call CRQ_CatalogArrayData;\
	private _cal = [CRQ_CDAT_AMMO_CALIBER, _btData] call CRQ_CatalogArrayData;\
	private _spd = [CRQ_CDAT_AMMO_SPEED, _btData] call CRQ_CatalogArrayData;\
	private _frc = [CRQ_CDAT_AMMO_FRICTION, _btData] call CRQ_CatalogArrayData;\
	private _impact = sqrt (_hit * _cal * (_spd + (_spd * 20 * _frc)) / 1000);\
	_impact = ((_impact - 5) * 1.33333 + 5) / 10;\
	if (_impact < 0) then {0} else {_impact};\
}],\
[[CRQ_MAG_ROCKET_AP,CRQ_MAG_ROCKET_AT,CRQ_MAG_MISSILE_AA,CRQ_MAG_MISSILE_AP,CRQ_MAG_MISSILE_AT],{\
	params ["_rpg", ["_pn", []]];\
	private _amData = _rpg select 3;\
	private _hit = [CRQ_CDAT_AMMO_HIT, _amData] call CRQ_CatalogArrayData;\
	private _idHit = [CRQ_CDAT_AMMO_INDIRECT_HIT, _amData] call CRQ_CatalogArrayData;\
	private _idRng = [CRQ_CDAT_AMMO_INDIRECT_RANGE, _amData] call CRQ_CatalogArrayData;\
	private _pnHit = 0;\
	private _pnCal = 0;\
	if (_pn isNotEqualTo []) then {\
		private _pnData = _pn select 3;\
		_pnHit = [CRQ_CDAT_AMMO_HIT, _pnData] call CRQ_CatalogArrayData;\
		_pnCal = [CRQ_CDAT_AMMO_CALIBER, _pnData] call CRQ_CatalogArrayData;\
	};\
	((_hit + (_idHit * (_idRng / 10)) + _pnHit * (_pnCal / 100)) / 600)\
}],\
[[CRQ_MAG_SHELL_CANNON_HE,CRQ_MAG_SHELL_CANNON_HEAT,CRQ_MAG_SHELL_CANNON_APDS],{\
	params ["_sh", ["_pn", []]];\
	private _shData = _sh select 3;\
	private _hit = [CRQ_CDAT_AMMO_HIT, _shData] call CRQ_CatalogArrayData;\
	private _cal = [CRQ_CDAT_AMMO_CALIBER, _shData] call CRQ_CatalogArrayData;\
	private _idHit = [CRQ_CDAT_AMMO_INDIRECT_HIT, _shData] call CRQ_CatalogArrayData;\
	private _idRng = [CRQ_CDAT_AMMO_INDIRECT_RANGE, _shData] call CRQ_CatalogArrayData;\
	private _pnHit = 0;\
	private _pnCal = 0;\
	if (_pn isNotEqualTo []) then {\
		private _pnData = _pn select 3;\
		_pnHit = [CRQ_CDAT_AMMO_HIT, _pnData] call CRQ_CatalogArrayData;\
		_pnCal = [CRQ_CDAT_AMMO_CALIBER, _pnData] call CRQ_CatalogArrayData;\
	};\
	((_hit * (_cal / 10) + (_idHit * (_idRng / 10)) + _pnHit * (_pnCal / 100)) / 600)\
}],\
[[CRQ_MAG_SHELL_GRENADE_HE],{\
	params ["_sh"];\
	private _shData = _sh select 3;\
	private _hit = [CRQ_CDAT_AMMO_HIT, _shData] call CRQ_CatalogArrayData;\
	private _idHit = [CRQ_CDAT_AMMO_INDIRECT_HIT, _shData] call CRQ_CatalogArrayData;\
	private _idRng = [CRQ_CDAT_AMMO_INDIRECT_RANGE, _shData] call CRQ_CatalogArrayData;\
	(((sqrt (_hit / 10)) + (sqrt (_idHit * (_idRng / 6)))) / 9)\
}]]

#define CRQ_METRIC_CALIBER_SUB 0.10
#define CRQ_METRIC_CALIBER_LOW 0.30
#define CRQ_METRIC_CALIBER_MED 0.40
#define CRQ_METRIC_CALIBER_HI 0.75

#define CRQ_UTIL_RANGEFINDER_EXCLUDE ["optic_MRCO"] // has control with idc of 198, yet no actual rangefinder in-game...?

#define CRQ_WEAPON_ATTACHMENT_DEFAULT [CRQ_MUZZLE_SURPRESSOR,CRQ_LASER_LIGHT + CRQ_LASER_IR,CRQ_OPTIC_NEAR + CRQ_OPTIC_MID,CRQ_UNDERBARREL_BIPOD]
#define CRQ_WEAPON_ATTACHMENT_TYPE [\
[CRQ_CATALOG_WEAPON_ARM, [CRQ_MUZZLE_SURPRESSOR,CRQ_LASER_IR,CRQ_OPTIC_MID,CRQ_UNDERBARREL_BIPOD]],\
[CRQ_CATALOG_WEAPON_CAR, [CRQ_MUZZLE_SURPRESSOR,CRQ_LASER_LIGHT + CRQ_LASER_IR,CRQ_OPTIC_NEAR,CRQ_UNDERBARREL_NONE]],\
[CRQ_CATALOG_WEAPON_HG,  [CRQ_MUZZLE_SURPRESSOR,CRQ_LASER_LIGHT + CRQ_LASER_IR,CRQ_OPTIC_NEAR,CRQ_UNDERBARREL_NONE]],\
[CRQ_CATALOG_WEAPON_SG,  [CRQ_MUZZLE_NONE,CRQ_LASER_LIGHT + CRQ_LASER_IR,CRQ_OPTIC_NEAR,CRQ_UNDERBARREL_NONE]],\
[CRQ_CATALOG_WEAPON_SMG, [CRQ_MUZZLE_SURPRESSOR,CRQ_LASER_LIGHT + CRQ_LASER_IR,CRQ_OPTIC_NEAR,CRQ_UNDERBARREL_NONE]],\
[CRQ_CATALOG_WEAPON_SRL, [CRQ_MUZZLE_SURPRESSOR,CRQ_LASER_IR,CRQ_OPTIC_FAR,CRQ_UNDERBARREL_BIPOD]],\
[CRQ_CATALOG_WEAPON_SRM, [CRQ_MUZZLE_SURPRESSOR,CRQ_LASER_IR,CRQ_OPTIC_MID + CRQ_OPTIC_FAR,CRQ_UNDERBARREL_BIPOD]],\
[CRQ_CATALOG_WEAPON_SRSO,[CRQ_MUZZLE_SURPRESSOR,CRQ_LASER_IR,CRQ_OPTIC_MID + CRQ_OPTIC_FAR,CRQ_UNDERBARREL_BIPOD]]]

#define CRQ_CATEGORY_ASSET_ARMAMENT [\
[CRQ_CATALOG_ARMAMENT_LMG,CRQ_CATALOG_ASSET_ARM_MG],\
[CRQ_CATALOG_ARMAMENT_MMG,CRQ_CATALOG_ASSET_ARM_MG],\
[CRQ_CATALOG_ARMAMENT_HMG,CRQ_CATALOG_ASSET_ARM_MG],\
[CRQ_CATALOG_ARMAMENT_GMG,CRQ_CATALOG_ASSET_ARM_GMG],\
[CRQ_CATALOG_ARMAMENT_AC,CRQ_CATALOG_ASSET_ARM_AC],\
[CRQ_CATALOG_ARMAMENT_CANNON,CRQ_CATALOG_ASSET_ARM_CN],\
[CRQ_CATALOG_ARMAMENT_ARTY,CRQ_CATALOG_ASSET_ARM_ART],\
[CRQ_CATALOG_ARMAMENT_RPG_AA,CRQ_CATALOG_ASSET_ARM_RPG_AA],\
[CRQ_CATALOG_ARMAMENT_RPG_AT,CRQ_CATALOG_ASSET_ARM_RPG_AT],\
[CRQ_CATALOG_ARMAMENT_LASER,CRQ_CATALOG_ASSET_ARM_LS],\
[CRQ_CATALOG_ARMAMENT_COUNTER,CRQ_CATALOG_ASSET_ARM_CM],\
[CRQ_CATALOG_ARMAMENT_VLS,CRQ_CATALOG_ASSET_ARM_VLS]]
