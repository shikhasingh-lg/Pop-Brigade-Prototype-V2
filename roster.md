# Pop Brigade v2 — Hero Roster

Full hero spec. 5 classes × 4 rarity tiers = 20 base hero slots, with seasonal additions on top.

> **Core principle:** every hero belongs to one of 5 color classes. Color determines targeting style (cone / column / splash / DoT zone / burst). Rarity determines power per copy. Tier (Bronze / Silver / Gold from merge) is independent and stacks on top of rarity.

---

## 1 — Color class roster (5 classes)

Each class has a unique targeting style, fire pattern, and special. All classes share the same Bronze/Silver/Gold merge progression.

| Class | Color | Role | Targeting | Fire rate | Special |
|---|---|---|---|---|---|
| **Fire Knight** | RED | Frontline bruiser | Cone, own col ±1, depth 0–6 | 0.75 s | 25% cleave chance |
| **Ice Mage** | BLUE | AoE controller | Col ±1, depth 0–12, splash 1.5 cells | 1.6 s | 30% slow on hit, 2s |
| **Archer** | YELLOW | Long-range sniper | Own col, depth 0–20, furthest-first | 1.2 s | +50% dmg vs <30% HP |
| **Druid** | GREEN | Healer / damage-over-time | Cross pattern (own col + same row ±2) | 1.0 s | Heals adjacent heroes 5%/hit; poison ticks 3s |
| **Wizard** | PURPLE | Burst caster | Anywhere on lane (selectable target) | 2.5 s | Charged shot — high damage, slow fire |

### 1.1 — Druid (NEW for v2 — was v1.5 in v1)

Green hero. Sits on row 0 like other classes but plays a dual role: healing nearby allies and stacking poison on enemies.

**Targeting:** "Cross" pattern. Fires at any enemy in same column (depth 0–10) OR same row range as adjacent heroes (column ±2, depth 0–4).

**Damage:** 0.5× base damage per hit (low direct damage), but applies **Poison** status.
- **Poison:** target takes 5% of its max HP every second for 3 seconds. Stacks up to 3 (15% / 1s = 45% over 3s total).

**Heal:** every successful hit also heals adjacent heroes (column ±1 on row 0) for 5% of their max HP. Caps at full HP.

**Color counter:** 2× vs GREEN enemies (boss minions, future content). No GREEN enemies in World 1.

### 1.2 — Wizard (NEW for v2 — was v1.5 in v1)

Purple hero. The "ultimate" class — slow fire rate, massive damage per hit.

**Targeting:** player can **manually select** Wizard's target by tap-and-hold on a visible enemy (subject to occlusion). Default behavior: furthest enemy in any column with open or cracked gate.

**Damage:** 3.0× base damage per hit, but 2.5s fire rate (vs 1.2s Archer).

**Special — Charged Shot:** every 3rd shot is a Charged Shot — fires a bolt that travels through enemies, hitting up to 3 in a line, full damage to each. Visual: forking purple lightning.

**Color counter:** 2× vs PURPLE enemies (only bosses are purple — Wizard is the dedicated boss-killer class).

---

## 2 — Rarity tiers

Each class has 4 rarities. Higher rarity = stronger base stats. Independent from Bronze/Silver/Gold merge tier.

| Rarity | Base HP mult | Base DMG mult | Gacha pull rate | Notes |
|---|---|---|---|---|
| **Common (1★)** | 1.0× | 1.0× | 60% | Default hero. Available from session 1. |
| **Rare (2★)** | 1.3× | 1.2× | 30% | Slight stat boost + minor unique flair (e.g. different cleave VFX). |
| **Epic (3★)** | 1.6× | 1.4× | 8% | Class kit gets one upgrade (e.g. Epic Fire Knight cleave is 40% chance instead of 25%). |
| **Legendary (4★)** | 2.0× | 1.8× | 2% | New unique ability layered on class kit (see §3). |

A hero copy is rolled: **class** + **rarity**. So you might pull "Common Fire Knight" or "Epic Archer."

### 2.1 — Rarity duplicates

Pulling a duplicate of a hero you already own:
- Converts to **Hero Shards** of that class + rarity.
- Shards are spent to **rank up** the hero permanently (see `progression.md` §3).
- Rank-ups give small stat bumps (+5% / +10% / +15% across the 3 rank-up steps; Rank 4 is the cap — see `progression.md` §3.3).

---

## 3 — Legendary unique abilities

Legendary heroes get a class-specific signature ability on top of the base kit.

| Class | Legendary unique |
|---|---|
| Fire Knight | **Inferno Wave** — every 5th attack hits ALL enemies in a 3×3 area in front (massive cleave). |
| Ice Mage | **Frost Bomb** — every 5th attack creates a freeze zone (no movement) for 3s in target area. |
| Archer | **Eagle Eye** — Execute threshold raised from 30% → 50% HP. Twice as much "execute" coverage. |
| Druid | **Bloom** — every 5th attack heals ALL heroes on row 0 (not just adjacent) for 15%. |
| Wizard | **Meteor** — Charged Shot AoE radius doubled, plus 1s stun on hit. |

