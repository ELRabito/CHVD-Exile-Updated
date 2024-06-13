params [["_varType",""],["_textCtrl",controlNull],["_listbox",controlNull]];
private _textValue = [ctrlText _textCtrl, "0123456789."] call BIS_fnc_filterString;
_textValue = if (_textValue == "") then {50} else {call compile _textValue min CHVD_minGrid max CHVD_maxGrid};
private _listboxCtrl = (finddisplay 2900) displayCtrl _listbox;
_listboxCtrl ctrlRemoveAllEventHandlers "LBSelChanged";
_sel = [_textValue] call CHVD_fnc_selTerrainQuality;	
//add EH again
_listboxCtrl ctrlSetEventHandler ["LBSelChanged", 
	format ["[_this select 1, '%1', %2] call CHVD_fnc_onLBSelChanged", _varType, _textCtrl]
];
ctrlSetText [_textCtrl, str _textValue];	
call compile format ["%1 = %2",_varType, _textValue];
call compile format ["profileNamespace setVariable ['%1',%1]", _varType];
[] call CHVD_fnc_updateTerrain;