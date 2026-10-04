extends CharacterBody2D

@export var speed := 180.0
@export var jump_velocity := -350.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

	var direction = Input.get_axis("ui_left", "ui_right")

	if direction != 0:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_velocity

	update_animation(direction)

	move_and_slide()

func update_animation(direction):
	if not is_on_floor():
		if velocity.y < 0:
			animated_sprite.play("jump")
		else:
			animated_sprite.play("fall")
	elif direction != 0:
		animated_sprite.play("walk")
	else:
		animated_sprite.play("idle")

	if direction != 0:
		animated_sprite.flip_h = direction < 0
