extends Node2D

var player_name = "Player"
var player_level = 0
var player_max_hp = 0
var player_current_hp = 0
var player_attack = 0
var player_defense = 0
var player_speed = 0
var player_skillpoints = 0
var player_status = []

const PLAYER_COLORS = [Color(0.0, 0.0, 1.0, 1.0), Color(1.0, 0.0, 0.0, 1.0), Color(1.0, 1.0, 0.0, 1.0), Color(0.0, 1.0, 0.0, 1.0)]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var x_pos = 35 + ((GameManager.active_player - 1) * 281) 
	$StatBlock.position = Vector2(x_pos, 400)
	$StatBlock/ColorIndicator.color = PLAYER_COLORS[GameManager.active_player - 1]
	$StatBlock/HunterNameValue.text = player_name
	$StatBlock/HunterHpValues.text = str(player_current_hp) + " / " + str(player_max_hp)
	$StatBlock/HunterHpBar.max_value = player_max_hp
	$StatBlock/HunterHpBar.value = player_current_hp
	$StatBlock/HunterAttackValue.text = str(player_attack)
	$StatBlock/HunterDefenseValue.text = str(player_defense)
	$StatBlock/HunterSpeedValue.text = str(player_speed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
