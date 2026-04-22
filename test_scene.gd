extends Node3D

@onready var player = $Player
var marcador

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and \
	event.button_index == MOUSE_BUTTON_LEFT and \
	event.pressed:

		var pos_3d = atirar_raio_da_camera(event.position)

		if pos_3d != null:
			player.alvo_movimento = pos_3d

			if event.double_click:
				player.SPEED = 13
				player.correndo = true
			else:
				player.SPEED = 5
				player.correndo = false

			criar_marcador(pos_3d)

	if event is InputEventMouseButton and \
	event.button_index == MOUSE_BUTTON_RIGHT and \
	event.pressed:

		var pos_3d = atirar_raio_da_camera(event.position)

		if pos_3d != null:
			criar_projetil(pos_3d)


func _process(delta):
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		var pos_3d = atirar_raio_da_camera(get_viewport().get_mouse_position())

		if pos_3d != null:
			player.alvo_movimento = pos_3d


func atirar_raio_da_camera(mouse_pos: Vector2):
	var camera = get_viewport().get_camera_3d()

	var origin = camera.project_ray_origin(mouse_pos)
	var end = origin + camera.project_ray_normal(mouse_pos) * 1000

	var space_state = get_world_3d().direct_space_state
	var query = PhysicsRayQueryParameters3D.create(origin, end)

	var result = space_state.intersect_ray(query)

	if result.is_empty():
		return null
	else:
		return result.position


func criar_marcador(pos):
	if marcador:
		marcador.queue_free()

	marcador = preload("res://marcador.tscn").instantiate()
	add_child(marcador)
	marcador.global_position = pos


func criar_projetil(pos):
	var projetil = preload("res://projetil.tscn").instantiate()
	add_child(projetil)
	projetil.global_position = player.global_position
	projetil.direcao = player.global_position.direction_to(pos)
