# UltraRogue 1.0.7 — RVIP handover (2026-09-25)

Third game of the Advanced Rogue line ported (after `~/Games/arogue7.7`
and `~/Games/arogue5.8`; read their HANDOVERs). UltraRogue is ANSI C with
prototypes, so fewer 64-bit traps, but it differs more:

- `rogue.h` has `typedef void daemon;` and macOS declares `daemon()` in
  `stdlib.h`/`unistd.h`: include those first, then `#define daemon ur_daemon`.
- `mdport.c`/`xcrypt.c` were missing from the Makefile's CFILES.
- No message window: messages go on row 0 of `cw` (like Rogue 5.4). The
  shim now treats the map window's row 0 as the message line when the game
  has no `msgw` (`state.c` defines an empty `msgw`).
- `file_name` was empty (the game asked for a name): now `$HOME/urogue.sav`.
- **Upstream save bug:** `ur_read_room()` read `r_flags` as a short after
  writing an int, so every restore failed (garbage string length). Fixed.
- Item prompts go through `get_object()` (returns objects, not list nodes).
- Help list uses `{ key, "text" }` pairs and ends at `{'-', 0}` before the
  wizard commands; the Enter menu stops there, docs use `parse_brace_helpstr`.
- ~400 monsters: `port/mktiles.py` maps unknown names with `RULES`
  (keyword → closest NetHack tile).
- 10 classes; `<` works only while carrying the artifact (upstream rule).
