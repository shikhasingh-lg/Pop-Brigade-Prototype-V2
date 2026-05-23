# Pop Brigade v2 — Art Direction

Consolidated visual direction for v2. Pulls from `concept.md`, `design-spec.md`, `combat-design.md`, `boss-design.md`, `roster.md`, `onboarding.md`, `open-questions.md` Q11, and `assets/heroes/HEROES.md`. When this doc disagrees with a design doc, **the design doc wins for behavior, this doc wins for look**.

---

## 1 — Style pillars

| Pillar | What it means |
|---|---|
| **Chibi, flat, cel-shaded** | 2–3 head bodies, no skeletal anatomy. Flat fills + 1 shadow tone + bold outline (2–4 px @ 512). No gradients, no PBR, no rim lights. |
| **Readable in 0.5 s on a phone** | Every entity (hero, enemy variant, bubble color, status, gate state) must be ID-able as a 64-px thumbnail. Silhouette before detail. |
| **Punchy, "candy" surface** | Bubbles + UI lean glossy/candy (one specular highlight pip). Heroes lean matte+outline. Enemies lean matte+shadow. The contrast is intentional — the gate looks like *toys*, the threat looks like *grime*. |
| **Mood: bright siege** | Sunny, saturated, optimistic palette. The siege fantasy is in motion + sound, not in dark/grim color. |

We are explicitly **not**: photoreal, painterly, pixel art, Royal-Match plasticky, Slime-Legion neon-glow, or Squad-Busters 3D-ish. The closest references are **Wittle Defender** (flat punchy chibi) and **Bubble Witch 3 Saga** (clean cel + saturated palette).

---

## 2 — Color system

### 2.1 — The five class colors (locked)

These five hues are the spine of the entire game. Bubbles, hero portraits, hero VFX, status icons, enemy variants all key off the same five values.

| Class | Hex | Use everywhere for |
|---|---|---|
| RED — Fire Knight | `#E84A3A` | Bubble, hero accent, "burn" status, RED enemies, color-counter glow |
| BLUE — Ice Mage | `#3FA4E6` | Bubble, hero accent, "freeze" status, BLUE enemies |
| YELLOW — Archer | `#F2C337` | Bubble, hero accent, "stun" status, YELLOW enemies |
| GREEN — Druid | `#5DC36F` | Bubble, hero accent, "poison" status, GREEN enemies, healing VFX |
| PURPLE — Wizard | `#9355C9` | Bubble, hero accent, boss corruption, PURPLE enemies (bosses only) |

Each hue has a fixed light/dark variant (`-20%` / `+20%` luminance) for shading + UI hover/pressed.

### 2.2 — Neutral palette

| Role | Hex |
|---|---|
| Outline | `#1A1626` (near-black purple, not pure black) |
| UI background dark | `#2A1F3D` |
| UI background mid | `#3E2F58` |
| UI background light | `#F4EDFA` |
| Gate base / structure | `#5B4A7A` |
| Sky gradient top | `#6FB5F2` |
| Sky gradient bottom | `#B8E2F7` |
| Corrupted / grey | `#4A4A52` with `#9355C9` aura |
| Damage red (numbers) | `#FF3A2A` |
| Heal green (numbers) | `#5DEB8C` |

### 2.3 — Status effect color codes

Match the class color of the hero that applies it: slow=BLUE, freeze=BLUE-deep, burn=RED, poison=GREEN, stun=YELLOW. This makes "who is doing what to that enemy" readable without text.

---

## 3 — Typography

- **Display / headers:** rounded sans (e.g. Fredoka, Baloo, Nunito 800). Wide tracking. Used for stage titles, wave callouts, reward banners.
- **UI body:** same family, weight 600. Min 24 px @ 720-wide canvas (~3.3% of width). Never below.
- **Damage numbers:** display font, 2-px outline, with a 50 ms "pop-and-shrink" easing on spawn. Crit = +30% scale + yellow tint. Execute = +50% scale + red tint.
- **Tutorial text:** body font, < 80 chars per line (matches `onboarding.md`).
- One family across the whole game. No serifs. No script.

---

## 4 — Layout & screen zones (locked from design-spec §6)

Portrait, **720 × 1560**. Pseudo-3D: enemy lane is depth-projected, gate is a flat plane, cannon is 2D HUD.

