# CHVD-Exile-Updated
CHVD Viewdistance script Updated and tweaked for Exile.
This is repository for saving the old CHVD View Distance Script (Arma 3) Scripted version.
I updated and tweaked it slightly (added min & max values etc) and fixed some bugs. 

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
// Available options 3.125 / 6.25 / 12.5 / 25 / 50 - (Highest 3.125 (Best Quality) - Lowest 50 (Worst Quality aka "No Grass"))
CHVD_maxGrid = 3.125;
CHVD_minGrid = 25;
////
```

4. Add/merge the "stringtable.xml" to your mission folder. (If you don't have one, just put it into the mission root).
