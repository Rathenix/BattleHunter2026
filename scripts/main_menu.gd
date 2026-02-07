extends Node2D

var player_scene = preload("res://scenes/player.tscn")
var allow_player_swap = true

func _ready() -> void:
	GameManager.game_state = GameManager.STATES.MENU
	$TopButtons.visible = true
	$InnButtons.visible = false
	$HunterEditMenu.visible = false
	$ShopMenu.visible = false

func _process(_delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if allow_player_swap and event.is_action_pressed("change_player"):
		var old = GameManager.active_player
		var new = old + 1
		if new > 4:
			new = 1
		GameManager.active_player = new
		print("Active Player: ", GameManager.active_player)

func _on_inn_button_pressed() -> void:
	$TopButtons.visible = false
	$InnButtons.visible = true

func _on_new_hunter_button_pressed() -> void:
	if GameManager.players[GameManager.active_player] == null:
		allow_player_swap = false
		$InnButtons.visible = false
		$HunterEditMenu/HunterSkillpointsValue.text = "10"
		$HunterEditMenu/HunterNameTextbox.text = ""
		$HunterEditMenu/HunterHpValue.text = "0"
		$HunterEditMenu/HunterAttackValue.text = "0"
		$HunterEditMenu/HunterDefenseValue.text = "0"
		$HunterEditMenu/HunterSpeedValue.text = "0"
		$HunterEditMenu.visible = true

func _on_hunter_cancel_button_pressed() -> void:
	$HunterEditMenu.visible = false
	$InnButtons.visible = true
	allow_player_swap = true

func _on_hunter_save_button_pressed() -> void:
	if $HunterEditMenu/HunterNameTextbox.text != "":
		var new_player = player_scene.instantiate()
		new_player.player_name = $HunterEditMenu/HunterNameTextbox.text
		new_player.player_level = 1
		new_player.player_max_hp = int($HunterEditMenu/HunterHpValue.text)
		new_player.player_current_hp = new_player.player_max_hp
		new_player.player_attack = int($HunterEditMenu/HunterAttackValue.text)
		new_player.player_defense = int($HunterEditMenu/HunterDefenseValue.text)
		new_player.player_speed = int($HunterEditMenu/HunterSpeedValue.text)
		new_player.player_skillpoints = int($HunterEditMenu/HunterSkillpointsValue.text)
		add_child(new_player)
		GameManager.players[GameManager.active_player] = new_player
		$HunterEditMenu.visible = false
		$InnButtons.visible = true
		allow_player_swap = true

func _on_retire_button_pressed() -> void:
	if GameManager.players[GameManager.active_player]:
		GameManager.players[GameManager.active_player].queue_free()
		GameManager.players[GameManager.active_player] = null
	else:
		print("no one home")

func _on_train_rest_button_pressed() -> void:
	pass # Replace with function body.


func _on_shop_button_pressed() -> void:
	pass # Replace with function body.


func _on_recruit_button_pressed() -> void:
	pass # Replace with function body.


func _on_battle_button_pressed() -> void:
	pass # Replace with function body.


func _on_options_button_pressed() -> void:
	pass # Replace with function body.

func _on_hunter_edit_button_pressed() -> void:
	pass # Replace with function body.


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
	var skillpoints_left = int($HunterEditMenu/HunterSkillpointsValue.text)
	if value > 0 and skillpoints_left > 0:
		match stat:
			"hp":
				var old_value = int($HunterEditMenu/HunterHpValue.text)
				var new_value = old_value + 1
				$HunterEditMenu/HunterHpValue.text = str(new_value)
			"attack":
				var old_value = int($HunterEditMenu/HunterAttackValue.text)
				var new_value = old_value + 1
				$HunterEditMenu/HunterAttackValue.text = str(new_value)
			"defense":
				var old_value = int($HunterEditMenu/HunterDefenseValue.text)
				var new_value = old_value + 1
				$HunterEditMenu/HunterDefenseValue.text = str(new_value)
			"speed":
				var old_value = int($HunterEditMenu/HunterSpeedValue.text)
				var new_value = old_value + 1
				$HunterEditMenu/HunterSpeedValue.text = str(new_value)
		skillpoints_left -= 1
	if value < 0:
		match stat:
			"hp":
				var old_value = int($HunterEditMenu/HunterHpValue.text)
				if old_value > 0:
					var new_value = old_value - 1
					skillpoints_left += 1
					$HunterEditMenu/HunterHpValue.text = str(new_value)
			"attack":
				var old_value = int($HunterEditMenu/HunterAttackValue.text)
				if old_value > 0:
					var new_value = old_value - 1
					skillpoints_left += 1
					$HunterEditMenu/HunterAttackValue.text = str(new_value)
			"defense":
				var old_value = int($HunterEditMenu/HunterDefenseValue.text)
				if old_value > 0:
					var new_value = old_value - 1
					skillpoints_left += 1
					$HunterEditMenu/HunterDefenseValue.text = str(new_value)
			"speed":
				var old_value = int($HunterEditMenu/HunterSpeedValue.text)
				if old_value > 0:
					var new_value = old_value - 1
					skillpoints_left += 1
					$HunterEditMenu/HunterSpeedValue.text = str(new_value)
	$HunterEditMenu/HunterSkillpointsValue.text = str(skillpoints_left)