Legendary uniques are passive — they fire automatically. No new player input required.

---

## 4 — Hero ultimate abilities

Every hero (not just Legendary) has an **ultimate** charged by combat. Player triggers manually via tap on hero portrait.

### 4.1 — Charging

- Ultimate gauge fills as the hero deals damage and takes damage.
- Full at: deal 200 damage OR survive 30s in combat (whichever first).
- Visual: portrait outline glows + small "READY" icon when full.

### 4.2 — Ultimates per class

| Class | Ultimate | Effect |
|---|---|---|
| Fire Knight | **Charge!** | Hero leaps forward into the mid lane, deals 5× damage in a 2-cell radius, returns to row 0. 3s animation. |
| Ice Mage | **Blizzard** | Freezes all enemies on lane for 4s. They take no damage from heroes during freeze, but heroes can keep building shots. (Strategic pause.) |
| Archer | **Volley** | Fires 8 arrows in rapid succession, each at full damage, distributed across the highest-HP enemies on lane. |
| Druid | **Verdant Field** | Heals all heroes to full + applies +50% damage buff for 8s. |
| Wizard | **Annihilation** | Targets boss / strongest enemy. Deals 25% of target's max HP as true damage (ignores armor). Once per wave only. |

### 4.3 — Ultimate UX

- Hero portrait at bottom-left HUD (one slot per hero on row 0, up to 8 slots).
- Portrait fills with class color as ultimate charges.
- "READY" icon when full.
- Tap portrait to fire ultimate. Cannon dims for 0.5s during ultimate animation.
- After firing: gauge resets to 0, refills again.

---

## 5 — Gacha and pull rates

### 5.1 — Pull rates (per single pull)

| Result | Rate |
|---|---|
| Common hero | 60% |
| Rare hero | 30% |
| Epic hero | 8% |
| Legendary hero | 2% |
| Pity at 50 pulls | Guaranteed Epic+ |
| Pity at 100 pulls | Guaranteed Legendary |

Class within rarity is uniform (each of 5 classes equally likely).

### 5.2 — Pull cost

| Pull | Cost | Source |
|---|---|---|
| Single | 300 gems | Premium currency |
| 10-pull | 2700 gems | Bulk discount + pity protection |
| Free daily | 1 free single pull per day | Daily login |
| Event 10-pull | event currency | Limited-time events |

### 5.3 — Banner structure

| Banner | What it offers | Duration |
|---|---|---|
| **Standard** | All heroes at base rates | Always available |
| **Rate-up** | One Legendary at doubled rate (4%) | 2 weeks per banner |
| **Newcomer** | Discounted 10-pull (1500 gems), Epic guaranteed | First 7 days only |
| **Event** | Event-exclusive Legendary | Tied to live ops events |

---

## 6 — Hero loadout

### 6.1 — Pre-run loadout

Player selects up to **5 heroes** from their collection before each run. These define the gacha pool for the run's hero bubbles.

- Loadout slots unlock progressively: 3 slots at start, +1 at world 1 cleared, +1 at world 2 cleared.
- Selecting same hero multiple times in loadout = higher chance of that hero appearing.
- Mix of classes recommended (color counters apply to enemy variety).

### 6.2 — Hero bubble pool

During the run, when a hero bubble is popped, the spawned hero is drawn from the loadout pool with uniform probability among selected entries.

If loadout has [Common FK ×2, Epic Archer, Rare Druid], pulls are weighted 2/4 FK, 1/4 Archer, 1/4 Druid.

---

## 7 — Numbers reference (initial)

Base stats per Bronze tier (the lowest spawn tier from match size 3-5):

```gdscript
# Per-class base (Bronze, Common rarity)
@export var fk_base_hp: int = 100
@export var fk_base_dmg: int = 20
@export var im_base_hp: int = 80
@export var im_base_dmg: int = 14
@export var arch_base_hp: int = 70
@export var arch_base_dmg: int = 28
@export var druid_base_hp: int = 90
@export var druid_base_dmg: int = 10
@export var wiz_base_hp: int = 75
@export var wiz_base_dmg: int = 60

# Tier multipliers (applies on top of class base + rarity mult)
@export var bronze_mult: float = 1.0
@export var silver_mult: float = 1.5
@export var gold_mult: float = 2.25

# Rarity multipliers (HP and DMG)
@export var common_mult: float = 1.0
@export var rare_mult: float = 1.25
@export var epic_mult: float = 1.5
@export var legendary_mult: float = 1.9

# Effective hero stat = base × tier_mult × rarity_mult × rank_bonus
```
