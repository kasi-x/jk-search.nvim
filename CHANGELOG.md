# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- `jksearch.word` モジュール: カーソル下の語の特定・複合名詞の展開・
  表示幅の切り詰めを純粋関数として分離 (単体テスト可能に)
- config / history / word モジュールの busted テスト (Chrome・ネットワーク不要)

### Changed

- `truncate()` がグローバル `utf8` (lua-utf8) に依存しなくなった
  (`utf8.charpattern` で直接走査)

### Fixed

- 機関固有の OpenAthens URL を既定値に含まないよう変更。
  `redirector` / `proxy` は `vim.g.jksearch_configuration` (または
  `JK_REDIRECTOR` / `JK_PROXY` 環境変数) での設定が必須
- `vim.g.jksearch_configuration` が plugin 読み込み時に `config.setup()`
  に渡されていなかった問題
