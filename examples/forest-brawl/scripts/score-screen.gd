extends Control
class_name ScoreScreen

@export var messages: PackedStringArray
@export var message_label: Label
@export var names_column: Control
@export var scores_column: Control
@export var fade_time: float = 0.2

var active: bool = false

func render(scores: Dictionary):
	clear()
	message_label.text = messages[randi() % messages.size()]
	
	for name in scores:
		var points = scores[name]
		names_column.add_child(_make_label(str(name)))
		scores_column.add_child(_make_label(str(points)))

func clear():
	for child in names_column.get_children() + scores_column.get_children():
		child.queue_free()

func _ready():
	modulate.a = 0
	visible = false

func _process(delta):
	var current = modulate.a
	var target = 1.0 if active else 0.0
	modulate.a = move_toward(current, target, delta / fade_time)
	
	visible = false if modulate.a < 0.05 else true

func _make_label(text: String) -> Label:
	var label = Label.new()
	label.text = text
	label.size_flags_horizontal = SIZE_FILL
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	return label
