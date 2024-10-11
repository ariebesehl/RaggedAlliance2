
#include "\a3\ui_f\hpp\defineCommonGrids.inc"
import RscObject;
import RscText;
import RscFrame;
import RscLine;
import RscProgress;
import RscPicture;
import RscPictureKeepAspect;
import RscVideo;
import RscHTML;
import RscButton;
import RscShortcutButton;
import RscEdit;
import RscCombo;
import RscListBox;
import RscListNBox;
import RscXListBox;
import RscTree;
import RscSlider;
import RscXSliderH;
import RscActiveText;
import RscActivePicture;
import RscActivePictureKeepAspect;
import RscStructuredText;
import RscToolbox;
import RscControlsGroup;
import RscControlsGroupNoScrollbars;
import RscControlsGroupNoHScrollbars;
import RscControlsGroupNoVScrollbars;
import RscButtonTextOnly;
import RscButtonMenu;
import RscButtonMenuOK;
import RscButtonMenuCancel;
import RscButtonMenuSteam;
import RscMapControl;
import RscMapControlEmpty;
import RscCheckBox;

#include "CRQ__Display.hpp"
#include "..\CQM\CQM__Display.hpp"

#define CRQ_GUI_CMD_BUTTON_OK "(ctrlParent (_this#0)) closeDisplay 1;"
#define CRQ_GUI_CMD_BUTTON_CANCEL "(ctrlParent (_this#0)) closeDisplay 2;"
#define CRQ_GUI_CMD_LMB_OK "if (_this#1 == 0) then {(ctrlParent (_this#0)) closeDisplay 1;};"
#define CRQ_GUI_CMD_LMB_CANCEL "if (_this#1 == 0) then {(ctrlParent (_this#0)) closeDisplay 2;};"

#define CRQ_GUI_DIMX_WINDOW (40 * GUI_GRID_CENTER_W)
#define CRQ_GUI_DIMY_WINDOW (26 * GUI_GRID_CENTER_H)
#define CRQ_GUI_DIMX_TITLE (CRQ_GUI_DIMX_WINDOW)
#define CRQ_GUI_DIMY_TITLE (GUI_GRID_CENTER_H)
#define CRQ_GUI_DIMX_TASKBAR (CRQ_GUI_DIMX_WINDOW)
#define CRQ_GUI_DIMY_TASKBAR (1.5 * GUI_GRID_CENTER_H)
#define CRQ_GUI_DIMX_CLIENT (CRQ_GUI_DIMX_WINDOW)
#define CRQ_GUI_DIMY_CLIENT (CRQ_GUI_DIMY_WINDOW - CRQ_GUI_DIMY_TITLE - CRQ_GUI_DIMY_TASKBAR)
#define CRQ_GUI_DIMX_DESKTOP (CRQ_GUI_DIMX_WINDOW)
#define CRQ_GUI_DIMY_DESKTOP (CRQ_GUI_DIMY_WINDOW - CRQ_GUI_DIMY_TASKBAR)

#define CRQ_GUI_DIMX_CANCEL (GUI_GRID_CENTER_W)
#define CRQ_GUI_DIMY_CANCEL (CRQ_GUI_DIMY_TITLE)
#define CRQ_GUI_DIMX_BUTTON (8 * GUI_GRID_CENTER_W)
#define CRQ_GUI_DIMY_BUTTON (1 * GUI_GRID_CENTER_H)
#define CRQ_GUI_DIMX_TILE (CRQ_GUI_DIMX_TASKBAR / 16)
#define CRQ_GUI_DIMY_TILE (CRQ_GUI_DIMY_TASKBAR)

#define CRQ_GUI_DIMX_OK (CRQ_GUI_DIMX_BUTTON)
#define CRQ_GUI_DIMY_OK (CRQ_GUI_DIMY_BUTTON)
#define CRQ_GUI_DIMX_LIST (CRQ_GUI_DIMX_BUTTON)
#define CRQ_GUI_DIMY_LIST (CRQ_GUI_DIMY_CLIENT)
#define CRQ_GUI_DIMX_MAP (CRQ_GUI_DIMX_CLIENT)
#define CRQ_GUI_DIMY_MAP (CRQ_GUI_DIMY_CLIENT)

