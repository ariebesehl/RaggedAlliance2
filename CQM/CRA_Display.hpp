

#include "CRA__Display.hpp"

class CRA_GUI_DISP_MAIL_ROOT {
	idd = CRA_GUI_ID_MAIL_ROOT;
	onUnload = "_this call CRA_DisplayLaptopMailExit";
	class ControlsBackground {
		class CRA_GUI_DISP_MAIL_TITLE: CRQ_GUI_CTRL_TITLE {
			idc = CRA_GUI_ID_MAIL_TITLE;
		};
		class CRA_GUI_DISP_MAIL_CLIENT: CRQ_GUI_CTRL_CLIENT {
			idc = CRA_GUI_ID_MAIL_CLIENT;
		};
	};
	class Controls {
		class CRA_GUI_DISP_MAIL_CANCEL: CRQ_GUI_CTRL_CANCEL {
			idc = CRA_GUI_ID_MAIL_CANCEL;
		};
		class CRA_GUI_DISP_MAIL_LIST: CRQ_GUI_CTRL_LISTMAX {
			idc = CRA_GUI_ID_MAIL_LIST;
			onLBDblClick = "_this call CRA_DisplayLaptopMailSelect";
		};
	};
};
class CRA_GUI_DISP_MESSAGE_ROOT {
	idd = CRA_GUI_ID_MESSAGE_ROOT;
	onUnload = "_this call CRA_DisplayLaptopMessageExit";
	class ControlsBackground {
		class CRA_GUI_DISP_MESSAGE_TITLE: CRQ_GUI_CTRL_TITLE {
			idc = CRA_GUI_ID_MESSAGE_TITLE;
		};
		class CRA_GUI_DISP_MESSAGE_CLIENT: CRQ_GUI_CTRL_CLIENT {
			idc = CRA_GUI_ID_MESSAGE_CLIENT;
		};
	};
	class Controls {
		class CRA_GUI_DISP_MESSAGE_CANCEL: CRQ_GUI_CTRL_CANCEL {
			idc = CRA_GUI_ID_MESSAGE_CANCEL;
		};
		class CRA_GUI_DISP_MESSAGE_LIST: CRQ_GUI_CTRL_LISTMAX {
			idc = CRA_GUI_ID_MESSAGE_LIST;
			h = 0.25 * CRQ_GUI_DIMY_CLIENT;
		};
		class CRA_GUI_DISP_MESSAGE_TEXT: CRQ_GUI_CTRL_TEXT {
			idc = CRA_GUI_ID_MESSAGE_TEXT;
			y = CRQ_GUI_POSY_CLIENT + 0.25 * CRQ_GUI_DIMY_CLIENT;
			h = 0.75 * CRQ_GUI_DIMY_CLIENT;
		};
	};
};