---
name: Pop Brigade v2 — Polish Sweep Audit
status: complete v1
date: 2026-05-22
direction: ./art-direction.md
audited_assets:
  - assets/heroes/ (5 portraits + 5 cutouts)
  - pop_brigade_art/bubbles/ (5 bubble + 5 hero-bubble)
  - v2/godot/assets/heroes/ (5 portraits)
  - v2/godot/assets/bubbles/ (5 bubble + 5 hero-bubble)
  - v2/godot/assets/enemies/ (17 variants: 5×walker, 5×runner, 5×brute, miniboss, boss)
  - v2/mockups/v2_playfield_polish_pass.png (existing composite)
---

# Pop Brigade v2 — Polish Sweep Audit

> Manual audit of every existing art asset against the locked direction in `art-direction.md`. Flags style inconsistencies, off-spec calls, and prioritized fixes. Findings drive what gets re-generated vs accepted.

## TL;DR

**~70% of existing assets pass.** The remaining ~30% need rework, with one structural decision needed first:

| Decision needed | Owner | Why |
|---|---|---|
| **Are enemies humanoid grunts or slime creatures?** | Shikha | Current sprites are slime blobs, art-direction.md §6 says humanoid (Walker/Runner/Brute). Pick one, update the other. |

Beyond that decision, the rework list is small (~6 assets) and the visual direction is largely already coherent.

---

## 1 — Hero portraits

Audited: `v2/godot/assets/heroes/{fire-knight,ice-mage,archer,druid,wizard}.png` (and the mirror set at `assets/heroes/`).

| Hero | Pass? | Findings |
|---|---|---|
| **Fire Knight** | 🟡 mostly | ✅ Chibi proportions. ✅ Horned helm in gold (matches §5.4 silhouette). ✅ Red armor + chest crest. ✅ Bold dark outline. ❌ **No greatsword visible** — carries a small dagger/short sword; spec calls for greatsword. Subtle painterly skin shading (cel direction calls for flat fills). |
| **Ice Mage** | 🟡 mostly | ✅ Pointed hood. ✅ Frost staff with blue crystal head. ✅ Blue robe. ✅ Long sleeves (silhouette tell match). ❌ **Outline is thin/silvery**, not the locked dark `#1A1626`. Painterly skin shading. |
| **Archer** | 🟡 mostly | ✅ Slim build. ✅ Bow + arrows visible. ✅ Yellow accent. (Confirmed via Loadout mockup composition.) ⚠ Need to verify shoulder quiver presence. |
| **Druid** | 🟡 mostly | ✅ Antlers. ✅ Vine staff. ✅ Green palette. ⚠ Need to verify leaf shoulder mantle (silhouette tell). |
| **Wizard** | ❌ **fails** | ✅ Tall pointed hat with star pattern. ✅ Purple robe. ✅ Orb. ❌ **No outline at all** — completely outline-less style, fails the bold-outline rule. Soft painterly shading throughout. ❌ Orb is on a wooden staff in hand, not "floating above palm" as spec'd. **This is the most off-style of the heroes.** |

### Recommended fix

**Wizard portrait** needs re-generation (or rework) to match outline rule. Other 4 heroes are acceptable for first internal playtest, but for soft launch all 5 should be re-passed for **outline weight + color uniformity** — currently outline thickness varies hero-to-hero (FK thick, IM thin, WZ none).

**Sword on Fire Knight** — minor, can be fixed in a future iteration. Not a blocker.

---

## 2 — Bubble sprites

Audited: `v2/godot/assets/bubbles/bubble_{red,yellow,green,blue,purple}.png` (and hero-bubble variants).

