extends Node

var levelScene: PackedScene = preload("res://Project/LevelMap/LevelMap.tscn")
var mainScene: PackedScene = preload("res://Project/Main/Main.tscn")

func loadMainScene():
	get_tree().change_scene_to_packed(mainScene)

func loadLevelScene():
	Engine.time_scale = 1
	get_tree().change_scene_to_packed(levelScene)
