---
name: Pop Brigade v2 — Audio Brief
status: draft v1 — ready for partner handoff
created: 2026-05-22
visual_direction: ./art-direction.md
mockup_set: ./mockups/
---

# Pop Brigade v2 — Audio Brief

> For an external audio partner / sound designer. Pop Brigade v2 is a hybrid casual mobile game — bubble shooter on top, tower defense behind. Match runs are ~4–5 minutes, 5 waves per run, boss-gated at wave 5. The audio job is to make the loop **satisfying at 30 seconds** and **non-fatiguing over 30 minutes**.

---

## 1 — Reference anchors

Single-listen, in order:

| Reference | Why |
|---|---|
| **Wittle Defender** | Chibi-cute hit feedback, punchy combat, mid-Tempo bright music |
| **Bubble Witch 3 Saga** | The "plink" satisfaction on bubble pop. Set the bar here. |
| **Squad Busters** | Cheerful, encouraging UX SFX cadence. Optimistic music. |
| **Royal Match** | Reward animation rhythm (chest open, gacha pull). We are *less* glossy-plastic but want the same *moment* feeling. |

Anti-references (do NOT sound like): Marvel Snap (too cinematic), Brawl Stars (too rock-band aggressive), Whiteout Survival (too grim).

---

## 2 — Mood + texture targets

- **Overall:** bright siege. The wall is under attack but the player is having a good time. Cheerful, not grim. Cartoon physics over realism — every hit can be a "thwack" or "plink" instead of a thud.
- **Frequency:** music in the warm mids; SFX cover bright top end. Avoid sub-bass except for boss arrival.
- **Repetition:** every SFX that fires >1×/second (bubble pop, hero fire) needs **3–5 micro-variants** that randomize on play. Repetition fatigue is the #1 risk.
- **Loudness:** mix at -16 LUFS-i (mobile standard). No SFX should clip music below -10 dB unless it's a "mega" moment.

---

## 3 — Asset list (delivery order)

### 3.1 — Tier P0 (must ship for first internal playtest)

| # | Asset | Format | Length | Notes |
|---|---|---|---|---|
| BP-1 | Bubble pop (5 variants × 5 colors) | mono WAV 44.1k 16b | 200–400 ms | The single most-heard SFX. Plink/pop satisfaction. Slight pitch lift per color (RED lowest, PURPLE highest). |
| HF-FK | Fire Knight fire | mono WAV | 250 ms | Heavy chop / sword swing whoosh + meaty impact. |
| HF-IM | Ice Mage fire | mono WAV | 300 ms | Airy whoosh + crystalline tail. |
| HF-AR | Archer fire | mono WAV | 200 ms | Bow draw click → release twang. Punchy. |
| HF-DR | Druid fire | mono WAV | 350 ms | Wood creak / vine snap → soft impact. |
| HF-WZ | Wizard fire | mono WAV | 300 ms | Electric zap zigzag → spark crackle. |
| EW-W | Enemy walk loop (Walker) | mono WAV | loopable 1.5 s | Plodding 2-step. |
| EW-R | Enemy walk loop (Runner) | mono WAV | loopable 0.6 s | Quick scampering. |
| EW-B | Enemy walk loop (Brute) | mono WAV | loopable 2.0 s | Heavy 3-step + shoulder roll. |
| EBR | Enemy breach (bash through gate) | mono WAV | 400 ms | Heavy thud + glass-shatter undertone. |
| EDT | Enemy death | mono WAV | 300 ms | Cartoon "poof" + pop. 3 variants. |
| HFR | Hero freed | mono WAV | 800 ms | 3-note rising sparkle, "ta-da" feeling. |
| WC | Wave clear sting | stereo WAV | 1.5 s | Bright 4-note ascending sparkle + light cymbal. |
| FMW | Final move warning | mono WAV | 200 ms | Single tense pulse. Plays at moves ≤ 1. |
| STS-1 | Slow application | mono WAV | 250 ms | Wind whoosh, descending. |
| STS-2 | Freeze application | mono WAV | 350 ms | Ice crackle + crystallize. |
| STS-3 | Burn application | mono WAV | 300 ms | Match-strike ignite + soft roar. |
| STS-4 | Poison application | mono WAV | 250 ms | Bubbling liquid drip. |
| STS-5 | Stun application | mono WAV | 300 ms | Tiny twinkling chime + dazed warble. |
| UI-T | UI tap | mono WAV | 80 ms | Soft cardboard tap. |
| UI-C | UI confirm | mono WAV | 200 ms | Bright happy click. |
| UI-X | UI cancel / back | mono WAV | 150 ms | Lower-pitched dull click. |
| UI-E | UI error / locked | mono WAV | 200 ms | Soft buzz. |

