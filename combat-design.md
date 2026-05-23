# Pop Brigade v2 — Combat Design

How heroes, enemies, and the gate interact mechanically. Companion to `design-spec.md`.

> **Recap:** Heroes stand on hero row (row 0, 8 columns) behind the gate. Enemies approach from a 20-cell-deep lane behind the gate. Hero bullets must pass through their column of the gate to reach enemies. Closed gate column = hero silenced. Open gate column = hero fires + enemy walks through.

---

## 1 — Hero classes (v2-enabled)

Roster unchanged from v1. Targeting zones updated for the depth lane.

| Class (color) | Targeting | Fire rate | Damage | Special | Gate dependency |
|---|---|---|---|---|---|
| **Fire Knight** (RED) | Cone in own column ±1, depth lane cells 0–6 (close range) | 0.75 s | 1.0× | 25% cleave: hit adjacent enemies in target's row | Fires if **target's column** is cracked or open |
| **Ice Mage** (BLUE) | Own column ±1, depth lane cells 0–12 (mid range), AoE 1.5-cell radius on impact, 30% slow / 2s | 1.6 s | 0.7× | AoE splash + slow | Fires if **target's column** is cracked or open |
| **Archer** (YELLOW) | Own column only, depth lane cells 0–20 (full lane), furthest-first | 1.2 s | 1.4× | Execute: +50% dmg vs enemies < 30% HP | Fires if **own column** is cracked or open |

### 1.1 — Targeting rule changes from v1

- **Lane axis switched from row-based to depth-based.** v1 used row 0 to row -15 (vertical screen). v2 uses lane cell 0 (closest to gate base) to lane cell 20 (horizon).
- **Fire Knight** now triggers on **close enemies** (those that have breached the gate or are 1-6 cells away). This makes it a "last line of defense" class. Strongly rewards heroes placed in columns the player intentionally leaves open.
- **Archer** still snipes furthest enemies, but now its column must be cracked or open. Closed-column Archers are silenced — creates a real tension because Archers want clear sight lines.
- **Ice Mage** spans mid range and gets bonus from AoE hits when enemies bunch up at the gate base (which is the common case during waves).

### 1.2 — Hero firing decision tree (per fire-rate tick)

```
1. Pick a target (per class rule)
   - No target? Don't fire.
2. Check gate column of target (for FK / IM) or own column (for Archer)
   - Closed (bubble in bottom 4 rows)? Don't fire. Show dim VFX.
   - Cracked or open? Fire.
3. Apply color counter (×2 if hero color == enemy color).
4. Resolve damage, VFX, telemetry.
```

### 1.3 — Hero placement strategy emerges from this

- **Archer:** wants open columns so it can snipe. Player should drag Archers to columns they're keeping cleared.
- **Fire Knight:** wants its column to be a breach point so close enemies arrive. Player drags FKs to "sacrificial" columns they let enemies through.
- **Ice Mage:** wants to be near where enemies bunch — usually adjacent to a closed column where enemies pile up at the gate base. AoE shines there.

This is the strategic depth v2 unlocks that v1 didn't have: hero placement isn't cosmetic, it interacts with how the player chooses to manage gate state.

---

## 2 — Hero freeing from the gate

Mechanically identical to v1, with one wrinkle for the continuous bubble drop.

### 2.1 — Hero bubble basics

| Property | Value |
|---|---|
| Density | 1 in 8 of dropped bubbles is a hero bubble |
| Floor | At run start, gate is pre-seeded with 1–2 hero bubbles guaranteed |
| Visibility | Hero portrait visible on the bubble (always) |
| Hero identity | Drawn from player's gacha pool (v1 prototype: random from enabled classes) |
| Bubble color | Independent of trapped hero's class |
| Match requirement | Hero bubble freed only when its bubble is popped via a 3+ same-color match |

### 2.2 — On pop (one or more hero bubbles in matched group)

1. Hero bubble breaks. Hero spawns at row 0 in the column **directly below** where the bubble was.
2. Tier by match size: 3–5 = Bronze, 6–9 = Silver, 10+ = Gold. One hero per popped hero bubble.

### 2.3 — Row 0 placement resolution (when target column on row 0 is occupied)

Identical to v1:

1. **Direct column merge** — if hero already in that column matches class + tier, merge in place.
2. **Nearest empty** — search outward (±1, ±2…) for nearest empty row 0 cell.
3. **Adjacent merge** — same-class same-tier hero on row 0 within search range: merge there.
4. **Tier-upgrade replace** — all cells full, no merge target, incoming tier > lowest existing: replace lowest (tie: oldest).
5. **Queue** — FIFO, max 3. Fills next vacated cell.

Bronze never silently replaces Gold. Merge wins over replace.

### 2.4 — Hero drag + merge (continuous, no phase gate)

