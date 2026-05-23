# Pop Brigade v2 — Open Questions

What's still undecided. Decided items moved to `README.md` § Locked design decisions.

---

## Locked since last revision

- ✅ Wave-based structure with [10, 6, 6, 6, 6] move budget.
- ✅ Static gate per wave (no sky drops).
- ✅ 5-wave boss-gated run, ~5 min target session.
- ✅ World 1 boss: The Corrupter (gate corruption mechanic).
- ✅ **Corrupter minion support: light minions** (1 RED Walker every 15s, first spawn 10s after boss arrival, closed-column biased).
- ✅ Color frenzy: clear-all-of-color, per-wave, +50% damage rest of wave.
- ✅ Cross-run carry-over: hero collection unlocks; per-run hero stats reset.
- ✅ Class roster: Fire Knight, Ice Mage, Archer, Druid, Wizard.
- ✅ Hero rarity: Common/Rare/Epic/Legendary via gacha + shard rank-ups.
- ✅ Hero ultimates: manual trigger, per-class effect.
- ✅ Class synergies: 3+ and 5+ on row 0.
- ✅ Status effects: Slow, Freeze, Burn, Poison, Stun.
- ✅ Gate reset between waves (no carry-over of gate state).
- ✅ Heroes between waves: persist as-is (HP preserved, dead heroes stay dead).
- ✅ Cannon miss attaches as new bubble (standard bubble shooter).
- ✅ Spawn column bias toward closed columns: medium (0.7).
- ✅ Drag UX: hero hitbox priority + cannon dim during drag.
- ✅ **Energy system: keep, with A/B test plan.** 10 energy per run, regens 1/5min, cap 100. Soft launch A/B tests "on" vs "off" — if D7 retention drops > 5pp in "on" cohort, remove.
- ✅ **No universal hero shards for launch.** Re-evaluate post-launch if pull-variance frustration shows up in metrics. See `economy.md` §3.5.
- ✅ **World 2 unlocks at stage 30 first clear only** — no secondary level/rarity gate. See `progression.md` §1.1.
- ✅ **Out-of-moves behavior: heroes finish the job.** Move budget is a strategy constraint, not a kill switch. See `design-spec.md` §5.4.
- ✅ **Status effect cap per enemy: no cap.** With 5 statuses × 5 classes the worst case is 5 simultaneous statuses — not chaotic enough to cap. See `combat-design.md` §7.3.
- ✅ **Ultimate gauge persists across waves within a run.** Resets on hero death and at run end. See `combat-design.md` §6.3.

---

## High-impact (resolve before prototype)

### Q2. Wizard manual targeting UX

Wizard can manually target an enemy via tap-and-hold. But tap-and-hold could conflict with cannon aim or hero drag.

- **Tap-and-hold on enemy sprite:** if no other UI is being touched, sets Wizard's target. Risk: precision issues on small enemy sprites.
- **Tap Wizard portrait first, then tap target:** explicit two-tap selection. Less elegant but unambiguous.
- **Auto-target only:** drop manual targeting entirely. Wizard always picks furthest open-column enemy.

Recommendation: **Tap Wizard portrait first, then tap target.** Two-tap is clear, doesn't conflict with cannon aim, makes Wizard's special feel intentional.

---

## Medium-impact (resolve during prototype tuning)

### Q7. Damage display

When a hero hits an enemy, show damage numbers?
- **Yes, all hits:** visual chaos in late waves but feedback-rich.
- **Yes, but only crits/executes/synergy bonuses:** clean UI, highlights special moments.
- **No damage numbers:** just HP bars on enemies.

Recommendation: **Special moments only.** Crits, executes, ultimates, synergy-boosted hits, frenzy hits show numbers. Regular hits show only HP bar depletion. Best of both worlds.

### Q8. Loadout edit between waves

Should the player be able to edit loadout mid-run (between waves)?
- **No (default):** loadout locked at run start.
- **Yes, free swap during intermissions:** strategic depth.
- **Yes, costs gems:** monetized convenience.

Recommendation: default. Loadout choice is a pre-run commitment. Mid-run flexibility undermines the choice.

---

## Low-impact (defer to playtesting)

### Q9. Difficulty scaling per session history

Veteran vs new player calibration:
- **Pure reset (default):** every run identical regardless of history.
- **Cohort scaling:** veterans get slightly tougher early waves.

Recommendation: default for prototype. Add scaling if veterans report "stages too easy" in metrics.

### Q12. Intermission UX

5-second pause between waves shows:
- Wave result + next wave preview + hero status + tap-to-continue (default).
- Auto-advance after 5s.
- Tap-to-continue with no time limit.

Recommendation: tap-to-continue with optional 10s auto-skip. Lets impatient players speed up, patient players breathe.

### Q13. Reward animation length

Per industry norm, gacha/chest reward animations are 2-4 seconds. Speed-up option?
- **Tap to skip animation:** standard, lets veterans speed through.
- **Hold to skip:** prevents accidental skips.
- **Setting toggle:** always-skip option in settings.

Recommendation: **Tap to skip + setting toggle to default-skip.** Both options available.

---

## Out of scope for v2 design phase

- Detailed economy live-ops tuning (left to economy team post-launch).
- World 3+ design (only World 1 fully specified; World 2 partial).
- Cross-platform sync.
- Cloud saves.
- Social/clan systems.
- PvP modes.
- Streaming / replay sharing.
- Localization beyond launch language.

These get addressed once v2 core loop is validated in prototype playtesting.
