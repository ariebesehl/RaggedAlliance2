
import RscStructuredText;
import RscText;
import RscPicture;
import RscButton;
import RscListBox;
import RscListNBox;
import RscMapControl;
import RscActivePictureKeepAspect;

#include "CRQ__DEF__Display.hpp"
#include "..\CQM\CQM__DEF__Display.hpp"

#define CRQ_UI_CMD_BUTTON_OK "(ctrlParent (_this#0)) closeDisplay 1;"
#define CRQ_UI_CMD_BUTTON_CANCEL "(ctrlParent (_this#0)) closeDisplay 2;"
#define CRQ_UI_CMD_LMB_OK "if (_this#1 == 0) then {(ctrlParent (_this#0)) closeDisplay 1;};"
#define CRQ_UI_CMD_LMB_CANCEL "if (_this#1 == 0) then {(ctrlParent (_this#0)) closeDisplay 2;};"

// 0LP
#define CRQ_UI_DM_ROOT_W (safezoneW)
#define CRQ_UI_DM_ROOT_H (safezoneH)
// 1LP
#define CRQ_UI_DM_BUTTON_W (0.1000 * (CRQ_UI_DM_ROOT_W))
#define CRQ_UI_DM_BUTTON_H (0.0200 * (CRQ_UI_DM_ROOT_H))
#define CRQ_UI_DM_MAP_W (CRQ_UI_DM_ROOT_W)
#define CRQ_UI_DM_MAP_H (CRQ_UI_DM_ROOT_H)
#define CRQ_UI_DM_TITLE_W (CRQ_UI_DM_ROOT_W)
#define CRQ_UI_DM_TITLE_H (0.0400 * (CRQ_UI_DM_ROOT_H))
#define CRQ_UI_DM_TASKB_W (CRQ_UI_DM_ROOT_W)
#define CRQ_UI_DM_TASKB_H (0.0600 * (CRQ_UI_DM_ROOT_H))
// 2LP
#define CRQ_UI_DM_CANCEL_W (CRQ_UI_DM_BUTTON_W)
#define CRQ_UI_DM_CANCEL_H (CRQ_UI_DM_BUTTON_H)
#define CRQ_UI_DM_OK_W (2 * CRQ_UI_DM_BUTTON_W)
#define CRQ_UI_DM_OK_H (2 * CRQ_UI_DM_BUTTON_H)
#define CRQ_UI_DM_CLOSE_W (0.0250 * (CRQ_UI_DM_ROOT_W))
#define CRQ_UI_DM_CLOSE_H (CRQ_UI_DM_TITLE_H)
#define CRQ_UI_DM_TILE_W (0.0625 * CRQ_UI_DM_TASKB_W)
#define CRQ_UI_DM_TILE_H (CRQ_UI_DM_TASKB_H)
#define CRQ_UI_DM_DESKTOP_W (CRQ_UI_DM_ROOT_W)
#define CRQ_UI_DM_DESKTOP_H (CRQ_UI_DM_ROOT_H - CRQ_UI_DM_TASKB_H)
// 3LP
#define CRQ_UI_DM_CLIENT_W (CRQ_UI_DM_DESKTOP_W)
#define CRQ_UI_DM_CLIENT_H (CRQ_UI_DM_DESKTOP_H - CRQ_UI_DM_TITLE_H)

// 0LP
#define CRQ_UI_DM_ROOT_X (safezoneX)
#define CRQ_UI_DM_ROOT_Y (safezoneY)
// 1LP
#define CRQ_UI_DM_ROOT_CX (CRQ_UI_DM_ROOT_X + 0.5 * CRQ_UI_DM_ROOT_W)
#define CRQ_UI_DM_ROOT_CY (CRQ_UI_DM_ROOT_Y + 0.5 * CRQ_UI_DM_ROOT_H)
#define CRQ_UI_DM_ROOT_R (CRQ_UI_DM_ROOT_X + CRQ_UI_DM_ROOT_W)
#define CRQ_UI_DM_ROOT_B (CRQ_UI_DM_ROOT_Y + CRQ_UI_DM_ROOT_H)
#define CRQ_UI_DM_MAP_X (CRQ_UI_DM_ROOT_X)
#define CRQ_UI_DM_MAP_Y (CRQ_UI_DM_ROOT_Y)
#define CRQ_UI_DM_DESKTOP_X (CRQ_UI_DM_ROOT_X)
#define CRQ_UI_DM_DESKTOP_Y (CRQ_UI_DM_ROOT_Y)

