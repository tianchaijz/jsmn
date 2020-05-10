local ffi = require "ffi"


ffi.cdef[[
typedef enum {
  JSMN_UNDEFINED = 0,
  JSMN_OBJECT = 1,
  JSMN_ARRAY = 2,
  JSMN_STRING = 3,
  JSMN_PRIMITIVE = 4
} jsmntype_t;

typedef struct jsmntok {
  jsmntype_t type;
  int start;
  int end;
  int size;
  // int parent;
} jsmntok_t;

typedef struct jsmn_parser {
  unsigned int pos;     /* offset in the JSON string */
  unsigned int toknext; /* next token to allocate */
  int toksuper;         /* superior token node, e.g. parent object or array */
} jsmn_parser;

void jsmn_init(jsmn_parser *parser);
int jsmn_parse(jsmn_parser *parser, const char *js, const size_t len,
               jsmntok_t *tokens, const unsigned int num_tokens);
]]


local libjsmn = ffi.load("./libjsmn.so")

local num_tokens = 8192
local parser = ffi.new("jsmn_parser[1]")
local tokens = ffi.new("jsmntok_t[?]", num_tokens)


local _M = {}


function _M.check(s)
    libjsmn.jsmn_init(parser)
    local r = libjsmn.jsmn_parse(parser, s, #s, tokens, num_tokens)

    -- print(string.format("len=%d pos=%d toknext=%d toksuper=%d r=%d",
    --                     #s, parser[0].pos, parser[0].toknext, parser[0].toksuper, r))

    return r > 0
end


return _M
