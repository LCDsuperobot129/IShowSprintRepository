extends CharacterBody2D

@export var base_speed: float = 1300.0     # starting speed
@export var decay_rate: float = 77.5      # how fast speed decreases per second
@export var boost_amount: float = 25.0     # how much speed increases per mash
@export var max_speed: float = 3000.0      # optional speed cap

@onready var anim_sprite = $AnimatedSprite2D
@onready var sprint_step_sound = $SprintButtonSound

@onready var camera = $Camera2D
@onready var spaceMash_button = $Camera2D/MashButton

@onready var music = $Running

@onready var staminaValue = $Camera2D/CanvasLayer/Panel/Value

var current_speed: float = 0.0

func zoom_in_and_out():
	#camera.zoom = Vector2(0.73, 0.73)
	spaceMash_button.scale = Vector2(0.55, 0.55)
	
	await get_tree().create_timer(0.08).timeout
	
	#camera.zoom = Vector2(0.72, 0.72)
	spaceMash_button.scale = Vector2(0.59, 0.59)
	
	await get_tree().create_timer(0.06).timeout
	
	#camera.zoom = Vector2(0.71, 0.71)
	spaceMash_button.scale = Vector2(0.63, 0.63)
	
	await get_tree().create_timer(0.03).timeout
	
	#camera.zoom = Vector2(0.7, 0.7)
	spaceMash_button.scale = Vector2(0.637, 0.637)

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
	if Input.is_action_just_pressed("spacebar_sprint_boost"): # or define custom "mash" input
		
		if staminaValue.value >= boost_amount:
			print("enough stamina")
			
			current_speed += boost_amount
			current_speed = clamp(current_speed, 0, max_speed)
			
			staminaValue.value -= boost_amount
		
		if staminaValue.value < boost_amount:
			print("not enough stamina")
			
			current_speed += staminaValue.value
			current_speed = clamp(current_speed, 0, max_speed)
			
			staminaValue.value -= staminaValue.value
		
		#camera.zoom = camera.zoom + Vector2(0.05, 0.05)
		zoom_in_and_out()
		
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
