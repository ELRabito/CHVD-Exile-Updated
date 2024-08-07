# CHVD-Exile-Updated

![grafik](https://github.com/ELRabito/CHVD-Exile-Updated/assets/39779934/1a8765c5-977f-4697-9370-b03523a1af53)

CHVD Viewdistance script Updated and tweaked for Exile.
This is repository for saving the old CHVD View Distance Script (Arma 3) Scripted version.
I updated and tweaked it slightly (added configurable min & max values etc) and fixed some bugs.
I recommend to use this version with minimum values since you can abuse the told version.

Original: https://forums.bohemia.net/forums/topic/175757-ch-view-distance-addon/

1. Place the "CHVD" folder in your mission folder.
2. Add/merge this to your description.ext file in your mission folder.
```
#include "CHVD\dialog.hpp"
class CfgFunctions
{
    #include "CHVD\CfgFunctions.hpp"
};
```

3. Add these variable to your initplayerlocal.sqf file in your mission folder:
```
//// CHVD Updated by El' Rabito
//
CHVD_maxView = 2400; // Max Viewdistance
CHVD_minView = 1000; // Min Viewdistance
CHVD_maxObj = 2400; // Max Object Viewdistance
CHVD_minObj = 1000; // Min Object Viewdistance
// Terrain Quality: Available options 3.125 / 6.25 / 12.5 / 25 / 50 - (Highest 3.125 (Best Quality) - Lowest 50 (Worst Quality aka "No Grass"))
CHVD_maxGrid = 3.125;
CHVD_minGrid = 25;
////
```

4. Add/merge the "stringtable.xml" to your mission folder. (If you don't have one, just put it into the mission root).

5. To open the CHVD dialog add this code to your button/script (Xm8 etc) or use/bind the keybinds.
```
call CHVD_fnc_openDialog
```
![grafik](https://github.com/ELRabito/CHVD-Exile-Updated/assets/39779934/0c7c0197-f0f0-4150-aef2-ea1759834d38)

* If you use Infistar add the IDD 2900 to your allowedIDDs inside EXILE_AHAT_CONFIG.

* If you want to remove the Exile part and use it without Exile just remove/replace the lines with the ExileClient_gui_toaster_addTemplateToast calls inside fn_keyDown & fn_keyDownTerrain.
These are only for the Exile Info toast if you use the CHVD keybinds to change viewdistance/terrain grid as seen in the screenshot.

1 - https://github.com/ELRabito/CHVD-Exile-Updated/blob/main/CHVD/fn_keyDown.sqf#L59C1-L59C3

2 - https://github.com/ELRabito/CHVD-Exile-Updated/blob/main/CHVD/fn_keyDownTerrain.sqf#L43
