extends Area2D

@onready var timer: Timer = $Timer
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _on_body_entered(body):
	print('you died')
	animation_player.play('DeathSound')
	Engine.time_scale = 0.5
	body.get_node('CollisionShapeNormal').queue_free()
	body.get_node('CollisionShapeSmall').queue_free()
	timer.start()
	
	
func _on_timer_timeout() -> void:
	Engine.time_scale = 1
	get_tree().reload_current_scene()
