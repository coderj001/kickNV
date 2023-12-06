local ls = require("luasnip") --{{{
local s = ls.s
local i = ls.i
local t = ls.t

local d = ls.dynamic_node
local c = ls.choice_node
local f = ls.function_node
local sn = ls.snippet_node

local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

local snippets, autosnippets = {}, {} --}}}

local group = vim.api.nvim_create_augroup("GoLang Snippets", { clear = true })
local file_pattern = "*.go"

local function cs(trigger, nodes, opts) --{{{
  local snippet = s(trigger, nodes)
  local target_table = snippets

  local pattern = file_pattern
  local keymaps = {}

  if opts ~= nil then
    -- check for custom pattern
    if opts.pattern then
      pattern = opts.pattern
    end

    -- if opts is a string
    if type(opts) == "string" then
      if opts == "auto" then
        target_table = autosnippets
      else
        table.insert(keymaps, { "i", opts })
      end
    end

    -- if opts is a table
    if opts ~= nil and type(opts) == "table" then
      for _, keymap in ipairs(opts) do
        if type(keymap) == "string" then
          table.insert(keymaps, { "i", keymap })
        else
          table.insert(keymaps, keymap)
        end
      end
    end

    -- set autocmd for each keymap
    if opts ~= "auto" then
      for _, keymap in ipairs(keymaps) do
        vim.api.nvim_create_autocmd("BufEnter", {
          pattern = pattern,
          group = group,
          callback = function()
            vim.keymap.set(keymap[1], keymap[2], function()
              ls.snip_expand(snippet)
            end, { noremap = true, silent = true, buffer = true })
          end,
        })
      end
    end
  end

  table.insert(target_table, snippet) -- insert snippet into appropriate table
end                                   --}}}

cs(                                   -- Go gin example snippet
  "ginexample",
  fmt(
    [[
      package {}

      import   "github.com/gin-gonic/gin"

      func main() {{
        r:= gin.Default();
        r.GET("/", func(ctx *gin.Context) {{
          ctx.String(200, "{}")
        }})
        r.Run(":{}")
      }}
    ]],
    {
      i(1, "main"),
      i(2, "Hello World"),
      i(3, "port number"),
    }
  )
)

cs(
  "gorm:sqlite",
  fmt([[
  // import "github.com/jinzhu/gorm"
	// import _ "github.com/jinzhu/gorm/dialects/sqlite"
	db, err := gorm.Open("sqlite3", "{}.db")
	if err != nil {{
		panic("Failed to connect database")
	}}
  ]],
    {
      i(1, "db_name")
    }
  )
)

cs("readfile",
  fmt([[
  file, err := os.Open({})
	if err != nil {{
		fmt.Printf("Error Opening The File: %v\n", err)
	}}
	defer file.Close()

  // import "bufio"
	scanner := bufio.NewScanner(file)
	for scanner.Scan() {{
		fmt.Println(scanner.Text())
	}}

	if err = scanner.Err(); err != nil {{
		fmt.Printf("Error Reading File: %v\n", err)
	}}
  ]], {
    i(1, "filename")
  })
)

cs("jsonread",
  fmt([[
    // import "encoding/json"
    err := json.Unmarshal([]byte({}), &{}); if err != nil {{
      {}
    }}
  ]], {
    i(1, "json"),
    i(2, "object"),
    i(3, "panic()"),
  })
)


return snippets, autosnippets
