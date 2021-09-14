
#define CRA_INDEX_BACKPACK_SMALL 1
#define CRA_INDEX_BACKPACK_MEDIUM 2
#define CRA_INDEX_BACKPACK_LARGE 3
#define CRA_INDEX_HEADGEAR_HAT 5
#define CRA_INDEX_HEADGEAR_HELMET 6
#define CRA_INDEX_HEADGEAR_LEADER 7
#define CRA_INDEX_VEST_PLAIN 8
#define CRA_INDEX_VEST_RIG 9
#define CRA_INDEX_VEST_ARMOR 10
#define CRA_INDEX_GLASSES 11
#define CRA_INDEX_THROW_UTIL 12
#define CRA_INDEX_THROW_GRENADE 13
#define CRA_INDEX_FIRSTAIDKIT 14
#define CRA_INDEX_MEDIKIT 15
#define CRA_INDEX_TOOLKIT 16
#define CRA_INDEX_MAGAZINE 17
#define CRA_INDEX_MINE 18
#define CRA_INDEX_OPTIC 19
#define CRA_INDEX_LASER 20
#define CRA_INDEX_MUZZLE 21
#define CRA_INDEX_BIPOD 22
#define CRA_INDEX_PARACHUTE 23


#define CRA_INDEX_BACKPACK_CIVILIAN 40
#define CRA_INDEX_BACKPACK_CIVILIAN_MEDIC 41
#define CRA_INDEX_BACKPACK_CIVILIAN_UTILITY 42
#define CRA_INDEX_VEST_CIVILIAN 43
#define CRA_INDEX_VEST_CIVILIAN_MEDIC 44
#define CRA_INDEX_VEST_CIVILIAN_UTILITY 45
#define CRA_INDEX_HEADGEAR_CIVILIAN 46
#define CRA_INDEX_HEADGEAR_CIVILIAN_MEDIC 47
#define CRA_INDEX_HEADGEAR_CIVILIAN_UTILITY 48

#define CRA_INDEX_WEAPON_GL 99

#define CRA_INDEX_WEAPON_ALL 100

#define CRA_INDEX_WEAPON_AA 101
#define CRA_INDEX_WEAPON_AR 102
#define CRA_INDEX_WEAPON_ARGL 103
#define CRA_INDEX_WEAPON_ARM 104
#define CRA_INDEX_WEAPON_ARSO 105
#define CRA_INDEX_WEAPON_ARSW 106
#define CRA_INDEX_WEAPON_AT 107
#define CRA_INDEX_WEAPON_CAR 108
#define CRA_INDEX_WEAPON_HG 109
#define CRA_INDEX_WEAPON_LMG 110
#define CRA_INDEX_WEAPON_MMG 111
#define CRA_INDEX_WEAPON_SG 112
#define CRA_INDEX_WEAPON_SMG 113
#define CRA_INDEX_WEAPON_SRL 114
#define CRA_INDEX_WEAPON_SRM 115
#define CRA_INDEX_WEAPON_SRSO 116
#define CRA_INDEX_WEAPON_UW 117

#define CRA_INDEX_VWEAPON_IGNORE 200
#define CRA_INDEX_VWEAPON_LMG 201
#define CRA_INDEX_VWEAPON_MMG 202
#define CRA_INDEX_VWEAPON_HMG 203
#define CRA_INDEX_VWEAPON_GAT_HE 204
#define CRA_INDEX_VWEAPON_GAT_AP 205
#define CRA_INDEX_VWEAPON_GMG 206
#define CRA_INDEX_VWEAPON_CAN 207
#define CRA_INDEX_VWEAPON_RPG_AA 208
#define CRA_INDEX_VWEAPON_RPG_AT 209

#define CRA_VWEAPON_QUALITY			[[0.3750,0.4375],[[1.00,0.25]]]
#define CRA_VWEAPON_QUALITY_LMG		[[0.3750,0.4375],[[1.00,0.25]]]
#define CRA_VWEAPON_QUALITY_MMG		[[0.4375,0.5000],[[1.00,0.75]]]
#define CRA_VWEAPON_QUALITY_HMG		[[0.5000,0.5625],[[1.00,2.25]]]
#define CRA_VWEAPON_QUALITY_GAT_HE	[[0.6250,0.6875],[[1.00,25.0]]]
#define CRA_VWEAPON_QUALITY_GAT_AP	[[0.6875,0.7500],[[1.00,100]]]
#define CRA_VWEAPON_QUALITY_GMG		[[0.5000,0.5625],[[1.00,0.03]]]
#define CRA_VWEAPON_QUALITY_CAN		[[0.6250,0.6875],[[1.00,1.00]]]
#define CRA_VWEAPON_QUALITY_RPG_AA	[[0.5000,0.6250],[[0.40,0.20],[0.60,1],[0.00,1]]]
#define CRA_VWEAPON_QUALITY_RPG_AT	[[0.5000,0.7500],[[0.60,0.50],[0.40,1],[0.00,1]]]

#define CRA_WEAPON_TYPE_PRIMARY [CRA_INDEX_WEAPON_AR,CRA_INDEX_WEAPON_ARGL,CRA_INDEX_WEAPON_ARM,CRA_INDEX_WEAPON_ARSO,CRA_INDEX_WEAPON_ARSW,CRA_INDEX_WEAPON_CAR,CRA_INDEX_WEAPON_LMG,CRA_INDEX_WEAPON_MMG,CRA_INDEX_WEAPON_SG,CRA_INDEX_WEAPON_SMG,CRA_INDEX_WEAPON_SRM,CRA_INDEX_WEAPON_SRL,CRA_INDEX_WEAPON_SRSO]
#define CRA_WEAPON_TYPE_SECONDARY [CRA_INDEX_WEAPON_AA,CRA_INDEX_WEAPON_AT]
#define CRA_WEAPON_TYPE_TERTIARY [CRA_INDEX_WEAPON_HG]

#define CRA_WEAPON_MODE_SINGLE 1
#define CRA_WEAPON_MODE_BURST 2
#define CRA_WEAPON_MODE_AUTO 3

#define CRA_WEAPON_TYPE_OVERRIDE [\
["HMG_M2_Mounted", 65536],\
["LMG_03_Vehicle_F", 65536]]


#define CRA_WEAPON_QUALITY		[[0.9999,0.9999],[[0.5,0.5],[0.5,30]]]
#define CRA_WEAPON_QUALITY_AR	[[0.3750,0.5625],[[0.5,0.24],[0.5,30]]]
#define CRA_WEAPON_QUALITY_ARGL	[[0.4375,0.6250],[[0.5,0.22],[0.5,30]]]
#define CRA_WEAPON_QUALITY_ARM	[[0.4375,0.5625],[[0.5,0.3],[0.5,20]]]
#define CRA_WEAPON_QUALITY_ARSO	[[0.4375,0.4375],[[0.5,0.28],[0.5,30]]]
#define CRA_WEAPON_QUALITY_ARSW	[[0.4375,0.5000],[[0.5,0.26],[0.5,75]]]
#define CRA_WEAPON_QUALITY_CAR	[[0.3125,0.5000],[[0.5,0.175],[0.5,30]]]
#define CRA_WEAPON_QUALITY_HG	[[0.0000,0.1250],[[0.5,0.055],[0.5,10]]]
#define CRA_WEAPON_QUALITY_LMG	[[0.4375,0.5000],[[0.5,0.24],[0.5,150]]]
#define CRA_WEAPON_QUALITY_MMG	[[0.5625,0.7500],[[0.5,0.825],[0.5,100]]]
#define CRA_WEAPON_QUALITY_SG	[[0.1250,0.1875],[[0.5,0.025],[0.5,2]]]
#define CRA_WEAPON_QUALITY_SMG	[[0.1875,0.2500],[[0.5,0.0625],[0.5,30]]]
#define CRA_WEAPON_QUALITY_SRL	[[0.8750,0.9375],[[0.5,2.5],[0.5,6]]]
#define CRA_WEAPON_QUALITY_SRM	[[0.5625,0.6875],[[0.5,0.5],[0.5,20]]]
#define CRA_WEAPON_QUALITY_SRSO	[[0.7500,0.8125],[[0.5,1.0],[0.5,12]]]
#define CRA_WEAPON_QUALITY_UW	[[0.4375,0.4375],[[0.5,0.015],[0.5,30]]]

