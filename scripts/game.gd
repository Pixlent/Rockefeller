extends Node2D

@onready var turn_machine = $TurnMachine

# Called when the node enters the scene tree for the first time.
func _ready():
	for player in GameManager.players:
		turn_machine.add_candidate(player)