#define CRQ_GUI_POSX_WINDOW (GUI_GRID_CENTER_X)
#define CRQ_GUI_POSY_WINDOW (GUI_GRID_CENTER_Y)
#define CRQ_GUI_POSX_DESKTOP (CRQ_GUI_POSX_WINDOW)
#define CRQ_GUI_POSY_DESKTOP (CRQ_GUI_POSY_WINDOW)
#define CRQ_GUI_POSX_TITLE (CRQ_GUI_POSX_WINDOW)
#define CRQ_GUI_POSY_TITLE (CRQ_GUI_POSY_WINDOW)
#define CRQ_GUI_POSX_CLIENT (CRQ_GUI_POSX_WINDOW)
#define CRQ_GUI_POSY_CLIENT (CRQ_GUI_POSY_WINDOW + CRQ_GUI_DIMY_TITLE)
#define CRQ_GUI_POSX_TASKBAR (CRQ_GUI_POSX_WINDOW)
#define CRQ_GUI_POSY_TASKBAR (CRQ_GUI_POSY_WINDOW + CRQ_GUI_DIMY_WINDOW - CRQ_GUI_DIMY_TASKBAR)

#define CRQ_GUI_POSX_CANCEL (CRQ_GUI_POSX_TITLE + CRQ_GUI_DIMX_TITLE - CRQ_GUI_DIMX_CANCEL)
#define CRQ_GUI_POSY_CANCEL (CRQ_GUI_POSY_TITLE)

#define CRQ_GUI_POSX_MAP (CRQ_GUI_POSX_CLIENT)
#define CRQ_GUI_POSY_MAP (CRQ_GUI_POSY_CLIENT)
#define CRQ_GUI_POSX_LIST (CRQ_GUI_POSX_CLIENT)
#define CRQ_GUI_POSY_LIST (CRQ_GUI_POSY_CLIENT)
#define CRQ_GUI_POSX_OK (CRQ_GUI_POSX_CLIENT + CRQ_GUI_DIMX_CLIENT - CRQ_GUI_DIMX_OK)
#define CRQ_GUI_POSY_OK (CRQ_GUI_POSY_CLIENT + CRQ_GUI_DIMY_CLIENT - CRQ_GUI_DIMY_OK)

#define CRQ_GUI_POSX_TILE_0 (CRQ_GUI_POSX_TASKBAR + 0 * CRQ_GUI_DIMX_TILE)
#define CRQ_GUI_POSX_TILE_1 (CRQ_GUI_POSX_TASKBAR + 1 * CRQ_GUI_DIMX_TILE)
#define CRQ_GUI_POSX_TILE_2 (CRQ_GUI_POSX_TASKBAR + 2 * CRQ_GUI_DIMX_TILE)
#define CRQ_GUI_POSX_TILE_3 (CRQ_GUI_POSX_TASKBAR + 3 * CRQ_GUI_DIMX_TILE)
#define CRQ_GUI_POSX_TILE_4 (CRQ_GUI_POSX_TASKBAR + 4 * CRQ_GUI_DIMX_TILE)
#define CRQ_GUI_POSX_TILE_5 (CRQ_GUI_POSX_TASKBAR + 5 * CRQ_GUI_DIMX_TILE)
#define CRQ_GUI_POSX_TILE_6 (CRQ_GUI_POSX_TASKBAR + 6 * CRQ_GUI_DIMX_TILE)
#define CRQ_GUI_POSX_TILE_7 (CRQ_GUI_POSX_TASKBAR + 7 * CRQ_GUI_DIMX_TILE)
#define CRQ_GUI_POSX_TILE_8 (CRQ_GUI_POSX_TASKBAR + 8 * CRQ_GUI_DIMX_TILE)
#define CRQ_GUI_POSX_TILE_9 (CRQ_GUI_POSX_TASKBAR + 9 * CRQ_GUI_DIMX_TILE)
#define CRQ_GUI_POSX_TILE_10 (CRQ_GUI_POSX_TASKBAR + 10 * CRQ_GUI_DIMX_TILE)
#define CRQ_GUI_POSX_TILE_11 (CRQ_GUI_POSX_TASKBAR + 11 * CRQ_GUI_DIMX_TILE)
#define CRQ_GUI_POSX_TILE_12 (CRQ_GUI_POSX_TASKBAR + 12 * CRQ_GUI_DIMX_TILE)
#define CRQ_GUI_POSX_TILE_13 (CRQ_GUI_POSX_TASKBAR + 13 * CRQ_GUI_DIMX_TILE)
#define CRQ_GUI_POSX_TILE_14 (CRQ_GUI_POSX_TASKBAR + 14 * CRQ_GUI_DIMX_TILE)
#define CRQ_GUI_POSX_TILE_15 (CRQ_GUI_POSX_TASKBAR + 15 * CRQ_GUI_DIMX_TILE)

