# Changelog

All notable changes to the mod scripts are documented here.
The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).

## [Unreleased]

### Added

- **Random board.** The «ПОЛЕ» setup option now cycles База → Эллада → Элизий → **Рандом**. With «Рандом», `mapSelect()`
  in Global picks one of the three boards at random when the game starts and announces it in chat.
- **Alternating turn order** (new setup option «ЧЕРЕДОВ. ХОДА», off by default). With the option off, turns always pass
  clockwise, as before. With it on, the action phase goes clockwise (←) in even generations and counter-clockwise (→)
  in odd ones, like the draft, so no player always depends on the same neighbour. It uses TTS's built-in
  `Turns.reverse_order`, set at the start of each action phase. The direction is announced in chat. The option label and
  checkbox are drawn on a new settings tile image in the same style as the other options
  ([assets/settings-tile.png](assets/settings-tile.png), uploaded to Steam Cloud and set on tile `86fef0` in the save).
- **Venus track bonuses.** When a player raises Venus to 8%, they get a project card (dealt into the small hand, like
  any card drawn from the deck). At 16% they get one extra TR. This works for the `+` button on the Venus board
  and for the «Очистка воздуха» standard project: both now go through one function, `raiseVenus`, in the
  «Стандартные проекты» script (`f802b0`), which redirects the board's `+` button to itself. A Venus raise from
  government support gives no bonus, as in the rules.
- **Venus standard project** «Очистка воздуха» (15 M€). The Venus board now has a button on its standard project, like
  the standard projects on the Mars board: after confirmation it takes 15 M€, raises Venus by one step (2%) and gives
  the player 1 TR. It is disabled at 30%. The button is created from the «Стандартные проекты» script (`f802b0`)
  when the Venus board is taken out of its bag during setup, or on load if a Venus game is already running.

### Changed

- **Draft** (setup option «Драфт»). The old draft passed cards automatically as soon as every player had exactly the
  expected number of cards in the hidden draft zone. It gave no feedback and hung silently on any mistake. Now, during
  the draft only, every player sees their own «Готов передать карты» button on the right side of the screen. The text is red while the
  player is not ready and turns green after a click. The button also shows the direction (← clockwise in even generations,
  → counter-clockwise in odd ones). When all players are ready, the script checks the cards: the right number in the
  draft zone, the rest in the hand, nothing held. If something is wrong, it tells the player and resets their button.
  Otherwise the remaining cards go to the neighbour. The last card joins the hand by itself, the draft zones are removed
  and the buying phase starts. The chat shows who is ready (`N/M`) and the current round. The on-screen tip now says
  where to put the card (the zone *below* the hand, not above).

### Fixed

- **Automation breaking when a player disconnects.** Several places in Global assumed every player is seated:
  - the first-player announcement used `Player[color].steam_name`, which is `nil` for a disconnected player. The Lua
    error stopped the start of the generation: no cards dealt, no draft, no buying phase. Names now go through
    `playerName(color)`, which falls back to the colour;
  - `deal4card` used `deck.deal(4)`, which deals only to seated players. Each player in the game now gets 4 cards
    explicitly (`deal(4, color)`), so a disconnected player has their cards waiting when they come back and the draft
    count still matches;
  - government support showed its dialog only to the first player. If they are away, the first seated player
    chooses, and the chat says so;
  - loading a save rebuilt the player list from whoever was seated at that moment, so a disconnected player dropped
    out of production, turns and the draft. The saved list is now kept;
  - the draft prints who it is waiting for and marks disconnected players «(не за столом)». They press their button
    when they come back.
- **Player markers falling under tiles.** For the greenery and city standard projects and for the plant-to-greenery
  conversion on player boards, the tile and the player's marker (cube or city figure) were taken out of their bags at
  the same time and almost at the same point. The marker could spawn inside the tile and get pushed under it. Now the
  marker is taken only when the tile has finished spawning (`takeObject` `callback_function`), 1.5 units above it, and
  falls onto it.
- **Draft direction not shown for the host.** The direction arrow was part of each player's button text, changed with
  `UI.setValue`. On these per-player buttons (`visibility="<colour>"`) the change reached other players but not the
  host, who kept the plain «Готов передать карты». The button text is now constant, and the direction
  (`←  по часовой` / `против часовой  →`) is a separate line above the buttons. It is shared by all players and has no
  visibility restriction.
- **Steel and titanium value on player boards.** Right-clicking the steel or titanium value and entering a new price
  (e.g. 3 instead of 2) saved the number but updated the wrong buttons. Steel overwrote the heat cost label, and
  titanium changed an invisible button. The value on the board stayed 2/3. Both now update their own labels
  (`Button.Steel` / `Button.Titan`) in all five player zone scripts.

## 2026-10-03

### Fixed

- **Total city counter** («Всего городов», `Counter.8df3e7`). The old script counted cities only inside two scripting
  zones. The Mars zone (`f83d45`) floats about 20 units above the table, and the second zone (`62b7cb`) covers only the
  colony area, so the counter stayed at 0. It now counts every object with the description «Город» anywhere on the
  table: Mars, Ganymede Colony, Phobos Space Haven, the Venus board and the Capital tile. It recounts one second after a
  city tile is dropped, deleted or put into a container, and on load.

### Added

- **Mars-surface city counter** («Городов на поверхности Марса», `Counter.d6dfbb`). Same script with
  `ONLY_MARS = true`: a city counts only if it lies within the Mars disc on the board, so off-Mars spaces and Venus
  are excluded.

## 2026-10-03 — baseline

- Original scripts of «Покорение Марса [Rus Scripted]» (Steam Workshop 3389459032), used as the rollback point.
