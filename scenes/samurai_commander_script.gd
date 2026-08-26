extends CharacterBody2D

@export var base_speed: float = 1100.0     # starting speed
@export var decay_rate: float = 80.0      # how fast speed decreases per second
@export var boost_amount: float = 26.0     # how much speed increases per mash
@export var max_speed: float = 2950.0      # optional speed cap

@onready var anim_sprite = $AnimatedSprite2D
@onready var sprint_step_sound = $SprintButtonSound

#@onready var camera = $Camera2D

@onready var music = $Running


var current_speed: float = 0.0



func _ready():
	current_speed = base_speed
	
	music.stream.set_loop(true)
	music.play()

func _process(delta):
	handle_input()
	apply_decay(delta)
	move_character(delta)
	anim_sprite.speed_scale = lerp(0.5, 3.0, current_speed / max_speed)

func handle_input():
	# Increase speed when spacebar is pressed
	if Input.is_action_just_pressed("p2_sprint_boost"): # or define custom "mash" input
		current_speed += boost_amount
		current_speed = clamp(current_speed, 0, max_speed)
		
		#camera.zoom = camera.zoom + Vector2(0.05, 0.05)
		#zoom_in_and_out()
		
		sprint_step_sound.play()
		
		# Adjust animation speed proportionally to running speed
		

		
		print(current_speed)

func apply_decay(delta):
	# Gradually reduce speed over time
	current_speed = max(current_speed - decay_rate * delta, 200)
	
	anim_sprite.speed_scale = lerp(0.5, 3.0, current_speed / max_speed)

func move_character(delta):
	# Move horizontally (you can change direction or axis as needed)
	velocity.x = current_speed
	move_and_slide()
