# Pop Brigade — v2

Full v2 redesign: wave-based runs with the new spatial layout (bubbles + enemies simultaneous, on different axes), expanded class roster, gate corruption boss, hero ultimates, status effects, class synergies, and a full hybrid casual meta loop.

> v1 docs are untouched at `pop-brigade/*.md`. v2 lives in this folder. The Godot prototype in `godot/` implements the v2 core loop (combat, gate, heroes, boss, stage select).

---

## Core changes from v1 → v2

| System | v1 | v2 |
|---|---|---|
| Layout | Flat 2D portrait. Cluster top, lane below. | Pseudo-3D. Bubbles stack on a gate wall at mid-depth. Enemies approach on a depth rail behind it. |
| Phasing | Phase 1 (build) → Phase 2 (combat). | **No phases.** Bubbles and enemies live simultaneously every wave. |
| Move budget | Per-stage budgets [10, 11, 13, 14, 16]. | Per-wave, tighter: **[10, 6, 6, 6, 6]**. |
| Bubble supply | Fixed cluster per stage. | Fresh gate seeded each wave, no mid-wave refills. |
| Hero firing | Auto-fires at lane enemies in Phase 2. | Auto-fires through gate columns. **Closed column = hero silenced** (occlusion mechanic). |
| Hero drag | Phase 2 only. | Always live. |
| Boss (wave 5) | Cluster shake. | **Gate Corruption** — bubbles in targeted column turn grey (column behaves as closed). See `boss-design.md`. |
| Hero classes | 3 enabled, 2 v1.5. | **5 enabled.** Fire Knight, Ice Mage, Archer, **Druid**, **Wizard**. |
| Hero rarity | Tier only (Bronze/Silver/Gold via merge). | **Tier + Rarity + Rank.** Common/Rare/Epic/Legendary from gacha. Shard-based rank-ups. |
| Hero ultimates | None. | **Yes** — manually triggered, one per class. |
| Status effects | Slow only. | **5 effects:** Slow, Freeze, Burn, Poison, Stun. |
| Class synergies | None. | **3+ and 5+ class buffs** on row 0. |
| Meta progression | None. | **Full hybrid casual meta:** worlds, stages, gacha, shards, battle pass, daily quests, events. |

---

## Doc map

| File | What it covers |
|---|---|
| `concept.md` | Elevator pitch + the gate metaphor + screen layout sketch. Start here. |
| `design-spec.md` | Core mechanical spec: playfield, gate, enemy lane, wave structure, occlusion, scoring, config. |
| `combat-design.md` | Hero targeting, enemy types, color counter, frenzy, hero ultimates, status effects, class synergies. |
| `roster.md` | Full 5-class roster, rarity tiers, gacha pool, legendary uniques, ultimate abilities. |
| `boss-design.md` | Boss framework + The Corrupter (World 1) full spec + future boss slots. |
| `progression.md` | Meta loop: worlds, stages, hero progression axes, player level, daily/weekly, battle pass, events. |
| `economy.md` | Currencies, sources, sinks, IAP catalog, gem velocity targets. |
| `onboarding.md` | First 5 sessions, FTUE walkthrough, tutorial events, drop-off flags. |
| `ui-spec.md` | Per-screen UI spec — Meta Hub, Match HUD, run-end, gacha, roster, pause, etc. |
| `art-direction.md` | Visual style bible: palette, silhouette rules, hero/enemy/bubble/VFX direction. |
| `art-pass-plan.md` | Planned art deliverables (hero portraits, enemy variants, VFX, backdrops). |
| `audio-brief.md` | SFX + music brief — per-event sound design, mix targets, partner handoff. |
| `polish-sweep-audit.md` | Standing list of art/UX polish items and acceptance status per sweep. |
| `open-questions.md` | Decisions still to make. |

## Reading order

**For design context:** `concept.md` → `design-spec.md` → `combat-design.md` → `roster.md` → `boss-design.md` → `progression.md` → `economy.md` → `onboarding.md`.

**For prototype priority:** `design-spec.md` (core loop) → `combat-design.md` (hero behavior) → `boss-design.md` (wave 5 only after the rest works).

**For balance / tuning:** all config exports are gathered at the bottom of each respective doc.

---

## Locked design decisions (as of this revision)

- Wave-based structure with move budget per wave: **[10, 6, 6, 6, 6]**.
- 5 waves per run, boss-gated at wave 5.
- Static gate per wave (no sky drops mid-wave).
- Hero firing reaches across the gate freely (occlusion was prototyped and dropped — see `combat-design.md` §1.2).
- Drag always live (no phase gate).
- 5 hero classes enabled (FK, IM, Archer, Druid, Wizard).
- 4 rarity tiers (Common, Rare, Epic, Legendary) with shard-based rank-ups.
- Hero ultimates manually triggered.
- Class synergies at 3+ and 5+ on row 0.
- World 1 boss = The Corrupter (gate corruption + light minion spawns, 1 RED Walker every 15s).
- Color frenzy trigger = clear-all-of-color (v1 trigger, per-wave).
- Meta progression: world map (30 stages per world), gacha, battle pass, daily quests.
- Cross-run carry-over: hero **collection** unlocks persist; per-run hero stats reset.
- Energy gate on stage entries enabled at launch, with A/B test flag to remove if D7 retention drops > 5pp.

---

## Status

v2 core loop is **implemented in `godot/`** — pseudo-3D layout, gate state, 5 hero classes, status effects, World 1 boss (The Corrupter), Sand-Zone style stage-select hub.

Still ahead:
- Hero ultimates (gauge + per-class effect).
- Meta loop scaffolding (gacha, shards, battle pass, daily quests).
- Tutorial / FTUE overlays.
- Pause overlay + settings.
- Loadout / Roster / Hero-detail screens.
