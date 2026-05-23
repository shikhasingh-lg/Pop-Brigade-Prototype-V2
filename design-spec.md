# Pop Brigade v2 — Design Spec

Full mechanical spec for the v2 redesign. Companion to `concept.md` and `combat-design.md`.

> **Architecture:** Wave-based with move budget per wave. Each wave: a fresh bubble gate is seeded; enemies spawn on a depth rail and march at the gate; player gets N moves to pop strategically. Bubbles and enemies live simultaneously — popping is offense (frees heroes, opens shooting lanes) and defense risk (lets enemies through). Heroes auto-fire continuously. No Phase 1 / Phase 2 boundary like v1.

---

## 1 — Playfield layout

Portrait orientation. Pseudo-3D: depth illusion via sprite scale + Y-position. All mechanics are 2D under the hood.

### 1.1 — Screen zones (top to bottom)

| Zone | Screen Y% | What lives here |
|---|---|---|
| **Sky** | 0–8% | Bubble preview (next cannon shot loaded). |
| **Far lane** | 8–25% | Enemies at horizon. Scale 0.3–0.5. Walk forward (down in screen space). |
| **Gate zone** | 22–58% | Bubble cluster wall. Overlaps far lane visually (parallax). |
| **Mid lane** | 55–68% | Enemies that have breached the gate. Scale 0.7–1.0. Approaching heroes. |
| **Hero row** | 68–77% | Row 0. Heroes stand here, draggable horizontally. |
| **Cannon** | 77–95% | Cannon, aim line, remaining moves counter. |
| **HUD** | 0–8% & 95–100% | Wave number, base HP, hero queue. |

### 1.2 — Grid (mechanical)

- **Gate grid:** 8 columns × 12 rows. Bubble cell = 60 px. Bubbles stack downward from row 0.
- **Enemy lane:** same 8 columns as the gate. Enemies travel on a virtual rail per column. Lane depth = 20 cells. Cell 20 = far horizon spawn. Cell 0 = at the gate base.
- **Hero row:** 8 columns × 1 row, below the gate.

Columns are shared across the three systems — column 3 of the gate is in front of column 3 of the enemy lane is in front of column 3 of the hero row. Critical for the targeting / occlusion logic.

---

## 2 — The gate

### 2.1 — How bubbles arrive

- **At wave start:** the gate is seeded with a fresh bubble cluster. Composition (size, color mix, hero bubble count) determined by wave script (§5).
- **During the wave:** **no sky drops.** The gate is static. The only ways bubbles leave are matched pops (player) and enemy bashes (enemies). The only way new bubbles enter is via cannon shots that land without matching.
- **Between waves:** brief intermission. Surviving gate bubbles either clear out fully (fresh start each wave) or persist (carry-over). See Q below in `open-questions.md`. **Default: clear and reseed.**

### 2.2 — How bubbles leave

- **Matched pop (player):** 3+ same-color group → all matching bubbles + any floaters disappear. Costs 1 move.
- **Cannon miss (player):** cannon shot that doesn't form a 3+ match attaches to the gate as a new bubble in that column. Still costs 1 move. Punishes sloppy aim.
- **Hero bubble pop:** any matched group containing a hero bubble frees that hero (see `combat-design.md`).
- **Enemy bash:** when an enemy reaches the gate in a column where the bottom-row bubble exists, it takes 1 second to bash. Bash destroys that bubble. Enemy takes `enemy_bash_self_damage` (small). If column still has bottom-4-row bubbles, enemy re-bashes.

### 2.3 — Gate column states

Each column can be in one of three states from the enemy's perspective:

| State | Definition | Enemy behavior |
|---|---|---|
| **Closed** | ≥1 bubble in bottom 4 rows of column | Blocked. Walks to gate base, bashes bottom bubble. |
| **Cracked** | ≥1 bubble in column but bottom 4 rows empty | Walks through but takes a brief 30% slow (debris). |
| **Open** | No bubbles in column | Walks through at full speed. |

### 2.4 — Hero-bubble density

- 1 in 8 of the gate-seeded bubbles is a hero bubble (same as v1).
- Each wave's seed guarantees at least 1 hero bubble in the starting cluster.
- Hero class drawn from the player's gacha pool (v1 prototype: random from enabled classes).
- Hero bubble has a visible portrait + glow ring.

---

## 3 — Enemies and the depth lane

### 3.1 — Spawning

- Each wave has a **scripted spawn timeline** (see §5.2 for default composition per wave).
- Enemies spawn at lane cell 20 (far horizon) on a specific column at scripted times.
- Spawn column biased toward currently-closed gate columns (forces the player to actively manage the gate, not let it stagnate).
- 2-second telegraph: shadow appears in the target column at the horizon before the enemy fades in.

### 3.2 — Movement

