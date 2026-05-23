# Pop Brigade v2 — Progression Systems

The meta loop: what players do between runs, why they come back tomorrow, what they spend on, what unlocks.

> **Core loop:** run (5 waves) → rewards → meta upgrades → harder run available → repeat.
> **Session goal:** new player completes 1 full run + 1 hero upgrade in their first session (~5 min).
> **Retention dial:** stages get incrementally harder; player has to upgrade heroes to keep clearing.

---

## 1 — World and stage structure

### 1.1 — World map

The game is divided into **worlds**. Each world is a themed chapter with:
- 30 stages.
- A unique world boss at stage 30 (the boss mechanic from `boss-design.md`).
- A visual theme (biome / palette / enemy reskins).
- A gacha pool unlock at world clear (new heroes available).

**World 1: The Bubbling Plains.** Default. Corrupter boss. RED/BLUE/YELLOW enemies only.
**World 2: Frozen Spires.** Unlocks at World 1 cleared. Glacier boss. Adds GREEN poison enemies. Reskinned visuals.
**World 3+:** placeholder, designed post-launch.

### 1.2 — Stage structure

A **stage** = one 5-wave run. Move budget [10, 6, 6, 6, 6] per run.

| Stage range | Difficulty | Wave 5 boss |
|---|---|---|
| 1–5 | Onboarding. Easy enemy comps. No boss yet. | Wave 5 is a "mini-boss" — a fat YELLOW Brute. |
| 6–15 | Standard. Variants start appearing earlier. | Mini-boss again, harder. |
| 16–25 | Hard. Multi-column synchronized waves. | Mini-boss. |
| 26–29 | Pre-world-boss. | Mini-boss preview of world boss mechanic (lite version). |
| **30** | **World boss.** | The Corrupter (World 1). |

Stages 31+ unlock World 2.

### 1.3 — Stage difficulty curve

Within a world, difficulty ramps via:
- Enemy HP/damage multiplier per stage (1.0× at stage 1 → 2.0× at stage 30).
- Variant spawn rate (Runners + Brutes more frequent at higher stages).
- Hero bubble density slightly lowered at high stages (1/8 base → 1/10 at stage 30) — fewer free heroes.
- Move budget unchanged ([10,6,6,6,6]) — the player's solution is hero power, not more moves.

### 1.4 — Stage gating

- Stage N+1 unlocks when stage N is cleared (boss defeated for World boss stages, last enemy killed for normal stages).
- Player can replay any cleared stage for rewards.
- "Best wave reached" recorded per stage (for failed attempts).

---

## 2 — Run rewards

What the player earns per run.

### 2.1 — Per-wave rewards (within a run)

| Reward | Source |
|---|---|
| Wave-clear coins | Killing all enemies in a wave. Scales with stage number. |
| Pop bonus XP | Per bubble popped. Capped per wave. |
| Hero freed bonus | Per hero freed during the wave. |

### 2.2 — Run-end chest (boss/last-enemy defeated)

| Tier | Trigger | Contents |
|---|---|---|
| **Bronze chest** | Stages 1–10 clear | 50 coins + 1 hero shard |
| **Silver chest** | Stages 11–20 clear | 150 coins + 3 hero shards + 5 gems |
| **Gold chest** | Stages 21–29 clear | 400 coins + 8 hero shards + 15 gems |
| **World chest** | World boss clear (stage 30, 60...) | 1000 coins + 25 hero shards + 100 gems + 1 guaranteed Epic+ hero |

### 2.3 — First-clear bonuses (one-time per stage)

- Stage 1–9 first clear: +20 gems
- Stage 10, 20 first clear: +100 gems
- World boss first clear: 500 gems + Legendary pull token

---

## 3 — Hero progression

A hero copy has **3 progression axes** that compound:

### 3.1 — Tier (Bronze → Silver → Gold)

