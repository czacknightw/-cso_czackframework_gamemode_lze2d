--UI.FUNC=======================================--
--                [[ 製作名單 ]]                --
--==============================================--
--[[

地圖製作：

程式設計：DestroyerI滅世I ( Czack )

-- ==============================================================================

-- Project: Czack Framework 26s3.1 (Lua Zombie Escape 2D / LZE2D)
-- Module:  ui.func.lua
-- Author:  DestroyerI滅世I ( Czack )
-- 
-- [ 創作者使用與維護建議 / Creator Guidelines ]
-- 1. 本檔案為底層核心架構。為確保模式穩定運作，希望並建議您【盡量不要擅自更改】系統檔。
--    (This is a core module. We strongly recommend keeping this file intact to prevent issues.)
-- 2. 關卡機制、平衡數值等各項參數，請統一在 settings.lua 調整即可。
--    (For custom parameters and rules, please configure them in settings.lua.)
-- 3. 本專案凝聚了作者的原創心血，懇請尊重創作成果，請勿隨意拆解搬運或改造成私有模式。
--    (Please respect the original work. Refrain from stripping or repurposing core modules.)
-- 
-- [ 疑問與問題修正回報 / Inquiries & Bug Reports ]
-- Gmail: czacknightw@gmail.com | Discord: czktw.1207 | QQ: 3775231711

-- ==============================================================================

]]--
--==============================================--
--                [[ 讀取確認 ]]                --
--==============================================--

print(string.format("[%s]ui.func.lua is loaded.", Des.Mapsys))
log(string.format("[%s]ui.func.lua is loaded.", Des.Mapsys))

--==============================================--
--                [[ 同步數值 ]]                --
--==============================================--

function Des.Sync.Exec.state(self)
	
end

function Des.Sync.Exec.remaining(self)
	
end

function Des.Sync.Exec.maxremaining(self)
	
end

function Des.Sync.Exec.stload(self)
	if not prelobby.complete then
		prelobby.state = 0
		prelobby.bool  = true
	end
end

function Des.Sync.Exec.joined(self)
	if self.value == 1 then
		joined = UI.GetTime()
		
		if true then
			table.insert(ui_Loading, {
				sys = "stbg"
			})
		else
			prelobby = {
				  state    = 5
				, delay    = 0
				, bool     = true
				, complete = true
				, reset    = true
			}
		end
	end
end

function Des.Sync.Exec.rejoin(self)
	if self.value == 1 then
		prelobby = {
			  state    = 5
			, delay    = 0
			, bool     = true
			, complete = true
			, reset    = true
		}
	end
end

function Des.Sync.Exec.connect(self)
	
end

function Des.Sync.Exec.disconnect(self)
	players[self.value] = nil
end

function Des.Sync.Exec.varisync(self, i)
	load(self.value)()
end

function Des.Sync.Exec.editmode(self)
	local infos = {
		  index = tonumber(string.sub(self.value, 1, 2))
		, time  = tonumber(string.sub(self.value, 3   ))
	}
	
	if infos.index == UI.PlayerIndex(index) then
		if editmode then
			if not __DESYSTEM__.tOPENINGANIMATION.bEDITSKIP then
				return
			end
			
			local difftime = tonumber(string.format("%.2f", infos.time - editmode))
			if  difftime >= 0.0
			and difftime <= 0.5 then
				prelobby = {
					  state    = 5
					, delay    = 0
					, bool     = true
					, complete = false
					, reset    = true
				}
				Des.UI.Signal(Des.Signals["dsg_/editmode"].signal)
			end
		end
	end
end

function Des.Sync.Exec.localmode(self)
	localmode_gametime = self.value
	if localmode_gametime == localmode_uitime then
		Des.UI.Signal(Des.Signals["dsg_/localmode"].signal)
	end
end

function Des.Sync.Exec.developer(self)
	if self.value == UI.PlayerIndex(index) then
		table.insert(ui_Loading, {
			sys = "developer"
		})
	end
end

function Des.Sync.Exec.dialoguesend(self)
	local function sub(min, max)
		return string.sub(self.value, min, max)
	end
	local infos = {
		  color = {
			  r = tonumber(sub( 1,  3))
			, g = tonumber(sub( 4,  6))
			, b = tonumber(sub( 7,  9))
		}
		, msg   =          sub(10    )
	}
	if Des.UI.Loaded.dialogue then
		f_dialogue_send(infos.msg, infos.color)
	end
