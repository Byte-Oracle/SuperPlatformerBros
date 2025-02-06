extends Node

var player : Node2D
var camera : Node2D
var current_level : Node2D
var flag : Node2D

func stage_init():
	LevelMusicManager.play_music(current_level.music_path)
	
	#if current_level.level_type == current_level.level_types.Flag:
	#	flag.on_touch.connect(_win_flag)

func _win_flag():
	AudioStreamManager.play(AudioStreamManager.sfx.win)
	## TODO: Introduce basic win state, just reload the scene as there is no level picker screen yet.
