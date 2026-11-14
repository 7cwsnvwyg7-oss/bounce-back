extends CharacterBody2D

func _physics_process(delta):
	var mozgas = Input.get_axis("ui_right", "ui_left")
	velocity.x = mozgas*(-750)
	velocity.y = 0
	move_and_slide()
