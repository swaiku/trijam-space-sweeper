extends Node2D

@onready var player: CharacterBody2D = $Player
@onready var camera_2d: Camera2D = $Camera2D
@onready var garbages: Node = $garbages

var score: int:
	set(value):
		score = value
		$UI/Label.text = "Score : " + str(value)

var center_exclusion_radius = 1000
var center_position = Vector2(0, 0)  # Centre de la zone
var garbage = load("res://scene/garbage.tscn")
# Called when the node enters the scene tree for the first time.

func get_random_spawn_position() -> Vector2:
	while true:
		var random_position = Vector2(
			randf_range(-3500,3500),
			randf_range(-2000,2000)
		)
		# Vérifie la distance entre la position générée et le centre
		if random_position.distance_to(center_position) > center_exclusion_radius:
			return random_position
	return Vector2(0,0)

func _ready() -> void:
	score = 0
	for i in 500:
		var c = garbage.instantiate()
		c.position = get_random_spawn_position()
		garbages.add_child(c)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	score = Globals.score
	camera_2d.zoom.x = -(5000-(player.position.distance_to(Vector2(0.0,0.0))))/7000
	camera_2d.zoom.y = -(5000-(player.position.distance_to(Vector2(0.0,0.0))))/7000
	camera_2d.position.x = player.position.x/2
	camera_2d.position.y = player.position.y/1.5
	