#define CRQ_UI_DM_CANCEL_X (CRQ_UI_DM_ROOT_CX - 0.5 * CRQ_UI_DM_CANCEL_W)
#define CRQ_UI_DM_CANCEL_Y (CRQ_UI_DM_ROOT_Y + 0.9125 * CRQ_UI_DM_ROOT_H)
#define CRQ_UI_DM_OK_X (CRQ_UI_DM_ROOT_CX - 0.5 * CRQ_UI_DM_OK_W)
#define CRQ_UI_DM_OK_Y (CRQ_UI_DM_ROOT_Y + 0.9000 * CRQ_UI_DM_ROOT_H - CRQ_UI_DM_OK_H)

#define CRQ_UI_DM_TITLE_X (CRQ_UI_DM_DESKTOP_X)
#define CRQ_UI_DM_TITLE_Y (CRQ_UI_DM_DESKTOP_Y)
#define CRQ_UI_DM_TASKB_X (CRQ_UI_DM_ROOT_X)
#define CRQ_UI_DM_TASKB_Y (CRQ_UI_DM_ROOT_Y + CRQ_UI_DM_ROOT_H - CRQ_UI_DM_TASKB_H)
#define CRQ_UI_DM_CLIENT_X (CRQ_UI_DM_ROOT_X)
#define CRQ_UI_DM_CLIENT_Y (CRQ_UI_DM_ROOT_Y + CRQ_UI_DM_TITLE_H)
#define CRQ_UI_DM_CLOSE_X (CRQ_UI_DM_TITLE_X + CRQ_UI_DM_TITLE_W - CRQ_UI_DM_CLOSE_W)
#define CRQ_UI_DM_CLOSE_Y (CRQ_UI_DM_TITLE_Y)

#define CRQ_UI_DM_TILE_X_0 (CRQ_UI_DM_TASKB_X + 0 * CRQ_UI_DM_TILE_W)
#define CRQ_UI_DM_TILE_X_1 (CRQ_UI_DM_TASKB_X + 1 * CRQ_UI_DM_TILE_W)
#define CRQ_UI_DM_TILE_X_2 (CRQ_UI_DM_TASKB_X + 2 * CRQ_UI_DM_TILE_W)
#define CRQ_UI_DM_TILE_X_3 (CRQ_UI_DM_TASKB_X + 3 * CRQ_UI_DM_TILE_W)
#define CRQ_UI_DM_TILE_X_4 (CRQ_UI_DM_TASKB_X + 4 * CRQ_UI_DM_TILE_W)
#define CRQ_UI_DM_TILE_X_5 (CRQ_UI_DM_TASKB_X + 5 * CRQ_UI_DM_TILE_W)
#define CRQ_UI_DM_TILE_X_6 (CRQ_UI_DM_TASKB_X + 6 * CRQ_UI_DM_TILE_W)
#define CRQ_UI_DM_TILE_X_7 (CRQ_UI_DM_TASKB_X + 7 * CRQ_UI_DM_TILE_W)
#define CRQ_UI_DM_TILE_X_8 (CRQ_UI_DM_TASKB_X + 8 * CRQ_UI_DM_TILE_W)
#define CRQ_UI_DM_TILE_X_9 (CRQ_UI_DM_TASKB_X + 9 * CRQ_UI_DM_TILE_W)
#define CRQ_UI_DM_TILE_X_10 (CRQ_UI_DM_TASKB_X + 10 * CRQ_UI_DM_TILE_W)
#define CRQ_UI_DM_TILE_X_11 (CRQ_UI_DM_TASKB_X + 11 * CRQ_UI_DM_TILE_W)
#define CRQ_UI_DM_TILE_X_12 (CRQ_UI_DM_TASKB_X + 12 * CRQ_UI_DM_TILE_W)
#define CRQ_UI_DM_TILE_X_13 (CRQ_UI_DM_TASKB_X + 13 * CRQ_UI_DM_TILE_W)
#define CRQ_UI_DM_TILE_X_14 (CRQ_UI_DM_TASKB_X + 14 * CRQ_UI_DM_TILE_W)
#define CRQ_UI_DM_TILE_X_15 (CRQ_UI_DM_TASKB_X + 15 * CRQ_UI_DM_TILE_W)
#define CRQ_UI_DM_TILE_Y (CRQ_UI_DM_TASKB_Y)