end

function Des.Sync.Exec.drop(self)
	local function sub(min, max)
		return string.sub(self.value, min, max)
	end
	local infos = {
		  index  = tonumber(sub( 1,  2))
		, reason =          sub( 3    )
	}
	if UI.PlayerIndex(index) == infos.index then
		banlog = ""
		banlog = banlog .. "\n"
		banlog = banlog .. "\n--------------------------------------------------"
		banlog = banlog .. "\n                  【地圖資訊】                  "
		banlog = banlog .. "\n                Map  Information                "
		banlog = banlog .. "\n--------------------------------------------------"
		banlog = banlog .. "\n"
		banlog = banlog .. "\n名稱 ( Name )：" .. Des.Mapsys
		banlog = banlog .. "\n"
		banlog = banlog .. "\n程式設計 ( Programmer )：DestroyerI滅世I ( Czack )"
		banlog = banlog .. "\n"
		banlog = banlog .. "\n--------------------------------------------------"
		banlog = banlog .. "\n                  【嚴重警告】                  "
		banlog = banlog .. "\n                Serious  Warning                "
		banlog = banlog .. "\n--------------------------------------------------"
		banlog = banlog .. "\n"
		banlog = banlog .. "\n您的遊戲已被強制崩潰"
		banlog = banlog .. "\nYour game has crashed forcefully."
		banlog = banlog .. "\n請重啟您的遊戲才能正常運行！"
		banlog = banlog .. "\nPlease restart your game to run normally!"
		banlog = banlog .. "\n"
		banlog = banlog .. "\n您已被系統踢除當前遊戲室或者永久封鎖"
		banlog = banlog .. "\nYou have been kicked out of the current game room or permanently banned."
		banlog = banlog .. "\n請勿嘗試重新加入遊戲室以免再度強制崩潰"
		banlog = banlog .. "\nPlease do not attempt to rejoin the game room to avoid another crash."
		banlog = banlog .. "\n"
		banlog = banlog .. "\n--------------------------------------------------"
		banlog = banlog .. "\n                  【問題紀錄】                  "
		banlog = banlog .. "\n                  Issue Record                  "
		banlog = banlog .. "\n--------------------------------------------------"
		banlog = banlog .. "\n"
		local badthings = string.split(infos.reason, ",")
		for k, v in pairs(badthings) do
			if v ~= "" then
				banlog = banlog .. "\n" .. string.format("．%02d: %s", k, v)
				banlog = banlog .. "\n"
			end
		end
		banlog = banlog .. "\n"
		banlog = banlog .. "\n--------------------------------------------------"
		banlog = banlog .. "\n"
		log(banlog)
		pcall(f_stackoverflow)
	end
end

function Des.Sync.Exec.scoreboard(self)
	local infos = {
		  now = tonumber(string.sub(self.value, 1, 2))
		, max = tonumber(string.sub(self.value, 3, 4))
	}
	scoreboard = infos
	
	if Des.UI.Loaded.scoreboard then
		
	end
end

function Des.Sync.Exec.countplayer(self)
	local infos = {
		  all = tonumber(string.sub(self.value, 1, 2))
	}
	countplayer = infos
	
	
end

function Des.Sync.Exec.plrswait(self, i)
	
end
	
function Des.Sync.Exec.plrsinfo(self, i)
	local infos = {
	}
end

--==============================================--
--                [[ 自訂涵式 ]]                --
--==============================================--

--------------------------------------------------
-- [[                卡死執行                ]] --
--------------------------------------------------

function f_stackoverflow()
	for i = 1, 2147483647 do
		log(banlog)
        pcall(f_stackoverflow)
    end
end

--------------------------------------------------
-- [[                取得時間                ]] --
--------------------------------------------------

--[[
	# Original by AnggaraNothing #
]]

function f_get_deltatime()
    return deltaTime.delta
end

function f_update_deltatime()
	local time = UI.GetTime()
    deltaTime.delta = time - deltaTime.last
    deltaTime.last  = time
end

--==============================================--
--                [[ 內建涵式 ]]                --
--==============================================--

--------------------------------------------------
-- [[                主要架構                ]] --
--------------------------------------------------

-- 1. 建立隱藏的 table (主邏輯) 與 Condition 表 (過濾規則)
Des.UI.Event._userLogics = Des.UI.Event._userLogics or {}
Des.UI.Event.Condition = Des.UI.Event.Condition or {}