class CRQ_GUI_CTRL_TITLE: RscText {
	idc = -1;
	style = "0x2";
	colorBackground[] = CQM_GUI_COLOR_TITLE;
	x = CRQ_GUI_POSX_TITLE;
	y = CRQ_GUI_POSY_TITLE;
	w = CRQ_GUI_DIMX_TITLE;
	h = CRQ_GUI_DIMY_TITLE;
};
class CRQ_GUI_CTRL_CANCEL: RscButton {
	idc = -1;
	text = "X";
	onButtonClick = CRQ_GUI_CMD_BUTTON_CANCEL;
	colorBackground[] = CQM_GUI_COLOR_TITLE;
	x = CRQ_GUI_POSX_CANCEL;
	y = CRQ_GUI_POSY_CANCEL;
	w = CRQ_GUI_DIMX_CANCEL;
	h = CRQ_GUI_DIMY_CANCEL;
};
class CRQ_GUI_CTRL_CLIENT: RscText {
	idc = -1;
	text = "";
	colorBackground[] = CQM_GUI_COLOR_CLIENT;
	x = CRQ_GUI_POSX_CLIENT;
	y = CRQ_GUI_POSY_CLIENT;
	w = CRQ_GUI_DIMX_CLIENT;
	h = CRQ_GUI_DIMY_CLIENT;
};
class CRQ_GUI_CTRL_DESKTOP: RscPicture {
	idc = -1;
	text = "";
	x = CRQ_GUI_POSX_DESKTOP;
	y = CRQ_GUI_POSY_DESKTOP;
	w = CRQ_GUI_DIMX_DESKTOP;
	h = CRQ_GUI_DIMY_DESKTOP;
};
class CRQ_GUI_CTRL_TASKBAR: RscText {
	idc = -1;
	text = "";
	colorBackground[] = CQM_GUI_COLOR_TITLE;
	x = CRQ_GUI_POSX_TASKBAR;
	y = CRQ_GUI_POSY_TASKBAR;
	w = CRQ_GUI_DIMX_TASKBAR;
	h = CRQ_GUI_DIMY_TASKBAR;
};
class CRQ_GUI_CTRL_TEXT: RscText {
	idc = -1;
	text = "";
	style = "0x210";
	x = CRQ_GUI_POSX_CLIENT;
	y = CRQ_GUI_POSY_CLIENT;
	w = CRQ_GUI_DIMX_CLIENT;
	h = CRQ_GUI_DIMY_CLIENT;
};
class CRQ_GUI_CTRL_MAP: RscMapControl {
	idc = -1;
	x = CRQ_GUI_POSX_MAP;
	y = CRQ_GUI_POSY_MAP;
	w = CRQ_GUI_DIMX_MAP;
	h = CRQ_GUI_DIMY_MAP;
	maxSatelliteAlpha = 0; // used to hide map textures
	alphaFadeStartScale = 0; // used to hide map textures
	alphaFadeEndScale = 0; // used to hide map textures
};
class CRQ_GUI_CTRL_LIST: RscListBox {
	idc = -1;
	x = CRQ_GUI_POSX_LIST;
	y = CRQ_GUI_POSY_LIST;
	w = CRQ_GUI_DIMX_LIST;
	h = CRQ_GUI_DIMY_LIST;
};
class CRQ_GUI_CTRL_LISTMAX: RscListNBox {
	idc = -1;
	x = CRQ_GUI_POSX_CLIENT;
	y = CRQ_GUI_POSY_CLIENT;
	w = CRQ_GUI_DIMX_CLIENT;
	h = CRQ_GUI_DIMY_CLIENT;
};
class CRQ_GUI_CTRL_OK: RscButton {
	idc = -1;
	text = "OK";
	onButtonClick = CRQ_GUI_CMD_BUTTON_OK;
	x = CRQ_GUI_POSX_OK;
	y = CRQ_GUI_POSY_OK;
	w = CRQ_GUI_DIMX_OK;
	h = CRQ_GUI_DIMY_OK;
};
class CRQ_GUI_CTRL_EXIT: CRQ_GUI_CTRL_OK {
	text = "Exit";
	onButtonClick = CRQ_GUI_CMD_BUTTON_CANCEL;
};
class CRQ_GUI_CTRL_TILE_0: RscActivePictureKeepAspect {
	idc = -1;
	text = CQM_GUI_IMG_LAPTOP_TILE_0;
	tooltip = CQM_GUI_TIP_LAPTOP_TILE_0;
	onMouseButtonUp = "if (_this#1 == 0) then {[ctrlParent (_this#0), 0] call CRQ_DisplayLaptopTile;};";
	x = CRQ_GUI_POSX_TILE_0;
	y = CRQ_GUI_POSY_TASKBAR;
	w = CRQ_GUI_DIMX_TILE;
	h = CRQ_GUI_DIMY_TILE;
};
class CRQ_GUI_CTRL_TILE_1: CRQ_GUI_CTRL_TILE_0 {x = CRQ_GUI_POSX_TILE_1; text = CQM_GUI_IMG_LAPTOP_TILE_1; tooltip = CQM_GUI_TIP_LAPTOP_TILE_1; onMouseButtonUp = "if (_this#1 == 0) then {[ctrlParent (_this#0), 1] call CRQ_DisplayLaptopTile;};";};
class CRQ_GUI_CTRL_TILE_2: CRQ_GUI_CTRL_TILE_0 {x = CRQ_GUI_POSX_TILE_2; text = CQM_GUI_IMG_LAPTOP_TILE_2; tooltip = CQM_GUI_TIP_LAPTOP_TILE_2; onMouseButtonUp = "if (_this#1 == 0) then {[ctrlParent (_this#0), 2] call CRQ_DisplayLaptopTile;};";};
class CRQ_GUI_CTRL_TILE_3: CRQ_GUI_CTRL_TILE_0 {x = CRQ_GUI_POSX_TILE_3; text = CQM_GUI_IMG_LAPTOP_TILE_3; tooltip = CQM_GUI_TIP_LAPTOP_TILE_3; onMouseButtonUp = "if (_this#1 == 0) then {[ctrlParent (_this#0), 3] call CRQ_DisplayLaptopTile;};";};
class CRQ_GUI_CTRL_TILE_4: CRQ_GUI_CTRL_TILE_0 {x = CRQ_GUI_POSX_TILE_4; text = CQM_GUI_IMG_LAPTOP_TILE_4; tooltip = CQM_GUI_TIP_LAPTOP_TILE_4; onMouseButtonUp = "if (_this#1 == 0) then {[ctrlParent (_this#0), 4] call CRQ_DisplayLaptopTile;};";};
class CRQ_GUI_CTRL_TILE_5: CRQ_GUI_CTRL_TILE_0 {x = CRQ_GUI_POSX_TILE_5; text = CQM_GUI_IMG_LAPTOP_TILE_5; tooltip = CQM_GUI_TIP_LAPTOP_TILE_5; onMouseButtonUp = "if (_this#1 == 0) then {[ctrlParent (_this#0), 5] call CRQ_DisplayLaptopTile;};";};
class CRQ_GUI_CTRL_TILE_6: CRQ_GUI_CTRL_TILE_0 {x = CRQ_GUI_POSX_TILE_6; text = CQM_GUI_IMG_LAPTOP_TILE_6; tooltip = CQM_GUI_TIP_LAPTOP_TILE_6; onMouseButtonUp = "if (_this#1 == 0) then {[ctrlParent (_this#0), 6] call CRQ_DisplayLaptopTile;};";};
class CRQ_GUI_CTRL_TILE_7: CRQ_GUI_CTRL_TILE_0 {x = CRQ_GUI_POSX_TILE_7; text = CQM_GUI_IMG_LAPTOP_TILE_7; tooltip = CQM_GUI_TIP_LAPTOP_TILE_7; onMouseButtonUp = "if (_this#1 == 0) then {[ctrlParent (_this#0), 7] call CRQ_DisplayLaptopTile;};";};
class CRQ_GUI_CTRL_TILE_8: CRQ_GUI_CTRL_TILE_0 {x = CRQ_GUI_POSX_TILE_8; text = CQM_GUI_IMG_LAPTOP_TILE_8; tooltip = CQM_GUI_TIP_LAPTOP_TILE_8; onMouseButtonUp = "if (_this#1 == 0) then {[ctrlParent (_this#0), 8] call CRQ_DisplayLaptopTile;};";};
class CRQ_GUI_CTRL_TILE_9: CRQ_GUI_CTRL_TILE_0 {x = CRQ_GUI_POSX_TILE_9; text = CQM_GUI_IMG_LAPTOP_TILE_9; tooltip = CQM_GUI_TIP_LAPTOP_TILE_9; onMouseButtonUp = "if (_this#1 == 0) then {[ctrlParent (_this#0), 9] call CRQ_DisplayLaptopTile;};";};
class CRQ_GUI_CTRL_TILE_10: CRQ_GUI_CTRL_TILE_0 {x = CRQ_GUI_POSX_TILE_10; text = CQM_GUI_IMG_LAPTOP_TILE_10; tooltip = CQM_GUI_TIP_LAPTOP_TILE_10; onMouseButtonUp = "if (_this#1 == 0) then {[ctrlParent (_this#0), 10] call CRQ_DisplayLaptopTile;};";};
class CRQ_GUI_CTRL_TILE_11: CRQ_GUI_CTRL_TILE_0 {x = CRQ_GUI_POSX_TILE_11; text = CQM_GUI_IMG_LAPTOP_TILE_11; tooltip = CQM_GUI_TIP_LAPTOP_TILE_11; onMouseButtonUp = "if (_this#1 == 0) then {[ctrlParent (_this#0), 11] call CRQ_DisplayLaptopTile;};";};
class CRQ_GUI_CTRL_TILE_12: CRQ_GUI_CTRL_TILE_0 {x = CRQ_GUI_POSX_TILE_12; text = CQM_GUI_IMG_LAPTOP_TILE_12; tooltip = CQM_GUI_TIP_LAPTOP_TILE_12; onMouseButtonUp = "if (_this#1 == 0) then {[ctrlParent (_this#0), 12] call CRQ_DisplayLaptopTile;};";};
class CRQ_GUI_CTRL_TILE_13: CRQ_GUI_CTRL_TILE_0 {x = CRQ_GUI_POSX_TILE_13; text = CQM_GUI_IMG_LAPTOP_TILE_13; tooltip = CQM_GUI_TIP_LAPTOP_TILE_13; onMouseButtonUp = "if (_this#1 == 0) then {[ctrlParent (_this#0), 13] call CRQ_DisplayLaptopTile;};";};
class CRQ_GUI_CTRL_TILE_14: CRQ_GUI_CTRL_TILE_0 {x = CRQ_GUI_POSX_TILE_14; text = CQM_GUI_IMG_LAPTOP_TILE_14; tooltip = CQM_GUI_TIP_LAPTOP_TILE_14; onMouseButtonUp = "if (_this#1 == 0) then {[ctrlParent (_this#0), 14] call CRQ_DisplayLaptopTile;};";};
class CRQ_GUI_CTRL_TILE_15: CRQ_GUI_CTRL_TILE_0 {x = CRQ_GUI_POSX_TILE_15; text = CQM_GUI_IMG_LAPTOP_TILE_15; tooltip = CQM_GUI_TIP_LAPTOP_TILE_15; onMouseButtonUp = "if (_this#1 == 0) then {[ctrlParent (_this#0), 15] call CRQ_DisplayLaptopTile;};";};