| Y-range | Zone | What lives there | Notes |
|---|---|---|---|
| 0–22% | Sky | Parallax clouds, world-themed skybox, sun/moon | Bubbles drop *from* here visually (even though gate is static per-wave) |
| 22–58% | **Gate** | Bubble wall (the wall), hero bubbles, corrupted bubbles | The hero — this is the most visually busy zone, design accordingly |
| 55–68% | **Mid lane** | Far + near enemy sprites on depth rail, telegraphs | 3% overlap with gate zone for parallax read |
| 68–77% | **Hero row** | 5–6 hero slots, drag targets, ultimate buttons | This is the player's avatar — heroes get the most polish budget |
| 77–100% | Cannon + HUD | Cannon, ammo preview, move counter, energy bar, hero ult portraits | Persistent bottom strip; tap-safe area starts 88% down |

**Parallax:** sky moves 0.3× camera, far enemies 0.7×, gate 1.0×, mid enemies 1.0×, heroes 1.0×, cannon HUD 1.0×.

**Safe zones:** top 6% reserved for notch / island. Bottom 4% for gesture bar.

---

## 5 — Hero visual spec

### 5.1 — Base look (already done)

- 512² portrait, bust + upper torso, **3/4 view facing right**.
- White-bg version (cards), transparent cutout (lane), high-res src (re-processing).
- Chibi proportions: head ≈ 1/2 body height.
- Bold outline, flat cel shading, one accent rim of class color.

### 5.2 — Rarity (Common → Legendary)

Same silhouette across rarities — rarity is *not* a redraw, it's a treatment. **(This locks Q11 from `open-questions.md`.)**

| Rarity | Treatment |
|---|---|
| Common | Plain portrait. No FX. Card border grey. |
| Rare | Soft class-color outer glow (4-px). Card border green. One accessory (cape / sash / hairpin) in class color. |
| Epic | Pulsing outer glow (8-px). Card border blue. Two accessories + small particles drifting from shoulders (3–5 pcs, class color). |
| Legendary | Strong aura (12-px, animated noise mask). Card border gold. Crown / weapon flourish + 8–12 continuous particles + subtle bloom on the highlight pip. |

Rarity treatment is **additive shader work**, not new art. One source portrait → four rarity outputs via a Godot shader.

### 5.3 — Tier (Bronze / Silver / Gold from merge)

Independent of rarity. Tier scales armor color + size.

| Tier | Treatment |
|---|---|
| Bronze | Base armor color (warm brown). Scale 1.0×. |
| Silver | Armor recolored cool grey. Scale 1.1×. Faint sparkle on metal highlights. |
| Gold | Armor recolored gold. Scale 1.2×. Continuous shimmer on metal highlights. |

A Legendary-Gold is the loudest entity on screen: gold armor + crown + 12 particles + 1.2× scale + 12-px aura. That's the intended ceiling — don't add more.

### 5.4 — Class silhouette cheat-sheet (locked)

| Class | Silhouette tell | Weapon held | Color band |
|---|---|---|---|
| Fire Knight | Broad shoulders + horned helmet | Greatsword (right hand) | RED chest crest |
| Ice Mage | Pointed hood + long sleeves | Frost staff (left, raised) | BLUE shoulder cape |
| Archer | Slim build + shoulder quiver | Bow (drawn, right) | YELLOW headband |
| Druid | Antlers + leaf shoulder mantle | Vine staff (vertical) | GREEN robe |
| Wizard | Tall pointed hat + star pattern | Orb floating above palm | PURPLE robe + star pattern |

Players should be able to ID class at thumbnail size from silhouette alone.

---

## 6 — Enemy visual spec

3 variants × 5 colors + miniboss + world boss. **Color = behavior tell** (matches §3.5 of combat-design). The roster is intentionally a **mixed taxonomy** — slime grunts (Walker, Brute) flanking humanoid Runners. The mix preserves the cute-cartoon-threatening read while letting Runners carry a distinct silhouette so players can read a fast-moving threat at a glance.

| Variant | Body type | Silhouette tell | Scale | Animation feel |
|---|---|---|---|---|
| Walker | **Slime** | Round slime blob, small crown | 1.0× at lane cell 0 | Plodding 2-step squash/stretch |
| Runner | **Humanoid** | Skinny humanoid, leaning forward, light armor | 0.85× | Quick 4-step loop |
| Brute | **Slime** | Stocky slime, oversized shoulder pads | 1.3× | Heavy 3-step loop with shoulder roll |
| Miniboss (YELLOW Brute) | Slime | Brute silhouette + larger crown | 1.6× | Brute loop, slower |
| World Boss | Bespoke | W1: Corrupter — tendrils + glowing PURPLE eye | 2.5–3.0× | Bespoke |

