extends ColorRect

func set_red() -> void:
	$IntelTypes/UnitBack.color = Color(150.0/255,50.0/255,50.0/255)

func set_blu() -> void:
	$IntelTypes/UnitBack.color = Color(50.0/255,50.0/255,150.0/255)

func set_profile(profile_directory) -> void:
	$IntelTypes/UnitBack/UnitIntel/Stats/CenterContainer/Profile.texture = load(profile_directory)

var move_types := ["Foot", "Tread", "Wheel"]
func set_stats_text(hp: int, max_hp: int, attack: int, move_type: int, move_range: int, attack_range: Vector2) -> void:
	$IntelTypes/UnitBack/UnitIntel/Stats/Stats/HP.text = "HP: " + str(hp) + " / " + str(max_hp)
	$IntelTypes/UnitBack/UnitIntel/Stats/Stats/Attack.text = "Attack: " + str(attack)
	$IntelTypes/UnitBack/UnitIntel/Stats/Stats/MoveType.text = "Move Type: " + move_types[move_type]
	$IntelTypes/UnitBack/UnitIntel/Stats/Stats/MoveRange.text = "Move Range: " + str(move_range)
	if attack_range.x == attack_range.y:
		$IntelTypes/UnitBack/UnitIntel/Stats/Stats/AttackRange.text = "Attack Range: " + str(attack_range.x)
	else:
		$IntelTypes/UnitBack/UnitIntel/Stats/Stats/AttackRange.text = "Attack Range: " + str(attack_range)

func set_unit_name(unit_name: String) -> void:
	$IntelTypes/UnitBack/UnitIntel/Class.text = unit_name

func set_lore(lore_entry: String) -> void:
	$IntelTypes/UnitBack/UnitIntel/Lore.text = lore_entry

func set_unit_intel_visible(yes: bool) -> void:
	$IntelTypes/UnitBack.visible = yes

func set_terrain_stats(defense: int, move_cost: Array) -> void:
	$IntelTypes/TerrainIntel/ColorRect/Terrain/Stats/Stats/Defense.text = "Defense Bonus: " + str(defense)
	var move_display = ""
	if move_cost[0] < 10:
		move_display += "Foot: "
		move_display += str(move_cost[0])
	if move_cost[1] < 10:
		move_display += " | Tread: "
		move_display += str(move_cost[1])
	if move_cost[2] < 10:
		move_display += " | Wheel: "
		move_display += str(move_cost[2])
	$IntelTypes/TerrainIntel/ColorRect/Terrain/Stats/Stats/Move.text = move_display

func set_terrain_name(terrain_name: String) -> void:
	$IntelTypes/TerrainIntel/ColorRect/Terrain/Label.text = terrain_name

func set_terrain_lore(terrain_lore: String) -> void:
	$IntelTypes/TerrainIntel/ColorRect/Terrain/Lore.text = terrain_lore

func set_terrain_image(terrain_directory: String) -> void:
	$IntelTypes/TerrainIntel/ColorRect/Terrain/Stats/CenterContainer/TerrainView.texture = load(terrain_directory)
