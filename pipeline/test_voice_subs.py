"""Self-check for script_lock + chunk_words: python pipeline/test_voice_subs.py"""
from voice_subs import script_lock, chunk_words

w = lambda *ws: [{"word": x, "start": i * 0.3, "end": i * 0.3 + 0.25} for i, x in enumerate(ws)]

# count mismatch (whisper split a hyphenated word) must still fix homophones
out = script_lock(w("For", "taps.", "thirty", "-year-old", "skin."), "Four taps. Thirty-year-old skin.")
assert [x["word"] for x in out] == ["Four", "taps.", "Thirty-year-old", "skin."], out

# never end a card on a function word ("OFF FOR HIS", "DO I SPEND / IT ON HER?")
for words in (w("Mia", "leaned", "in", "to", "watch."), w("off", "for", "his", "phone."), w("Do", "I", "spend", "it", "on", "her?")):
    for c in chunk_words(words):
        assert c[-1]["word"].lower().strip(".,!?") not in {"in", "to", "for", "his", "the", "a", "my", "her"} or c[-1]["word"][-1] in ".,!?", [x["word"] for x in c]
print("ok")
