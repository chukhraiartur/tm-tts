# Terraforming Mars (Rus Scripted) — script improvements for Tabletop Simulator

Bug fixes and small quality-of-life improvements for the Lua scripts of the Russian-language Tabletop Simulator mod
**«Покорение Марса [Rus Scripted]»** ([Steam Workshop 3389459032](https://steamcommunity.com/sharedfiles/filedetails/?id=3389459032)).

The original mod is already heavily automated. This repository keeps its scripts under version control and fixes the
remaining bugs in small, isolated steps.

## Latest changes

- **Fixed:** player cubes and city figures no longer fall under greenery and city tiles placed by the automation.
- **Fixed:** the draft direction (← / →) is now a separate line above the draft button, visible to every player
  including the host.
- **Added:** «Рандом» value for the board setup option: a random board out of Tharsis, Hellas and Elysium.
- **Added:** setup option «ЧЕРЕДОВ. ХОДА»: turns pass clockwise in even generations and counter-clockwise in odd ones.
- **Added:** Venus track bonuses: a project card at 8% and an extra TR at 16% for the player who raised Venus.
- **Fixed:** changing the steel or titanium value on a player board (right-click) now updates the shown number.
- **Changed:** the draft now has a per-player «ready to pass cards» button (red/green, with the passing direction).
  Cards are passed when everyone is ready, and mistakes are reported in chat instead of hanging the game.
- **Added:** the Venus standard project «Очистка воздуха» (15 M€) is now a button: it pays 15 M€, raises Venus by one
  step and gives 1 TR, like the standard projects on the Mars board.
- **Fixed:** the «Всего городов» (total cities) counter now counts every city tile on the table: Mars, Ganymede Colony,
  Phobos Space Haven, the Venus board and the Capital tile.
- **Added:** a «Городов на поверхности Марса» (cities on the Mars surface) counter for cards that only count cities on Mars.

Full history: [CHANGELOG.md](CHANGELOG.md).

---

## Contents

- [Core automation](#core-automation)
- [Game boards and expansions](#game-boards-and-expansions)
- [Game setup options](#game-setup-options)
- [Development](#development)
- [Future improvements](#future-improvements)
- [Credits](#credits)

## Core automation

Most of the game flow is scripted. Players mainly play cards and place tiles.

- **Setup.** One click lays out the chosen board and expansion boards, builds the decks, deals the starting cards,
  sets up milestones, awards and sponsor tokens, and picks a random first player.
- **Phases.** Every player has a ready/pass "rocket". When everyone is ready, the game moves on: research → actions →
  production → (Turmoil) solar phase → next generation. On-screen tips explain the current phase.
- **Production.** At the end of a generation, energy turns into heat and production plus TR income is added to every
  player's resources automatically. Changes are written to the «Лог ресурсов» (resource log) tab. The game-end condition is checked
  every generation.
- **Player boards.** Resource amounts are digital counters, and production cubes are moved by script. There are buttons to convert heat to temperature and plants
  to greenery, and to change steel and titanium values. TR is tracked with a counter next to the board.
- **Standard projects.** Buttons with a confirmation dialog: sell patents, power plant, asteroid, aquifer, greenery,
  city.
- **Global parameters.** Oxygen and temperature markers have +/- buttons. The ocean stack shows how many oceans are
  left (`N / 9`). The generation marker moves along the track by itself.
- **Research.** Card buying at 3 M€ each, with an optional draft from generation 2 on: each player drags one card
  into the draft zone below their hand and presses their «ready to pass» button. When everyone is ready, the remaining
  cards go to the neighbour: clockwise (←) in even generations, counter-clockwise (→) in odd ones. The «СБРОС» (discard) button returns a player's hand
  cards to the correct discard piles.
- **Board scoring.** The chat command `!поле` highlights tiles and prints city and greenery points per player
  (see [Future improvements](#future-improvements)). The command `!поле ` (with a trailing space) clears the labels.
- **City counters.** Two counters next to the board: all cities, and cities on the Mars surface.

## Game boards and expansions

The sections below follow the release order of the physical board game. Russian names are the ones used in the mod.

### Base game (2016)

- Tharsis board, project and corporation decks, milestones and awards.
- Standard projects, global parameters and player boards, all automated as described above.

### Corporate Era — «Эра корпораций» (2016)

Shipped in the base game box as a variant.

- 67 projects, 4 promo projects, 2 corporations.

### Hellas & Elysium — «Эллада» и «Элизий» (2017)

- Two more boards, chosen in the setup options: «база» (Tharsis), «Эллада», «Элизий».
- Both boards have the off-Mars Ganymede Colony and Phobos Space Haven spaces. Cities placed there count towards the
  total city counter but not towards the Mars-surface counter.

### Venus Next — «Венера» (2017)

- Venus board, 49 projects, 5 corporations, the «Авиатор» milestone and the «Венерианец» award.
- City spaces on Venus count towards the total city counter.
- The «Очистка воздуха» standard project (15 M€) is a button with confirmation: pays, raises Venus, gives TR.
- Venus track bonuses are automatic: a project card at 8% and an extra TR at 16% for the player who raised Venus
  (with the `+` button or the standard project).
- Option: Venus must be fully terraformed for the game to end.

### Prelude — «Пролог» (2018)

- 35 preludes, 7 projects, 5 corporations.
- The number of preludes to choose from is set in the setup options.

### Colonies — «Колонии» (2018)

- 11 colony tiles, 49 projects, 5 corporations, trade fleets.
- Automatic colony track movement each generation. Trade fleets return at the end of a generation.
- Trading is started by script and asks which resource to pay with (M€, titanium or energy).

### Turmoil — «Кризис» (2019)

- Events board and government board, 36 global events, 17 projects, 6 corporations, delegates.
- Ruling party and global events are handled in the solar phase.
- Option: lower TR in the solar phase.

### Ares — «Арес»

- 23 projects (11 are updated versions of existing cards), 22 special tiles (11 updated).

### Pathfinders — «Первооткрыватели»

- Planetary tracks board, 10 special tiles, 6 events, 16 preludes, 2 colonies, 60 projects, 23 corporations.

### Underworld — «Подземный мир»

- 91 underground resource tokens, 92 projects, 12 corporations, 15 preludes, 5 events, 3 colonies, corruption counters.

### Sponsorship — «Спонсорство»

- 26 sponsor tokens.

> Release years are given only where they are certain. Ares, Pathfinders, Underworld and Sponsorship are listed in
> the order the mod's own settings panel shows them.

## Game setup options

All options are set on the settings tile before the game starts:

| Option | Description |
| --- | --- |
| Expansions | Turn each expansion above on or off |
| Corporations / preludes to choose | How many cards each player is dealt |
| Board | Tharsis, Hellas, Elysium or «Рандом» (one of the three at random, announced at game start) |
| Government support | At the end of a generation the first player raises one global parameter without getting its bonus |
| TR recalculation | Lower TR in the solar phase (Turmoil) |
| Draft | Players pass cards during the research phase |
| Mandatory Venus | The game ends only after Venus is fully terraformed |
| Random milestones & awards | Replaces the board's milestones and awards with 5 (6 with Venus) random ones out of 62 |
| Custom start | Players get 2–4 milestone, award, colony and sponsor tokens and choose which ones go on the table |
| Alternating turns («ЧЕРЕДОВ. ХОДА») | Off: turns always pass clockwise. On: clockwise in even generations, counter-clockwise in odd ones |

## Development

### Tools

- [Tabletop Simulator](https://store.steampowered.com/app/286160/).
- VS Code with:
  - [Tabletop Simulator Editor](https://marketplace.visualstudio.com/items?itemName=sebaestschjin.tts-editor)
    (`sebaestschjin.tts-editor`), which implements the TTS External Editor API.
    Docs: <https://sebaestschjin.github.io/tts-tools/editor/latest/>.
  - [Lua](https://marketplace.visualstudio.com/items?itemName=sumneko.lua) (`sumneko.lua`) with the TTS API type
    library (`language-server.zip` from
    [typed-tabletop-simulator](https://github.com/Sebaestschjin/typed-tabletop-simulator/releases)) added to
    `Lua › Workspace: Library`.

### Repository layout

```
.tts/
  objects/   # scripts you edit: Global.lua/.xml and <Name>.<GUID>.lua/.xml/.data.json per scripted object
  bundled/   # the same scripts as sent to TTS (written by the extension)
```

Only objects that have a script are exported. Objects without a script (boards, most tiles, scripting zones) exist only
in the TTS save file.

### Workflow

1. Subscribe to the mod, load it once and **save it as your own game** (Games → Save & Load → Save). Always work with
   that save. Save and Play cannot write to a Workshop mod and fails with
   `Error cannot commit save changes to a workshop mod`.
2. If you change anything on the table (add, move or rename objects), save the game in TTS **before** running
   Save and Play. Save and Play keeps only scripts and UI, and table changes after the last save are lost.
3. Edit scripts in `.tts/objects/`.
4. In VS Code run **Tabletop Simulator: Save And Play** (`Ctrl+Shift+P`). The table reloads with the new code and
   sends all scripts back to VS Code. You don't need to save the game again afterwards.
5. Check the TTS chat for red errors and make sure the edited file still contains your version.

Notes:

- **Load the save before you edit.** When TTS loads a game, the extension overwrites all files in `.tts/` with the
  scripts from that game. Local edits not yet sent with Save and Play are lost.
- The extension sends only the objects it currently knows about. They are registered when TTS loads a game or when
  you run **Get Objects**. After restarting VS Code without reloading the table, run Get Objects first, otherwise
  Save and Play sends nothing and your local edits are overwritten by the old scripts.
- Every table reload rewrites all `*.data.json` files with the current object state (positions, counter values,
  line endings). These diffs are noise: commit only the files of objects whose script you changed (`objects/*.lua`,
  `bundled/*.lua`, and that object's `*.data.json`) and discard the rest with `git restore .tts/objects/`.

## Future improvements

- **Fix the `!поле` board scoring command.** It reads tiles from scripting zone `f83d45`, which floats about 20 units
  above the table, so it most likely finds nothing. The old city counter failed for the same reason.
- **Check the Mars-surface counter on Tharsis.** The Mars disc centre and radius were calibrated on the Hellas/Elysium
  board. Tharsis is a separate object and may need slightly different values.
- **Tharsis Republic house rule.** Test a small nerf of the corporation, changing one parameter at a time.
- **Track bonuses after a decrease.** Like temperature and oxygen, a Venus bonus is given again if the marker is
  lowered with `-` and raised past the same mark. The tracks could remember which bonuses were already given.
- **Resume the draft after a reload.** The research phase (`STEP = 5`) is not restored in `onLoad`, so reloading the
  table in the middle of a draft loses the draft state.
- **Undo support for the city counters.** After `Ctrl+Z` the counters update only on the next action with a city tile.
- **Original author's TODO list** (from the header of `Global.lua`): automatic colony trading, automatic placement of
  neutral delegates, delegate handling as in the rules, moving global parameter counters into the Global script,
  and translation errors on several Pathfinders, Turmoil and Underworld cards.

## Credits

- Original mod and scripts: «Покорение Марса [Rus Scripted]» by **4EPBRK_6RK_6RK**.
- *Terraforming Mars* is designed by Jacob Fryxelius and published by FryxGames. All game content belongs to its
  respective owners. This repository contains only script changes for personal use.
