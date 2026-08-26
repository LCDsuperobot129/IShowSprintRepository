extends Node

func _ready():
	await get_tree().create_timer(1).timeout
	
	self.text = "4"
	
	await get_tree().create_timer(1).timeout
	
	self.text = "3"
	
	await get_tree().create_timer(1).timeout
	
	self.text = "2"
	
	await get_tree().create_timer(1).timeout
	
	self.text = "1"
	
	await get_tree().create_timer(1).timeout
	
	self.text = "0"
	
	get_tree().change_scene_to_file("res://scenes/easy_bot_map.tscn")