### 3.2 — Tier P1 (must ship for soft launch)

| # | Asset | Format | Length | Notes |
|---|---|---|---|---|
| ULT-FK | Fire Knight Ultimate — Eruption | stereo WAV | 1.2 s | Volcanic rumble + crackling flame burst. |
| ULT-IM | Ice Mage Ultimate — Cryo Wave | stereo WAV | 1.5 s | Sweep wind + crystallize-crackle finale. |
| ULT-AR | Archer Ultimate — Volley | stereo WAV | 1.5 s | Multiple arrow whistles staggered + impact thuds. |
| ULT-DR | Druid Ultimate — Verdant Surge | stereo WAV | 1.5 s | Earth rumble + plant growth crunch + healing chime tail. |
| ULT-WZ | Wizard Ultimate — Forking Bolt | stereo WAV | 1.2 s | Electric crack × 3 forking hits, each pitched slightly higher. |
| BSS-A | Boss arrival horn | stereo WAV | 2.0 s | Low brass horn motif, foreboding but cartoon. |
| BSS-R | Boss low-HP roar | mono WAV | 1.0 s | Desperate roar — cartoon, not horror. |
| CRP | Boss corruption fire | mono WAV | 500 ms | Glass-shatter + low purple sub-rumble. |
| CRP-T | Boss corruption telegraph | mono WAV | 2.0 s | Electric crackle building tension, 2-second buildup. |
| FRZ | Color frenzy riser | stereo WAV | 1.2 s | Synth riser climaxing in a happy fanfare. |
| HBT | Base HP < 25% heartbeat | mono WAV | loopable 1.0 s | Soft thump-thump, fades in proportional to damage taken. |
| RC | Run clear / boss death | stereo WAV | 2.5 s | Cartoon "VICTORY" fanfare. Light brass + sparkle. |
| GACHA-R | Gacha pull (Rare) | mono WAV | 1.0 s | Soft chime + light sparkle. |
| GACHA-E | Gacha pull (Epic) | stereo WAV | 1.5 s | Glass tinkle + soft fanfare. |
| GACHA-L | Gacha pull (Legendary) | stereo WAV | 2.0 s | Big golden fanfare + crowd "ooh". |
| CHEST | Chest open | mono WAV | 1.0 s | Wood creak + golden chime. |
| LVUP | Player level up | stereo WAV | 1.5 s | Bright fanfare, gentle. |
| RWD-T | Reward tap (small claim) | mono WAV | 200 ms | Bright "ding". |

### 3.3 — Tier P2 (post-soft-launch polish)

- Music loops (see §4).
- Per-world ambient layers.
- Voice barks per hero class (one-liners on freed / on ult cast).
- Per-event musical motifs.

---

## 4 — Music

### 4.1 — Loop structure

Stage music = **layered ducking system** that fades up/down per game state.

| Layer | Plays when |
|---|---|
| **Ambient bed** | Always. Low-key meadow ambience + soft melodic motif. 60–90 s loop. |
| **Combat layer** | Fades in when enemies present on lane. Adds percussion + faster melody. |
| **Boss layer** | Replaces ambient + combat on wave 5. Bespoke boss theme, 30–45 s loop, includes horn motif from BSS-A. |
| **Frenzy layer** | One-shot, plays on top of any layer for 5 s when color frenzy triggers. |
| **Wave-clear sting** | One-shot, plays on top for 1.5 s. Music briefly ducks. |

### 4.2 — Tempo + key targets

- BPM: 120–135 (energetic but not stressful).
- Key: bright major keys (C / G / D). Avoid minor keys outside boss + corruption moments.
- Instrumentation: chibi orchestral — ukulele, marimba, light brass, soft synth pads, light tambourine on combat.

### 4.3 — World-themed reskin

World 1 (Sunbloom) = sunny meadow palette → light ukulele + marimba + flute.
World 2 (TBD) → reskin to match biome. One-page brief per world; main melodic motif stays so the game retains identity.

### 4.4 — Menu music

