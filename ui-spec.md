---
name: Pop Brigade v2 — UI Spec
status: draft
created: 2026-05-22
design_spec: ./design-spec.md
combat_doc: ./combat-design.md
art_direction: ./art-direction.md
v1_predecessor: ../ui-flow.md
---

# Pop Brigade v2 — UI Spec

> **Scope:** every screen needed from boot → first run → meta loop. v2 invalidates large parts of v1's `ui-flow.md` (phased combat is gone, 5 classes instead of 3, full hybrid-casual meta loop). This doc supersedes v1 ui-flow for v2.
>
> **Conventions:** grayscale wireframes. Visual treatment lives in `art-direction.md`. Where v1's wireframes still apply (boot, pause), this doc points back.
>
> **Canvas:** portrait 720×1560. Top safe-zone 0–6%. Bottom gesture-bar safe-zone 96–100%.

---

## 1 — Screen inventory

| # | Screen | Purpose | Time budget | Priority |
|---|---|---|---|---|
| 1 | **Boot** | Logo + loading | 2 s passive | P0 |
| 2 | **Meta hub** | Home base — energy, currencies, all sub-screens | 5–15 s | P0 |
| 3 | **World map** | World 1 path with 30 stages → boss at 30 | 5–10 s | P0 |
| 4 | **Stage confirm** | Pre-run modal: stage info, energy cost, rewards | 3–5 s | P0 |
| 5 | **Loadout** | Pick 3–5 heroes from owned roster for the run | 10–30 s | P0 |
| 6 | **Match** | Combat — gate + lane + heroes + HUD | 4–6 min per run (5 waves) | P0 |
| 7 | **Intermission** | 5-s pause between waves | ≤5 s | P0 |
| 8 | **Pause** | Resume / Settings / Quit overlay | 2–5 s | P0 |
| 9 | **Run clear** | Boss-cleared results + rewards | 15 s | P0 |
| 10 | **Run fail** | Out-of-HP screen + optional revive offer | 10 s | P0 |
| 11 | **Gacha** | Hero summon + reward animation | 5–10 s per pull | P0 |
| 12 | **Roster** | Hero collection grid (owned + unowned) | browse | P0 |
| 13 | **Hero detail** | Per-hero stats, ult, rank-up via shards | 15–30 s | P0 |
| 14 | **Battle pass** | Track + tier rewards | browse | P1 |
| 15 | **Daily quests** | 3 daily + 5 weekly objectives | 10 s | P1 |
| 16 | **Events** | Limited-time event list | browse | P1 |
| 17 | **Shop** | IAP packs + soft-currency exchange | browse | P1 |
| 18 | **Mail / Inbox** | Gifts, event rewards, support replies | 5–10 s | P2 |
| 19 | **Settings** | Audio, language, account, support | rare | P2 |

**P0 = required for first internal playtest.** P1 = required for soft launch. P2 = polish.

---

## 2 — Wireflow