- Enemies walk forward at color-stat speed. RED = 1.0 cell/s, BLUE = 0.67 cell/s, YELLOW = 0.83 cell/s.
- Sprite scale lerps 0.3 → 1.0 as lane cell drops 20 → 0 (pseudo-3D illusion).
- Once at lane cell 0 (gate base): see §2.3.
- After breach: walks through mid lane toward hero row at full speed.
- On reaching hero row in a column with a hero: engages, deals `enemy_hero_damage` per second to the hero, stops moving. If hero dies, resumes toward cannon.
- On reaching cannon (no hero blocked it): deals `enemy_base_damage` to base HP. Despawns.

### 3.3 — Color archetypes

| Color | HP | Speed (cells/s) | Damage on hero/base |
|---|---|---|---|
| RED | 50 | 1.0 | 10 / 20 |
| BLUE | 80 | 0.67 | 10 / 20 |
| YELLOW | 120 | 0.83 | 15 / 25 |

### 3.4 — Variants

Same as v1 §4.3 — Walker (default), Runner (wave 3+), Brute (wave 4+), Boss (wave 5). Tag-based.

---

## 4 — Heroes

Full details in `combat-design.md`. Summary here.

- Heroes stand on hero row (8 cells, 1 per column).
- Auto-fire at enemies in their targeting zone whenever a clear line exists through the gate (occlusion rule, §6).
- **Draggable horizontally along hero row at any time** (no phase gate — drag is always live, unlike v1 which gated to Phase 2).
- Drag-to-merge same-class same-tier.
- Hero bubble in the gate, when popped, drops a hero to row 0 in the column directly below.

---

## 5 — Wave structure

v2 keeps v1's discrete wave format. Each wave is its own round with its own move budget and enemy script. **Bubbles do not refill during a wave** — what's in the gate at wave start is what you have to work with, minus pops, minus enemy bashes, plus cannon misses that attach.

### 5.1 — Move budget per wave

| Wave | Moves | Notes |
|---|---|---|
| 1 | **10** | Onboarding. Generous to let player learn the gate + heroes. |
| 2 | **6** | Tightens immediately. |
| 3 | **6** | |
| 4 | **6** | |
| 5 (boss) | **6** | Boss wave. Same budget, much harder composition. |

After wave 5 default: run ends (boss-gated). Endless mode (post-launch) would extend with continued 6-move waves and intensity scaling.

### 5.2 — Enemy composition per wave

Starting point — retune in playtest.

| Wave | Scripted spawns | Variant adds |
|---|---|---|
| 1 | 5 RED Walkers | — |
| 2 | 4 RED + 2 BLUE Walkers | — |
| 3 | 4 RED + 3 BLUE + 2 YELLOW | + 1 Runner |
| 4 | 5 RED + 3 BLUE + 3 YELLOW | + 1 Runner + 1 Brute |
| 5 (boss) | 6 RED + 4 BLUE + 4 YELLOW + Boss | + 2 Runners + 2 Brutes |

Spawn timeline: enemies don't all spawn at once. Scripted across the wave duration so the player gets pacing beats (small clusters → break → next cluster).

### 5.3 — Gate seed per wave

Each wave's starting cluster is also wave-scaled:

| Wave | Gate bubbles (approx) | Hero bubbles | Color mix |
|---|---|---|---|
| 1 | 32 (4 rows × 8 cols) | 4 | RED-heavy |
| 2 | 40 (5 rows) | 5 | RED + BLUE |
| 3 | 48 (6 rows) | 6 | RED + BLUE + YELLOW |
| 4 | 56 (7 rows) | 7 | Full mix |
| 5 | 64 (8 rows) | 8 | Full mix + denser |

### 5.4 — Wave end condition

A wave ends when one of these happens, checked in order:

1. **All enemies dead** → wave win. Intermission begins.
2. **Base HP = 0** → run end (fail).
3. **Moves exhausted AND no heroes alive AND enemies still on the field** → wave loss / run end. Heroes continue auto-firing if alive even after moves run out, so this is rare.

Running out of moves does NOT end the wave on its own. Heroes keep auto-firing through whatever lanes remain. If your heroes can clean up the rest, you win the wave without popping any more.

### 5.5 — Intermission between waves

- ~5 second pause. UI shows wave result + next wave preview.
- Heroes carry over with HP preserved.
- Gate clears entirely (default — see Q in `open-questions.md`).
- Next wave's gate seed appears.
- Move counter resets to new wave's budget.
- (Optional: small heal for surviving heroes — TBD.)

---

## 6 — Bullet occlusion (the core tactical layer)

This is the new mechanical depth of v2. Heroes can only shoot enemies they have **line of sight** to through the gate.

### 6.1 — Cannon → gate

Cannon bullets travel **up** toward the gate. They hit the **first bubble in their trajectory** or attach to the gate if no match forms (cannon miss). Standard bubble-shooter behavior. No interaction with enemies.

### 6.2 — Hero → enemy

Hero bullets travel **up through the gate column** to reach enemies in the lane.

- If the hero's column has a **closed** gate (any bubble in bottom 4 rows), the hero's bullet is blocked — it does not fire.
- If the hero's column is **cracked or open**, the hero fires normally.
- Heroes with multi-column targeting (Fire Knight cone, Ice Mage splash) check the **target's column** state, not the hero's own column.

