# Style Anchors: Gold-Standard Kid-Simple Roblox Shorts

The story writer (`pipeline/story_gen.py --auto`) and the judge read this file. Every new story must match these
three examples in **simplicity, voice and visual clarity**. The test suite also lints all three, so they must keep
passing Gate 1 and the kid-simple rules.

## The 8-Year-Old First-Try Test (all must be true)

1. **One-line visual rule** an 8-year-old gets in 2 seconds on mute: no maths, no steps, no "if... then... unless".
   Show it on screen in beat 1 or 2 (an overhead `counter:`, a prop, or a clear action).
2. **Everyday spoken English**: 5-9 words per line, at a 4th-grade level. At least 70% of beats are dialogue or
   reactions; never a dry narrator summary.
   Never use stiff or adult words: valedictorian, intimidation, corrupt, disqualified, official, enrolled, percent,
   championship, consequence, therefore, however, approximately, policy.
3. **Feelings, not policy**: family, friendship, survival, betrayal, or greed backfiring. No school-rules plots.
4. **Hook-first title**: `In This World, ...` or `In This Town, ...`, then the rule itself (max 60 characters).
5. **Uses what we can show**: our 6 sets (`school_yard`, `school_hallway`, `classroom`, `auditorium`, `living_room`,
   `street`), their spots, prop kits (`phone`, `banner`, `paper`, `podium`, `locker`) and the overhead
   `counter:` (bold, emoji-free, max 18 characters) that changes when the number changes.
6. **22 beats, about 2.4 s each**. Narrated objects are visible. Falls only on a fall/impact word (`fell`, `trip`,
   `slam` ...). Never repeat the previous episode's set.
7. **Fast faces + comic pops (V6.2 Engine Capability Contract)**: the rule must visibly happen with what the engine
   can do: `scale:` (0.2-2.5) for shrinking/growing, `invisible: true` for vanishing, `counter:` for numbers.
   Use 4-6 `face_mid:` swaps (the face changes halfway through the line) and 2-4 `overlay:` pops
   (`sweat`, `hearts`, `bubble` + `overlay_text` of 2-16 chars, `flash_red_blue`). Close-ups beat long walks.

---

## Anchor 1: "In This World, You Only Get 10 Words a Day"