```
                          ┌────────────┐
                          │  1. BOOT   │
                          └─────┬──────┘
                                │ auto 2s
                                ▼
                  ┌─────────────────────────────────┐
        ┌────────►│        2. META HUB              │◄────────┐
        │         │  energy / currencies / tabs     │         │
        │         └─┬───┬───┬───┬───┬───┬───┬──────┘         │
        │           │   │   │   │   │   │   │                 │
        │      [PLAY]│ros│gac│bp │dq │evt│shp │mail            │
        │           ▼   ▼   ▼   ▼   ▼   ▼   ▼                 │
        │      ┌────┐ ┌──┐ ┌──┐ ┌──┐ ┌──┐ ┌──┐ ┌──┐          │
        │      │ 3. │ │12│ │11│ │14│ │15│ │16│ │17│          │
        │      │WORL│ │ROS│ │GAC│ │BP│ │DQ│ │EV│ │SH│          │
        │      │ MAP│ └┬─┘ └──┘ └──┘ └──┘ └──┘ └──┘          │
        │      └─┬──┘  │                                       │
        │     tap stage│                                       │
        │        ▼     ▼                                       │
        │   ┌────────┐ ┌────────┐                              │
        │   │ 4. STG │ │ 13. HERO│                             │
        │   │ CONFIRM│ │ DETAIL │                              │
        │   └───┬────┘ └────────┘                              │
        │       │ tap PLAY                                     │
        │       ▼                                              │
        │   ┌────────┐                                         │
        │   │ 5. LOAD│                                         │
        │   │ OUT    │                                         │
        │   └───┬────┘                                         │
        │       │ tap START                                    │
        │       ▼                                              │
        │   ┌─────────────────────────────────────┐            │
        │   │ 6. MATCH ── wave 1..5 ── boss W5    │            │
        │   │   ▲   │     ▲    │      pause       │            │
        │   │   │   │     │    │       │          │            │
        │   │   │intermsn│ HP=0│       ▼          │            │
        │   │   └───7────┘    │   ┌───8───┐       │            │
        │   │       (tap/auto)│   │ PAUSE │       │            │
        │   │                 │   └─┬─┬───┘       │            │
        │   │  boss defeated  │     │ │           │            │
        │   │       │         │  resume│          │            │
        │   │       ▼         ▼     │  │          │            │
        │   │   ┌─────┐   ┌─────┐   │  │ quit     │            │
        │   │   │ 9.  │   │ 10. │◄──┘  ▼          │            │
        │   │   │CLEAR│   │ FAIL│   to META       │            │
        │   │   └──┬──┘   └──┬──┘                 │            │
        │   └──────┼─────────┼─────────────────────┘            │
        │          │         │                                  │
        └──────────┴─────────┴──────────────────────────────────┘
```

**Trigger summary:**

| From → To | Trigger |
|---|---|
| Boot → Meta hub | 2 s auto |
| Meta hub → World map | Tap PLAY (big bottom button) |
| World map → Stage confirm | Tap a stage node |
| Stage confirm → Loadout | Tap PLAY |
| Loadout → Match | Tap START (after ≥3 heroes selected) |
| Match → Intermission | Wave clear (all enemies down + ≥3 s grace) |
| Intermission → Match | Tap CONTINUE OR auto-skip 10 s |
| Match → Pause | Tap pause button (top-right) |
| Pause → Match | Tap RESUME |
| Pause → Run fail | Tap QUIT RUN (consumes the energy) |
| Match → Run clear | Boss HP = 0 (wave 5 only) |
| Match → Run fail | Base HP = 0 OR moves exhausted with enemies remaining + heroes dead |
| Run clear → World map | Tap CONTINUE → next stage unlocked |
| Run fail → Meta hub OR Match | Tap CONTINUE OR REVIVE (gems, once per run) |
| Run end → Meta hub | Default after rewards |

---

## 3 — Per-screen wireframes

### 3.1 — Boot (screen 1)
Carryover from v1 (`ui-flow.md` §3.1). Logo + loading bar. No v2 changes.

### 3.2 — Meta hub (screen 2)

```
┌──────────────────────────────────┐
│  ⚙  ⚡ 7/10  💎 250  💰 4.2k  📬 │ ← Top bar: settings, energy, gems, gold, mail
│ ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ │
│                                  │
│         POP BRIGADE              │
│         Player Lv 7              │ ← Player level + XP bar below
│         ████████░░ 320/500       │
│                                  │
│   ╔══════════════════════════╗   │
│   ║   WORLD 1: SUNBLOOM      ║   │ ← Current world banner (tap → world map)
│   ║   Stage 12 / 30          ║   │
│   ║   [last hero portrait]   ║   │
│   ╚══════════════════════════╝   │
│                                  │
│   ┌──────────────────────────┐   │
│   │         ▶ PLAY            │   │ ← Big primary CTA (to world map)
│   └──────────────────────────┘   │
│                                  │
│  ┌─────┐ ┌─────┐ ┌─────┐ ┌────┐ │ ← Tab strip — secondary entries
│  │ROST │ │GACHA│ │ BP  │ │DQ  │ │
│  └─────┘ └─────┘ └─────┘ └────┘ │
│  ┌─────┐ ┌─────┐                 │
│  │EVENT│ │SHOP │                 │
│  └─────┘ └─────┘                 │
└──────────────────────────────────┘
```

