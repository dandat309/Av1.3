extends CharacterBody3D

var SPEED = 5
var alvo_movimento
var correndo = false
@onready var main = get_parent()

func _ready():
	alvo_movimento = global_position

func _physics_process(delta):
	var direcao = global_position.direction_to(alvo_movimento)

	if global_position.distance_to(alvo_movimento) > 0.1:
		look_at(alvo_movimento, Vector3.UP, true)
		velocity = direcao * SPEED
	else:
		velocity = Vector3.ZERO

		if main.marcador:
			main.marcador.queue_free()

	if correndo:
		set_collision_mask(1)      
	else:
		set_collision_mask(1 | 2) 

	move_and_slide()