```yaml
id: A01
format: story
set: living_room
title: In This World, You Only Get 10 Words a Day
description: Lily saved her last words for the one person who mattered.
bgm_mood: mystery
lighting: day_bright
engine: moral_dilemma
rule_type: speech_cost
opening_variant: rule_first
ending_type: emotional_payoff
rule: Everyone only gets 10 spoken words a day.
visible_proof: A number above every head counts down each word.
personal_stake: Mom leaves on the bus tonight for a whole year.
motivated_choice: Lily stays silent all day to save her words.
rule_payoff: Lily's last three words make Mom stay.
cta: What would you say with your last words?
cast:
  - { name: Lily, gender: girl,  default_face: neutral,    spot: center_rug, counter: "10 WORDS" }
  - { name: Max,  gender: boy,   default_face: grin,       spot: rug_right,  counter: "10 WORDS" }
  - { name: Mom,  gender: woman, default_face: neutral,    spot: at_door }
beats:
  - { dur: 2.4, cam: closeup,     motion: push_in, target: Lily, action: idle,  face: neutral,    speaker: narrator, sfx: ding, line: "Here, everyone gets ten *words* a day." }
  - { dur: 2.4, cam: ots,         motion: push_in, target: Max,  action: talk,  face: grin, counter: "3 WORDS", with: [{ name: Lily, action: idle, face: shocked }], speaker: boy, line: "Pizza, pizza, pizza, *pizza*!" }
  - { dur: 2.4, cam: closeup,     motion: push_in, target: Lily, action: recoil, face: shocked, face_mid: determined, overlay: bubble, overlay_text: "PIZZA?!", speaker: girl, line: "My brother wasted his words on *pizza*." }
  - { dur: 2.4, cam: wide,        motion: push_in, target: Mom,  action: walk,  spot: rug_left, face: scared, speaker: boy, line: "Mom is packing her big *suitcase*!" }
  - { dur: 2.4, cam: closeup,     motion: push_in, target: Mom,  action: talk,  face: neutral, face_mid: scared, speaker: woman, line: "My bus leaves tonight. One whole *year*." }
  - { dur: 2.4, cam: reverse_ots, motion: push_in, target: Lily, action: idle,  face: scared, with: [{ name: Mom, action: idle, face: scared }], speaker: girl, line: "I wanted to beg her to *stay*." }
  - { dur: 2.4, cam: closeup,     motion: static,  target: Lily, action: idle,  face: determined, speaker: girl, line: "So I didn't say a *word*." }
  - { dur: 2.4, cam: side_track,  motion: push_in, target: Max,  action: talk,  face: grin, counter: "1 WORD", speaker: boy, line: "Lily, say something! Say *anything*!" }
  - { dur: 2.4, cam: closeup,     motion: push_in, target: Lily, action: idle,  face: determined, speaker: girl, line: "I shook my head. Not *yet*." }
  - { dur: 2.4, cam: wide,        motion: push_in, target: Max,  action: point, face: grin, face_mid: shocked, counter: "0 WORDS", overlay: sweat, speaker: narrator, line: "Max used his last word. *Silence*." }
  - { dur: 2.4, cam: ots,         motion: push_in, target: Mom,  action: walk,  spot: at_door, face: scared, speaker: girl, line: "Wait, Mom! Not out that *door*!" }
  - { dur: 2.4, set: street, cam: wide, motion: push_in, target: Mom, action: walk, snap_spot: sidewalk_right, spot: bus_stop, face: scared, speaker: narrator, sfx: footsteps_wood, line: "The bus stop was cold and *dark*." }
  - { dur: 2.4, set: street, cam: wide, motion: push_in, target: Lily, action: run, snap_spot: sidewalk_left, spot: crosswalk, face: determined, speaker: girl, line: "I ran after her as fast as *ever*." }
  - { dur: 2.4, set: street, cam: closeup, motion: push_in, target: Mom, action: idle, face: shocked, speaker: woman, line: "Lily? You came all this *way*?" }
  - { dur: 2.4, set: street, cam: reverse_ots, motion: push_in, target: Lily, action: idle, face: scared, with: [{ name: Mom, action: idle, face: shocked }], speaker: girl, line: "Ten words saved. I needed only *three*." }
  - { dur: 2.4, set: street, cam: closeup, motion: static, target: Lily, action: talk, face: determined, counter: "7 WORDS", pause_before: 0.3, speaker: girl, line: "Please don't *go*." }
  - { dur: 2.4, set: street, cam: closeup, motion: push_in, target: Mom, action: recoil, face: shocked, speaker: narrator, line: "Mom dropped her suitcase right *there*." }
  - { dur: 2.4, set: street, cam: ots, motion: push_in, target: Lily, action: talk, face: proud, counter: "4 WORDS", speaker: girl, line: "I love you, *Mom*." }
  - { dur: 2.4, set: street, cam: closeup, motion: push_in, target: Mom, action: talk, face: proud, speaker: woman, line: "Then I'm not getting on that *bus*." }
  - { dur: 2.4, set: street, cam: wide, motion: push_in, target: Mom, action: walk, spot: sidewalk_left, face: proud, with: [{ name: Lily, action: idle, face: proud }], speaker: narrator, line: "The bus left without her that *night*." }
  - { dur: 2.4, set: street, cam: low_hero, motion: push_in, target: Lily, action: wave, face: proud, speaker: girl, line: "I still had four words for *tomorrow*." }
  - { dur: 2.4, set: street, cam: high_angle, motion: pull_out, target: Lily, action: cheer, face: proud, with: [{ name: Mom, action: wave, face: proud }], sfx: resolution_chord, bgm_climax: true, speaker: narrator, line: "Save your words for the people you *love*." }
```