**Notes:**
- Energy meter top-left ticks up every 5 min (per `progression.md`).
- Daily quest button shows red dot when claimable.
- Battle pass tab shows time-remaining in this season.
- Events tab shows red dot if a new event started.

### 3.3 — World map (screen 3)

```
┌──────────────────────────────────┐
│  ◄ WORLD 1: SUNBLOOM   ⚡7/10 💎 │
│ ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ │
│                                  │
│     ☁                            │
│              30 ★ ◄ BOSS         │ ← Stage 30 = boss, larger node
│         ↗                        │
│       29 ●                       │
│           ↘                      │
│             28 ●                 │
│       ↗                          │
│     27 ●                         │
│        ↘                         │
│          26 ●                    │
│              ↘                   │
│                25 ●              │
│       ┃ ◄ Player marker at 13    │
│  ●──●──●──●──○──○──○──○          │
│  9  10 11 12 13 14 15 16         │   completed = filled, current = ring,
│                                  │   locked = empty
│ ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ │
│   ┌──────────────┐               │
│   │  TAP A STAGE │               │
│   └──────────────┘               │
└──────────────────────────────────┘
```

**Notes:**
- Scrollable vertically (player marker auto-centers on load).
- Stages render as ● (cleared) / ○ (locked) / ◉ (current playable) / ★ (boss).
- Background art per world (Sunbloom = sunny meadow; later worlds re-skin).
- Pinch-to-zoom (post-MVP).

### 3.4 — Stage confirm (screen 4)

```
┌──────────────────────────────────┐
│  ✕                               │ ← Dismiss
│                                  │
│       STAGE 13                   │
│     "GARDEN GATE"                │ ← Stage name
│                                  │
│  Modifiers:                      │
│   • +1 RED enemy speed           │ ← (Post-MVP — empty for v1)
│   • 4 hero slots unlocked        │
│                                  │
│  ┌──────────────────────────┐   │
│  │   Energy cost:  ⚡ 1      │   │
│  │   Rewards:                │   │
│  │     ⭐ 80 XP              │   │
│  │     💰 +60 gold           │   │
│  │     💎 +1 gem (first clr) │   │
│  │     🃏 stage chest        │   │
│  └──────────────────────────┘   │
│                                  │
│   ┌──────────────────────────┐   │
│   │       ▶ PLAY              │   │
│   └──────────────────────────┘   │
└──────────────────────────────────┘
```

### 3.5 — Loadout (screen 5)

```
┌──────────────────────────────────┐
│  ◄ Stage 13                      │
│                                  │
│   Pick your heroes  3 / 4 slots  │ ← Slot count by progression
│                                  │
│  ┌────────────────────────────┐ │
│  │ SELECTED:                  │ │
│  │ ┌──┐ ┌──┐ ┌──┐ ┌──┐        │ │
│  │ │FK│ │IM│ │AR│ │__│        │ │ ← Filled + empty slots
│  │ └──┘ └──┘ └──┘ └──┘        │ │
│  └────────────────────────────┘ │
│                                  │
│  Your roster:                    │
│  ┌──┐ ┌──┐ ┌──┐ ┌──┐ ┌──┐      │
│  │FK│ │IM│ │AR│ │DR│ │WZ│      │ ← Owned heroes (tap to add)
│  │R5│ │E3│ │C2│ │R1│ │--│      │   tag: rarity + rank
│  └──┘ └──┘ └──┘ └──┘ └──┘      │   greyed if not owned
│  (scroll for more)               │
│                                  │
│  Active synergies (3+ / 5+):     │
│   ✓ Elements (3+): +10% dmg      │ ← Reads ahead of run start
│                                  │
│   ┌──────────────────────────┐   │
│   │       ▶ START             │   │
│   └──────────────────────────┘   │
└──────────────────────────────────┘
```

