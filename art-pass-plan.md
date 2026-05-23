---
name: Pop Brigade v2 — Art & Polish Pass Plan
status: in-progress
created: 2026-05-22
inputs:
  - ./art-direction.md
  - ./ui-spec.md
  - ./mockups/v2_playfield_polish_pass.png
---

# Pop Brigade v2 — Art & Polish Pass Plan

Operationalizes `art-direction.md` against `ui-spec.md`. Every item below is a concrete deliverable with an acceptance test, a priority tier, and a target slot.

## Acceptance test (applies to all items)

A delivered asset is **accepted** when:
1. It is readable at thumbnail (64-px) — class / variant / status ID-able from silhouette + color alone.
2. Outline is the neutral dark `#1A1626`, not pure black.
3. Palette uses the locked five class hues (`art-direction.md` §2.1) — no off-spec colors.
4. No gradients or rim lights — only flat fills + 1 cel shadow + 1 specular pip on bubble surfaces.
5. Style passes the "Wittle Defender + Bubble Witch hybrid" reference test (not Royal-Match plasticky, not Slime-Legion neon, not Marvel-Snap painterly).

## Priority tiers

- **P0** — must ship for first internal playtest (proto-day-1 feel).
- **P1** — must ship for soft launch.
- **P2** — post-soft-launch polish.

---

## 1 — Mockups (UI screens, used as artist briefs + Godot reference)

Target dir: `v2/mockups/`. All 9:16 portrait unless noted. PNG.

| # | Asset | Tier | Status | Notes |
|---|---|---|---|---|
| M1 | **Match screen v2 — full HUD** | P0 | ✅ batch3 → `match-screen-v2-b.png` (v1 batch1 superseded) | Final accept — asymmetric wall, hero bubbles embedded, slowed-enemy icons, Ice Mage READY glow |
| M2 | **World map — Sunbloom (World 1)** | P0 | ✅ batch1 → `world-map-sunbloom.png` | Strong reference, accept |
| M3 | **Stage confirm modal** | P0 | ✅ batch1 → `stage-confirm.png` | Accept |
| M4 | **Loadout screen** | P0 | ✅ batch2 → `loadout.jpg` | Accept — slot row, roster grid, synergy preview all readable |
| M5 | **Intermission overlay** | P0 | ✅ batch1 → `intermission.png` | Accept |
| M6 | **Run clear (with chest)** | P0 | ✅ batch1 → `run-clear.png` | Accept |
| M7 | **Run fail** | P0 | ✅ batch2 → `run-fail.jpg` | Accept — bittersweet tone, revive offer prominent |
| M8 | **Gacha pull screen** | P0 | ✅ batch2 → `gacha.png` | Accept — capsule, rates, 1×/10× CTAs |
| M9 | **Meta hub** | P0 | ✅ batch2 → `meta-hub.png` | Accept — currencies, world banner, tab strip, daily-quest red dot |
| M10 | **Hero detail** | P0 | ✅ batch2 → `hero-detail.jpg` | Accept — Legendary Ember showcase, stats, rank-up track |
| M11 | **Roster grid** | P0 | ✅ batch3 → `roster-grid.png` | Accept — 9 owned + 3 locked silhouettes, rarity badges, rank tags |
| M12 | **Battle pass screen** | P1 | ⬜ plan | Free + premium tracks, tier rewards |
| M13 | **Daily quests** | P1 | ⬜ plan | 3 daily + 5 weekly objectives w/ check states |
| M14 | **Events tab** | P1 | ⬜ plan | Card list, banner art per event |
| M15 | **Shop** | P1 | ⬜ plan | IAP pack grid, featured row |
| M16 | **Mail / inbox** | P2 | ⬜ plan | Row list w/ claim buttons |
| M17 | **Settings** | P2 | ⬜ plan | Sliders + account info |
| M18 | **Pause overlay** | P0 | ✅ batch2 → `pause.jpg` | Accept — Resume / Settings / Quit, clear hierarchy |

## 2 — Gameplay art (asset classes used in combat)

Target dir: `v2/godot/assets/`. Square PNGs unless noted. Each item is a sprite or sheet.

### 2.1 — Bubble + gate

