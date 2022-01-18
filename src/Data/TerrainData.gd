class_name TerrainData
extends Resource

enum MOVE_TYPE {FOOT, TREAD, TIRE}

var buildable_cells = {5:6, 7:8}
var capturable_cells = [9]

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
	},
	4: {
		"name": "river", "defense": 0,
		"move_cost": [2,-1,-1],
	},
	5: {
		"name": "broken-bridge", "defense": 0,
		"move_cost": [2,-1,-1],
	},
	6: {
		"name": "bridge", "defense": 0,
		"move_cost": [1,1,1],
	},
	7: {
		"name": "foundations", "defense":2,
		"move_cost": [1,1,1]
	},
	8: {
		"name": "station", "defense": 2,
		"move_cost": [1,1,1]
	},
	9: {
		"name": "blue base", "defense": 4,
		"move_cost": [1,1,1]
	}
}
