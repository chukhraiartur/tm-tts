# Changelog

All notable changes to the mod scripts are documented here.
The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).

## [Unreleased]

### Added

- **Venus track bonuses.** When a player raises Venus to 8%, they get a project card (dealt into the small hand, like
  any card drawn from the deck). At 16% they get one extra TR. This works for the `+` button on the Venus board
  and for the «Очистка воздуха» standard project: both now go through one function, `raiseVenus`, in the
  «Стандартные проекты» script (`f802b0`), which redirects the board's `+` button to itself. A Venus raise from
  government support gives no bonus, as in the rules.

### Fixed

- **Steel and titanium value on player boards.** Right-clicking the steel or titanium value and entering a new price
  (e.g. 3 instead of 2) saved the number but updated the wrong buttons. Steel overwrote the heat cost label, and
  titanium changed an invisible button. The value on the board stayed 2/3. Both now update their own labels
  (`Button.Steel` / `Button.Titan`) in all five player zone scripts.

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

### Added

- **Venus standard project** «Очистка воздуха» (15 M€). The Venus board now has a button on its standard project, like
  the standard projects on the Mars board: after confirmation it takes 15 M€, raises Venus by one step (2%) and gives
  the player 1 TR. It is disabled at 30%. The button is created from the «Стандартные проекты» script (`f802b0`)
  when the Venus board is taken out of its bag during setup, or on load if a Venus game is already running.

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
