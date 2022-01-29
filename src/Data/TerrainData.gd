class_name TerrainData
extends Resource

enum MOVE_TYPE {FOOT, TREAD, TIRE}

var buildable_cells = {5:6, 7:8}
var capturable_cells = [9]

var data := {
	-1: {
		"name": "EMPTY", "defense": 0,
		"move_cost": [99, 99, 99], # Foot, Tread, Tire
		"lore": "If you can see this, something has gone wrong",
		"image": "res://assets/Terrain/blue-base.png"
	},
	2: {
		"name": "PLAINS", "defense": 1,
		"move_cost": [1, 1, 1],
		"lore": "Open grassland that offers little defense.",
		"image": "res://assets/Terrain/plains.png"
	},
	0: {
		"name": "WOODS", "defense": 3,
		"move_cost": [1, 2, 3],
		"lore": "Trees provide good cover from enemy fire.",
		"image": "res://assets/Terrain/forest.png"
	},
	1: {
		"name": "HILLS", "defense": 4,
		"move_cost": [2, 99, 99],
		"lore": "The rocky slopes provide very good cover from enemy fire.",
		"image": "res://assets/Terrain/hills.png"
	},
	3: {
		"name": "ROAD", "defense": 0,
		"move_cost": [1, 1, 1],
		"lore": "A fast way to travel at the cost of being open to enemy fire.",
		"image": "res://assets/Terrain/road-single.png"
	},
	4: {
		"name": "RIVER", "defense": 0,
		"move_cost": [2,99,99],
		"lore": "Impassible to treads and wheels.",
		"image": "res://assets/Terrain/river-single.png"
	},
	5: {
		"name": "BRIDGE FOUNDATIONS", "defense": 0,
		"move_cost": [2,99,99],
		"lore": "A SAPPER can build a BRIDGE here.",
		"image": "res://assets/Terrain/bridge-broken-single.png"
	},
	6: {
		"name": "BRIDGE", "defense": 0,
		"move_cost": [1,1,1],
		"lore": "A way for tread and wheel units to cross rivers.",
		"image": "res://assets/Terrain/bridge-single.png"
	},
	7: {
		"name": "FOUNDATIONS", "defense":2,
		"move_cost": [1,1,1],
		"lore": "A SAPPER can build a RED SUPPLY STATION here.",
		"image": "res://assets/Terrain/foundations.png"
	},
	8: {
		"name": "RED SUPPLY STATION", "defense": 2,
		"move_cost": [1,1,1],
		"lore": "Heals Red units by 5 HP per turn.",
		"image": "res://assets/Terrain/heal-tower.png"
	},
	9: {
		"name": "BLUE TOWER", "defense": 4,
		"move_cost": [1,1,1],
		"lore": "Capture with an AGENT to win the level.",
		"image": "res://assets/Terrain/blue-base.png"
	}
}
