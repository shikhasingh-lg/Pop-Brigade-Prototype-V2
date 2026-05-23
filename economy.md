# Pop Brigade v2 — Economy

Currencies, sources, sinks, IAP, gem velocity. Designed for hybrid casual D30 retention + reasonable monetization without pay-to-win.

> **Principle:** every currency has at least 2 sources and 2 sinks. No dead-end currencies. Premium currency (gems) is the only currency that benefits from IAP — soft currency must be earnable.

---

## 1 — Currency catalog

| Currency | Type | IAP-able? | Cap | Purpose |
|---|---|---|---|---|
| **Coins** | Soft | No | 999,999 | General upgrade currency, cosmetics |
| **Gems** | Hard | Yes | None | Gacha, energy refill, time-skips, cosmetic premium |
| **Hero Shards** | Per-hero | No (indirectly via gacha duplicates) | None | Hero rank-ups |
| **Energy** | Time-gated | Yes (refill purchasable) | 100 | Stage entry cost |
| **Event Currency** | Event-only | No | None (expires post-event) | Event banner + event shop |
| **Boss Tokens** | Prestige | No | None | Cosmetic exclusives |
| **Player XP** | Progression | No | None | Player level + battle pass |

---

## 2 — Coins

### 2.1 — Sources

| Source | Amount | Frequency |
|---|---|---|
| Wave-clear coins | 5–50 (stage-scaled) | Per wave, per run |
| Run-clear chest | 50–1000 (chest-tier dependent) | Per run end |
| Daily quest completion | 20–100 per quest | 4 quests / day |
| Weekly quest completion | 200–800 per quest | 5 quests / week |
| Daily login | 100 coins on Day 2 | Daily |
| First-clear stage bonus | 50–500 | One-time per stage |
| Selling duplicates (Common only) | 10 coins per Common | As needed |

### 2.2 — Sinks

| Sink | Cost |
|---|---|
| Cosmetic frames | 500–5000 coins each |
| Cosmetic hero skins | 2000–8000 coins each |
| Stage retry skip (cosmetic streak protection) | 100 coins per retry |
| Battle pass tier skip (free track) | 200 coins per tier |
| Daily refresh of trial stage | 200 coins |

**Note:** coins do NOT upgrade hero stats directly. That's hero shards (§3). Coins are mostly a cosmetic + convenience currency. This keeps coins always-relevant without making them gate combat power.

### 2.3 — Coin velocity targets

- Daily-active player earns: ~1000 coins / day average
- Daily-active player spends: ~500–800 coins / day average
- Net: ~200-500 coin surplus / day, builds up for cosmetic splurges or event sinks

---

## 3 — Hero Shards

### 3.1 — Shard taxonomy

Hero shards are **class + rarity scoped**. A "Common Fire Knight shard" can only rank up the Common Fire Knight. Cannot convert across classes or rarities (in v2 base — see Q below).

### 3.2 — Sources

| Source | Amount | Notes |
|---|---|---|
| Gacha duplicate | Shards = base rarity value (Common=1, Rare=3, Epic=10, Legendary=50) | Auto-converted on pull |
| Daily quest | 1–5 random shards | Random class roll |
| Weekly quest | 5–20 random shards | Random class roll |
| Run-clear chest | 1–25 (tier-scaled) | Random class roll |
| Event shop | Variable | Event currency |
| Direct purchase | 100 gems = 5 of a chosen Common shard | Gem sink, no Rare+ direct purchase |

### 3.3 — Sinks

Only one sink: ranking up heroes.

| Rank-up | Shard cost |
|---|---|
| Rank 1 → 2 | 5 shards |
| Rank 2 → 3 | 15 shards |
| Rank 3 → 4 (max) | 50 shards |

Per-hero copy. Each hero you own has its own rank track.

### 3.4 — Shard velocity

Players should reach Rank 2 on their starter hero within ~3 sessions, Rank 3 within ~10 sessions. Rank 4 is a long-tail goal (~30–50 sessions) and intended to feel meaningful.

### 3.5 — Open question — universal shards?

Should "Universal Shards" exist that can be converted to any class+rarity? Pros: anti-frustration for unlucky pulls. Cons: dilutes per-hero collection feeling. Default: NO universal shards. Re-evaluate post-launch.

---

## 4 — Gems

### 4.1 — Sources

| Source | Amount | Frequency |
|---|---|---|
| Player level-up | 10–50 (level-scaled) | Each level |
| Stage first-clear bonus | 20–100 (milestone) | One-time per stage |
| Boss first-clear | 500 | One-time per world |
| Daily login (Day 1) | 10 | Daily cycle |
| Weekly quest milestone | 50–100 | Weekly cap |
| Achievements | 25–500 (achievement-scaled) | One-time |
| Battle pass (both tracks) | Variable per tier | Seasonal |
| IAP | Variable | On-demand |
| Special offers | Bonus on first purchases | One-time |

### 4.2 — Sinks

| Sink | Cost |
|---|---|
| Single gacha pull | 300 gems |
| 10-pull | 2700 gems |
| Energy refill (full) | 50 gems |
| Battle pass tier skip | 200 gems |
| Stage hint (show optimal first move) | 10 gems per stage |
| Time-skip on energy regen | 5 gems per 10 minutes |
| Cosmetic premium frames | 500–2000 gems |
| Hero shard direct purchase (Common only) | 100 gems = 5 shards |

### 4.3 — Gem velocity targets (free player)