class CRQ_UI_CT_BUTTON: RscButton {
	idc = -1;
};
class CRQ_UI_CT_CANCEL: CRQ_UI_CT_BUTTON {
	onButtonClick = CRQ_UI_CMD_BUTTON_CANCEL;
	text = "Cancel";
};
class CRQ_UI_CT_EXIT: CRQ_UI_CT_CANCEL {
	text = "Exit";
};
class CRQ_UI_CT_CLOSE: CRQ_UI_CT_CANCEL {
	text = "Close";
};
class CRQ_UI_CT_NO: CRQ_UI_CT_CANCEL {
	text = "No";
};
class CRQ_UI_CT_OK: CRQ_UI_CT_BUTTON {
	onButtonClick = CRQ_UI_CMD_BUTTON_OK;
	text = "OK";
};
class CRQ_UI_CT_CONFIRM: CRQ_UI_CT_OK {
	text = "Confirm";
};
class CRQ_UI_CT_YES: CRQ_UI_CT_OK {
	text = "Yes";
};
class CRQ_UI_CT_FAKE_BUTTON : RscButton {
	idc = -1;
	onButtonClick = "{}";
};
class CRQ_UI_CT_INFO_DESC: RscStructuredText {
	idc = -1;
	text = "";
	colorBackground[] = CQM_GUI_COLOR_INFO;
	x = CRQ_UI_DM_ROOT_X + 0.36 * CRQ_UI_DM_ROOT_W;
	y = CRQ_UI_DM_ROOT_Y + 0.85 * CRQ_UI_DM_ROOT_H;
	w = CRQ_UI_DM_ROOT_W * 0.28;
	h = CRQ_UI_DM_ROOT_H * 0.025;
};
class CRQ_UI_CT_MAP_ROOT: RscMapControl {
	idc = -1;
	scaleDefault = 0.03125;
	//moveOnEdges = 1; // did not work here?
	maxSatelliteAlpha = 0; // used to hide map textures
	alphaFadeStartScale = 0; // used to hide map textures
	alphaFadeEndScale = 0; // used to hide map textures
	x = CRQ_UI_DM_MAP_X;
	y = CRQ_UI_DM_MAP_Y;
	w = CRQ_UI_DM_MAP_W;
	h = CRQ_UI_DM_MAP_H;
};
class CRQ_UI_CT_MAP_CANCEL: CRQ_UI_CT_EXIT {
	colorBackground[] = CQM_GUI_COLOR_BTTN;
	x = CRQ_UI_DM_MAP_X + CRQ_UI_DM_MAP_W * 0.015;
	y = CRQ_UI_DM_MAP_Y + CRQ_UI_DM_MAP_H * 0.95;
	w = CRQ_UI_DM_MAP_W * 0.15;
	h = CRQ_UI_DM_MAP_H * 0.025;
};
class CRQ_UI_CT_MAP_TITLE: CRQ_UI_CT_FAKE_BUTTON {
	text = "TITLE";
	style = "0x2";
	colorBackground[] = CQM_GUI_COLOR_TITLE;
	x = CRQ_UI_DM_MAP_X + CRQ_UI_DM_MAP_W * 0.835;
	y = CRQ_UI_DM_MAP_Y + CRQ_UI_DM_MAP_H * 0.025;
	w = CRQ_UI_DM_MAP_W * 0.15;
	h = CRQ_UI_DM_MAP_H * 0.025;
};
class CRQ_UI_CT_MAP_LIST: RscListBox {
	idc = -1;
	colorBackground[] = CQM_GUI_COLOR_LIST;
	x = CRQ_UI_DM_MAP_X + CRQ_UI_DM_MAP_W * 0.835;
	y = CRQ_UI_DM_MAP_Y + CRQ_UI_DM_MAP_H * 0.050;
	w = CRQ_UI_DM_MAP_W * 0.15;
	h = CRQ_UI_DM_MAP_H * 0.800;
};
class CRQ_UI_CT_MAP_INFO: RscStructuredText {
	idc = -1;
	onButtonClick = "{}";
	text = "INFO";
	style = "0x0";
	colorBackground[] = CQM_GUI_COLOR_INFO;
	x = CRQ_UI_DM_MAP_X + CRQ_UI_DM_MAP_W * 0.835;
	y = CRQ_UI_DM_MAP_Y + CRQ_UI_DM_MAP_H * 0.85;
	w = CRQ_UI_DM_MAP_W * 0.15;
	h = CRQ_UI_DM_MAP_H * 0.100;
};
class CRQ_UI_CT_MAP_OK: CRQ_UI_CT_OK {
	colorBackground[] = CQM_GUI_COLOR_BTTN;
	x = CRQ_UI_DM_MAP_X + CRQ_UI_DM_MAP_W * 0.835;
	y = CRQ_UI_DM_MAP_Y + CRQ_UI_DM_MAP_H * 0.95;
	w = CRQ_UI_DM_MAP_W * 0.15;
	h = CRQ_UI_DM_MAP_H * 0.025;
};
class CRQ_UI_CT_WIN_TITLE: RscText {
	idc = -1;
	style = "0x2";
	colorBackground[] = CQM_GUI_COLOR_TITLE;
	x = CRQ_UI_DM_TITLE_X;
	y = CRQ_UI_DM_TITLE_Y;
	w = CRQ_UI_DM_TITLE_W;
	h = CRQ_UI_DM_TITLE_H;
};
class CRQ_UI_CT_WIN_X: CRQ_UI_CT_CANCEL {
	text = "X";
	colorBackground[] = CQM_GUI_COLOR_TITLE;
	x = CRQ_UI_DM_CLOSE_X;
	y = CRQ_UI_DM_CLOSE_Y;
	w = CRQ_UI_DM_CLOSE_W;
	h = CRQ_UI_DM_CLOSE_H;
};
class CRQ_UI_CT_WIN_CLIENT: RscText {
	idc = -1;
	text = "";
	colorBackground[] = CQM_GUI_COLOR_CLIENT;
	x = CRQ_UI_DM_CLIENT_X;
	y = CRQ_UI_DM_CLIENT_Y;
	w = CRQ_UI_DM_CLIENT_W;
	h = CRQ_UI_DM_CLIENT_H;
};
class CRQ_UI_CT_WIN_DESKTOP: RscPicture {
	idc = -1;
	text = "";
	x = CRQ_UI_DM_DESKTOP_X;
	y = CRQ_UI_DM_DESKTOP_Y;
	w = CRQ_UI_DM_DESKTOP_W;
	h = CRQ_UI_DM_DESKTOP_H;
};
class CRQ_UI_CT_WIN_TASKBAR: RscText {
	idc = -1;
	text = "";
	colorBackground[] = CQM_GUI_COLOR_TITLE;
	x = CRQ_UI_DM_TASKB_X;
	y = CRQ_UI_DM_TASKB_Y;
	w = CRQ_UI_DM_TASKB_W;
	h = CRQ_UI_DM_TASKB_H;
};
class CRQ_UI_CT_WIN_TEXT: RscText {
	idc = -1;
	text = "";
	style = "0x210";
	x = CRQ_UI_DM_CLIENT_X;
	y = CRQ_UI_DM_CLIENT_Y;
	w = CRQ_UI_DM_CLIENT_W;
	h = CRQ_UI_DM_CLIENT_H;
};
class CRQ_UI_CT_WIN_LIST: RscListNBox {
	idc = -1;
	x = CRQ_UI_DM_CLIENT_X;
	y = CRQ_UI_DM_CLIENT_Y;
	w = CRQ_UI_DM_CLIENT_W;
	h = CRQ_UI_DM_CLIENT_H;
};
class CRQ_UI_CT_TILE_0: RscActivePictureKeepAspect {
	idc = -1;
	text = CQM_GUI_IMG_LAPTOP_TILE_0;
	tooltip = CQM_GUI_TIP_LAPTOP_TILE_0;
	onMouseButtonUp = "if (_this#1 == 0) then {[ctrlParent (_this#0), 0] call CRQ_DisplayLaptopTile;};";
	x = CRQ_UI_DM_TILE_X_0;
	y = CRQ_UI_DM_TILE_Y;
	w = CRQ_UI_DM_TILE_W;
	h = CRQ_UI_DM_TILE_H;
};
class CRQ_UI_CT_TILE_1: CRQ_UI_CT_TILE_0 {x = CRQ_UI_DM_TILE_X_1; text = CQM_GUI_IMG_LAPTOP_TILE_1; tooltip = CQM_GUI_TIP_LAPTOP_TILE_1; onMouseButtonUp = "if (_this#1 == 0) then {[ctrlParent (_this#0), 1] call CRQ_DisplayLaptopTile;};";};
class CRQ_UI_CT_TILE_2: CRQ_UI_CT_TILE_0 {x = CRQ_UI_DM_TILE_X_2; text = CQM_GUI_IMG_LAPTOP_TILE_2; tooltip = CQM_GUI_TIP_LAPTOP_TILE_2; onMouseButtonUp = "if (_this#1 == 0) then {[ctrlParent (_this#0), 2] call CRQ_DisplayLaptopTile;};";};
class CRQ_UI_CT_TILE_3: CRQ_UI_CT_TILE_0 {x = CRQ_UI_DM_TILE_X_3; text = CQM_GUI_IMG_LAPTOP_TILE_3; tooltip = CQM_GUI_TIP_LAPTOP_TILE_3; onMouseButtonUp = "if (_this#1 == 0) then {[ctrlParent (_this#0), 3] call CRQ_DisplayLaptopTile;};";};
class CRQ_UI_CT_TILE_4: CRQ_UI_CT_TILE_0 {x = CRQ_UI_DM_TILE_X_4; text = CQM_GUI_IMG_LAPTOP_TILE_4; tooltip = CQM_GUI_TIP_LAPTOP_TILE_4; onMouseButtonUp = "if (_this#1 == 0) then {[ctrlParent (_this#0), 4] call CRQ_DisplayLaptopTile;};";};
class CRQ_UI_CT_TILE_5: CRQ_UI_CT_TILE_0 {x = CRQ_UI_DM_TILE_X_5; text = CQM_GUI_IMG_LAPTOP_TILE_5; tooltip = CQM_GUI_TIP_LAPTOP_TILE_5; onMouseButtonUp = "if (_this#1 == 0) then {[ctrlParent (_this#0), 5] call CRQ_DisplayLaptopTile;};";};
class CRQ_UI_CT_TILE_6: CRQ_UI_CT_TILE_0 {x = CRQ_UI_DM_TILE_X_6; text = CQM_GUI_IMG_LAPTOP_TILE_6; tooltip = CQM_GUI_TIP_LAPTOP_TILE_6; onMouseButtonUp = "if (_this#1 == 0) then {[ctrlParent (_this#0), 6] call CRQ_DisplayLaptopTile;};";};
class CRQ_UI_CT_TILE_7: CRQ_UI_CT_TILE_0 {x = CRQ_UI_DM_TILE_X_7; text = CQM_GUI_IMG_LAPTOP_TILE_7; tooltip = CQM_GUI_TIP_LAPTOP_TILE_7; onMouseButtonUp = "if (_this#1 == 0) then {[ctrlParent (_this#0), 7] call CRQ_DisplayLaptopTile;};";};
class CRQ_UI_CT_TILE_8: CRQ_UI_CT_TILE_0 {x = CRQ_UI_DM_TILE_X_8; text = CQM_GUI_IMG_LAPTOP_TILE_8; tooltip = CQM_GUI_TIP_LAPTOP_TILE_8; onMouseButtonUp = "if (_this#1 == 0) then {[ctrlParent (_this#0), 8] call CRQ_DisplayLaptopTile;};";};
class CRQ_UI_CT_TILE_9: CRQ_UI_CT_TILE_0 {x = CRQ_UI_DM_TILE_X_9; text = CQM_GUI_IMG_LAPTOP_TILE_9; tooltip = CQM_GUI_TIP_LAPTOP_TILE_9; onMouseButtonUp = "if (_this#1 == 0) then {[ctrlParent (_this#0), 9] call CRQ_DisplayLaptopTile;};";};
class CRQ_UI_CT_TILE_10: CRQ_UI_CT_TILE_0 {x = CRQ_UI_DM_TILE_X_10; text = CQM_GUI_IMG_LAPTOP_TILE_10; tooltip = CQM_GUI_TIP_LAPTOP_TILE_10; onMouseButtonUp = "if (_this#1 == 0) then {[ctrlParent (_this#0), 10] call CRQ_DisplayLaptopTile;};";};
class CRQ_UI_CT_TILE_11: CRQ_UI_CT_TILE_0 {x = CRQ_UI_DM_TILE_X_11; text = CQM_GUI_IMG_LAPTOP_TILE_11; tooltip = CQM_GUI_TIP_LAPTOP_TILE_11; onMouseButtonUp = "if (_this#1 == 0) then {[ctrlParent (_this#0), 11] call CRQ_DisplayLaptopTile;};";};
class CRQ_UI_CT_TILE_12: CRQ_UI_CT_TILE_0 {x = CRQ_UI_DM_TILE_X_12; text = CQM_GUI_IMG_LAPTOP_TILE_12; tooltip = CQM_GUI_TIP_LAPTOP_TILE_12; onMouseButtonUp = "if (_this#1 == 0) then {[ctrlParent (_this#0), 12] call CRQ_DisplayLaptopTile;};";};
class CRQ_UI_CT_TILE_13: CRQ_UI_CT_TILE_0 {x = CRQ_UI_DM_TILE_X_13; text = CQM_GUI_IMG_LAPTOP_TILE_13; tooltip = CQM_GUI_TIP_LAPTOP_TILE_13; onMouseButtonUp = "if (_this#1 == 0) then {[ctrlParent (_this#0), 13] call CRQ_DisplayLaptopTile;};";};
class CRQ_UI_CT_TILE_14: CRQ_UI_CT_TILE_0 {x = CRQ_UI_DM_TILE_X_14; text = CQM_GUI_IMG_LAPTOP_TILE_14; tooltip = CQM_GUI_TIP_LAPTOP_TILE_14; onMouseButtonUp = "if (_this#1 == 0) then {[ctrlParent (_this#0), 14] call CRQ_DisplayLaptopTile;};";};
class CRQ_UI_CT_TILE_15: CRQ_UI_CT_TILE_0 {x = CRQ_UI_DM_TILE_X_15; text = CQM_GUI_IMG_LAPTOP_TILE_15; tooltip = CQM_GUI_TIP_LAPTOP_TILE_15; onMouseButtonUp = "if (_this#1 == 0) then {[ctrlParent (_this#0), 15] call CRQ_DisplayLaptopTile;};";};

