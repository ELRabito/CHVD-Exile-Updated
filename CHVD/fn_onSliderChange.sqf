params [["_varType1",""],["_slider1",controlNull],["_sliderPos",0],["_text1",controlNull],["_varType2",""],["_slider2",controlNull],["_text2",controlNull],["_modeVar",""],["_percentVar",""]];
private _updateType = -1;
if (count _this < 8) then {
	_updateType = 2;
} else {
	_modeVar = call compile _modeVar;
	switch (_modeVar) do {
		case 1: {
			_updateType = 3;
		};
		default {
			_updateType = 1;		
		};	
	};
};
private _viewDistValue = _sliderPos min CHVD_maxView max CHVD_minView;
private _objViewDistValue = if (_modeVar isEqualTo 1) then {_sliderPos  * (call compile _percentVar) min CHVD_maxObj max CHVD_minObj} else {_sliderPos min CHVD_maxObj max CHVD_minObj};
switch (_updateType) do { // 1 - VIEW, 2 - OBJ, 3 - BOTH, 0 - BOTH AND TERRAIN
	case 1: {
	
		sliderSetPosition [ctrlIDC _slider1, _viewDistValue];
		ctrlSetText [_text1, str round _viewDistValue];
		sliderSetRange [_slider2, 0, _viewDistValue];
		call compile format ["%1 = %2", _varType1, _viewDistValue];
		call compile format ["profileNamespace setVariable ['%1',%1]", _varType1];
		if ((call compile _varType2) > _viewDistValue) then {
		
			sliderSetPosition [_slider2, _objViewDistValue];
			ctrlSetText [_text2, str round _objViewDistValue];
			call compile format ["%1 = %2", _varType2, _objViewDistValue];
			call compile format ["profileNamespace setVariable ['%1',%1]", _varType2];
		};
		[_updateType] call CHVD_fnc_updateSettings;
	};
	case 2: {
	
		sliderSetPosition [ctrlIDC _slider1, _objViewDistValue];
		ctrlSetText [_text1, str round _objViewDistValue];
		call compile format ["%1 = %2", _varType1, _objViewDistValue];
		call compile format ["profileNamespace setVariable ['%1',%1]", _varType1];
		[_updateType] call CHVD_fnc_updateSettings;
	};
	case 3: {
	
		sliderSetPosition [ctrlIDC _slider1, _viewDistValue];
		ctrlSetText [_text1, str round _viewDistValue];
		sliderSetRange [_slider2, 0, _viewDistValue];
		call compile format ["%1 = %2", _varType1, _viewDistValue];
		call compile format ["profileNamespace setVariable ['%1',%1]", _varType1];
		if ((call compile _varType2) > _viewDistValue) then {
			sliderSetPosition [_slider2, _objViewDistValue];
			ctrlSetText [_text2, str round _objViewDistValue];
			call compile format ["%1 = %2", _varType2, _objViewDistValue];
			call compile format ["profileNamespace setVariable ['%1',%1]", _varType2];
		};
		sliderSetPosition [_slider2, _objViewDistValue];
		ctrlSetText [_text2, str round _objViewDistValue];	
		call compile format ["%1 = %2", _varType2, _objViewDistValue];
		call compile format ["profileNamespace setVariable ['%1',%1]", _varType2];
		[_updateType] call CHVD_fnc_updateSettings;
	};	
};