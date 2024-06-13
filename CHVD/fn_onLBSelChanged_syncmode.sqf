params ["_mode",["_varString",""],["_textBoxCtrl",controlNull],["_sliderCtrl",controlNull],["_sliderTextboxCtrl",controlNull]];
switch (_mode) do {
	case 1: {
	
		ctrlEnable [_textBoxCtrl, true];
		_percentageVar = "RW_" + _varString + "SyncPercentage";
		_percentage = call compile _percentageVar;
		ctrlSetText [_textBoxCtrl, format ["%1",_percentage * 100] + "%"];	
		private _viewDistVar = "RW_" + _varString;
		private _viewDist = call compile _viewDistVar;
		private _objVDVar = "RW_" + _varString + "Obj";
		private _objVD = _viewDist * _percentage min CHVD_maxObj max CHVD_minObj;
		ctrlEnable [_sliderCtrl, false];
		sliderSetPosition [_sliderCtrl, _objVD];
		ctrlEnable [_sliderTextboxCtrl, false];		
		ctrlSetText [_sliderTextboxCtrl, str round _objVD];
		call compile format ["%1 = %2", _objVDVar, _objVD];
		call compile format ["profileNamespace setVariable ['%1',%1]", _objVDVar];
	};
	default {
	
		ctrlEnable [_textBoxCtrl, false];
		ctrlSetText [_textBoxCtrl, ""];
		ctrlEnable [_sliderCtrl, true];
		ctrlEnable [_sliderTextboxCtrl, true];		
	};	
};
private _modeVar = "RW_" + _varString + "SyncMode";
call compile format ["%1 = %2", _modeVar, _mode];
call compile format ["profileNamespace setVariable ['%1',%1]", _modeVar];
[2] call CHVD_fnc_updateSettings;