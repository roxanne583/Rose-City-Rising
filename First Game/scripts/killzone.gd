extends Area2D

@onready var timer = $Timer

func _on_body_entered(body):
	print("You died!")
	Engine.time_scale = 0.4
	body.get_node("CollisionShape2D").queue_free()
	timer.start()
	body.animated_sprite.play("death")


func _on_timer_timeout():
	Engine.time_scale = 1.0
	get_tree().reload_current_scene()