#define CRA_WEAPON_QUALITY_RPG		[[0.9999,0.9999],[[0.50,0.50],[0.50,1],[0.00,1]]]
#define CRA_WEAPON_QUALITY_RPG_AA	[[0.5000,0.6250],[[0.40,0.20],[0.60,1],[0.00,1]]]
#define CRA_WEAPON_QUALITY_RPG_AT	[[0.5000,0.7500],[[0.60,0.50],[0.40,1],[0.00,1]]]

#define CRA_WEAPON_ATTACHMENT [[0,1],[0],[0],[0]]
#define CRA_WEAPON_ATTACHMENT_CAR [[0],[0],[0],[]]
#define CRA_WEAPON_ATTACHMENT_HG [[0],[0],[0],[]]
#define CRA_WEAPON_ATTACHMENT_SMG [[0],[0],[0],[]]
#define CRA_WEAPON_ATTACHMENT_SG [[0],[0],[0],[]]
#define CRA_WEAPON_ATTACHMENT_SR [[1,2],[0],[0],[0]]

//#define CRA_WEAPON_CONFIG [[0,0,0,0],[[2,4,6]],[[2,4,6]]]
#define CRA_WEAPON_CONFIG		[[0.00,0.00,0.00,0.00],[0.00,[2,4,6]],[0.00,[2,4,6]]]
#define CRA_WEAPON_CONFIG_AA	[[0.00,0.00,0.00,0.00],[0.75,[1,2,4]],[0.50,[2,4,6]]]
#define CRA_WEAPON_CONFIG_AR	[[0.50,0.25,0.10,0.10],[0.25,[2,4,6]],[0.50,[2,4,6]]]
#define CRA_WEAPON_CONFIG_ARGL	[[0.40,0.20,0.05,0.00],[0.25,[2,4,6]],[0.75,[2,4,6]]]
#define CRA_WEAPON_CONFIG_ARM	[[0.95,0.35,0.15,0.50],[0.25,[2,4,6]],[0.50,[2,4,6]]]
#define CRA_WEAPON_CONFIG_ARSO	[[0.65,0.45,0.50,0.00],[0.25,[2,4,6]],[0.75,[2,4,6]]]
#define CRA_WEAPON_CONFIG_ARSW	[[0.35,0.25,0.05,0.95],[0.25,[2,3,4]],[0.50,[2,4,6]]]
#define CRA_WEAPON_CONFIG_AT	[[0.00,0.00,0.00,0.00],[0.75,[1,2,4]],[0.50,[2,4,6]]]
#define CRA_WEAPON_CONFIG_CAR	[[0.35,0.45,0.25,0.00],[0.25,[2,3,4]],[0.50,[2,4,6]]]
#define CRA_WEAPON_CONFIG_HG	[[0.25,0.25,0.10,0.00],[0.50,[2,4,6]],[0.50,[2,4,6]]]
#define CRA_WEAPON_CONFIG_LMG	[[0.35,0.25,0.05,0.95],[0.75,[2,3,4]],[0.50,[2,4,6]]]
#define CRA_WEAPON_CONFIG_MMG	[[0.35,0.25,0.05,0.95],[0.75,[2,3,4]],[0.50,[2,4,6]]]
#define CRA_WEAPON_CONFIG_SG	[[0.25,0.25,0.10,0.00],[0.50,[4,6,8]],[0.50,[2,4,6]]]
#define CRA_WEAPON_CONFIG_SMG	[[0.35,0.25,0.15,0.00],[0.50,[2,4,5]],[0.50,[2,4,6]]]
#define CRA_WEAPON_CONFIG_SRL	[[1.00,0.05,0.05,0.75],[0.75,[4,6,8]],[0.50,[2,4,6]]]
#define CRA_WEAPON_CONFIG_SRM	[[0.95,0.25,0.25,0.75],[0.75,[3,4,6]],[0.50,[2,4,6]]]
#define CRA_WEAPON_CONFIG_SRSO	[[0.95,0.45,0.50,0.75],[0.75,[3,3,5]],[0.50,[2,4,6]]]
#define CRA_WEAPON_CONFIG_UW	[[0.65,0.45,0.50,0.00],[0.15,[2,4,6]],[0.50,[2,4,6]]]

#define CRA_VEHICLE_QUALITY			[[0.9999,0.9999],[[0.5,0.5],[0.5,50]]]
#define CRA_VEHICLE_QUALITY_CAR		[[0.3750,0.5000],[[0.5,0.5],[0.5,50]]]
#define CRA_VEHICLE_QUALITY_MRAP	[[0.5000,0.6250],[[0.5,0.6],[0.5,200]]]
#define CRA_VEHICLE_QUALITY_APC		[[0.6875,0.8125],[[0.5,0.8],[0.5,360]]]
#define CRA_VEHICLE_QUALITY_BOAT	[[0.5000,0.6250],[[0.5,0.6],[0.5,360]]]
#define CRA_VEHICLE_QUALITY_HELI	[[0.6250,0.7500],[[0.5,0.6],[0.5,50]]]
#define CRA_VEHICLE_QUALITY_PLANE	[[0.6875,0.8125],[[0.8,0.6],[0.2,60]]]

#define CRA_OPTIC_NVG 1
#define CRA_OPTIC_TI 2
#define CRA_OPTIC_QUALITY_0 [[0.1250,0.3875],[[0.25,1],[0.75,150],[0.40,1]]]
#define CRA_OPTIC_QUALITY_1 [[0.4375,0.6250],[[0.40,1],[0.40,250],[0.40,1]]]
#define CRA_OPTIC_QUALITY_2 [[0.5000,0.7500],[[0.20,1],[0.80,750],[0.00,1]]]

#define CRA_AMMO_BULLET 0
#define CRA_AMMO_GRENADE 1
#define CRA_AMMO_SHELL 2
#define CRA_AMMO_MISSILE 3
#define CRA_AMMO_ROCKET 4
#define CRA_AMMO_COUNTER 5
#define CRA_AMMO_LASER 6

