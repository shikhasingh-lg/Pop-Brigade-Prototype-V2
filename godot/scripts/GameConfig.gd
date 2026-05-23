extends Node
## GameConfig — Pop Brigade v2 tunables.
## Mirrors design-spec.md §9 + combat-design.md §7. Tune in playtest.
## Autoloaded. Read from anywhere as `GameConfig.<key>`.

# ─── Gate ───────────────────────────────────────────────────────────
@export var gate_columns: int = 11   # spans 11*60 = 660px of 720 vp → ~30px margin each side
@export var gate_rows: int = 12
@export var bubble_cell_px: int = 60

# ─── Wave structure ─────────────────────────────────────────────────
# num_waves is set per-match at run start from MetaState.waves_for_stage(stage).
# Default mirrors stage 1 so a direct MatchScene launch still works.
@export var num_waves: int = 5
@export var moves_per_wave: Array[int] = [10, 6, 6, 6, 6]
@export var intermission_duration_sec: float = 5.0
@export var pre_run_countdown_sec: float = 10.0   # Wave 1 "Get Ready" — longer than intermission to let player plan

@export var gate_seed_rows_per_wave: Array[int] = [4, 5, 6, 7, 8]
# Explicit per-wave hero count — capped at 3, decreasing curve so later waves
# force harder merging decisions with fewer fresh recruits.
@export var hero_bubbles_per_wave: Array[int] = [3, 3, 2, 2, 2]

func hero_bubble_count_for_wave(wave_idx: int) -> int:
	var i: int = clamp(wave_idx, 0, hero_bubbles_per_wave.size() - 1)
	return clamp(hero_bubbles_per_wave[i], 0, 3)

# Safe per-wave accessors. Stages 3-5 run 10-16 waves but the tuning arrays
# below are length 5 — past the end we hold at the last entry until per-wave
# content is authored.
func moves_for_wave(idx: int) -> int:
	return moves_per_wave[clamp(idx, 0, moves_per_wave.size() - 1)]

func seed_rows_for_wave(idx: int) -> int:
	return gate_seed_rows_per_wave[clamp(idx, 0, gate_seed_rows_per_wave.size() - 1)]

func wave_duration_for_wave(idx: int) -> float:
	return wave_duration_sec[clamp(idx, 0, wave_duration_sec.size() - 1)]

func spawn_totals_for_wave(idx: int) -> Dictionary:
	return SPAWN_TOTALS[clamp(idx, 0, SPAWN_TOTALS.size() - 1)]

func enemy_hp_mult_for_wave(idx: int) -> float:
	return enemy_hp_mult_per_wave[clamp(idx, 0, enemy_hp_mult_per_wave.size() - 1)]

func enemy_dmg_mult_for_wave(idx: int) -> float:
	return enemy_dmg_mult_per_wave[clamp(idx, 0, enemy_dmg_mult_per_wave.size() - 1)]

# ─── Enemy lane ─────────────────────────────────────────────────────
@export var enemy_lane_cells: int = 16
@export var enemy_base_damage: int = 20
@export var enemy_hero_damage: int = 10
@export var spawn_telegraph_sec: float = 1.5
@export var spawn_column_closed_bias: float = 0.7

@export var lane_traversal_sec_for_red: float = 6.0

@export var wave_duration_sec: Array[float] = [25.0, 22.0, 22.0, 22.0, 22.0]

const SPAWN_TOTALS: Array = [
	{"RED": 5},
	{"RED": 4, "BLUE": 2},
	{"RED": 4, "BLUE": 3, "YELLOW": 2},
	{"RED": 5, "BLUE": 3, "YELLOW": 3},
	{"RED": 6, "BLUE": 4, "YELLOW": 4},
]

@export var enemy_hp_mult_per_wave:  Array[float] = [1.0, 1.1, 1.2, 1.35, 1.5]
@export var enemy_dmg_mult_per_wave: Array[float] = [1.0, 1.0, 1.05, 1.1, 1.2]

const ENEMY_STATS: Dictionary = {
	"RED":    {"hp": 50,  "speed": 1.0,  "dmg_hero": 10, "dmg_base": 20},
	"BLUE":   {"hp": 80,  "speed": 0.67, "dmg_hero": 10, "dmg_base": 20},
	"YELLOW": {"hp": 120, "speed": 0.83, "dmg_hero": 15, "dmg_base": 25},
}

# ─── Player base ────────────────────────────────────────────────────
@export var base_max_hp: int = 100

# ─── Cannon ─────────────────────────────────────────────────────────
@export var cannon_reload_cooldown_sec: float = 0.2

