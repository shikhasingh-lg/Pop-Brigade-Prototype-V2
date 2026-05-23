# Pop Brigade v2 — Concept

## Elevator pitch

You stand behind a wall of bubbles. Enemies march at you from the horizon. The wall is the only thing keeping them off your heroes — and the wall is built of the same bubbles you're trying to pop to free more heroes. Every match is a tradeoff: open a lane, your hero shoots through it, but so do the enemies.

## The gate metaphor

The whole game collapses into one mental model: **the gate**.

- The gate is a vertical bubble wall at mid-depth of the playfield.
- At the start of each wave, the gate is seeded with a fresh bubble cluster.
- Enemies approach from beyond the gate along a depth rail.
- A **closed lane** of the gate blocks enemies in that column.
- A **popped lane** lets enemies through — and lets your heroes shoot through.
- Hero bubbles embedded in the gate, when popped, drop a hero down to your row 0.

Each wave gives you a fixed move budget (10 for wave 1, then 6 per wave). The gate does not refill during a wave. What you start with is what you have, minus your pops, minus what enemies bash through.

Three pressures, one wall, finite moves:
1. **Pop to free heroes.** (You want to pop.)
2. **Pop to clear shooting lanes for the heroes you have.** (You want to pop.)
3. **Don't pop too much or enemies pour through.** (You want NOT to pop.)
4. **You only have N moves.** (Every pop is a real choice.)

The strategy lives in resolving those forces in real time, under a hard move budget.

## What the screen looks like

```
   ☁    ●  ●  ●  ●  ●  ●     ☁     ← sky, bubbles drop from here
   ☁     ●   H  ●  ●  ●
          ●   ●  ●  H  ●            ← GATE (mid-depth bubble wall)
          ●   ●  ●  ●  ●  ●
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━     ← gate base (where enemies are blocked)

               e   e   e             ← far enemies on horizon (small)
                 e   e
               e   e   e
                                     ← they walk forward toward gate

         🛡    🏹   ❄    🛡          ← hero row (between gate and cannon)

                ⊕                    ← cannon (player POV, fires up into gate)
```

Portrait orientation. Pseudo-3D: enemies scale up as they approach. The gate is a flat 2D plane (bubble-shooter physics unchanged). The cannon is 2D at the bottom. Only the enemy lane is depth-projected.

## Why this works as a hybrid casual game

| Hybrid casual must-have | How v2 delivers |
|---|---|
| One-thumb readable | Cannon aim is the only required input. Hero drag is an optional layer. |
| 30s session is satisfying | Restacking bubbles + continuous enemy pressure = no setup time, instant action. |
| 3-loop depth (core / meta / progression) | Core = gate management. Meta = hero collection + merge. Progression = stage clears + hero tier-ups. |
| Creative-friendly | "Defend the gate" reads in 3 seconds. UA hook is the wall + the enemies. |
| Differentiation | Bubble shooters don't have a tower-defense layer. TD games don't have a bubble wall. The gate is the unique mechanic. |

## What changed from v1's pitch

v1: "Bubble shooter where popping frees heroes who then defend in a separate combat phase." Two minigames, switched between by a phase boundary. Move budget governed Phase 1 only.

v2: "Bubble wall is the battlefield. Heroes defend behind it. Popping it is a tradeoff, not just an objective." One unified loop, no mode switch. Move budget governs the whole wave — every pop competes with itself for three different jobs (free heroes / open lanes / hold the wall).

## Core fantasy

You are the cannon operator on a wall under siege. The wall is alive — bubbles keep dropping. Your job is to break the wall surgically: enough to free heroes, enough to give them firing lanes, but not so much that the horde pours through.

It's a tug-of-war, not a race.
