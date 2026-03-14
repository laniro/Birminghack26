extends Area2D


var player
var enemyspeed
var parent


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var vector_to_player = player.position - position
	
	if vector_to_player.length() < 50: 
		queue_free()
	
	vector_to_player = vector_to_player.normalized()
	
	var velocity = vector_to_player * delta * enemyspeed
	position += velocity