# ─── Hit feel (per-hit polish on enemies) ───────────────────────────
# Tiny "freeze frame" stutter when a hit lands. Time scale dips to
# hit_freeze_time_scale for hit_freeze_duration_sec real-time seconds.
# Re-entrant calls during an active freeze are ignored so the rate is
# bounded even at peak fire density.
@export var hit_freeze_duration_sec: float = 0.035
@export var hit_freeze_time_scale: float = 0.05
# White-flash overlay drawn on top of the enemy sprite, alpha fades from 1→0.
@export var hit_flash_duration_sec: float = 0.09
# Floating damage number — vertical rise + fade.
@export var dmg_number_rise_px: float = 46.0
@export var dmg_number_lifetime_sec: float = 0.70
@export var dmg_number_font_size: int = 26
@export var dmg_number_crit_font_size: int = 34

# ─── Hero classes ───────────────────────────────────────────────────
# Hero lineup per stage is driven by MetaState.STAGE_LINEUP, not a static enable list.

# Hero class numbers (combat-design.md §7). All Bronze-tier baselines.
@export var hero_base_hp: float = 100.0
@export var hero_base_damage: float = 20.0

# Ranges below use lane_progress (0=far at gate, 1=at heroes). v1 quoted
# reach in lane cells; with enemy_lane_cells=20, "N rows ahead" maps to
# lane_progress >= (20-N)/20.

# Fire Knight (RED) — melee cone + cleave chance.
@export var red_fire_rate_sec: float = 0.5
@export var red_dmg_mult: float = 1.0
@export var red_cone_rows: int = 4                     # → lane_progress >= 0.80
@export var red_cone_cols: int = 1                     # ±1 col
@export var red_cleave_chance: float = 0.25
@export var red_cleave_targets: int = 2

# Ice Mage (BLUE) — lob + AoE splash + slow.
@export var blue_fire_rate_sec: float = 1.0
@export var blue_dmg_mult: float = 0.7
@export var blue_reach_rows: int = 6                   # → lane_progress >= 0.70
@export var blue_col_radius: int = 1                   # ±1 col
@export var blue_aoe_radius_px: float = 90.0           # ~1.5 gate cells (CELL=60)
@export var blue_slow_pct: float = 0.30                # 30% movement slow
@export var blue_slow_duration_sec: float = 2.0

# Archer (YELLOW) — straight column snipe + execute bonus.
@export var yellow_fire_rate_sec: float = 0.8
@export var yellow_dmg_mult: float = 1.4
@export var yellow_reach_rows: int = 16                # full lane (0–16) per combat-design §1
@export var yellow_execute_threshold: float = 0.30
@export var yellow_execute_bonus: float = 0.50

# Druid (GREEN) — single-target + chain heal.
@export var green_fire_rate_sec: float = 0.7
@export var green_dmg_mult: float = 0.9
@export var green_reach_rows: int = 5                  # → lane_progress >= 0.75
@export var green_col_radius: int = 1                  # ±1 col
@export var green_chain_heal_amount: int = 5
@export var green_chain_heal_targets: int = 2
@export var green_heal_per_hero_cap_per_sec: int = 15

# Wizard (PURPLE) — column snipe + arcane burst every Nth hit.
@export var purple_fire_rate_sec: float = 1.4
@export var purple_dmg_mult: float = 2.5
@export var purple_reach_rows: int = 10                # → lane_progress >= 0.50
@export var purple_burst_every_n_hits: int = 5
@export var purple_aoe_radius_px: float = 90.0         # ~1.5 gate cells

# Status effects (combat-design.md §7)
@export var status_slow_speed_mult: float = 0.7
@export var status_slow_duration_sec: float = 2.0
@export var status_freeze_duration_sec: float = 4.0
@export var status_burn_pct_per_sec: float = 0.03      # 3% max HP / sec / stack
@export var status_burn_duration_sec: float = 3.0
@export var status_burn_max_stacks: int = 3
@export var status_poison_pct_per_sec: float = 0.05    # 5% max HP / sec / stack
@export var status_poison_duration_sec: float = 3.0
@export var status_poison_max_stacks: int = 3
@export var status_stun_duration_sec: float = 1.0

# Boss + The Corrupter (boss-design.md §2, §4)
@export var boss_hp: int = 1000
@export var boss_lane_cell: int = 5                          # fixed lane cell (of 20)
@export var boss_telegraph_sec: float = 2.0
@export var boss_ability_interval_sec: float = 8.0
@export var boss_low_hp_threshold: float = 0.25
@export var boss_low_hp_interval_mult: float = 0.75          # 8s → 6s at low HP
@export var corruption_splash_radius_cells: int = 1
@export var corruption_target_bias_away_from_corrupted: float = 0.7
@export var corrupter_minion_first_spawn_delay_sec: float = 10.0
@export var corrupter_minion_spawn_interval_sec: float = 15.0
@export var corrupter_minion_closed_column_bias: float = 0.7

# Color counter / merge
@export var color_counter_mult: float = 2.0
@export var hero_tier_hp_mult:  Array[float] = [0.0, 1.0, 1.6, 2.4]   # Bronze=1.0
@export var hero_tier_dmg_mult: Array[float] = [0.0, 1.0, 1.5, 2.2]
