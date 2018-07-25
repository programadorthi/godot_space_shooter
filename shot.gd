extends Area2D

const MOVEMENT_SPEED = 500.0
const SCREEN_WIDTH = 320 + 8

func _process(delta):
    position += Vector2(MOVEMENT_SPEED * delta, 0.0)
    if position.x >= SCREEN_WIDTH:
        queue_free()

func _on_shot_area_entered(area):
    if area.is_in_group("asteroid"):
        queue_free()