class CRQ_GUI_DISP_LAPTOP_ROOT {
	idd = CRQ_UI_ID_LAPTOP_ROOT;
	onUnload = "_this call CRQ_DisplayLaptopExit;";
	class ControlsBackground {
		class CRQ_GUI_DISP_LAPTOP_DESKTOP : CRQ_UI_CT_WIN_DESKTOP {
			idc = CRQ_UI_ID_LAPTOP_DESKTOP;
			text = CQM_GUI_IMG_LAPTOP_DESKTOP;
		};
		class CRQ_GUI_DISP_LAPTOP_TASKBAR: CRQ_UI_CT_WIN_TASKBAR {
			idc = CRQ_UI_ID_LAPTOP_TASKBAR;
		};
	};
	class Controls {
		class CRQ_GUI_DISP_LAPTOP_TILE_0 : CRQ_UI_CT_TILE_0 {idc = CRQ_UI_ID_LAPTOP_TILE_0;};
		class CRQ_GUI_DISP_LAPTOP_TILE_1 : CRQ_UI_CT_TILE_1 {idc = CRQ_UI_ID_LAPTOP_TILE_1;};
		class CRQ_GUI_DISP_LAPTOP_TILE_2 : CRQ_UI_CT_TILE_2 {idc = CRQ_UI_ID_LAPTOP_TILE_2;};
		class CRQ_GUI_DISP_LAPTOP_TILE_3 : CRQ_UI_CT_TILE_3 {idc = CRQ_UI_ID_LAPTOP_TILE_3;};
		class CRQ_GUI_DISP_LAPTOP_TILE_4 : CRQ_UI_CT_TILE_4 {idc = CRQ_UI_ID_LAPTOP_TILE_4;};
		class CRQ_GUI_DISP_LAPTOP_TILE_5 : CRQ_UI_CT_TILE_5 {idc = CRQ_UI_ID_LAPTOP_TILE_5;};
		class CRQ_GUI_DISP_LAPTOP_TILE_6 : CRQ_UI_CT_TILE_6 {idc = CRQ_UI_ID_LAPTOP_TILE_6;};
		class CRQ_GUI_DISP_LAPTOP_TILE_7 : CRQ_UI_CT_TILE_7 {idc = CRQ_UI_ID_LAPTOP_TILE_7;};
		class CRQ_GUI_DISP_LAPTOP_TILE_8 : CRQ_UI_CT_TILE_8 {idc = CRQ_UI_ID_LAPTOP_TILE_8;};
		class CRQ_GUI_DISP_LAPTOP_TILE_9 : CRQ_UI_CT_TILE_9 {idc = CRQ_UI_ID_LAPTOP_TILE_9;};
		class CRQ_GUI_DISP_LAPTOP_TILE_10 : CRQ_UI_CT_TILE_10 {idc = CRQ_UI_ID_LAPTOP_TILE_10;};
		class CRQ_GUI_DISP_LAPTOP_TILE_11 : CRQ_UI_CT_TILE_11 {idc = CRQ_UI_ID_LAPTOP_TILE_11;};
		class CRQ_GUI_DISP_LAPTOP_TILE_12 : CRQ_UI_CT_TILE_12 {idc = CRQ_UI_ID_LAPTOP_TILE_12;};
		class CRQ_GUI_DISP_LAPTOP_TILE_13 : CRQ_UI_CT_TILE_13 {idc = CRQ_UI_ID_LAPTOP_TILE_13;};
		class CRQ_GUI_DISP_LAPTOP_TILE_14 : CRQ_UI_CT_TILE_14 {idc = CRQ_UI_ID_LAPTOP_TILE_14;};
		class CRQ_GUI_DISP_LAPTOP_TILE_15 : CRQ_UI_CT_TILE_15 {idc = CRQ_UI_ID_LAPTOP_TILE_15;};
	};
};

