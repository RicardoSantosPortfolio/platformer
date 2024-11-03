extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var animation_tree : AnimationTree = $AnimationTree
@onready var sprite2D : Sprite2D = $Sprite2D
@onready var state_machine : CharacterStateMachine = $CharacterStateMachine

func _ready() -> void:
	animation_tree.active = true

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	animation_tree.set("parameters/Move/blend_position", direction)
	sprite2D.flip_h = (direction < 0)
	if direction && state_machine.get_can_move():
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
