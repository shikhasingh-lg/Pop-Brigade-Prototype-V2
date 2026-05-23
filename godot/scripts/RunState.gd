extends Node
## RunState — per-run mutable state.
## Reset on run start. Read/written by MatchScene and HUD.

signal wave_changed(wave_index: int)
signal moves_changed(moves_remaining: int)
signal base_hp_changed(hp: int)
signal intermission_started(from_wave: int, to_wave: int)
signal intermission_ended()
signal run_ended(result: String)  # "win" | "lose" | "stall_loss"

var wave_index: int = 0          # 0..num_waves-1
var moves_remaining: int = 0
var base_hp: int = 0
var heroes_alive: int = 0
var intermission_active: bool = false
var run_over: bool = false

func start_run() -> void:
	# Pull the wave count for whichever stage was selected. Falls back to
	# GameConfig.num_waves if no stage is set (e.g. direct MatchScene launch).
	if MetaState.current_stage > 0:
		GameConfig.num_waves = MetaState.waves_for_stage(MetaState.current_stage)
	wave_index = 0
	base_hp = GameConfig.base_max_hp
	heroes_alive = 0
	intermission_active = false
	run_over = false
	_begin_wave(0)
	emit_signal("base_hp_changed", base_hp)

func _begin_wave(idx: int) -> void:
	wave_index = idx
	moves_remaining = GameConfig.moves_for_wave(idx)
	intermission_active = false
	emit_signal("intermission_ended")
	emit_signal("wave_changed", idx)
	emit_signal("moves_changed", moves_remaining)

func spend_move() -> void:
	if moves_remaining > 0:
		moves_remaining -= 1
		emit_signal("moves_changed", moves_remaining)

func begin_intermission() -> void:
	if run_over:
		return
	var from_wave: int = wave_index
	var to_wave: int = wave_index + 1
	intermission_active = true
	emit_signal("intermission_started", from_wave, to_wave)

func advance_wave() -> void:
	if run_over:
		return
	if wave_index + 1 >= GameConfig.num_waves:
		intermission_active = false
		run_over = true
		emit_signal("run_ended", "win")
	else:
		_begin_wave(wave_index + 1)

func damage_base(amount: int) -> void:
	if run_over:
		return
	base_hp = max(0, base_hp - amount)
	emit_signal("base_hp_changed", base_hp)
	if base_hp == 0:
		run_over = true
		emit_signal("run_ended", "lose")

func end_run_stall_loss() -> void:
	if run_over:
		return
	run_over = true
	emit_signal("run_ended", "stall_loss")

func can_fire_now() -> bool:
	return moves_remaining > 0 and not intermission_active and not run_over
