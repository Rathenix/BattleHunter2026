extends Node2D

var player_scene = preload("res://scenes/player.tscn")
var allow_player_swap = true

func _ready() -> void:
	GameManager.game_state = GameManager.STATES.MENU
	$TopButtons.visible = true
	$InnButtons.visible = false
	$ShopMenu.visible = false
	$TopButtons/InnButton.grab_focus.call_deferred()

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
		var new_player = player_scene.instantiate()
		add_child(new_player)
		new_player.create_new()
		new_player.hunter_changes_saved.connect(_on_hunter_changes_saved)
		new_player.hunter_changes_cancelled.connect(_on_hunter_changes_cancelled)

func _on_hunter_changes_saved(hunter) -> void:
	GameManager.players[GameManager.active_player] = hunter
	$InnButtons.visible = true
	allow_player_swap = true

func _on_hunter_changes_cancelled(hunter) -> void:
	hunter.queue_free()
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
