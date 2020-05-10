local cjson = require "cjson.safe"
local jsmn = require "jsmn"


local check_json = jsmn.check


assert(check_json(cjson.encode({})))
assert(check_json("[]"))
assert(check_json('{"x":[]}'))
assert(check_json('{ "X": { "Attr1": [], "Attr2": 110 }}'))
assert(check_json(" { } \n"))
assert(check_json(cjson.encode({["你好"] = "世界"})))
assert(check_json(cjson.encode({"你好", "世界", "Foo © bar 𝌆 baz ☃ qux"})))
assert(check_json(cjson.encode({"\0"})))
assert(check_json('["\\u0000"]'))
assert(cjson.decode('["\\u0000"]')[1] == "\0")
assert(check_json(cjson.encode({"\xe4\xbd\xa0"})))
-- print(cjson.encode({"\0"}))
-- print(cjson.encode({"\xe4\xbd\xa0"}))

assert(not check_json(""))
assert(not check_json(" "))
assert(not check_json("{"))
assert(not check_json("}"))
assert(not check_json("{}x"))
assert(not check_json("{}{}"))
assert(not check_json("{}\n{}"))
assert(not check_json("1"))
assert(not check_json('"1"'))

print("OK!")