class CRQ_GUI_DISP_LAPTOP_ROOT {
	idd = CRQ_GUI_ID_LAPTOP_ROOT;
	onUnload = "_this call CRQ_DisplayLaptopExit;";
	class ControlsBackground {
		class CRQ_GUI_DISP_LAPTOP_DESKTOP : CRQ_GUI_CTRL_DESKTOP {
			idc = CRQ_GUI_ID_LAPTOP_DESKTOP;
			text = CQM_GUI_IMG_LAPTOP_DESKTOP;
		};
		class CRQ_GUI_DISP_LAPTOP_TASKBAR: CRQ_GUI_CTRL_TASKBAR {
			idc = CRQ_GUI_ID_LAPTOP_TASKBAR;
		};
	};
	class Controls {
		class CRQ_GUI_DISP_LAPTOP_TILE_0 : CRQ_GUI_CTRL_TILE_0 {idc = CRQ_GUI_ID_LAPTOP_TILE_0;};
		class CRQ_GUI_DISP_LAPTOP_TILE_1 : CRQ_GUI_CTRL_TILE_1 {idc = CRQ_GUI_ID_LAPTOP_TILE_1;};
		class CRQ_GUI_DISP_LAPTOP_TILE_2 : CRQ_GUI_CTRL_TILE_2 {idc = CRQ_GUI_ID_LAPTOP_TILE_2;};
		class CRQ_GUI_DISP_LAPTOP_TILE_3 : CRQ_GUI_CTRL_TILE_3 {idc = CRQ_GUI_ID_LAPTOP_TILE_3;};
		class CRQ_GUI_DISP_LAPTOP_TILE_4 : CRQ_GUI_CTRL_TILE_4 {idc = CRQ_GUI_ID_LAPTOP_TILE_4;};
		class CRQ_GUI_DISP_LAPTOP_TILE_5 : CRQ_GUI_CTRL_TILE_5 {idc = CRQ_GUI_ID_LAPTOP_TILE_5;};
		class CRQ_GUI_DISP_LAPTOP_TILE_6 : CRQ_GUI_CTRL_TILE_6 {idc = CRQ_GUI_ID_LAPTOP_TILE_6;};
		class CRQ_GUI_DISP_LAPTOP_TILE_7 : CRQ_GUI_CTRL_TILE_7 {idc = CRQ_GUI_ID_LAPTOP_TILE_7;};
		class CRQ_GUI_DISP_LAPTOP_TILE_8 : CRQ_GUI_CTRL_TILE_8 {idc = CRQ_GUI_ID_LAPTOP_TILE_8;};
		class CRQ_GUI_DISP_LAPTOP_TILE_9 : CRQ_GUI_CTRL_TILE_9 {idc = CRQ_GUI_ID_LAPTOP_TILE_9;};
		class CRQ_GUI_DISP_LAPTOP_TILE_10 : CRQ_GUI_CTRL_TILE_10 {idc = CRQ_GUI_ID_LAPTOP_TILE_10;};
		class CRQ_GUI_DISP_LAPTOP_TILE_11 : CRQ_GUI_CTRL_TILE_11 {idc = CRQ_GUI_ID_LAPTOP_TILE_11;};
		class CRQ_GUI_DISP_LAPTOP_TILE_12 : CRQ_GUI_CTRL_TILE_12 {idc = CRQ_GUI_ID_LAPTOP_TILE_12;};
		class CRQ_GUI_DISP_LAPTOP_TILE_13 : CRQ_GUI_CTRL_TILE_13 {idc = CRQ_GUI_ID_LAPTOP_TILE_13;};
		class CRQ_GUI_DISP_LAPTOP_TILE_14 : CRQ_GUI_CTRL_TILE_14 {idc = CRQ_GUI_ID_LAPTOP_TILE_14;};
		class CRQ_GUI_DISP_LAPTOP_TILE_15 : CRQ_GUI_CTRL_TILE_15 {idc = CRQ_GUI_ID_LAPTOP_TILE_15;};
	};
};