This means: closing a column is defensive (blocks enemies) but silences the hero in that column. The player must balance.

### 6.3 — Visual feedback

- Closed-column hero: dim sprite overlay + faint "would-fire" targeting line so player understands why.
- Open-column hero: subtle glow, bullet line visible through gate gap on each shot.

---

## 7 — Scoring + progression

### 7.1 — Run rewards

- **Bubbles popped:** XP toward hero gacha currency.
- **Enemies killed:** soft currency (coins).
- **Heroes freed:** count toward run goal / mission objectives.
- **Wave clears:** unlock next wave + reward chest at intervals.

### 7.2 — Fail state

- **Base HP = 0** → run ends. Each enemy that reaches the cannon (no hero blocking) deals `enemy_base_damage`.
- Hero deaths do NOT end the run. Hero respawns from queue or next freed hero bubble.

### 7.3 — Meta loop

- **Hero collection:** gacha. New heroes unlock new classes / colors.
- **Hero permanent upgrades:** between runs. Stat boosts per class.
- **World / chapter progression:** runs gated by best wave reached.

(Full meta design is out of scope for this doc.)

---

## 8 — Run length and end condition

**Default: 5-wave boss-gated run, ~4-6 minutes.** Run ends when wave 5 boss is defeated OR base HP hits 0.

Endless mode is post-launch.

---

## 9 — Config exports (initial values, all tunable)

```gdscript
# Gate
@export var gate_columns: int = 8
@export var gate_rows: int = 12
@export var hero_bubble_density: float = 0.125  # 1 in 8

# Wave structure
@export var moves_per_wave: Array[int] = [10, 6, 6, 6, 6]
@export var num_waves: int = 5
@export var intermission_duration_sec: float = 5.0
@export var clear_gate_between_waves: bool = true
@export var heal_heroes_between_waves: bool = false   # tunable

# Gate seed per wave
@export var gate_seed_rows_per_wave: Array[int] = [4, 5, 6, 7, 8]
@export var hero_bubbles_per_wave: Array[int] = [4, 5, 6, 7, 8]

# Enemy lane
@export var enemy_lane_cells: int = 20
@export var enemy_bash_duration_sec: float = 1.0
@export var enemy_bash_self_damage: int = 5
@export var enemy_base_damage: int = 20
@export var enemy_hero_damage: int = 10
@export var spawn_telegraph_sec: float = 2.0
@export var spawn_column_closed_bias: float = 0.7    # 0=random, 1=always closed

# Enemy stats per wave
@export var enemy_hp_mult_per_wave: Array[float] = [1.0, 1.1, 1.2, 1.35, 1.5]
@export var enemy_dmg_mult_per_wave: Array[float] = [1.0, 1.0, 1.05, 1.1, 1.2]

# Player base
@export var base_max_hp: int = 100

# Cannon
@export var cannon_reload_cooldown_sec: float = 0.2

# Hero firing / occlusion
@export var occlusion_check_rows: int = 4    # bottom-N rows define "closed"
```

---

## 10 — Telemetry events

- `wave_start` — wave number, gate seed snapshot, move budget.
- `wave_end` — result (win/loss/timeout), moves used, time elapsed, heroes alive.
- `gate_state_snapshot` — sampled every 5s. Per-column { state, hero_present, bubbles_in_col }.
- `hero_bullet_blocked` — every time a hero would fire but is gated. Catches players who don't understand occlusion.
- `enemy_breach` — enemy crosses gate. Tags column, state, hero_present.
- `cannon_miss` — shot that attached without matching. Tags column, intent vs result.
- `bubble_pop` — match size, contains_hero, color, wave.
- `hero_freed`, `hero_merge`, `hero_death` — from v1 telemetry.

---

## 11 — What's removed from v1

- Phase 1 / Phase 2 boundary (combat is always live).
- Cluster-converted enemies at P1→P2 (no phase transition exists).
- Cluster descent timer (would only matter mid-wave; we keep gate static instead).
- Boss cluster shake (replaced by The Corrupter — see `boss-design.md`).

## 12 — What survives from v1 unchanged

- Hero class roster (Fire Knight / Ice Mage / Archer / Druid / Wizard — all 5 enabled in v2).
- Bronze / Silver / Gold tier + drag-to-merge.
- Color counter (2× same-color).
- Hero bubble + freeing rules.
- Hero queue + row-0 placement resolution.
- Carry-over heroes between waves.
- Per-wave move budget (just retuned to [10, 6, 6, 6, 6]).
- Wave-scaled enemy HP / damage multipliers.

## 13 — What's new in v2

- Pseudo-3D depth lane (enemies approach in Z, not Y).
- Gate metaphor — bubble cluster physically blocks enemies.
- Bullet occlusion — heroes only fire through open/cracked gate columns.
- Drag is always live (not gated to Phase 2).
- Bubble + enemy gameplay is simultaneous within each wave.
