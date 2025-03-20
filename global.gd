extends Node

var score : int:
	get:
		return score
	set(val):
		if val > score:
			high_score = val
		score = val

var high_score = 0