class CRQ_GUI_DISP_MAP_ROOT {
	idd = CRQ_UI_ID_MAP_ROOT;
	onUnload = "_this call CRQ_fnc_UI_MapExit";
	class ControlsBackground {
		class CRQ_GUI_DISP_MAP_MAP: CRQ_UI_CT_MAP_ROOT {
			idc = CRQ_UI_ID_MAP_MAP;
			onDraw = "(_this#0) call CRQ_fnc_UI_MapDraw";
			onMouseButtonUp = "_this call CRQ_fnc_UI_MapSelectMap;";
		};
	};
	class Controls {
		class CRQ_GUI_DISP_MAP_TITLE: CRQ_UI_CT_MAP_TITLE {
			idc = CRQ_UI_ID_MAP_TITLE;
			// moving = true;
		};
		class CRQ_GUI_DISP_MAP_LIST: CRQ_UI_CT_MAP_LIST {
			idc = CRQ_UI_ID_MAP_LIST;
			onLBSelChanged = "_this call CRQ_fnc_UI_MapSelectList;";
			onLBDblClick = CRQ_UI_CMD_BUTTON_OK;
		};
		class CRQ_GUI_DISP_MAP_INFO: CRQ_UI_CT_MAP_INFO {
			idc = CRQ_UI_ID_MAP_INFO;
		};
		class CRQ_GUI_DISP_MAP_OK: CRQ_UI_CT_MAP_OK {
			idc = CRQ_UI_ID_MAP_OK;
		};
		class CRQ_GUI_DISP_MAP_CANCEL: CRQ_UI_CT_MAP_CANCEL {
			idc = CRQ_UI_ID_MAP_CANCEL;
		};
	};
};

#include "..\CQM\CQM__INC__Display.hpp"
