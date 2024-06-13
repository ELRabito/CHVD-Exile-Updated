params [["_updateType",0]];
if (CHVD_keyDown) exitWith {};
CHVD_keyDown = true;
if (_updateType isEqualTo 0) exitWith {};
private _terrainGridArray = [50,25,12.5,6.25,3.125];
if (!isNull (findDisplay 2900)) then {call CHVD_fnc_openDialog};
private _vehTypeString = "";
switch (CHVD_vehType) do {
	case 1: {
		_vehTypeString = "car";
	};
	case 2: {
		_vehTypeString = "air";
	};
	default {
		_vehTypeString = "foot";
	};
};
private _terrainGridVar = "RW_" + _vehTypeString + "Terrain";
private _terrainGrid = call compile _terrainGridVar;
private _terrainIndex = switch (true) do {
	case (_terrainGrid >= 49): {0};
	case (_terrainGrid >= 25): {1};
	case (_terrainGrid >= 12.5): {2};
	case (_terrainGrid >= 6.25): {3};
	case (_terrainGrid >= 3.125): {4};
	default {1};
};
_terrainIndex = (_terrainIndex + _updateType) max 0 min 4;
_terrainGrid = (_terrainGridArray select _terrainIndex) min CHVD_minGrid max CHVD_maxGrid;
call compile format ["%1 = %2", _terrainGridVar, _terrainGrid];
call compile format ["profileNamespace setVariable ['%1',%1]", _terrainGridVar];
call CHVD_fnc_updateTerrain;
private _terrainQualityArray = [
	["Low", localize "STR_chvd_low"] select (isLocalized "STR_chvd_low"),
	["Standart", localize "STR_chvd_standard"] select (isLocalized "STR_chvd_standard"),
	["High", localize "STR_chvd_high"] select (isLocalized "STR_chvd_high"),
	["Very High", localize "STR_chvd_veryHigh"] select (isLocalized "STR_chvd_veryHigh"),
	["Ultra", localize "STR_chvd_ultra"] select (isLocalized "STR_chvd_ultra")
];
private _terrainQuality = _terrainQualityArray select _terrainIndex;
private _textTerrainQuality = if (isLocalized "STR_chvd_terrainQuality") then {localize "STR_chvd_terrainQuality"} else {"Terrain Quality"};
["InfoTitleAndText", [format ["<img size='40' image='%1'/><t color='#e6dfdf'> %2</t>","a3\ui_f\data\gui\rsc\rscdisplayarsenal\binoculars_ca.paa",_textTerrainQuality], format ["%1: %2",_textTerrainQuality,_terrainQuality]]] call ExileClient_gui_toaster_addTemplateToast;
[] spawn {
	uiSleep 0.05;
	CHVD_keyDown = false;
};