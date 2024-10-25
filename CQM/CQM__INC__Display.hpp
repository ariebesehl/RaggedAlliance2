
#include "CRA__DEF__Display.hpp"

class CRA_GUI_DISP_MAIL_ROOT {
	idd = CRA_GUI_ID_MAIL_ROOT;
	onUnload = "_this call CRA_DisplayLaptopMailExit";
	class ControlsBackground {
		class CRA_GUI_DISP_MAIL_TITLE: CRQ_UI_CT_WIN_TITLE {
			idc = CRA_GUI_ID_MAIL_TITLE;
		};
		class CRA_GUI_DISP_MAIL_CLIENT: CRQ_UI_CT_WIN_CLIENT {
			idc = CRA_GUI_ID_MAIL_CLIENT;
		};
	};
	class Controls {
		class CRA_GUI_DISP_MAIL_CANCEL: CRQ_UI_CT_WIN_X {
			idc = CRA_GUI_ID_MAIL_CANCEL;
		};
		class CRA_GUI_DISP_MAIL_LIST: CRQ_UI_CT_WIN_LIST {
			idc = CRA_GUI_ID_MAIL_LIST;
			onLBDblClick = "_this call CRA_DisplayLaptopMailSelect";
		};
	};
};
class CRA_GUI_DISP_MESSAGE_ROOT {
	idd = CRA_GUI_ID_MESSAGE_ROOT;
	onUnload = "_this call CRA_DisplayLaptopMessageExit";
	class ControlsBackground {
		class CRA_GUI_DISP_MESSAGE_TITLE: CRQ_UI_CT_WIN_TITLE {
			idc = CRA_GUI_ID_MESSAGE_TITLE;
		};
		class CRA_GUI_DISP_MESSAGE_CLIENT: CRQ_UI_CT_WIN_CLIENT {
			idc = CRA_GUI_ID_MESSAGE_CLIENT;
		};
	};
	class Controls {
		class CRA_GUI_DISP_MESSAGE_CANCEL: CRQ_UI_CT_WIN_X {
			idc = CRA_GUI_ID_MESSAGE_CANCEL;
		};
		class CRA_GUI_DISP_MESSAGE_LIST: CRQ_UI_CT_WIN_LIST {
			idc = CRA_GUI_ID_MESSAGE_LIST;
			h = 0.25 * CRQ_UI_DM_CLIENT_H;
		};
		class CRA_GUI_DISP_MESSAGE_TEXT: CRQ_UI_CT_WIN_TEXT {
			idc = CRA_GUI_ID_MESSAGE_TEXT;
			y = CRQ_UI_DM_CLIENT_Y + 0.25 * CRQ_UI_DM_CLIENT_H;
			h = 0.75 * CRQ_UI_DM_CLIENT_H;
		};
	};
};