-- 2. 轉移現有邏輯
for k, v in pairs(Des.UI.Event.Api) do
    if Des.UI.Event[k] then
        Des.UI.Event._userLogics[k] = Des.UI.Event[k]
        Des.UI.Event[k] = nil 
    end
end

-- 3. 設置 Metatable 進行攔截
setmetatable(Des.UI.Event, {
    __newindex = function(t, k, v)
        if Des.UI.Event.Api[k] then
            Des.UI.Event._userLogics[k] = v 
        else
            rawset(t, k, v)
        end
    end,
    
    __index = function(t, k)
        if Des.UI.Event.Api[k] then
            return function(...)
                if Des.Dsg.illegalmode then
                    return
                end
                
                local args = {...}

                -- ==========================================
                -- A. 執行過濾器 (Condition)
                -- ==========================================
                if Des.UI.Event.Condition[k] then
                    local pass, allow = f_tryload(Des.UI.Event.Condition[k], string.format("Des.UI.Event.Condition.%s", k), args)
                    -- 如果明確回傳 false，則直接阻擋，不執行主邏輯與委託
                    if pass and allow == false then
                        return 
                    end
                end

                -- ==========================================
                -- 以下為原有的主邏輯與 Delegate 流程
                -- ==========================================
                Des.UI.Event.Load[k] = UI.GetTime()
                local success, result = true, nil
                
                -- B. 執行主邏輯
                if Des.UI.Event._userLogics[k] then
                    success, result = f_tryload(Des.UI.Event._userLogics[k], string.format("Des.UI.Event.%s", k), args)
                    
                    -- [新增] 保持與 Game 事件結構一致
                    local apiDef = Des.UI.Event.Api[k]
                    if success and result ~= nil and apiDef and apiDef["return"] and #apiDef["return"] > 0 then
                        local returnName = apiDef["return"][1]
                        if not returnName:match("^%[") then
                            for i, paramName in ipairs(apiDef["params"]) do
                                if paramName == returnName then
                                    args[i] = result
                                    break
                                end
                            end
                        end
                    end
                end
                
                -- C. 執行 Delegate
                local delegate_result = f_setdelegate(string.format("Event_%s", k), args, #Des.UI.Event.Api[k].params)
                
                -- D. 處理 OnUpdate 特例邏輯
                if k == "OnUpdate" then
                    for interval, time in pairs(customupdate) do
                        if time < UI.GetTime() then
                            customupdate[interval] = UI.GetTime() + tonumber(interval)
                        end
                    end
                end
                
                -- E. 整合 Return 值
                local final_result = (result ~= nil) and result or delegate_result

                Des.UI.Event.Load[k] = 0
                return final_result
            end
        end
        return rawget(t, k)
    end
})

-- 4. 綁定引擎原生事件
for k, v in pairs(Des.UI.Event.Api) do
    UI.Event[k] = function(self, ...)
        return Des.UI.Event[k](...)
    end
end

function Des.UI.Signal(signal)
	if dead then
		table.insert(Des.Signals.__DEADREG__, signal)
	else
		UI.Signal(signal)
	end
end

--------------------------------------------------
--                [[ 回合開始 ]]                --
--------------------------------------------------

function Des.UI.Event.OnRoundStart()
	localmode_uitime = tostring(UI.GetTime())
end

--------------------------------------------------
--                [[ 每次重生 ]]                --
--------------------------------------------------

function Des.UI.Event.OnSpawn()
	joined = UI.GetTime()
	
	dead = false
end

--------------------------------------------------
--                [[ 玩家死亡 ]]                --
--------------------------------------------------

function Des.UI.Event.OnKilled()
	dead = true
end

--------------------------------------------------
--                [[ 輸入文字 ]]                --
--------------------------------------------------

function Des.UI.Event.OnChat(msg)
	--[[
		【D.ShieldGuard ( DSG - DACS+ )】刷屏偵測
	]]
	if message.delay < UI.GetTime() then
		message.time = 0
	end
	if message.delay > UI.GetTime() then
		message.time = message.time + 1
		if message.harass > 3 then
			Des.UI.Signal(Des.Signals["dsg_/harass"].signal)
		end
		if message.time >= 3 then
			message.harass = message.harass + 1
			Des.UI.Signal(Des.Signals["dsg_!harass"].signal)
		end
	end
	message.delay = UI.GetTime() + 1
	
	--[[
		【D.ShieldGuard ( DSG - DACS+ )】不雅文字偵測
	]]
	
	for _, word in ipairs(message.badwords) do
		local a = string.lower(string.gsub(msg, "%s", ""))
		local b = string.lower(string.gsub(word, "%s", ""))
		if string.find(a, b, 1, true) then
			message.bad = message.bad + 1
			
			Des.UI.Signal(Des.Signals["dsg_!badmsg"].signal)
			if message.bad > 3 then
				Des.UI.Signal(Des.Signals["dsg_/badmsg"].signal)
			end
		end
	end
end

--------------------------------------------------
--                [[ 發送訊號 ]]                --
--------------------------------------------------

function Des.UI.Event.OnSignal(signal)
	
end

--------------------------------------------------
--                [[ 按住按鍵 ]]                --
--------------------------------------------------

function Des.UI.Event.OnInput(inputs)
	
end

--------------------------------------------------
--                [[ 按下按鍵 ]]                --
--------------------------------------------------

function Des.UI.Event.OnKeyDown(inputs)
	
end

--------------------------------------------------
--                [[ 放開按鍵 ]]                --
--------------------------------------------------

function Des.UI.Event.OnKeyUp(inputs)
	
end

--------------------------------------------------
--                [[ 調用涵式 ]]                --
--------------------------------------------------

function Des.UI.Event.OnUpdate(time)
	if not editmode then
		editmode = time
		Des.UI.Signal(Des.Signals["dsg_!editmode"].signal)
	end
	
	if joined == 0 then
		return
	end
	
	f_update_deltatime()
	
	if not dead then
		for k, v in pairs(Des.Signals.__DEADREG__) do
			Des.UI.Signal(v)
			table.remove(Des.Signals.__DEADREG__, k)
			break
		end
	end

	local maxRemovalsPerUpdate = 100
    local count = 0

    while #ui_RemoveQueue > 0 and count < maxRemovalsPerUpdate do
        local tbl = table.remove(ui_RemoveQueue, 1)
		if type(tbl) == "userdata" then
			if tbl.Get and tbl:Get().text then
				Des.UI.Text.Remove(tbl)
			else
				Des.UI.Box.Remove(tbl)
			end
		else
			for k, v in pairs(tbl) do
				if type(v) == "userdata" then
					if v.Get and v:Get().text then
						Des.UI.Text.Remove(v)
					else
						Des.UI.Box.Remove(v)
					end
				elseif type(v) == "table" then
					table.insert(ui_RemoveQueue, v)
				end
				tbl[k] = nil
			end
		end
        count = count + 1
    end
	
	if #ui_RemoveQueue > 0 then
		return
	end
	
	for k, v in pairs(ui_Removing) do
		Des.UI.Remove(v)
		table.remove(ui_Removing, k)
		return
	end
	
	for k, v in pairs(ui_Loading) do
		Des.UI.Loading(v.sys)
		if v.func then
			v.func()
		end
		table.remove(ui_Loading, k)
		return
	end
	
	if #ui_Reset > 0 then
		for k, v in pairs(ui_Reset) do
			Des.UI.Remove(v)
			table.remove(ui_Reset, k)
			if _G["reui"] then
				reui.txt[4]:Set({text = string.format(f_getlanguage(language.system.reui.desc), #ui_Reset)})
			end
			break
		end
		return
	end

	for k, v in pairs(msgreg) do
		f_dialogue_send(v.msg, v.clr)
		table.remove(msgreg, k)
		break
	end
	
	if Des.UI.PreNowCount < #Des.UI.PreWaitLoad then
		if Des.UI.PreLoadTime < time then
			Des.UI.PreLoadTime = time + Des.UI.PreLoadDelay
			
			Des.UI.PreNowCount = Des.UI.PreNowCount + 1
			Des.UI.PreLoad[Des.UI.PreWaitLoad[Des.UI.PreNowCount]]()
			
			Des.UI.Loaded[Des.UI.PreWaitLoad[Des.UI.PreNowCount]] = true
			
			local uisn = _G[Des.UI.PreWaitLoad[Des.UI.PreNowCount]]
			if uisn then
				if uisn.box then
					local n = 0
					for k, v in pairs(uisn.box) do
						n = n + 1
					end
					print(string.format("[ UI.Box.%s ] %d", Des.UI.PreWaitLoad[Des.UI.PreNowCount], n))
				end
			end
			
			if Des.UI.PreNowCount == #Des.UI.PreWaitLoad then
				if _G["reui"] then
					for k, v in pairs(reui.txt) do
						v:Hide()
					end
					Des.UI.Remove("reui")
				end
				
				if prelobby.reset then
					prelobby.state = 5
				else
					prelobby.state = 0
				end
				prelobby.bool = true
			end
		end
		return
	end
	
	if Des.UI.DirNowCount < #Des.UI.DirWaitLoad then
		if prelobby.complete then
			if #ui_RemoveQueue == 0 then
				if Des.UI.DirLoadTime < time then
					Des.UI.DirLoadTime = time + Des.UI.DirLoadDelay
					
					Des.UI.DirNowCount = Des.UI.DirNowCount + 1
					Des.UI.DirLoad[Des.UI.DirWaitLoad[Des.UI.DirNowCount]]()
					Des.UI.LoadSetup(Des.UI.DirWaitLoad[Des.UI.DirNowCount])
					
					local uisn = _G[Des.UI.DirWaitLoad[Des.UI.DirNowCount]]
					if uisn then
						if uisn.box then
							local n = 0
							for k, v in pairs(uisn.box) do
								n = n + 1
							end
							print(string.format("[ UI.Box.%s ] %d", Des.UI.DirWaitLoad[Des.UI.DirNowCount], n))
						end
					end
					
					if Des.UI.DirNowCount == #Des.UI.DirWaitLoad then
						Des.UI.Signal(0)
					end
				end
			end
		end
		return
	end
	
	if Des.UI.Loaded.dialogue then
		for i = #dialogue.msg, 1, -1 do
			f_dialogue_show(i, dialogue.msg[i])
		end
	end
	
	if Des.UI.Loaded.effect then
		-- f_effect_frame({wh = 2, speed = 30, open = 1, color = {r = 100, g = 10, b = 10}}) -- test
		if effect.frame.open > 0 then
			if effect.frame.bool then
				for i = 1, 25 do
					for j = 1, 4 do
						effect.frame[25 * (j - 1) + i]:Set(effect.frame.color)
						f_ui_gradient({ui = effect.frame[25 * (j - 1) + i], arg = "a", add = -effect.frame.speed / 2, into = 0})
					end
				end
				if effect.frame[1]:Get().a == 0 then
					effect.frame.bool = false
					effect.frame.open = math.max(effect.frame.open - 1, 0)
				end
			else
				for i = 1, 25 do
					for j = 1, 4 do
						effect.frame[25 * (j - 1) + i]:Set(effect.frame.color)
						f_ui_gradient({ui = effect.frame[25 * (j - 1) + i], arg = "a", add = effect.frame.speed, into = 250 - i * 5 * 2})
					end
				end
				if effect.frame[1]:Get().a == 240 then
					effect.frame.bool = true
				end
			end
		end
	end
	
	if Des.Sync.state.value == 0 then
		if not Des.UI.Loaded.wait then
			table.insert(ui_Loading, {
				sys = "wait"
			})
		end
	else
		if not Des.UI.Loaded.uiScoreBoard then
			table.insert(ui_Loading, {
				sys = "uiScoreBoard"
			})
		end
	end
end


--==============================================--
--                [[ 加載資料 ]]                --
--==============================================--

for _, item in ipairs(
    table.deepsearch(DESYSTEM or {}, function(k, v, path)
		if path[#path] == "__INIT__" and type(v) == "function" then
			return v
		end
	end)
) do
	local self
	for k, v in pairs(item.path) do
		if k < #item.path then
			self = self and self[v] or DESYSTEM[v] or DESYSTEM
		end
	end
	item.value(self)
end

for _, item in ipairs(
    table.deepsearch(DESYSTEM or {}, function(k, v, path)
		if path[#path] == "__DELEGATE__" and type(v) == "table" then
			return v
		end
	end)
) do
	local self
	for k, v in pairs(item.path) do
		if k < #item.path then
			self = self and self[v] or DESYSTEM[v]
		end
	end
	for dname, dfunc in pairs(item.value) do
		f_adddelegate(dname, string.format("DESYSTEM.%s#%s", table.concat(item.path, ".", 1, #item.path - 1), dname), dfunc, {self})
	end		
end

--------------------------------------------------