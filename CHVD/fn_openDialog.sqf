[] spawn {

	if (missionNamespace getVariable ["CHVD_loadingDialog",false]) exitWith {true};
	if (isNull (findDisplay 2900)) then {
		_dialog = createDialog "CHVD_dialog";
		if (!_dialog) exitWith {systemChat "CH View Distance: Error: can't open dialog."};
	};
	
	disableSerialization;
	CHVD_loadingDialog = true;
	
	{
		ctrlSetText _x;
	} forEach [[1006, str round RW_foot],[1007, str round RW_footObj],[1013, str round RW_car],[1014, str round RW_carObj],[1017, str round RW_air],[1018, str round RW_airObj],[1400, str RW_footTerrain],[1401, str RW_carTerrain],[1402, str RW_airTerrain]];
	
	{
		sliderSetRange [_x select 0, 0, _x select 2];
		sliderSetRange [_x select 3, 0, (_x select 5) min (_x select 1)];
		sliderSetSpeed [_x select 0, 500, 500];
		sliderSetSpeed [_x select 3, 500, 500];
		sliderSetPosition [_x select 0, _x select 1];
		sliderSetPosition [_x select 3, (_x select 4) min (_x select 1)];
	} forEach [[1900,RW_foot,CHVD_maxView,1901,RW_footObj,CHVD_maxObj],[1902,RW_car,CHVD_maxView,1903,RW_carObj,CHVD_maxObj],[1904,RW_air,CHVD_maxView,1905,RW_airObj,CHVD_maxObj]];
	
	{
		private _ctrl = ((findDisplay 2900) displayCtrl (_x select 0));
		private _textDisabled = if (isLocalized "STR_chvd_disabled") then {localize "STR_chvd_disabled"} else {"Disabled"};
		_ctrl lbAdd _textDisabled;
		private _textDynamic = if (isLocalized "STR_chvd_dynamic") then {localize "STR_chvd_dynamic"} else {"Dynamic"};
		_ctrl lbAdd _textDynamic;
		_textFov = if (isLocalized "STR_chvd_fov") then {localize "STR_chvd_fov"} else {"FOV"};
		_ctrl lbAdd _textFov;
		_mode = call compile ("RW_" + (_x select 1) + "SyncMode");
		_ctrl lbSetCurSel _mode;
		_handle = _ctrl ctrlSetEventHandler ["LBSelChanged", 
			format ["[_this select 1, '%1',%2,%3,%4] call CHVD_fnc_onLBSelChanged_syncmode", _x select 1, _x select 2, _x select 3, _x select 4]
		];
	} forEach [[1404,"foot",1410,1901,1007], [1406,"car",1409,1903,1014], [1408,"air",1411,1905,1018]];
	
	{
		private _ctrl = _x select 0;
		private _mode = call compile ("RW_" + (_x select 1) + "SyncMode");
		switch (_mode) do {
			case 1: {
			
				private _percentage = call compile ("RW_" + (_x select 1) + "SyncPercentage");
				ctrlSetText [_ctrl, format ["%1",_percentage * 100] + "%"];
				ctrlEnable [_ctrl, true];
			};
			default {
				ctrlEnable [_ctrl, false];
			};
			
		};
		private _ctrlDisplay = (findDisplay 2900) displayCtrl _ctrl;
		_handle = _ctrlDisplay ctrlSetEventHandler ["keyDown", 
			format ["[_this select 0, '%1',%2,%3] call CHVD_fnc_onEBinput_syncmode", _x select 1, _x select 2, _x select 3]
		];
	} forEach [[1410,"foot",1901,1007], [1409,"car",1903,1014], [1411,"air",1905,1018]];
	
	{
		private _ctrl = ((findDisplay 2900) displayCtrl (_x select 0));
		private _textLow = if (isLocalized "STR_chvd_low") then {localize "STR_chvd_low"} else {"Low"};
		_ctrl lbAdd _textLow;
		private _textStandard = if (isLocalized "STR_chvd_standard") then {localize "STR_chvd_standard"} else {"Standard"};
		_ctrl lbAdd _textStandard;
		private _textHigh = if (isLocalized "STR_chvd_high") then {localize "STR_chvd_high"} else {"High"};
		_ctrl lbAdd _textHigh;
		private _textVeryHigh = if (isLocalized "STR_chvd_veryHigh") then {localize "STR_chvd_veryHigh"} else {"Very High"};
		_ctrl lbAdd _textVeryHigh;
		private _textUltra = if (isLocalized "STR_chvd_ultra") then {localize "STR_chvd_ultra"} else {"Ultra"};
		_ctrl lbAdd _textUltra;
		private _sel = [_x select 1] call CHVD_fnc_selTerrainQuality;
		_ctrl lbSetCurSel _sel;
		
	} forEach [[1500,RW_footTerrain],[1501,RW_carTerrain],[1502,RW_airTerrain]];
	
	{
		private _ctrl = ((findDisplay 2900) displayCtrl (_x select 0));
		_handle = _ctrl ctrlSetEventHandler ["LBSelChanged", 
			format ["[_this select 1, '%1', %2] call CHVD_fnc_onLBSelChanged", _x select 1, _x select 2]
		];
	} forEach [[1500,"RW_footTerrain",1400],[1501,"RW_carTerrain",1401],[1502,"RW_airTerrain",1402]];
	
	if (RW_footSyncMode isEqualTo 1) then {
		ctrlEnable [1901,false];
		ctrlEnable [1007,false];
	} else {	
		ctrlEnable [1901,true];
		ctrlEnable [1007,true];
	};
	
	if (RW_carSyncMode isEqualTo 1) then {
		ctrlEnable [1903,false];
		ctrlEnable [1014,false];
	} else {	
		ctrlEnable [1903,true];
		ctrlEnable [1014,true];
	};
	
	if (RW_airSyncMode isEqualTo 1) then {
		ctrlEnable [1905,false];
		ctrlEnable [1018,false];
	} else {	
		ctrlEnable [1905,true];
		ctrlEnable [1018,true];
	};
	CHVD_loadingDialog = false;
};