#define CRA_ITEM_HEADGEAR_LEADER ["H_Beret_blk","H_Beret_CSAT_01_F"]
#define CRA_ITEM_BACKPACK_CIVILIAN ["B_LegStrapBag_black_F","B_LegStrapBag_coyote_F","B_LegStrapBag_olive_F","B_Messenger_Black_F","B_Messenger_Coyote_F","B_Messenger_Gray_F","B_Messenger_Olive_F","B_Messenger_IDAP_F","B_CivilianBackpack_01_Sport_Blue_F","B_CivilianBackpack_01_Sport_Red_F","B_CivilianBackpack_01_Sport_Green_F","B_CivilianBackpack_01_Everyday_Black_F","B_CivilianBackpack_01_Everyday_Vrana_F","B_CivilianBackpack_01_Everyday_Astra_F","B_CivilianBackpack_01_Everyday_IDAP_F"]
#define CRA_ITEM_BACKPACK_CIVILIAN_MEDIC ["B_Messenger_Gray_Medical_F"]
#define CRA_ITEM_BACKPACK_CIVILIAN_UTILITY ["B_LegStrapBag_black_F","B_LegStrapBag_coyote_F","B_LegStrapBag_olive_F"]
#define CRA_ITEM_VEST_CIVILIAN ["V_LegStrapBag_black_F","V_LegStrapBag_coyote_F","V_LegStrapBag_olive_F","V_Pocketed_black_F","V_Pocketed_coyote_F","V_Pocketed_olive_F"]
#define CRA_ITEM_VEST_CIVILIAN_MEDIC ["V_LegStrapBag_black_F","V_LegStrapBag_coyote_F"]
#define CRA_ITEM_VEST_CIVILIAN_UTILITY ["V_Safety_blue_F","V_Safety_orange_F","V_Safety_yellow_F"]
#define CRA_ITEM_HEADGEAR_CIVILIAN ["H_Cap_blk"]
#define CRA_ITEM_HEADGEAR_CIVILIAN_MEDIC ["H_WirelessEarpiece_F"]
#define CRA_ITEM_HEADGEAR_CIVILIAN_UTILITY ["H_Cap_grn_BI", "H_Cap_blk","H_Cap_Black_IDAP_F","H_Cap_blu","H_Cap_blk_CMMG","H_Cap_grn","H_Cap_blk_ION","H_Cap_Oli","H_Cap_oli_hs","H_Cap_Orange_IDAP_F","H_Cap_red","H_Cap_tan","H_Cap_White_IDAP_F","H_EarProtectors_black_F","H_EarProtectors_orange_F","H_EarProtectors_red_F","H_EarProtectors_white_F","H_EarProtectors_yellow_F","H_Construction_basic_yellow_F","H_Construction_basic_white_F","H_Construction_basic_orange_F","H_Construction_basic_red_F","H_Construction_basic_vrana_F","H_Construction_basic_black_F","H_Construction_earprot_yellow_F","H_Construction_earprot_white_F","H_Construction_earprot_orange_F","H_Construction_earprot_red_F","H_Construction_earprot_vrana_F","H_Construction_earprot_black_F","H_Construction_headset_yellow_F","H_Construction_headset_white_F","H_Construction_headset_orange_F","H_Construction_headset_red_F","H_Construction_headset_vrana_F","H_Construction_headset_black_F","H_Headset_black_F","H_Headset_orange_F","H_Headset_red_F","H_Headset_white_F","H_Headset_yellow_F","H_Cap_marshal","H_Cap_headphones","H_WirelessEarpiece_F"]

#define CRA_WEAPON_EXCLUDE ["hgun_esd_01_F","hgun_esd_01_dummy_F","hgun_Pistol_Signal_F"]
#define CRA_ITEM_HEADGEAR_EXCLUDE ["H_HelmetCrew_B","H_HelmetCrew_O","H_HelmetCrew_I","H_PilotHelmetFighter_B","H_PilotHelmetFighter_O","H_PilotHelmetFighter_I","H_PilotHelmetHeli_B","H_PilotHelmetHeli_O","H_PilotHelmetHeli_I","H_CrewHelmetHeli_B","H_CrewHelmetHeli_O","H_CrewHelmetHeli_I","H_RacingHelmet_1_F","H_RacingHelmet_2_F","H_RacingHelmet_3_F","H_RacingHelmet_4_F","H_RacingHelmet_1_black_F","H_RacingHelmet_1_blue_F","H_RacingHelmet_1_green_F","H_RacingHelmet_1_red_F","H_RacingHelmet_1_white_F","H_RacingHelmet_1_yellow_F","H_RacingHelmet_1_orange_F","H_HelmetCrew_O_ghex_F","H_Construction_basic_yellow_F","H_Construction_basic_white_F","H_Construction_basic_orange_F","H_Construction_basic_red_F","H_Construction_basic_vrana_F","H_Construction_basic_black_F","H_Construction_earprot_yellow_F","H_Construction_earprot_white_F","H_Construction_earprot_orange_F","H_Construction_earprot_red_F","H_Construction_earprot_vrana_F","H_Construction_earprot_black_F","H_Construction_headset_yellow_F","H_Construction_headset_white_F","H_Construction_headset_orange_F","H_Construction_headset_red_F","H_Construction_headset_vrana_F","H_Construction_headset_black_F","H_HeadBandage_stained_F","H_HeadBandage_clean_F","H_HeadBandage_bloody_F","H_PilotHelmetFighter_I_E","H_PilotHelmetHeli_I_E","H_CrewHelmetHeli_I_E","H_ParadeDressCap_01_US_F","H_ParadeDressCap_01_CSAT_F","H_ParadeDressCap_01_AAF_F","H_ParadeDressCap_01_LDF_F","H_HelmetCrew_I_E","H_Tank_eaf_F","H_Tank_black_F","H_PASGT_basic_blue_press_F","H_PASGT_neckprot_blue_press_F","H_PASGT_basic_white_F","H_PASGT_basic_blue_F","H_HelmetO_ViperSP_hex_F","H_HelmetO_ViperSP_ghex_F","H_Beret_CSAT_01_F","H_Helmet_Skate","H_Beret_blk","H_Beret_02","H_Beret_Colonel","H_Beret_gen_F","H_Beret_EAF_01_F","H_HelmetB_TI_tna_F","H_HelmetB_TI_arid_F","H_Hat_Tinfoil_F"]
#define CRA_ITEM_GLASSES_EXCLUDE ["None","G_Diving","G_B_Diving","G_O_Diving","G_I_Diving","G_Goggles_VR","G_Respirator_white_F","G_Respirator_yellow_F","G_Respirator_blue_F","G_AirPurifyingRespirator_01_F","G_AirPurifyingRespirator_02_black_F","G_AirPurifyingRespirator_02_olive_F","G_AirPurifyingRespirator_02_sand_F","G_RegulatorMask_F","G_Blindfold_01_white_F","G_Blindfold_01_black_F","G_EyeProtectors_F","G_EyeProtectors_Earpiece_F","G_Balaclava_TI_blk_F","G_Balaclava_TI_G_blk_F","G_Balaclava_TI_G_tna_F","G_Balaclava_TI_tna_F"]
#define CRA_ITEM_BACKPACK_EXCLUDE ["B_CombinationUnitRespirator_01_F","B_RadioBag_01_wdl_F","B_RadioBag_01_mtp_F","B_RadioBag_01_tropic_F","B_RadioBag_01_black_F","B_RadioBag_01_hex_F","B_RadioBag_01_oucamo_F","B_RadioBag_01_ghex_F","B_RadioBag_01_digi_F","B_RadioBag_01_eaf_F","B_CivilianBackpack_01_Sport_Blue_F","B_CivilianBackpack_01_Sport_Red_F","B_CivilianBackpack_01_Sport_Green_F","B_CivilianBackpack_01_Everyday_Black_F","B_CivilianBackpack_01_Everyday_Vrana_F","B_CivilianBackpack_01_Everyday_Astra_F","B_CivilianBackpack_01_Everyday_IDAP_F"]
#define CRA_ITEM_VEST_EXCLUDE ["V_RebreatherB","V_RebreatherIR","V_RebreatherIA","V_TacVest_blk_POLICE","V_PlateCarrier_Kerry","V_I_G_resistanceLeader_F","V_Press_F","V_DeckCrew_yellow_F","V_DeckCrew_blue_F","V_DeckCrew_green_F","V_DeckCrew_red_F","V_DeckCrew_white_F","V_DeckCrew_brown_F","V_DeckCrew_violet_F","V_Safety_yellow_F","V_Safety_orange_F","V_Safety_blue_F","V_EOD_blue_F","V_EOD_olive_F","V_EOD_coyote_F","V_EOD_IDAP_blue_F","V_SmershVest_01_radio_F","V_Plain_medical_F","V_Plain_crystal_F","V_TacVest_gen_F"]

