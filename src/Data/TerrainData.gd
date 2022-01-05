class_name TerrainData
extends Resource

enum MOVE_TYPE {FOOT, TREAD, TIRE}

var data := {
	-1: {
		"name": "empty", "defense": 0,
		"move_cost": [-1, -1, -1], # Foot, Tread, Tire
	},
	2: {
		"name": "plain", "defense": 1,
		"move_cost": [1, 1, 1],
	},
	0: {
		"name": "forest", "defense": 3,
		"move_cost": [1, 2, 3],
	},
	1: {
		"name": "hill", "defense": 4,
		"move_cost": [2, -1, -1],
	},
	3: {
		"name": "road", "defense": 0,
		"move_cost": [1, 1, 1],
	}
}
