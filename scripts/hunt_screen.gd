extends Node2D

var player_scene = preload("res://scenes/player.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.game_state = GameManager.STATES.HUNT
	for hunter in GameManager.players.keys():
		var h = player_scene.instantiate()
		add_child(h)
		h.load_hunter(GameManager.players[hunter])
		h.setup_map_sprite()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
