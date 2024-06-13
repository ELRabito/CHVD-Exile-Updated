params [["_updateType",0]];
if (CHVD_keyDown) exitWith {};
CHVD_keyDown = true;
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
private _updateMode = call compile ("RW_" + _vehTypeString + "SyncMode");
private _viewDistVar = "RW_" + _vehTypeString;
private _viewDist = call compile _viewDistVar;
private _objViewDistVar = "RW_" + _vehTypeString + "Obj";
private _objViewDist = call compile _objViewDistVar;
private _vdDiff = _viewDist - _objViewDist;
private _viewDistValue = viewDistance;
private _objViewDistValue = 0;
private _updateValue = if (_updateType isEqualTo 0) then {-250} else {250};
switch (_updateMode) do {
	case 1: {

		_viewDistValue = (_viewDist + _updateValue) min CHVD_maxView max CHVD_minView;		
		private _percentVar = "RW_" + _vehTypeString + "SyncPercentage";
		private _percentValue = call compile _percentVar;
		_objViewDistValue = (_viewDistValue * _percentValue) min CHVD_maxObj max CHVD_minObj;
		if (_objViewDistValue >= 500) then {
			call compile format ["%1 = %2", _viewDistVar, _viewDistValue];
			call compile format ["profileNamespace setVariable ['%1',%1]", _viewDistVar];
			call compile format ["%1 = %2", _objViewDistVar, _objViewDistValue];
			call compile format ["profileNamespace setVariable ['%1',%1]", _objViewDistVar];
			[3] call CHVD_fnc_updateSettings;
		};
	};
	case 2: {	
		_objViewDistValue = ((_objViewDist + _updateValue) min _viewDist) min CHVD_maxObj max CHVD_minObj;
		call compile format ["%1 = %2", _objViewDistVar, _objViewDistValue];
		call compile format ["profileNamespace setVariable ['%1',%1]", _objViewDistVar];
		[4] call CHVD_fnc_updateSettings;
	};
	default {
		_viewDistValue = (_viewDist + _updateValue) min CHVD_maxView max CHVD_minView;
		_objViewDistValue = (_objViewDist + _updateValue) min CHVD_maxObj max CHVD_minObj;
		call compile format ["%1 = %2", _viewDistVar, _viewDistValue];
		call compile format ["profileNamespace setVariable ['%1',%1]", _viewDistVar];
		call compile format ["%1 = %2", _objViewDistVar, _objViewDistValue];
		call compile format ["profileNamespace setVariable ['%1',%1]", _objViewDistVar];
		[3] call CHVD_fnc_updateSettings;
	};
};
private _textViewDistance = if (isLocalized "STR_chvd_viewDistance") then {localize "STR_chvd_viewDistance"} else {"View Distance"};
private _textObjViewDistance = if (isLocalized "STR_chvd_objViewDistance") then {localize "STR_chvd_objViewDistance"} else {"View Distance"};
["InfoTitleAndText", [format ["<img size='40' image='%1'/><t color='#e6dfdf'> %2</t>","a3\ui_f\data\gui\rsc\rscdisplayarsenal\binoculars_ca.paa",_textViewDistance], format ["%1: %2 <br/>%3: %4",_textViewDistance,round _viewDistValue,_textObjViewDistance,round _objViewDistValue]]] call ExileClient_gui_toaster_addTemplateToast;
[] spawn {
	uiSleep 0.05;
	CHVD_keyDown = false;
};