Light variant of stage music — strip percussion, keep melody. 90-second loop. Cross-fades into combat music when entering a stage.

---

## 5 — Mixing + technical specs

- **Mastering bus:** -16 LUFS-i, true peak -1 dB.
- **Sample rate:** 44.1 kHz, 16-bit.
- **Format:** WAV for source delivery; OGG Vorbis q5 for in-game (Godot default).
- **Loops:** seamless. Provide both a "tail" version (one-shot) and a "loop" version where applicable.
- **Mono vs stereo:** most SFX are mono (mobile speaker reality). Music, mega-tier moments, ult VFX are stereo.
- **Naming convention:** `{tier}_{category}_{name}_{variant}.wav` — e.g. `p0_bubble_pop_red_v3.wav`.

---

## 6 — Per-asset audio notes (the moments that matter)

### Bubble pop — the most important single SFX

This sound fires ~50 times per run. **Variation is mandatory.**

- Pitch slight per color: RED 220 Hz fundamental, YELLOW 264, GREEN 294, BLUE 330, PURPLE 392.
- Each color gets 5 micro-variants at ±20 cents pitch.
- Layer: a short transient pop + a soft "candy crunch" tail.
- Cluster pops (4+ bubbles in one match) play layered with 30–50 ms stagger, each pitch-shifted up slightly. The bigger the match, the more satisfying.

### Hero freed — the FTUE moment

The 3-note rising sparkle is the single most important SFX for D1 retention proxy. New players need to feel **delighted** the first time they free a hero.

- Notes: C5 → E5 → G5 (major triad rising).
- Add a "ta-da" sparkle tail (4 high glissando notes descending).
- 800 ms total.

### Boss arrival — the wave-5 reveal

The horn motif should be re-used in the boss music loop. **Cartoon foreboding**, not horror — think "uh oh, here we go" not "we're all going to die."

- Low brass (F2 → Bb2 → F2 minor triad), ~1 s.
- Tail with a subtle vinyl crackle for atmosphere.

### Color frenzy riser

This is the moment a player feels powerful. Synth riser climbing 1.2 s, climaxing in a happy major-chord fanfare. Sync the climax exactly with the on-screen "COLOR FRENZY!" banner appearing.

### Final move warning

Plays when moves ≤ 1 AND enemies are still on lane. Single 200 ms tension pulse, soft enough to not annoy if the player is fine, sharp enough to register.

---

## 7 — Files we have for visual reference

The audio partner should look at:

- `mockups/match-screen-v2-b.png` — combat HUD context
- `mockups/vfx-hero-ultimates.jpg` — ultimate visual feel × 5
- `mockups/vfx-combat.png` — combat micro/macro VFX (hero fire flashes, hero freed, enemy breach)
- `mockups/vfx-color-frenzy.jpg` — frenzy moment, sync target
- `mockups/vfx-boss-corruption.jpg` — corruption mood
- `mockups/vfx-celebration.jpg` — wave/run clear + legendary gacha
- `mockups/run-clear.png` — chest reward moment
- `mockups/gacha.png` — gacha pull context

Audio cue lengths should match the VFX lengths from `art-direction.md` §8 (micro 100-200 ms, macro 400-800 ms, mega 1500-3000 ms).

---

## 8 — Deliverables checklist for partner

- [ ] 23 P0 SFX files (see §3.1).
- [ ] 18 P1 SFX files (see §3.2).
- [ ] 1 stage music package: ambient + combat + boss layers + frenzy + wave-clear sting, all stems separate.
- [ ] 1 menu music loop.
- [ ] Provide both .wav source and .ogg q5 in-game versions.
- [ ] Implementation reference doc (which file plays on which Godot signal).
- [ ] One round of revisions after first integration playtest.

**Budget guidance:** mid-tier mobile-game audio partner, expect $4–7k for the above. We are not buying voice acting or licensed music.

---

## 9 — Schedule

| Phase | Deliverable | Target |
|---|---|---|
| Brief sent | This doc + mockup link bundle | Week 0 |
| First pass review | All P0 SFX + ambient music draft | Week 3 |
| Integration playtest | P0 SFX in build, mixing pass | Week 5 |
| P1 delivery | P1 SFX + combat music + boss music | Week 6 |
| Final mix + polish | Mastering + revisions | Week 7 |

Soft launch target follows engineering schedule, not audio.

---

## Change log

- 2026-05-22 — initial draft for partner handoff.
