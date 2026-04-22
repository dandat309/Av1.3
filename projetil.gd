extends CharacterBody3D

var speed = 10
var direcao = Vector3.ZERO

func _physics_process(delta):
	velocity = direcao * speed
	move_and_slide()
