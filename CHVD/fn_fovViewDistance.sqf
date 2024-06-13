params [["_minViewDistance",0]];
private _ret = _minViewDistance;
private _zoom = call CHVD_fnc_trueZoom;
if (_zoom >= 1) then {
	_ret = _minViewDistance + ((12000 / 74) * (_zoom - 1)) min viewDistance;	
};
_ret