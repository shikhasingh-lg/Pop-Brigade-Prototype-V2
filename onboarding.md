# Pop Brigade v2 — Onboarding (FTUE)

First 5 sessions. Each one introduces exactly one new system. Goal: new player understands the core loop by end of session 1, unlocks meta progression by end of session 5.

> **Anti-pattern to avoid:** overwhelming the player with all mechanics at once. v1's phased loop already needed 2-3 minutes of tutorial — v2's simultaneity makes this even more critical.

---

## 1 — First-session goal (Session 1, ~5 min)

A new player should complete:
1. Stage 1 cleared (a 5-wave run).
2. At least one hero freed and dragged.
3. At least one match popped that they understood the consequence of.
4. One gacha pull (free).
5. One chest opened.

Success metric: D1 retention proxy — % of players who complete session 1 in < 7 min.

---

## 2 — Stage 1 walkthrough (guided)

Stage 1 is **heavily scripted** to introduce concepts one at a time.

### 2.1 — Wave 1 (intro to popping)

- Pre-seeded gate: 24 bubbles, only RED + BLUE. 1 hero bubble (Fire Knight, Common, Bronze).
- 0 enemies on lane.
- Move budget: 10.
- Tutorial overlay: "Tap to aim. Release to fire. Pop 3 same-color bubbles."
- Player must pop at least one match to advance.
- Hero bubble pop is set up (the FK hero bubble is positioned to be part of a guaranteed-easy red match).
- On hero freed: "You freed a hero! She'll defend you in the next wave."
- Wave clears when all bubbles popped OR moves exhausted (no enemies to defeat).

### 2.2 — Wave 2 (intro to enemies + occlusion)

- Pre-seeded gate: 30 bubbles, RED + BLUE + YELLOW. 1 hero bubble.
- 3 enemies (RED Walkers) spawn at intervals, slowly walking toward gate.
- Move budget: 6.
- Tutorial: "Enemies are coming. Pop bubbles in their column to let your hero shoot through!"
- Visual: arrows indicate which columns have enemies approaching.
- Player must open at least one column AND have a hero firing through it. Game waits for this before continuing.
- On first hero shot: "Your hero is firing! Keep the column open."
- On first enemy reaching gate: "If the column is closed, the enemy will bash through. Open it first!"

### 2.3 — Wave 3 (intro to dragging + merging)

- Pre-seeded gate: 30 bubbles. 2 hero bubbles (both Fire Knight Bronze, positioned in different columns).
- 4 enemies spawn (mixed).
- Move budget: 6.
- After both hero bubbles freed, tutorial: "Long-press and drag heroes to move or merge them. Two Bronze Fire Knights = one Silver!"
- Game pauses cannon during tutorial drag prompt.
- Player must perform the merge to advance.
- Demonstrates immediate power spike from Silver hero.

### 2.4 — Wave 4 (intro to color counter)

- Spawns 2 RED + 2 BLUE enemies.
- Tutorial: "Red heroes deal double damage to red enemies. Free a blue hero to handle blue enemies."
- Pre-seeded BLUE hero bubble is well-positioned for an easy match.
- Player ideally ends wave with one FK + one Ice Mage on row 0.

### 2.5 — Wave 5 (mini-boss + intro to ultimate)

- Stage 1 wave 5 is a fat YELLOW Brute (mini-boss). HP 250.
- 2 supporting Walkers.
- Hero ultimates introduced: "Your hero is charged! Tap her portrait to unleash her ultimate."
- Player must trigger at least one ultimate (game ensures one is charged by mid-wave).
- Brute kill triggers run-clear chest celebration.

---

## 3 — Post-stage-1 flow

- Chest opens with: 50 coins + 5 hero shards + free pull token.
- Tutorial: "You can pull more heroes here. Tap the banner."
- Player makes 1 free pull. Rate-gated to Rare+ (so the pull feels rewarding).
- New hero shows in collection.
- Tutorial: "Add new heroes to your loadout before your next run."
- Player adjusts loadout (tutorial-prompted).
- Player taps to enter stage 2.

