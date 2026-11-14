extends CharacterBody2D

var speed = 400.0
var direction = Vector2(1, -1).normalized()

@export var padlo: Node2D
@export var lives_label: Label
@export var elet = 2
@export var game_over_label: Label
@export var blokk1: $"../blokk"

func _physics_process(delta):
	var hit = move_and_collide(direction * speed * delta)

	if hit:
		direction = direction.bounce(hit.get_normal())
		print("Ütközött ezzel: ", hit.get_collider().name)

		if hit.get_collider() == padlo:
			elet -= 1
			lives_label.text = "Élet: " + str(elet)
			
			if elet<1:
				game_over_label.text = "Meghaltál!"
				game_over_label.show()
				get_tree().paused = true
				
				if collider.is_in_group("blokkok"):
						collider.queue_free()