- Set per-instance by match size when freed (3-5 = Bronze, 6-9 = Silver, 10+ = Gold).
- Resets every run — tier is a within-run state, not a permanent stat.
- Merging two same-tier same-class heroes promotes (Bronze+Bronze=Silver, etc., capping at Gold).

### 3.2 — Rarity (Common → Rare → Epic → Legendary)

- Set by gacha. A hero is one rarity forever — you can't upgrade rarity without a new pull.
- Higher rarity = higher base HP and damage (see `roster.md` §2).

### 3.3 — Rank (permanent stat boost via duplicates)

- Duplicates of a hero you own convert to **Hero Shards** of that class + rarity.
- Spend shards to **rank up** the hero. Rank 4 is the cap (3 rank-up steps from Rank 1).

| Rank | Shard cost | Stat bonus |
|---|---|---|
| Rank 1 | 0 (default on first pull) | 1.0× |
| Rank 2 | 5 shards | +5% HP, +5% DMG |
| Rank 3 | 15 shards | +10% HP, +10% DMG |
| Rank 4 (max) | 50 shards | +15% HP, +15% DMG, unlocks a 4th targeting-zone cell |

Rank is **per-hero copy** (e.g. your Epic Fire Knight ranks separately from your Common Fire Knight).

---

## 4 — Account-level progression

### 4.1 — Player level