**Notes:**
- Min 1 hero to start; UI nudges to fill all slots.
- Synergy preview live-updates as the player adds/removes.
- Tap a roster card → opens Hero detail modal.

### 3.6 — Match (screen 6) — **most important**

V2 has no phases. Cannon and heroes both live every wave. The HUD is denser than v1.

```
┌──────────────────────────────────┐
│  ⏸  HP ████████░░  W 2/5  ⚡1 1× │ ← Top: pause, base HP, wave, energy used, speed toggle
│                                  │
│      ☁     ☁                     │ ← Sky / parallax
│                                  │
│    ┌──────────────────────────┐  │
│    │ ●  ●  ●  H  ●  ●  ●      │  │
│    │  ●  ●  ●  ●  ●  H  ●     │  │ ← GATE (bubble wall)
│    │ ●  ●  ●  ●  ●  ●  ●  ●   │  │   22–58% Y
│    │  ●  ●  ●  ●  ●  ●  ●     │  │
│    └──────────────────────────┘  │
│                                  │
│        e   e   e   e             │ ← Enemy lane (depth-rail, parallax)
│         e  e  e  e               │   55–68% Y
│                                  │
│    🛡    🏹    ❄    🌿    ✨    │ ← Hero row (68–77% Y)
│   FK    AR   IM    DR    WZ     │
│  [ult] [ult] [ult] [ult] [ult]   │ ← Ult gauge under each hero portrait
│   ▓▓▓░  ▓░░░  ▓▓▓▓  ░░░  ▓▓░    │   when full: glow + READY label
│                                  │
│ ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ │
│   MOVES: 4 / 6                   │ ← Move counter (prominent)
│      ╭───╮  ┌─────┐ ┌─────┐      │
│      │ 🔴│  │ 🔵  │ │ Q   │      │ ← Cannon + ammo preview
│      ╰───╯  └─────┘ └─────┘      │
└──────────────────────────────────┘
```

**HUD elements:**

| Element | Position | Behavior |
|---|---|---|
| Pause | Top-left | Tap → pause overlay |
| Base HP | Top-center-left | Decrements when enemy reaches cannon. Flash red on hit. Heartbeat loop < 25%. |
| Wave indicator | Top-center | "W 2/5" — boss icon for W5 |
| Energy used | Top-center-right | Display only — energy was spent at run start |
| Speed toggle | Top-right | 1× / 2× toggle (post-MVP, default 1×) |
| Gate | 22–58% | Static per wave. Bubbles, hero bubbles, corrupted bubbles. |
| Enemy lane | 55–68% | Pseudo-3D depth rail. Telegraph → spawn → walk → engage. |
| Hero row | 68–77% | 5 slots max (queue overflow FIFO). Always-live drag, swap, merge. |
| Ult gauge | Under each hero | Fills with damage dealt or time. Tap to fire ult. |
| Move counter | Above cannon | Decrements per shot. Flash red at ≤1. |
| Cannon + on-deck | Bottom center | Tap-fire. Q = queue slot, displays next-next. |

**Ult fire interaction:**

- Tap a hero portrait when their ult ring is full → ult fires immediately for FK / IM / Archer / Druid.
- Wizard requires two-tap: tap portrait → target reticle appears → tap enemy. (Per Q2 lock.)
- If ult not ready: portrait shakes "nope" + faint percentage tooltip ("63%").

**Closed-column affordance** (`combat-design.md` 1.2):
- Hero whose firing column is closed → 60% opacity + dashed faint "would-fire" line projecting up to the blocking bubble.

**Drag interaction (always live, no phase gate):**

```
Press-and-hold any hero on row 0:

   • Cannon dims + becomes tap-inert during drag.
   • Ghost outline on possible drop columns.
   • Same-class + same-tier matches glow (merge target).
   • Release on empty column → move.
   • Release on different class → swap.
   • Release on same class + tier → merge (B+B→S, S+S→G).
```

### 3.7 — Intermission (screen 7)

