extends CharacterBody3D

var SPEED = 5
var alvo_movimento
@onready var PLAy = get_parent()

func _ready():
	alvo_movimento = global_position

func _physics_process(delta):
	var distancia = global_position.distance_to(alvo_movimento)

	if distancia > 0.1:
		var direcao = global_position.direction_to(alvo_movimento)

		look_at(alvo_movimento, Vector3.UP, true)
		velocity = direcao * SPEED
	else:
		velocity = Vector3.ZERO

		if PLAy.marcador:
			PLAy.marcador.queue_free()

	move_and_slide()
