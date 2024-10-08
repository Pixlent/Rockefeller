extends Node

@onready var hud = %HUD
@onready var card = $Card
@onready var timer = $Timer

var rng := RandomNumberGenerator.new()

var real_estate = DataLoader.load_json("res://data/cards/real_estate.json")
var events = DataLoader.load_json("res://data/cards/events.json")
var investment_opportunities = DataLoader.load_json("res://data/cards/investment_opportunities.json")

func _ready():
	pass

@rpc("any_peer", "call_local")
func draw_card(card_info: Dictionary):
	
	
	print(card_info)
	
	card.set_card_name("Card: " + card_info["name"])
	card.show()
	timer.stop()
	timer.start(3)

func roll_card():
	var weighted_sum = 0
	var cards = real_estate + events + investment_opportunities
	
	for n in cards:
		weighted_sum += n["weight"]
	
	var card = rng.randi_range(0, weighted_sum)
	
	for n in cards:
		if card <= n["weight"]:
			return n
		card -= n["weight"]

func _on_button_pressed():
	draw_card.rpc(roll_card())

func _on_timer_timeout():
	card.hide()