- Daily-active free player: ~40–80 gems / day
- Days to one 10-pull (2700 gems): ~35–60 days as F2P
- Days to a Legendary (pity 100 pulls): ~10–15 months as F2P
- Whale player can hit Legendary in week 1 via IAP

This is on the generous side for hybrid casual — keeps F2P engagement without trivializing IAP value.

---

## 5 — Energy

### 5.1 — Mechanic

- Cap: 100.
- Regen: 1 energy per 5 minutes (full refill: 8 hr 20 min).
- Run cost: 10 energy per stage entry.
- Effective free runs without refill: 10 / day from regen + 3 daily energy-free runs = 13 free runs / day.

### 5.2 — Refill sources

- Time (passive regen).
- Gem purchase (50 gems = full refill, up to 5× per day).
- Daily login on certain days (Day 7: 1 free full refill).
- Event reward.

### 5.3 — Anti-burnout flag

Energy systems can kill early retention. **A/B test from soft launch:** measure D7 retention with energy ON vs OFF. If energy hurts D7 by > 5pp, remove it and switch to attempt-based daily cap (e.g. unlimited play, but only first 20 runs per day give meaningful rewards).

---

## 6 — Event currency

### 6.1 — Mechanic

- Events drop their own scoped currency.
- Earned by completing event objectives during the event window.
- Spent in event-only shops on event-exclusive rewards.
- **Expires** when event ends (typically 7-14 days).

### 6.2 — Why scoped + expiring?

- Forces event engagement (FOMO).
- Prevents whales from stockpiling across events.
- Lets us tune per-event reward structure independently.

### 6.3 — Conversion

- 5% of unspent event currency converts to gems when event ends (consolation).
- Hero shards earned from event drops do NOT expire.

---

## 7 — Boss Tokens

### 7.1 — Mechanic

- Earned from boss kills only (1 per kill at default, 2 for first kill of a new world).
- No other source.
- Sink: cosmetic exclusives. Prestige frames, victory poses, hero portraits.

### 7.2 — Why?

Cosmetics earned by gameplay achievement (not currency exchange) feel more valuable. Gives boss kills a unique reward beyond chest contents.

---

## 8 — IAP catalog

### 8.1 — One-time offers

| Offer | Price | Contents |
|---|---|---|
| **Starter pack** | $0.99 | 500 gems + 1 Epic hero of choice (one-time only, first 7 days) |
| **Daily deal** | $1.99 | 200 gems + 5 hero shards (rotates daily) |
| **Newcomer 10-pull** | $4.99 | Discounted 10-pull worth ~2700 gems, Epic guaranteed |

### 8.2 — Gem packs

| Pack | Price | Gems | Bonus |
|---|---|---|---|
| Small | $0.99 | 80 | — |
| Medium | $4.99 | 500 | +10% |
| Large | $9.99 | 1200 | +20% |
| XL | $19.99 | 2700 | +30% (1 10-pull worth) |
| XXL | $49.99 | 7500 | +40% |
| Whale | $99.99 | 17000 | +50% |

### 8.3 — Subscription (battle pass + monthly bundle)

| Sub | Price | Contents |
|---|---|---|
| **Premium battle pass** | $9.99 / season | Premium track unlocked + 300 gems instant |
| **Monthly gem boost** | $9.99 / month | 50 gems / day for 30 days (1500 total = +50% value) |

### 8.4 — Event packs

- Event-exclusive bundles tied to live ops. Variable pricing $4.99–$29.99.
- Always include: event currency + cosmetic + hero shards relevant to event.

---

## 9 — Reward dispenser pacing

Hybrid casual best practice: never let the player go more than ~3 minutes without a reward animation.

| Pacing beat | Source |
|---|---|
| Every wave-clear | Coins, possibly hero shard |
| Every run-clear | Chest opening animation |
| Every 5 levels | Player level-up celebration |
| Every gacha pull | Animation regardless of result |
| Every battle pass tier | Reward burst |
| Every daily login | Reward burst |

This is more for the UI/animation team than mechanical design, but the slot for it must exist in the loop.

---

## 10 — Anti-pay-to-win guardrails

- No combat-power IAP exclusive to paid players (everything is in the free pool eventually).
- Legendary heroes available via F2P pity at 100 pulls.
- Stage difficulty is gated by hero rank, not raw stat — skilled play with low-rank heroes can clear stages.
- Energy refills give MORE attempts, not better attempts.
- PvP (if added later) uses normalized stats — collection breadth matters, not raw power.

---

## 11 — Live-ops levers

The economy team can tune in real time:
- Gacha rates (e.g. +1% Legendary during anniversary).
- Daily quest rewards (boost coins by 50% during retention dip).
- Energy regen speed (boost during weekend events).
- Battle pass XP rate (catch-up bonus week 4).
- IAP bundle composition (rotate offerings).
- Event currency drop rate.

These are config-driven, not code-driven. The remote config service should support per-flag rollback.

---

## 12 — Metrics to track post-launch

| Metric | Target |
|---|---|
| ARPDAU (avg revenue / daily active user) | $0.20–$0.50 (hybrid casual range) |
| Conversion rate (% F2P → first IAP) | 3–5% |
| D1 retention | 40%+ |
| D7 retention | 18%+ |
| D30 retention | 8%+ |
| Median runs/session | 3 |
| Median session length | 8 min |
| Energy refill purchase rate | 5–10% of DAU |
| Gacha pulls / paying user / week | 8–15 |

These are aspirational targets, not commitments. Tune against early soft launch data.