| # | Asset | Tier | Status | Spec |
|---|---|---|---|---|
| G1 | Standard bubble × 5 colors | P0 | ✅ exists | In `pop_brigade_art/bubbles/`. Audit against §7.1 spec. |
| G2 | Hero bubble × 5 colors | P0 | ✅ exists | Inset portrait + halo ring in class color. |
| G3 | **Cracked overlay (tintable)** | P0 | ✅ batch2 → `gate-states.png` (sheet) | Closed/cracked/open/corrupted all in one reference sheet — extract crack overlay as alpha mask |
| G4 | **Corrupted bubble** | P0 | ✅ batch2 → `gate-states.png` (sheet) | Grey-black with purple aura, on the sheet |
| G5 | **Open-slot indicator** (post-pop) | P0 | ✅ batch2 → `gate-states.png` (sheet) | Faint dotted outline, on the sheet |
| G6 | Specular pip overlay | P1 | ⬜ plan | Single 25%-radius highlight, top-left aligned. Reused across all bubbles. |

### 2.2 — Heroes (portrait + cutout)

| # | Asset | Tier | Status | Spec |
|---|---|---|---|---|
| H1 | Fire Knight (Ember) | P0 | ✅ exists | Audit silhouette against §5.4 (broad shoulders + horned helm). |
| H2 | Ice Mage (Frost) | P0 | ✅ exists | Audit (pointed hood + frost staff). |
| H3 | Archer (Robin) | P0 | ✅ exists | Audit (slim + shoulder quiver + drawn bow). |
| H4 | Druid (Willow) | P0 | ✅ exists | Audit (antlers + vine staff + green robe). |
| H5 | Wizard (Merlin) | P0 | ✅ exists | Audit (tall pointed hat + orb above palm + star pattern). |
| H6-H12 | **Rarity × Tier showcase grid** | P0 | ✅ batch3 → `rarity-tier-showcase.png` | 4 rarity columns × 3 tier rows for Fire Knight — additive shader reference for all 5 heroes |
| H13 | **READY-ult portrait outline** | P0 | ✅ batch4 → `combat-overlays-sheet.png` (tile 1) | Glowing red outline + tiny "READY" sticker on FK example |

### 2.3 — Enemies

| # | Asset | Tier | Status | Spec |
|---|---|---|---|---|
| E1 | Walker × 5 colors | P0 | ✅ exists | Audit silhouette tell (humanoid grunt, hunched). |
| E2 | Runner × 5 colors | P0 | ✅ exists | Audit (skinny, leaning forward). |
| E3 | Brute × 5 colors | P0 | ✅ exists | Audit (stocky, oversized shoulders). |
| E4 | Miniboss YELLOW | P0 | ✅ exists | Audit (Brute + crown, 1.6× scale). |
| E5 | Boss: Corrupter | P0 | ✅ exists | Audit (tendrils, glowing PURPLE eye). |
| E6 | **Walk-cycle frames per enemy** | P1 | ⬜ plan | 2-4 frame loops per variant. |
| E7 | **HP bar overlay (above sprite)** | P0 | ✅ batch4 → `combat-overlays-sheet.png` (tile 2) | Slim red bar + status-icon tray underneath, on slime grunt example |
| E8 | **Telegraph spawn indicator** | P0 | ✅ batch4 → `combat-overlays-sheet.png` (tile 3) | Fade-in silhouette + "INCOMING" arrow + 2s pulse ring |

### 2.4 — Status effects

| # | Asset | Tier | Status | Spec |
|---|---|---|---|---|
| S1-S5 | **Status icon sheet (all 5)** | P0 | ✅ batch2 → `status-icons.png` | Slow/Freeze/Burn/Poison/Stun in one row. Tint shaders + body FX remain for engine. |

### 2.5 — VFX

| # | Asset | Tier | Status | Spec |
|---|---|---|---|---|
| V1-V4 | **Combat VFX sheet** (bubble pop / hero fire × 5 / hero freed / enemy breach / hit impact) | P0 | ✅ batch4 → `vfx-combat.png` | 9-tile reference, all combat micro+macro VFX |
| V5 | **Color frenzy** (trigger + active) | P0 | ✅ batch4 → `vfx-color-frenzy.jpg` | Two-state composite |
| V6-V10 | **Hero ultimates sheet** (all 5) | P0 | ✅ batch4 → `vfx-hero-ultimates.jpg` | Eruption / Cryo Wave / Volley / Verdant Surge / Forking Bolt |
| V11-V12 | **Boss corruption sheet** (telegraph + fire + result) | P0 | ✅ batch4 → `vfx-boss-corruption.jpg` | 3-tile reference |
| V13-V15 | **Celebration VFX sheet** (wave clear + run clear + legendary gacha) | P0 | ✅ batch4 → `vfx-celebration.jpg` | 3-tile reference, all mega-tier moments |

