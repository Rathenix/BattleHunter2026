extends Node

var players = {1:null, 2:null, 3:null, 4:null}
var active_player = 1
enum STATES {TITLE, MENU, BATTLE, HUNT}
var game_state = STATES.TITLE

func _ready() -> void:
	pass
