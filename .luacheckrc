ignore = {
  "631",    -- max_line_length
  "611",    -- line is too long
  "212",    -- unused argument
  "213",    -- unused loop variable
  "214",    -- unused local variable
}
read_globals = {
  "describe",
  "it",
  "assert",
  "before_each",
  "after_each",
  "unpack",
}
-- vim.bo[buf].modifiable 等のフィールド代入を許容する
globals = {
  "vim",
  "vim.g",
}