```
┌──────────────────────────────────┐
│         ★  WAVE 2 CLEAR  ★       │
│                                  │
│        +120 wave score           │
│                                  │
│   Heroes status:                 │
│    🛡 FK   ██████ HP 60%         │
│    🏹 AR   █████░ HP 50%         │
│    ❄ IM   ███░░░ HP 30% ◄ low!  │
│                                  │
│   Next wave preview:             │
│    Wave 3 — RED + YELLOW         │
│    moves: 6                      │
│    enemies: 6 (1 Brute)          │
│                                  │
│   ┌──────────────────────────┐   │
│   │   CONTINUE   (auto 10s)   │   │ ← Per Q12 lock
│   └──────────────────────────┘   │
└──────────────────────────────────┘
```

**Notes:**
- Auto-advance after 10 s if player doesn't tap (Q12 lock).
- Boss wave preview shows boss portrait silhouette + "BOSS: The Corrupter" label.

### 3.8 — Pause (screen 8)
Carryover from v1 `ui-flow.md` §3.7 with these v2 additions:
- "Settings" entry (was missing in v1).
- "Quit Run" confirms with a "you will lose this run's progress" modal.

### 3.9 — Run clear (screen 9)

```
┌──────────────────────────────────┐
│      ✨ ✨ ✨ ✨ ✨ ✨ ✨         │
│                                  │
│          STAGE 13 CLEAR          │
│           ⭐ ⭐ ⭐                │ ← Star rating (post-MVP)
│                                  │
│   Run summary:                   │
│     Damage dealt: 2,840          │
│     Bubbles popped: 47           │
│     MVP: Ice Mage (1,120 dmg)    │
│                                  │
│   Rewards:                       │
│     ⭐ +80 XP                    │
│     💰 +60 gold                  │
│     💎 +1 gem (first clear)      │
│     🃏 Stage chest               │
│       └─ tap to open             │ ← Triggers gacha-like reward animation
│                                  │
│     🎫 Battle Pass: +5 pts       │
│     ✓ Daily quest 2/3 complete   │
│                                  │
│   ┌──────────────────────────┐   │
│   │      ▶ CONTINUE           │   │
│   └──────────────────────────┘   │
└──────────────────────────────────┘
```

### 3.10 — Run fail (screen 10)

```
┌──────────────────────────────────┐
│            💀                    │
│         RUN FAILED               │
│                                  │
│       Wave 3 / 5                 │
│       Cause: base HP 0           │
│                                  │
│   ┌──────────────────────────┐   │
│   │   REVIVE for 💎 50        │   │ ← Optional, once per run
│   │   (restart from wave 3,   │   │
│   │    full HP, half heroes)  │   │
│   └──────────────────────────┘   │
│                                  │
│   Or keep what you earned:       │
│     ⭐ +20 XP (partial)          │
│     💰 +15 gold (partial)        │
│                                  │
│   ┌──────────────────────────┐   │
│   │      ✕ END RUN            │   │
│   └──────────────────────────┘   │
└──────────────────────────────────┘
```

**Notes:**
- Revive offer only on first fail of a run.
- Energy is consumed regardless (re-attempt costs another energy).

### 3.11 — Gacha (screen 11)

```
┌──────────────────────────────────┐
│  ◄ HERO SUMMON                   │
│                                  │
│   ╔═════════════════════════╗   │
│   ║                          ║   │
│   ║     🎁 STANDARD          ║   │
│   ║     1 pull: 🎟 1          ║   │ ← Currencies: tickets, gems
│   ║    10 pull: 🎟 9 (-1)     ║   │
│   ║                          ║   │
│   ║  Rates:                  ║   │
│   ║   Legendary: 1.5%        ║   │
│   ║   Epic: 8.5%             ║   │
│   ║   Rare: 30%              ║   │
│   ║   Common: 60%            ║   │
│   ║                          ║   │
│   ║   Pity: 90 pulls → Leg.  ║   │ ← Per progression.md
│   ║                          ║   │
│   ║   ┌──────┐  ┌──────────┐ ║   │
│   ║   │ 1 ×  │  │ 10 × 🎟9 │ ║   │
│   ║   └──────┘  └──────────┘ ║   │
│   ╚═════════════════════════╝   │
│                                  │
│   [event banner]   [Tab strip]   │
└──────────────────────────────────┘
```