#define CRA_ITEM_THROW_EXCLUDE ["B_IR_Grenade","O_IR_Grenade","I_IR_Grenade","O_R_IR_Grenade","I_E_IR_Grenade"]

#define CRA_WEAPON_FILTER ["author","_generalMacro","LinkedItems","weaponpoolavailable","cursor","cursoraim","baseWeapon"]
#define CRA_ITEM_ARMOR_HEADGEAR [["Head",0.85],["Face",0.15]]
#define CRA_ITEM_ARMOR_VEST [["Abdomen",0.20],["Arms",0.10],["Chest",0.30],["Diaphragm",0.20],["Neck",0.05],["Pelvis",0.10]]
#define CRA_ITEM_HEADGEAR_HELMET_MIN 2.5
#define CRA_ITEM_HEADGEAR_HELMET_MAX 4.5
#define CRA_ITEM_VEST_ARMOR_MIN 3.2
#define CRA_ITEM_VEST_ARMOR_MAX 13.2
#define CRA_ITEM_VEST_PLAIN_MAX 100
#define CRA_ITEM_VEST_RIG_MIN 80
#define CRA_ITEM_BACKPACK_SMALL_MIN 75
#define CRA_ITEM_BACKPACK_SMALL_MAX 175
#define CRA_ITEM_BACKPACK_MEDIUM_MIN 150
#define CRA_ITEM_BACKPACK_MEDIUM_MAX 250
#define CRA_ITEM_BACKPACK_LARGE_MIN 225
#define CRA_ITEM_BACKPACK_LARGE_MAX 375


#define CRA_UNIT_NAMES_HOSTILE ["Antagonizer","Brick","Chainsaw","Deathbringer","Executor","Forger","Gargoyle","Hammer","Isolator","Jackhammer","Kingslayer","Lipstick","Mutilator","Nightbringer","Oppressor","Painstaker","Queueskipper","Romeo","Saintkiller","Themebreaker","Usurper","Victor","Wildfire","Xray","Yardstick","Zoomlock"]
//TODO
#define CRA_UNIT_NAMES_FRIENDLY ["Angel","Blackjack","Checkmark","Dolphin","Eagle","Foxhound","Greyhound","Hotdog","Icebreaker","Jester","Kilo","Lonestar","Minuteman","November","Oscar","Papa","Quebec","Relinquisher","Sentinel","Tango","Uniform","Vindicator","Whisky","Xray","Yankee","Zulu"]
// TODO
#define CRA_UNIT_NAMES_NEUTRAL ["Alpha","Buzzkill","Charlie","Delta","Echo","Foxtrot","Gamma","Hotel","India","Juliett","Kilo","Lima","Mike","Nosebleeder","Oscar","Partypooper","Quebec","Roadkill","Sierra","Tango","Uniform","Victor","Whisky","Xray","Yankee","Zulu"]
#define CRA_UNIT_FACES_EXCLUDE ["GreekHead_A3_10_a","GreekHead_A3_10_l","GreekHead_A3_10_sa","PersianHead_A3_04_a","PersianHead_A3_04_l","PersianHead_A3_04_sa","WhiteHead_22_a","WhiteHead_22_l","WhiteHead_22_sa","Custom"]
#define CRA_UNIT_VOICE_EXCLUDE ["Male01ENGVR","Male01GREVR","Male01PERVR"]
#define CRA_UNIT_PITCH_MIN 0.95
#define CRA_UNIT_PITCH_VARIANCE 0.1

#define CRA_UNIT_UNIFORM ["U_C_Protagonist_VR"]
#define CRA_UNIT_UNIFORM_CIVILIAN ["U_Competitor", "U_C_IDAP_Man_cargo_F", "U_C_IDAP_Man_Jeans_F", "U_C_IDAP_Man_casual_F", "U_C_IDAP_Man_shorts_F", "U_C_IDAP_Man_Tee_F", "U_C_IDAP_Man_TeeShorts_F", "U_C_ArtTShirt_01_v6_F", "U_C_ArtTShirt_01_v1_F", "U_C_Man_casual_2_F", "U_C_ArtTShirt_01_v2_F", "U_C_ArtTShirt_01_v4_F", "U_C_Man_casual_3_F", "U_C_Man_casual_1_F", "U_C_ArtTShirt_01_v5_F", "U_C_ArtTShirt_01_v3_F", "U_C_Poloshirt_blue", "U_C_Poloshirt_burgundy", "U_C_Poloshirt_redwhite", "U_C_Poloshirt_salmon", "U_C_Poloshirt_stripped", "U_C_Poloshirt_tricolour", "U_OrestesBody", "U_Marshal", "U_C_Uniform_Scientist_02_formal_F", "U_C_man_sport_1_F", "U_C_man_sport_3_f", "U_C_man_sport_2_F", "U_C_Man_casual_6_F", "U_C_Man_casual_4_F", "U_C_Man_casual_5_F"]
#define CRA_UNIT_UNIFORM_CIVILIAN_MEDIC ["U_C_Paramedic_01_F"]
#define CRA_UNIT_UNIFORM_CIVILIAN_UTILITY ["U_C_Poor_1","U_C_Mechanic_01_F","U_O_R_Gorka_01_black_F","U_C_ConstructionCoverall_Vrana_F","U_C_ConstructionCoverall_Red_F","U_C_ConstructionCoverall_Blue_F","U_C_ConstructionCoverall_Black_F"]
#define CRA_UNIT_UNIFORM_LOOTER ["U_I_L_Uniform_01_tshirt_olive_F","U_I_L_Uniform_01_tshirt_skull_F","U_I_L_Uniform_01_tshirt_sport_F","U_C_Mechanic_01_F","U_I_C_Soldier_Bandit_1_F","U_I_C_Soldier_Bandit_2_F","U_I_C_Soldier_Bandit_3_F","U_I_C_Soldier_Bandit_4_F","U_I_C_Soldier_Bandit_5_F","U_C_HunterBody_grn","U_C_Poor_1","U_C_E_LooterJacket_01_F","U_I_L_Uniform_01_tshirt_black_F"]
#define CRA_UNIT_UNIFORM_CARTEL ["U_I_C_Soldier_Camo_F","U_I_C_Soldier_Para_5_F","U_I_L_Uniform_01_tshirt_olive_F","U_I_L_Uniform_01_tshirt_skull_F","U_I_L_Uniform_01_tshirt_sport_F","U_C_Mechanic_01_F","U_I_C_Soldier_Bandit_2_F","U_I_C_Soldier_Bandit_3_F","U_I_C_Soldier_Bandit_5_F","U_C_HunterBody_grn","U_C_Poor_1","U_C_E_LooterJacket_01_F","U_I_L_Uniform_01_tshirt_black_F"]
#define CRA_UNIT_UNIFORM_ARMY ["U_O_T_Soldier_F"]
#define CRA_UNIT_UNIFORM_ARMY_LEADER ["U_O_T_Officer_F"]

