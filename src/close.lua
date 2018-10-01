identifier = fibaro:getGlobal('locker_identifier');
code = fibaro:getGlobal('locker_code');
ts = ""..os.time()

hmac = sha256.hmac_sha256(code, ts)
local b64_hmac = urlencode(to_base64(hex_to_binary(hmac)))
fibaro:debug(b64_hmac)
local params = "identifier=" .. identifier .. "&hash=" .. b64_hmac .. "&ts=" .. ts


IP = fibaro:get(fibaro:getSelfId(), "IPAddress")
fibaro:debug("IP: "..IP)
local gw = Net.FHttp(IP, 80)
res = gw:POST("/close", params ) ;
--res = gw:GET("/status") ;

fibaro:debug("response: "..res)


