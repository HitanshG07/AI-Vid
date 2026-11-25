import json

judgments = {
    "stories/_inbox/story_01.judge.json": {
        "writer_model": "gemini-3.8-flash",
        "judge_model": "claude-3-7-sonnet",
        "scores": {
            "hook_2s": 9.2,
            "stakes": 9.4,
            "rule_consistency": 9.5,
            "technical_validity": 10.0
        },
        "mean_score": 9.53,
        "pass": True,
        "reason": "KILL SWITCH EVALUATION: PASS. 1. Hook (9.2/10): The short opens in media res with an immediate, poignant consequence: 'Sixteen years. No one ever spoke my name.' Accompanied by closeup push-in and wooden footsteps SFX, it arrests viewer attention in under 2 seconds without any world-rule lecture. 2. Stakes (9.4/10): High emotional resonance and mortal danger. Eli's isolation is challenged by bully Jax, culminating in a life-or-death truck collision where genuine sacrifice is on the line. 3. Rule Consistency (9.5/10): The premise rule ('You cannot physically speak a person's name unless you would die to protect them') is strictly and beautifully honoured. Jax is unable to say Eli's name until the exact second he dives into oncoming traffic to push Eli to safety, proving his willingness to sacrifice his life. Zero deus ex machina. 4. Technical Validity (10.0/10): Fully compliant with assets/manifest.json. All spots (sidewalk_left, sidewalk_right, crosswalk, bus_stop, road_center) exist in street_day; all actions, cameras, and active SFX are verified. 22 beats, 52.8s runtime, 54.5% non-narrator dialogue, preflight lint passed."
    },
    "stories/_inbox/story_02.judge.json": {
        "writer_model": "gemini-3.8-flash",
        "judge_model": "claude-3-7-sonnet",
        "scores": {
            "hook_2s": 9.0,
            "stakes": 8.6,
            "rule_consistency": 8.2,
            "technical_validity": 10.0
        },
        "mean_score": 8.95,
        "pass": True,
        "reason": "KILL SWITCH EVALUATION: PASS. 1. Hook (9.0/10): Starts consequence-first with an immediate ding SFX and 'My phone buzzed. Daily luck: one hundred percent.' High-concept curiosity hook within 2 seconds that compels the viewer to keep watching. 2. Stakes (8.6/10): Classic social karma. Dex's hubris causes him to strut around school betting his reputation, believing he has finally become beloved, setting up a sharp comedic downfall. 3. Rule Consistency (8.2/10): The rule that daily luck equals smiles caused yesterday holds firm: the twist reveals that 100 students smiled because they believed Dex had transferred away forever. The final beat where his luck drops to zero after the truth is exposed is a slightly abrupt comedic punctuation, but the core twist mechanic strictly follows the established law. 4. Technical Validity (10.0/10): Spotless adherence to assets/manifest.json. All spots exist in school_yard; all camera shots, actions, and active SFX (ding, whoosh, thud, stone_thud, bell_clang_loud, drone_smash) are valid. Preflight lint passed at 22 beats and 52.8s."
    },
    "stories/_inbox/story_03.judge.json": {
        "writer_model": "gemini-3.8-flash",
        "judge_model": "claude-3-7-sonnet",
        "scores": {
            "hook_2s": 9.3,
            "stakes": 9.2,
            "rule_consistency": 9.7,
            "technical_validity": 10.0
        },
        "mean_score": 9.55,
        "pass": True,
        "reason": "KILL SWITCH EVALUATION: PASS. 1. Hook (9.3/10): Atmospheric and instant: 'Ten AM. The courtyard was a ghost town.' Zane prowls an empty courtyard while Mia cowers, visible to the audience but invisible to Zane. Readable on mute, immediate tension. 2. Stakes (9.2/10): Psychological karma with genuine emotional weight. The school bully achieves complete intimidation, only to realize total dominion results in agonizing, total sensory isolation. 3. Rule Consistency (9.7/10): Flawless inverse logic. The rule states one is completely blind to anyone who fears them; Toby remains fully visible calmly eating lunch because he has zero fear of the bully ('Why would I fear a clown?'). Zero plot holes, zero deus ex machina. 4. Technical Validity (10.0/10): 100% compliant with assets/manifest.json for school_yard. Verified spots, active SFX (footsteps_wood, whoosh, heartbeat, chime_soft, stone_thud), valid cameras, and R6 actions. Preflight lint passed (22 beats, 52.8s, 40.9% non-narrator dialogue)."
    },
    "stories/_inbox/story_04.judge.json": {
        "writer_model": "gemini-3.8-flash",
        "judge_model": "claude-3-7-sonnet",
        "scores": {
            "hook_2s": 5.5,
            "stakes": 6.0,
            "rule_consistency": 7.5,
            "technical_validity": 10.0
        },
        "mean_score": 7.25,
        "pass": False,
        "reason": "KILL SWITCH EVALUATION: FAIL (Kill Switches 1 & 2). 1. Hook (5.5/10 - KILL SWITCH 1 FAILURE): Violates the hard rule against world-rule lecturing at the opening. Beats 1-2 open with static exposition: 'In our school, handshakes are a binding contract. You can't let go until your promise is kept.' There is zero in media res action, trouble, or visual engagement in the first 0-3 seconds. 2. Stakes (6.0/10 - KILL SWITCH 2 FAILURE): Weak, trivial stakes. Chad promises Ned will be popular, so he simply buys pizza and hands out flyers. Furthermore, it completely fails the V5.4 spoiler test: by beat 4, the entire plot is 100% predictable with zero second turn or clever reframe. 3. Rule Consistency (7.5/10): The locking hand mechanic releases when the promise is kept, which is mechanically literal, but lacks any clever loophole, irony, or narrative twist. 4. Technical Validity (10.0/10): Technically compliant with manifest schemas and passes preflight lint, but fails core editorial criteria."
    },
    "stories/_inbox/story_05.judge.json": {
        "writer_model": "gemini-3.8-flash",
        "judge_model": "claude-3-7-sonnet",
        "scores": {
            "hook_2s": 7.5,
            "stakes": 8.8,
            "rule_consistency": 9.6,
            "technical_validity": 10.0
        },
        "mean_score": 8.98,
        "pass": True,
        "reason": "KILL SWITCH EVALUATION: PASS. 1. Hook (7.5/10): Opens with 'In our school, spoken words carry a price', which brushes close to rule exposition, but immediately pivots within 2-4 seconds into an explosive high-concept premise: speaking costs your exam percentage, contrasting slackers speaking for pennies while the 99% valedictorian goes broke saying hello. Instant scroll-stopping concept. 2. Stakes (8.8/10): High emotional and institutional stakes. Tara risks her perfect academic career to expose the Dean's embezzlement of school funds at the championship debate. 3. Rule Consistency (9.6/10): Masterful execution of the clever_loophole engine. Tara deliberately marks every answer wrong to score a zero; at 0%, her cost per sentence is mathematically $0.00, granting her unlimited free speech to dismantle the corrupt dean. Pure adherence to premise mechanics without deus ex machina. 4. Technical Validity (10.0/10): Full manifest compliance. Verified spots on school_yard, active SFX (ding, stone_thud, whoosh, bell_clang_loud, thud, resolution_chord), cameras, and R6 actions. Preflight lint passed (22 beats, 52.8s)."
    },
    "stories/_inbox/story_06.judge.json": {
        "writer_model": "gemini-3.8-flash",
        "judge_model": "claude-3-7-sonnet",
        "scores": {
            "hook_2s": 9.5,
            "stakes": 9.0,
            "rule_consistency": 4.5,
            "technical_validity": 10.0
        },
        "mean_score": 8.25,
        "pass": False,
        "reason": "KILL SWITCH EVALUATION: FAIL (Kill Switch 3). 1. Hook (9.5/10): Outstanding opening in media res: gold coins clinking in a ragged coat while an officer draws a weapon shouting 'Freeze! Drop the stolen gold!' Consequence-first, audible, visual, gripping. 2. Stakes (9.0/10): High stakes involving an orphan accused of bank robbery facing incarceration by a corrupt municipal government. 3. Rule Consistency (4.5/10 - KILL SWITCH 3 FAILURE): Catastrophic violation of the premise rule mechanics. The established rule explicitly dictates: 'Lying to protect someone else drops a gold coin in their pocket; lying to protect yourself dissolves one from yours.' In the climax, the Mayor lies on TV claiming no children are starving in order to protect HIS OWN political career and PR. Under the rule, this is a lie to protect himself, which must dissolve his own coins! Instead, the script claims his selfish lie dropped coins into Leo's coat. Furthermore, the coins appearing with the Mayor's personal eagle crest is an ungrounded deus ex machina invented to convict him on the spot. 4. Technical Validity (10.0/10): Technically compliant with street_day manifest spots and actions, but fails on premise logic parity."
    },
    "stories/_inbox/story_07.judge.json": {
        "writer_model": "gemini-3.8-flash",
        "judge_model": "claude-3-7-sonnet",
        "scores": {
            "hook_2s": 7.5,
            "stakes": 5.5,
            "rule_consistency": 3.0,
            "technical_validity": 10.0
        },
        "mean_score": 6.50,
        "pass": False,
        "reason": "KILL SWITCH EVALUATION: FAIL (Kill Switches 2 & 3). 1. Hook (7.5/10): Creepy and atmospheric with creaking floorboards and a cobwebbed journal, though slower to reveal character conflict. 2. Stakes (5.5/10 - KILL SWITCH 2 FAILURE): Severe logical incoherence undermines the emotional stakes. If writing in the journal erases memory from one's mind, Sam writing 'Do not forget Cole' is a self-defeating paradox. 3. Rule Consistency (3.0/10 - KILL SWITCH 3 FAILURE): Complete narrative breakdown and deus ex machina. The premise defines an internal memory curse: 'Whatever memory you write down on paper is permanently erased from your own mind.' In the climax, this is arbitrarily mutated into an existential deletion and ghost story: a literal ghost (GhostBro) appears in the room stating 'The last word erases me completely', and tearing the page in half miraculously resurrects Cole into a physical silhouette beside the door! Moreover, Mother's memory loss is unexplained under a rule where writing only erases from 'your own mind'. Total violation of premise mechanics. 4. Technical Validity (10.0/10): Valid cozy_room spots and actions, preflight lint passed, but story logic fails completely."
    }
}

for path, data in judgments.items():
    with open(path, "w", encoding="utf-8") as f:
        json.dump(data, f, indent=2)
    print(f"Wrote {path}")
