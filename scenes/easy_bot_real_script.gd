extends CharacterBody2D

@export var start_speed: float = 1100.0
@export var max_speed: float = 2800.0
@export var acceleration: float = 85.0
@export var base_animation_speed: float = 1.75

var current_speed: float = 0.0
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

func _ready():
	current_speed = start_speed
	sprite.play()

func _physics_process(delta: float):
	current_speed = min(current_speed + acceleration * delta, max_speed)
	velocity = Vector2.RIGHT.rotated(rotation) * current_speed
	move_and_slide()

	var speed_ratio = current_speed / max_speed
	sprite.speed_scale = base_animation_speed * (0.5 + speed_ratio * 0.5)