- Player levels up by earning XP from any source (pops, kills, run clears).
- Each level grants: +1 base HP for the base (the player's HP pool), +1 gacha free-pull token at certain milestones, +1 loadout slot at milestones.

| Player level | Unlock |
|---|---|
| 1 | Default — 3 loadout slots, 100 base HP |
| 5 | +1 daily free pull |
| 10 | 4th loadout slot, 120 base HP |
| 20 | 5th loadout slot, 140 base HP |
| 30 | Permanent +10% move budget option toggle (8 moves wave 1, 5 moves wave 2-5 — alternate mode for skill expression) |
| 50 | Prestige cosmetic frame |

### 4.2 — World progression

- World cleared = unlock next world.
- Stages within world unlock sequentially.
- "World power score" = sum of all hero ranks. Used as a soft gate for stage difficulty recommendation.

---

## 5 — Daily and weekly loops

### 5.1 — Daily

| Slot | Reward |
|---|---|
| Daily login | Day 1: 10 gems. Day 2: 100 coins. Day 3: 1 hero shard. Day 4-7: increasing rewards. Day 30 cycle. |
| Daily free pull | 1 free single pull |
| 3 wins | 50 coins + 5 gems |
| Pop 50 bubbles | 30 coins |
| Free 10 heroes | 2 hero shards (random class) |
| Reach wave 5 (any stage) | 10 gems |

### 5.2 — Weekly

| Slot | Reward |
|---|---|
| Clear 20 stages | 200 gems + 1 guaranteed Rare+ pull |
| Defeat world boss 3 times | 500 coins + 10 shards |
| Earn 1000 coins from runs | 50 gems |
| Free 50 heroes | 20 hero shards |
| Reach a new stage milestone | Variable (stage-based bonus) |

### 5.3 — Daily limited content

- **Trial Stage:** rotates daily. Special restrictions (e.g. "no Fire Knight loadout") with bonus rewards.
- **Boss Rush:** 3 mini-boss waves back-to-back, no normal waves. Quick session (~2 min). Cosmetic + gem rewards.

---

## 6 — Battle pass (lightweight)

### 6.1 — Structure

- 30-day season.
- Free track: 50 tiers of rewards (coins, gems, shards, 1 Epic hero at tier 50).
- Premium track (paid, $9.99): 50 tiers with better rewards + 1 season-exclusive Legendary at tier 50 + cosmetic frames.

### 6.2 — XP source

- Same XP pool as player level — battle pass tiers fill in parallel.
- Daily/weekly quest completion gives bonus battle pass XP.

### 6.3 — Skip purchase

- Players can buy tiers directly with gems if they fall behind. 200 gems per tier.

---

## 7 — Live ops events (placeholder)

Mechanic types Pop Brigade supports for events:

| Event type | Description |
|---|---|
| **Limited boss raid** | Special boss appears for 7 days. Players grind shards to unlock event-exclusive hero. |
| **Color affinity weekend** | All heroes of one color get +25% damage. Promotes specific gacha banners. |
| **Move constrained mode** | All runs use [8, 4, 4, 4, 4] moves. Skill expression. Cosmetic-only rewards. |
| **Frenzy fever** | Frenzy buff lasts entire RUN (not just wave) when triggered. |
| **Endless tower** | New mode unlocked during event. Continuous waves until base HP 0. Leaderboard rewards. |
| **Collab hero** | Cross-IP hero pull banner. Limited time. |

Event cadence target: 2-3 active events per month.

---

## 8 — Currencies (summary — full spec in `economy.md`)

| Currency | Use | Earn from |
|---|---|---|
| **Coins** (soft) | Cosmetic unlocks (hero ranks consume **shards**, not coins) | Run clears, daily missions, boss kills |
| **Gems** (hard, IAP-able) | Gacha pulls, energy refills, battle pass skips | First-clear bonuses, leveling, IAP |
| **Hero Shards** | Rank up heroes (per-class, per-rarity) | Duplicates from gacha, daily/weekly quests |
| **Event Currency** | Event banner pulls, event shop | Event-specific objectives only |
| **Boss Tokens** | Cosmetic prestige items | Boss kills only |

---

## 9 — Energy system (gate on play frequency)

### 9.1 — Energy

- Players have an **energy pool** capping at 100.
- Each run costs 10 energy.
- Energy regenerates 1 / 5 minutes (full refill in 8.3 hours).
- Energy refills purchasable with gems (50 gems = full refill).

### 9.2 — Energy-free runs

- First 3 runs of the day = energy-free.
- Boss Rush + Trial Stage runs = energy-free.
- Replays of cleared stages cost normal energy.

### 9.3 — Why energy?

- Prevents grind-burnout in early game.
- Gives whales a sink for gems.
- Creates daily come-back hook (energy refilled overnight).

(Energy is a contentious system in hybrid casual. Consider removing if early playtests show it kills retention rather than helping.)

---

## 10 — Onboarding hooks (full spec in `onboarding.md`)

First-session goals:
1. Clear stage 1 in ~90s.
2. Free first hero (guaranteed in stage 1 wave 1).
3. Trigger first merge (guided).
4. First gacha pull (free at end of session 1).
5. Open first chest (run-clear chest from stage 1).

Sessions 2-5 are designed to introduce one new system per session:
- Session 2: drag-to-merge with multiple heroes
- Session 3: occlusion mechanic (heroes can't fire through closed columns)
- Session 4: color counter (deal 2× to same-color enemies)
- Session 5: mini-boss + first Epic gacha pull pity

---

## 11 — Failure recovery (anti-churn)

Players who fail a stage 3+ times in a row get offered:
- Free temporary "Lucky Pulls" banner (1 free pull).
- Free 1-time stat boost on a hero of their choice (small).
- Optional "Story Skip" — skip the failed stage with 50% rewards. Toggles on after 5 fails.

Prevents hard-block churn at difficulty spikes.

---

## 12 — Telemetry events (progression-specific)

- `stage_attempt` — stage, result, waves cleared, time elapsed, heroes used.
- `stage_clear_first_time` — flag major milestones.
- `gacha_pull` — banner, result (rarity, class), pity counter state.
- `hero_rank_up` — class, rarity, new rank, shard cost.
- `chest_opened` — tier, contents.
- `daily_quest_complete` — quest type, reward.
- `battle_pass_tier_up` — tier, free/premium.
- `energy_spent` — amount, run linked.
- `energy_refill_purchased` — gems spent.
- `event_participation` — event id, objective progress.
