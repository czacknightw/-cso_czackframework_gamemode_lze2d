--GAME==========================================--
--                [[ 製作名單 ]]                --
--==============================================--
--[[

地圖製作：

程式設計：DestroyerI滅世I ( Czack )

-- ==============================================================================

-- Project: Czack Framework 26s3.1 (Lua Zombie Escape 2D / LZE2D)
-- Module:  game.lua
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

print(string.format("[%s]game.lua is loaded.", Des.Mapsys))
log(string.format("[%s]game.lua is loaded.", Des.Mapsys))

--==============================================--
--                [[ 遊戲規則 ]]                --
--==============================================--

Game.Rule.name = ""
Game.Rule.desc = ""

Game.Rule.enemyfire    = false
Game.Rule.breakable    = false
Game.Rule.respawnable  = false
Game.Rule.friendlyfire = false

Game.Rule.respawnTime = 0

--==============================================--
--                [[ 變數宣告 ]]                --
--==============================================--

minplayers     = __DESYSTEM__.tWAIT.iMINPLAYERS
waitingrecord  = __DESYSTEM__.tWAIT.iWAITINGTIME

difficultyrate = 1

win      = false
dsgac    = __DESYSTEM__.tDSG.bACTIVE
reround  = false
wincheck = true

drop    = {}
msgreg  = {}
noxpass = {}
waiters = {}
players = {}
leavers = {}

developers = {
	"DestroyerI滅世I"
}

for k, v in pairs(__DESYSTEM__.tDEVELOPERS or {}) do
	table.insert(developers, v)
end

scoreboard = {
	now = 0,
	max = 5,
	[Game.TEAM.TR] = 0,
	[Game.TEAM.CT] = 0,
}

countplayer = {
	all = 0,
	[Game.TEAM.TR] = 0,
	[Game.TEAM.CT] = 0,
}

customupdate = {
	  ["1"] = 0
}

--==============================================--
--                [[ 同步數值 ]]                --
--==============================================--



--==============================================--
--                [[ 裝置觸發 ]]                --
--==============================================--

--------------------------------------------------
--                [[ 重生驗證 ]]                --
--------------------------------------------------

passtouch = Game.EntityBlock.Create(__DESYSTEM__.tDSG.tSPAWNPASS)
if dsgac and passtouch then
	function passtouch:OnTouch(player)
		if not player.user.spawnxpass then
			player.user.spawnxpass = true
		end
	end
end

--==============================================--
--                [[ 藍色腳本 ]]                --
--==============================================--

Des.Game.Blua = {
	ADD = function(self, name, data)
		
		func = function(bool, argstr)
			local bluargs = {}
			for i, n in pairs(data[1] or {}) do
				bluargs[n] = true
			end
			
			if bluargs.on then
				if bool == false then
					return
				end
			end
			if bluargs.off then
				if bool == true then
					return
				end
			end
			bluargs.bool = bool
			
			bluargs.defarg = argstr
			
			local player, monster
			local entity = Game:GetTriggerEntity()
			
			if entity then
				if entity:IsPlayer() then
					player = entity:ToPlayer()
					bluargs.player = entity:ToPlayer()
				end
				
				if entity:IsMonster() then
					monster = entity:ToMonster()
					bluargs.monster = entity:ToMonster()
				end
			end
			
			if bluargs.player and not player then return end
			if bluargs.monster and not monster then return end
			
			bluargs.callentity = Game:GetScriptCaller()
			bluargs.position = Game:GetScriptCaller().position
			
			local cusargs = {}
			for i, n in pairs(data[2] or {}) do
				cusargs[i] = n
			end
			
			local splited = string.split(argstr, ",")
			if #splited >= 1 then
				for index, splarg in pairs(splited or {}) do
					if tonumber(splarg) then
						splarg = tonumber(splarg)
					end
					if cusargs[index] then
						cusargs[cusargs[index]] = splarg
					end
				end
			end
			
			local func = data[3]
			
			local reargs = {}
			for i, n in pairs(bluargs) do
				reargs[i] = n
			end
			for i, n in pairs(cusargs) do
				reargs[i] = n
			end
			
			local success, result = f_tryload(func, string.format("Des.Game.Blua.%s", name), {reargs})
			
			-- 建立委託
			f_setdelegate(string.format("Blua_%s", name), {reargs})
		end
		
		_G[name] = func
		self[name] = func
	end
	
	, difficulty = {{"on", "monster"}, {}, function(env)
		-- easy
		if env.monster.maxhealth >= 30 * (10 / 100)
		and env.monster.maxhealth <= 30 * (90 / 100) then
			Des.Sync.difficulty.value = 1
		-- normal
		elseif env.monster.maxhealth == 30 then
			Des.Sync.difficulty.value = 0
		-- hard
		elseif env.monster.maxhealth >= 30 * (150 / 100)
		and env.monster.maxhealth <= 30 * (250 / 100) then
			Des.Sync.difficulty.value = 2
		-- extreme
		elseif env.monster.maxhealth >= 30 * (350 / 100)
		and env.monster.maxhealth <= 30 * (450 / 100) then
			Des.Sync.difficulty.value = 3
		-- hell
		elseif env.monster.maxhealth >= 30 * (600 / 100)
		and env.monster.maxhealth <= 30 * (1000 / 100) then
			Des.Sync.difficulty.value = 4
		end
		
		difficultyrate = env.monster.maxhealth / 30
	end}
	
	, Reset = {{"on"}, {"x", "y", "z"}, function(env)
		local entityblock = Des.Game.EntityBlock.Create({x = env.x, y = env.y, z = env.z})
		if entityblock then
			entityblock:Event({action = "reset"})
		end
	end}
	
	, UseEntityBlock = {{"on", "player"}, {"x", "y", "z"}, function(env)
		local entityblock = Des.Game.EntityBlock.Create({x = env.x, y = env.y, z = env.z})
		if entityblock then
			entityblock:Event({action = "use", target = env.player})
		end
	end}
	
	, fasterupdate = {{}, {}, function(env)
		if not fasterupdate_limit then
			fasterupdate_limit = {
				  now  = 0
				, time = 0.0001
				, bool = false
			}
		end
		local time = Game.GetTime()
		if fasterupdate_limit.now < time then
			fasterupdate_limit.now = time + fasterupdate_limit.time
			fasterupdate_limit.bool = true
			
			-- # Main Code # --
			
		end
	end}
}

for k, v in pairs(Des.Game.Blua) do
	if k ~= "ADD" then
		Des.Game.Blua:ADD(k, v)
	end
end

--==============================================--
--                [[ 自訂涵式 ]]                --
--==============================================--

--------------------------------------------------
--                [[ 紅色腳本 ]]                --
--------------------------------------------------

function f_red_script(data)
	if not data.name then
		return
	end
	
    local name = (data.value == nil and data.name or data.name .. "#" .. data.value)
	
    if data.flash then
        Game.SetTrigger(name, true)
        Game.SetTrigger(name, false)
    else
        Game.SetTrigger(name, data.bool)
    end
end

--------------------------------------------------
--                [[ 偵測座標 ]]                --
--------------------------------------------------

function DESYSTEM.DISTANCE(pos1, pos2)
    local result = {}
    result.x = pos1.x - pos2.x
    result.y = pos1.y - pos2.y
    result.z = pos1.z - pos2.z
    return math.sqrt(result.x ^ 2 + result.y ^ 2 + result.z ^ 2)
end

--------------------------------------------------
-- [[                發送訊息                ]] --
--------------------------------------------------

function f_dialogue_send(index, msg, color)
	if not index then
		return
	end
	if not msg
	or     msg == "" then
		return
	end
	local color = color or {r = 255, g = 255, b = 255}
	
	if index == "all" then
		for k, v in pairs(players) do
			if v then
				Des.Sync.dialoguesend[v.index].value = string.format("%03d%03d%03d%s", color.r, color.g, color.b, msg)
			end
		end
	else
		Des.Sync.dialoguesend[index].value = string.format("%03d%03d%03d%s", color.r, color.g, color.b, msg)
	end
end

--------------------------------------------------
-- [[                踢除玩家                ]] --
--------------------------------------------------

function f_player_drop(args)
	local player = args.player
	local remove = args.remove
	local check = args.check
	
	if check then
		for k, v in pairs(drop) do
			if player.name == v then
				Des.Sync.drop.value = string.format("%02d%s", player.index, player.user.bad)
				return true
			end
		end
		return false
	end
	
	if not remove then
		if not player then
			return
		end
		
		local exist = false
		for k, v in pairs(drop) do
			if player.name == v then
				exist = true
			end
		end
		if not exist then
			table.insert(drop, player.name)
		end
		player.user.drop = true
		player.user.gdrop = Game.GetTime() + 0.5
		Des.Sync.drop.value = string.format("%02d%s", player.index, player.user.bad)
	elseif tonumber(remove) then
		for k, v in pairs(drop) do
			if k == remove then
				table.remove(drop, k)
			end
		end
	end
end

--------------------------------------------------
-- [[                作弊偵測                ]] --
--------------------------------------------------

function f_cheat_detected(player, reason, value)
	if not player then
		return
	end
	if not reason then
		return
	end
	
	table.insert(msgreg, {
		  to = "all"
		, msg = (value and string.format(f_getlanguage(language.badreason[reason]), player.name, value) or string.format(f_getlanguage(language.badreason[reason]), player.name)) .. (dsgac and "" or " ( ※D.ShieldGuard Disabled! )")
		, clr = {r = 250, g = 100, b = 100}
	})
	
	if dsgac then
		player:RemoveWeapon()
		player.health = 1
		player:Kill()
		player.user.alive = false
		if player ~= "reset" then
			player.user.bad = string.format("%s%02d,", player.user.bad, reason)
		
			local badthings = string.split(player.user.bad, ",")
			
			if not player.user.developer then
				f_player_drop({player = player})
			else
				player.user.bad = ""
			end
		end
	end
end

--------------------------------------------------
--                [[ 等待排序 ]]                --
--------------------------------------------------

function f_sort_waiting(a, b)
    if a.team > b.team then
        return true
    elseif a.team < b.team then
        return false
    elseif a.user.wait > b.user.wait then
        return true
    elseif a.user.wait < b.user.wait then
        return false
    else
        return a.index < b.index
    end
end


--------------------------------------------------
-- [[                測試玩家                ]] --
--------------------------------------------------

Des.Bot = {}
Des.Bot.Count = 0            -- 用來記錄生成了多少個 Bot (用於專屬命名)
Des.Bot.RespawnQueue = {}    -- 用來存放準備要重生的 Bot 隊列

Des.Bot.__index = function(t, k)
	local proxy = rawget(t, "_proxy")
	local bot = rawget(t, "_bot")
	
	if proxy then
		if proxy[k] ~= nil then return proxy[k] end
		if proxy.plrsim and proxy.plrsim[k] ~= nil then return proxy.plrsim[k] end
	end
	
	if bot then
		if proxy and proxy.simsync and proxy.simsync[k] then
			local botKey = proxy.simsync[k]
			
			-- 【修復核心】：使用 pcall 安全讀取，防止實體被引擎刪除時報錯
			local success, val = pcall(function() return bot[botKey] end)
			
			if not success or val == nil then
				if k == "health" or k == "maxhealth" or k == "armor" or k == "maxarmor" then return 0 end
				if k == "maxspeed" or k == "speed" then return 0 end
				if k == "velocity" or k == "position" then return {x = 0, y = 0, z = 0} end
				return nil
			end
			return val
		end
		
		-- 攔截其他方法呼叫 (例如 bot:Stop())
		local success, v = pcall(function() return bot[k] end)
		if success and type(v) == "function" then
			return function(_, ...) 
				-- 方法執行也要保護
				local s, res = pcall(function(...) return v(bot, ...) end, ...)
				if s then return res else return nil end
			end
		elseif success then
			return v
		end
	end
end

Des.Bot.__newindex = function(t, k, v)
	if k == "name" then return end -- 鎖死名字防呆
	
	local bot   = rawget(t, "_bot")
	local proxy = rawget(t, "_proxy")

	if proxy and proxy.simsync and proxy.simsync[k] and bot then
		local botKey = proxy.simsync[k]
		-- 【修復核心】：寫入時也使用 pcall，死了就別強求寫入了
		pcall(function() bot[botKey] = v end)
		return
	end

	if proxy then
		if proxy.plrsim and proxy.plrsim[k] ~= nil then
			proxy.plrsim[k] = v
			return
		end
		proxy[k] = v
		return
	end

	rawset(t, k, v)
end

function em_bots(position)
	Des.Bot.Count = Des.Bot.Count + 1
	local botName = "BOT_" .. tostring(Des.Bot.Count)
	
	log("【系統】生成了一隻新 Bot，目前總數：", Des.Bot.Count, "名字是：", botName)
	
	-- 【修復核心】：給予虛擬 Index，從 24 往下遞減 (確保 UI Sync 陣列不會越界，且不跟前面玩家撞號)
	local fake_index = 25 - Des.Bot.Count 
	
	local bot = Game.Monster:Create(Des.Game.MONSTERTYPE.A101AR.ID, position)
	
	bot.maxhealth = 100
	bot.health = 100
	bot.maxarmor = 0
	bot.armor = 0
	bot.speed = 0.001
	bot.damage = 0
	bot.viewDistance = 0
	bot.checkAngle = 0
	bot.applyKnockback = false
	bot.canJump = false
	bot:Stop(true)
	
	bot.user.lobby = true
	bot.user.alive = true
	bot.user.isBot = true
	
	local plrsim = {
		team = math.random(1, 2)
		, model = Game.MODEL.DEFAULT
		
		, coin = 0
		, gravity = 1
		, flinch = 1
		, knockback = 1
		, death = 0
		
		, infiniteclip = false
		
		, name = botName
		, spawnpos = position
		, index = fake_index -- 綁定虛擬玩家編號在這裡！
	}
	
	local simsync = {
		-- 注意：已經把 index = "index" 移除！不讓他去讀取怪物的亂數 ID
		maxhealth = "maxhealth"
		, health = "health"
		, maxarmor = "maxarmor"
		, armor = "armor"
		, maxspeed = "speed"
		, velocity = "velocity"
		, position = "position"
	}
	
	local proxy = setmetatable({
		bot = bot
		, plrsim = plrsim
		, simsync = simsync
		, saved_user = bot.user -- 【新增】備份 user 資料引用，防止實體刪除後讀不到
	}, {
		__index = {
			Respawn = function(self)
				if self.user.alive then
					-- 如果還活著，直接改變位置
					self.position = self.plrsim.spawnpos
				else
					-- 如果死了，將其加入延遲重生隊列 (等待 3.1 秒)
					Des.Bot.RespawnQueue[self.user.wrapper] = Game.GetTime() + 3.1
				end
			end
			, Kill = function(self)
				if not self.user.alive then return end
				self.user.alive = false
				self.user.death = self.user.death + 1
				
				-- 強制把怪物的血量設為 0 (讓引擎知道他死了)
				if self._bot then self._bot.health = 0 end 
				
				self.user.back = self.position
				self.position = {x = -184, y = -184, z = -88}
			end
			, Win = function(self, isend)
				Game.Rule:Win(3, isend)
			end
			
			, Signal = function(self, signal)
			end
			
			, SetLevelUI = function(self, level, expRate)
			
			end
			, SetBuymenuLockedUI = function(self, weaponid, uiLocked, level)
				
			end
			, SetWeaponInvenLockedUI = function(self, weapon, uiLocked, level)
				
			end
			
			, ShowBuymenu = function(self)
				
			end
			, RemoveWeapon = function(self)
				
			end
			
			, ShowWeaponInven = function(self)
				
			end
			, ToggleWeaponInven = function(self)
				
			end
			, ClearWeaponInven = function(self)
				
			end
			, GetPrimaryWeapon = function(self)
				
			end
			, GetSecondaryWeapon = function(self)
				
			end
			, GetWeaponInvenList = function(self)
				
			end
			
			, SetFirstPersonView = function(self)
				
			end
			, SetThirdPersonView = function(self, minDist, maxDist)
				
			end
			, SetThirdPersonFixedView = function(self, yaw, pitch, minDist, maxDist)
				
			end
			, SetThirdPersonFixedPlane = function(self, plane)
				
			end
			
			, SetGameSave = function(self, name, value)
				
			end
			, GetGameSave = function(self, name)
				
			end
			
			, IsPlayer = function(self)
				return true
			end
			
			, IsMonster = function(self)
				return true
			end
			
			, ToPlayer = function(self)
				return self
			end
			
			, ToMonster = function(self)
				return self
			end
		}
	})
	
	bot.user.proxy = proxy
	bot.user.plrsim = plrsim
	bot.user.simsync = simsync
	
	local wrapper = setmetatable({
		_bot = bot,
		_proxy = proxy
	}, Des.Bot)
	
	bot.user.wrapper = wrapper
	proxy.plrsim.user = bot.user -- 互相參照確保 wrapper 內也能抓到 user
	
	-- 初始化事件
	if Des.Game.Rule.OnPlayerConnect then Des.Game.Rule.OnPlayerConnect(wrapper) end
	f_setdelegate("Rule_OnPlayerConnect", {wrapper})
	
	if Des.Game.Rule.OnPlayerJoiningSpawn then Des.Game.Rule.OnPlayerJoiningSpawn(wrapper) end
	f_setdelegate("Rule_OnPlayerJoiningSpawn", {wrapper})
	
	if Des.Game.Rule.OnPlayerSpawn then Des.Game.Rule.OnPlayerSpawn(wrapper) end
	f_setdelegate("Rule_OnPlayerSpawn", {wrapper})
	
	bot.user.wait = 3
	
	return wrapper
end

--------------------------------------------------
-- [[         Bot 延遲重生系統               ]] --
--------------------------------------------------
f_adddelegate(
	"Rule_OnUpdate", 
	"Des.Bot.Update", 
	function(time)
		for wrapper, respawnTime in pairs(Des.Bot.RespawnQueue) do
			if time >= respawnTime then
				Des.Bot.RespawnQueue[wrapper] = nil -- 移除隊列
				
				local pos = wrapper.plrsim.spawnpos or {x=0,y=0,z=0}
				local old_bot = wrapper._bot
				
				-- 清除舊的怪物實體 (安全地扣血)
				if old_bot then pcall(function() old_bot.health = 0 end) end
				
				-- 生成新的一隻怪物
				local new_bot = Game.Monster:Create(Des.Game.MONSTERTYPE.A101AR.ID, pos)
				new_bot.maxhealth = 100
				new_bot.health = 100
				new_bot.maxarmor = 0
				new_bot.armor = 0
				new_bot.speed = 0.001
				new_bot.damage = 0
				new_bot.viewDistance = 0
				new_bot.checkAngle = 0
				new_bot.applyKnockback = false
				new_bot.canJump = false
				new_bot:Stop(true)
				
				-- 【修復核心】：從我們先前備份的 saved_user 複製資料，而不是從失效的 old_bot 拿
				if wrapper._proxy.saved_user then
					for k, v in pairs(wrapper._proxy.saved_user) do
						new_bot.user[k] = v
					end
				end
				
				-- 刷新備份引用與底層怪物指標
				wrapper._proxy.saved_user = new_bot.user
				wrapper._bot = new_bot
				wrapper._proxy.bot = new_bot
				
				-- 狀態更新為存活
				wrapper.user.alive = true
				wrapper.position = pos
				
				if Des.Game.Rule.OnPlayerSpawn then
					Des.Game.Rule.OnPlayerSpawn(wrapper)
				end
				f_setdelegate("Rule_OnPlayerSpawn", {wrapper})
			end
		end
	end, 
	nil
)

--------------------------------------------------
-- [[               傷害轉換                 ]] --
--------------------------------------------------
f_adddelegate(
	"Rule_OnTakeDamage"
	, "Des.Bot.OnTakeDamage"
	, function(victim, attacker, damage, weapontype, hitbox)
		if attacker then
			local bot = false
			
			if attacker:IsPlayer() then
				attacker = attacker:ToPlayer()
			end
			
			if attacker:IsMonster() then
				attacker = attacker:ToMonster()
				if attacker.user.isBot then
					bot = true
					attacker = attacker.user.wrapper
				end
			end
			
			if victim:IsPlayer() then
				victim = victim:ToPlayer()
			end
			
			if victim:IsMonster() then
				victim = victim:ToMonster()
				if victim.user.isBot then
					bot = true
					victim = victim.user.wrapper
				end
			end
			
			if bot then
				if Des.Game.Rule.OnPlayerAttack then
					Des.Game.Rule.OnPlayerAttack(victim, attacker, damage, weapontype, hitbox)
				end
				f_setdelegate("Rule_OnPlayerAttack", {victim, attacker, damage, weapontype, hitbox})
			end
		end
	end
	, nil
)

f_adddelegate(
	"Rule_OnKilled"
	, "Des.Bot.OnKilled"
	, function(victim, killer, weapontype, hitbox)
		if killer then
			local bot = false
			
			if killer:IsPlayer() then
				killer = killer:ToPlayer()
			end
			
			if killer:IsMonster() then
				killer = killer:ToMonster()
				if killer.user.isBot then
					bot = true
					killer = killer.user.wrapper
				end
			end
			
			if victim:IsPlayer() then
				victim = victim:ToPlayer()
			end
			
			if victim:IsMonster() then
				victim = victim:ToMonster()
				if victim.user.isBot then
					bot = true
					victim = victim.user.wrapper
				end
			end
			
			if bot then
				Des.Game.Rule.OnPlayerKilled(victim, killer, weapontype, hitbox)
				f_setdelegate("OnPlayerKilled", {victim, killer, weapontype, hitbox})
			end
		end
	end
	, nil
)

--==============================================--
--                [[ 內建涵式 ]]                --
--==============================================--

--------------------------------------------------
-- [[                主要架構                ]] --
--------------------------------------------------


Des.Game.EntityBlock.Data = Des.Game.EntityBlock.Data or {}

function Des.Game.EntityBlock.Create(position)
    local strpos = string.format("%.0f%.0f%.0f", position.x, position.y, position.z)
    
    -- 1. 只有第一次呼叫時，才會建立真實方塊與共用替身 (Proxy)
    if not Des.Game.EntityBlock.Data[strpos] then
        local real_eb = Game.EntityBlock.Create(position)
		if not real_eb then
			return
		end
        
        local data = {
            entityblock = real_eb,
            delegates = {
                OnSignal = {} -- 統一集中到 OnSignal
            },
            proxy = {} -- 建立該座標專屬的唯一替身
        }
        Des.Game.EntityBlock.Data[strpos] = data
        
        -- 設定替身的魔法 (Metatable)
        setmetatable(data.proxy, {
            __index = function(t, k)
				local val = real_eb[k]
				
				-- 如果拿出來的是個函數，我們需要包裝它
				if type(val) == "function" then
					return function(proxy_self, ...)
						-- 核心：將呼叫者傳進來的 proxy 替換回真實的 real_eb
						-- 這樣 real_eb:NativeMethod() 就能正常運作
						return val(real_eb, ...)
					end
				end
				
				return val
			end,
            
            __newindex = function(t, k, v)
                -- 只要名稱開頭是 "OnSignal"，就納入 delegate 系統
                if string.sub(k, 1, 8) == "OnSignal" then
                    data.delegates.OnSignal[k] = v
                else
                    real_eb[k] = v
                end
            end
        })
        
        -- 統一的事件處理中樞
        local function eb_OnSignal(self, player)
			f_red_script({name = string.format("des.trigger#%s", strpos), bool = true})
            for key, func in pairs(data.delegates.OnSignal) do
                -- 重點：這裡傳入 data.proxy 作為 self，確保函數內部的 self 具備替身魔法
                func(data.proxy, player)
            end
        end
        
        -- 將真實方塊的觸碰與使用，全部接管到 OnSignal 中樞
        real_eb.OnTouch = eb_OnSignal
        real_eb.OnUse = eb_OnSignal
    end
    
    -- 2. 每次建立/獲取時，直接回傳那個寫好魔法的共用替身
    return Des.Game.EntityBlock.Data[strpos].proxy
end

-- 1. 隱藏表 (存放主邏輯)
Des.Game.Rule._userLogics = Des.Game.Rule._userLogics or {}

Des.Game.Rule.LastArgsCache = Des.Game.Rule.LastArgsCache or {}
Des.Game.Rule.Condition = Des.Game.Rule.Condition or {}

-- 3. 轉移現有邏輯
for k, v in pairs(Des.Game.Rule.Api) do
    if Des.Game.Rule[k] then
        Des.Game.Rule._userLogics[k] = Des.Game.Rule[k]
        Des.Game.Rule[k] = nil 
    end
end

-- 4. 設置 Metatable
setmetatable(Des.Game.Rule, {
    __newindex = function(t, k, v)
        if Des.Game.Rule.Api[k] then
            Des.Game.Rule._userLogics[k] = v 
        else
            rawset(t, k, v)
        end
    end,
    
    __index = function(t, k)
        if Des.Game.Rule.Api[k] then
            return function(...)
                if Des.Dsg.illegalmode then return end
                
                local args = {...}
                local apiDef = Des.Game.Rule.Api[k]

                -- ==========================================
                -- 快取最後一次的參數
                -- ==========================================
                Des.Game.Rule.LastArgsCache["Rule_" .. k] = args

                -- ==========================================
                -- A. 執行過濾器 (Condition)
                -- ==========================================
                if Des.Game.Rule.Condition[k] then
                    local pass, allow = f_tryload(Des.Game.Rule.Condition[k], string.format("Des.Game.Rule.Condition.%s", k), args)
                    if pass and allow == false then
                        return 
                    end
                end
                
                Des.Game.Rule.Load[k] = Game.GetTime()
                local success, result = true, nil
                
                -- ==========================================
                -- B. 執行外部手寫的主邏輯 (_userLogics)
                -- ==========================================
                if Des.Game.Rule._userLogics[k] then
                    success, result = f_tryload(Des.Game.Rule._userLogics[k], string.format("Des.Game.Rule.%s", k), args)
                    
                    -- 將返回值更新回 args
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
                
                -- ==========================================
                -- C. 執行舊版 Delegate 
                -- ==========================================
                local delegate_result = f_setdelegate(string.format("Rule_%s", k), args, #apiDef.params)
                local final_result = (delegate_result ~= nil) and delegate_result or result

                -- (將舊系統最後的結果更新回 args，準備交給 Section)
                if final_result ~= nil and apiDef and apiDef["return"] and #apiDef["return"] > 0 then
                    local returnName = apiDef["return"][1]
                    if not returnName:match("^%[") then
                        for i, paramName in ipairs(apiDef["params"]) do
                            if paramName == returnName then
                                args[i] = final_result
                                break
                            end
                        end
                    end
                end

                -- ==========================================
                -- D. 執行新版 Section 系統 (🚀 核心升級點)
                -- ==========================================
                -- 1. 自動將 args 陣列打包成帶有名字的 Context
                local context = { _eventName = k }
                if apiDef and apiDef["params"] then
                    for i, paramName in ipairs(apiDef["params"]) do
                        context[paramName] = args[i]
                    end
                end

                -- 2. 跑遍所有註冊的 Section
                context = f_runsection(string.format("Rule_%s", k), context)

                -- 3. 從 Context 中把 return 值抽出來 (如果有被修改的話)
                if apiDef and apiDef["return"] and #apiDef["return"] > 0 then
                    local returnName = apiDef["return"][1]
                    if not returnName:match("^%[") then
                        if context[returnName] ~= nil then
                            final_result = context[returnName]
                        end
                    end
                end

                -- ==========================================
                -- E. 例外處理與防呆機制
                -- ==========================================
                if not success or final_result == nil then
                    if k == "OnTakeDamage" then
                        local victim, attacker = args[1], args[2]
                        if attacker and victim then
                            if attacker:IsPlayer() and victim:IsMonster() then
                                final_result = 0
                            end
                        end
                    end
                end
                
                Des.Game.Rule.Load[k] = 0
                return final_result
            end
        end
        return rawget(t, k)
    end
})

-- 5. 綁定引擎原生事件
for k, v in pairs(Des.Game.Rule.Api) do
    Game.Rule[k] = function(self, ...)
		local ret = Des.Game.Rule[k](...)
        return ret
    end
end

--------------------------------------------------
--                [[ 加入遊戲 ]]                --
--------------------------------------------------

function Des.Game.Rule.OnPlayerConnect(player)
	player.user.wait = 1
	
	player.user.drop = false
	player.user.gdrop = 0
	player.user.bad = ""
	
	Des.Sync.connect.value = player.index
	
	f_player_drop({player = player, check = true})
	
	if Des.Sync.state.value == 0 then
		table.insert(waiters, player)
	end
	
	if player.team < 0 or player.team > 3 then
		f_cheat_detected(player, 13, player.team)
	end
	
	player.user.__desystem__setbuymenulockid = 0
	
	player.user.__desystem__setbuymenuunlockid1 = 0
	player.user.__desystem__setbuymenuunlockid2 = 0
end

--------------------------------------------------
--                [[ 離開遊戲 ]]                --
--------------------------------------------------

function Des.Game.Rule.OnPlayerDisconnect(player)
	players[player.index] = nil
	
	Des.Sync.joined[player.index].value = 0
	Des.Sync.rejoin[player.index].value = 0
	Des.Sync.disconnect.value = player.index
	
	table.insert(leavers, {name = player.name})
	
	for k, v in pairs(waiters) do
		if player == v then
			table.remove(waiters, k)
		end
	end
end

--------------------------------------------------
--                [[ 回合開始 ]]                --
--------------------------------------------------

function Des.Game.Rule.OnRoundStart()
	Des.Sync.stload.value = 0
	
	f_red_script({name = "difficulty", bool = true})
	
	if not Des.Sync.localmode.value then
		Des.Sync.localmode.value = tostring(Game.GetTime())
	end
	
	if not __DESYSTEM__.tWAIT.bACTIVE then
		Des.Sync.state.value = 1
	end
	
	if Des.Sync.state.value == 0 then
		Des.Sync.stload.value = 0
		Des.Sync.maxremaining.value = 90
		
		-- for i = 1, 20 do
			-- em_bots({x = -158, y = -185 + i, z = 35})
		-- end
		
		f_red_script({name = "wait_music", flash = true})
	else
		win = false
		
		Des.Sync.state.value = 1
		
		f_red_script({name = "ready_music", flash = true})
	end
	
	if tonumber(Des.Sync.remaining.value) then
		Des.Sync.remaining.value = Game.GetTime() + Des.Sync.maxremaining.value
	end
end

function Des.Game.Rule.OnRoundStartFinished()
	
end

--------------------------------------------------
--                [[ 初次重生 ]]                --
--------------------------------------------------

function Des.Game.Rule.OnPlayerJoiningSpawn(player)
	players[player.index] = player
	
	player:ToggleWeaponInven()
	player:ToggleWeaponInven()
	
	if not dsgac or not passtouch then
		player.user.spawnxpass = true
	end
end

--------------------------------------------------
--                [[ 每次重生 ]]                --
--------------------------------------------------

function Des.Game.Rule.OnPlayerSpawn(player)
	if f_player_drop({player = player, check = true}) then
		player.health = 1
		player:Kill()
	end
	
	if not player.user.lobby then
		noxpass[player.index] = player
		
		player.gravity = 3
		player.maxspeed = 0.001
		
		player.user.wait = 2
		
		if passtouch then
			player.position = passtouch.position
		end
		
		for k, v in pairs(leavers) do
			if v.name == player.name then
				player.user.rejoin = true
				
				table.remove(leavers, k)
			end
		end
	else
		if Des.Sync.state.value == 0 then
			
		else
			
		end
	end
end

--------------------------------------------------
--                [[ 購買武器 ]]                --
--------------------------------------------------

function Des.Game.Rule.CanBuyWeapon(player, weaponid)
	
end

--------------------------------------------------
--                [[ 拾取武器 ]]                --
--------------------------------------------------

function Des.Game.Rule.CanHaveWeaponInHand(player, weaponid, weapon)
	if not weapon then
		return
	end
end

--------------------------------------------------
--                [[ 取得武器 ]]                --
--------------------------------------------------

function Des.Game.Rule.OnGetWeapon(player, weaponid, weapon)
	if not weapon then
		return
	end
end

--------------------------------------------------
--                [[ 切換武器 ]]                --
--------------------------------------------------

function Des.Game.Rule.OnSwitchWeapon(player)
	
end

--------------------------------------------------
--                [[ 掏出武器 ]]                --
--------------------------------------------------

function Des.Game.Rule.OnDeployWeapon(player, weapon)
	if not weapon then
		return
	end
	
	if weapon.weaponid == 4
	or weapon.weaponid == 9
	or weapon.weaponid == 25 then
		weapon:AddClip1(1)
	end
	
	if not weapon.user.set then
		weapon.user.set = true
		
		local deset = __DESYSTEM__.tWEAPON.tSET[0]
		for k, v in pairs(deset or {}) do
			if type(weapon[k]) == "function" then
				weapon[k](weapon, v)
			else
				weapon[k] = v
			end
		end
	end
end

--------------------------------------------------
--                [[ 武器開槍 ]]                --
--------------------------------------------------

function Des.Game.Rule.PostFireWeapon(player, weapon, time)
	if not weapon then
		return
	end
end

--------------------------------------------------
--                [[ 武器換彈 ]]                --
--------------------------------------------------

function Des.Game.Rule.OnReload(player, weapon, time)
	if not weapon then
		return
	end
end

--------------------------------------------------
--                [[ 換彈完畢 ]]                --
--------------------------------------------------

function Des.Game.Rule.OnReloadFinished(player, weapon)
	if not weapon then
		return
	end
end

--------------------------------------------------
--                [[ 發送訊號 ]]                --
--------------------------------------------------

function Des.Game.Rule.OnPlayerSignal(player, signal)
	if signal == 0 then
		if not player.user.lobby then
			player.gravity = 1
			player.maxspeed = 1
			
			player.user.wait = 3
			
			player.user.lobby = true
			
			Des.Game.Rule.OnPlayerSpawn(player)
		end
		
		-- 預設開發者模式
		for number, name in pairs(developers) do
			if name == player.name then
				player.user.developer = true
				Des.Sync.developer.value = player.index
			end
		end
	end
end

--------------------------------------------------
--                [[ 玩家受傷 ]]                --
--------------------------------------------------

function Des.Game.Rule.OnPlayerAttack(victim, attacker, damage, weapontype, hitbox)
	if not victim then
		return
	end
	

	if not attacker then
		return damage / difficultyrate
	end
end

--------------------------------------------------
--                [[ 實體受傷 ]]                --
--------------------------------------------------

function Des.Game.Rule.OnTakeDamage(victim, attacker, damage, weapontype, hitbox)
	if not victim then
		return
	end
	
	if victim:IsMonster() then
		local victim = victim:ToMonster()
	end
	
	if victim:IsPlayer() then
		local victim = victim:ToPlayer()
	end

	if not attacker then
		return
	end
	
	if attacker:IsPlayer() then
		local attacker = attacker:ToPlayer()
		if victim:IsMonster() then
			local victim = victim:ToMonster()
		end
	end
	
	if attacker:IsMonster() then
		local attacker = attacker:ToMonster()
		if victim:IsPlayer() then
			local victim = victim:ToPlayer()
		end
	end
	
end

--------------------------------------------------
--                [[ 玩家死亡 ]]                --
--------------------------------------------------

function Des.Game.Rule.OnPlayerKilled(victim, killer, weapontype, hitbox)
	if not victim then
		return
	end
	
	
	
	if not killer then
		return
	end
	
	
end

--------------------------------------------------
--                [[ 實體死亡 ]]                --
--------------------------------------------------

function Des.Game.Rule.OnKilled(victim, killer)
	if not victim then
		return
	end
	
	
	
	if not killer then
		return
	end
	
	
end

--------------------------------------------------
--                [[ 調用涵式 ]]                --
--------------------------------------------------

function Des.Game.Rule.OnUpdate(time)
	-- f_red_script({name = "usefasterupdate", flash = true})
	
	Des.Sync.scoreboard.value = string.format("%02d%02d%02d%02d", scoreboard.now, scoreboard.max, scoreboard[Game.TEAM.TR], scoreboard[Game.TEAM.CT])
	Des.Sync.countplayer.value = string.format("%02d%02d%02d", countplayer.all, countplayer[Game.TEAM.TR], countplayer[Game.TEAM.CT])
	
	if Des.Sync.drop.value ~= "000" then
		Des.Sync.drop.value = "000"
	end
	
	if reround then
		reround = false
		Des.Game.Rule.OnRoundStart()
		-- Game.Rule:Respawn()
		for k, v in pairs(players) do
			if v then
				if v.user.lobby then
					v:Respawn()
					Des.Game.Rule.OnPlayerSpawn(v)
				end
			end
		end
	end
	
	if Des.Sync.state.value == 0 then
		if countplayer.all > minplayers - 1 then
			if not tonumber(Des.Sync.remaining.value) then
				Des.Sync.remaining.value = time + waitingrecord
			end
			waitingrecord = Des.Sync.remaining.value - time
		else
			Des.Sync.remaining.value = f_getlanguage(language.wait.minplayers)
		end
		
		table.sort(waiters, f_sort_waiting)
		local notready = false
		for k, v in pairs(waiters) do
			if v then
				if Des.Sync.plrswait[k] then
					Des.Sync.plrswait[k].value = string.format("%d%d%s", v.team, v.user.wait, v.name)
					if v.user.wait < 3 then
						notready = true
					end
				end
			end
		end
		if not notready then
			if tonumber(Des.Sync.remaining.value) then
				if Des.Sync.remaining.value > time + 5 then
					Des.Sync.remaining.value = time + 5
					waitingrecord = 5
				end
			end
		end
	elseif Des.Sync.state.value == 3 then
		if wincheck then
			if not win then
				if win then
					
				end
			end
		end
	end
	
	if customupdate["1"] < time then
		if tonumber(Des.Sync.remaining.value) then
			if Des.Sync.remaining.value < time then
			
				if Des.Sync.state.value == 0 then
					
					-- 等待玩家階段結束
					
					-- Game.Rule:Win(3, false)
					reround = true
					f_red_script({name = "off_music", flash = true})
					
					Des.Sync.state.value = 10
					Des.Sync.maxremaining.value = 5
					
				elseif Des.Sync.state.value == 1 then

					f_red_script({name = "off_music", flash = true})

					Des.Sync.maxremaining.value = 10

				elseif Des.Sync.state.value == 2 then
					
					
					
				end
				
				Des.Sync.state.value = Des.Sync.state.value + 1
				if tonumber(Des.Sync.remaining.value) then
					Des.Sync.remaining.value = time + Des.Sync.maxremaining.value
				end
			end
		end
	end
	
	for k, v in pairs(msgreg) do
		f_dialogue_send(v.to, v.msg, v.clr)
		table.remove(msgreg, k)
		break
	end
	
	for k, v in pairs(countplayer) do
		countplayer[k] = 0
	end
	
	for k, v in pairs(players) do
		if v then
			
			-- v:ClearWeaponInven()
			
			if v.user.drop then
				if v.user.gdrop < time then
					for i = 1, 100 do
						v:Respawn()
					end
					v.user.drop = false
				end
			end
			
			if v.user.lobby then
				countplayer.all = countplayer.all + 1
			end
			
			if __DESYSTEM__.tWEAPON.tBUYMENU_LOCK_LIST then
				if player.user.__desystem__setbuymenulockid < #__DESYSTEM__.tWEAPON.tBUYMENU_LOCK_LIST then
					local ic = 0
					for i = player.user.__desystem__setbuymenulockid + 1, #__DESYSTEM__.tWEAPON.tBUYMENU_LOCK_LIST do
						player:SetBuymenuLockedUI(__DESYSTEM__.tWEAPON.tBUYMENU_LOCK_LIST[i], true)
						
						ic = ic + 1
						if ic == 10 then
							break
						end
					end
					player.user.__desystem__setbuymenulockid = player.user.__desystem__setbuymenulockid + 10
				end
			end
			
			if __DESYSTEM__.tWEAPON.tBUYMENU_UNLOCK_LIST then
				if player.user.__desystem__setbuymenuunlockid1 < 1000 then
					local ic = 0
					for i = player.user.__desystem__setbuymenuunlockid1 + 1, 1000 do
						player:SetBuymenuLockedUI(i, true)
						
						ic = ic + 1
						if ic == 10 then
							break
						end
					end
					player.user.__desystem__setbuymenuunlockid1 = player.user.__desystem__setbuymenuunlockid1 + 10
				elseif player.user.__desystem__setbuymenuunlockid2 < #__DESYSTEM__.tWEAPON.tBUYMENU_UNLOCK_LIST then
					local ic = 0
					for i = player.user.__desystem__setbuymenuunlockid2 + 1, #__DESYSTEM__.tWEAPON.tBUYMENU_UNLOCK_LIST do
						player:SetBuymenuLockedUI(__DESYSTEM__.tWEAPON.tBUYMENU_UNLOCK_LIST[i], false)
						
						ic = ic + 1
						if ic == 10 then
							break
						end
					end
					player.user.__desystem__setbuymenuunlockid2 = player.user.__desystem__setbuymenuunlockid2 + 10
				end
			end
			
			f_setdelegate(string.format("Rule_OnPlayerUpdate", v.index), {v, time})
			
			--[[
			local testentity = Des.Game.EntityBlock.Create({x = -186, y = -192, z = -94})
			if testentity then
				v.user.testbool = not v.user.testbool
				if v.user.testbool then
					testentity:Event({action = "reset", target = v})
					testentity:Event({action = "use", target = v})
				end
			end
			]]
		end
	end
	
	for k, v in pairs(noxpass) do
		if v then
			if v.user.spawnxpass then
				if not v.user.passdetect then
					v.user.passdetect = time + 0.1
				elseif v.user.passdetect < time then
					if passtouch and not players[v.index] then
						print(string.format("<ffaaaa>%s pass failed!", v.name))
						f_cheat_detected(v, 2)
					else
						print(string.format("<aaffaa>%s passed!", v.name))
						
						v:Respawn()
						v.model = Game.MODEL.NORMAL_ZOMBIE
						v.model = Game.MODEL.DEFAULT
						
						if v.user.rejoin then
							v.gravity = 1
							v.maxspeed = 1
							Des.Sync.rejoin[v.index].value = 1
						else
							Des.Sync.joined[v.index].value = 1
						end
					end
					noxpass[v.index] = nil
				end
			end
		end
	end
	
	for k, v in pairs(customupdate) do
		if v < time then
			customupdate[k] = time + tonumber(k)
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