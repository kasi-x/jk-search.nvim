--- jk-search.nvim 設定。

local M = {}

---@type JKSearch.Config
M.DATA = {
  -- Chrome 実行ファイル
  chrome = "/usr/bin/google-chrome",
  -- 専用プロファイル (cookie を永続化してログイン状態を維持)
  profile = vim.fn.expand("~/.local/share/jk-search/profile"),
  -- node 実行ファイル
  node = "node",
  -- 検索スクリプトのパス
  script = vim.fn.expand("~/.local/share/jk-search/bin/jk-search.js"),
  -- 検索履歴 (JSON) の保存先
  history_file = vim.fn.expand("~/.local/share/jk-search/history.json"),
  -- true ならバックグラウンド Chrome をヘッドレスで起動する (ウィンドウ非表示)。
  -- false なら可視ウィンドウで起動する (初回ログイン時はこちらの方が分かりやすい)。
  headless = false,
  -- 所属機関の OpenAthens リダイレクタ URL (必須)。
  -- 例: "https://go.openathens.net/redirector/<your-domain>"
  redirector = "",
  -- OpenAthens proxy のベース URL (必須)。
  -- 例: "https://<resource>.proxy.openathens.net"
  proxy = "",
}

---設定を更新する。
---@param opts? table
function M.setup(opts)
  if opts then
    M.DATA = vim.tbl_deep_extend("force", M.DATA, opts)
  end
end

return M