#define CRA_UNIT_VEST [[1.0],[[]]]
#define CRA_UNIT_VEST_PLAYER [[0.3,0.4,0.2,0.1],[[],[CRA_INDEX_VEST_PLAIN],[CRA_INDEX_VEST_RIG],[CRA_INDEX_VEST_ARMOR]]]
#define CRA_UNIT_VEST_CIVILIAN [[0.75,0.25],[[],[CRA_INDEX_VEST_CIVILIAN]]] // TODO rangemasterbelt with pistol holster?
#define CRA_UNIT_VEST_CIVILIAN_MEDIC [[0.75,0.25],[[],[CRA_INDEX_VEST_CIVILIAN_MEDIC]]] // TODO rangemasterbelt with pistol holster?
#define CRA_UNIT_VEST_CIVILIAN_UTILITY [[1.00],[[CRA_INDEX_VEST_CIVILIAN_UTILITY]]] // TODO rangemasterbelt with pistol holster?
#define CRA_UNIT_VEST_LOOTER [[0.75,0.20,0.05],[[],[CRA_INDEX_VEST_PLAIN],[CRA_INDEX_VEST_RIG]]]
#define CRA_UNIT_VEST_CARTEL [[0.15,0.65,0.20],[[CRA_INDEX_VEST_PLAIN],[CRA_INDEX_VEST_RIG],[CRA_INDEX_VEST_ARMOR]]]
#define CRA_UNIT_VEST_ARMY [[0.5,0.5],[[CRA_INDEX_VEST_RIG],[CRA_INDEX_VEST_ARMOR]]]

#define CRA_UNIT_BACKPACK [[1.0],[[]]]
#define CRA_UNIT_BACKPACK_PLAYER [[0.75,0.15,0.10],[[],[CRA_INDEX_BACKPACK_SMALL],[CRA_INDEX_BACKPACK_MEDIUM]]]
#define CRA_UNIT_BACKPACK_CIVILIAN [[0.80,0.20],[[],[CRA_INDEX_BACKPACK_CIVILIAN]]]
#define CRA_UNIT_BACKPACK_CIVILIAN_MEDIC [[1.00],[[CRA_INDEX_BACKPACK_CIVILIAN_MEDIC]]]
#define CRA_UNIT_BACKPACK_CIVILIAN_UTILITY [[1.00],[[CRA_INDEX_BACKPACK_CIVILIAN_UTILITY]]]
#define CRA_UNIT_BACKPACK_LOOTER [[0.90,0.10],[[],[CRA_INDEX_BACKPACK_SMALL]]]
#define CRA_UNIT_BACKPACK_CARTEL [[0.85,0.15],[[],[CRA_INDEX_BACKPACK_SMALL]]]
#define CRA_UNIT_BACKPACK_CARTEL_BIG [[1.0],[[CRA_INDEX_BACKPACK_MEDIUM]]]
#define CRA_UNIT_BACKPACK_ARMY [[1.0],[[CRA_INDEX_BACKPACK_MEDIUM]]]
#define CRA_UNIT_BACKPACK_ARMY_BIG [[1.0],[[CRA_INDEX_BACKPACK_LARGE]]]

#define CRA_UNIT_HEADGEAR [[1.0],[[]]]
#define CRA_UNIT_HEADGEAR_CIVILIAN [[0.15,0.85],[[],[CRA_INDEX_HEADGEAR_CIVILIAN]]]
#define CRA_UNIT_HEADGEAR_CIVILIAN_MEDIC [[0.50,0.50],[[],[CRA_INDEX_HEADGEAR_CIVILIAN_MEDIC]]]
#define CRA_UNIT_HEADGEAR_CIVILIAN_UTILITY [[0.10,0.90],[[],[CRA_INDEX_HEADGEAR_CIVILIAN_UTILITY]]]
#define CRA_UNIT_HEADGEAR_LOOTER [[0.15,0.85],[[],[CRA_INDEX_HEADGEAR_HAT]]]
#define CRA_UNIT_HEADGEAR_CARTEL [[0.15,0.60,0.25],[[],[CRA_INDEX_HEADGEAR_HAT],[CRA_INDEX_HEADGEAR_HELMET]]]
#define CRA_UNIT_HEADGEAR_CARTEL_LEADER [[0.10,0.30,0.60],[[],[CRA_INDEX_HEADGEAR_HAT],[CRA_INDEX_HEADGEAR_LEADER]]]
#define CRA_UNIT_HEADGEAR_ARMY [[0.05,0.95],[[],[CRA_INDEX_HEADGEAR_HELMET]]]
#define CRA_UNIT_HEADGEAR_ARMY_LEADER [[0.10,0.95],[[],[CRA_INDEX_HEADGEAR_LEADER]]]

#define CRA_UNIT_GLASSES [[1.0],[[]]]
#define CRA_UNIT_GLASSES_CIVILIAN [[0.40,0.00],[[],[CRA_INDEX_GLASSES]]] // TODO includes bandanas, etc.
#define CRA_UNIT_GLASSES_LOOTER [[0.25,0.75],[[],[CRA_INDEX_GLASSES]]]
#define CRA_UNIT_GLASSES_CARTEL [[0.50,0.50],[[],[CRA_INDEX_GLASSES]]]
#define CRA_UNIT_GLASSES_CARTEL_LEADER [[0.05,0.95],[[],[CRA_INDEX_GLASSES]]]
#define CRA_UNIT_GLASSES_ARMY [[0.75,0.25],[[],[CRA_INDEX_GLASSES]]]
#define CRA_UNIT_GLASSES_ARMY_LEADER [[0.1,0.9],[[],[CRA_INDEX_GLASSES]]]

#define CRA_INV_BINO [["Binocular","","","",[],[],""]]
#define CRA_IPB_BINO [0.0]
#define CRA_IPB_BINO_CIVILIAN [0.02]
#define CRA_IPB_BINO_CIVILIAN_MEDIC [0.00]
#define CRA_IPB_BINO_CIVILIAN_UTILITY [0.00]
#define CRA_IPB_BINO_LOOTER [0.10]
#define CRA_IPB_BINO_CARTEL_LEADER [0.50]
#define CRA_IPB_BINO_ARMY_LEADER [1.00]