class CRQ_GUI_DISP_MAP_ROOT {
	idd = CRQ_GUI_ID_MAP_ROOT;
	onUnload = "_this call CRQ_DisplayMapExit";
	class ControlsBackground {
		class CRQ_GUI_DISP_MAP_TITLE: CRQ_GUI_CTRL_TITLE {
			idc = CRQ_GUI_ID_MAP_TITLE;
			moving = true;
		};
		class CRQ_GUI_DISP_MAP_MAP: CRQ_GUI_CTRL_MAP {
			idc = CRQ_GUI_ID_MAP_MAP;
			onDraw = "(_this#0) call CRQ_DisplayMapDraw";
			onMouseButtonUp = "_this call CRQ_DisplayMapSelectMap;";
		};
	};
	class Controls {
		class CRQ_GUI_DISP_MAP_CANCEL: CRQ_GUI_CTRL_CANCEL {
			idc = CRQ_GUI_ID_MAP_CANCEL;
		};
		class CRQ_GUI_DISP_MAP_LIST: CRQ_GUI_CTRL_LIST {
			idc = CRQ_GUI_ID_MAP_LIST;
			onLBSelChanged = "_this call CRQ_DisplayMapSelectList;";
			onLBDblClick = CRQ_GUI_CMD_BUTTON_OK;
		};
		class CRQ_GUI_DISP_MAP_OK: CRQ_GUI_CTRL_OK {
			idc = CRQ_GUI_ID_MAP_OK;
		};
	};
};

#include "..\CQM\CQM_Display.hpp"

