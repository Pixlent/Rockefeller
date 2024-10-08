extends Node

signal new_turn(candidate)

var candidates: Array

func add_candidate(candidate):
	candidates.append(candidate)
	print("Added candidate: " + candidate)

func get_current_candidate():
	return candidates[0]

func next_turn():
	candidates.append(candidates[0])
	candidates.remove_at(0)
	new_turn.emit(get_current_candidate())
	pass