#define CRA_INV_LINKED [["ItemMap"],["ItemGPS"],["ItemRadio"],["ItemCompass"],["ItemWatch"],["NVGoggles"]]
#define CRA_IPB_LINKED [[0.0],[0.0],[0.0],[0.0],[0.0],[0.0]]
#define CRA_IPB_LINKED_CIVILIAN [[0.05],[0.05],[0.02],[0.02],[0.5],[0.0]]
#define CRA_IPB_LINKED_CIVILIAN_MEDIC [[0.05],[0.05],[0.25],[0.02],[0.5],[0.0]]
#define CRA_IPB_LINKED_CIVILIAN_UTILITY [[0.25],[0.15],[0.25],[0.02],[0.5],[0.0]]
#define CRA_IPB_LINKED_LOOTER [[0.125],[0.0],[0.1],[0.125],[0.25],[0.0]]
#define CRA_IPB_LINKED_CARTEL [[0.20],[0.05],[0.50],[0.20],[0.50],[0.05]]
#define CRA_IPB_LINKED_CARTEL_LEADER [[0.75],[0.10],[1.0],[0.50],[0.75],[0.05]]
#define CRA_IPB_LINKED_ARMY [[0.25],[0.05],[1.0],[0.25],[1.0],[0.1]]
#define CRA_IPB_LINKED_ARMY_LEADER [[1.0],[0.15],[1.0],[1.0],[1.0],[0.1]]

#define CRA_INV_PRI []
#define CRA_INV_PRI_ARMY [0,[CRA_INDEX_WEAPON_SMG,CRA_INDEX_WEAPON_CAR,CRA_INDEX_WEAPON_AR]]
#define CRA_INV_PRI_ARMY_MG [0,[CRA_INDEX_WEAPON_ARSW,CRA_INDEX_WEAPON_LMG,CRA_INDEX_WEAPON_MMG]]
#define CRA_INV_PRI_ARMY_DMM [0,[CRA_INDEX_WEAPON_ARM,CRA_INDEX_WEAPON_SRM,CRA_INDEX_WEAPON_SRSO]]
#define CRA_INV_PRI_ARMY_UGL [0,[CRA_INDEX_WEAPON_ARGL]]
#define CRA_INV_PRI_ARMY_AT [0,[CRA_INDEX_WEAPON_AT]]
#define CRA_INV_PRI_ARMY_AA [0,[CRA_INDEX_WEAPON_AA]]

#define CRA_INV_PRI_CARTEL [0,[CRA_INDEX_WEAPON_SMG,CRA_INDEX_WEAPON_CAR,CRA_INDEX_WEAPON_AR]]
#define CRA_INV_PRI_CARTEL_MG [0,[CRA_INDEX_WEAPON_ARSW,CRA_INDEX_WEAPON_LMG]]
#define CRA_INV_PRI_CARTEL_DMM [0,[CRA_INDEX_WEAPON_CAR,CRA_INDEX_WEAPON_AR,CRA_INDEX_WEAPON_SRM,CRA_INDEX_WEAPON_SRSO]]
#define CRA_INV_PRI_CARTEL_UGL [0,[CRA_INDEX_WEAPON_ARGL]]
#define CRA_INV_PRI_CARTEL_AT [0,[CRA_INDEX_WEAPON_AT]]

#define CRA_INV_PRI_LOOTER_PISTOL [0,[CRA_INDEX_WEAPON_HG]]
#define CRA_INV_PRI_LOOTER_SMG [-1,[CRA_INDEX_WEAPON_SMG]]
#define CRA_INV_PRI_LOOTER_SG [0,[CRA_INDEX_WEAPON_SG]]
#define CRA_INV_PRI_LOOTER_RIFLE [-2,[CRA_INDEX_WEAPON_AR,CRA_INDEX_WEAPON_CAR,CRA_INDEX_WEAPON_SRM]]

#define CRA_INV_SEC []
#define CRA_INV_SEC_ARMY [0,[CRA_INDEX_WEAPON_HG]]
#define CRA_INV_SEC_ARMY_AT [0,[CRA_INDEX_WEAPON_SMG]]
#define CRA_INV_SEC_CARTEL [0,[CRA_INDEX_WEAPON_HG]]
#define CRA_INV_SEC_CARTEL_AT [0,[CRA_INDEX_WEAPON_SMG]]
#define CRA_INV_TER []

#define CRA_UNIT_ITEM_UNIFORM_ITEMS [[CRA_INDEX_FIRSTAIDKIT]]
#define CRA_UNIT_ITEM_UNIFORM_FAK [0,0,0]
#define CRA_UNIT_ITEM_UNIFORM_FAK_PLAYER [0.50,1.00,2.50]
#define CRA_UNIT_ITEM_UNIFORM_FAK_LOOTER [0.50,1.00,2.50]
#define CRA_UNIT_ITEM_UNIFORM_FAK_CARTEL [0.50,1.25,2.50]
#define CRA_UNIT_ITEM_UNIFORM_FAK_CARTEL_MED [0,0,0]
#define CRA_UNIT_ITEM_UNIFORM_FAK_ARMY [0.50,1.50,3.50]
#define CRA_UNIT_ITEM_UNIFORM_FAK_ARMY_MED [0,0,0]
#define CRA_UNIT_ITEM_UNIFORM [CRA_UNIT_ITEM_UNIFORM_FAK]
#define CRA_UNIT_ITEM_UNIFORM_PLAYER [CRA_UNIT_ITEM_UNIFORM_FAK_PLAYER]
#define CRA_UNIT_ITEM_UNIFORM_LOOTER [CRA_UNIT_ITEM_UNIFORM_FAK_LOOTER]
#define CRA_UNIT_ITEM_UNIFORM_CARTEL [CRA_UNIT_ITEM_UNIFORM_FAK_CARTEL]
#define CRA_UNIT_ITEM_UNIFORM_CARTEL_MED [CRA_UNIT_ITEM_UNIFORM_FAK_CARTEL_MED]
#define CRA_UNIT_ITEM_UNIFORM_ARMY [CRA_UNIT_ITEM_UNIFORM_FAK_ARMY]
#define CRA_UNIT_ITEM_UNIFORM_ARMY_MED [CRA_UNIT_ITEM_UNIFORM_FAK_ARMY_MED]

#define CRA_UNIT_ITEM_VEST_ITEMS []
#define CRA_UNIT_ITEM_VEST []

