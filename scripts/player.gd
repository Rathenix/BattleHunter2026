extends Node2D

var player_name = ""
var player_level = 1
var player_max_hp = 0
var player_current_hp = 0
var player_attack = 0
var player_defense = 0
var player_speed = 0
var player_skillpoints = {"unspent": 11, "hp": 1, "attack": 1, "defense": 1, "speed": 1}
var previous_skillpoints
var player_status = []

signal hunter_changes_saved(hunter)
signal hunter_changes_cancelled(hunter)

const PLAYER_COLORS = [Color(0.0, 0.0, 1.0, 1.0), Color(1.0, 0.0, 0.0, 1.0), Color(1.0, 1.0, 0.0, 1.0), Color(0.0, 1.0, 0.0, 1.0)]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$CharacterSprite.visible = false
	$StatBlock.visible = false
	$HunterEditMenu.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func create_new() -> void:
	setup_edit_menu()

func calculate_stats() -> void:
	player_max_hp = 6 + player_level + (3 * player_skillpoints["hp"])
	player_current_hp = player_max_hp
	player_attack = player_skillpoints["attack"]
	player_defense = player_skillpoints["defense"] / 2
	player_speed = player_skillpoints["speed"] / 3

func setup_edit_menu() -> void:
	previous_skillpoints = player_skillpoints.duplicate()
	$HunterEditMenu/HunterSkillpointsValue.text = str(player_skillpoints["unspent"])
	$HunterEditMenu/HunterNameTextbox.text = str(player_name)
	$HunterEditMenu/HunterHpValue.text = str(player_skillpoints["hp"])
	$HunterEditMenu/HunterAttackValue.text = str(player_skillpoints["attack"])
	$HunterEditMenu/HunterDefenseValue.text = str(player_skillpoints["defense"])
	$HunterEditMenu/HunterSpeedValue.text = str(player_skillpoints["speed"])
	$HunterEditMenu.visible = true

func setup_stat_block() -> void:
	calculate_stats()
	var x_pos = 35 + ((GameManager.active_player - 1) * 281) 
	$StatBlock.position = Vector2(x_pos, 400)
	$StatBlock/ColorIndicator.color = PLAYER_COLORS[GameManager.active_player - 1]
	$StatBlock/HunterNameValue.text = str(player_name)
	$StatBlock/HunterHpValues.text = str(player_current_hp) + " / " + str(player_max_hp)
	$StatBlock/HunterHpBar.max_value = player_max_hp
	$StatBlock/HunterHpBar.value = player_current_hp
	$StatBlock/HunterAttackValue.text = str(player_attack)
	$StatBlock/HunterDefenseValue.text = str(player_defense)
	$StatBlock/HunterSpeedValue.text = str(player_speed)
	$StatBlock.visible = true

func _on_hp_decrement_button_pressed() -> void:
	recalc_hunter_skillpoints("hp", -1)

func _on_hp_increment_button_pressed() -> void:
	recalc_hunter_skillpoints("hp", 1)

func _on_attack_decrement_button_pressed() -> void:
	recalc_hunter_skillpoints("attack", -1)

func _on_attack_increment_button_pressed() -> void:
	recalc_hunter_skillpoints("attack", 1)

func _on_defense_decrement_button_pressed() -> void:
	recalc_hunter_skillpoints("defense", -1)

func _on_defense_increment_button_pressed() -> void:
	recalc_hunter_skillpoints("defense", 1)

func _on_speed_decrement_button_pressed() -> void:
	recalc_hunter_skillpoints("speed", -1)

func _on_speed_increment_button_pressed() -> void:
	recalc_hunter_skillpoints("speed", 1)

func recalc_hunter_skillpoints(stat, value) -> void:
	if value > 0 and player_skillpoints["unspent"] > 0:
		player_skillpoints["unspent"] -= 1
		player_skillpoints[stat] += 1
	if value < 0 and player_skillpoints[stat] > previous_skillpoints[stat]:
		player_skillpoints["unspent"] += 1
		player_skillpoints[stat] -= 1
	$HunterEditMenu/HunterHpValue.text = str(player_skillpoints["hp"])
	$HunterEditMenu/HunterAttackValue.text = str(player_skillpoints["attack"])
	$HunterEditMenu/HunterDefenseValue.text = str(player_skillpoints["defense"])
	$HunterEditMenu/HunterSpeedValue.text = str(player_skillpoints["speed"])
	$HunterEditMenu/HunterSkillpointsValue.text = str(player_skillpoints["unspent"])

func _on_hunter_save_button_pressed() -> void:
	if $HunterEditMenu/HunterNameTextbox.text != "":
		player_name = $HunterEditMenu/HunterNameTextbox.text
		$HunterEditMenu.visible = false
		setup_stat_block()
		hunter_changes_saved.emit(self)

func _on_hunter_cancel_button_pressed() -> void:
	$HunterEditMenu.visible = false
	$StatBlock.visible = true
	hunter_changes_cancelled.emit(self)