**Pull animation (overlay):**
- Background dims.
- Capsule drops in (1 s).
- Glow color signals rarity before reveal: grey → green → blue → gold.
- Capsule cracks open, hero portrait flies out at full Legendary treatment if applicable.
- Tap to skip per Q13.

### 3.12 — Roster (screen 12)

```
┌──────────────────────────────────┐
│  ◄ HEROES                        │
│                                  │
│  All  |  Owned  |  Locked        │ ← Filter tabs
│                                  │
│  ┌──┐ ┌──┐ ┌──┐ ┌──┐ ┌──┐       │
│  │FK│ │IM│ │AR│ │DR│ │WZ│       │
│  │R5│ │E3│ │C2│ │R1│ │--│       │ ← Tag: rarity + rank (or -- if locked)
│  └──┘ └──┘ └──┘ └──┘ └──┘       │
│                                  │
│  (more rows as more heroes       │
│   added in future worlds)        │
│                                  │
│  Sorted by:  rarity ▼            │
└──────────────────────────────────┘
```

### 3.13 — Hero detail (screen 13)

```
┌──────────────────────────────────┐
│  ◄                               │
│                                  │
│       ┌──────────────┐           │
│       │ [hero art]   │           │ ← Full portrait, rarity treatment
│       │ Legendary    │           │   applied
│       └──────────────┘           │
│                                  │
│       EMBER — Fire Knight        │
│       Rank 5  Legendary          │
│                                  │
│  Stats:                          │
│   HP    240   ████████░░         │
│   DMG    18   ████░░░░░░         │
│   FIRE   0.75s ██████░░░░        │
│                                  │
│  Special: 25% cleave chance      │
│  Ultimate: Eruption — column     │
│            flame, 200 dmg AoE    │
│                                  │
│  Rank up to 6:                   │
│   needs 30 FK shards (have 12)   │
│   ████░░░░░░ 12/30               │
│                                  │
│   ┌────────────┐  ┌────────────┐ │
│   │ RANK UP    │  │  USE       │ │ ← Use → adds to loadout favorites
│   └────────────┘  └────────────┘ │
└──────────────────────────────────┘
```

### 3.14 — Battle pass (screen 14, P1)

```
┌──────────────────────────────────┐
│  ◄ BATTLE PASS — Sunbloom Season │
│  Time left: 18d 4h               │
│                                  │
│  Your tier: 7 / 50               │
│  Pts: 320 / 500 (next tier)      │
│  ███████░░░                       │
│                                  │
│  ┌──────────────────────────┐   │
│  │ FREE TRACK               │   │
│  │  T1 ✓  T2 ✓  T3 ✓  ...   │   │
│  ├──────────────────────────┤   │
│  │ PREMIUM TRACK 💎          │   │
│  │  T1 ✓  T2 _  T3 _  ...   │   │
│  └──────────────────────────┘   │
│                                  │
│  ┌──────────────────────────┐   │
│  │ BUY PREMIUM — 💎 950      │   │
│  └──────────────────────────┘   │
└──────────────────────────────────┘
```

### 3.15 — Daily quests (screen 15, P1)

```
┌──────────────────────────────────┐
│  ◄ DAILY QUESTS                  │
│  Resets in: 9h 12m               │
│                                  │
│  Daily:                          │
│   ✓ Clear 3 stages    🃏        │
│   ░ Pop 100 bubbles   💰 50      │
│   ░ Free 5 heroes     🎟 1       │
│                                  │
│  Weekly:                         │
│   ░ Clear 20 stages   💎 50      │
│   ░ Get 3 Epic pulls  🎟 5       │
│   ░ ... (3 more)                 │
│                                  │
└──────────────────────────────────┘
```

### 3.16 — Events (screen 16, P1)
Card list of active limited-time events. Card per event: banner art, time-remaining, "ENTER" CTA.