v1 gated drag to Phase 2. **v2 has no phases — drag is always live.**

- Press-and-hold a hero → it lifts. Press is detected on hero sprite hitbox.
- Drag horizontally along row 0 (no vertical movement).
- Release commits:
  - Empty cell → move
  - Same class + same tier → merge (Bronze + Bronze = Silver, Silver + Silver = Gold, Gold + Gold = no merge)
  - Different class or tier → swap
- **Aim block during drag:** cannon dims and won't fire while a hero is being dragged. Prevents thumb conflict.

---

## 3 — Enemies

### 3.1 — Spawn behavior

- Spawn at lane cell 20 in a chosen column. Sprite scale 0.3 (small, distant).
- Spawn cadence and color totals per wave are scripted in `GameConfig.SPAWN_TOTALS` and paced across `wave_duration_sec`.
- Spawn column **biased toward currently-closed gate columns** (force the player to keep the gate dynamic, not static).
- Visible 2s telegraph before spawn: shadow appears in the target column at far horizon, then enemy fades in. Helps the player anticipate where to open the gate.

### 3.2 — Approach behavior

- Walks forward (down in screen space) toward the gate at color speed.
- Scale lerps 0.3 → 1.0 as lane cell drops 20 → 0 (pseudo-3D illusion).
- Y screen position lerps `far_lane_y` → `gate_base_y` over the same trip.

### 3.3 — At the gate

| Gate column state | Enemy action |
|---|---|
| **Closed** (bubble in bottom 4 rows) | Stops at gate base. Begins **bashing** the bottom bubble. Bash takes `enemy_bash_duration_sec` (1.0s default). On bash complete: bottom bubble of that column is destroyed. Enemy takes `enemy_bash_self_damage` (5 HP). If column still has bottom-4-row bubbles, enemy re-bashes. If column is now cracked or open, enemy advances. |
| **Cracked** (some bubbles in column, but bottom 4 rows empty) | Walks through, takes a brief 30% slow for 1s (caught on debris). |
| **Open** (no bubbles in column) | Walks through at full speed. |

### 3.4 — Post-breach behavior

- After crossing gate base, enemy enters mid lane (screen Y 55–68%).
- Continues forward toward hero row at full color speed.
- On reaching hero row in a column with a hero present:
  - Engages hero. Deals `enemy_hero_damage` per second to the hero. Stops moving.
  - If hero dies, resumes movement toward cannon.
- On reaching cannon (no hero blocked it):
  - Deals `enemy_base_damage` (20) to base HP. Despawns.

### 3.5 — Enemy color archetypes

Same as v1 §4.2:

| Color | HP | Speed (cells/s, lane) | Damage on hero/base |
|---|---|---|---|
| RED | 50 | 1.0 | 10 / 20 |
| BLUE | 80 | 0.67 | 10 / 20 |
| YELLOW | 120 | 0.83 | 15 / 25 |

### 3.6 — Variants

Mechanical variants, gated by wave number within the run:

| Variant | Unlock | Tag | Stat delta |
|---|---|---|---|
| **Walker** (default) | Wave 1+ | — | baseline |
| **Runner** | Wave 3+ | thin white outline | speed ×0.6, HP ×0.7 |
| **Brute** | Wave 4+ | scale 1.4 + dark inner ring | HP ×2.0, speed ×1.3, damage ×1.5 |
| **Mini-boss** (YELLOW Brute on wave 5 of normal stages) | Wave 5 of stages 1-29 | scale 1.6 + crown | HP ×3.0, speed ×1.0, damage ×2.0 |
| **World Boss** | Wave 5 of world boss stages (30, 60, ...) | unique visual per world | See `boss-design.md` |

Variant is a tag (Walker/Runner/Brute/Miniboss), not a separate scene. World bosses are separate entities with bespoke behavior.

---

## 4 — Color counter and frenzy

### 4.1 — Color counter (unchanged from v1)

Hero of color X deals **2× damage** to enemies of color X.

### 4.2 — Color frenzy

The gate is **finite per wave** (no mid-wave sky drops), so v1's "clear all of color X" trigger works again in v2.

**Default:** clear every bubble of one color from the current gate → that color's heroes get **+50% damage for the rest of the wave**. Same as v1, applied per-wave instead of per-Phase-2.

Visual: hero glow during buff + screen edge tint pulse on trigger.

Alternative triggers (e.g. mass-pop bonus on 8+ matches) are in `open-questions.md` if playtest shows clear-all is too rare to fire.

---

## 5 — Hero death and carry-over

- HP 0 → hero dies. Particle burst. Cell becomes empty.
- Queued hero takes the slot (FIFO).
- The enemy that killed the hero continues toward the cannon.
- **Run-level carry-over:** surviving heroes persist across checkpoints within a run (HP + column preserved).
- **Cross-run carry-over:** TBD — see `open-questions.md`.

