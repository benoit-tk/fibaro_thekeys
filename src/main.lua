-- 1. Create share on http://api.the-keys.fr or from the app The Keys
-- 2. Go to http://api.the-keys.fr to find the code (in the share details
-- 3. Upload the icons for the plugin and for the open and close buttons
--

local identifier = ""
local code = ""

fibaro:setGlobal('locker_identifier', identifier)
fibaro:setGlobal('locker_code', code)

--Find icons id from buttons.
local res ,status, err = Net.FHttp("127.0.0.1",11111):GET('/api/devices/'..fibaro:getSelfId());
if (tonumber(status) == 200 and tonumber(err)==0) then 
    fibaro:debug("Got info...")
    response = json.decode(res)
    fibaro:debug("Found ".. #response.properties .. " properties")
	for i = 1, #response.properties.rows do   
    	for j = 1, #response.properties.rows[i].elements do
      		if response.properties.rows[i].elements[j].name == "ButtonOpen" then
        		fibaro:debug("Found button open: "..response.properties.rows[i].elements[j].buttonIcon)
		        fibaro:setGlobal('locker_open_id', response.properties.rows[i].elements[j].buttonIcon)
            elseif response.properties.rows[i].elements[j].name == "ButtonClose" then
          		fibaro:debug("Found button close: "..response.properties.rows[i].elements[j].buttonIcon)
		        fibaro:setGlobal('locker_close_id', response.properties.rows[i].elements[j].buttonIcon)
            end
			--fibaro:debug(response.properties.rows[i].elements[j].name)
        end
    end
else
	fibaro:debug("Fail to get device "..fibaro.getSelfId())
end 

