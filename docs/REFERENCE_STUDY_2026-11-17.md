# Reference study: how others make "In This Town / In This World" Roblox shorts (2026-11-17)

Audience: the AI-Vid repo owner, and afterwards a GPT or Gemini model that has never seen this project or these videos.

Terms used below:
- **AI-Vid** is this repository. It makes original Roblox story shorts (1080x1920, at most 60 s per part, first-person voice-over, a "world rule plus twist" story) for YouTube Shorts, Instagram Reels and TikTok.
- **Studio** is Roblox Studio, the free Roblox game editor. **Studio MCP** is the connection Roblox built into Studio that lets an AI agent place parts, run Luau code (Roblox's scripting language) and take screenshots.
- **Argon** is the external AI (Gemini) that AI-Vid uses to build characters, props and sets to one locked style. **MANIFEST.md** is the per-story build specification AI-Vid writes before production.
- **Beat** is one planned shot in `beats.json`. **Cut** is a visible change of shot in the finished video.
- **Skill** means a packaged instruction file that Claude Code or Claude.ai loads on request. **Kit** is the word the reference creators use for their downloadable skill plus helper files.
- All numbers cite their source: a transcript timestamp, a frame number, a contact-sheet tile, or an ffmpeg measurement. "Not shown" means the video neither shows nor says it.

---

## 1. Summary

**What the references turned out to be.** Fourteen links were given. Eight could be studied: six tutorials (links 01 to 06) and two finished shorts (07, 09). Six Instagram reels (08, 10, 11, 12, 13, 14) could not be downloaded and were not studied. The tutorials are not all about Roblox "In This Town" videos, and they do not all use Roblox:

- Link 01 teaches a Claude.ai chat workflow for flat 2D and cartoon-3D **history-fact** shorts (the Pig War of 1859, Emperor Norton). It has nothing to do with Roblox or the "In This Town" format.
- Link 05 builds Roblox-**looking** blocky characters in a browser (React plus Three.js, per its description). No Roblox Studio is involved.
- Links 03 and 06 use real Roblox Studio driven by Claude Code, the same family of method as AI-Vid.
- Links 02 and 04 render with Blender, driven by an AI agent through code.

**Distinct methods found (four):**
1. **Studio plus Studio MCP** (links 03 and 06). Claude Code builds and animates the scene inside Studio and the creator screen-records it. This is the same family as AI-Vid.
2. **Blender scripted by an agent** (links 02 and 04). One variant is a free local kit (Python, Blender, ffmpeg, Edge-TTS). The other leans on a paid hosted service (Flashloop) for assets and voice.
3. **Claude-only generation without Studio or Blender** (links 01 and 05). Claude writes its own small renderer, either in its chat sandbox (01) or as a browser React/Three.js engine (05).
4. **Hosted apps sold alongside the tutorials** (Ovra in 03, CreatorIQ in 02, Flashloop in 04). These are product pitches, not separate methods. They are described in the method sections where they appear.

**Main conclusions:**
- AI-Vid's method (Studio plus Studio MCP, Argon assets, voice and captions by script, ffmpeg finish) is the same family as the highest-quality method shown (03, and the "best quality" route 05 names). Nothing shown beats it on look or originality control. No tutorial shows an originality check; all of them rely on the creator to pick a rule and avoid copying.
- **Assets and recording are where AI-Vid falls short, and the references say how.** The owner reports that every asset method tried so far (Studio `generate_avatar`, dressed catalog extras, Argon meshes, Blender conversions, kit props, generated sets) missed the standard of "assets that look like the Roblox stories out there". The repository records agree (section 3.5, Table C). The visual benchmark is the pair of finished shorts: classic blocky Roblox avatars with printed clothing, chunky hair and exaggerated decal faces, simple props with readable text, and fully dressed maps (section 3.5). By count, four of six tutorials build assets from primitives by agent code (Blender, Three.js, chat sandbox) and only two work inside Studio (03, 06), but the primitive-built results are the plainest in the frames and nothing like the finished shorts. For capture, Studio screen recording and Blender each have two tutorials, one uses a browser renderer and one a direct export; both finished shorts look like Studio renders. Recommendation: keep Studio screen capture and fix the framing and resolution; replace the asset method with a Roblox-native rig plus 2D clothing and face art and dressed maps (section 3.6), as a tested hypothesis. This conflicts with the "Argon builds all assets" rule, so the adoption guide puts it to the owner.
- **Story process.** The tutorials generate the story in one prompt, from "the most viral Roblox stories" (04, 03:09) or ten pitches (03, 01:22), with no originality check at all. AI-Vid's web-verified premise, ledger, engagement score and completeness gate are stricter and must be kept; nothing in the references should replace or weaken them.
- The finished shorts differ from AI-Vid's rules in measurable ways. Both examples cut about every 1.1 to 1.3 s (07: 1.26 s, 09: 1.14 s average shot length). AI-Vid's own story 007 part 1 plans 27 beats averaging 2.07 s with a longest beat of 4.0 s, which breaks AI-Vid's own 3 s maximum. Both examples speak much faster than AI-Vid's natural voice (about 230 and 316 words per minute versus 183 for story 007). Both put captions in the upper or middle area rather than at Y of 82 %, and both use more than three words per caption card.
- AI-Vid's repository benchmark file says the craftee_films "Sword" reel (link 09) has lower-third captions at Y = 82 %. The frames show the captions at about 24 to 29 % from the top. That entry is wrong.
- Story 007's final mp4 is 60 fps (ffprobe `r_frame_rate=60/1`), while AI-Vid's rule and both example shorts are 30 fps. This was already flagged on 2026-11-17 in `docs/HARDENING_REPORT_2026-11-17.md`.
- Every tutorial sits next to a funnel: a Skool community, a Discord, a Google Drive download behind a comment request, a referral code, a paid editor, or a sponsor. Several ask the user to run downloaded skills with permission checks off. None of those downloads should be installed without review (section 3 lists them).
- The most useful adoptions are small: a script that measures any local video the way this study did, a beat-table linter, optional highlighted-keyword captions, and a few rules for readable props and story shape. Section 8 ranks them.

---

## 2. Coverage table

| # | Title (as given) | Creator | Type | Length | Studied? |
|---|---|---|---|---|---|
| 01 | I Gave Claude AI a Story... It Turned It Into a Full Animated Short! (FREE Plugin) | Henry Studioz | YouTube tutorial | 407 s | Yes. Transcript, meta, 12 sampled frames |
| 02 | FREE AI Makes VIRAL Roblox "In This Town" Shorts (No Claude Pro) | Jack Bennett | YouTube tutorial | 379 s | Yes |
| 03 | How to Make Viral "In This Town" Roblox Shorts Using Claude | Simply Azan | YouTube tutorial | 617 s | Yes |
| 04 | How to Make Viral Roblox "In This Town" 3D Animations in One Prompt (FREE PRESET) | Flashloop Twins | YouTube tutorial | 508 s | Yes |
| 05 | How to Make Viral Roblox 'In This Town' 3D Animations With Claude Only (FREE SKILL) | Saajwal Gigabyte | YouTube tutorial | 193 s | Yes |
| 06 | How to Make 'In This World' Roblox Shorts with AI (FREE Skill) | fwjelaa | YouTube tutorial | 788 s | Yes |
| 07 | In this world, everyone gets one superpower, but only once. | Flupzzy | YouTube Short, 360x640, 30 fps | 49 s | Yes. 2 contact sheets, 6 full frames, transcript, cuts. 4,721,040 views, 50,088 likes (meta.txt) |
| 08 | "MY GRANDPA KNOCKS ON THIS WALL EVERY DAY..." | craftee_films | Instagram reel | unknown | No. Download failed (no formats without login) |
| 09 | "The Sword" (page title "Video by craftee_films") | craftee_films | Instagram reel, 30 fps | 35.29 s | Yes. 2 sheets, 6 full frames, Whisper transcript, cuts |
| 10 | "Never Turn Around" | craftee_films | Instagram reel | unknown | No. Download failed |
| 11 | "The Monster Can Only Move in the Dark..." | zaylento | Instagram reel | unknown | No. Download failed |
| 12 | "Everyone Has a Bunker Except Me (Part 1)" | zaylento | Instagram reel | unknown | No. Download failed |
| 13 | "In this world, monsters can smell how strong you are. I'm a zero." | noctaru.story | Instagram reel | unknown | No. Download failed |
| 14 | (no caption visible) | gneef.original | Instagram reel | unknown | No. Download failed |

The six unstudied reels are listed only by the caption text the owner supplied. Nothing is claimed about how they look.

Reading notes for the tutorials: links 01, 02, 04 and 05 use auto-generated English subtitles, link 03 uses manually uploaded subtitles, and link 06 was transcribed by the extraction tool's own speech recognizer. Names like "4gy" in 06 are mis-hearings of "ForgeGUI". Link 05's transcript contains machine-translation oddities ("Gape", "Housework?") that suggest it was translated from another language.

---

## 3. The methods

### 3.1 Method 1: Studio plus Studio MCP, driven by Claude Code (links 03 and 06)

**Who teaches it.** Simply Azan (03) and fwjelaa (06). Link 05 also says this is the "highest quality" route and "closer to what the largest channels use" (05, 00:00:50), without showing it.

**Procedure in 03 (observed, transcript timestamps):**
1. Install Roblox Studio (free) and Claude Code. In Studio, open the Assistant, then Manage MCP Servers, turn on "Enable Studio as MCP server", press quick connect and pick Claude Code (02:15 to 02:33). The creator stresses this is Roblox's own feature, "you don't need to install anything dodgy" (02:25).
2. Prove the link: ask Claude to put a red block in the map and take a screenshot (03:01).
3. Pick one rule. Ask Claude to "pitch me ten of them" and pick the one that makes you ask "wait, what happens then?" (01:22 to 01:32).
4. Paste a long master prompt (obtained from the creator's free Skool, 10:02). Its order, as described at 03:10 to 03:27: story, then a grey-box version, then the world, the lighting, the characters, the shot list and the camera, and finally "it presses play by itself and checks that every single shot ran".
5. Story rules inside the prompt (03:35 to 03:51): the first line is something that "shouldn't be true, said like it's completely normal"; three small early lines each return at the end.
6. A basic grey-box version is built first so layout errors are found "in two minutes" (03:55 to 04:09). After approval Claude swaps in shops, school, houses, cars, trees and then fills the town with people (04:11 to 04:21).
7. Lighting is the largest quality lever according to the creator: low sun, long dark shadows, pale sky, warm colours (04:35 to 04:45). One bug: everything was built too far from the map centre so the camera saw only sky; this is now a rule in the prompt (04:51 to 05:01).
8. Camera: the creator counted 133 shots in just over two minutes in a top channel's video (05:16, "a new picture every single second"). Most shots push in slowly, occasionally one snaps in on a word, most start close and snap back, and "about half of them are tilted slightly" (05:21 to 05:35). The prompt turns the camera on its side so that the landscape Studio window records a full-size vertical video after rotation (05:39 to 05:49). AI-Vid uses the same trick (`docs/LESSONS_LEARNED.md`).
9. Voice: Google AI Studio text-to-speech (free) or ElevenLabs (06:00 to 06:24).
10. Edit in **Ovra**, a paid editor the creator uses: drop in the screen recording, the script and the shot list Claude saved; it rotates the video, crops the Roblox buttons out of the corner, makes the voice, aligns each shot to its line, adds word-by-word captions and sound effects. "About ten minutes, and it cost me just over a dollar" (06:46 to 07:21).
11. Alternative shown at 08:31: an Ovra template that makes the whole video without Studio. The creator says "it's not real Roblox Studio, so it looks a little bit different".

**Procedure in 06 (observed):**
1. New Claude Code session plus a new Studio place. In Experience Settings, Security: allow HTTP requests and enable Studio access to API services (01:23 to 01:56 and 01:40 in the transcript at 103.44 s).
2. Take the creator's "Roblox story shorts kit" from his Discord (120 s, 313 s) and ask Claude to install it as a skill (143 s). Frame 8 (203 s) shows Claude saying it has unpacked the kit ("SkitKit"), is checking existing Studio and Blender files and will "design the multi-story skill, install the skill files, test the skill in Studio".
3. Per story, give Claude a new character as catalog item IDs (shirt, pants, hair) or the creator's own avatar (167 s to 198 s).
4. Ask Claude for a 20 s "In This World" script only; the creator makes the voice himself (216 to 250 s), using fish.audio (299 s).
5. Optional upgrade, sponsored by ForgeGUI: Claude generates every prop as a text-to-3D model (355 s to 372 s). A separate "make map" skill builds a realistic house (544 to 572 s). Claude's output is "a lot of details and lighting" (659 s).
6. Safety tip: do not paste API keys into the chat; ask Claude to run a PowerShell command that stores the key encrypted (498 to 524 s). The reason given (the provider trains on chats) is the creator's claim and is not verified.
7. Result: a 20 s story, "The Snore Collector". The Studio frame at about 686 s (frame 27) shows a night-time suburban house with a red door that looks like a real Studio build. The final sampled frame (737 s) shows a plain blue pill-shaped character with a caption "COLLECTOR" at about 15 % from the top of its 9:16 tile.
8. Claim: "leave my Claude on repeat to crank out these stories ... make you like 60 stories ... even make it uploaded for you" (274 to 289 s). Not shown.

**Tools and cost.** Studio is free. Claude Code is a paid Anthropic product; its price is not stated. Ovra costs about one dollar per edit (03, 07:21). ElevenLabs, fish.audio and ForgeGUI prices are not shown.

**What the "free skill/preset" is.** In 03 it is a long text prompt, delivered through a free-to-join Skool page; its text is not shown beyond a few lines (frame 10 at about 199 s shows a text block that begins "TELL ME ONCE, THEN CARRY ON"). In 06 it is a downloadable folder ("kit") that Claude unpacks and registers as a skill, delivered through Discord. Its contents beyond the summary above are not shown.

**How rendering really happens.** Real-time Studio rendering, recorded by screen capture (03: "all I do is just record it", 05:55). No offline renderer is used. This is identical to AI-Vid's approach.

**Time per video.** Not stated for 03 ("you can make one in an evening instead of a week", 09:46; the top channels "spend days working on the quality", 08:18). 06 gives no build time; the creator waits an unmeasured period (603 to 716 s of video time).

**Output quality.** 03's own result is described by its creator as "simple ... not as detailed as theirs" (07:50). The frames sampled at 400 to 560 s show the creator's examples from other channels more than his own. 06 shows a realistic house and a very simple character.

**Strengths.** Real engine look; characters from catalog items or the creator's avatar; exactly the pipeline AI-Vid already runs; grey-box-first catches layout mistakes cheaply; the lighting recipe matches AI-Vid's own (ClockTime 16.8 low sun).

**Weaknesses and risks.**
- Quality depends on iterating with Claude for days (03, 08:14). The "one prompt" claim is not what 03 itself says.
- 03's top-channel claim that videos are now "two and a half to three minutes" (01:55) contradicts the 20 to 60 s range that 05 states (01:07) and the 35 to 49 s of the two example shorts.
- Funnels. 03: the prompt is "in my Skool. It's free to join" (10:02), plus a paid-by-the-edit editor and a "whole workflow plus the app" behind the Skool "about" link. 06: kit only in a Discord; Ko-fi donations; a sponsor (ForgeGUI) whose models the video promotes.
- The 06 kit is an unvetted download that Claude is told to install as a skill and that was built to run alongside an API key. The 03 prompt is plain text but unvetted.

---

### 3.2 Method 2: Blender scripted by an agent (links 02 and 04)

**Who teaches it.** Jack Bennett (02, free local kit) and Flashloop Twins (04, Flashloop service plus a "Roblox Story Kit" skill).

**Variant A (link 02), procedure (observed):**
1. Install three free tools: Python, Blender, ffmpeg (04:57 to 05:04 in the video).
2. Download "my Roblox kit" from the description. The description link is a `claude.ai/artifact/...` page; the creator calls it "Roblox Kit".
3. Open the kit folder in an AI agent: OpenCode (free plan with DeepSeek or GLM), Antigravity (Google Gemini) or Claude Code (05:07 to 05:23).
4. Type the idea as one line starting "In this town ..." (05:23 to 05:26). Ask for "check pictures first" (05:26 to 05:34).
5. What the agent did for the demo idea ("a town where you must never be the last one awake"), per 01:23 to 01:58 and frame 6 (the agent window at about 73 s): it writes `story.json`, runs `rt_voice.py` (Edge-TTS), writes a story script, runs a Blender check-picture step, renders 1,200 frames, then runs `rt_finish.py` to produce `FINAL.mp4`. It writes a 76-word story, draws a sheet of 16 faces ("the face does all the acting", 01:39), builds the town and cast in Blender and stages 17 shots; makes three small pictures per shot and checks them in "about 12 seconds"; then renders the whole thing "in about five minutes on my laptop".
6. Upgrades when the channel earns: switch the model to Claude and record your own voice because "the free voice is only good for testing" (05:35 to 05:43).

**Output quality (frames 2 to 12).** The sampled frames show low-poly blocky characters in a 3D town rendered in Blender, readable word-level captions near the lower middle, and a face sheet of expression decals. Compared with the real Roblox look in 07 and 09, surfaces are plainer. Frames 15 to 20 show the creator's comparison "re-creations" of other models: the Gemini-like version has a no-ice-cream sign instead of a coffee sign and a clock with a pizza on it.

**Important caveat for 02.** The description says the DeepSeek, Gemini and GLM comparison videos "are re-creations made by Claude to show the kind of mistakes each model makes. They are not direct outputs from those models." So the model comparison (02:28 to 03:40) is illustrative and not a test of the real models.

**Claims in 02 that are not verified here.** "My own AI channel made over $33,500 in the last four weeks" (00:31). "12 of the 13 open on the rule" for 13 shorts the creator measured (03:42 to 03:49). "The real ones cut about every 1.2 seconds" (04:10). "Roblox-sized heads and dark clothes and texture on every surface"; the creator's first version "had big heads and bright pastel colors, and it looked like a kid's show" (04:19 to 04:30).

**Funnel.** CreatorIQ, an app the creator sells through a Skool community: "7 Days Free Trial" in the description, "my personal help with your AI content business", "the goal is your first $2,000 from YouTube" (05:36 to 06:14). It appears in two frames (frames 24 and 30). The kit itself is free.

**Variant B (link 04), procedure (observed):**
1. In Claude Code add a custom connector: Flashloop's MCP link, named "Flash Loop", then sign in to a Flashloop account (01:49 to 02:10). The description gives a referral code "FLASHY" for free credits.
2. Install the "Roblox Story Kit" skill from a Google Drive file. The description says it is "FREE and only works with flashloop"; the transcript says "They only work together" (02:45).
3. Set Claude Code to "Opus 5.5" and "bypass permissions" (02:48 to 02:52). Frames 9 and 11 show the status bar "Opus 5.5 ... Bypass permissions".
4. Type the only prompt: "/roblox story kit ... make me an interesting Roblox town story animation" (02:55 to 03:04).
5. Claude writes a script with a HOOK and BODY structure (frame 14 at about 230 s shows timestamps 00:00 to 00:12 and an orange HOOK tab), offers character designs "A" and "B" (03:20), generates images, characters, voice and music through Flashloop, installs and connects Blender itself, builds the scene, rigs and animates the characters and renders it with captions, music and a thumbnail (03:28 to 04:38).
6. Time: "around 30 minutes to animate and render" per video (04:30 and 06:55).
7. Results: Example 1 (about 88 s: 04:40 to about 06:08): "I told my mom one tiny lie, and I shrunk so small a pigeon carried me across town." Rule: every lie shrinks you. Example 2 (about 47 s: 06:59 to 07:46): "I sneezed in class and teleported into the cockpit of a flying plane." Rule: every sneeze teleports you.

**Output quality (frames 14 to 27).** Clean, brightly lit, blocky 3D characters on smooth backgrounds with a single large bold word as the caption near the lower third (frame 19: "DOG"; frame 21: "SHRINK"; frame 27: "HEAD"). A character that looks like a plush toy on a plain backdrop appears at frame 27. The look is not Roblox's own rendering. Example 1 is about 88 s long, which is above AI-Vid's 60 s maximum and above the 20 to 60 s that the other tutorials say.

**What the skill is and does (as far as shown).** A skill that tells Claude to write a story from "the most viral Roblox stories" (03:09), call Flashloop for assets and voice, then run Blender. Contents not shown.

**Risks, stated factually.**
- Permission bypass: with "bypass permissions" Claude Code runs commands without asking. In 04 it also installs Blender on its own (03:55 to 03:59).
- Vendor lock: the skill "only works with flashloop" (description), which is a paid credit-based app (App Store link) from the same creators. A referral code is attached.
- Unvetted download: a Google Drive file.
- The video states very large numbers ("500 million views", 500,000 subscribers in about 20 Shorts) that are not verified.
- The "no iteration needed" claim is not demonstrated beyond two results chosen by the creator. The stories are generic comedic chains with no earned meaning (the AI-Vid rule "Meaning and completeness" would likely fail them).

---

### 3.3 Method 3: Claude-only generation without Studio or Blender (links 01 and 05)

**Link 01 (Henry Studioz). Observed procedure:**
1. Download a "free Claude skill" and a "cartoon kit" from a Google Drive folder; the link is also obtainable by commenting "Claude" or from the creator's WhatsApp channel (01:07 to 01:39).
2. In Claude.ai: Customize, Add, Upload skill; start a new chat and select the skill (01:44 to 02:03). Frame 8 (105 s) shows the Claude.ai home screen with "Free plan" and a Sonnet 5.5 model label.
3. Choose a starting option and a duration (20 to 30 s). Claude suggests ten ideas. Each idea has Hook, Twist, Visuals and "True or legend" lines (frame at 105 s). Pick one and Claude writes the script (02:08 to 02:46).
4. Voice by ElevenLabs text-to-speech with voice "Mark - Casual, Relaxed and Light", model Eleven v4 (frames at 144 to 171 s); download one of two generations (02:52 to 03:13).
5. Back in Claude, upload the voice file. For a 3D cartoon look also upload the cartoon kit zip; for 2D upload only the voice (03:02 to 03:50).
6. Claude produces an mp4 inside the chat. 2D took "approximately 20 minutes", 3D "approximately 47 minutes" (04:21 and 05:26). Frame 24 (315 s) shows the 3D run's summary: "your voiceover is 40.28 s (1,208 frames at 30 fps) and I matched each line to the audio", "18 shots", characters and sets listed, and "I checked the finished file for frozen or black frames".
7. Edit loop: not shown.

**How rendering really happens in 01.** Not shown. The chat summary (frame 24) names frames and fps, and says Claude checked the output file for frozen or black frames, which means the mp4 was produced by code that ran in Claude's own environment. The renderer, library and resolution are not stated and cannot be determined from the video.

**Output quality.** Flat cel-style 2D cartoon figures on painted backdrops (frames at 79 s, 263 s). The 3D run has the same cartoon figures with some depth and shading (frames at 354 s, 368 s); the sampling is too sparse to tell more. Stories are 20 to 30 s history facts ("America and Britain almost went to war over one pig", 00:43), not "In This Town" stories. The finished output is not Roblox in any form.

**Inconsistency noted.** The description and the spoken text say 20 to 30 s videos; the summary in frame 24 says the voiceover is 40.28 s. The summary text was read from a low-resolution montage and may be a misreading.

**Link 05 (Saajwal Gigabyte). Observed procedure:**
1. Collect two or three of the best reference videos, download them and send them to Claude (00:01:22 to 00:01:31).
2. Ask Claude to break the references down frame by frame into "a set of style rules" (blocky characters, bright colours, camera angles, rapid shot changes, subtitle look) (00:01:33 to 00:01:44).
3. Claude writes "his own engine": "a small animation studio" with blocky characters, a city, cameras and lights, built once and reused per episode (00:01:50 to 00:02:04). The description says it is **React plus Three.js, no Blender**. Frame 19 (the "Heads, arms and legs" card) shows a blue and yellow box-body figure.
4. One strange rule in, short script out; record a voice with ElevenLabs (00:02:07 to 00:02:19).
5. Upload the voice; Claude syncs frames to it, adds word-for-word subtitles, music and sound effects and renders a vertical video (00:02:19 to 00:02:31). How export is done is not shown.
6. Correction: watch, write notes, send them back (00:02:31 to 00:02:45).
7. The skill itself: at the end of the video the creator says it will be released "if enough of you ask" (00:02:57); the description says to comment if you want it and that it will be dropped once "10-15 people need it", and also gives a Google Drive folder "Skill File And Its Guide". The video and description disagree about whether it exists yet.

**Time and cost.** Not stated. Claude Code (Pro) is the only tool named in the description; ElevenLabs is shown.

**Output quality.** The only finished output shown is a 20 s example, "In this city, when you yawn, day turns into night" (00:00:19 to 00:00:45). The sampled frames show a simple blue figure with a hat and an idea-lightbulb on a plain gradient (frames 5 and 25), with a word caption. It reads as flat primitives, much simpler than Roblox's look.

**Strengths.** Zero local installs for 01; runs entirely in a browser for 05; the "study references, extract style rules, build the engine once" workflow is sound for consistency.

**Weaknesses and risks.** Not Roblox. 01 is not even the same genre. Nothing is shown of the renderer, export path or the skill files. Both depend on downloads gated by a comment (01: comment "Claude" or WhatsApp; 05: comments threshold) or a Drive folder. Quality ceiling is far below Studio.

---

### 3.4 How each reference makes its characters, props and sets, and how it renders, frames and captures the picture

This section answers two questions in detail: how are assets produced, and how is the picture rendered, framed and recorded. "Not shown" means the video neither shows nor says it.

**Table A: assets (characters, props, sets)**

| Link | Characters | Props | Sets | Evidence |
|---|---|---|---|---|
| 01 | Drawn by code in Claude's chat environment as flat 2D cartoon figures; with the "cartoon kit" zip a 3D-cartoon look. Kit contents not shown | Part of the same generated scene | Painted-style backdrops generated in the same run | 03:02 to 05:30; frames at 79 s and 354 s |
| 02 | Blocky figures built by agent code (Python scripting in Blender) from simple shapes plus a 16-face expression sheet "drawn" by the agent | Built by code | A whole town built by code in Blender | 01:23 to 01:58; frame 6 (`story.json`, Blender steps), frame 8 (9-face sheet) |
| 03 | Built inside Studio by Claude through Studio MCP; whether from catalog avatars, Humanoid rigs or parts is not shown | Claude places parts: shops, houses, cars, trees | Grey-box first, then detailed streets, school, houses; "I did not place a single block myself" | 00:00 to 00:06, 03:55 to 04:21 |
| 04 | Generated as images by Flashloop (AI), then built and rigged in Blender by Claude; the creator picks design "A" or "B" | Flashloop-generated assets | A 3D scene built in Blender | 02:55 to 04:12 |
| 05 | Blocky figures (heads, arms, legs) written as code in a React plus Three.js engine; no Blender, no Studio | Code | A city with school and park, in code | 01:50 to 02:04 |
| 06 | Outfits assigned from Roblox catalog item IDs, or the creator's own avatar; the kit unpacks as a skill | Text-to-3D models from the sponsor ForgeGUI, uploaded to Roblox as model assets (frame 20: "uploading the bed ... to your Roblox account") | A separate "make map" skill builds a realistic house (frame 27, about 686 s) | 167 to 198 s, 355 to 372 s, 544 to 600 s |
| 07 | Classic-style Roblox avatars with layered hair and clothing and 2D face decals, many distinct outfits | Look like ordinary Roblox models with readable text ("SCHOOL BUS", `sheet_02` tile 1,3) | Roblox-game-style maps: school hallway, playground, bridge | `sheet_01`, `sheet_02`; production method not stated by the creator |
| 09 | Same style: catalog hair and clothes, 2D face decals, apron with pretzel icons | Baker's basket, "GLUE" jar, sword in stone, red dragon | Half-timbered town and castle with bunting, day, dusk and night | `sheet_01`, `sheet_02`, `full_06` |

**Table B: rendering, framing and capture**

| Link | Rendered by | Capture / export | Resolution and aspect | How framing is decided |
|---|---|---|---|---|
| 01 | Not shown (code that ran in Claude's own environment; frame 24 mentions "1,208 frames at 30 fps") | mp4 appears in the chat, downloaded (04:51) | Not stated; the player in the frames at 79 s and 263 s is a narrow vertical player | Claude decides 18 shots from the script; no human framing step shown; Claude only says it checked for frozen or black frames |
| 02 | Blender (render engine not stated); 1,200 frames for a roughly 20 s story, which equals 60 fps if 20 s (fps not stated) | `rt_finish.py` produces `FINAL.mp4` | Portrait phone-shaped tiles (frames 2 to 12); numeric resolution not stated | The agent stages 17 shots in code, makes "three small pictures of every shot" in about 12 s, and the creator catches "a bad camera angle" before the full render (frame 27 "too far away") |
| 03 | Studio real-time renderer | Screen recorder on the Studio window; camera rolled 90 degrees so the landscape window holds a vertical frame; rotated later (05:39 to 05:55, 06:47) | Not stated | Camera moves are written per shot into the master prompt (shot list, push-ins, snaps, tilt); Claude presses play and checks every shot ran (03:24); the creator watches |
| 04 | Blender | Automatic render with captions, music and thumbnail, about 30 min (04:30) | Not stated; vertical in the frames | Automatic, nothing shown; no human framing step |
| 05 | Browser (Three.js) | Export not shown | A portrait phone mock-up in the frames; resolution not stated | Camera code written by Claude from the style rules; the creator reviews and sends notes (02:31) |
| 06 | Studio real-time renderer | The description says Claude "records the Short for you"; how the recording is made is not shown. The kit also burns captions (frame 29: "COLLECTOR" at about 15 % from the top) | Not stated | Not shown beyond the kit |
| 07 | Appears to be Studio: real Roblox shading, bloom, bright sky, aura effects. Not stated by the creator | Not stated; the published Short is 360x640 as downloaded at 30 fps | 9:16 | Close low-angle framing with the subject in the middle of the frame and captions in the lower-middle (`full_01` to `full_06`) |
| 09 | Appears to be Studio, same reasoning | Not stated; 30 fps | 9:16 | Subject in the lower two thirds, captions in the upper third (`full_01` to `full_06`) |

**Counts over the six tutorials.**

| Approach | Count | Links |
|---|---|---|
| Assets: Roblox-native inside Studio (catalog avatars and outfits, Studio-built parts and maps) | 2 of 6 | 03, 06 |
| Assets: built by agent code from primitives outside Studio (Blender scripts, Three.js, chat sandbox) | 4 of 6 | 01, 02, 04, 05 |
| Assets: AI text-to-3D models (props only) | 1 of 6 | 06 |
| Assets: AI-generated images used as character art | 1 of 6 | 04 |
| Render and capture: Studio real-time renderer plus screen recording | 2 of 6 | 03, 06 (06's recording method is not shown) |
| Render and capture: Blender offline render to a video file | 2 of 6 | 02, 04 |
| Render and capture: browser Three.js render (export not shown) | 1 of 6 | 05 |
| Render and capture: direct mp4 export from Claude's chat environment | 1 of 6 | 01 |
| Both finished examples (07, 09) | Look like Studio renders of catalog-style avatars | Appearance only; the creators do not say how they were made |

**What the counts and the frames say.** No single approach is used by more than four of six tutorials. The most common asset approach by count is agent-written code building primitives (4 of 6), but the frames of those results are the plainest: flat 2D (01, frames at 79 and 263 s), plain low-poly Blender figures (02, frames 2 to 12), a plush-like figure on a blank backdrop (04, frame 27) and a box figure on a gradient (05, frames 25 and 29). The two finished examples that audiences actually watched (07 with 4.72 million views) look like Roblox itself: classic avatars with decal faces, textured cobble and marble, a readable school bus. They are not what the primitive-building tutorials produce. Of the two Studio tutorials, 03 shows a basic town and 06 shows a convincing house plus a very plain character. The proven look therefore comes from using Roblox-native avatars and parts, rendered by Studio. For render and capture, Studio screen recording and Blender are tied at two tutorials each, and the finished examples look Studio-rendered.

### 3.5 What the AI-Vid workspace shows about its own assets and recording

This is read-only evidence from the repository on 2026-11-17.

**Assets (characters, props, meshes, sets).**
- Argon's first character mesh (`audits/argon_002/ARGON_REPORT_character_mesh_test.md`) was judged "not usable yet (our current Mia looks clearly better)": arms fused into the torso, no hands, no skirt, a sharp cube head, about 108 faces, no joints, and colours that imported grey because Roblox ignores material base colours.
- The second Argon mesh (`audits/argon_003/ARGON_REPORT_003_mia_v2_and_faceplate_test.md`) fixed the body shapes but the face printed on the side of the head, the hair was a solid block, there was no rig, and colours only appeared after a `SurfaceAppearance` fix. Verdict in that report: "The current Mia still looks best overall. Neither option is ready." The attempted face-plate workaround rendered as a thin sliver or a flat square sticking out of the head.
- `assets/INDEX.md` lists the Blender-converted props, heads and characters as "EXPERIMENT"; the kit's character meshes are marked "banned: no Blender characters" in `archive/kit_v3_unused/`. The 12 prop meshes are `.obj` files that must go through Argon or Studio first.
- The story 007 cast that actually shipped was made with Studio's `generate_avatar`, with faces as head clones. Sets came from `generate_scene` plus manual fixes (`docs/LESSONS_LEARNED.md`: sets arrived 10 studs below the baseplate, with missing walls, ceilings and doors to nowhere, and grey characters when textures failed with HTTP 503).
- The external audit on story 007 (`update/story007_wristrewind_qa_audit_and_next_story_playbook.md`) scored "Roblox Character Authenticity" 7 of 10, "Camera and Scene Framing" 5 of 10, and "VFX and Lighting Polish" 6 of 10, and described an "untextured white cylinder" as the milk prop.
- Owner statement (relayed): every asset-production method tried so far fell short of the owner's standard, which is "assets that look like the Roblox stories out there", meaning the look of the finished reference videos and tutorial results. The workspace is consistent with this and does not show any method that reached it.

**Table C: every asset method AI-Vid has tried, what it produced, why it fell short (from the records)**

| Method tried | What it produced | Why it fell short, as recorded |
|---|---|---|
| Studio `generate_avatar` (`npc` pipeline) for the main cast | Smooth, semi-realistic characters (story 007 beat sheet `audit_v2/02_after_part1_beat_sheet.png`, B10 to B27) | External audit rated authenticity 7 of 10 and reported rig-detachment glitches in the first cut. The faces had to be replaced with per-emotion head clones, skin tone drifted (`assets/faces/skin_tones.json` exists because of it) and textures failed to load as grey bodies (HTTP 503). Why the look differs from classic Roblox avatars is **not recorded** beyond "AI v1 style semi-realistic cartoon" in `docs/LESSONS_LEARNED.md` |
| Dressed `HumanoidDescription` extras from free catalog items (`assets/rigs/bystanders_school.luau`) | Six distinct bystanders replacing clone extras (`audit_v2/04_new_bystanders.jpg`) | Owner says it did not reach the standard. The reason is **not recorded**. The script filters to free items (`MaxPrice 0`), which restricts the hair and clothing choice (`docs/LESSONS_LEARNED.md`) |
| Argon (Gemini) kit v3 character mesh `Mia_R15_Riggable.obj` | About 108 faces: arms fused to torso, no hands, no skirt, sharp cube head, no joints, grey in Studio | `audits/argon_002/ARGON_REPORT_character_mesh_test.md`: "not usable yet" |
| Argon `Mia_v2.glb` | Better body, sweater, skirt and legs, but face on the side of the head, hair a solid block, no rig, black until a `SurfaceAppearance` fix | `audits/argon_003/ARGON_REPORT_003_mia_v2_and_faceplate_test.md`: "Neither option is ready" |
| Face-plate workaround on `generate_avatar` heads | A thin sliver, then a flat square sticking out of the head | Same report |
| Blender conversion and baking of kit meshes (`engines/blender/exp_convert.py`, `kit_convert.py`, `mia_atlas.py`, `mia_full.py`) | `.glb` characters, heads and props, listed as EXPERIMENT in `assets/INDEX.md` | Imported grey until colours were baked into one texture atlas; later face-mapping error as above; no rig |
| Blender-designed hero (`assets/rigs/hero_blender.fbx`, `engines/blender/build_r6_character.py`) | AI-designed boxes | Rejected on 2026-11-15 (`AGENTS.md`); the specific visual fault is **not recorded** |
| Kit prop meshes (12 `.obj` props in `assets/meshes/props/`) | Props such as the acid bottle, beaker, milk cup, pencil | Not directly importable (Roblox does not import `.obj`); colours not baked (the armchair imported "flat cream"); in the video the milk and glass props read as pale blobs (`audit_v2` B15 to B21) |
| `generate_scene` sets (Set_ChemLab, Set_Hallway) plus manual fixes | School lab and hallway | Arrived 10 studs below the baseplate, with missing walls, ceilings, doors to nowhere and flat text; needed rebuilding from classic Parts (`docs/LESSONS_LEARNED.md`) |
| Part-built set (`engines/roblox/sets/grandma_room.luau`) | Classic part-built living room | Used in the video; the sets are sparse next to the references (see the benchmark below). Specific complaint **not recorded** |

**Visual benchmark for assets, taken from the finished examples and tutorial results.** This is what "looks like the Roblox stories out there" means in the frames.

| Aspect | What the benchmark frames show | Where |
|---|---|---|
| Proportions | Classic blocky Roblox build: head about one quarter of body height, boxy torso, thick straight arms and legs held in simple poses, no sculpted anatomy. R6 or R15 cannot be told apart at 360x640 | 07 `sheet_01` tiles 1,2, 3,6, 5,4; 09 `sheet_01` tiles 1,2, 2,5, 4,4 |
| Faces | 2D decals on a plain head, with very readable, exaggerated expressions: huge eyes with white sclera, open-mouth shock, wide grin, the "troll" grin, closed-eye smile, angry brows. Thin simple line work | 07 `sheet_01` tiles 3,1, 3,4, 4,2, 5,5; 09 `sheet_01` tiles 1,3, 2,5, 5,5 |
| Outfits | Flat printed clothing textures on the blocky body: varsity jackets with letters and numbers ("C 11", "8" jersey), an apron with pretzel and croissant icons, a striped pink gown, plated armour texture, a school uniform with plaid skirt. Each character has a distinct colour identity | 07 `sheet_01` tiles 1,1, 3,6, 5,4; 09 `sheet_01` tiles 1,2, 1,4, 5,1 |
| Hair and accessories | Chunky 3D hair and hats in strong silhouettes: green spiky hair, messy brown hair, a beanie, a baseball cap, long black hair, a tiara, a crown | 07 `sheet_01` tiles 2,4, 3,2, 3,6; 09 `sheet_01` tiles 1,3, 1,1, 2,5 |
| Props | Simple, instantly recognisable objects with readable text or distinct colour: a yellow bus marked "SCHOOL BUS", a cake with candles, a jar marked "GLUE", a basket of bread, a sword in a rock, a number "1" statue. None is a pale untextured blob | 07 `sheet_01` tile 1,4, `sheet_02` tile 1,3; 09 `sheet_02` tile 4, `sheet_01` tile 4,4 |
| Materials and detail | Textured but low-poly: cobblestone, marble, brick, wood grain, tiled roofs; mild bloom and soft shadows | 07 `sheet_01` tiles 2,3, 4,1; 09 `sheet_01` tile 1,4 |
| Sets and dressing | Complete, dressed Roblox-game-style maps: school hallway with lockers, marble floor and windows; playground; bridge with arches, cars and a skyline; half-timbered medieval town with lit windows, bunting strings, market tents and a castle. Day, dusk and night variants of the same town | 07 `sheet_01` rows 4 to 5, `sheet_02` rows 1 to 2; 09 `sheet_01` rows 1 to 5 |
| Extras | Several distinct extras in crowd shots, each with different hair and outfit | 09 `sheet_01` tile 2,4; 07 `sheet_02` tile 1,4 |
| Tutorial results | The plainest tutorial results (01, 02, 04, 05) are weaker than this benchmark. 06 shows a convincing house and a plain character. 03 shows a basic town | Section 3.4 |

**Recording and framing.**
- Capture is `ffmpeg gdigrab` of a fixed screen region (`pipeline/record_take.py`, `REGION = x 4, y 160, w 1882, h 966`) with the camera rolled 90 degrees and rotated afterwards. After rotation the picture is only 966 px wide, which is scaled up to 1080 (about 12 % upscale), and `docs/LESSONS_LEARNED.md` itself requires at least 968 px. The region is hard-coded and the hardening report (weakness 14) notes it can silently capture chrome.
- The final file is 60 fps from a 30 fps capture (`ffprobe` on `stories/007_wrist-rewind/007_wrist-rewind_part1.mp4`: `60/1`).
- Camera: every shot gets the same slow push-in (`engines/roblox/story007_cutscene.luau` lines 1277 to 1283); no snap-out or impact zoom exists (hardening report weakness 5). Beats average 2.07 s with a 4.0 s maximum in `beats_p1.json`.
- Frame evidence in `stories/007_wrist-rewind/audit_v2/02_after_part1_beat_sheet.png` (beats B1 to B27 plus END): macro shots where the main object fills the frame and the action is unreadable (B2 clock, B16, B17, B20, B21 close-ups of bottles and a beaker seen from above); a glass beaker in front of Jace's face in B5, B6, B15 and B17; large pale props with no clear identity; the first beat opens on a hand, not a face (AUDIT_REPORT_v2 section 5); and captions sitting on a dark bench strip at the bottom of the frame. Several beats (B9, B16, B17, B25) are low-contrast or mostly bench.
- Reading: the capture method matches what the Studio tutorial (03) does, so the weakness is in resolution headroom (966 px), shot design (macro inserts and occluders), the 60 fps resample and the single camera move, not in the choice of Studio screen recording.

### 3.6 Recommendations for assets and for recording and framing

**Assets: recommended approach.** No current AI-Vid asset method is recommended as it stands (owner statement and Table C). The replacement recommended here is the approach the benchmark frames imply: **classic Roblox avatars built on the standard R6 or R15 rig, dressed with flat printed clothing textures (classic `Shirt`, `Pants` and graphic textures) and chunky layered hair or hats, with a 2D decal face on the standard head, set in dressed maps made of Roblox-native parts and free-to-use Toolbox models, and props that are simple, textured and carry readable text.** This is a hypothesis built from the frames: the two examples do not state how they were made, and it must be tested with one character and one set before any commitment.

What must change compared with the methods already tried, and why that closes the gap:
1. **Characters stop being AI-generated smooth avatars or custom meshes.** The benchmark is a plain blocky rig with printed clothing. Image generators (Argon/Gemini or others) are good at 2D images, so they are used to make the 2D clothing textures and face decals (the template images Roblox clothing uses), not 3D meshes. Both Argon mesh tests failed on 3D structure (ARGON-002, ARGON-003); a flat texture on a standard rig removes the rigging, face-mapping and colour-baking failure modes.
2. **Faces become decals on the standard head,** as in 07 and 09, with the benchmark's exaggerated, thin-line expressions, instead of the "v1" semi-realistic head clones. This changes a locked taste rule and the skin-tone logic.
3. **Hair and hats come from layered accessories** with strong silhouettes. The earlier extras script limited the pool to free catalog items (`MaxPrice 0`); whether that limit or something else made the extras fall short is not recorded, so the first test must say which accessory pool is used and show the result against the benchmark tiles.
4. **Sets are dressed to the density of the benchmark** (lockers and windows in a hallway; bunting, tents and lit windows in a town; skyline and cars on a bridge), using Studio-native parts and free Toolbox models. Sets are never taken as raw `generate_scene` output.
5. **Every key prop carries readable text or a distinct colour** (the "GLUE" jar, the bus), and no key prop is a pale untextured shape.

**Runner-up.** A Roblox-native hand-built workflow with free-to-use Toolbox sets only and catalog avatars as the cast, with no custom character art. It costs the least and has the lowest risk, but gives the least control over character identity.
**Rejected.** Code-built primitives in Blender, Three.js or a chat sandbox (4 of 6 tutorials), and 3D meshes made by an image model, for the reasons in section 3.4 and Table C.

**Recording and framing: recommended approach.** Keep **Studio real-time rendering captured by screen recording** (2 of 6 tutorials, both examples appear to be Studio renders, AI-Vid already does it). Change the framing and capture details, not the engine: get at least 1080 px of native viewport height, record 30 fps and finish at 30 fps, write each shot as a subject-first frame (face or key object readable, full head in frame, nothing between the camera and the face), and use the Studio-tutorial habit of previewing every shot before the long run (03 03:24; 02's "three small pictures of every shot", 01:49). A frame specification is in the adoption guide.
**Runner-up.** Blender offline render to a video file (2 of 6 tutorials). It would give resolution control, but it breaks the current rule that Blender never designs characters and gives a less Roblox-like picture (02, frames 2 to 12). Not recommended.

**Conflicts with current AI-Vid rules.** These are stated plainly and are decisions for the owner, not silent overrides:
1. "Argon builds all assets" (`AGENTS.md`, `docs/ARGON_PIPELINE.md`) conflicts with using Studio-native avatars, parts and Toolbox models. The rule has not delivered the owner's standard (Table C), so replacement is recommended: Argon's role changes from building 3D assets to producing 2D art (clothing textures, face decals, prop labels), with the Roblox-native rig and parts doing the 3D.
2. "Main characters via `generate_avatar`", "bystanders via free-catalog `HumanoidDescription`" and the "v1 face style" with per-emotion head clones and locked skin hex (`docs/LESSONS_LEARNED.md`) conflict with the recommendation. Each has been tried and fell short; the change alters the look the owner locked on 2026-11-16 as "user taste".
3. "Authentic Roblox R6/R15 characters only" is consistent with the recommendation (a plain R6 or R15 rig is the authentic form); it is reinforced, not weakened.
4. "Roblox Studio is the primary engine" is consistent.
5. "Faces fill 25 to 35 % of frame height on emotional beats" and "no macro closer than 2.5 to 3 studs" are consistent with the framing spec but are not being met in the story 007 beat sheet.

---

## 4. Finished examples

### 4.1 Link 07: Flupzzy, "In this world, everyone gets one superpower, but only once."

Source: YouTube Short, 360x640 at 30 fps, 49 s. 4,721,040 views and 50,088 likes at the time of download (meta.txt, upload date 2026-08-01). `sheet_01.jpg` shows seconds 0 to 29, tile (row, column), left to right and top to bottom, 6 columns by 5 rows. `sheet_02.jpg` shows seconds 30 to 48 (19 tiles, rows 1 to 4). Full frames are `full_01.jpg` to `full_06.jpg`.

**Characters.** Blocky, R6-like (wide boxy torso and arms), many distinct outfits and hairstyles: varsity jackets, a beanie, a Yankees-style jacket, a school uniform with a pink plaid skirt (`sheet_01` tiles 1,1 to 1,3 and 2,3 to 2,6). Faces are 2D decals with strong expressions: grin, wide-eyed shock, the "troll" grin on two characters (`sheet_01` tiles 3,1 and 3,4), and a beaming smile on the hero in `full_06` of the children group. The hero Mason keeps one outfit (green number-8 jersey) and gets a muscle-texture torso for the strength power (`sheet_02` tiles 1,6 and 2,2 to 2,3). I could not tell R6 from R15 reliably at 360x640.

**Sets and materials.** Five or six varied locations in 49 s: a school hallway with red lockers and a cracked-marble floor (`sheet_01` tiles 1,1 to 1,2 and 4,1 to 5,6), a birthday room with a cake and bunting (tiles 1,4 to 2,1), a playground on cobble (tiles 2,2 to 2,6), a bedroom (tile 3,1), a skyline (tile 3,3) and a bridge with a yellow school bus (`sheet_02` tiles 1,2 to 3,3). Surfaces are textured (cobble, marble, brick). Props carry readable text: "SCHOOL BUS" on the bus front (`sheet_02` tile 1,3) and a big "1" statue (`sheet_01` tile 2,2).

**Lighting and colour.** Mostly bright daytime, blue sky and clear colour. This is not the low golden-hour sun that AI-Vid and the 03 and 02 tutorials describe. The hallway is soft and pale. Power effects are saturated: an orange flame ring (`sheet_01` tiles 2,3 to 2,6), a white-blue Goku-style aura (tile 2,1 and `sheet_02` tile 4,4), a cyan burst for strength (`sheet_02` tiles 1,6 to 2,3), strong bloom.

**Camera.** Close, low-angle shots with wide-angle perspective distortion on the face (e.g. `sheet_01` tiles 4,3 and 5,5); a handful of slightly tilted frames (tiles 2,3 to 2,6, 4,3); a drone-like skyline shot; the bus shot is low and tight. Some shots hold on the same set for several consecutive tiles with small movement (tiles 5,1 to 5,3 "his friends laughed at him" are three tiles of one shot). I cannot count the camera-mode mix from still tiles. Roughly, push-ins and close-ups dominate.

**Cut rate.** `cuts.txt`: 38 detector changes in 49 s, an average shot length of 1.26 s (scene threshold 0.3; the detector also fires on flashes and aura bursts, so the true cut count may be a little lower). Sanity check against the sheet: tiles 5,1 to 5,3 show one continuous shot over about 3 s, and tiles 1,1 to 1,3 show three different shots in 3 s. The average of about 1.3 s is plausible. Cut times cluster at 0.8 to 4.5 s (6 cuts in the first 4.5 s) and 20.5 to 22.1 s (4 cuts in 1.6 s).

**Captions.** White lowercase sans-serif, thin dark outline, no coloured highlight, with the emphasised word in capitals ("everyone is born with a STAR", `sheet_01` tile 1,2). Two lines per card with 4 to 6 words in total. Position: about 64 to 69 % from the top of the frame (measured on `full_01` to `full_06`; the text sits above the lower-third band), centred horizontally. Font size is modest: a text line is about 3 to 4 % of the frame height. Each card changes at roughly one per second.

**Voice and pace.** The transcript has 188 words over 0 to about 49 s: roughly **230 words per minute**. The narrator is **third person** ("One boy chose flight", "Mason always smiled"), not first person. The voice itself (person, TTS or human) cannot be judged from a transcript.

**On-screen rule indicator.** The yellow star mark is on the hand of almost every character in nearly every tile (e.g. `sheet_01` tiles 1,1, 1,2, 2,3, 3,1, 4,5; `sheet_02` tiles 3,3, 3,4). After use it turns grey (tile 2,6, `sheet_02` tile 2,5 shows a fading mark). So the video reads muted. This matches the sound-off rule.

**Hook in the first 3 s.** Caption and voice: "In this world, everyone is born with a star-shaped mark on their hand. The moment you turn 15, it grants you any superpowers you want." (0.00 to 6.72 s, transcript). The first tiles show a girl with a star on her hand (tiles 1,1 to 1,3) and a birthday cake (tile 1,4). The one rule ("you can only use your power once") arrives at 6.72 s, which is later than AI-Vid's 0 to 1 s hook target.

**Structure and ending.** Rule (0 to 9 s), examples of use (9 to 20 s: flight, time manipulation, skipping classes), the protagonist who never used his (20 to 29 s), crisis (a bus hanging over a river, 29 to 33 s), power spent (33 to 38 s), payoff. The final line is a moral: "A superpower only lasts for a moment. But the lives you save can last a lifetime." (44.8 to 46.8 s). It does not loop back to the first line. The last three tiles before the final tile (`sheet_02` tiles 4,4 to 4,6) reuse earlier clips (the birthday power shot, the clock shot, the bus lift) as a recap during the final line.

### 4.2 Link 09: craftee_films, "The Sword"

Source: Instagram reel, 35.29 s at 30 fps (ffmpeg), no likes or views known. `sheet_01.jpg` has seconds 0 to 29; `sheet_02.jpg` has seconds 30 to 34 (5 tiles used). Full frames `full_01.jpg` to `full_06.jpg`. Transcript is automatic (faster-whisper small.en).

**Characters.** Blocky Roblox rigs with layered catalog hair and clothes: a baker's son with green hair, a brown apron and pretzel and croissant icons; a princess in a pink gown with long black hair; knights in black armour; a king in red and white; a red dragon (`sheet_01` tiles 1,1 to 3,6). Faces are expressive 2D decals (shock on the baker, closed-eye smile on the princess; `sheet_01` tiles 1,3, 2,5 and `full_02`). A crowd of about 8 distinct extras appears in one shot (`sheet_01` tile 2,4). I could not tell R6 from R15.

**Sets and materials.** A half-timbered medieval town with glowing yellow windows, a white castle with a drawbridge, a tournament field with red-and-white tents, bunting everywhere; the same town at dusk and at night with lanterns (`sheet_01` tiles 4,6 to 5,6). Textured cobble and timber. Props carry readable text: a jar labelled "GLUE" (`sheet_02` tile 4 and `full_06`).

**Lighting and colour.** Bright blue sky and warm daytime, then dusk (tiles 3,1 to 3,6) and night (tiles 4,6 to 5,5) tied to the passage of the story. Colour is saturated and pleasant, not dark.

**Camera.** Close-ups with a wide lens on the characters (`sheet_01` tiles 1,3, 2,1, 3,5, 4,3, 5,5); medium two-shots (tile 4,4, 4,5); a wide crowd shot (tile 2,4); a dragon in the distance (tile 4,1). The camera is rarely static across tiles. Counting the mix is not possible from stills.

**Cut rate.** `cuts.txt`: 30 changes over 35.29 s, average shot length 1.14 s. Sanity check: nearly every tile in `sheet_01` (one per second) shows a different framing or subject, so the figure fits.

**Captions.** White text with the key word in **bright green**, black outline, bold sans-serif, centred. Two lines of 1 to 3 words each ("the / SWORD", "marries the / PRINCESS", "I'm / JUST"), 2 to 5 words per card. Position: about **24 to 29 % from the top** (upper third), on `full_01` to `full_06` and in every tile of both sheets. The highlighted word is nearly always the last content word of the card, and the card never ends on a function word. At least one new card per second tile in `sheet_01`, so cards last about 1 s or less. (The repository's `reference/BENCHMARKS.md` says this reel has "Lower-Third Y = 82 %" captions. The frames contradict that.)

**Voice and pace.** 186 words in 35.29 s: roughly **316 words per minute**, first person ("I tripped and pulled it out", "I'm just the baker's son"). That is much faster than natural speech and likely accelerated audio. The speaker cannot be identified from the transcript.

**On-screen rule indicator.** There is none beyond the object itself (the sword in the stone is on screen in the first and last quarter). The rule is stated in the first sentence and the proof is visual (a sword in a stone, `sheet_01` tiles 1,1 and 1,4). A sign-off-sound reading works because captions carry the story.

**Hook in the first 3 s.** "Whoever pulls the sword out of the stone marries the princess. I tripped and pulled it out." (0.00 to 3.24 s). The rule and the narrator's problem arrive in 3.2 s.

**Structure and ending.** Rule plus problem (0 to 3 s), who I am and the stakes (3 to 9 s: baker's son, crush on the princess), the kingdom reacts (9 to 13 s), repeated duels and a dragon each resolved by tripping (13 to 20 s), the princess keeps coming for bread (20 to 24 s), the reveal (24 to 29.6 s: a hammer, a chisel and her crown behind the stone, "she'd loosened that sword herself", "what I tripped on. Her foot."), a final joke (30 to 35 s: the knights retry, "this time, she glued it in. She said she was keeping me."). The reveal recasts the opening line, and the story is a romantic comedy with no moral line. It does not loop to the first line.

---

## 5. The common format

All numbers cite the examples and tutorial claims; tutorial claims are marked as claims.

| Aspect | What the references agree on | Evidence |
|---|---|---|
| Premise shape | One absurd rule, stated in the first line. "In this town ..." or "In this world ...", or a rule-plus-problem line in the same breath | 07 0.00 s, 09 0.00 s, 03 01:13, 05 00:11 (claims), 02 03:49 (claim: 12 of 13 shorts open on the rule), 04 examples |
| Examples of life under the rule | Two or three quick consequences used as jokes ("bedtime stories are one word") | 02 03:52, 03 01:40, 07 9 to 20 s, 04 ex. 1 "Fishermen have to stand on their own fish" |
| Personal turn | "I" or one protagonist who differs | 02 04:02, 03 01:42, 05 01:11, 07 (Mason), 09 |
| Escalation then twist | A crisis, then a twist that uses the rule | 02 04:04, 03 01:46, 07 (bus), 09 (the glue) |
| Ending | Loop back to line one (02, claim); cliffhanger for part two (03, claim); moral line (07, observed); comic punch (09, observed) | The observed shorts do not loop back |
| Planted details | Three small early lines that pay off at the end (03 03:45, claim) | 09: the princess "took the bread from me herself" returns as the proof of her plan |
| Length | 20 to 60 s per short (05, 01:07); 03 says top channels now go 2.5 to 3 min; examples 07 and 09 are 49 s and 35 s | Conflicting claims; observed numbers 35 to 49 s |
| Cut rate | About 1.1 to 1.3 s between cuts | 07: 1.26 s, 09: 1.14 s (measured); 02 04:10 "about every 1.2 seconds" (claim); 03 05:16 "133 shots in just over two minutes" (about 1.0 s; claim) |
| Look | Blocky Roblox characters, expressive 2D faces, textured sets, strong close-ups | 07 and 09 observed. 02 and 03 advise "darker than you'd expect, Roblox-sized heads, texture on every surface" (claim); the two examples are bright, so that part is not confirmed |
| Captions | Word-synchronised, bold, outlined, 1 to 3 words per line, often two lines; a highlighted or capitalised keyword | 07 and 09 observed; 05 01:15, 02 01:07 "a small script adds the captions" |
| Voice | A fast synthetic or heavily edited voice. 07 at 230 and 09 at 316 words per minute; creators use ElevenLabs (01, 03, 05), fish.audio (06), Edge-TTS (02), Google AI Studio (03) | Measured from transcripts |
| Narration person | 09: first person; 07: third person | Observed |
| Sound-off | The rule must be on screen in every shot (03 02:01 to 02:13, claim). 07 does it with a star on every hand | Observed in 07 |
| Orientation trick | Roll the Studio camera 90 degrees, record landscape, rotate | 03 05:39 to 05:49 |

---

## 6. Comparison matrix

Ratings are qualitative and come from what each video shows. "AI-Vid" is the pipeline as documented on 2026-11-17.

| | Method 1: Studio plus MCP (03, 06) | Method 2A: Blender free kit (02) | Method 2B: Blender plus Flashloop (04) | Method 3: Claude-only (01, 05) | AI-Vid |
|---|---|---|---|---|---|
| Look | Real Roblox rendering; quality depends on iteration | Roblox-like low-poly Blender render, plainer surfaces | Blocky 3D, clean, not real Roblox rendering | Flat 2D or primitives | Real Studio rendering, Argon assets, ClockTime 16.8, textured sets |
| Originality control | None shown. Creator picks a rule from ten pitched by Claude | None shown | None shown. Claude invents story from "viral Roblox stories" | None shown | Web-verified premise, saved evidence, a ledger |
| Effort per video | Hours to days with iteration (03 08:14) | Minutes: one-line prompt; render about 5 min (02 01:55) | One prompt, about 30 min (04 04:30) | 20 to 47 min (01) | Hours; several manual gates (manifest, Argon, record, QA) |
| Automation level | Medium: Claude builds, creator records and edits | High | Highest (shown as one prompt) | High | Medium: scripts exist, manual Argon and recording steps |
| Cost | Claude Code subscription, about 1 dollar per Ovra edit, voice service | Free tools plus an AI agent (free plans possible) | Claude Code plus Flashloop credits | Claude plan plus ElevenLabs | Claude Code plus Argon (Gemini) plus Edge-TTS (free) |
| Tooling required | Studio, Claude Code, screen recorder, optional editor | Python, Blender, ffmpeg, an agent | Claude Code, Flashloop connector, Blender (self-installed) | Claude.ai or Claude Code, ElevenLabs | Studio, Studio MCP, Python, ffmpeg, Whisper, Argon |
| Quality ceiling | High if the creator keeps directing | Medium | Medium | Low to medium | High; limited by Argon asset quality and engine camera work |
| Risk | Unvetted prompt or kit, funnel to Skool or Discord | Funnel to CreatorIQ; model comparison is staged | Bypass permissions, vendor lock, Drive download | Unvetted skill, not Roblox (so not the target look) | Rules are strict and some are unmeasured; 60 fps output mismatch |

---

## 7. Where the references agree or disagree with AI-Vid's rules

| Rule in AI-Vid | What the references show | Verdict |
|---|---|---|
| Captions at Y about 82 % (lower third) or about 15 % (upper third), 1 to 3 words (AGENTS.md) | 07: two lines, 4 to 6 words, Y about 64 to 69 %. 09: two lines, 2 to 5 words, Y about 24 to 29 %. 04: one big word, near the lower third (frame 19). 06: one word near 15 % (frame 29). | Disagree. The two finished shorts use both more words and different Y. The 09 entry in `reference/BENCHMARKS.md` is wrong. The "never dead-centre" rule still holds in all examples (Y is never 50 %). |
| Caption colour | 09 highlights one word in green. 07 capitalises one word and keeps the rest lowercase. 02 frames show a yellow highlight word. AI-Vid styles are plain white or plain yellow in capitals | Disagree; the hardening report already lists "caption highlight" as an experiment (section 6). |
| Cut every 1.2 to 2 s, 3 s maximum | 07: 1.26 s average. 09: 1.14 s. 03 claim: about 1.0 s. AI-Vid story 007 part 1: 27 beats averaging 2.07 s with a 4.0 s maximum (measured from `beats_p1.json`) | Partly agree. The references sit at the fast end of AI-Vid's range or just under it. Story 007 breaks its own rule. |
| Camera mix 60 % push-in, 25 % snap pull-out, 15 % impact zoom with 2.5 degree tilt | 03 claims most push-in, a few snaps, "about half" tilted (05:21 to 05:35). Stills show a minority of tilted shots in 07. Not countable from stills | Cannot be confirmed. The tutorial's "half tilted" claim disagrees with AI-Vid's 15 %, but is unmeasured. |
| 30 fps locked | 07 is 30 fps (meta). 09 is 30 fps (ffmpeg). 03 and 06 recordings are 30 fps; 01 is 60 fps, 04 is 25 fps | Agree on 30 fps for the finished shorts. AI-Vid's own final mp4 is 60 fps (ffprobe on story 007 part 1), which disagrees with its own rule. |
| Voice: natural speech about 180 wpm, never sped up; 150 to 175 words per part | 07: about 230 wpm. 09: about 316 wpm. The words per second figure is far above natural. Story 007: 152 words over 49.7 s, about 183 wpm | Disagree. Both example shorts pack more words per second. The reference story length (188 and 186 words) matches AI-Vid's word count, but in 49 s and 35 s instead of up to 60 s. |
| Narration in first person | 09 first person; 07 third person | Partly disagree. A 4.7 million-view example is third person. |
| Sound-off: the rule visible on screen in every applicable shot | 07 does this (star on every hand). 03 states the rule (02:01 to 02:13). 09 shows the object, not a persistent marker | Agree. |
| Hook in the first 1.5 s (strongest image in the first 1.5 s) | 09: rule plus problem in 3.2 s. 07: the first weird rule reaches the listener at 6.7 s | AI-Vid is stricter than both. Fine. |
| Length at most 60 s per part, series welcome | 07: 49 s. 09: 35 s. 05 states 20 to 60 s. 04 example 1 is about 88 s. 03 claims top channels go 2.5 to 3 min | Agree with 60 s for the observed shorts. The longer claims are unmeasured and conflict with each other. |
| Parts and cliffhanger | 03 says the shape ends "on a cliffhanger so people want part two". Link 12's title says "(Part 1)". 07 and 09 are standalone | Agree that series are used. |
| Real Roblox rendering; no Blender-built characters | 02 and 04 build characters in Blender; 05 builds them in a browser | These methods break AI-Vid's rule. The rule stays. |
| Lighting ClockTime 16.8, textured surfaces | 03 04:35 says low sun and long shadows; 02 04:19 says dark clothes and texture; 07 and 09 are bright daytime with textured cobble and timber | Mixed: textured surfaces agree; golden-hour and dark clothes are not what the finished shorts show. |
| Originality: premise web-verified before scripting | No reference shows a check. 04 says "Borrow the format, never the videos" (description) | AI-Vid is stricter. Nothing to adopt. |

---

## 8. What is worth adopting

Ranked by expected benefit divided by cost, except that the two owner-priority areas (assets A, recording and framing B) come first. Items A, B and 1 to 5 are covered by tasks in `docs/ADOPTION_GUIDE_2026-11-17.md`.

| Rank | Item | Expected benefit | Cost | Evidence | AI-Vid files touched |
|---|---|---|---|---|---|
| A | Replace the asset method: Roblox-native rig, printed clothing and face decals from 2D art, hair and hats from layered accessories, dressed Studio-native maps, props with readable text; test with one character and one set against the benchmark tiles | Closes the visible gap between AI-Vid frames and the finished shorts, which is the owner's stated standard | One test character and one test set; Argon's role becomes 2D art | 07 and 09 `sheet_01` and `sheet_02` (benchmark table in section 3.5); Table C failures | `AGENTS.md`, `docs/ARGON_PIPELINE.md`, `docs/LESSONS_LEARNED.md`, `.claude/skills/roblox-characters/SKILL.md`, `templates/production_manifest_template.md`, `assets/INDEX.md` (conditional on the owner's decision) |
| B | Framing and capture fixes: native viewport height of at least 1080 px (or a measured, accepted upscale), 30 fps end to end, a written frame specification (subject size, headroom, safe zones, no occluders, no unreadable macros), a pre-record shot preview, and a camera-mode field per beat | The story 007 beat sheet shows unreadable macros, face occlusion, a hand-first hook and a 966 px capture upscaled to 1080 | Small code and rules changes | `audit_v2/02_after_part1_beat_sheet.png`, `pipeline/record_take.py` REGION, 07 and 09 `full_*` frames | `pipeline/record_take.py`, `pipeline/finish_video.py`, `pipeline/qa_sheet.py`, `.claude/skills/roblox-cinema-director/SKILL.md`, `docs/LESSONS_LEARNED.md` |
| 1 | Make the final output 30 fps (not 60) | Removes the duplicate-frame mismatch the repeated-frame check is meant to catch; matches both example shorts | One line plus a docstring | 07 meta (30 fps), 09 ffmpeg (30 fps); story 007 mp4 `r_frame_rate=60/1`; hardening report weakness 1 | `pipeline/finish_video.py` (line 75 and docstring line 4) |
| 2 | A script that measures any local video like this study (fps, resolution, cut rate, words per minute, contact sheet) | Turns "feels fast" into numbers; lets AI-Vid compare its own output against the references | About 120 lines, ffmpeg only | This study did all of it by hand; 03 05:09 ("I actually counted") shows creators do it too | new `pipeline/measure_video.py` |
| 3 | A beat-table linter (average beat length, maximum, camera-mode counts, missing spoken line, missing sfx file) | Catches the 4.0 s beat in story 007 before recording; the camera-mix rule becomes checkable | About 100 lines | 007 `beats_p1.json`: 27 beats, average 2.07 s, maximum 4.0 s; examples at 1.1 to 1.3 s; hardening report weaknesses 3 and 5 | new `pipeline/check_beats.py`, `.claude/skills/produce-video/SKILL.md` (one new step) |
| 4 | Optional highlighted keyword captions | Matches the style of 09 and the experiment in the hardening report; improves word emphasis with sound off | Small change plus one test | 09 `full_01` to `full_06`, 02 frames | `pipeline/voice_subs.py`, `pipeline/test_voice_subs.py` |
| 5 | Documentation: readable text on key props; planted-details and reveal-that-recasts-the-hook as optional patterns; correct the 09 caption entry | Makes the sound-off rule stronger; fixes a wrong benchmark | Text only | 09 "GLUE" jar, 07 "SCHOOL BUS" and star marks, 03 03:45, 09 transcript | `docs/ENGAGEMENT_RULES.md`, `templates/production_manifest_template.md`, `reference/BENCHMARKS.md` |
| 6 | Owner decision: test a higher-density script (more words per second) on one story | May match the pace of the references; may hurt clarity | Needs an owner decision, one test story | 07 about 230 wpm, 09 about 316 wpm vs 183 wpm in story 007 | `pipeline/voice_subs.py` (`--rate`), `docs/LESSONS_LEARNED.md` if accepted |
| 7 | Owner decision: tighten the cut-rate rule to 1.0 to 1.5 s average | Matches the references | Raises the number of beats in MANIFEST section G and in the engine | 07 1.26 s, 09 1.14 s | `AGENTS.md`, `docs/ENGAGEMENT_RULES.md`, `templates/production_manifest_template.md` |
| 8 | Optional: reuse earlier shots in the final recap line | Fewer new beats in the closing seconds | Needs engine or editing support that does not exist | 07 `sheet_02` tiles 4,4 to 4,6 reuse earlier shots | Not specified; needs design |

**Not worth adopting, and why:**
- **Blender-built characters or scenes (02, 04).** They break AI-Vid's rule against Blender-designed characters and give a plainer look than Studio's own rendering.
- **Browser React/Three.js engines (05) and Claude-sandbox rendering (01).** Not Roblox, low quality ceiling, no shown renderer or export path.
- **Flashloop, Ovra, CreatorIQ, ForgeGUI, ElevenLabs as dependencies.** Paid or credit-based, and in Flashloop's case the skill "only works with flashloop". AI-Vid already has Edge-TTS, Whisper and ffmpeg for voice, captions and finishing at no extra cost.
- **Permission bypass in Claude Code (04).** It removes the checks that AI-Vid's "never record until the owner says record" and one-Studio-job-at-a-time rules depend on.
- **Downloading and running any creator's kit, skill or prompt (01, 03, 04, 05, 06).** None of the contents were shown in full; each sits behind a funnel or a Drive link.
- **One-prompt story generation with no originality check (03, 04, 05, 06, 02).** The story that comes out is whatever the model produces; the tutorials' own example rules (every lie shrinks you, every sneeze teleports you, yawning turns day to night, never be the last awake) are already public and must not be reused. AI-Vid's verified, ledgered, scored story process stays as it is.
- **Grey-box-first and check-picture steps (03, 02).** AI-Vid already has Argon-built sets, a dry run and `pipeline/qa_sheet.py` (one frame per beat).
- **Long 2.5 to 3 min videos (03, claim).** Unmeasured and in conflict with every observed short and with AI-Vid's 60 s rule.
- **"60 stories overnight, auto-uploaded" (06).** Not shown; also conflicts with AI-Vid's originality gate.

---

## 9. Limits of this study

- **Six reels were not studied** (08, 10, 11, 12, 13, 14). Their captions are the only information. No claim about their look is made. Link 09 and 07 are therefore the only two finished examples; they should not be taken as a sample of the genre.
- **Frame sampling.** Each tutorial was inspected through 12 evenly chosen frames out of 30, combined in a montage of 640 px tiles. Details smaller than that (small text, UI) were read with uncertainty, and any claim marked "not shown" may exist in unsampled moments.
- **Contact sheets** are one tile per second, so cuts, camera moves and tilt cannot be measured from them. The cut rates are ffmpeg scene-detection counts at threshold 0.3 and were not checked frame by frame; flashes and aura effects can add false cuts.
- **Transcripts** are auto-generated (01, 02, 04, 05, 06, 09) and not hand-checked. Numbers read from transcripts (word counts, wpm) assume complete transcripts; wpm is word count divided by the video length.
- **Voice quality, music and sound effects** cannot be judged from transcripts and were not heard. Voice identity (human or synthetic) is undetermined for 07 and 09.
- **The skills, kits and prompts themselves** were never downloaded or read. Everything said about them is what the creators say or show on screen.
- **The 01 render method** (what code produced the mp4) cannot be determined from the video.
- **R6 versus R15** could not be determined at 360x640 resolution.
- **All numerical claims by the creators** (views, subscribers, earnings, "133 shots", "12 of 13") are unverified.
- **Prices** of Claude Code, Flashloop, ElevenLabs, fish.audio and ForgeGUI are not stated in the videos.
- The Google Drive, Skool, Discord, claude.ai artifact and app-store links found in the descriptions were recorded as text only and not opened: `drive.google.com/drive/folders/1c92Y27a3fhz5RD8KE_dGcgGzWqepiBTG` (01), `skool.com/creatoriq-8383` and `claude.ai/artifact/PwVEZxBCwhwi9PqMqZjsPG` (02), `ovra.pro/roblox` and `skool.com/simplyazan` (03), `links.flashloop.app/f1TXwRNS` and `drive.google.com/file/d/1RzHShy9AqRA8vpaEIqXJzV2HjOr2isfv` (04), `drive.google.com/drive/folders/1b_CTxwRiPViQ06QxNYhqdBrqmEoNC-OH` (05), `discord.gg/GgV7TWpwd9`, `forgegui.com` and `ko-fi.com/fwjelaa` (06).
