# UltraRogue — RVIP port

Upstream: UltraRogue 1.0.7 (Herb Chong), from the Roguelike
Restoration Project: https://github.com/RoguelikeRestorationProject/urogue/tree/8dec2be

**Our changes:** https://github.com/memmaker/urogue/compare/8dec2be...master
(commit 1 is the untouched upstream; everything after it is ours).

- `port:` builds on macOS/arm64 and WebAssembly, curses shim (`port/`) with
  an X11 frontend, NetHack tiles (`port/mktiles.py`), DawnLike as a second
  set (`port/mkdawn.py`; DragonDePlatino, palette DawnBringer, CC BY 4.0;
  web: *Tiles* button, desktop: `TILESET=dawn ./play.sh`); fixes an upstream bug
  that made every save unloadable (`ur_read_room` read an int as a short).
- `RVIP:` auto-explore (`x`), `<`/`>` walk to known stairs, Enter command
  menu, inventory with a cursor, sound events (`rvip.c` + small hooks).
- `web:` browser build (`web/build.sh`), played at https://ruzzoli.de/roguelikes/urogue/

Build: `make urogue-x11` (XQuartz), `./play.sh`; web: `sh web/build.sh`, `web/deploy.sh`.
Notes for the next person: `HANDOVER.md`. Process: `~/Games/RVIP.md`, `~/Games/rogue2wasm.md`.
