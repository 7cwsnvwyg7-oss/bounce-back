extends CharacterBody2D

@export var speed: float = 750.0
@export var elet: int = 5
@export var padlo: StaticBody2D
@export var lives_label: Label
@export var game_over_label: Label

var direction := Vector2(1, -1).normalized()


func _ready() -> void:
	if is_instance_valid(lives_label):
		lives_label.text = "Élet: " + str(elet)

	if is_instance_valid(game_over_label):
		game_over_label.hide()


func _physics_process(delta: float) -> void:
	var hit = move_and_collide(direction * speed * delta)

	if hit == null:
		return

	var utkozott_test = hit.get_collider()
	print("Ütközött: ", utkozott_test.name)

	# A labda minden ütközésnél visszapattan.
	direction = direction.bounce(hit.get_normal()).normalized()

	# A padló találatakor életet veszít.
	if utkozott_test == padlo:
		elet -= 1

		if is_instance_valid(lives_label):
			lives_label.text = "Élet: " + str(elet)

		if elet <= 0:
				game_over_label.text = "Meghaltál!"
				game_over_label.show()

				get_tree().paused = true

	# A blokkok találatkor eltűnnek.
	elif utkozott_test is Node and utkozott_test.is_in_group("blokkok"):
		utkozott_test.queue_free()
		
		if utkozott_test.is_in_group("extra_élet"):
			elet += 1
			lives_label.text = "Élet: " + str(elet)
