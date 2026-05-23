# Pop Brigade v2 — Boss Design

Boss design framework + the locked-in World 1 boss (The Corrupter / gate corruption mechanic).

> **Principle:** every boss in Pop Brigade introduces a mechanic that interacts with the gate, moves, or heroes — not a separate minigame. A boss fight should feel like a tactical twist on the core loop, not a context switch.

---

## 1 — Boss framework

Each boss has:

| Property | Spec |
|---|---|
| **Lane position** | Fixed Z-depth. Boss doesn't walk forward — stops at lane cell 5 (halfway between horizon and gate). |
| **HP pool** | Large flat number (no color, no counter). Killed by direct hero damage over time. |
| **Threat mechanic** | Recurring ability triggered on a timer. Interacts with gate / heroes / moves. |
| **Telegraph** | Visible signal 2s before each ability trigger. |
| **Minion support** | Spawns adds alongside the boss to keep lane pressure active. |
| **Defeat reward** | Run-end chest + world progression. |

Bosses do NOT have:
- Color counter weakness (no 2× elemental bonus). Pure throughput.
- Bash interaction with gate (they don't approach the gate; they affect it from afar).
- Status effect immunity (they take burns / slows / freezes from heroes normally).

---

## 2 — World 1 boss: The Corrupter

### 2.1 — Identity

A floating, oozing creature that stops at lane cell 5 and projects corruption tendrils into the gate. It can't reach you physically, but it rots your wall.

### 2.2 — Stats

| Stat | Value |
|---|---|
| HP | 1000 |
| Color | Purple (no archetype counter applies) |
| Lane position | Fixed at cell 5 |
| Movement | None (floats in place, slight bob) |
| Direct damage to base | Only via minions (Corrupter itself cannot reach base) |
| Minion spawn | 1 Walker every 15 seconds on a random column (see §2.5) |

### 2.3 — Threat mechanic: Gate Corruption

Every 8 seconds, the Corrupter targets a random gate column and corrupts every bubble in that column.

**Corruption visual:**
- 2-second telegraph: target column outlined in pulsing purple from the boss.
- On trigger: bubbles in the column flash, then turn grey/black (corrupted).
- Visual: cracks running across each corrupted bubble, faint purple aura.

**Corrupted bubble rules:**
- **No color.** Can't be popped by matching with a colored bubble.
- **Can be destroyed by splash.** If a normal 3+ match pops adjacent to a corrupted bubble, the corrupted one breaks too (1-cell splash radius).
- **Still blocks enemies mechanically.** A corrupted column counts as Closed in §2.3 of `design-spec.md`.
- **Still occludes heroes.** A corrupted bubble in the bottom 4 rows = column is closed for hero firing.
- **Counts for overflow.** If a column already has corruption, subsequent corruption rolls re-corrupt and add 1 bubble to the column (representing growing decay).

### 2.4 — Corruption tempo

| Time | Event |
|---|---|
| Wave 5 start | Boss spawns at cell 5. Telegraph + horn audio cue. |
| +2s | First telegraph appears on target column. |
| +4s | First corruption fires. |
| +12s | Second corruption telegraph (target different column). |
| +14s | Second corruption fires. |
| Every 8s thereafter | Telegraph + corruption alternating columns (random, weighted away from already-fully-corrupted columns). |

### 2.5 — Minion support

While the Corrupter floats at cell 5 and corrupts the gate, it also spawns supporting minions to keep lane pressure active.

| Property | Value |
|---|---|
| Type | RED Walker (baseline stats from `combat-design.md` §3.5) |
| Spawn cadence | 1 minion every 15 seconds |
| Spawn column | Random, weighted toward closed gate columns (same 0.7 bias as normal spawns) |
| Spawn delay (post boss-arrival) | First minion spawns 10s after boss appears (lets player set up) |
| Telegraph | 2s shadow at horizon, same as normal spawn telegraph |
| Color stats | Stage-scaled per wave 5 HP/damage multipliers (1.5× HP, 1.2× damage at stage 30) |

Minions are NOT corrupted bubbles — they're regular Walkers and can be killed normally by heroes.

**Why minions:** without lane pressure, the corruption mechanic doesn't matter — players could ignore the gate entirely and just focus heroes on the boss. Minions force the player to keep at least some columns open and active.

**Why only 1 every 15s:** more than that would overwhelm the boss as the primary threat. The fight should feel like "Corrupter is the main problem, minions are the secondary nuisance," not the inverse.

### 2.6 — Player counterplay

Three viable strategies:

1. **Pre-burn the boss.** Push hero damage hard before too many corruptions stack. With Gold heroes + frenzy, possible to kill the boss in ~25–30s before the gate is wrecked.
2. **Splash-clear corruption.** Use the move budget to set up matches adjacent to corrupted columns, splashing the corruption away. Costly but recovers gate usability.
3. **Lane sacrifice.** Accept that 2–3 columns will be permanently corrupted. Use them defensively (they're locked closed against enemies). Focus hero damage through the remaining open columns.

Strategy mix depends on the player's hero composition and remaining move budget. No single strategy dominates — this is the design intent.

### 2.7 — Boss death

- Boss HP 0 → run ends. Run-clear chest + world progression triggered.
- Corrupted bubbles **stay corrupted** in the final visual but the wave ends immediately on boss death.
- Lingering enemies on the lane despawn with a flourish.

### 2.8 — Telegraph + audio

- **Boss spawn:** distant horn + 1s screen tint to purple + camera shake.
- **Corruption telegraph:** purple lightning crackle from boss tendril to target column. Column outline pulses.
- **Corruption fire:** "shatter" SFX + grey particle burst.
- **Boss low HP (< 25%):** desperate roar, corruption interval drops to 6s (final stand).

---

## 3 — Future bosses (placeholder slots)

Locked design only for the Corrupter. Future bosses sketched as design space, not committed.

| World | Name | Mechanic concept | Notes |
|---|---|---|---|
| 1 | The Corrupter | Gate corruption (above) | Locked. |
| 2 | The Glacier | Freezes 3-column gate section for 5s on a 12s cycle. Frozen bubbles can't be popped or splashed. | Targets the player's *current* matching plans — punishes laziness. |
| 3 | The Stormcaller | Every 10s, picks a hero and locks them out of firing for 6s ("silenced"). | Targets the hero side of the loop, not the gate. |
| 4 | The Tax Collector | Eats 1 move from remaining budget every 12s. | Pressure on the move economy. Brutal — late game. |
| 5 | The Hive | Continuously spawns minions at half-depth into all columns. Boss is HP-only at cell 5. | Pure throughput test. End-game DPS check. |

Each boss interacts with a different system (gate, moves, heroes, throughput) so they don't feel mechanically duplicated.

---

## 4 — Boss balance dials

Tunable per-boss config:

```gdscript
@export var boss_hp: int = 1000
@export var boss_lane_cell: int = 5
@export var boss_telegraph_sec: float = 2.0
@export var boss_ability_interval_sec: float = 8.0
@export var boss_low_hp_threshold: float = 0.25
@export var boss_low_hp_interval_mult: float = 0.75    # interval shortens to 6s at low HP

# Corrupter-specific
@export var corruption_splash_radius_cells: int = 1
@export var corruption_target_bias_away_from_corrupted: float = 0.7

# Corrupter minions
@export var corrupter_minion_type: String = "walker_red"
@export var corrupter_minion_spawn_interval_sec: float = 15.0
@export var corrupter_minion_first_spawn_delay_sec: float = 10.0
@export var corrupter_minion_closed_column_bias: float = 0.7
```

---

## 5 — Reward structure

| Reward | Trigger |
|---|---|
| Run-clear chest | Boss defeated. Coins + hero shards + small chance of new hero. |
| World 1 first-clear bonus | One-time. Larger chest + 1 guaranteed Epic hero. |
| Per-wave clear coins | Each wave clear within the run (5 waves total). |
| Boss-only currency | Special drop from boss kills, used for prestige cosmetics. |

(Detail in `economy.md`.)
