extends Control

@onready var multiplayer_controller = $MultiplayerController

# Called when the node enters the scene tree for the first time.
func _ready():
	SceneManager.hook_main(self)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
