
#include "CRA__Res.hpp"

class CfgSounds {
	sounds[] = {};
	class CRA_RES_MUSIC_ID_INTRO {
		name = CRA_RES_MUSIC_NAME_INTRO;
		sound[] = {CRA_RES_MUSIC_PATH_INTRO, db + 0, 1.0};
		titles[] = {0, ""};
	};
	class CRA_RES_MUSIC_ID_VICTORY {
		name = CRA_RES_MUSIC_NAME_VICTORY;
		sound[] = {CRA_RES_MUSIC_PATH_VICTORY, db + 0, 1.0};
		titles[] = {0, ""};
	};
	class CRA_RES_MUSIC_ID_LOSS {
		name = CRA_RES_MUSIC_NAME_LOSS;
		sound[] = {CRA_RES_MUSIC_PATH_LOSS, db + 0, 1.0};
		titles[] = {0, ""};
	};
};