---

## Anchor 2: "In This Town, a Number Shows Every Lie You Tell"

```yaml
id: A02
format: story
set: school_hallway
title: In This Town, a Number Shows Every Lie You Tell
description: Ben told one lie to his best friend, and everyone saw it.
bgm_mood: mystery
lighting: day_bright
engine: social_karma
rule_type: perception
opening_variant: consequence_first
ending_type: karma_reversal
rule: A number above your head counts every lie you tell.
visible_proof: Ben's number jumps the second he lies.
personal_stake: Mia is Ben's only best friend.
motivated_choice: Ben finally tells the truth in front of everyone.
rule_payoff: The truth sends the bully's number flying up instead.
cta: Would you tell the truth if it cost you?
props:
  - { name: MiaPhone, kit: phone, text: "MIA", attach: "Rex/Right Arm", hide: true }
cast:
  - { name: Ben, gender: boy,  default_face: neutral, spot: hall_center,  counter: "LIES: 0" }
  - { name: Mia, gender: girl, default_face: neutral, spot: locker_left,  counter: "LIES: 0" }
  - { name: Rex, gender: boy,  default_face: grin,    spot: locker_right, counter: "LIES: 12" }
beats:
  - { dur: 2.4, cam: closeup,     motion: push_in, target: Ben, action: idle,  face: shocked, counter: "LIES: 1", speaker: boy, sfx: ding, line: "My number went up. Everyone *saw*." }
  - { dur: 2.4, cam: wide,        motion: push_in, target: Mia, action: idle,  face: neutral, speaker: narrator, line: "In this town, lies float over your *head*." }
  - { dur: 2.4, cam: closeup,     motion: push_in, target: Rex, action: talk,  face: grin, speaker: villain, line: "Twelve lies and I'm still *winning*." }
  - { dur: 2.4, cam: ots,         motion: push_in, target: Mia, action: talk,  face: scared, with: [{ name: Ben, action: idle, face: neutral }], speaker: girl, line: "Ben, my phone is gone! Help *me*!" }
  - { dur: 2.4, cam: closeup,     motion: push_in, target: Ben, action: idle,  face: scared, speaker: boy, line: "I saw Rex grab it at *lunch*." }
  - { dur: 2.4, cam: side_track,  motion: push_in, target: Rex, action: walk,  spot: hall_entry, face: grin, prop: [{ name: MiaPhone, show: true }], speaker: narrator, line: "He was holding it right *now*." }
  - { dur: 2.4, cam: closeup,     motion: push_in, target: Rex, action: point, face: grin, speaker: villain, line: "Tell her and you're *next*, Ben." }
  - { dur: 2.4, cam: reverse_ots, motion: push_in, target: Ben, action: idle,  face: scared, with: [{ name: Mia, action: idle, face: scared }], speaker: girl, line: "Did you see who took *it*?" }
  - { dur: 2.4, cam: closeup,     motion: static,  target: Ben, action: talk,  face: scared, counter: "LIES: 2", speaker: boy, line: "No. I didn't see *anything*." }
  - { dur: 2.4, cam: closeup,     motion: push_in, target: Mia, action: recoil, face: neutral, face_mid: shocked, overlay: sweat, speaker: boy, sfx: heartbeat, line: "Mia looked up at my *number*." }
  - { dur: 2.4, cam: ots,         motion: push_in, target: Mia, action: talk,  face: scared, with: [{ name: Ben, action: idle, face: scared }], speaker: girl, line: "You just lied to me. *Why*?" }
  - { dur: 2.4, cam: wide,        motion: push_in, target: Mia, action: walk,  spot: door_left, face: scared, speaker: boy, line: "She walked away from me *crying*." }
  - { dur: 2.4, cam: closeup,     motion: push_in, target: Ben, action: idle,  face: scared, speaker: boy, line: "My best friend. Gone over one *lie*." }
  - { dur: 2.4, cam: low_hero,    motion: push_in, target: Ben, action: run,   spot: hall_entry, face: determined, speaker: boy, sfx: footsteps_wood, line: "So I ran straight to *Rex*." }
  - { dur: 2.4, cam: ots,         motion: push_in, target: Ben, action: point, face: determined, with: [{ name: Rex, action: idle, face: shocked }], speaker: boy, line: "Rex has your phone! I *saw* him!" }
  - { dur: 2.4, cam: closeup,     motion: push_in, target: Rex, action: talk,  face: grin, face_mid: scared, counter: "LIES: 13", speaker: villain, line: "That's not true! I never touched *it*!" }
  - { dur: 2.4, cam: closeup,     motion: shake,   target: Rex, action: recoil, face: shocked, counter: "LIES: 50", speaker: narrator, sfx: bass_hit, line: "His number shot all the way *up*." }
  - { dur: 2.4, cam: wide,        motion: push_in, target: Mia, action: walk,  spot: hall_center, face: shocked, with: [{ name: Rex, action: idle, face: scared }], speaker: narrator, line: "Mia came back and saw *everything*." }
  - { dur: 2.4, cam: closeup,     motion: push_in, target: Rex, action: talk,  face: scared, scale: 0.7, prop: [{ name: MiaPhone, hide: true }], speaker: villain, line: "Fine! Take your stupid phone *back*!" }
  - { dur: 2.4, cam: reverse_ots, motion: push_in, target: Mia, action: talk,  face: proud, with: [{ name: Ben, action: idle, face: scared }], speaker: girl, line: "You told the truth. That's what *counts*." }
  - { dur: 2.4, cam: closeup,     motion: push_in, target: Ben, action: talk,  face: proud, speaker: boy, line: "I'm sorry I lied to *you*." }
  - { dur: 2.4, cam: high_angle,  motion: pull_out, target: Ben, action: cheer, face: proud, with: [{ name: Mia, action: cheer, face: proud }], overlay: hearts, sfx: resolution_chord, bgm_climax: true, speaker: narrator, line: "One truth fixed what one lie *broke*." }
```

