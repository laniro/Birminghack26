extends Node

@export var maxhalth = 100
@export var health = 100
@export var defense = 10
@export var trueDefense = 0

func Hit(damage, isTrue):
	if (!isTrue):
		damage *= (100-defense)
	damage -= trueDefense
	damage = max(damage,0)
	health -= damage
	
func heal(amount):
	health = min(maxhalth,health+amount)
