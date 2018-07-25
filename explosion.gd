extends Sprite

func _ready():
    $queue_free_timer.connect("timeout", self, "queue_free")