---

## Anchor 3: "In This World, Touching Anything Red Freezes You Forever"

```yaml
id: A03
format: story
set: school_yard
title: In This World, Touching Red Freezes You Forever
description: The bully dared Tom to touch the red wall. Big mistake.
bgm_mood: mystery
lighting: day_bright
engine: ironic_reframe
rule_type: curse
opening_variant: consequence_first
ending_type: karma_reversal
rule: If you touch anything red, you freeze forever.
visible_proof: A frozen kid stands stiff beside the red brick wall.
personal_stake: Tom's little sister Rosa is new and scared.
motivated_choice: Tom refuses the dare and protects his sister.
rule_payoff: The bully leans on the red wall to laugh and freezes.
cta: Would you take the dare?
cast:
  - { name: Tom,  gender: boy,  default_face: neutral, spot: court_center }
  - { name: Rosa, gender: girl, default_face: scared,  spot: court_hoop }
  - { name: Rex,  gender: boy,  default_face: grin,    spot: entry_walk }
beats:
  - { dur: 2.4, cam: wide,        motion: push_in, target: Rex,  action: idle,  face: grin, counter: "RED = FREEZE", speaker: narrator, sfx: ding, line: "Touch anything red, and you freeze *forever*." }
  - { dur: 2.4, cam: closeup,     motion: push_in, target: Tom,  action: idle,  face: scared, speaker: boy, line: "And our whole school was red *brick*." }
  - { dur: 2.4, cam: ots,         motion: push_in, target: Rosa, action: talk,  face: scared, with: [{ name: Tom, action: idle, face: neutral }], speaker: girl, line: "Tom, I'm scared. Don't leave *me*." }
  - { dur: 2.4, cam: closeup,     motion: push_in, target: Tom,  action: talk,  face: determined, speaker: boy, line: "Stay close. Never touch the *walls*." }
  - { dur: 2.4, cam: wide,        motion: push_in, target: Rex,  action: walk,  spot: court_center, face: grin, speaker: boy, sfx: footsteps_wood, line: "Oh no. Here comes Rex, *grinning*." }
  - { dur: 2.4, cam: closeup,     motion: push_in, target: Rex,  action: talk,  face: grin, speaker: villain, line: "New girl! Touch the wall, I *dare* you." }
  - { dur: 2.4, cam: closeup,     motion: push_in, target: Rosa, action: recoil, face: scared, overlay: sweat, speaker: boy, sfx: heartbeat, line: "Look at Rosa. She is shaking *hard*." }
  - { dur: 2.4, cam: ots,         motion: push_in, target: Tom,  action: block, face: determined, with: [{ name: Rex, action: idle, face: grin }], speaker: boy, line: "Leave my sister alone, *Rex*." }
  - { dur: 2.4, cam: closeup,     motion: push_in, target: Rex,  action: talk,  face: grin, speaker: villain, line: "Then you do it, *chicken*." }
  - { dur: 2.4, cam: closeup,     motion: static,  target: Tom,  action: idle,  face: determined, speaker: boy, line: "Everyone was watching *me*." }
  - { dur: 2.4, cam: closeup,     motion: push_in, target: Tom,  action: talk,  face: determined, speaker: boy, line: "No. I'm not touching *it*." }
  - { dur: 2.4, cam: side_track,  motion: push_in, target: Rex,  action: walk,  spot: school_entry, face: grin, speaker: narrator, line: "Rex walked right up to the *wall*." }
  - { dur: 2.4, cam: closeup,     motion: push_in, target: Rex,  action: talk,  face: grin, speaker: villain, line: "Watch me get super close, *babies*." }
  - { dur: 2.4, cam: wide,        motion: push_in, target: Rex,  action: point, face: grin, speaker: boy, line: "He pointed and laughed at *us*." }
  - { dur: 2.4, cam: closeup,     motion: shake,   target: Rex,  action: recoil, face: grin, face_mid: shocked, speaker: narrator, sfx: impact_whoosh, line: "Then he leaned back to *laugh*." }
  - { dur: 2.4, cam: low_hero,    motion: shake,   target: Rex,  action: idle,  face: shocked, counter: "FROZEN", speaker: narrator, sfx: bass_hit, line: "His back hit the red *brick*." }
  - { dur: 2.4, cam: closeup,     motion: static,  target: Rex,  action: idle,  face: shocked, speaker: narrator, line: "He couldn't move a single *finger*." }
  - { dur: 2.4, cam: ots,         motion: push_in, target: Rosa, action: talk,  face: shocked, overlay: bubble, overlay_text: "HE FROZE!", with: [{ name: Tom, action: idle, face: neutral, face_mid: shocked }], speaker: girl, line: "He froze! He really *froze*!" }
  - { dur: 2.4, cam: closeup,     motion: push_in, target: Tom,  action: talk,  face: determined, face_mid: proud, speaker: boy, line: "That's what dares get *you*." }
  - { dur: 2.4, cam: wide,        motion: push_in, target: Tom,  action: walk,  spot: court_hoop, face: proud, with: [{ name: Rosa, action: walk, face: proud }], speaker: boy, line: "We walked away, hand in *hand*." }
  - { dur: 2.4, cam: closeup,     motion: push_in, target: Rosa, action: talk,  face: proud, overlay: hearts, speaker: girl, line: "You're the best big brother *ever*." }
  - { dur: 2.4, cam: high_angle,  motion: pull_out, target: Rex, action: idle, face: shocked, sfx: resolution_chord, bgm_climax: true, speaker: narrator, line: "Some dares are better left *untouched*." }
```
