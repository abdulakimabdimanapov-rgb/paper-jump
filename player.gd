extends CharacterBody2D

@export var walk_speed := 200.0
@export var run_speed := 320.0
@export var jump_velocity := -350.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

	var current_speed = walk_speed

	if Input.is_key_pressed(KEY_SHIFT):
		current_speed = run_speed

	if Input.is_key_pressed(KEY_D) or Input.is_key_pressed(KEY_RIGHT):
		velocity.x = current_speed

	elif Input.is_key_pressed(KEY_A) or Input.is_key_pressed(KEY_LEFT):
		velocity.x = -current_speed

	else:
		velocity.x = 0

	if Input.is_key_pressed(KEY_SPACE) and is_on_floor():
		velocity.y = jump_velocity

	move_and_slide()

	update_animation()


func update_animation():
	if not is_on_floor():
		if velocity.y < 0:
			animated_sprite.play("jump")
		else:
			animated_sprite.play("fall")

	elif velocity.x != 0:
		if Input.is_key_pressed(KEY_SHIFT):
			animated_sprite.play("run")
		else:
			animated_sprite.play("walk")

	else:
		animated_sprite.play("idle")

	if velocity.x != 0:
		animated_sprite.flip_h = velocity.x < 0
