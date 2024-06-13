params ["_terrainGrid"];
private _output = switch (true) do {
	case (_terrainGrid >= 50): {0};
	case (_terrainGrid >= 25): {1};
	case (_terrainGrid >= 12.5): {2};
	case (_terrainGrid >= 6.25): {3};
	case (_terrainGrid >= 3.125): {4};
};
_output