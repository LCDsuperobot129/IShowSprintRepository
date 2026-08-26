extends Node

@onready var playButton = self

func _on_play_button_pressed():
	get_tree().change_scene_to_file("res://scenes/classic_sprint_loading.tscn")

func _on_button_down() -> void:
	_on_play_button_pressed()