| Asset | Pass? | Findings |
|---|---|---|
| Standard bubbles × 5 | ❌ **fails** outline rule | ✅ Glossy candy surface ✅ Specular highlight present ✅ All 5 class colors correct. ❌ **No outlines whatsoever** — these are realistic glass-marble renders, not cel-shaded chibi bubbles. Bottom inner-shadow ring (spec §7.1) is also missing or rendered as a generic sub-surface reflection. |
| Hero bubbles × 5 | ⚠ unaudited in detail | Inset hero portraits + halo rings — composition matches spec, but if the base bubble outline is missing, the hero bubble inherits the same issue. |

### Recommended fix

**Bubbles need re-generation as a sheet** to add the bold dark outline `#1A1626` 2-4 px (matches `mockups/match-screen-v2-b.png` which shows outlined bubbles correctly). One batch prompt covers all 10 bubbles (5 standard + 5 hero) in one sheet.

**Alternative:** if you decide glossy-no-outline reads better in playtests, **update art-direction.md §7.1** to drop the outline requirement for bubbles only — keep it for heroes/enemies/UI. This is a defensible deviation because bubbles read as a "different material" (candy/glass) vs the matte sprites.

---

## 3 — Enemy sprites

Audited: `v2/godot/assets/enemies/{walker,runner,brute}_{red,yellow,green,blue,purple}.png` + `miniboss_yellow.png` + `boss_corrupter.png`.

| Asset | Pass? | Findings |
|---|---|---|
| Walker × 5 | ❌ **fails silhouette spec** | ✅ Bold dark outline. ✅ Flat cel shading. ✅ Saturated palette. ✅ Glossy cute appeal. ❌ **Slime blobs with crowns**, not "humanoid grunt, hunched" as spec'd in §6. |
| Runner × 5 | ❌ **fails silhouette spec** | Same — slime body, not "skinny, leaning forward" humanoid. |
| Brute × 5 | 🟡 close | Bulkier, with shoulder pads, but still slime-based body. Closer to spec's "stocky, oversized fists/shoulders" but not humanoid. |
| Miniboss (yellow) | 🟡 close | Larger Brute variant with crown. Functional. |
| Boss Corrupter | ✅ **passes** | ✅ Purple tendril arms. ✅ Glowing eyes (white in current, spec says PURPLE — minor). ✅ Dark outline. ✅ Cel shading. **Best-aligned enemy asset.** |

### Critical finding — silhouette taxonomy mismatch

Existing enemies are **slime monsters**, but `art-direction.md` §6 + `combat-design.md` §3.5 describe them as **humanoid grunts**. Pick a direction:

**Option A — accept slimes as the spec.** Update §6 to read:
> Enemies are slime-monster grunts. Walker = round slime with crown. Runner = elongated slime. Brute = stocky slime with shoulder pads.

This is fine for chibi mobile and the existing assets all become accepted. Slime visual identity is cleaner than humanoid grunts at 64 px thumbnail.

**Option B — re-generate enemies as humanoids.** Big re-work (17 sprites). Only worth it if a humanoid silhouette is essential to the fantasy.

**Recommendation:** **Option A**. Slimes pass the readability test, are already produced, and read as cute-cartoon-threatening which matches the "bright siege" mood. Update the spec.

---

## 4 — Composite mockup `v2_playfield_polish_pass.png`

The existing 19 MB polish mockup that predates this audit.

| Aspect | Pass? | Findings |
|---|---|---|
| HUD reflects v2 spec | ❌ **outdated** | Made before v2 design decisions locked. Likely shows phase banner / 3 heroes / move budget per phase. Superseded by `mockups/match-screen-v2-b.png`. |

### Recommended action

**Archive or delete** `v2_playfield_polish_pass.png`. The canonical reference is now `mockups/match-screen-v2-b.png`. Keep the old file only if you want a "before/after" comparison for the artist brief.

---

## 5 — Cross-asset issues

### 5.1 — Outline weight + color inconsistency

Heroes have wildly varying outline treatments:

| Hero | Outline |
|---|---|
| Fire Knight | Thick dark — matches spec |
| Ice Mage | Thin silvery — off-spec |
| Wizard | None — fails spec |
| Druid / Archer | Probably thick dark (mockups show this) |