#define CRA_UNIT_ITEM_BACKPACK_ITEMS [[CRA_INDEX_FIRSTAIDKIT],[CRA_INDEX_MEDIKIT],[CRA_INDEX_TOOLKIT]]
#define CRA_UNIT_ITEM_BACKPACK_FAK [0,0,0]
#define CRA_UNIT_ITEM_BACKPACK_FAK_CARTEL_MED [1.50,3.50,5.50]
#define CRA_UNIT_ITEM_BACKPACK_FAK_ARMY_MED [2.50,4.50,6.50]
#define CRA_UNIT_ITEM_BACKPACK_MEDIKIT [0,0,0]
#define CRA_UNIT_ITEM_BACKPACK_MEDIKIT_CARTEL_MED [0.75,1.25,1.75]
#define CRA_UNIT_ITEM_BACKPACK_MEDIKIT_ARMY_MED [0.75,1.50,2.00]
#define CRA_UNIT_ITEM_BACKPACK_TOOLKIT [0,0,0]
#define CRA_UNIT_ITEM_BACKPACK_TOOLKIT_ARMY_ENG [0.75,1.50,2.00]
#define CRA_UNIT_ITEM_BACKPACK [CRA_UNIT_ITEM_BACKPACK_FAK,CRA_UNIT_ITEM_BACKPACK_MEDIKIT,CRA_UNIT_ITEM_BACKPACK_TOOLKIT]
#define CRA_UNIT_ITEM_BACKPACK_CARTEL_MED [CRA_UNIT_ITEM_BACKPACK_FAK_CARTEL_MED,CRA_UNIT_ITEM_BACKPACK_MEDIKIT_CARTEL_MED,CRA_UNIT_ITEM_BACKPACK_TOOLKIT]
#define CRA_UNIT_ITEM_BACKPACK_ARMY_MED [CRA_UNIT_ITEM_BACKPACK_FAK_ARMY_MED,CRA_UNIT_ITEM_BACKPACK_MEDIKIT_ARMY_MED,CRA_UNIT_ITEM_BACKPACK_TOOLKIT]
#define CRA_UNIT_ITEM_BACKPACK_ARMY_ENG [CRA_UNIT_ITEM_BACKPACK_FAK,CRA_UNIT_ITEM_BACKPACK_MEDIKIT,CRA_UNIT_ITEM_BACKPACK_TOOLKIT_ARMY_ENG]


#define CRA_UNIT_MAG_UNIFORM_MAGS [[CRA_INDEX_THROW_UTIL],[CRA_INDEX_THROW_GRENADE]]
#define CRA_UNIT_MAG_UNIFORM_THROW_UTIL [0,0,0]
#define CRA_UNIT_MAG_UNIFORM_THROW_UTIL_CARTEL [0.50,0.75,1.50]
#define CRA_UNIT_MAG_UNIFORM_THROW_UTIL_ARMY [0.50,1.00,2.50]
#define CRA_UNIT_MAG_UNIFORM_THROW_GRENADE [0,0,0]
#define CRA_UNIT_MAG_UNIFORM_THROW_GRENADE_CARTEL [0.25,0.50,1.25]
#define CRA_UNIT_MAG_UNIFORM_THROW_GRENADE_ARMY [0.25,0.50,2.50]
#define CRA_UNIT_MAG_UNIFORM [CRA_UNIT_MAG_UNIFORM_THROW_UTIL,CRA_UNIT_MAG_UNIFORM_THROW_GRENADE]
#define CRA_UNIT_MAG_UNIFORM_PLAYER [CRA_UNIT_MAG_UNIFORM_THROW_UTIL,CRA_UNIT_MAG_UNIFORM_THROW_GRENADE]
#define CRA_UNIT_MAG_UNIFORM_CARTEL [CRA_UNIT_MAG_UNIFORM_THROW_UTIL_CARTEL,CRA_UNIT_MAG_UNIFORM_THROW_GRENADE_CARTEL]
#define CRA_UNIT_MAG_UNIFORM_ARMY [CRA_UNIT_MAG_UNIFORM_THROW_UTIL_ARMY,CRA_UNIT_MAG_UNIFORM_THROW_GRENADE_ARMY]

#define CRA_UNIT_MAG_VEST_MAGS [[CRA_INDEX_THROW_UTIL],[CRA_INDEX_THROW_GRENADE]]
#define CRA_UNIT_MAG_VEST_THROW_UTIL [0,0,0]
#define CRA_UNIT_MAG_VEST_THROW_UTIL_CARTEL [0.25,0.50,1.75]
#define CRA_UNIT_MAG_VEST_THROW_UTIL_ARMY [0.50,0.75,3.50]
#define CRA_UNIT_MAG_VEST_THROW_GRENADE [0,0,0]
#define CRA_UNIT_MAG_VEST_THROW_GRENADE_CARTEL [0.50,1.00,1.25]
#define CRA_UNIT_MAG_VEST_THROW_GRENADE_CARTEL_UGL [0.25,0.50,1.25]
#define CRA_UNIT_MAG_VEST_THROW_GRENADE_ARMY [0.50,1.25,2.50]
#define CRA_UNIT_MAG_VEST_THROW_GRENADE_ARMY_UGL [0.25,0.50,1.50]
#define CRA_UNIT_MAG_VEST [CRA_UNIT_MAG_VEST_THROW_UTIL,CRA_UNIT_MAG_VEST_THROW_GRENADE]
#define CRA_UNIT_MAG_VEST_CARTEL [CRA_UNIT_MAG_VEST_THROW_UTIL_CARTEL,CRA_UNIT_MAG_VEST_THROW_GRENADE_CARTEL]
#define CRA_UNIT_MAG_VEST_CARTEL_UGL [CRA_UNIT_MAG_VEST_THROW_UTIL_CARTEL,CRA_UNIT_MAG_VEST_THROW_GRENADE_CARTEL_UGL]
#define CRA_UNIT_MAG_VEST_ARMY [CRA_UNIT_MAG_VEST_THROW_UTIL_ARMY,CRA_UNIT_MAG_VEST_THROW_GRENADE_ARMY]
#define CRA_UNIT_MAG_VEST_ARMY_UGL [CRA_UNIT_MAG_VEST_THROW_UTIL_ARMY,CRA_UNIT_MAG_VEST_THROW_GRENADE_ARMY_UGL]

#define CRA_UNIT_MAG_BACKPACK_MAGS [[CRA_INDEX_MINE]]
#define CRA_UNIT_MAG_BACKPACK_MINE [0,0,0]
#define CRA_UNIT_MAG_BACKPACK_MINE_ARMY_ENG [0.50,0.75,4.50]
#define CRA_UNIT_MAG_BACKPACK [CRA_UNIT_MAG_BACKPACK_MINE]
#define CRA_UNIT_MAG_BACKPACK_ARMY_ENG [CRA_UNIT_MAG_BACKPACK_MINE_ARMY_ENG]

#define CRA_UNIT_CIVILIAN_0 "C_man_1"
#define CRA_UNIT_CIVILIAN_MEDIC "C_Man_Paramedic_01_F"
#define CRA_UNIT_CIVILIAN_UTILITY "C_Man_UtilityWorker_01_F"

#define CRA_UNIT_LOOTER_0 "I_L_Looter_Pistol_F"
#define CRA_UNIT_LOOTER_1 "I_L_Looter_SMG_F"
#define CRA_UNIT_LOOTER_2 "I_L_Looter_SG_F"
#define CRA_UNIT_LOOTER_3 "I_L_Looter_Rifle_F"

#define CRA_UNIT_CARTEL_LEADER_0 "I_C_Soldier_Bandit_4_F"
#define CRA_UNIT_CARTEL_GRUNT_0 "I_C_Soldier_Bandit_7_F"
#define CRA_UNIT_CARTEL_MG_0 "I_C_Soldier_Bandit_3_F"
#define CRA_UNIT_CARTEL_DMM_0 "I_C_Soldier_Bandit_5_F"
#define CRA_UNIT_CARTEL_UGL_0 "I_C_Soldier_Bandit_6_F"
#define CRA_UNIT_CARTEL_MED_0 "I_C_Soldier_Bandit_1_F"
#define CRA_UNIT_CARTEL_AT_0 "I_C_Soldier_Bandit_2_F"

