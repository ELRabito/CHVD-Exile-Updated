params [["_updateType",0]];
switch (_updateType) do {
	case 1: {
		switch (CHVD_vehType) do {
			case 0: {setViewDistance RW_foot};
			case 1: {setViewDistance RW_car};
			case 2: {setViewDistance RW_air};
		};
	};
	case 2: {
		switch (CHVD_vehType) do {
			case 0: {setObjectViewDistance RW_footObj};
			case 1: {setObjectViewDistance RW_carObj};
			case 2: {setObjectViewDistance RW_airObj};
		};
	};
	case 4: {
		switch (CHVD_vehType) do {
			case 0: {setObjectViewDistance ([RW_footObj] call CHVD_fnc_fovViewDistance)};
			case 1: {setObjectViewDistance ([RW_carObj] call CHVD_fnc_fovViewDistance)};
			case 2: {setObjectViewDistance ([RW_airObj] call CHVD_fnc_fovViewDistance)};
		};
	};
	default {
		switch (CHVD_vehType) do {
			case 0: {setViewDistance RW_foot; setObjectViewDistance RW_footObj};
			case 1: {setViewDistance RW_car; setObjectViewDistance RW_carObj};
			case 2: {setViewDistance RW_air; setObjectViewDistance RW_airObj};
		};
	};
};
if (_updateType isEqualTo 0) then {
	[] call CHVD_fnc_updateTerrain;
};