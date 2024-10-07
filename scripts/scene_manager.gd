extends Node

@onready var main: Control

var game_instance: Node2D

func hook_main(main_scene: Control):
	main = main_scene

func unload_game():
	if is_instance_valid(game_instance):
		game_instance.queue_free()
	game_instance = null

@rpc("any_peer", "call_local")
func load_game(game: String):
	unload_game()
	var game_resource = load(game)
	if game_resource:
		game_instance = game_resource.instantiate()
		main.add_child(game_instance)
	print("Game started!")
