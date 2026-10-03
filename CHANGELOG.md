# Changelog

All notable changes to the mod scripts are documented here.
The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).

## [Unreleased]

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