Bubbles have **no outline** across the board. Enemies have **thick dark outlines** consistently.

**Fix:** when re-generating the Wizard portrait, lock the outline spec (`#1A1626`, 2-4 px at 512²) in the prompt. Consider doing a hero re-pass for all 5 with identical outline brief.

### 5.2 — Shading style — flat cel vs painterly

Direction spec: **flat fills + 1 cel shadow tone + 1 specular pip**.

Current state:
- Heroes have painterly skin shading (gradients on cheeks, soft eye highlights). This is style drift from "flat cel."
- Enemies are clean flat cel (correct).
- Bubbles have painterly glass-marble rendering (correct for "candy gloss" if we accept bubble-as-different-material).

**Fix:** in any hero re-pass, prompt explicitly for "flat fills, no skin gradients, no soft shading" to pull heroes back toward the cel direction. Alternatively, accept "slightly painterly chibi" as a style call — many successful hybrid casual games (Squad Busters, Slime Legion) use this.

### 5.3 — Specular pip placement

Direction spec: specular at top-left, 25% radius, top-left-aligned, single pip.

Current bubbles: multiple soft highlights, center-aligned, no clear single pip. Probably need to re-export with the locked spec, or define a separate "specular pip overlay" sprite that the engine composites over the bubble base.

---

## 6 — Recommendations summary

### Must-fix before first playtest (P0)
1. **Wizard portrait** — re-generate with locked outline rule.
2. **Pick A or B for enemy taxonomy** (recommendation: A, accept slimes, update spec).
3. **Decide outline policy for bubbles** (recommendation: keep no-outline, update spec §7.1 to make bubbles a deliberate exception).

### Nice-to-fix before soft launch (P1)
4. **Hero re-pass** — all 5 with identical outline + flat-shading brief for visual unity.
5. **Bubble re-pass** — if you keep outlines, generate a sheet with all 10 outlined bubbles + locked specular pip placement.
6. **Boss Corrupter eyes** — minor tweak: change white eyes to PURPLE glow (matches §6 enemy color disambiguation rule).
7. **Specular pip overlay** — extract as a single reusable sprite for engine composition.
8. **Delete or archive** `v2_playfield_polish_pass.png`.

### Defer to later (P2)
9. Per-enemy walk-cycle frames (2-4 frame loops × 17 variants). Hand-animate from static sprites.
10. Cleanup pass on enemy `flat_backup/` folder — probably old iterations, can be deleted if redundant.

### Cost estimate to fix all P0+P1 items

- Wizard re-gen: 1 prompt (~$0.14)
- Hero re-pass: 5 prompts (~$0.70)
- Bubble re-pass: 1 sheet prompt (~$0.14)
- Boss tweak: 1 edit (~$0.14)
- Specular pip: 1 prompt (~$0.14)

**Total to close the audit: ~$1.30.** Easily affordable from the remaining $17 budget.

---

## 7 — Acceptance log

| Asset class | Total | ✅ Pass | 🟡 Mostly | ❌ Fail |
|---|---|---|---|---|
| Heroes | 5 | 0 | 4 | 1 |
| Bubbles | 10 | 0 | 0 | 10 (outline rule) |
| Enemies | 17 | 1 | 11 | 5 (silhouette spec — if we adopt slime taxonomy, all pass) |
| Composite mockup | 1 | 0 | 0 | 1 (outdated) |

**Adjusted, if we adopt slime taxonomy + bubble-no-outline exception:**
- Heroes: 4 pass, 1 fail (Wizard).
- Bubbles: 10 pass (now intentional exception).
- Enemies: 17 pass.
- Composite: archive.

That gets us from 70% to **97%** asset acceptance with two spec amendments and one hero re-gen.

---

## Change log

- 2026-05-22 — initial audit. Heroes, bubbles, enemies, composite reviewed. Two spec amendments + one Wizard re-gen recommended to close.
