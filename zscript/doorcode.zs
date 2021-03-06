/**
 *Copyright (c) 2018-2019 DRRP-Team
 *
 *This software is released under the MIT License.
 *https://opensource.org/licenses/MIT
 */

class DoorCodeInputActor {
    static int DoorCode(Actor activator, string info, string code, int scriptnum) {
        EventHandler.SendNetworkEvent("opendoorinput@@@@" .. info, code.ToInt(), scriptnum);
 
        return 1;
    }
}

class DoorCodeInputStubItem : Inventory {
    String code;
    String displayTooltip;
    int scriptnum;
}

class DoorCodeInputHandler : EventHandler {
    override void OnRegister() {
        SetOrder(666);
    }

    override void NetworkProcess(ConsoleEvent e) {
        Array<string> command;
        e.Name.Split(command, "@@@@");
        if(command[0] == "opendoorinput") {
            if(command.size() == 2) {
                players[e.player].mo.A_GiveInventory("DoorCodeInputStubItem");
				ACS_Suspend(-int(name("lockwindow")), 0);
                DoorCodeInputStubItem item = DoorCodeInputStubItem(players[e.player].mo.findInventory("DoorCodeInputStubItem"));
                item.code = String.format("%d", e.args[0]);
                item.displayTooltip = command[1];
                item.scriptnum = e.args[1];
                Menu.SetMenu("DoorCodeInputMenu");
            }
        } else if (command[0] == "closedoorinput") {
            DoorCodeInputStubItem item = DoorCodeInputStubItem(players[e.player].mo.findInventory("DoorCodeInputStubItem"));
            if(item == null) return;

            if (e.Args[0] == 1) {
                players[e.Player].mo.A_PlaySound("access/grant1");
				ACS_Execute(-int(name("lockwindow")), 0, 0, 0, 0);
            } else if (e.Args[0] == 2) {
                players[e.Player].mo.A_PlaySound("access/deny1");
                players[e.Player].mo.A_Print(StringTable.Localize("$DRRP_D_MENU_PASSCODE_WRONG"));
				ACS_Terminate(-int(name("lockwindow")), 0);
				ACS_Terminate(item.scriptnum, 0);
            } else if (e.Args[0] == 3) {
				ACS_Terminate(-int(name("lockwindow")), 0);
				ACS_Terminate(item.scriptnum, 0);
            }
        }
    }
}

class DoorCodeInputMenu : GenericMenu {
    String codeStr;
    String realCodeStr;
    String displayTooltip;
    
    Override
    void init(Menu parent) {
        DoorCodeInputStubItem item = DoorCodeInputStubItem(players[consoleplayer].mo.findInventory("DoorCodeInputStubItem"));
        if(item == null) {
            codeStr = "____";
            realCodeStr = "0000";
            displayTooltip = "you shouldn't see this\n";
        } else {
            realCodeStr = item.code;
            codeStr = "";
            displayTooltip = item.displayTooltip;

            for(int i = 0; i < self.realCodeStr.Length(); i++) {
                codeStr.AppendFormat("_");
            }
        }
    }
    
    Override
    void drawer() {
        super.drawer();
        let tex = TexMan.CheckForTexture("M_WINDOW", TexMan.Type_MiscPatch);
        if (tex.IsValid()) {
            Vector2 v = TexMan.GetScaledSize(tex);
            int x = 320;
            int y = 320;
            screen.DrawTexture(tex, false, x, y, DTA_LeftOffset, int(v.x / 2), DTA_VirtualWidth, 640, DTA_VirtualHeight, 480);
            Font font = Font.FindFont("SMALLFONT");
            screen.DrawText(font, Font.CR_WHITE, 244, 322, displayTooltip .. " " .. self.codeStr, DTA_VirtualWidth, 640, DTA_VirtualHeight, 480);
        }
    }
    
    Override
    bool OnUIEvent(UIEvent ev) { 
        super.OnUIEvent(ev);
        if (ev.Type == UiEvent.Type_KeyDown && (ev.keyChar >= 48 && ev.keyChar <= 57)) {
            for(int i = 0; i < self.codeStr.Length(); i++) {
                if (self.codeStr.CharAt(i) != '_') continue;
                
                self.codeStr = String.format("%s%c", self.codeStr.Left(i), ev.keyChar);

                for(int j = self.codeStr.Length(); j < self.realCodeStr.Length(); j++) {
                    self.codeStr.AppendFormat("_");
                }

                break;
            }
 
            for(int i = 0; i < self.codeStr.Length(); i++) {
                if (self.codeStr.CharAt(i) == '_') {
                    return true;
                }
            }
            
            EventHandler.SendNetworkEvent("closedoorinput", codeStr == realCodeStr ? 1 : 2);
            Close();
        } else if (ev.Type == UiEvent.Type_KeyDown && ev.keyChar == 27) {
            Close();
        }

        return true;
    }
	
	Override
	bool MenuEvent (int mkey, bool fromcontroller) {
		if(mkey == Menu.MKEY_Back) {
			EventHandler.SendNetworkEvent("closedoorinput", 3);
		}
		return super.MenuEvent(mkey, fromcontroller);
	}
}
