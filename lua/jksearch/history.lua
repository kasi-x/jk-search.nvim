--- jk-search.nvim 検索履歴の保存・読み込み。
---
--- 検索結果と意味全文をローカルに JSON で保存する。
--- 同じ語を再度検索したときに、ネットワークアクセスなしで再利用できる。
---
--- 保存ファイル: ~/.local/share/jk-search/history.json
--- 構造:
---   {
---     "実験": {
---       "query": "実験",
---       "searched_at": "2026-08-15T12:00:00",
---       "results": [ { "title", "dict", "snippet", "url", "exact", "text" } ]
---     }
---   }

local M = {}

local config = require("jksearch.config")

---履歴ファイルのパス。
---@return string
function M.file()
  return config.DATA.history_file or vim.fn.expand("~/.local/share/jk-search/history.json")
end

---履歴全体を読み込む。無ければ空テーブル。
---@return table<string, any>
function M.load()
  local path = M.file()
  if not vim.fn.filereadable(path) then
    return {}
  end
  local ok, lines = pcall(vim.fn.readfile, path)
  if not ok or not lines then
    return {}
  end
  local ok2, data = pcall(vim.json.decode, table.concat(lines, "\n"))
  if ok2 and type(data) == "table" then
    return data
  end
  return {}
end

---履歴全体を書き込む (保存先ディレクトリを作成する)。
---@param data table
function M.save(data)
  local path = M.file()
  local ok_dir, _ = pcall(vim.fn.mkdir, vim.fn.fnamemodify(path, ":h"), "p")
  if not ok_dir then
    return
  end
  local ok, json = pcall(vim.json.encode, data)
  if ok then
    pcall(vim.fn.writefile, vim.split(json, "\n", { plain = true }), path)
  end
end

---指定クエリの保存済み結果を返す。無ければ nil。
---@param query string
---@return table|nil
function M.get(query)
  local data = M.load()
  return data[query]
end

---検索結果を保存する (新しいクエリのみ、既存は上書きしない)。
---exact フラグは results の各項目に付けて渡す。
---@param query string
---@param results table[] 検索結果一覧
function M.store_search(query, results)
  if not query or query == "" then
    return
  end
  local data = M.load()
  if data[query] then
    return -- 既に保存済みなら上書きしない
  end
  data[query] = {
    query = query,
    searched_at = os.date("%Y-%m-%dT%H:%M:%S"),
    results = results,
  }
  M.save(data)
end

---意味全文を保存する (対応するクエリの結果項目に text を追記)。
---@param query string
---@param url string
---@param text string
function M.store_text(query, url, text)
  if not query or query == "" then
    return
  end
  local data = M.load()
  local entry = data[query]
  if entry and entry.results then
    for _, r in ipairs(entry.results) do
      if r.url == url then
        r.text = text
        break
      end
    end
    M.save(data)
  end
end

---保存済みの意味全文を取得する。無ければ nil。
---@param query string
---@param url string
---@return string|nil
function M.get_text(query, url)
  local entry = M.get(query)
  if not entry or not entry.results then
    return nil
  end
  for _, r in ipairs(entry.results) do
    if r.url == url and r.text then
      return r.text
    end
  end
  return nil
end

return M