#define CRA_UNIT_ARMY_LEADER_0 "O_T_Officer_F"
#define CRA_UNIT_ARMY_LEADER_1 "O_T_Soldier_TL_F"
#define CRA_UNIT_ARMY_LEADER_2 "O_T_Soldier_SL_F"
#define CRA_UNIT_ARMY_GRUNT_0 "O_T_Soldier_F"
#define CRA_UNIT_ARMY_MG_0 "O_T_Soldier_AR_F"
#define CRA_UNIT_ARMY_DMM_0 "O_T_Soldier_M_F"
#define CRA_UNIT_ARMY_UGL_0 "O_T_Soldier_GL_F"
#define CRA_UNIT_ARMY_MED_0 "O_T_Medic_F"
#define CRA_UNIT_ARMY_ENG_0 "O_T_Engineer_F"
#define CRA_UNIT_ARMY_AT_0 "O_T_Soldier_AT_F"
#define CRA_UNIT_ARMY_AA_0 "O_T_Soldier_AA_F"

#define CRA_SQUAD_TYPE_BASIC 0
#define CRA_SQUAD_TYPE_RECON 1
#define CRA_SQUAD_TYPE_URBAN 2
#define CRA_SQUAD_TYPE_ELITE 3
#define CRA_SQUAD_TYPE_DIVER 4

#define CRA_SQUAD_LOOTER_LEADER [CRA_UNIT_LOOTER_0,CRA_UNIT_LOOTER_1,CRA_UNIT_LOOTER_2,CRA_UNIT_LOOTER_3]
#define CRA_SQUAD_LOOTER_GRUNT [CRA_UNIT_LOOTER_0]
#define CRA_SQUAD_LOOTER_MG [CRA_UNIT_LOOTER_1]
#define CRA_SQUAD_LOOTER_DMM [CRA_UNIT_LOOTER_2,CRA_UNIT_LOOTER_3]
#define CRA_SQUAD_LOOTER [[8,4,4],[CRA_SQUAD_LOOTER_GRUNT,CRA_SQUAD_LOOTER_MG,CRA_SQUAD_LOOTER_DMM]]

#define CRA_SQUAD_CARTEL_LEADER [CRA_UNIT_CARTEL_LEADER_0]
#define CRA_SQUAD_CARTEL_GRUNT [CRA_UNIT_CARTEL_GRUNT_0]
#define CRA_SQUAD_CARTEL_MG [CRA_UNIT_CARTEL_MG_0]
#define CRA_SQUAD_CARTEL_DMM [CRA_UNIT_CARTEL_DMM_0]
#define CRA_SQUAD_CARTEL_UGL [CRA_UNIT_CARTEL_UGL_0]
#define CRA_SQUAD_CARTEL_MED [CRA_UNIT_CARTEL_MED_0]
#define CRA_SQUAD_CARTEL_AT [CRA_UNIT_CARTEL_AT_0]
#define CRA_SQUAD_CARTEL [[8,2,2,2,1,1],[CRA_SQUAD_CARTEL_GRUNT,CRA_SQUAD_CARTEL_MG,CRA_SQUAD_CARTEL_DMM,CRA_SQUAD_CARTEL_UGL,CRA_SQUAD_CARTEL_MED,CRA_SQUAD_CARTEL_AT]]

#define CRA_SQUAD_ARMY_LEADER [CRA_UNIT_ARMY_LEADER_0,CRA_UNIT_ARMY_LEADER_1,CRA_UNIT_ARMY_LEADER_2]
#define CRA_SQUAD_ARMY_GRUNT [CRA_UNIT_ARMY_GRUNT_0]
#define CRA_SQUAD_ARMY_MG [CRA_UNIT_ARMY_MG_0]
#define CRA_SQUAD_ARMY_DMM [CRA_UNIT_ARMY_DMM_0]
#define CRA_SQUAD_ARMY_UGL [CRA_UNIT_ARMY_UGL_0]
#define CRA_SQUAD_ARMY_MED [CRA_UNIT_ARMY_MED_0]
#define CRA_SQUAD_ARMY_ENG [CRA_UNIT_ARMY_ENG_0]
#define CRA_SQUAD_ARMY_AT [CRA_UNIT_ARMY_AT_0]
#define CRA_SQUAD_ARMY_AA [CRA_UNIT_ARMY_AA_0]
#define CRA_SQUAD_ARMY [[6,2,2,2,1,1,1,1],[CRA_SQUAD_ARMY_GRUNT,CRA_SQUAD_ARMY_MG,CRA_SQUAD_ARMY_DMM,CRA_SQUAD_ARMY_UGL,CRA_SQUAD_ARMY_MED,CRA_SQUAD_ARMY_ENG,CRA_SQUAD_ARMY_AT,CRA_SQUAD_ARMY_AA]]

#define CRA_FACTION_OPFOR_ARMY 0
#define CRA_FACTION_IDFOR_LOOTER 1
#define CRA_FACTION_IDFOR_CARTEL 2

#define CRA_FACTION_OPFOR [[[1.0],[CRA_FACTION_OPFOR_ARMY]]]
#define CRA_FACTION_IDFOR [\
[[1.00,0.00],[CRA_FACTION_IDFOR_LOOTER,CRA_FACTION_IDFOR_CARTEL]],\
[[0.80,0.20],[CRA_FACTION_IDFOR_LOOTER,CRA_FACTION_IDFOR_CARTEL]],\
[[0.64,0.36],[CRA_FACTION_IDFOR_LOOTER,CRA_FACTION_IDFOR_CARTEL]],\
[[0.51,0.49],[CRA_FACTION_IDFOR_LOOTER,CRA_FACTION_IDFOR_CARTEL]],\
[[0.40,0.60],[CRA_FACTION_IDFOR_LOOTER,CRA_FACTION_IDFOR_CARTEL]],\
[[0.31,0.69],[CRA_FACTION_IDFOR_LOOTER,CRA_FACTION_IDFOR_CARTEL]],\
[[0.23,0.77],[CRA_FACTION_IDFOR_LOOTER,CRA_FACTION_IDFOR_CARTEL]],\
[[0.17,0.83],[CRA_FACTION_IDFOR_LOOTER,CRA_FACTION_IDFOR_CARTEL]],\
[[0.13,0.87],[CRA_FACTION_IDFOR_LOOTER,CRA_FACTION_IDFOR_CARTEL]],\
[[0.09,0.91],[CRA_FACTION_IDFOR_LOOTER,CRA_FACTION_IDFOR_CARTEL]],\
[[0.06,0.94],[CRA_FACTION_IDFOR_LOOTER,CRA_FACTION_IDFOR_CARTEL]],\
[[0.04,0.96],[CRA_FACTION_IDFOR_LOOTER,CRA_FACTION_IDFOR_CARTEL]],\
[[0.03,0.97],[CRA_FACTION_IDFOR_LOOTER,CRA_FACTION_IDFOR_CARTEL]],\
[[0.02,0.98],[CRA_FACTION_IDFOR_LOOTER,CRA_FACTION_IDFOR_CARTEL]],\
[[0.01,0.99],[CRA_FACTION_IDFOR_LOOTER,CRA_FACTION_IDFOR_CARTEL]],\
[[0.00,1.00],[CRA_FACTION_IDFOR_LOOTER,CRA_FACTION_IDFOR_CARTEL]],\
[[0.00,1.00],[CRA_FACTION_IDFOR_LOOTER,CRA_FACTION_IDFOR_CARTEL]]]

