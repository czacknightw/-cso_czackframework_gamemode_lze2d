--SYSTEM========================================--
--                [[ 製作名單 ]]                --
--==============================================--
--[[

地圖製作：

程式設計：DestroyerI滅世I // Czack

-- ==============================================================================

-- Project: Czack Framework 26s3.1 (Lua Zombie Escape 2D / LZE2D)
-- Module:  system.lua
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

print(string.format("<aaffaa>[%s]system.lua is loaded.", Des.Mapsys))
log(string.format("<aaffaa>[%s]system.lua is loaded.", Des.Mapsys))

--==============================================--
--                [[ 提醒事項 ]]                --
--==============================================--



--==============================================--
--                [[ 參考列表 ]]                --
--==============================================--
--[[



]]
--==============================================--
--                [[ 內容設置 ]]                --
--==============================================--

--------------------------------------------------
--                [[ 堆疊計算 ]]                --
--------------------------------------------------

-- By. Ain神的規律P

DESYSTEM.BUFFVALUE = {}
DESYSTEM.BUFFVALUE.__index = DESYSTEM.BUFFVALUE

function DESYSTEM.BUFFVALUE.CREATE()
    return setmetatable({
        _list = {},
        _invoking = false,
        _pendingRemove = {}
    }, DESYSTEM.BUFFVALUE)
end

function DESYSTEM.BUFFVALUE:GET(name, default)
    for _, buff in ipairs(self._list) do
        if buff.name == name and not buff.remove then
            local action = { stop = false, Stop = function(self) self.stop = true end }

            local value = buff.func(action, 0)
			
            return value or default
        end
    end
	return default
end

function DESYSTEM.BUFFVALUE:ADD(name, func, priority)
    local target_priority = priority or 0
    local is_exist = false

    -- 1. 遍歷目前的列表，尋找同名的 buff
    for i, buff in ipairs(self._list) do
        if buff.name == name then
            -- 找到同名的，直接覆蓋資料
            buff.func = func
            -- buff.priority = target_priority
            buff.remove = false
            is_exist = true
            break -- 既然找到了就跳出迴圈，節省效能
        end
    end

    -- 2. 如果迴圈跑完都沒找到，代表是新的 buff，就新增進去
    if not is_exist then
		if target_priority == 0 then
			for i, buff in ipairs(self._list) do
				if buff.priority >= target_priority then
					target_priority = buff.priority
				end
			end
		end
		
        table.insert(self._list, {
            name = name,
            func = func,
            priority = target_priority + 1,
            remove = false
        })
    end

    -- 3. 無論是更新還是新增，最後都重新排序
    table.sort(self._list, function(a, b)
        return a.priority < b.priority
    end)
end

function DESYSTEM.BUFFVALUE:REMOVE(name)
    for _, v in ipairs(self._list) do
        if v.name == name then
            if self._invoking then
                v.remove = true
            else
                v.remove = true
            end
        end
    end
end

function DESYSTEM.BUFFVALUE:INVOKE(value, arg)
    self._invoking = true

    local action = {
        stop = false,
        Stop = function(self)
            self.stop = true
        end
    }

    for _, buff in ipairs(self._list) do
        if not buff.remove then
            value = buff.func(action, value, arg)

            if value == nil then
                error("Buff 必須回傳值: ".. buff.name)
            end

            if action.stop then
                break
            end
        end
    end

    self._invoking = false
	
    for i = #self._list, 1, -1 do
        if self._list[i].remove then
            table.remove(self._list, i)
        end
    end

    return value
end

--------------------------------------------------
--                [[ 排程執行 ]]                --
--------------------------------------------------

-- By. Ain神的規律P

DESYSTEM.SCHEDULE = {}
DESYSTEM.SCHEDULE.__index = DESYSTEM.SCHEDULE

-- 建立一個新的計時管理器實例
function DESYSTEM.SCHEDULE.CREATE()
    return setmetatable({
        _tasks = {},
        _invoking = false
    }, DESYSTEM.SCHEDULE)
end

-- 內部更新邏輯：與 OnUpdateDelegate 對接
function DESYSTEM.SCHEDULE:_UPDATE(dt)
    self._invoking = true
    
    for i, task in ipairs(self._tasks) do
        if not task.remove then
            task.cur = task.cur + dt
            
            -- 判斷是否到達觸發時間
            if task.cur >= task.time then
                task.callback()
                
                if task.type == "once" then
                    task.remove = true
                elseif task.type == "loop" then
                    task.cur = task.cur - task.time
                elseif task.type == "count" then
                    task.curCount = task.curCount + 1
                    task.cur = task.cur - task.time
                    if task.curCount >= task.maxCount then
                        task.remove = true
                    end
                end
            end
        end
    end
    
    self._invoking = false
    
    -- 清理已完成或標記刪除的任務
    for i = #self._tasks, 1, -1 do
        if self._tasks[i].remove then
            table.remove(self._tasks, i)
        end
    end
end


function DESYSTEM.SCHEDULE:GET(name)
	for _, task in ipairs(self._tasks) do
        if task.name == name then
            return task
        end
    end
end

-- 停止特定名稱的計時器
function DESYSTEM.SCHEDULE:STOP(name)
    for _, task in ipairs(self._tasks) do
        if task.name == name then
            task.remove = true
        end
    end
end

-- 執行一次 (Once)
function DESYSTEM.SCHEDULE:ONCE(name, time, callback)
    self:STOP(name) -- 確保同名計時器不會重複
    table.insert(self._tasks, {
        name = name,
        type = "once",
        time = time,
        cur = 0,
        callback = callback,
        remove = false
    })
end

-- 循環執行 (Loop)
function DESYSTEM.SCHEDULE:LOOP(name, time, callback)
    self:STOP(name)
    table.insert(self._tasks, {
        name = name,
        type = "loop",
        time = time,
        cur = 0,
        callback = callback,
        remove = false
    })
end

-- 指定次數執行 (Count)
function DESYSTEM.SCHEDULE:COUNT(name, time, count, callback)
    self:STOP(name)
    table.insert(self._tasks, {
        name = name,
        type = "count",
        time = time,
        cur = 0,
        maxCount = count,
        curCount = 0,
        callback = callback,
        remove = false
    })
end

--------------------------------------------------
--------------------------------------------------

--------------------------------------------------
--                [[ 系統切換 ]]                --
--------------------------------------------------

LZE2D.SYSTEM.__INIT__ = function(self)
	Des.Keybind:ADD({
		keys       = {{"W"}},
		name       = "movefront",
		desc       = "向前移動",
		
		conflict   = true,
		deadsignal = false,
		
		OnKeyDown = {
			gamesignal = function(player, signal)
				player.user.movekey.w = true
			end,
		},
		
		OnKeyUp = {
			gamesignal = function(player, signal)
				player.user.movekey.w = false
			end,
		},
	})
	
	Des.Keybind:ADD({
		keys       = {{"A"}},
		name       = "moveleft",
		desc       = "向左移動",
		
		conflict   = true,
		deadsignal = false,
		
		OnKeyDown = {
			gamesignal = function(player, signal)
				player.user.movekey.a = true
			end,
		},
		
		OnKeyUp = {
			gamesignal = function(player, signal)
				player.user.movekey.a = false
			end,
		},
	})
	
	Des.Keybind:ADD({
		keys       = {{"S"}},
		name       = "moveback",
		desc       = "向後移動",
		
		conflict   = true,
		deadsignal = false,
		
		OnKeyDown = {
			gamesignal = function(player, signal)
				player.user.movekey.s = true
			end,
		},
		
		OnKeyUp = {
			gamesignal = function(player, signal)
				player.user.movekey.s = false
			end,
		},
	})
	
	Des.Keybind:ADD({
		keys       = {{"D"}},
		name       = "moveright",
		desc       = "向右移動",
		
		conflict   = true,
		deadsignal = false,
		
		OnKeyDown = {
			gamesignal = function(player, signal)
				player.user.movekey.d = true
			end,
		},
		
		OnKeyUp = {
			gamesignal = function(player, signal)
				player.user.movekey.d = false
			end,
		},
	})
	
	Des.Keybind:ADD({
		keys       = {{"M"}},
		name       = "gamedescription",
		desc       = "遊戲說明",
		
		conflict   = true,
		deadsignal = false,
		
		OnKeyDown = {
			gamesignal = function(player, signal)
				if self.book_description then
					if self.book then
						self.book:Event({action = "use", target = player})
					end
				end
			end,
		},
	})
	
	--[[
	Des.Keybind:ADD({
		keys       = {{"B"}},
		name       = "weaponinven",
		desc       = "武器背包",
		
		conflict   = true,
		deadsignal = false,
		
		OnKeyDown = {
			gamesignal = function(player, signal)
				if player.user.inround then
					if player.team == Game.TEAM.CT then
						player:ToggleWeaponInven()
					end
				end
			end,
		},
	})
	]]
	
	Des.Game.Blua:ADD("DimBuyCar", {{"on"}, {"x", "y", "z"}, function(env)
		local entityblock = Des.Game.EntityBlock.Create({x = env.x, y = env.y, z = env.z})
		if entityblock then
			entityblock:Event({action = "signal", value = true})
			function entityblock:OnUse(player)
				-- local strpos = string.format("%d%d%d", env.x, env.y, env.z)
				-- Game.SetTrigger(string.format("buymenu#%s", strpos), true)
				entityblock:Event({action = "signal", value = false})
				LZE2D.__GAMETIMER__:ONCE("buycarreset", 0.1, function()
					entityblock:Event({action = "signal", value = true})
				end)
				player:ShowBuymenu()
			end
		end
	end})
	
	Des.Game.Blua:ADD(self.BLUA.SetReadyTime, {{"on"}, {"time"}, function(env)
		self.DATA.flTIME_READY = env.time or 30
	end})
	
	Des.Game.Blua:ADD(self.BLUA.SetRoundTime, {{"on"}, {"time"}, function(env)
		self.DATA.flTIME_ROUND = env.time or 900
	end})
	
	Des.Game.Blua:ADD(self.BLUA.SetBook, {{"on"}, {"x", "y", "z"}, function(env)
		local entityblock = Des.Game.EntityBlock.Create({x = env.x, y = env.y, z = env.z})
		if entityblock then
			self.book = entityblock
		end
	end})
	
	Des.Game.Blua:ADD(self.BLUA.SetDialogue, {{"on"}, {"textid", "r", "g", "b"}, function(env)
		if self.DATA.tDIALOGUE[env.textid] then
			f_dialogue_send("all", self.DATA.tDIALOGUE[env.textid], {r = env.r or 255, g = env.g or 255, b = env.b or 255})
		end
	end})
	
	for k, v in pairs(self.DATA.tBUYCAR) do
		local entityblock = Des.Game.EntityBlock.Create(v)
		if entityblock then
			entityblock:Event({action = "signal", value = true})
			function entityblock:OnUse(player)
				-- local strpos = string.format("%d%d%d", v.x, v.y, v.z)
				-- Game.SetTrigger(string.format("buymenu#%s", strpos), true)
				entityblock:Event({action = "signal", value = false})
				LZE2D.__GAMETIMER__:ONCE("buycarreset", 0.1, function()
					entityblock:Event({action = "signal", value = true})
				end)
				player:ShowBuymenu()
			end
		end
	end
	
	self.EB_WB_PRIMARY = {}
	for k, v in pairs(self.DATA.tWEAPONBASE_PRIMARY or {}) do
		self.EB_WB_PRIMARY[k] = Des.Game.EntityBlock.Create(v)
	end
	self.EB_WB_SECONDARY = {}
	for k, v in pairs(self.DATA.tWEAPONBASE_SECONDARY or {}) do
		self.EB_WB_SECONDARY[k] = Des.Game.EntityBlock.Create(v)
	end
	
	if Des.Sys == Game then
		Game.SetTrigger(self.RLUA.OnGameStart, true)
	end
	
	self.book_description = true
end

LZE2D.SYSTEM.__DELEGATE__ = {
	Rule_OnRoundStart = function(self)
		if Des.Sync.state.value == 1 then
			Game.SetTrigger(self.RLUA.OnReset, true)
			Game.SetTrigger(self.RLUA.OnReset, false)
			
			LZE2D.__GAMETIMER__:ONCE("triggerRoundStart", 0.2, function()
				if Des.Sync.state.value == 1 then
					Game.SetTrigger(self.RLUA.OnRoundStart, true)
					Game.SetTrigger(self.RLUA.OnRoundStart, false)
				end
			end)
			
			for k, v in pairs(players) do
				if v then
					if v.user.lobby then
						v.user.inround = true
						v.user.alive = true
						v.user.respawning = false
						
						v.maxspeed = 1
						v.gravity = 1
						
						v:ClearWeaponInven()
					end
				end
			end
		end
	end,
	Rule_OnPlayerConnect = function(player, self)
		player.team = Game.TEAM.TR
		
		player.user.language = "tw"
		
		player.user.movekey = {
			a = false,
			d = false,
			w = false,
			s = false,
		}
		
		player.user.inround = false
		player.user.alive = false
		player.user.respawning = false
	end,
	Rule_OnPlayerSpawn = function(player, self)
		player.user.movekey = {
			a = false,
			d = false,
			w = false,
			s = false,
		}
		
		if player.user.lobby then
			if Des.Sync.state.value == 1 then
				player.user.inround = true
			elseif Des.Sync.state.value > 1 then
				
			end
			
			if player.user.inround then
				player.user.alive = true
			end
		else
			
		end
		player.user.respawning = false
	end,
	Rule_OnPlayerSignal = function(player, signal, self)
		if signal == 0 then
			if Des.Sync.state.value <= 1 then
				player.user.inround = true
				player.user.alive = true
				
				local defset = LZE2D.VIEW.DATA.tDEFAULT
				player.user.view = defset
				player:SetFirstPersonView()
				player:SetThirdPersonFixedView(defset.yaw, defset.pitch, defset.mindist, defset.maxdist)
				player:SetThirdPersonFixedPlane(Game.THIRDPERSON_FIXED_PLANE[defset.plane])
			elseif Des.Sync.state.value > 1 then
				
			end
		end
	end,
	Rule_OnPlayerKilled = function(victim, killer, self)
		if not victim then
			return
		end
		
		if victim.user.inround then
			victim.user.alive = false
			victim:Respawn()
			
			victim.user.respawning = true
		end
	end,
	Rule_OnPlayerUpdate = function(player, time, self)
		if player.user.inround then
			if (player.team == Game.TEAM.CT and player.user.alive) or player.team == Game.TEAM.TR then
				countplayer[player.team] = countplayer[player.team] + 1
			end
			
			if not player.user.respawning and player.user.alive and player.health <= 0 then
				player:Respawn()
				player.user.alive = false
				player.user.respawning = true
			end
		end
		
		self:AIRSPEED(player, 15)
	end,
	
	SyncChanged_state = function(new, old, proxy, self)
		Game.SetTrigger(string.format(self.RLUA.OnState, new), true)
		if new == 1 then
			Des.Sync.maxremaining.value = self.DATA.flTIME_READY
		end
		if new == 2 then
			Des.Sync.maxremaining.value = self.DATA.flTIME_ROUND
			for k, v in pairs(LZE2D.HUMAN:GETPLAYERS()) do
				if not v:GetPrimaryWeapon() then
					if #self.EB_WB_PRIMARY > 0 then
						local r = math.random(#self.EB_WB_PRIMARY)
						if self.EB_WB_PRIMARY[r] then
							self.EB_WB_PRIMARY[r]:Event({action = "reset", target = v})
							self.EB_WB_PRIMARY[r]:Event({action = "use", target = v})
							self.EB_WB_PRIMARY[r]:Event({action = "reset", target = v})
						end
					end
				end
				if not v:GetSecondaryWeapon() then
					
				end
			end
		end
	end,
}

LZE2D.SYSTEM.AIRSPEED = function(self, player, speed)
	local speed = speed or 10
	
	if not player or not player.user.lobby then
		return
	end
	
	if not player.user.inround or (player.user.inround and player.team == Game.TEAM.CT) then
		if player.velocity.z ~= 0 then
			local mspeed = player.maxspeed * 300

			local vx = player.velocity.x or 0
			local vy = player.velocity.y or 0

			-- 1. 計算目前的水平移動長度
			local current_len = math.sqrt(vx^2 + vy^2)

			-- 2. 若玩家完全沒有水平速度，則不進行加速
			if current_len == 0 then return end

			-- 3. 取得目前移動方向的單位向量 (Normalize) 並乘上加速量
			local dir_x = vx / current_len
			local dir_y = vy / current_len

			local accel_x = dir_x * speed
			local accel_y = dir_y * speed

			-- 4. 更新速度並做限制 (Clamp)
			local new_vx = math.clamp(vx + accel_x, -mspeed, mspeed)
			local new_vy = math.clamp(vy + accel_y, -mspeed, mspeed)
			local vz = player.velocity.z

			-- 5. 回寫速度 (包含 z 軸避免被覆蓋清空)
			player.velocity = {x = new_vx, y = new_vy}
		end
	end
end

--------------------------------------------------
--                [[ 視角切換 ]]                --
--------------------------------------------------

LZE2D.VIEW.__INIT__ = function(self)
	Des.Game.Blua:ADD("DimViewDefault", {{"on"}, {"yaw", "pitch", "mindist", "maxdist", "plane"}, function(env)
		self.DATA.tDEFAULT = {
			yaw = env.yaw,
			pitch = env.pitch,
			mindist = env.mindist,
			maxdist = env.maxdist,
			plane = env.plane
		}
	end})
	
	Des.Game.Blua:ADD("SetPlayerView", {{"on", "player"}, {"yaw", "pitch", "mindist", "maxdist", "plane"}, function(env)
		if not env.player then
			return
		end
		
		env.player:SetFirstPersonView()
		if env.yaw then
			env.player.user.view = {
				yaw = env.yaw,
				pitch = env.pitch,
				mindist = env.mindist,
				maxdist = env.maxdist,
				plane = env.plane,
			}
			env.player:SetThirdPersonFixedView(env.yaw, env.pitch, env.mindist, env.maxdist)
			env.player:SetThirdPersonFixedPlane(Game.THIRDPERSON_FIXED_PLANE[env.plane])
		else
			local defset = self.DATA.tDEFAULT
			env.player.user.view = defset
			env.player:SetThirdPersonFixedView(defset.yaw, defset.pitch, defset.mindist, defset.maxdist)
			env.player:SetThirdPersonFixedPlane(Game.THIRDPERSON_FIXED_PLANE[defset.plane])
		end
		
		LZE2D.__GAMETIMER__:STOP("review" .. env.player.index)
	end})
end

LZE2D.VIEW.__DELEGATE__ = {
	Rule_OnPlayerConnect = function(player, self)
		player.user.view = {
			yaw = 0,
			pitch = 0,
			mindist = 0,
			maxdist = 0,
			plane = "GROUND",
		}
	end,
	Rule_OnPlayerSpawn = function(player, self)
		local defset = self.DATA.tDEFAULT
		player.user.view = defset
		
		player:SetFirstPersonView()
		player:SetThirdPersonFixedView(defset.pitch, defset.yaw, defset.mindist, defset.maxdist)
		player:SetThirdPersonFixedPlane(Game.THIRDPERSON_FIXED_PLANE.GROUND)
		
		LZE2D.__GAMETIMER__:ONCE("review" .. player.index, 0.1, function()
			player:SetFirstPersonView()
			player:SetThirdPersonFixedView(defset.yaw, defset.pitch, defset.mindist, defset.maxdist)
			player:SetThirdPersonFixedPlane(Game.THIRDPERSON_FIXED_PLANE[defset.plane])
		end)
	end,
}

--------------------------------------------------
--                [[ 牆壁推力 ]]                --
--------------------------------------------------

LZE2D.WALLPUSH.__INIT__ = function(self)
	self.Point = {}
	
	Des.Game.Blua:ADD(self.BLUA.AddWallPush, {{"on"}, {"x1", "y1", "z1", "x2", "y2", "z2", "xP", "yP", "zP"}, function(env)
		table.insert(self.Point, env)
	end})
end

LZE2D.WALLPUSH.__DELEGATE__ = {
	Rule_OnPlayerUpdate = function(player, time, self)
		for k, v in pairs(self.Point) do
			if player.position.x >= math.min(v.x1, v.x2)
			and player.position.y >= math.min(v.y1, v.y2)
			and player.position.z >= math.min(v.z1, v.z2)
			and player.position.x <= math.max(v.x1, v.x2)
			and player.position.y <= math.max(v.y1, v.y2)
			and player.position.z <= math.max(v.z1, v.z2) then
				player.velocity = {
					x = (v.xP or 0) * 250,
					y = (v.yP or 0) * 250,
					z = (v.zP or 0) * 250,
				}
			end
		end
	end,
}

--------------------------------------------------
--                [[ 牆壁破壞 ]]                --
--------------------------------------------------

LZE2D.WALLBREAK.__INIT__ = function(self)
	Des.Game.Blua:ADD(self.BLUA.ChainWallBreak, {{"on"}, {"x", "y", "z"}, function(env)
		local startBlock = Des.Game.EntityBlock.Create({x = env.x, y = env.y, z = env.z})
		if startBlock then
			if not startBlock.onoff then
				local visited = {}
				self:CHAIN(env.x, env.y, env.z, startBlock.id, visited)
			end
		end
	end})
end

LZE2D.WALLBREAK.__DELEGATE__ = {
	
}

LZE2D.WALLBREAK.CHAIN = function(self, x, y, z, targetId, visited)
	local key = x .. "," .. y .. "," .. z
	
	-- 避免重複觸發已造訪過的座標（防止擺放成環狀時死迴圈）
	if visited[key] then return end
	visited[key] = true

	-- 取得該座標的 EntityBlock
	local currentBlock = Des.Game.EntityBlock.Create({x = x, y = y, z = z})
	
	-- 檢查方塊是否存在，且 ID 是否與起始方塊相同
	if currentBlock and currentBlock.id == targetId then
		-- 發送訊號
		currentBlock:Event({action = "signal"})

		-- 3D 空間 6 個相鄰方向 (東、西、南、北、上、下)
		local neighbors = {
			{x = x + 1, y = y,     z = z},     -- +X
			{x = x - 1, y = y,     z = z},     -- -X
			{x = x,     y = y + 1, z = z},     -- +Y
			{x = x,     y = y - 1, z = z},     -- -Y
			{x = x,     y = y,     z = z + 1}, -- +Z
			{x = x,     y = y,     z = z - 1}, -- -Z
		}

		-- 對 6 個方向繼續遞迴尋找
		for _, pos in ipairs(neighbors) do
			self:CHAIN(pos.x, pos.y, pos.z, targetId, visited)
		end
	end
end

--------------------------------------------------
--                [[ 回合進度 ]]                --
--------------------------------------------------

LZE2D.ROUNDPROGRESS.__INIT__ = function(self)
	self.TOGGLE = false
	
	self.GETSTPLR = 0
	self.EB_PROGRESS = {}
	self.BLUA_PROGRESS_POSITION = {}
	
	self.HM_PROGRESS = 1
	self.ZB_PROGRESS = 1
	
	self.PLAYER_PROGRESS = {}
	
	self.__dimstart__ = {}
	self.__dimend__ = {}
	
	for i = 1, 20 do
		self.PLAYER_PROGRESS[i] = {
			HM = {},
			ZB = {},
		}
	end
	
	Des.Game.Blua:ADD(self.BLUA.DimProgressStart, {{"on", "position"}, {}, function(env)
		self.__dimstart__ = env.position
	end})

	Des.Game.Blua:ADD(self.BLUA.DimProgressEnd, {{"on"}, {}, function(env)
		self.__dimend__ = env.position
		LZE2D.__GAMETIMER__:ONCE("dimprogress", 0.1, function()
			local pStart = self.__dimstart__
			local pEnd = self.__dimend__

			if not pStart or not pEnd then return end

			-- 1. 計算兩點間的向量與距離
			local dx = pEnd.x - pStart.x
			local dy = (pEnd.y or 0) - (pStart.y or 0)
			local dz = (pEnd.z or 0) - (pStart.z or 0)
			
			-- 計算三維歐氏距離（若為 2D 遊戲可無視 dz）
			local distance = math.sqrt(dx * dx + dy * dy + dz * dz)
			
			-- 2. 設定生成密度 (假設每 1 個單位距離生成 1 個方塊)
			local stepSize = 1
			local count = math.max(1, math.floor(distance / stepSize))

			self.EB_PROGRESS = self.EB_PROGRESS or {}

			-- 3. 沿直線插值計算各點 XYZ 並生成 EntityBlock
			for i = 0, count do
				local t = (count == 0) and 0 or (i / count) -- 插值比例 (0.0 到 1.0)
				
				local posX = pStart.x + dx * t
				local posY = (pStart.y or 0) + dy * t
				local posZ = ((pStart.z or 0) + dz * t) - 2 -- Z 軸減 2

				-- 生成 EntityBlock 並寫入表格
				self.EB_PROGRESS[i + 1] = Des.Game.EntityBlock.Create({
					x = posX,
					y = posY,
					z = posZ
				})
			end
		end)
	end})
	
	Des.Game.Blua:ADD(self.BLUA.ToggleRoundProgress, {{"on"}, {"state"}, function(env)
		self:TOGGLE(env.state)
	end})
	
	Des.Game.Blua:ADD(self.BLUA.SetPlayerRoundProgress, {{"on", "player", "position"}, {"id"}, function(env)
		if self.EB_PROGRESS[env.id] then
			local old = env.player.user.progress
			
			env.player.user.progress = env.id
			env.player.user.progresspoint = env.player.position
			
			self.EB_PROGRESS[env.id]:Event({action = "touch", target = env.player})
			
			if not self.BLUA_PROGRESS_POSITION[env.id] then
				self.BLUA_PROGRESS_POSITION[env.id] = env.position
			end
			
			if env.player.team == Game.TEAM.TR then
				self.ZB_PROGRESS = math.max(env.id, self.ZB_PROGRESS)
			elseif env.player.team == Game.TEAM.CT then
				self.HM_PROGRESS = math.max(env.id, self.HM_PROGRESS)
			end
			
			if self.ZB_PROGRESS > self.HM_PROGRESS + 1 then
				LZE2D.ROUNDEND:ZOMBIE()
			end
		end
	end})
end

LZE2D.ROUNDPROGRESS.TOGGLE = function(self, set)
	if set then
		self.TOGGLE = set
	else
		self.TOGGLE = not self.TOGGLE
	end
end

LZE2D.ROUNDPROGRESS.__DELEGATE__ = {
	Rule_OnPlayerConnect = function(player, self)
		player.user.progress = 1
	end,
	Rule_OnPlayerSpawn = function(player, self)
		LZE2D.__GAMETIMER__:ONCE("ProgressSpawn" .. player.index, 0.1, function()
			if player.user.progress > 1 then
				player.position = self.BLUA_PROGRESS_POSITION[player.user.progress]
				player.position = player.user.progresspoint
			end
		end)
	end,
	Rule_OnRoundStart = function(self)
		self.HM_PROGRESS = 1
		self.ZB_PROGRESS = 1
		
		for i = 1, 20 do
			self.PLAYER_PROGRESS[i] = {
				HM = {},
				ZB = {},
			}
		end
		
		for k, v in pairs(players) do
			if v then
				v.user.progress = 1
				
				self.EB_PROGRESS[1]:Event({action = "touch", target = v})
			end
		end
	end,
	Rule_OnUpdate = function(time, self)
		if self.TOGGLE then
			if not players[self.GETSTPLR] then
				for k, v in pairs(players) do
					if v then
						if v.user.lobby then
							self.GETSTPLR = k
							break
						end
					end
				end
			else
				local target = players[self.GETSTPLR]
				self.EB_PROGRESS[1]:Event({action = "touch", target = target})
				self.EB_PROGRESS[20]:Event({action = "touch", target = target})
				self.EB_PROGRESS[target.user.progress]:Event({action = "touch", target = target})
			end
		end
	end,
	SyncChanged_state = function(new, old, proxy, self)
		if new == 1 then
			self.TOGGLE = true
		end
	end,
}

--------------------------------------------------
--                [[ 回合結束 ]]                --
--------------------------------------------------

LZE2D.ROUNDEND.__INIT__ = function(self)
	self.ENDED = false
	
	self.EB_CLEAR = Des.Game.EntityBlock.Create({x = -191, y = -191, z = 5})
	self.EB_FAILED = Des.Game.EntityBlock.Create({x = -191, y = -190, z = 5})
	
	Des.Game.Blua:ADD(self.BLUA.TriggerRoundEnd, {{"on", "player"}, {"x", "y", "z"}, function(env)
		if not env.player then
			return
		end
		
		local entityblock = Des.Game.EntityBlock.Create({x = env.x, y = env.y, z = env.z})
		if entityblock then
			function entityblock:OnSignal_inpoint(player)
				player.user.inendpoint = Game.GetTime() + 0.2
			end
		end
		
		if env.player.user.inround then
			if env.player.team == Game.TEAM.TR then
				self:ZOMBIE()
			end
		end
	end})
	
	Des.Game.Blua:ADD(self.BLUA.SetHumanWin, {{"on"}, {"x", "y", "z"}, function(env)
		local entityblock = Des.Game.EntityBlock.Create({x = env.x, y = env.y, z = env.z})
		self:HUMAN(entityblock)
	end})
end

LZE2D.ROUNDEND.__DELEGATE__ = {
	Rule_OnRoundStart = function(self)
		self.ENDED = false
	end,
	Rule_OnPlayerConnect = function(player, self)
		player.user.inendpoint = 0
	end,
	Rule_OnUpdate = function(time, self)
		if Des.Sync.state.value == 2 then
			if countplayer[Game.TEAM.TR] == 0 then
				self:HUMAN()
			end
			if countplayer[Game.TEAM.CT] == 0 then
				self:ZOMBIE()
			end
		end
	end,
	SyncChanged_state = function(new, old, proxy, self)
		if new == 3 then
			self:ZOMBIE()
		end
	end
}

LZE2D.ROUNDEND.HUMAN = function(self, entityblock)
	if Des.Sync.state == 0 then
		return
	end
	
	if not wincheck then
		return
	end
	
	if self.ENDED then
		return
	end
	
	scoreboard.now = scoreboard.now + 1
	scoreboard[Game.TEAM.CT] = scoreboard[Game.TEAM.CT] + 1
	
	self.ENDED = true
	Game.Rule:Win(Game.TEAM.CT, scoreboard.now >= scoreboard.max)
	LZE2D.__GAMETIMER__:ONCE("roundend", 0.1, function()
		-- Game.SetTrigger("ROUNDEND.CLEAR", true)
		-- Game.SetTrigger("ROUNDEND.CLEAR", false)
	end)
	
	if entityblock then
		for k, v in pairs(LZE2D.HUMAN:GETPLAYERS()) do
			if v.user.inendpoint <= Game.GetTime() then
				v.health = 1
				v:Kill()
				v.user.alive = false
			end
		end
	end
end

LZE2D.ROUNDEND.ZOMBIE = function(self)
	if Des.Sync.state == 0 then
		return
	end
	
	if not wincheck then
		return
	end
	
	if self.ENDED then
		return
	end
	
	scoreboard.now = scoreboard.now + 1
	scoreboard[Game.TEAM.TR] = scoreboard[Game.TEAM.TR] + 1
	
	self.ENDED = true
	Game.Rule:Win(Game.TEAM.TR, scoreboard.now >= scoreboard.max)
	LZE2D.__GAMETIMER__:ONCE("roundend", 0.1, function()
		-- Game.SetTrigger("ROUNDEND.FAILED", true)
		-- Game.SetTrigger("ROUNDEND.FAILED", false)
	end)
end

--------------------------------------------------
--                [[ 裝填提示 ]]                --
--------------------------------------------------

LZE2D.WEAPONRELOAD.__INIT__ = function(self)
	Des.Sync:ADD(
		  {name = "PlayerWeaponReload", player = true}
		, true
	)
end

LZE2D.WEAPONRELOAD.__DELEGATE__ = {
	Rule_OnDeployWeapon = function(player, weapon, self)
		Des.Sync.PlayerWeaponReload[player.index].value = 0
		
		if not weapon then
			return
		end
	end,
	Rule_OnReload = function(player, weapon, time, self)
		if not weapon then
			return
		end
		
		if time > 0 then
			Des.Sync.PlayerWeaponReload[player.index].value = time
		end
	end,
	Rule_OnReloadFinished = function(player, weapon, self)
		if not weapon then
			return
		end
		
		Des.Sync.PlayerWeaponReload[player.index].value = 0
	end
}

--------------------------------------------------
--                [[ 人類相關 ]]                --
--------------------------------------------------

LZE2D.HUMAN.__INIT__ = function(self)
	Des.Game.Blua:ADD("DimHumanSpawn", {{"on", "position"}, {"x", "y", "z"}, function(env)
		local position = env.x and {x = env.x, y = env.y, z = env.z} or env.position
		table.insert(self.DATA.tSPAWNPOINT, position)
	end})
	
	Des.Game.Blua:ADD("DimHumanHealth", {{"on"}, {"health"}, function(env)
		self.DATA.iHEALTH = env.health or 1000
	end})
	
	Des.Game.Blua:ADD("DimHumanArmor", {{"on"}, {"armor"}, function(env)
		self.DATA.iARMOR = env.armor or 100
	end})
	
	Des.Game.Blua:ADD("DimHumanSpeedRate", {{"on"}, {"speed"}, function(env)
		self.DATA.iSPEED = env.speed or 1
	end})
end

LZE2D.HUMAN.__DELEGATE__ = {
	Rule_OnRoundStart = function(self)
		for k, v in pairs(players) do
			if v then
				if v.user.lobby then
					self:SET(v)
				end
			end
		end
	end,
	Rule_OnPlayerSpawn = function(player, self)
		if Des.Sync.state.value == 1 then
			if player.user.inround then
				if player.team == Game.TEAM.CT then
					player.position = self.DATA.tSPAWNPOINT[math.random(#self.DATA.tSPAWNPOINT)]
				end
			end
		end
	end,
	Rule_OnPlayerSignal = function(player, signal, self)
		if signal == 0 then
			if Des.Sync.state.value == 1 then
				if player.team == Game.TEAM.CT then
					player.position = self.DATA.tSPAWNPOINT[math.random(#self.DATA.tSPAWNPOINT)]
				end
			end
		end
	end
}

LZE2D.HUMAN.SET = function(self, player)
	if not player.user.lobby then
		return
	end
	
	player.team = Game.TEAM.CT
	player.model = Game.MODEL.NORMAL_ZOMBIE
	player.model = Game.MODEL.DEFAULT
	
	player.maxhealth = self.DATA.iHEALTH
	player.health = player.maxhealth
	
	player.maxarmor = self.DATA.iARMOR
	player.armor = player.maxarmor
	
	player.maxspeed = self.DATA.iSPEED
end

LZE2D.HUMAN.GETPLAYERS = function(self)
	local humans = {}
	for k, v in pairs(players) do
		if v then
			if v.user.lobby then
				if v.team == Game.TEAM.CT then
					if v.user.inround then
						table.insert(humans, v)
					end
				end
			end
		end
	end
	return humans
end

--------------------------------------------------
--                [[ 殭屍相關 ]]                --
--------------------------------------------------

LZE2D.ZOMBIE.__INIT__ = function(self)
	self.toggle = true
	
	self.RoundZombies = {}
	self.NewPlayers = {}
	
	self.ZombieHistory = {}
	
	Des.Game.Blua:ADD("DimZombieSpawn", {{"on", "position"}, {"x", "y", "z"}, function(env)
		local position = env.x and {x = env.x, y = env.y, z = env.z} or env.position
		table.insert(self.DATA.tSPAWNPOINT, position)
	end})
	
	Des.Game.Blua:ADD("DimZombieHostHealth", {{"on"}, {"health"}, function(env)
		self.DATA.iHOST_HEALTH = env.health or 5000
	end})
	
	Des.Game.Blua:ADD("DimZombieHostArmor", {{"on"}, {"armor"}, function(env)
		self.DATA.iHOST_ARMOR = env.armor or 100
	end})
	
	Des.Game.Blua:ADD("DimZombieHostSpeedRate", {{"on"}, {"speed"}, function(env)
		self.DATA.iHOST_SPEED = env.speed or 1
	end})
	
	Des.Game.Blua:ADD("DimZombieHostModel", {{"on"}, {"model"}, function(env)
		self.DATA.iHOST_MODEL = Game and Game.MODEL[env.model] or Des.Game.MODEL[env.model]
	end})
	
	Des.Game.Blua:ADD("DimZombieInfectHealth", {{"on"}, {"health"}, function(env)
		self.DATA.iINFECT_HEALTH = env.health or 3000
	end})
	
	Des.Game.Blua:ADD("DimZombieInfectArmor", {{"on"}, {"armor"}, function(env)
		self.DATA.iINFECT_ARMOR = env.armor or 100
	end})
	
	Des.Game.Blua:ADD("DimZombieInfectSpeedRate", {{"on"}, {"speed"}, function(env)
		self.DATA.iINFECT_SPEED = env.speed or 1
	end})
	
	Des.Game.Blua:ADD("DimZombieInfectModel", {{"on"}, {"model"}, function(env)
		self.DATA.iINFECT_MODEL = Game and Game.MODEL[env.model] or Des.Game.MODEL[env.model]
	end})
	
	Des.Game.Blua:ADD("DimZombieFlinch", {{"on"}, {"flinch"}, function(env)
		self.DATA.flFLINCH = env.flinch
		
		for k, v in pairs(self:GETPLAYERS()) do
			v.flinch = env.flinch
		end
	end})
	
	Des.Game.Blua:ADD("DimZombieKnockback", {{"on"}, {"knockback"}, function(env)
		self.DATA.flKNOCKBACK = env.knockback
		
		for k, v in pairs(self:GETPLAYERS()) do
			v.knockback = env.knockback
		end
	end})
	
	Des.Game.Blua:ADD("SetTriggerZombieFlinch", {{"on", "player"}, {"flinch"}, function(env)
		v.flinch = env.flinch
	end})
	
	Des.Game.Blua:ADD("SetTriggerZombieKnockback", {{"on", "player"}, {"knockback"}, function(env)
		v.knockback = env.knockback
	end})
end

LZE2D.ZOMBIE.__DELEGATE__ = {
	Rule_OnRoundStart = function(self)
		if #self.RoundZombies > 0 then
			table.insert(self.ZombieHistory, self.RoundZombies)
			if #self.ZombieHistory > scoreboard.max - 1 then
				table.remove(self.ZombieHistory, 1)
			end
		end
		
		self.RoundZombies = {}
		self.NewPlayers = {}
	end,
	Rule_OnPlayerDisconnect = function(player, self)
		for k, v in pairs(self.RoundZombies) do
			if v == player then
				table.remove(self.RoundZombies, k)
				break
			end
		end
		
		for k, v in pairs(self.NewPlayers) do
			if v == player then
				table.remove(self.NewPlayers, k)
				break
			end
		end
		
		for _, roundList in ipairs(self.ZombieHistory) do
			for k, v in pairs(roundList) do
				if v == player then
					table.remove(roundList, k)
					break
				end
			end
		end
		
		if Des.Sync.state.value == 2 then
			if #LZE2D.HUMAN:GETPLAYERS() <= 0 then
				LZE2D.ROUNDEND:ZOMBIE()
			end
			
			if #LZE2D.ZOMBIE:GETPLAYERS() <= 0 then
				LZE2D.ROUNDEND:HUMAN()
			end
		end
	end,
	Rule_OnPlayerSpawn = function(player, self)
		if Des.Sync.state.value == 1 then
			if player.user.inround then
				if player.team == Game.TEAM.TR then
					player.position = self.DATA.tSPAWNPOINT[math.random(#self.DATA.tSPAWNPOINT)]
				end
			end
		end
	end,
	Rule_OnPlayerSignal = function(player, signal, self)
		if signal == 0 then
			table.insert(self.NewPlayers, player)
		end
	end,
	Rule_OnPlayerAttack = function(victim, attacker, damage, weapontype, hitbox, self)
		if not victim then
			return
		end
		
		if Des.Sync.state.value == 0 then
			damage = 0
		end
		
		if not attacker then
			return damage
		end
		
		if attacker.team == Game.TEAM.TR then
			if attacker.model >= Game.MODEL.NORMAL_ZOMBIE then
				self:SETINFECT(victim)
				if #LZE2D.HUMAN:GETPLAYERS() <= 0 then
					LZE2D.ROUNDEND:ZOMBIE()
				end
				damage = 0
			end
		end
		
		if attacker.team == Game.TEAM.CT then
			if victim.model == self.DATA.iHOST_MODEL then
				damage = 0
			end
		end
		
		return damage
	end,
	SyncChanged_state = function(new, old, proxy, self)
		if new == 2 then
			local respawn = false
			if #self.RoundZombies == 0 then
				self.RoundZombies = LZE2D.ZOMBIE:SELECT()
				respawn = true
			end
			
			for k, v in pairs(self.RoundZombies) do
				self:SETHOST(v)
				if respawn then
					v.position = self.DATA.tSPAWNPOINT[math.random(#self.DATA.tSPAWNPOINT)]
				end
			end
		end
	end,
}

LZE2D.ZOMBIE.SELECT = function(self, newplr)
	if not self.toggle then
		return
	end
	
	if test then
		local selfunc = function()
			for k, v in pairs(self.DATA.tSELECT) do
				local pc = v[1]
				local sc = v[2]
				if countplayer.all < pc then
					return sc
				end
			end
		end
		
		if not newplr then
			local zombies = table.randomselect(players, selfunc(), function(player)
				return player and player.user.lobby and player.user.inround
			end)
			return zombies
		else
			if selfunc() > #self.RoundZombies then
				for i = 1, selfunc() - #self.RoundZombies do
					table.insert(self.RoundZombies, self.NewPlayers[i])
					self.NewPlayers[i].position = LZE2D.ZOMBIE.DATA.tSPAWNPOINT[math.random(#LZE2D.ZOMBIE.DATA.tSPAWNPOINT)]
					self.NewPlayers[i].team = Game.TEAM.TR
					table.remove(self.NewPlayers, 1)
					break
				end
			end
			return self.RoundZombies
		end
		return {}
	else
		local selfunc = function()
			for k, v in pairs(self.DATA.tSELECT) do
				local pc = v[1]
				local sc = v[2]
				if countplayer.all < pc then
					return sc
				end
			end
			return 1
		end
		
		if not newplr then
			local requiredCount = selfunc()
			
			-- 收集所有在線且在場的玩家
			local allEligible = {}
			for _, p in pairs(players) do
				if p and p.user.lobby and p.user.inround then
					table.insert(allEligible, p)
				end
			end
			
			-- 計算每個玩家在近期歷史（5回合內）當過幾次殭屍
			local zombieCounts = {}
			for _, p in ipairs(allEligible) do
				zombieCounts[p] = 0
			end
			
			for _, roundList in ipairs(self.ZombieHistory) do
				for _, zp in ipairs(roundList) do
					if zombieCounts[zp] then
						zombieCounts[zp] = zombieCounts[zp] + 1
					end
				end
			end
			
			-- 將候選人排序：當過次數越少的人排越前面（次數相同則隨機打散）
			local candidates = {}
			for _, p in ipairs(allEligible) do
				table.insert(candidates, {player = p, count = zombieCounts[p], rand = math.random()})
			end
			
			table.sort(candidates, function(a, b)
				if a.count ~= b.count then
					return a.count < b.count
				end
				return a.rand < b.rand
			end)
			
			-- 挑選前 requiredCount 名玩家
			local zombies = {}
			for i = 1, math.min(requiredCount, #candidates) do
				table.insert(zombies, candidates[i].player)
			end
			
			return zombies
		else
			if selfunc() > #self.RoundZombies then
				for i = 1, selfunc() - #self.RoundZombies do
					table.insert(self.RoundZombies, self.NewPlayers[i])
					table.remove(self.NewPlayers, 1)
					break
				end
			end
			return self.RoundZombies
		end
		return {}
	end
end

LZE2D.ZOMBIE.SETHOST = function(self, player)
	if not player.user.lobby then
		return
	end
	
	player.team = Game.TEAM.TR
	player.model = self.DATA.iHOST_MODEL or Game.MODEL.NORMAL_ZOMBIE_HOST
	
	player.maxhealth = self.DATA.iHOST_HEALTH
	player.health = player.maxhealth
	
	player.maxarmor = self.DATA.iHOST_ARMOR
	player.armor = player.maxarmor
	
	player.maxspeed = self.DATA.iHOST_SPEED
	
	player.flinch = self.DATA.flFLINCH
	player.knockback = self.DATA.flKNOCKBACK
end

LZE2D.ZOMBIE.SETINFECT = function(self, player)
	if not player.user.lobby then
		return
	end
	
	player.team = Game.TEAM.TR
	player.model = self.DATA.iINFECT_MODEL or Game.MODEL.NORMAL_ZOMBIE
	
	player.maxhealth = self.DATA.iINFECT_HEALTH
	player.health = player.maxhealth
	
	player.maxarmor = self.DATA.iINFECT_ARMOR
	player.armor = player.maxarmor
	
	player.maxspeed = self.DATA.iINFECT_SPEED
	
	player.flinch = self.DATA.flFLINCH
	player.knockback = self.DATA.flKNOCKBACK
end

LZE2D.ZOMBIE.GETPLAYERS = function(self)
	local zombies = {}
	for k, v in pairs(players) do
		if v then
			if v.user.lobby then
				if v.team == Game.TEAM.TR then
					if v.user.inround then
						table.insert(zombies, v)
					end
				end
			end
		end
	end
	return zombies
end

--------------------------------------------------
--                [[ 觀戰相關 ]]                --
--------------------------------------------------

LZE2D.SPECTATOR.__INIT__ = function(self)
	Des.Sync:ADD(
		  {name = "PlayerSpectator", player = true}
		, true
	)
	
	Des.Game.Blua:ADD("DimSpectatorSpawn", {{"on", "position"}, {"x", "y", "z"}, function(env)
		local position = env.x and {x = env.x, y = env.y, z = env.z} or env.position
		self.DATA.tSPAWNPOINT = position
	end})
end

LZE2D.SPECTATOR.__DELEGATE__ = {
	Rule_OnPlayerSpawn = function(player, self)
		if player.user.lobby then
			if not player.user.inround then
				if Des.Sync.state.value > 1 then
					if self.DATA.bCUSTOM then
						player.position = self.DATA.tSPAWNPOINT
						player.maxspeed = 1.56
						player:RemoveWeapon()
						
						Des.Sync.PlayerSpectator[player.index].value = 1
					else
						player.health = 1
						player:Kill()
						player.user.alive = false
					end
				end
			else
				Des.Sync.PlayerSpectator[player.index].value = 0
			end
		else
			
		end
	end,
}

--------------------------------------------------
--                [[ 區域標題 ]]                --
--------------------------------------------------

LZE2D.ZONETITLE.__INIT__ = function(self)
	Des.Sync:ADD(
		  {name = "ShowZoneTitle"}
		, true
	)
	
	Des.Game.Blua:ADD(self.BLUA.ShowZoneTitle, {{"on"}, {"id"}, function(env)
		Des.Sync.ShowZoneTitle.value = env.id
	end})
end

LZE2D.ZONETITLE.__DELEGATE__ = {
	
}

--------------------------------------------------
--                [[ 自訂執行 ]]                --
--------------------------------------------------

LZE2D.CUSEXEC.__INIT__ = function(self)
	for id, tbl in pairs(self) do
        if type(tbl) == "table" and type(id) == "number" then
			tbl.__ADD_DELEGATE__ = function(self)
				for dname, dfunc in pairs(tbl.__DELEGATE__ or {}) do
					f_adddelegate(dname, string.format("LZE2D.CUSEXEC[%d]#%s", id, dname), dfunc, {tbl})
				end
			end
			
			tbl.__REMOVE_DELEGATE__ = function(self)
				for dname, dfunc in pairs(tbl.__DELEGATE__ or {}) do
					f_remdelegate(dname, string.format("LZE2D.CUSEXEC[%d]#%s", id, dname))
				end
			end
			
            if tbl.__INIT__ then
                tbl:__INIT__()
            end
        end
    end
	
	Des.Game.Blua:ADD("LZE2D.CUSEXEC", {{"on"}, {"id", "off"}, function(env)
		local tbl = self[env.id]
		if not tbl then
			return
		end
		
		if tbl.__RUN__ then
			tbl:__RUN__()
		end
		
		if env.off == 0 then
			if tbl.__OFF__ then
				tbl:__OFF__()
			end
			if tbl.__REMOVE_DELEGATE__ then
				tbl:__REMOVE_DELEGATE__()
			end
		else
			for dname, dfunc in pairs(tbl.__DELEGATE__ or {}) do
				local name = string.format("LZE2D.CUSEXEC[%d]#%s", env.id, dname)
				if not f_checkdelegate(dname, name) then
					f_adddelegate(dname, name, dfunc, {tbl})
				end
			end
		end
		
		if not tbl.__REMOVE_DELEGATE__ then
			tbl.__REMOVE_DELEGATE__ = function(self)
				for dname, dfunc in pairs(tbl.__DELEGATE__ or {}) do
					f_remdelegate(dname, string.format("LZE2D.CUSEXEC[%d]#%s", env.id, dname))
				end
			end
		end
	end})
end

LZE2D.CUSEXEC.__DELEGATE__ = {
	
}

--==============================================--
--                [[ 加載資料 ]]                --
--==============================================--

language.use = __DESYSTEM__.sLANGUAGE

language.wait.map[language.use] = string.format("．%s．", __DESYSTEM__.tWAIT.sMAPNAME)

for k, v in pairs(__DESYSTEM__.tWAIT.tPLAYDESC) do
	table.insert(language.wait.playdesc[language.use], {text = v})
end
for k, v in pairs(__DESYSTEM__.tWAIT.tUPDATEDESC) do
	table.insert(language.wait.updatedesc[language.use], {text = v})
end

LZE2D.__LOADQUENE__ = {}
LZE2D.__INITLOADED__ = {}

LZE2D.__LOADSORT__ = {
	"SYSTEM",
	"HUMAN",
	"ZOMBIE",
	"SPECTATOR",
	"ROUNDPROGRESS",
}

LZE2D.LOAD = function(self, tbl, name)
    if not tbl or type(tbl) ~= "table" or self.__INITLOADED__[name] then return end
    
    self.__INITLOADED__[name] = true
    
    if tbl.__INIT__ and name ~= "self" then 
        tbl:__INIT__(tbl) 
    end
    
    for dname, dfunc in pairs(tbl.__DELEGATE__ or {}) do
        f_adddelegate(dname, string.format("LZE2D.%s#%s", name, dname), dfunc, {tbl})
    end
    
    table.insert(self.__LOADQUENE__, name)
    
    print("<ffffaa>", (Des.Sys == Game and "Game" or "UI"), " basic loaded: ", name)
end

LZE2D.LOADUPDATE = function(self, time)
    if #self.__LOADQUENE__ == 0 then return end
	
    local name = table.remove(self.__LOADQUENE__, 1)
    local target = self[name]
    
    if name == "self" then target = self end

    if target then
        for _, data in pairs(target.KEYBIND or {}) do
            if type(data) == "table" then Des.Keybind:ADD(data) end
        end
        for _, data in pairs(target.COMMAND or {}) do
            if type(data) == "table" then Des.Commands:ADD(data) end
        end
        print("<ffffaa>", (Des.Sys == Game and "Game" or "UI"), " res bound: ", name)
    end
end

LZE2D.__INIT__ = function(self)
    self.__GAMETIMER__ = DESYSTEM.SCHEDULE.CREATE()
    
    for _, key in ipairs(self.__LOADSORT__) do
        self:LOAD(self[key], key)
    end
    
    self:LOAD(self, "self")
    
    for k, v in pairs(self) do
        if type(v) == "table" and not k:find("^__") 
           and k ~= "DATA" and k ~= "SCHEDULE" then
            self:LOAD(v, k)
        end
    end
	
	--
	
	Des.Game.Blua:ADD(self.BLUA.CAMERA, {{"on"}, {"x", "y", "z"}, function(env)
		local camera = Des.Game.EntityBlock.Create({x = env.x, y = env.y, z = env.z})
		if camera then
			Game.Rule:Respawn()
			for k, v in pairs(players) do
				if v then
					for i = 1, 3 do
						v:Respawn()
						camera:Event({action = "reset", target = v})
						camera:Event({action = "signal", target = v})
					end
				end
			end
		end
	end})
	
	Des.Game.Blua:ADD(self.BLUA.ENTITYTRIGGER, {{"on", "player"}, {"x", "y", "z"}, function(env)
		local entityblock = Des.Game.EntityBlock.Create({x = env.x, y = env.y, z = env.z})
		if entityblock then
			entityblock:Event({action = "use", target = env.player})
			entityblock:Event({action = "touch", target = env.player})
			entityblock:Event({action = "signal", target = env.player})
		end
	end})
	
	Des.Game.Blua:ADD(self.BLUA.ENTITYRESET, {{"on"}, {"x", "y", "z"}, function(env)
		if env.y then
			local entityblock = Des.Game.EntityBlock.Create({x = env.x, y = env.y, z = env.z})
			if entityblock then
				entityblock:Event({action = "reset", target = env.player})
			end
		else
			Game.SetTrigger(env.x, false)
		end
	end})
	
	--
	
	Common.SetBuymenuWeaponList(__DESYSTEM__.tWEAPON.tBUYMENU_LIST)
	
	for weaponid, data in pairs(__DESYSTEM__.tWEAPON.tOPTION) do
		if weaponid == 0 then
			for i = 1, 5000 do
				local option = Common.GetWeaponOption(i)
				if option then
					for k, v in pairs(__DESYSTEM__.tWEAPON.tOPTION[0]) do
						if type(option[k]) == "function" then
							option[k](option, v)
						else
							option[k] = v
						end
					end
				end
			end
		end
		
		local option = Common.GetWeaponOption(weaponid)
		if option then
			for k, v in pairs(data) do
				if option[k] then
					if type(option[k]) == "function" then
						option[k](option, v)
					else
						option[k] = v
					end
				end
			end
		end
	end
	
	if Des.Sys == Game then
		Game.Rule.breakable		= self.DATA.bBREAKABLE
		Game.Rule.enemyfire		= true
		Game.Rule.friendlyfire	= false
		Game.Rule.respawnable	= false
		Game.Rule.respawnTime	= 0
	end
end

LZE2D.__DELEGATE__ = {
	-- SYS
	Rule_OnUpdate = function(time, self)
		self:LOADUPDATE(time)
		
		if not self.__LAST_TIME__ then
			self.__LAST_TIME__ = time
		end
		local dt = time - self.__LAST_TIME__
		self.__LAST_TIME__ = time
		
		self.__GAMETIMER__:_UPDATE(dt)
	end,
	Event_OnUpdate = function(time, self)
		self:LOADUPDATE(time)
		
		if not self.__LAST_TIME__ then
			self.__LAST_TIME__ = time
		end
		local dt = time - self.__LAST_TIME__
		self.__LAST_TIME__ = time
		
		self.__GAMETIMER__:_UPDATE(dt)
	end,
}

LZE2D.GetNearPlayer = function(self, player, range)
	local range = range or 10
	
	local mindist = 100
	local minplr = nil
	
	for k, v in pairs(players) do
		if v then
			if player ~= v then
				if v.user.respawn == 0 then
					local dist = DESYSTEM.DISTANCE(player.position, v.position)
					if dist <= range then
						if mindist > dist then
							mindist = dist
							minplr = v
						end
					end
				end
			end
		end
	end
	
	return minplr
end

LZE2D:__INIT__()

--------------------------------------------------