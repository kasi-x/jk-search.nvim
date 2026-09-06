describe("jksearch.config", function()
  local config = require("jksearch.config")

  it("has no institution-specific defaults", function()
    -- 公開版は所属機関固有の URL を既定値に持たない
    assert.are.equal("", config.DATA.redirector)
    assert.are.equal("", config.DATA.proxy)
  end)

  it("merges user configuration via setup()", function()
    config.setup({
      redirector = "https://go.openathens.net/redirector/example.ac.jp",
      proxy = "https://japanknowledge-com.example.proxy.openathens.net",
      headless = true,
    })
    assert.are.equal("https://go.openathens.net/redirector/example.ac.jp", config.DATA.redirector)
    assert.are.equal("https://japanknowledge-com.example.proxy.openathens.net", config.DATA.proxy)
    assert.is_true(config.DATA.headless)
    -- 他の既定値は維持される
    assert.are.equal("node", config.DATA.node)

    -- 後片付け
    config.setup({ redirector = "", proxy = "", headless = false })
  end)
end)
