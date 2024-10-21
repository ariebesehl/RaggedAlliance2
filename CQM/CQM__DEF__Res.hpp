
#include "CRA__DEF__Res.hpp"

class CfgUnitInsignia {
	class CRA_INSIGNIA_ROOT {
		author = "cr4qsh0t & others";
		material = "\A3\Ui_f\data\GUI\Cfg\UnitInsignia\default_insignia.rvmat";
	};
	class CRA_INSIGNIA_EAGLE: CRA_INSIGNIA_ROOT {
		displayName = "2nd R.E.C.O.N. Incision";
		texture = "res\CRA-ui-insignia-128-eagle.png.paa";
	};
	class CRA_INSIGNIA_GOAT: CRA_INSIGNIA_ROOT {
		displayName = "6th Underground Regiment";
		texture = "res\CRA-ui-insignia-128-goat.png.paa";
	};
	class CRA_INSIGNIA_PARROT_A: CRA_INSIGNIA_ROOT {
		displayName = "7th Para-Rooster";
		texture = "res\CRA-ui-insignia-128-parrot-a.png.paa";
	};
	class CRA_INSIGNIA_PARROT_B: CRA_INSIGNIA_ROOT {
		displayName = "9th Para-Rooster";
		texture = "res\CRA-ui-insignia-128-parrot-b.png.paa";
	};
	class CRA_INSIGNIA_SKULL: CRA_INSIGNIA_ROOT {
		displayName = "4th Division a.k.a. 'Death-Defiers'";
		texture = "res\CRA-ui-insignia-128-skull.png.paa";
	};
	class CRA_INSIGNIA_TREE: CRA_INSIGNIA_ROOT {
		displayName = "1st Response a.k.a. 'Leaf'";
		texture = "res\CRA-ui-insignia-128-tree.png.paa";
	};
	class CRA_INSIGNIA_WOLF: CRA_INSIGNIA_ROOT {
		displayName = "5th J.P. a.k.a. 'Cubs'";
		texture = "res\CRA-ui-insignia-128-wolf.png.paa";
	};
};

class CfgSounds {
	sounds[] = {};
	class CRA_RES_SOUND_UI_MESSAGE {
		sound[] = {CRA_PATH_SOUND_UI_MESSAGE, CRA_MIXING_SOUND_UI_MASTER + 0, 1};
		titles[] = {0, "[UI: Message]"};
	};
	class CRA_RES_SOUND_UI_NOTIFY {
		sound[] = {CRA_PATH_SOUND_UI_NOTIFY, CRA_MIXING_SOUND_UI_MASTER + 0, 1};
		titles[] = {0, "[UI: Notification]"};
	};
};

class CfgMusic {
	tracks[] = {};
	class CRA_RES_MUSIC_ORIG_LOSS {
		sound[] = {CRA_PATH_MUSIC_ORIG_LOSS, CRA_MIXING_MUSIC_MASTER + 0, 1};
		titles[] = {0, "[Soundtrack: Intro]"};
	};
	class CRA_RES_MUSIC_ORIG_WIN {
		sound[] = {CRA_PATH_MUSIC_ORIG_WIN, CRA_MIXING_MUSIC_MASTER + 0, 1};
		titles[] = {0, "[Soundtrack: Victory]"};
	};
	class CRA_RES_MUSIC_ORIG_INTRO {
		sound[] = {CRA_PATH_MUSIC_ORIG_INTRO, CRA_MIXING_MUSIC_MASTER + 0, 1};
		titles[] = {0, "[Soundtrack: Defeat]"};
	};
	class CRA_RES_MUSIC_ORIG_UI {
		sound[] = {CRA_PATH_MUSIC_ORIG_UI, CRA_MIXING_MUSIC_MASTER + 0, 1};
		titles[] = {0, "[Soundtrack: User Interface]"};
	};
	class CRA_RES_MUSIC_ORIG_MODE_STEALTH_A {
		sound[] = {CRA_PATH_MUSIC_ORIG_MODE_STEALTH_A, CRA_MIXING_MUSIC_MASTER + 0, 1};
		titles[] = {0, "[Soundtrack: Stealth-A]"};
	};
	class CRA_RES_MUSIC_ORIG_MODE_STEALTH_B {
		sound[] = {CRA_PATH_MUSIC_ORIG_MODE_STEALTH_B, CRA_MIXING_MUSIC_MASTER + 0, 1};
		titles[] = {0, "[Soundtrack: Stealth-B]"};
	};
	class CRA_RES_MUSIC_ORIG_MODE_STEALTH_C {
		sound[] = {CRA_PATH_MUSIC_ORIG_MODE_STEALTH_C, CRA_MIXING_MUSIC_MASTER + 0, 1};
		titles[] = {0, "[Soundtrack: Stealth-C]"};
	};
	class CRA_RES_MUSIC_ORIG_MODE_COMBAT_A {
		sound[] = {CRA_PATH_MUSIC_ORIG_MODE_COMBAT_A, CRA_MIXING_MUSIC_MASTER + 0, 1};
		titles[] = {0, "[Soundtrack: Combat-A]"};
	};
	class CRA_RES_MUSIC_ORIG_MODE_SAFE_A {
		sound[] = {CRA_PATH_MUSIC_ORIG_MODE_SAFE_A, CRA_MIXING_MUSIC_MASTER + 0, 1};
		titles[] = {0, "[Soundtrack: Safe-A]"};
	};
	class CRA_RES_MUSIC_ORIG_MODE_SAFE_B {
		sound[] = {CRA_PATH_MUSIC_ORIG_MODE_SAFE_B, CRA_MIXING_MUSIC_MASTER + 0, 1};
		titles[] = {0, "[Soundtrack: Safe-B]"};
	};
	class CRA_RES_MUSIC_ORIG_MODE_SAFE_C {
		sound[] = {CRA_PATH_MUSIC_ORIG_MODE_SAFE_C, CRA_MIXING_MUSIC_MASTER + 0, 1};
		titles[] = {0, "[Soundtrack: Safe-C]"};
	};
	class CRA_RES_MUSIC_ORIG_MODE_SAFE_D {
		sound[] = {CRA_PATH_MUSIC_ORIG_MODE_SAFE_D, CRA_MIXING_MUSIC_MASTER + 0, 1};
		titles[] = {0, "[Soundtrack: Safe-D]"};
	};
};