---

## 4 — Stages 2-5 (introduce one mechanic per session)

| Stage | New mechanic introduced | Tutorial moment |
|---|---|---|
| 2 | **Runner enemies** | "Runners move fast! Take them out early or they'll breach." |
| 3 | **Cracked vs Open columns** | "Even 1 bubble in a column counts as cracked — enemies slow down. Useful!" |
| 4 | **Frenzy** | "Clear all of one color to power up that team!" |
| 5 | **Brute enemies + queue mechanic** | "Brutes tank a lot of damage. Group up heroes to focus them. Queued heroes wait until row 0 has space." |

After stage 5 cleared, the player has been exposed to all v2 core mechanics. Stage 6+ assumes mastery and ramps difficulty proportionally.

---

## 5 — First-week progression milestones

| Day | Target milestone |
|---|---|
| Day 1 (session 1) | Stage 1 clear, 1 free pull, loadout configured |
| Day 1 (session 2) | Stage 3 clear, first Rare hero, first merge |
| Day 2 | Stage 5 clear, mini-boss defeated, first chest tier upgrade |
| Day 3 | Stage 10 first-clear bonus, first Epic pull (pity-assisted), battle pass introduced |
| Day 5 | Stage 15, player level 10 |
| Day 7 | Stage 20, first weekly quest cleared, ~1500 gems earned |
| Day 14 | World 1 boss (Corrupter) attempt |
| Day 21 | World 1 cleared, World 2 unlocked |

These are targets, not requirements. Soft launch metrics will calibrate.

---

## 6 — Tutorial UX principles

- **Modal overlay only when necessary.** Most teaching is contextual (arrows, highlights, sound cues).
- **Demonstrate before explain.** Show the consequence of an action (enemy reaching base) before the player needs to act.
- **One concept per wave.** Never introduce two new things in the same wave.
- **Always-skippable from session 2 onward.** Returning players or replays auto-skip tutorial overlays.
- **No fail states in stages 1-2.** If the player runs out of moves on stage 1, give them more. The first 2 stages cannot be "lost." Stage 3 introduces real fail risk.

---

## 7 — Onboarding flags (analytics)

Each step emits an event so we can identify drop-off:

| Step | Event |
|---|---|
| App opened first time | `onboarding_start` |
| Stage 1 wave 1 first pop | `onboarding_first_pop` |
| Stage 1 wave 1 first hero freed | `onboarding_first_hero` |
| Stage 1 wave 2 first hero shot | `onboarding_first_hero_fire` |
| Stage 1 wave 3 first merge | `onboarding_first_merge` |
| Stage 1 wave 5 first ultimate | `onboarding_first_ult` |
| Stage 1 clear | `onboarding_stage_1_clear` |
| First free gacha pull | `onboarding_first_pull` |
| Loadout configured for stage 2 | `onboarding_loadout_set` |
| Stage 5 clear | `onboarding_complete` |

Drop-off cliffs (where to investigate first):
- Stage 1 wave 2 → wave 3 (transition from "pure popping" to "merge mechanic")
- Stage 1 → Stage 2 (post-tutorial transition)
- Stage 3 → Stage 4 (real-fail-risk introduction)

---

## 8 — Return player handling

Returning players (Day 2+):
- Skip all tutorial overlays.
- "Welcome back" reward animation (small).
- Show progress since last session (new daily quests, energy regen status).
- Resume on last-attempted stage.

Returning after 7+ days:
- "Comeback" event triggers — free hero, bonus quest, gem reward.
- Quick refresher tooltip on hero ultimates and merge (optional, dismissable).

---

## 9 — Localization considerations

(Out of scope for v2 design phase, but flagged for systems team.)

- All tutorial text should be < 80 chars per line for non-English layouts.
- Visual tutorials (arrows, highlights) preferred over text where possible.
- Voice-acted tutorials only in primary launch language (English) for v1 release.