---

## 6 — Hero ultimates

Every hero charges an ultimate gauge through combat. Player triggers manually.

### 6.1 — Charging

- Ultimate gauge fills as the hero deals or takes damage.
- Full at: deal 200 damage OR survive 30s in combat (whichever first).
- Visual: portrait outline glows + "READY" icon when full.

### 6.2 — Per-class ultimates

| Class | Ultimate | Effect |
|---|---|---|
| Fire Knight | **Charge!** | Leaps into mid lane, 5× damage in a 2-cell radius, returns. 3s anim. |
| Ice Mage | **Blizzard** | Freezes all lane enemies for 4s. No damage during freeze; heroes can build shots. Strategic pause. |
| Archer | **Volley** | 8 rapid arrows, full damage each, distributed across highest-HP enemies. |
| Druid | **Verdant Field** | All heroes heal to full + +50% damage for 8s. |
| Wizard | **Annihilation** | 25% of target's max HP as true damage (ignores armor). Once per wave only. |

### 6.3 — UX

- Hero portraits in bottom-left HUD strip (8 slots, one per row-0 hero).
- Tap full portrait → fire ultimate. Cannon dims 0.5s during animation.
- Charge persists across waves (within a run). Resets on hero death and at run end.

(Full details in `roster.md` §4.)

---

## 7 — Status effects

Five status effects can be applied by heroes or bosses. Stack rules below.

| Status | Applied by | Effect | Duration | Stack rule |
|---|---|---|---|---|
| **Slow** | Ice Mage | Target speed ×0.7 | 2s (refreshes on reapply) | Doesn't stack — refreshes only |
| **Freeze** | Ice Mage ult (Blizzard) | Target speed ×0 | 4s | Doesn't stack — refreshes only |
| **Burn** | Fire Knight Legendary uniques (future) | 3% max HP / 1s | 3s | Stacks up to 3 (9% / 1s) |
| **Poison** | Druid | 5% max HP / 1s | 3s | Stacks up to 3 (15% / 1s) |
| **Stun** | Wizard Legendary unique (Meteor) | Movement + actions disabled | 1s | Doesn't stack — refreshes only |

### 7.1 — Status visuals

| Status | Visual |
|---|---|
| Slow | Faint blue trail behind enemy |
| Freeze | Ice crystals over enemy, no animation |
| Burn | Orange flame particles around enemy |
| Poison | Green bubbles dripping from enemy |
| Stun | Stars rotating above enemy |

Each is a `Sprite2D` overlay on the enemy with a short-lived `AnimationPlayer`.

### 7.2 — Status removal

- Status auto-clears on duration end.
- Enemy death clears all statuses (no carry-over to other enemies).
- No active dispel mechanism in v2 (no hero "cleanses" a status).

### 7.3 — Status priority

- Multiple statuses can stack on one enemy.
- Damage-over-time effects (Burn + Poison) tick on same frame.
- Movement modifiers (Slow + Freeze) — Freeze wins (movement stops entirely).

---

## 8 — Class synergies

If 3+ heroes of the same class are on row 0 simultaneously, the class gets a synergy buff.

| Class | 3+ synergy buff | 5+ synergy buff |
|---|---|---|
| Fire Knight | +10% damage | +20% damage + cleave chance +10% |
| Ice Mage | -10% fire rate (faster) | -20% fire rate + slow duration +1s |
| Archer | +10% damage | +20% damage + execute threshold to 40% |
| Druid | Heal also gives +5% damage buff to healed heroes for 5s | Heal applies to all row 0 (not just adjacent) |
| Wizard | Charged shot every 2nd shot instead of 3rd | Annihilation cooldown becomes 2× per wave instead of 1× |

### 8.1 — Synergy UX

- Active synergy shown as a small badge on each hero's portrait.
- Triggers immediately when count hit, drops immediately when count falls below.
- Synergy badges fade in/out with the count change.

### 8.2 — Tactical implication

- Players are incentivized to build "class clusters" via the loadout system.
- Trade-off: full-class loadout = strong synergy but poor color counter coverage against multi-color enemy waves.
- Mixed loadout = balanced, fewer synergies.

This is where deck-building meta emerges — players experiment with class-focused vs balanced loadouts per stage.

---

## 9 — Boss design

Locked: World 1 boss is **The Corrupter** with gate corruption mechanic. Full spec in `boss-design.md`.

Per-world boss design summary:
- World 1: Gate corruption.
- World 2 (planned): Bubble freeze.
- World 3+ (planned): see `boss-design.md` §3.

Each boss mechanic targets a different player system (gate / heroes / moves / throughput) to prevent mechanical duplication.

---

## 7 — Numbers

Canonical tuning lives in `godot/scripts/GameConfig.gd`. This doc is the rationale; that file is the source of truth.