### 2.6 — Cannon + projectiles

| # | Asset | Tier | Status | Spec |
|---|---|---|---|---|
| C1-C4 | **Cannon + projectile sheet** | P0 | ✅ batch3 → `cannon-projectile-sheet.png` | Cannon body, aim trajectory, projectile trail, on-deck queue all in one reference |

### 2.7 — Background / parallax (per world)

| # | Asset | Tier | Status | Spec |
|---|---|---|---|---|
| B1-B3 | **Sunbloom parallax panorama** | P0 | ✅ batch3 → `backdrop-sunbloom.png` | Three parallax layers (sky/mid/foreground) in one reference — slice for engine |
| B4 | World 2 set (TBD theme) | P2 | ⬜ plan | Defer until W1 ships. |

---

## 3 — UI assets (reusable)

| # | Asset | Tier | Status |
|---|---|---|---|
| U1-U2 | Buttons — primary green / cancel / quit | P0 | ✅ batch3 → `ui-elements-sheet.png` | 3 states + class-color variants extractable from sheet |
| U3-U5 | Card / modal frame / tab strip | P0 | ✅ derive from mockups | Visible in stage-confirm, pause, meta-hub mockups |
| U6 | Energy icon + bar | P0 | ✅ batch3 → `ui-elements-sheet.png` | Lightning on blue badge |
| U7 | Gem icon | P0 | ✅ batch3 → `ui-elements-sheet.png` | Purple gem |
| U8 | Gold-coin icon | P0 | ✅ batch3 → `ui-elements-sheet.png` | Stacked gold coins |
| U9 | XP-star icon | P0 | ✅ batch3 → `ui-elements-sheet.png` | Yellow star |
| U10 | Chest closed/opening/open (3 states) | P0 | ✅ batch3 → `chest-states.png` | Excellent — open state shows rewards inside |
| U11 | HP bar (slim + segmented) | P0 | ✅ batch3 → `ui-elements-sheet.png` | 3 bar variants in sheet |
| U12 | Move-counter pip × 10 | P0 | ✅ batch4 → `combat-overlays-sheet.png` (tile 5) | 10 pip dots with lit/unlit states |
| U13 | Synergy callout banner | P0 | ✅ batch4 → `notifications-feedback-sheet.png` (tile 1) | Wide pill banner w/ icon row + check |
| U14 | Toast banner (1-s synergy/effect notifications) | P0 | ✅ batch4 → `notifications-feedback-sheet.png` (tile 2) | Smaller bottom-of-screen pill |
| U15 | Damage-number sprite (display font + outline) | P0 | ✅ batch4 → `notifications-feedback-sheet.png` (tile 3) | Regular / CRIT / EXECUTE / heal variants |
| U16 | Tutorial arrow + highlight cutout | P0 | ✅ batch4 → `notifications-feedback-sheet.png` (tile 4) | Dimmed bg + cutout + arrow + tutorial card |
| U17 | Confetti burst sheet | P0 | ✅ batch4 → `particles-sheet.jpg` (tile 1) | 5-color confetti at peak burst |
| U18 | Sparkle particle sheet | P0 | ✅ batch4 → `particles-sheet.jpg` (tile 2) | Mixed sparkle constellation |

---

## 4 — Audio brief (handoff to audio partner)

All items per `art-direction.md` §10. Status: ⬜ unbriefed. Output: one audio-brief PDF/Notion page handed to partner, then SFX files delivered to `v2/godot/assets/sfx/`.

Tier P0 SFX list (must-ship for first playtest):
- Bubble pop (variations × 5 colors)
- Hero fire × 5 classes
- Enemy walk / breach / death × 3 variants
- Hero freed (3-note rise)
- Wave clear sting
- Run clear / boss death sting
- Final-move warning tone
- Status applications × 5 (slow whoosh / freeze crackle / burn ignite / poison drip / stun chime)
- UI tap / confirm / cancel

P1 SFX:
- Ultimate trigger × 5 classes
- Boss arrival horn
- Boss low-HP roar
- Corruption fire
- Color frenzy riser
- Base HP < 25% heartbeat loop

