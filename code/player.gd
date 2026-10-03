extends CharacterBody2D

const SPEED = 200.0
const JUMP_VELOCITY = -400.0
var has_key: bool = false
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var tile_map_layer: TileMapLayer = $"../evil"
@onready var animated_sprite = $AnimatedSprite2D

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction = Input.get_axis("ui_left", "ui_right")
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
	update_animations(direction)
	var cell_pos = tile_map_layer.local_to_map(global_position)
	var tile_data = tile_map_layer.get_cell_tile_data(cell_pos)
	if tile_data and tile_data.get_custom_data("is_deadly"):
		get_tree().reload_current_scene()
func update_animations(direction):
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true

	if not is_on_floor():
		animated_sprite.play("jump")
	elif direction != 0:
		animated_sprite.play("run")
	else:
		animated_sprite.play("idle")

func collect_key() -> void:
	has_key = true
	print("Skeleton key obtained")
	


func _on_area_2d_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