Enemy color is in their **garment / slime-body tint + a glowing eye/core**, never in their outline. Outline stays the neutral dark across all enemies — this protects gate-color readability (enemies and bubbles use the same five hues, so the eye/core is what disambiguates a stray enemy from a stray bubble).

Depth scaling: lane cell 20 (spawn) = 0.3×, lane cell 0 (gate) = 1.0×. Linear interp.

---

## 7 — Bubble + gate visual spec

### 7.1 — Standard bubble

- Sphere with one specular pip top-left at ~25%.
- Class-color fill, **no outline** — bubbles are an intentional exception to the outline rule because they read as a different material (candy / glass) than the matte sprites. The candy gloss + specular pip carries the silhouette on its own.
- 1 subtle inner-shadow ring at bottom for volume (cel, not gradient).
- Hero bubble: same body + small inset hero portrait + a thin "halo" ring in the hero's class color. Reads as "there's a hero in there."

### 7.2 — Gate states (currently binary in proto — locked here as three-state)

| State | Look |
|---|---|
| **Closed** | Bubble at full opacity. Stops enemies. Hero can't fire through column. |
| **Cracked** | Bubble with a fracture overlay (3 crack lines), 80% opacity. Enemies still blocked, **heroes can fire through.** |
| **Open** | No bubble in cell. Enemies pass. Heroes fire. |

The fracture overlay is a single shared sprite tinted to each color — not 5 redraws.

### 7.3 — Corrupted bubble (boss wave only)

- Grey/black fill (`#4A4A52`), no class color.
- Visible cracks across the bubble face.
- Faint PURPLE aura pulsing 1 Hz.
- 2-second telegraph **before** corruption: target column outlined with pulsing purple, lightning crackle from boss tendril.

---

## 8 — VFX system

VFX is shader + particle on top of base sprite. Three intensity tiers — pick consciously per moment.

| Tier | Examples | Length | Particle count |
|---|---|---|---|
| **Micro** (per shot) | Hero fire flash, bubble pop sparkle, hit shake | 100–200 ms | 3–8 |
| **Macro** (per moment) | Hero freed, color frenzy trigger, ultimate, boss corruption fire, enemy breach | 400–800 ms | 12–30 |
| **Mega** (per outcome) | Wave clear, run clear, boss death, gacha legendary | 1.5–3.0 s | 60+ (still respects mobile budget — atlas + GPU particles) |

### 8.1 — Status effect on-enemy treatments

Effect shown as a small icon above the enemy's HP bar + a body tint. **Multiple statuses stack icons left-to-right (no cap, per Q5).**

| Status | Icon | Body tint | Loop FX |
|---|---|---|---|
| Slow | Snowflake (small) | None | Blue trail behind movement |
| Freeze | Snowflake (large) | Pale blue body | Ice crystal overlay |
| Burn | Flame | Red rim glow | Flickering flame above head, 1-Hz tick |
| Poison | Drip | Green skin tint | Green bubble particles, 1-Hz tick |
| Stun | Star spiral | None | Stars orbiting head |

### 8.2 — Ultimate VFX (one signature moment per class)

Locked at "macro" tier minimum — these are the most expressive moments in the game. Each ult gets a bespoke 600–800 ms screen-coverage VFX:

- **Fire Knight — Eruption:** vertical column of flame from below, screen shakes 200 ms.
- **Ice Mage — Cryo Wave:** horizontal frost sweep, all on-screen enemies freeze 1 frame.
- **Archer — Volley:** arc of arrows from off-screen left, falling on lane.
- **Druid — Verdant Surge:** green ground bloom under hero row, healing motes rise.
- **Wizard — Forking Bolt:** purple chain lightning, 3 hops.

### 8.3 — Color frenzy

Activate VFX: screen edge tint pulse in the frenzy color + hero(es) of that color get a continuous body glow for the rest of the wave.

---

## 9 — UI direction

### 9.1 — Surface language

- Cards: rounded corners (16-px @ 720-wide), 2-px outline in neutral dark, drop shadow at 6-px / 30% opacity.
- Buttons: rounded rect (12-px), bold class-color or accent fill, 4-px outline, text shadow.
- Modals: dim background to 60% black, modal card centered with sticker-cut outline.
- Tabs: bottom tab bar uses class colors as tab accents (Heroes=hero blend, Stages=neutral, Battle Pass=gold, Shop=green money tint, Events=violet).
- Energy bar: top-left, lightning icon, fills with the BLUE→YELLOW gradient as it regens.

