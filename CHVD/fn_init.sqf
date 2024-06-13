// CHVD ViewDistance updated by El'Rabito for Exile
[] spawn {
	if (!hasInterface) exitWith {};
	//Wait for mission init, in case there are variables defined some place else
	waitUntil {time > 0};
	
	//Define variables, load from profileNamespace
	RW_footSyncMode = profileNamespace getVariable ["RW_footSyncMode",0];
	RW_footSyncPercentage = profileNamespace getVariable ["RW_footSyncPercentage",0.8];	
	RW_carSyncMode = profileNamespace getVariable ["RW_carSyncMode",0];
	RW_carSyncPercentage = profileNamespace getVariable ["RW_carSyncPercentage",0.8];	
	RW_airSyncMode = profileNamespace getVariable ["RW_airSyncMode",0];
	RW_airSyncPercentage = profileNamespace getVariable ["RW_airSyncPercentage",0.8];

	RW_foot = (profileNamespace getVariable ["RW_foot",viewDistance]) min CHVD_maxView max CHVD_minView;
	RW_car = (profileNamespace getVariable ["RW_car",viewDistance]) min CHVD_maxView max CHVD_minView;
	RW_air = (profileNamespace getVariable ["RW_air",viewDistance]) min CHVD_maxView max CHVD_minView;

	RW_footObj = (profileNamespace getVariable ["RW_footObj",viewDistance]) min CHVD_maxObj max CHVD_minObj;
	RW_footObj = if (RW_footSyncMode isEqualTo 1) then {RW_foot * RW_footSyncPercentage min CHVD_maxView max CHVD_minView} else {RW_footObj};	
	RW_carObj = (profileNamespace getVariable ["RW_carObj",viewDistance]) min CHVD_maxObj max CHVD_minObj;
	RW_carObj = if (RW_carSyncMode isEqualTo 1) then {RW_car * RW_carSyncPercentage min CHVD_maxView max CHVD_minView} else {RW_carObj};	
	RW_airObj = (profileNamespace getVariable ["RW_airObj",viewDistance]) min CHVD_maxObj max CHVD_minObj;
	RW_airObj = if (RW_airSyncMode isEqualTo 1) then {RW_air * RW_airSyncPercentage min CHVD_maxView max CHVD_minView} else {RW_airObj};

	RW_footTerrain = (profileNamespace getVariable ["RW_footTerrain",12.5]) min CHVD_minGrid max CHVD_maxGrid;
	RW_carTerrain = (profileNamespace getVariable ["RW_carTerrain",12.5]) min CHVD_minGrid max CHVD_maxGrid;
	RW_airTerrain = (profileNamespace getVariable ["RW_airTerrain",12.5]) min CHVD_minGrid max CHVD_maxGrid;
	
	CHVD_vehType = 0; // 0 = foot, 1 = car, 2 = air
	
	//Begin initialization
	waitUntil {!isNull player};
	waitUntil {!isNull findDisplay 46};
	if (isClass (configfile >> "CfgPatches" >> "cba_keybinding")) then {call CHVD_fnc_keyBindings};
	(findDisplay 46) displayAddEventHandler ["Unload", {call CHVD_fnc_updateSettings}]; // Reset obj view distance so game doesn't lag when browsing menues and so on, if FOV method was used during the game
	[] call CHVD_fnc_updateVehType;
	[] call CHVD_fnc_updateSettings;

	//Detect when to change setting type
	[] spawn {
		for "_i" from 0 to 1 step 0 do {
			_currentVehicle = vehicle player;			
			waitUntil {_currentVehicle != vehicle player};			
			[] call CHVD_fnc_updateVehType;
			if (
				(CHVD_vehType isEqualTo 0 && RW_footSyncMode isEqualTo 2) || 
				(CHVD_vehType isEqualTo 1 && RW_carSyncMode isEqualTo 2) || 
				(CHVD_vehType isEqualTo 2 && RW_airSyncMode isEqualTo 2)
			) then {
				[1] call CHVD_fnc_updateSettings;
				[] call CHVD_fnc_updateTerrain;
				[4] call CHVD_fnc_updateSettings
			} else {				
				[] call CHVD_fnc_updateSettings;
			};
		};
	};
	
	[] spawn {
		for "_i" from 0 to 1 step 0 do {
			_UAVstatus = call CHVD_fnc_UAVstatus;			
			waitUntil {_UAVstatus != call CHVD_fnc_UAVstatus};			
			[] call CHVD_fnc_updateVehType;
			if (
				(CHVD_vehType isEqualTo 0 && RW_footSyncMode isEqualTo 2) || 
				(CHVD_vehType isEqualTo 1 && RW_carSyncMode isEqualTo 2) || 
				(CHVD_vehType isEqualTo 2 && RW_airSyncMode isEqualTo 2)
			) then {
				[1] call CHVD_fnc_updateSettings;
				[] call CHVD_fnc_updateTerrain;
				[4] call CHVD_fnc_updateSettings
			} else {
				[] call CHVD_fnc_updateSettings;
			};
		};
	};
	
	[] spawn {
		for "_i" from 0 to 1 step 0 do {
			_currentZoom = call CHVD_fnc_trueZoom;			
			waitUntil {_currentZoom != call CHVD_fnc_trueZoom};			
			if (
				(CHVD_vehType isEqualTo 0 && RW_footSyncMode isEqualTo 2) || 
				(CHVD_vehType isEqualTo 1 && RW_carSyncMode isEqualTo 2) || 
				(CHVD_vehType isEqualTo 2 && RW_airSyncMode isEqualTo 2)
			) then {[4] call CHVD_fnc_updateSettings};
		};
	};
};