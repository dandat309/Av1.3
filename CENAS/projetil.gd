extends CharacterBody3D

var speed = 20
var direcao = Vector3.ZERO

func _physics_process(delta):
	velocity = direcao * speed
	move_and_slide()
