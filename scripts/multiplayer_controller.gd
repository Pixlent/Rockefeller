extends Node

@onready var main: Control = $".."

@export var address: String = "127.0.0.1"
@export var port: int = 8910

var peer

# Called when the node enters the scene tree for the first time.
func _ready():
	multiplayer.peer_connected.connect(peer_connected)
	multiplayer.peer_disconnected.connect(peer_disconnected)
	multiplayer.connected_to_server.connect(connected_to_server)
	multiplayer.connection_failed.connect(connection_failed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

# Gets called on the server and clients
func peer_connected(id):
	print("Player Connected: " + str(id))

# Gets called on the server and clients
func peer_disconnected(id):
	print("Player Disconnected: " + str(id))

# Gets called on the client
func connected_to_server():
	print("Connected to server!")
	send_player_information.rpc_id(1, $"../VBoxContainer/NameEdit.text", multiplayer.get_unique_id())

# Gets called on the client
func connection_failed():
	print("Failed to connect to server...")

@rpc("any_peer")
func send_player_information(username, id):
	if !GameManager.players.has(id):
		GameManager.players[id] = {
			"name": username,
			"id": id
		}
	
	if multiplayer.is_server():
		for i in GameManager.players:
			send_player_information.rpc(GameManager.players[i].name, i)

@rpc("any_peer", "call_local")
func start_game():
	SceneManager.load_game("res://scenes/game.tscn")

func _on_host_button_pressed():
	print("Hosting server...")
	
	peer = ENetMultiplayerPeer.new()
	port = int($"../VBoxContainer/BoxContainer/PortEdit".text)
	
	var error = peer.create_server(port, 10)
	
	print("Server created on: " + str(port))
	
	if error != OK:
		print("Cannot host: ", error)
		return
	
	multiplayer.multiplayer_peer = peer
	
	send_player_information($"../VBoxContainer/NameEdit".text, multiplayer.get_unique_id())
	
	print("Waiting for players...")

func _on_join_button_pressed():
	address = $"../VBoxContainer/BoxContainer/AddressEdit".text
	port = int($"../VBoxContainer/BoxContainer/PortEdit".text)
	peer = ENetMultiplayerPeer.new()
	peer.create_client(address, port)
	print("Attempting to connect to server on: " + address + ":" + str(port))
	
	multiplayer.multiplayer_peer = peer

func _on_start_button_pressed():
	start_game.rpc()