### 3.17 — Shop (screen 17, P1)
Vertical scroll of IAP packs: starter pack, gem packs, currency packs, hero-specific bundles. Featured row at top.

### 3.18 — Mail (screen 18, P2)
List of system messages + gifts. Tap a row → claim button.

### 3.19 — Settings (screen 19, P2)
Audio sliders (master / music / SFX), language picker, account ID, restore purchases, contact support, version + build number.

---

## 4 — Cross-screen behaviors

### 4.1 — Energy gate

Per `progression.md`, energy is enforced **on tap PLAY from Stage confirm**, not on returning to Meta hub. If energy = 0, the Stage confirm PLAY button disables and shows refill options (wait timer / gems / ad).

Per `open-questions.md`, energy ships with A/B test flag — if D7 retention drops > 5pp in "on" cohort, ship "off".

### 4.2 — Currency display

Top bar **always shows**: energy, gems, gold. The mail badge appears when unread. **Battle pass time-left** is not in the top bar — too much chrome — only in the BP screen.

### 4.3 — Modal vs full-screen

| Surface | Style |
|---|---|
| Stage confirm | Modal (dim background) |
| Pause | Modal |
| Intermission | Full-screen overlay (pauses combat) |
| Run clear / fail | Full-screen replaces match |
| Hero detail | Modal (over Roster or Loadout) |
| Gacha pull animation | Full-screen overlay |
| Tutorial overlays | Modal with cutout reveal (highlights tappable area) |

### 4.4 — Tutorial overlay style

Per `onboarding.md`, FTUE uses arrows + highlights, not text walls. Pattern:
- Dim background to 70%.
- Cut a circle around the target (gate cell, hero, button).
- Arrow + ≤80-char tutorial line below.
- "TAP TO CONTINUE" or auto-advance on the correct gesture.

### 4.5 — Back navigation rules

- Modal screens always dismissable with a top-left `✕` or back-tap on dim area.
- Full-screen sub-screens use `◄` top-left.
- During Match: pause-only. No way to back out without quit-confirmation.
- During Gacha pull animation: tap-to-skip, no back.

---

## 5 — Open questions (UI-specific)

| # | Question | Status |
|---|---|---|
| U1 | Star rating per stage (3-star system based on moves remaining + heroes alive)? | Defer — adds replay loop, but post-MVP. |
| U2 | Stage modifiers (e.g. "RED enemies +1 speed") visible pre-run or revealed at wave 1? | Pre-run (Stage confirm). Telegraph beats surprise in hybrid casual. |
| U3 | World map pinch-zoom? | Post-MVP. MVP = vertical scroll only. |
| U4 | Speed toggle (1× / 2×) for combat? | Lock as P1 (post-MVP). Drains tension if shipped at launch. |
| U5 | Auto-pickup for chest rewards (no animation) when "always skip" toggle is on? | Yes — but show "+1 chest" toast as confirmation. |
| U6 | Hero-died notification during combat? | Brief screen-edge red pulse + skull above empty cell. No modal. |
| U7 | Synergy activation toast mid-run? | Brief 1-s screen-bottom banner: "ELEMENTS x3 — +10% damage". |

---

## 6 — Priority order for UI mockups (artist brief order)

1. **Match screen v2** — densest screen, most-felt. Full-fidelity mockup.
2. **World map** — sets meta-loop feel + theming for World 1 (Sunbloom).
3. **Stage confirm** — small but high-frequency.
4. **Loadout** — gating screen between meta and combat.
5. **Run clear** — monetization-adjacent (chest open). Most rewarding moment.
6. **Gacha** — second-most rewarding moment.
7. **Intermission** — high frequency, low complexity.
8. **Meta hub** — anchor screen, but mostly composition of other elements.
9. **Hero detail, Roster** — collection moments.
10. **Battle pass, Daily quests, Events, Shop, Mail, Settings** — soft-launch tier.

---

## Change log

- 2026-05-22 — initial v2 spec, supersedes v1 `ui-flow.md` for v2 surfaces.
