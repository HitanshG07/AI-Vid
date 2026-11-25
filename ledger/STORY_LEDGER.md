# Story Ledger — never repeat a rule, twist, or core meaning listed here

Two tables. The never-repeat check covers **both**.

- **Stories** — premises chosen for production. IDs start at `001`, are assigned in production order (next = highest ID in this table + 1), run contiguous, and are never reused or skipped. Evidence: `ledger/verification/<ID>.md`.
- **Verified ideas** — premises that were brainstormed or verified but not produced. They have **no story ID**; each is identified by a slug, with evidence in `ledger/verification/ideas/<slug>.md`. When one is chosen for production it gets the next story ID, its row moves to Stories, and its evidence file moves to `ledger/verification/<ID>.md`.

Story status flow: `Scripted` → `Produced` → `Posted`. Idea status: `Verified`, or `REJECTED` (a duplicate was found online, so it is never pitched again).

## Stories

| ID | Date | Title / Premise | World Rule | Twist | Format | Core Meaning | Status | YouTube URL | Final Duration | Stayed-to-Watch % | APV % | First Drop (s) |
| :-- | :-- | :-- | :-- | :-- | :-- | :-- | :-- | :-- | :-- | :-- | :-- | :-- |
| 001 | 2026-11-17 | In This Beach Town, Your First Brave Act Makes Your Outline Glow Gold | Gold outline on first true bravery | Lifeguard's glow came from calling for help; narrator lights up ringing the shore bell | Standalone | Courage is acting while still scared | Produced (final = take 10, 2026-11-18) |  |  |  |  |  |
| 002 | 2026-11-19 | In This Town, Every Footstep Glows With Heat — Blind Striders Hunt It | Footsteps glow with body heat 60 s; running blazes | Hot-sock decoy on the night van; Striders sink through the frozen lake; driver runs and is taken | Standalone | Sacrifice repaid — June carries the brother who burned his feet for her | Produced (final = 002_heat-footsteps_FINAL.mp4, 2026-11-19) |  |  |  |  |  |
| 003 | 2026-11-19 | In This Freezing Town, Every Tear Turns Into a Glass Key | Tears freeze into real glass keys; heartbreak scales key size | 5 years of held grief breaks into Master Key to save sister from Frost Vault Door 19 | 2-Part | True grief frees those we love | Produced (Take 14 Finalized: 2-Part Series Release: Part 1 114.57s with Outro Hook, Part 2 93.33s with Extended Watch Ticking Finale, 2026-11-20) |  |  |  |  |  |
| 004 | 2026-11-21 | Every Broken Promise Leaves a Mark | A red dot appears above your head when you break a promise | Lena gives up her school-show audition to finish the dance practice she promised Ben, and the dot goes out | Standalone | Follow through to repair a broken promise | Posted (2026-11-21, 004_FINAL.mp4, 56.27s) |  |  |  |  |  |
| 005 | 2026-11-22 | My Name Was on Her Forehead | One lifetime kiss, accepted within 24 hours, leaves a glowing name | Maya was waiting for Noah and accepts his kiss, revealing his name on her forehead | Standalone | Give each other time and take a chance | Posted (2026-11-22, 005_FINAL_LOCKER_RETAKE.mp4, 94.47s) |  |  |  |  |  |
| 006 | 2026-11-22 | Why Is Everyone Laughing? | Kai misses the bin with a candy wrapper; all day everyone laughs and backs away from him | The same wrapper was stuck to his shoe all day; he re-throws, misses, it sticks to the other shoe | Standalone | The problem you blame on everyone else can be stuck to you | Posted (2026-11-23, 006_FINAL.mp4 take 12, 44.2s) |  | 44.2s |  |  |  |

## Verified ideas (not produced, no story ID)

| Slug | Date | Title / Premise | World Rule | Twist | Format | Core Meaning | Status | Evidence |
| :-- | :-- | :-- | :-- | :-- | :-- | :-- | :-- | :-- |
| legacy-shadow-weight | 2026-11-14 | In This Town, Every Shadow Has Real Weight | Shadows weigh 500 lbs at sunset | Pocket mirror rescue | Standalone | Cleverness under pressure | Legacy test render (`stories/_test`), unverified | none |
| grandpa-taps | 2026-11-15 | My Grandpa Taps 3 Times on the Hallway Floor Every Night | Nightly ritual tapping | 1974 flood shelter Morse-code pipe | 2-Part | Grief looks like madness until you learn love's language | Verified | `ledger/verification/ideas/grandpa-taps.md` |
| lie-counter | 2026-11-15 | Everyone's Chest Shows Lies Left — Mine Says "-1" | Lie counter on chest | Overloads the Truth-Eater beast | 2-Part | Radical honesty | REJECTED | `ledger/verification/ideas/lie-counter.md` |
| nameplates | 2026-11-15 | Your Nameplate Fades When Nobody Says Your Name With Care | Fading nameplates | Janitor Arthur stadium chant | Standalone | No one is invisible if remembered | Verified | `ledger/verification/ideas/nameplates.md` |
| gratitude-lanterns | 2026-11-15 | Every "Thank You" Floats a Gold Lantern Above Your Roof | Gratitude lanterns | 10,000 anonymous lanterns over woods | Standalone | Generosity without credit | Verified | `ledger/verification/ideas/gratitude-lanterns.md` |
| heartbeat-aura | 2026-11-15 | Heartbeats Broadcast a Musical Aura | Audible heartbeat aura | Class clown's hidden speaker | Standalone | Loudest people hide heaviest silence | Verified | `ledger/verification/ideas/heartbeat-aura.md` |
| worst-shoe-day | 2026-11-22 | Why Is Everyone Laughing? | Missed-bin wrapper day of ridicule | Wrapper stuck to his own shoe; repeat miss | Standalone | Look at yourself before blaming others | Used as 006 | `ledger/verification/ideas/worst-shoe-day.md` |
| wrong-line | 2026-11-23 | You Cut the Wrong Line | A queue bully punches past fifty bystanders to steal the front display crate | The jackpot goes to the patient kid at the back; the front crate was 40 lbs of heavy road salt to haul away | Standalone | Selfish shortcuts leave you holding dead weight | Scrapped 2026-11-24 (produced as old 006, never posted; owner deleted) | `ledger/verification/ideas/wrong-line.md` |
| the-couch-ate-it | 2026-11-23 | Back Up, Ben | First shoe past the bedroom rug stripe wins the coin | Ben sidesteps Nia's block in the opening and crosses the finish before he knows there is a race | Standalone | The step everyone laughed at was the winning move | Scrapped 2026-11-24 (never finished; owner deleted) | `ledger/verification/ideas/the-couch-ate-it.md` |

The raw search results behind the idea evidence are in `ledger/verification/ideas/_raw_search_ideas.md`. The original idea evidence for the premises that became stories 002 and 003 is kept as `heat-footsteps_original-idea.md` and `glass-key-tears_original-idea.md` in the same folder.
