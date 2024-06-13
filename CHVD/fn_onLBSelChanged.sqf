params ["_index","_varType","_text"];
private _terrainGrid = 50;
switch (_index) do {
	case 0: {_terrainGrid = 50};
	case 1: {_terrainGrid = 25};
	case 2: {_terrainGrid = 12.5};
	case 3: {_terrainGrid = 6.25};
	case 4: {_terrainGrid = 3.125};
};
_terrainGrid = _terrainGrid min CHVD_minGrid max CHVD_maxGrid;
ctrlSetText [_text, str _terrainGrid];
call compile format ["%1 = %2",_varType, _terrainGrid];
call compile format ["profileNamespace setVariable ['%1',%1]", _varType];
[] call CHVD_fnc_updateTerrain;