P2:
- Music loops (per world, layered combat + ambient)

---

## 5 — Polish sweep (existing assets)

Before generating new art, audit existing assets against the locked direction. Items below get a re-export pass if they fail the acceptance test in any way.

| # | Asset | Test failure to look for |
|---|---|---|
| AP1 | Hero portraits × 5 | Outline color (must be `#1A1626` not pure black). Specular treatment on chest accent. Class silhouette tells (§5.4). |
| AP2 | Bubbles × 5 + hero bubbles × 5 | Specular pip placement (top-left 25%). Bottom inner-shadow ring present. |
| AP3 | Enemies × 17 variants | Eye/core glow visible (color disambiguation rule). Outline is neutral dark, not class color. |
| AP4 | `v2_playfield_polish_pass.png` mockup | Does the v2 HUD reflected match `ui-spec.md` §3.6? (5 heroes, ult gauges, no phase banner.) |

---

## 6 — Execution log (this session)

**Total spent:** ~$2.79 of $50 budget · **20 assets delivered** in 3 batches via `nano-banana-pro` (Gemini 3 Pro Image) at medium quality.

### Batch 1 — most-felt P0 mockups ($0.70)
✅ M1 match-screen (v1, superseded by v2-b), M2 world-map-sunbloom, M3 stage-confirm, M5 intermission, M6 run-clear.

### Batch 2 — gameplay unblockers + remaining P0 mockups ($1.11)
✅ S1-5 status-icons, G3-5 gate-states, M4 loadout, M7 run-fail, M8 gacha, M9 meta-hub, M10 hero-detail, M18 pause.

### Batch 3 — asset sheets + match-screen retry ($0.98)
✅ M1 match-screen-v2-b (final), M11 roster-grid, C1-4 cannon-projectile-sheet, U10 chest-states, U1-9+U11 ui-elements-sheet, H6-12 rarity-tier-showcase, B1-3 backdrop-sunbloom.

### Batch 4 — VFX sheets + small assets ($1.11)
✅ V1-V4 vfx-combat, V5 vfx-color-frenzy, V6-V10 vfx-hero-ultimates, V11-V12 vfx-boss-corruption, V13-V15 vfx-celebration, H13+E7+E8+G6+U12 combat-overlays-sheet, U13-U16 notifications-feedback-sheet, U17-U18 particles-sheet.

### Companion docs delivered this session
✅ `audio-brief.md` — partner-ready brief, 23 P0 + 18 P1 SFX list, layered music spec, schedule, budget guidance.
✅ `polish-sweep-audit.md` — manual audit of existing 30+ assets. Identified 2 spec amendments (enemy slime taxonomy, bubble outline exception) and 1 hero re-gen (Wizard).

### Still ⬜ (defer to future batches)
- **Walk-cycle frames per enemy** (E6) — 2-4 frame loops × 17 variants. Hand-animate from existing static sprites; not LLM work.
- **P1 screens** — battle pass, daily quests, events, shop (~$0.56 in 4 prompts).
- **P2 screens** — mail, settings (~$0.28).
- **Audit fixes** — Wizard re-gen + optional hero re-pass + optional bubble re-pass (~$1.30 total). See `polish-sweep-audit.md` §6.

**Total to fully close all P0 art:** ~$1.30 (audit fixes). All major P0 surfaces delivered.

---

## 7 — How to use these deliverables

Each delivered mockup serves three purposes:
1. **Artist brief** — hand to a contract artist as reference for production-quality art. They will redraw, not reuse, but the composition + palette + silhouette decisions are locked.
2. **Godot scene reference** — match scene layout and HUD positioning to the mockup pixel-for-pixel during Phase 8 (telemetry + tuning UI) of the prototype.
3. **Stakeholder alignment** — concrete visuals to align with CEO + design lead before art production spend.

---

## Change log

- 2026-05-22 — initial plan + Batches 1-3 executed. 20 deliverables across mockups, asset sheets, and reference grids. Status, gate-state, chest-state, and rarity-tier sheets are production-extractable. Match-screen v2-b is the canonical reference.
- 2026-05-22 — Batch 4 (8 prompts) added VFX sheets + combat overlays + notifications + particles. Audio brief + polish-sweep audit docs written. 28 total deliverables. Spent $3.90 of $50.