### 9.2 — Animation feel

Everything springs (not eases). 200–300 ms, slight overshoot. Modals enter from bottom with a 10° tilt that settles. Reward chests bounce on land.

### 9.3 — Tap-to-skip default

Per Q13: reward animations are tap-to-skip and there is a "default skip" toggle in settings. Veterans never wait.

### 9.4 — Damage number policy (Q7 locked here)

Show damage numbers **only** for: crits, executes (Archer <30%), synergy-boosted hits, frenzy hits, ultimate hits, boss-corruption damage. Regular hits show HP-bar depletion only. Numbers float up 80 px in 500 ms then fade.

### 9.5 — Closed-column hero affordance

When a hero's firing column is closed: hero sprite drops to 60% opacity, faint dashed "would-fire" line projects up to the bubble blocking them. Restore to 100% on column open/crack.

---

## 10 — Audio direction (high level — full brief still TBD with audio partner)

Anchor reference: **Wittle Defender + Bubble Witch hybrid.** Bubble pops are satisfying *plinks*, hero shots are *thwacks*, enemies grunt with cartoon weight.

Per Q10, these are the SFX buckets that need delivery — listed here so art and audio agree on emotional tone:

| Bucket | Emotional read |
|---|---|
| Bubble pop | Satisfying, light, repeatable (must not fatigue) |
| Hero fire (per class) | Class-specific: FK = heavy chop, IM = airy whoosh, Archer = bow twang, Druid = wood creak, Wizard = electric zap |
| Enemy breach | Heavy thud + glass-shatter undertone |
| Hero freed | Bright "ta-da" 3-note rise |
| Boss arrival | Horn, low + ominous |
| Frenzy activation | Synth riser, 1.2 s |
| Base HP < 25% | Heartbeat loop, slow |
| Wave clear | Bright 4-note sting |
| Final move warning | Single tense pulse |
| Ultimate trigger (per class) | Bespoke per class — see §8.2 VFX, audio matches the motion |
| Status applications | Whoosh / crackle / ignite / drip / chime as in §8.1 |
| Corruption | Glass-shatter + low purple sub-rumble |

Music: stage music is loopable 60–90 s, layered (combat layer fades in on enemy presence). Boss wave has a bespoke 30–45 s loop with horn motif.

---

## 11 — Reference anchors

When briefing artists, frame the look against these published games (not "copy" — direction-set):

- **Wittle Defender** — chibi proportion, flat cel, punchy hit feedback
- **Bubble Witch 3 Saga** — bubble candy surface, UI saturation
- **Squad Busters** — chibi cast clarity at small thumbnail size
- **Slime Legion** — VFX density without losing readability
- **Royal Match** — UI polish + reward animation rhythm (we are *less* glossy, more cel)

Explicit anti-references: Marvel Snap (too painterly), Brawl Stars (too 3D), Whiteout Survival (too grim/grounded), Toon Blast (too noodle-cartoon).

---

## 12 — Priority order for unbuilt art (use this as the brief order)

1. **Status icon set** (5) + body tint shaders — unblocks combat readability in prototype.
2. **Gate state sheet** — cracked overlay (1 sprite tintable to 5 colors) + open empty slot. Unblocks the proto's three-state gate.
3. **World map + stage select screen** (1 mockup) — sets meta-loop visual feel; unblocks ~60% of remaining UI art.
4. **Ultimate VFX** (5) — second most-felt moment after a freed hero.
5. **Rarity treatment shaders** (4 tiers) — adds visible gacha value without redrawing portraits.
6. **Boss corruption pass** — telegraph, corrupted bubble overlay, boss tendril VFX. Unblocks boss wave.
7. **Gacha + reward screens** — biggest monetization-facing surface.
8. **Audio brief delivery** — once V8.2 ult VFX are locked, audio can match motion.

Everything below this line (battle pass UI, daily quest UI, loadout edit, etc.) can wait until after first internal playtest.

---

## Change log

- 2026-05-21 — initial draft, consolidating Q11 lock + scattered visual cues across v2 design docs.
- 2026-05-22 — Phase 0 spec amendments from polish-sweep audit:
  - §6 enemy taxonomy: mixed — Walker + Brute = slime (accept existing art), Runner = humanoid (re-gen pending).
  - §7.1 bubble outline: dropped — bubbles are a deliberate no-outline exception (candy/glass material read).
  - Wizard portrait: accepted as-is despite outline-failing per audit; ship as a known soft-launch fix.
