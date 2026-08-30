--UI.FACE=======================================--
--                [[ 製作名單 ]]                --
--==============================================--
--[[

地圖製作：

程式設計：DestroyerI滅世I ( Czack )

-- ==============================================================================

-- Project: Czack Framework 26s3.1 (Lua Zombie Escape 2D / LZE2D)
-- Module:  ui.face.lua
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

print(string.format("[%s]ui.face.lua is loaded.", Des.Mapsys))
log(string.format("[%s]ui.face.lua is loaded.", Des.Mapsys))

--==============================================--
--                [[ 變數宣告 ]]                --
--==============================================--

fps        = 0
joined     = 0

player     = {}
players    = {}

msgreg         = {}
ui_Reset       = {}
ui_Loading     = {}
ui_Removing    = {}
ui_RemoveQueue = {}

countplayer = {
	
}

s = {
	  w = UI.ScreenSize().width
	, h = UI.ScreenSize().height
}

prelobby = {
	  state    = 0
	, delay    = 0
	, bool     = false
	, complete = false
}

deltaTime = {
	  last  = UI.GetTime()
	, delta = 0
}

customupdate = {
	  ["0.03"] = 0
	, ["0.1"]  = 0
	, ["1"]    = 0
}

message = {
	  time     = 0
	, delay    = 0
	, bad      = 0
	, harass   = 0
	, badwords = {
		
	}
	, radio    = {
		  "掩護我!"
		, "你守住這個據點."
		, "守住這邊."
		, "重整隊形."
		, "跟隨我."
		, "我中彈了...需要援助!"
		
		, "衝衝衝!"
		, "後退!"
		, "團體行動!"
		, "就定位等我."
		, "全力攻擊!"
		, "小隊回報狀況."
		
		, "了解."
		, "收到."
		, "發現敵人."
		, "需要後援."
		, "這個區域安全了."
		, "我就定位了"
		, "回報沒有問題."
		, "離開那邊, 快爆炸了!"
		, "無法執行"
		, "敵人死了."
		
		, "炸死他們!"
	}
}
for k, v in pairs(message.radio) do
	message.radio[v] = true
end

--==============================================--
--                [[ 介面設計 ]]                --
--==============================================--

--------------------------------------------------
-- [[                地圖版本                ]] --
--------------------------------------------------

function Des.UI.PreLoad.version()
	local difflv = {
		  "簡單"
		, "普通"
		, "困難"
		, "極限"
		, "地獄"
	}
	
	version = {
		  phase = Des.Version.phase
		, phasecht = Des.Version.phasecht[Des.Version.phase]
		, number = Des.Version.number
		, box = {}
		, txt = {}
		
		, DELEGATE = {
			Sync_difficulty = function(sync, self)
				if Des.UI.Loaded.version then
					version.txt[1]:Set({text = version.txt[1]:Get().text .. string.format(" ( %s )", difflv[sync.value])})
				end
			end
		}
	}

	version.txt[1] = Des.UI.Frame.Text:Create()
	version.txt[1]:Set({text = string.format(string.rebyte("7c20e78988e69cacefbc9a2573efbc9be7a88be5bc8fe8a8ade8a888efbc9a44657374726f79657249e6bb85e4b89649202820437a61636b2029efbc9be58e9fe5a78be7a2bce6909ce7af84e69cacefbc9a4c5a453244"), LZE2D.DATA.iVERSION), font = "small", align = "left", x = 55, y = -17 - 12.5, width = s.w, height = 100, border = 1, color = {r = 150, g = 150, b = 150, a = 125}, frameColor = {r = 0, g = 0, b = 0, a = 125}})
	
	if Des.Sync.difficulty and Des.Sync.difficulty.value then
		if not string.find(version.txt[1]:Get().text, difflv[Des.Sync.difficulty.value]) then
			version.txt[1]:Set({text = version.txt[1]:Get().text .. string.format(" ( %s )", difflv[Des.Sync.difficulty.value])})
		end
	end
	
	if not __DESYSTEM__.tVERSION.bTEXT then
		version.txt[1]:Hide()
	end
	
log([[

＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃

　　＃＃＃　　＃＃＃＃＃　　＃＃＃　　　＃＃＃　　＃　　　＃　
　＃　　　＃　　　　　＃　＃　　　＃　＃　　　＃　＃　　＃　　
　＃　　　　　　　　＃　　＃　　　＃　＃　　　　　＃　＃　　　
　＃　　　　　　　＃　　　＃　　　＃　＃　　　　　＃＃　　　　
　＃　　　　　　＃　　　　＃＃＃＃＃　＃　　　　　＃　＃　　　
　＃　　　＃　＃　　　　　＃　　　＃　＃　　　＃　＃　　＃　　
　　＃＃＃　　＃＃＃＃＃　＃　　　＃　　＃＃＃　　＃　　　＃　

＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃

]])

end

--------------------------------------------------
-- [[                開發模式                ]] --
--------------------------------------------------

function Des.UI.Load.developer()
	developer = {
		  fps = 0
		
		, SETUP = {
			  {UIC = "Frame.Text", ARGS = {text = string.format("# DEV/m ( %s )", f_getlanguage(language.devmode.opened)), font = "small", align = "left", x = 5, y = 0 - 12.5, width = s.w, height = 100, border = 1, color = {r = 255, g = 255, b = 255, a = 75}, frameColor = {r = 0, g = 0, b = 0, a = 50}}}
			, {UIN = "detail", UIC = "Frame.Text", ARGS = {text = "# detail", font = "small", align = "left", x = 5, y = 20 - 12.5, width = s.w, height = 100, border = 1, color = {r = 255, g = 255, b = 255, a = 75}, frameColor = {r = 0, g = 0, b = 0, a = 50}}}
		}
		
		, __INIT__ = function(self)
			if not __DESYSTEM__.tDEVELOPERMODE.bTEXT then
				for k, v in pairs(self:Getobjs()) do
					v:Hide()
				end
			end
		end
		
		, DELEGATE = {
			  Event_OnUpdate = function(time, self)
				self.ui.detail:Set({text = string.format("# fps ( %s ) - %3.0f ; box ( %s ) - %4d ; text ( %s ) - %4d", f_getlanguage(language.devmode.detail.fps), math.round(math.abs(1 / (time - self.fps))), f_getlanguage(language.devmode.detail.box), #Des.UI.Max1024.Using.Box, f_getlanguage(language.devmode.detail.text), #Des.UI.Max1024.Using.Text)})
				self.fps = time
			end
		}
	}
end

--------------------------------------------------
-- [[                重整介面                ]] --
--------------------------------------------------

function Des.UI.Load.reui()
	reui = {
		txt = {}
	}
	for i = 1, 4 do
		reui.txt[i] = Des.UI.Text.Create()
	end
	reui.txt[3]:Set({text = f_getlanguage(language.system.reui.title), font = "large", align = "center", x = 0, y = s.h / 2 - 75, width = s.w, height = 100, r = 255, g = 255, b = 255, a = 255})
	reui.txt[4]:Set({text = "", font = "medium", align = "center", x = 0, y = s.h / 2 - 25, width = s.w, height = 100, r = 255, g = 255, b = 255, a = 255})
	reui.txt[1]:Set({text = ""})
	reui.txt[2]:Set({text = ""})
	for i = 1, s.h // 90 do
		reui.txt[1]:Set({text = reui.txt[1]:Get().text .. string.rep("█", s.w // 64) .. "\n", font = "verylarge", align = "left", x = 0, y = -s.h / 2, width = s.w * 2, height = s.h * 2, r = 30, g = 30, b = 30, a = 255})
		reui.txt[2]:Set({text = reui.txt[1]:Get().text .. string.rep("█", s.w // 64) .. "\n", font = "verylarge", align = "left", x = 0, y = -s.h / 2 + 50, width = s.w * 2, height = s.h * 2, r = 30, g = 30, b = 30, a = 255})
	end
end

--------------------------------------------------
-- [[                開頭背景                ]] --
--------------------------------------------------

function Des.UI.Load.stbg()
	stbg = {
		  box   = {}
		, txt   = {}
		, back  = {
			  level = 0
			, lbool = false
			, box   = {}
		}
		, skip = {
			  time = 0
			, maxtime = 1.5
			, tiptime = true
			, box = {}
			, txt = {}
		}
		, DELEGATE = {
			  Event_OnKeyDown = function(inputs)
				--[[
				if inputs[UI.KEY.SPACE] then
					if prelobby.bool then
						stbg.skip.time = UI.GetTime()
						stbg.skip.tiptime = false
					end
				end
				]]
			end
			, Event_OnKeyUp = function(inputs)
				if inputs[UI.KEY.SPACE] then
					stbg.skip.time = 0
					stbg.skip.txt[1]:Set({a = 0})
					for i = 1, 150 do
						stbg.skip.box[i]:Set({a = 0})
					end
				end
			end
			, Event_OnUpdate = function(time, self)
				if prelobby.reset then
					prelobby.state = 5
				end
				
				if stbg.skip.time ~= 0 then
					local presstime = time - stbg.skip.time
					stbg.skip.txt[1]:Set({a = math.clamp(presstime * 255 / stbg.skip.maxtime, 0, 255)})
					for i = 1, math.clamp(math.round(presstime * 150 / stbg.skip.maxtime), 0, 150) do
						stbg.skip.box[i]:Set({a = i})
					end
					for i = math.clamp(math.round(presstime * 150 / stbg.skip.maxtime) + 1, 0, 150), 150 do
						stbg.skip.box[i]:Set({a = 0})
					end
					
					if presstime >= stbg.skip.maxtime then
						prelobby.state = 5
						prelobby.delay = 0
						prelobby.bool = true
						
						Des.UI.Remove("deslogo")
						
						for _, i in pairs(stbg.skip) do
							if type(i) == "table" then
								for k, v in pairs(i) do
									v:Set({r = 250, g = 250, b = 100})
								end
							end
						end
					end
				end
				
				if not stbg.skip.tiptime then
					if stbg.skip.txt[2]:Get().a > 0 then
						f_ui_gradient({ui = stbg.skip.txt[2], arg = "a", add = -5, into = 0})
					end
				end
				
				if prelobby.bool then
					if prelobby.delay < time then
						prelobby.state = prelobby.state + 1
						if prelobby.state == 1 then
							prelobby.delay = time + 3
							stbg.back.lbool = true
							stbg.back.level = #stbg.back.box
						elseif prelobby.state == 2 then
							stbg.bool = true
							prelobby.delay = time + 1.5
							stbg.box[1]:Set({a = 255})
							
							table.insert(ui_Loading, {
								sys = "deslogo"
							})
						elseif prelobby.state == 3 then
							deslogo.time = time
							prelobby.delay = time + 6
						elseif prelobby.state == 4 then
							prelobby.delay = time + 2
						elseif prelobby.state == 5 then
							prelobby.delay = time + 2
							stbg.back.lbool = false
							stbg.back.level = 1
							table.insert(ui_Removing, "deslogo")
						elseif prelobby.state == 6 then
							prelobby.delay = time + 1
							prelobby.bool = false
							table.insert(ui_Removing, "stbg")
							prelobby.complete = true
						end
					end
				end
				
				if prelobby.state == 1 then
					f_ui_gradient({ui = stbg.box[1], arg = "a", add = 2.5, into = 255})
					for level, i in pairs(stbg.back.box) do
						if tonumber(level) then
							for count, j in pairs(i) do
								f_ui_gradient({ui = j, arg = {"r", "g", "b"}, add = -5, into = 5})
								if level >= stbg.back.level then
									f_ui_gradient({ui = j, arg = "a", add = 15, into = 255})
								end
							end
						end
					end
				elseif prelobby.state == 2 then
					for level, i in pairs(stbg.back.box) do
						if tonumber(level) then
							for count, j in pairs(i) do
								f_ui_gradient({ui = j, arg = {"r", "g", "b"}, add = 1, into = 25 - level})
							end
						end
					end
				elseif prelobby.state == 3 then
					-- CZACK 淡入
					local obj = deslogo.pixel:Object()
					for k, v in pairs(obj.UI) do
						f_ui_gradient({ui = v.main, arg = "a", add = 5, into = 255})
						f_ui_gradient({ui = v.shadow, arg = "a", add = 5, into = 255})
					end
					-- DESTROYER 淡入
					if deslogo.pixel_sub then
						local sub_obj = deslogo.pixel_sub:Object()
						for k, v in pairs(sub_obj.UI) do
							f_ui_gradient({ui = v.main, arg = "a", add = 5, into = 255})
							f_ui_gradient({ui = v.shadow, arg = "a", add = 5, into = 255})
						end
					end
					-- 橫線與底部文字淡入
					if deslogo.line then f_ui_gradient({ui = deslogo.line, arg = "a", add = 5, into = 255}) end
					if deslogo.line_shadow then f_ui_gradient({ui = deslogo.line_shadow, arg = "a", add = 5, into = 255}) end
					if deslogo.txt_footer then f_ui_gradient({ui = deslogo.txt_footer, arg = {"color.a", "tocolor.a"}, add = 5, into = 255}) end
					if deslogo.txt_footer_frame then f_ui_gradient({ui = deslogo.txt_footer_frame, arg = {"color.a", "frameColor.a"}, add = 5, into = 255}) end
				elseif prelobby.state == 4 then
					-- CZACK 淡出
					local obj = deslogo.pixel:Object()
					for k, v in pairs(obj.UI) do
						f_ui_gradient({ui = v.main, arg = "a", add = -5, into = 0})
						f_ui_gradient({ui = v.shadow, arg = "a", add = -5, into = 0})
					end
					-- DESTROYER 淡出
					if deslogo.pixel_sub then
						local sub_obj = deslogo.pixel_sub:Object()
						for k, v in pairs(sub_obj.UI) do
							f_ui_gradient({ui = v.main, arg = "a", add = -5, into = 0})
							f_ui_gradient({ui = v.shadow, arg = "a", add = -5, into = 0})
						end
					end
					-- 橫線與底部文字淡出
					if deslogo.line then f_ui_gradient({ui = deslogo.line, arg = "a", add = -5, into = 0}) end
					if deslogo.line_shadow then f_ui_gradient({ui = deslogo.line_shadow, arg = "a", add = -5, into = 0}) end
					if deslogo.txt_footer then f_ui_gradient({ui = deslogo.txt_footer, arg = {"color.a", "tocolor.a"}, add = -5, into = 0}) end
					if deslogo.txt_footer_frame then f_ui_gradient({ui = deslogo.txt_footer_frame, arg = {"color.a", "frameColor.a"}, add = -5, into = 0}) end
				elseif prelobby.state == 5 then
					f_ui_gradient({ui = stbg.box[1], arg = "a", add = -1, into = 0})
					for level, i in pairs(stbg.back.box) do
						if tonumber(level) then
							for count, j in pairs(i) do
								f_ui_gradient({ui = j, arg = {"r", "g", "b"}, add = -5, into = 5})
								if level < stbg.back.level then
									f_ui_gradient({ui = j, arg = "a", add = -5, into = 0})
								end
							end
						end
					end
				end
				
				if stbg then
					if customupdate["0.03"] < time then
						if stbg.back.lbool then
							if stbg.back.level > 0 then
								if stbg.back.box[stbg.back.level] then
									for k, v in pairs(stbg.back.box[stbg.back.level]) do
										v:Set({r = 255, g = 255, b = 255})
									end
									stbg.back.level = stbg.back.level - 1
								end
							end
						else
							if stbg.back.level < #stbg.back.box then
								if stbg.back.box[stbg.back.level] then
									for k, v in pairs(stbg.back.box[stbg.back.level]) do
										v:Set({r = 255, g = 255, b = 255})
									end
									stbg.back.level = stbg.back.level + 1
								end
							end
						end
					end
				end
			end
		}
	}
	
	stbg.box[1] = Des.UI.Box.Create()
	stbg.box[1]:Set({x = 0, y = -50, width = s.w, height = s.h + 100, r = 5, g = 5, b = 5, a = 0})
	
	local max_boxes = 400
	local gap = 8
	local box_size = math.max((s.w) // math.sqrt(max_boxes)) - gap
	
	local cx, cy = s.w // 2, s.h // 2
	
	local dirs = { {1, 0}, {0, 1}, {-1, 0}, {0, -1} }
	
	local level = 1
	stbg.back.box[level] = {}
	stbg.back.box[level][1] = Des.UI.Box.Create()
	stbg.back.box[level][1]:Set({ x = cx - box_size // 2, y = cy - box_size // 2 + gap * 2, width = box_size, height = box_size, r = 5, g = 5, b = 5, a = 0 })

	local count = 1
	local x, y = 0, 0
	local step = 1
	local dir_index = 1

	while count < max_boxes do
		level = level + 1
		stbg.back.box[level] = {}
		
		for _ = 1, 2 do
			for _ = 1, step do
				if count >= max_boxes then break end
				x = x + dirs[dir_index][1]
				y = y + dirs[dir_index][2]
				count = count + 1
				
				local adjusted_y = cy + y * (box_size + gap) - box_size // 2
				if x % 2 == 0 then
					adjusted_y = adjusted_y + gap * 2
				else
					adjusted_y = adjusted_y - gap * 2
				end
				
				stbg.back.box[level][count] = Des.UI.Box.Create()
				stbg.back.box[level][count]:Set({
					x = cx + x * (box_size + gap) - box_size // 2,
					y = adjusted_y,
					width = box_size,
					height = box_size,
					r = 5,
					g = 5,
					b = 5,
					a = 0
				})
			end
			dir_index = dir_index % 4 + 1
		end
		step = step + 1
	end
	
	local radius = 30
	local centerX, centerY = s.w - 100, s.h - 100
	local points = {}
	local steps = 150

	for i = 0, steps - 1 do
		local angle = (2 * math.pi / steps) * i - math.pi / 2
		local x = centerX + radius * math.cos(angle)
		local y = centerY + radius * math.sin(angle)
		points[#points + 1] = {x = x, y = y}
	end
	
	for i, p in ipairs(points) do
		stbg.skip.box[i] = Des.UI.Box.Create()
		stbg.skip.box[i]:Set({x = p.x, y = p.y, width = 5, height = 5, r = 255, g = 255, b = 255, a = 0})
	end
	
	stbg.skip.txt[1] = Des.UI.Text.Create()
	stbg.skip.txt[1]:Set({text = "＞", font = "medium", align = "center", x = s.w - 145, y = s.h - 114 + 12, width = 100, height = 33, r = 255, g = 255, b = 255, a = 0})
	
	stbg.skip.txt[2] = Des.UI.Text.Create()
	stbg.skip.txt[2]:Set({text = "公開範本不允許跳過", font = "small", align = "right", x = 0, y = s.h - 40 + 12, width = s.w - 28, height = 33, r = 255, g = 100, b = 100, a = 100})
end

--------------------------------------------------
-- [[                滅世開頭                ]] --
--------------------------------------------------

function Des.UI.Load.deslogo()
	deslogo = {
		  index = 0
		, time = 0
		, DELEGATE = {
			Event_OnUpdate = function(time, self)
				-- 1. 取得主字體 (CZACK) 的物件
				local obj = self.pixel:Object()

				-- 調整參數
				local wave_speed  = 2    -- 控制波紋移動的速度 (越大越快)
				local wave_length = 0.02 -- 控制波紋的間距/寬度 (越小越寬，反之越窄)

				-- === 自定義顏色設定 (目前為：賽博龐克霓虹) ===
				local R_DARK =   10
				local G_DARK =    5
				local B_DARK =   40

				local R_LIGHT =  50
				local G_LIGHT = 180
				local B_LIGHT = 230
				-- ========================

				local current_phase = (time - self.time) * wave_speed

				-- 處理主字體 CZACK 的波紋動畫
				for k, v in pairs(obj.UI) do
					local position_on_wave = k * wave_length
					local input_angle = position_on_wave - current_phase
					local sin_value = math.sin(input_angle)
					local t = (sin_value + 1) / 2 

					local R = math.floor(R_DARK * (1 - t) + R_LIGHT * t)
					local G = math.floor(G_DARK * (1 - t) + G_LIGHT * t)
					local B = math.floor(B_DARK * (1 - t) + B_LIGHT * t)
					
					v.main:Set({r = R, g = G, b = B})
					
					local shadow_factor = 0.15 + (t * 0.1)
					local sR = math.floor(R * shadow_factor)
					local sG = math.floor(G * shadow_factor)
					local sB = math.floor(B * shadow_factor)
					
					v.shadow:Set({r = sR, g = sG, b = sB})
				end

				-- 處理新增的副字體 (DESTROYER) 的波紋動畫 (與主字體同步)
				if self.pixel_sub then
					local sub_obj = self.pixel_sub:Object()
					for k, v in pairs(sub_obj.UI) do
						local position_on_wave = (k + 10) * wave_length -- 稍微偏移讓波紋有延續感
						local input_angle = position_on_wave - current_phase
						local sin_value = math.sin(input_angle)
						local t = (sin_value + 1) / 2 

						local R = math.floor(R_DARK * (1 - t) + R_LIGHT * t)
						local G = math.floor(G_DARK * (1 - t) + G_LIGHT * t)
						local B = math.floor(B_DARK * (1 - t) + B_LIGHT * t)
						
						v.main:Set({r = R, g = G, b = B})
						
						local shadow_factor = 0.15 + (t * 0.1)
						v.shadow:Set({r = math.floor(R * shadow_factor), g = math.floor(G * shadow_factor), b = math.floor(B * shadow_factor)})
					end
				end

				-- 處理橫線的波紋動畫
				if self.line then
					local line_angle = -current_phase
					local sin_value = math.sin(line_angle)
					local t = (sin_value + 1) / 2 
					local R = math.floor(R_DARK * (1 - t) + R_LIGHT * t)
					local G = math.floor(G_DARK * (1 - t) + G_LIGHT * t)
					local B = math.floor(B_DARK * (1 - t) + B_LIGHT * t)
					self.line:Set({r = R, g = G, b = B})
					
					local shadow_factor = 0.15 + (t * 0.1)
					if self.line_shadow then
						self.line_shadow:Set({r = math.floor(R * shadow_factor), g = math.floor(G * shadow_factor), b = math.floor(B * shadow_factor)})
					end
				end
			end
		}
	}
	
	-- 計算基準 X, Y (將 Y 整體往上移動，從原本的 -35 改為 -90)
	local base_x = s.w / 2
	local base_y = s.h / 2 - 90 * 1.2

	--------------------------------------------------
	-- 1. 主標題 "CZACK"
	--------------------------------------------------
	local text_main = string.rebyte("435a41434b")
	local main_w = (string.len(text_main) * 30 - 5) * 1.2
	
	deslogo.pixel = Des.UI.Pixel.Text:Create()
	deslogo.pixel:Set({
		text = text_main, 
		x = base_x - main_w, 
		y = base_y, 
		width = 12, height = 12, 
		r = 255, g = 255, b = 255, a = 0, 
		shadow = {r = 0, g = 0, b = 0, offset = {x = 5, y = 5}, bool = true}, 
		ignore = {"r", "g", "b"}
	})

	--------------------------------------------------
	-- 2. 新增：CZACK 下方的裝飾橫線
	--------------------------------------------------
	local line_y = base_y + 100
	
	-- 建立線條陰影
	deslogo.line_shadow = Des.UI.Box.Create()
	deslogo.line_shadow:Set({ x = base_x - main_w + 5 - 25, y = line_y + 5, width = main_w * 2 + 50, height = 4, r = 0, g = 0, b = 0, a = 0 })
	
	-- 建立線條主體
	deslogo.line = Des.UI.Box.Create()
	deslogo.line:Set({ x = base_x - main_w - 12, y = line_y, width = main_w * 2 + 25, height = 4, r = 255, g = 255, b = 255, a = 0 })

	--------------------------------------------------
	-- 3. 橫線底下的 "DESTROYER"
	--------------------------------------------------
	local text_sub = string.rebyte("44455354524f594552")
	local sub_w = (string.len(text_sub) * 30 - 5) * 0.5
	
	deslogo.pixel_sub = Des.UI.Pixel.Text:Create()
	deslogo.pixel_sub:Set({
		text = text_sub, 
		x = base_x - sub_w, 
		y = line_y + 20, -- 位於橫線下方 20 像素
		width = 5, height = 5, -- *1.0 的像素大小通常為 10
		r = 255, g = 255, b = 255, a = 0, 
		shadow = {r = 0, g = 0, b = 0, offset = {x = 4, y = 4}, bool = true}, 
		ignore = {"r", "g", "b"}
	})
	
	--------------------------------------------------
	-- 4. 底部的文字
	--------------------------------------------------
	local text_other = "原始碼與範本請搜尋 LZE2D"
	
	deslogo.txt_footer_frame = Des.UI.Frame.Text:Create()
	deslogo.txt_footer_frame:Set({
		text = text_other, 
		font = "medium", 
		align = "center", 
		x = base_x - s.w / 2, 
		y = line_y + 80,
		width = s.w,
		height = 33,
		border = 2,
		color = {r = 0, g = 0, b = 0, a = 0},
		frameColor = {r = 0, g = 0, b = 0, a = 0}
	})
	
	deslogo.txt_footer = Des.UI.Gradient.Text:Create()
	deslogo.txt_footer:Set({
		text = text_other, 
		font = "medium", 
		align = "center", 
		x = base_x - s.w / 2, 
		y = line_y + 80,
		fine = 15,
		width = s.w,
		color = {r = 50, g = 20, b = 0, a = 0},
		tocolor = {r = 200, g = 150, b = 0, a = 0}
	})
end

--------------------------------------------------
-- [[                黑色底邊                ]] --
--------------------------------------------------

function Des.UI.PreLoad.black()
	black = {
		edges = {}
	}

	-- black.edges[1] = Des.UI.Box.Create()
	-- black.edges[1]:Set({x = 0, y = s.h - 39, width = s.w, height = 100, r = 0, g = 0, b = 0, a = 255})
	-- black.edges[2] = Des.UI.Text.Create()
	-- black.edges[2]:Set({text = '██████████', font = "large", align = 'center', x = -250, y = s.h - 250, width = s.w + 500, height = 500, r =   0, g =   0, b =   0, a = 255})
	-- black.edges[3] = Des.UI.Text.Create()
	-- black.edges[3]:Set({text = '███████████████████████████████████████████████████████████████████', font = "large", align = 'center', x = - 100, y = s.h -  16, width = s.w + 200, height = 100, r = 255, g = 255, b = 255, a = 150})
end

--------------------------------------------------
-- [[                特效邊框                ]] --
--------------------------------------------------

function Des.UI.DirLoad.effect()
	effect = {
		frame = {
			  wh    = 3
			, speed = 5
			, open  = 0
			, bool  = false
			, color = {
				  r = 0
				, g = 0
				, b = 0
			}
		}
	}
	for i = 1, 25 do
		effect.frame[ 0 + i] = Des.UI.Box.Create()
		effect.frame[ 0 + i]:Set({x = 0, y = 0 + effect.frame.wh * (i - 1), width = s.w, height = effect.frame.wh, r = 0, g = 0, b = 0, a = 0})
		effect.frame[25 + i] = Des.UI.Box.Create()
		effect.frame[25 + i]:Set({x = effect.frame.wh * (i - 1), y = 0, width = effect.frame.wh, height = s.h, r = 0, g = 0, b = 0, a = 0})
		effect.frame[50 + i] = Des.UI.Box.Create()
		effect.frame[50 + i]:Set({x = 0, y = s.h - effect.frame.wh * (i - 1), width = s.w, height = effect.frame.wh, r = 0, g = 0, b = 0, a = 0})
		effect.frame[75 + i] = Des.UI.Box.Create()
		effect.frame[75 + i]:Set({x = s.w - effect.frame.wh * (i - 1), y = 0, width = effect.frame.wh, height = s.h, r = 0, g = 0, b = 0, a = 0})
	end
end

function f_effect_frame(value)
	if not value then
		return
	end
	value.wh    = value.wh    or 3
	value.speed = value.speed or 5
	value.open  = value.open  or 1
	value.color = value.color or {r = 0, g = 0, b = 0}
	
	for k, v in pairs(value) do
		effect.frame[k] = v
	end
end

--------------------------------------------------
-- [[                文字對話                ]] --
--------------------------------------------------

function f_getdialoguelen(msg)
	local dismantle = {}
	local width = 25
	
	local len = #msg
	local i = 1
    while i <= len do
        local byte = string.byte(msg, i)
        local bytecount = 1
        if byte > 0 and byte <= 127 then
            bytecount = 1
			if byte == 105
            or byte == 108 then
                width = width + 9
            else
                width = width + 8
            end
        elseif byte >= 192 and byte <= 223 then
            bytecount = 2
        elseif byte >= 224 and byte <= 239 then
            bytecount = 3
			width = width + 16
        elseif byte >= 240 and byte <= 247 then
            bytecount = 4
        end
		dismantle[#dismantle + 1] = string.sub(msg, i, i + bytecount - 1)
        i = i + bytecount
    end
    return {width = width, dismantle = dismantle}
end

function Des.UI.DirLoad.dialogue()
	dialogue = {
		  count   = 5
		, delay   = {}
		, time    = {}
		, reverse = {}
		, index   = {}
		, remix   = {}
		, msg     = {}
		, box     = {}
		, txt     = {}
	}

	for i = 1, dialogue.count do
		dialogue.delay   [i] = 0
		dialogue.time    [i] = 0
		dialogue.reverse [i] = false
		dialogue.index   [i] = 0
		dialogue.remix   [i] = ""
		dialogue.msg     [i] = ""
	end
	
	for i = 1, dialogue.count do
		dialogue.txt[i] = Des.UI.Frame.Text:Create()
		dialogue.txt[i]:Set({text = '', font = 'small', align = 'center', x = s.w / 2 - s.w / 2, y = s.h - 200 + 12.5 - 50 * (i - 1), width = s.w, height = 30, border = 1, color = {r = 30, g = 150, b = 250}, frameColor = {r = 0, g = 0, b = 0}})
		for j = 1, 7 do
			if not dialogue.box[i * 100 + 0 + j] then
				local gx = s.w / 2 - f_getdialoguelen(dialogue.txt[1]:Get().text).width / 2
				local gy = s.h - 201
				
				dialogue.box[i * 100 + 0 + j] = Des.UI.Box.Create()
				dialogue.box[i * 100 + 0 + j]:Set({x = gx + j - 3, y = gy + j - 50 * (i - 1), width = 32 - j * 2, height = 2, r = 0, g = 0, b = 0, a = 150})
				dialogue.box[i * 100 + 7 + j] = Des.UI.Box.Create()
				dialogue.box[i * 100 + 7 + j]:Set({x = gx + 7 - j - 2, y = gy + j - 50 * (i - 1) + 7 * 2, width = j * 2, height = 2, r = 0, g = 0, b = 0, a = 150})
				
				if j == 1 then
					dialogue.box[i * 100 + 0 + j]:Set({height = 1})
				end
				if j == 1 then
					dialogue.box[i * 100 + 7 + j]:Set({height = 1})
				end
			end
		end
	end

	for _, box in pairs(dialogue.box) do
		box:Hide()
	end
end

--------------------------------------------------
-- [[                等待畫面                ]] --
--------------------------------------------------

function Des.UI.Load.wait()
	wait = {
		  box = {}
		, txt = {}
		
		, bool = false
		, toggle = true
		
		, teammode = false
		
		, teamnums = {
			  [1] = 0
			, [2] = 0
		}
		
		, playdesc = table.deepcopy(language.wait.playdesc[language.use])
		, updatedesc = table.deepcopy(language.wait.updatedesc[language.use])
		
		, DELEGATE = {
			Sync_plrswait = function(sync, i, self)
				local infos = {
					  team  = tonumber(string.sub(sync.value, 1, 1))
					, state = tonumber(string.sub(sync.value, 2, 2))
					, name  =          string.sub(sync.value, 3   )
				}
					
				local show = {
					  [1] = {
						  state = f_getlanguage(language.wait.connecting)
						, color = {
							  {r = 200, g = 200, b = 200}
							, {r = 200, g = 200, b = 200}
						}
					}
					, [2] = {
						  state = f_getlanguage(language.wait.waiting)
						, color = {
							  {r = 250, g = 175, b =   0}
							, {r = 250, g = 175, b =   0}
						}
					}
					, [3] = {
						  state = f_getlanguage(language.wait.ready)
						, color = {
							  {r = 250, g = 150, b = 150}
							, {r = 100, g = 150, b = 250}
						}
					}
				}
				
				if i == 1 then
					for team = 1, 2 do
						wait.teamnums[team] = 0
						for j = 1, 12 do
							wait.txt[1000 + 100 * team + j]:Set({text = string.format(f_getlanguage(language.wait.leftslot), j), color = {r = 75, g = 75, b = 75}})
							for k = 2, 3 do
								wait.box[1000 * k + 100 * team + j]:Set({r = 75, g = 75, b = 75})
							end
						end
					end
				end
				
				if not self.teammode then
					infos.team = i % 2 + 1
					
					for j = 1, 2 do
						show[3].color[j] = {r = 0, g = 250, b = 0}
					end
				end
				
				if infos.team == 1
				or infos.team == 2 then
					wait.teamnums[infos.team] = wait.teamnums[infos.team] + 1
					if wait.teamnums[infos.team] <= 12 then
						wait.txt[1000 + 100 * infos.team + wait.teamnums[infos.team]]:Set({color = show[infos.state].color[infos.team]})
						if infos.team % 2 == 0 then
							wait.txt[1000 + 100 * infos.team + wait.teamnums[infos.team]]:Set({text = infos.name .. show[infos.state].state})
						else
							wait.txt[1000 + 100 * infos.team + wait.teamnums[infos.team]]:Set({text = show[infos.state].state .. infos.name})
						end
						for k = 2, 3 do
							wait.box[1000 * k + 100 * infos.team + wait.teamnums[infos.team]]:Set(show[infos.state].color[infos.team])
						end
					end
				end
			end
			, Event_OnUpdate = function(time, self)
				if Des.Sync.state.value == 0 then
					if tonumber(Des.Sync.remaining.value) then
						wait.txt[2]:Set({text = string.format(f_getlanguage(language.wait.remain), math.floor(Des.Sync.remaining.value - UI.GetTime()))})
						if Des.Sync.remaining.value - UI.GetTime() < 0 then
							wait.txt[2]:Set({text = f_getlanguage(language.wait.holdon)})
						end
					else
						wait.txt[2]:Set({text = string.format("．%s．", Des.Sync.remaining.value)})
					end

					if Des.Sync.difficulty then
						if Des.Sync.difficulty.value then
							local difficultyshow = {
								  [1] = "簡單"
								, [2] = "普通"
								, [3] = "困難"
								, [4] = "極限"
								, [5] = "地獄"
							}
							wait.txt[1]:Set({text = string.format(f_getlanguage(language.wait.map), difficultyshow[Des.Sync.difficulty.value])})
						end
					end
					
					if wait.toggle then
						if wait.box[101]:Get().x < math.floor(s.w / 16 + 11)
						or wait.box[501]:Get().y > math.floor(s.h / 12) then
							wait.bool = true
							f_ui_gradient({ui = wait.box[101], arg = "x", add = 5, into = math.floor(s.w / 16 + 11)})
							f_ui_gradient({ui = wait.box[301], arg = "x", add = -5, into = math.floor(s.w - s.w / 16 - 11 - s.w / 4 + 10)})
							
							f_ui_gradient({ui = wait.box[501], arg = "y", add = -10, into = math.floor(s.h / 12)})
						else
							wait.bool = false
						end
					else
						if wait.box[101]:Get().x > math.floor(- s.w / 3.5 + s.w / 16 + 11)
						or wait.box[501]:Get().y < math.floor(s.h - 60) then
							wait.bool = true
							f_ui_gradient({ui = wait.box[101], arg = "x", add = -5, into = math.floor(- s.w / 3.5 + s.w / 16 + 11)})
							f_ui_gradient({ui = wait.box[301], arg = "x", add = 5, into = math.floor(s.w / 3.5 + s.w - s.w / 16 - 11 - s.w / 4 + 6)})
							
							f_ui_gradient({ui = wait.box[501], arg = "y", add = 10, into = math.floor(s.h - 60)})
						else
							wait.bool = false
						end
					end
					
					if wait.bool then
						local tget = {
							  [1] = wait.box[101]:Get()
							, [2] = wait.box[301]:Get()
						}
						for i = 1, 10 do
							wait.box[200 + i]:Set({x = tget[1].x - 10 + i - 1})
							wait.box[210 + i]:Set({x = tget[1].x + tget[1].width + i - 1})
							wait.box[400 + i]:Set({x = tget[2].x - 10 + i - 1})
							wait.box[410 + i]:Set({x = tget[2].x + tget[2].width + i - 1})
						end
						
						for t = 1, 2 do
							for i = 1, 12 do
								wait.box[1000 + 100 * t + i]:Set({x = tget[t].x + 6})
								wait.box[2000 + 100 * t + i]:Set({x = tget[t].x + 6})
								wait.box[3000 + 100 * t + i]:Set({x = tget[t].x + (s.w / 4 - 25 + 6)})
								
								wait.txt[1000 + 100 * t + i]:Set({x = tget[t].x + 6})
							end
						end
						
						local yget = wait.box[501]:Get().y
						for i = 1, 10 do
							wait.box[600 + i]:Set({y = yget + 10 - i})
							wait.box[610 + i]:Set({y = yget + i})
							wait.box[800 + i]:Set({y = yget - 22 + i * 2})
						end
						
						wait.box[701]:Set({y = yget + 60})
						wait.box[702]:Set({y = yget + (s.h - s.h / 12 * 2) / 2})
						wait.box[703]:Set({y = yget + (s.h - s.h / 12 * 2) - 40})
						
						wait.txt[1]:Set({y = yget + 12 + 15})
						wait.txt[2]:Set({y = yget + (s.h - s.h / 12 * 2) - 30 + 12})
						wait.txt[3]:Set({y = yget + 12 - 20})
						
						local fontheight = {
							  small     = 16
							, medium    = 33
							, large     = 50
							, verylarge = 90
						}
				
						local pdy = yget + 25 + fontheight[wait.playdesc[1].font]
						for k, v in pairs(wait.playdesc) do
							wait.txt[100 + k]:Set({y = pdy})
							pdy = pdy + fontheight[v.font] + 10
						end
						
						local udy = yget + (s.h - s.h / 7 * 2) / 2 - 10 + fontheight[wait.updatedesc[1].font] * 2
						local total_height = 0
						for _, v in pairs(wait.updatedesc) do
							total_height = total_height + fontheight[v.font] + 10
						end
						local available_height = (s.h - s.h / 12 * 2) - 20 - s.h / 2
						local sk = math.max(1, math.ceil((total_height - available_height) / (fontheight.small + 10)))
						for k, v in pairs(wait.updatedesc) do
							if k == 1 or k > sk then
								wait.txt[200 + k]:Set({y = udy})
								
								udy = udy + fontheight[v.font] + 10
							end
						end
					end
				else
					if wait.txt[1]:Get().color.a > 0 then
						for k, v in pairs(wait.box) do
							f_ui_gradient({ui = v, arg = {"a", "color.a", "frameColor.a"}, add = -5, into = 0})
						end
						for k, v in pairs(wait.txt) do
							f_ui_gradient({ui = v, arg = {"a", "color.a", "frameColor.a"}, add = -5, into = 0})
						end
					else
						table.insert(ui_Removing, "wait")
					end
				end
			end
		}
	}
	
	wait.box[101] = Des.UI.Box.Create()
	wait.box[101]:Set({x = math.floor(- s.w / 3.5 + s.w / 16 + 11), y = s.h / 7, width = s.w / 4 - 10, height = s.h - s.h / 7 * 2, r = 25, g = 0, b = 0, a = 100})
	
	wait.box[301] = Des.UI.Box.Create()
	wait.box[301]:Set({x = math.floor(s.w / 3.5 + s.w - s.w / 16 - 11 - s.w / 4 + 6), y = s.h / 7, width = s.w / 4 - 10, height = s.h - s.h / 7 * 2, r = 0, g = 10, b = 25, a = 100})
	
	wait.box[501] = Des.UI.Box.Create()
	wait.box[501]:Set({x = s.w / 2 - s.w / 3 / 2 + 11, y = math.floor(s.h - 60), width = s.w / 3 - 20, height = s.h - s.h / 12 * 2, r = 0, g = 0, b = 0, a = 100})
	
	local tget = {
		  [1] = wait.box[101]:Get()
		, [2] = wait.box[301]:Get()
		, [3] = wait.box[501]:Get()
	}
	
	for i = 1, 10 do
		wait.box[200 + i] = Des.UI.Box.Create()
		wait.box[200 + i]:Set({x = tget[1].x - 10 + i - 1, y = s.h / 7 + 10 - i, width = 1, height = s.h - s.h / 7 * 2 - 20 + i * 2, r = 25, g = 0, b = 0, a = 150 - i * 5})
		wait.box[210 + i] = Des.UI.Box.Create()
		wait.box[210 + i]:Set({x = tget[1].x + tget[1].width + i - 1, y = s.h / 7 + i, width = 1, height = s.h - s.h / 7 * 2 - i * 2, r = 25, g = 0, b = 0, a = 100 + i * 5})
		
		wait.box[400 + i] = Des.UI.Box.Create()
		wait.box[400 + i]:Set({x = tget[2].x - 10 + i - 1, y = s.h / 7 + 10 - i, width = 1, height = s.h - s.h / 7 * 2 - 20 + i * 2, r = 0, g = 10, b = 25, a = 150 - i * 5})
		wait.box[410 + i] = Des.UI.Box.Create()
		wait.box[410 + i]:Set({x = tget[2].x + tget[2].width + i - 1, y = s.h / 7 + i, width = 1, height = s.h - s.h / 7 * 2 - i * 2, r = 0, g = 10, b = 25, a = 100 + i * 5})
		
		wait.box[600 + i] = Des.UI.Box.Create()
		wait.box[600 + i]:Set({x = tget[3].x - 11 + i, y = tget[3].y + 10 - i, width = 1, height = s.h - s.h / 12 * 2 - 20 + i * 2, r = 0, g = 0, b = 0, a = 150 - i * 5})
		wait.box[610 + i] = Des.UI.Box.Create()
		wait.box[610 + i]:Set({x = tget[3].x - 11 + s.w / 3 - 10 + i, y = tget[3].y + i, width = 1, height = s.h - s.h / 12 * 2 - i * 2, r = 0, g = 0, b = 0, a = 100 + i * 5})
		
		wait.box[800 + i] = Des.UI.Box.Create()
		wait.box[800 + i]:Set({x = s.w / 2 - ((s.w / 4 - 10) / 2) / 2 - i * 2 + 1, y = tget[3].y - 22 + i * 2, width = (s.w / 4 - 10) / 2 + i * 4, height = 2, r = 0, g = 0, b = 0, a = 100})
	end
	
	wait.box[701] = Des.UI.Box.Create()
	wait.box[701]:Set({x = s.w / 2 - s.w / 3 / 2 + 25, y = tget[3].y + 60, width = s.w / 3 - 50, height = 1, r = 200, g = 200, b = 200, a = 100})
	wait.box[702] = Des.UI.Box.Create()
	wait.box[702]:Set({x = s.w / 2 - s.w / 3 / 2 + 25, y = tget[3].y + (s.h - s.h / 12 * 2) / 2, width = s.w / 3 - 50, height = 1, r = 200, g = 200, b = 200, a = 100})
	wait.box[703] = Des.UI.Box.Create()
	wait.box[703]:Set({x = s.w / 2 - s.w / 3 / 2 + 25, y = tget[3].y + (s.h - s.h / 12 * 2) - 40, width = s.w / 3 - 50, height = 1, r = 200, g = 200, b = 200, a = 100})
	
	wait.txt[1] = Des.UI.Frame.Text:Create()
	wait.txt[1]:Set({text = f_getlanguage(language.wait.map), font = "medium", align = "center", x = 0, y = tget[3].y + 12 + 15, width = s.w, height = 33, border = 2, color = {r = 150, g = 150, b = 150, a = 255}, frameColor = {r = 0, g = 0, b = 0, a = 255}})
	wait.txt[2] = Des.UI.Frame.Text:Create()
	wait.txt[2]:Set({text = f_getlanguage(language.wait.remain), font = "small", align = "center", x = 0, y = tget[3].y + (s.h - s.h / 12 * 2) - 30 + 12, width = s.w, height = 16, border = 1, color = {r = 150, g = 150, b = 150, a = 255}, frameColor = {r = 0, g = 0, b = 0, a = 255}})
	wait.txt[3] = Des.UI.Frame.Text:Create()
	wait.txt[3]:Set({text = f_getlanguage(language.wait.toggle), font = "small", align = "center", x = 0, y = tget[3].y + 12 - 20, width = s.w, height = 33, border = 1, color = {r = 255, g = 255, b = 255, a = 255}, frameColor = {r = 0, g = 0, b = 0, a = 255}})
	
	if s.w == 1024 and s.h == 768 then
		wait.playdesc[1].font = "small"
		wait.playdesc[1].border = 1
		wait.updatedesc[1].font = "small"
		wait.updatedesc[1].border = 1
		
		wait.txt[1]:Set({font = "small", border = 1})
	end
	
	local fontborder = {
		  small     = 1
		, medium    = 2
		, large     = 2
		, verylarge = 3
	}
	
	local fontheight = {
		  small     = 16
		, medium    = 33
		, large     = 50
		, verylarge = 90
	}
	
	local pdy = tget[3].y + fontheight[wait.playdesc[1].font]
	
	for k, v in pairs(wait.playdesc) do
		if not v.font then
			wait.playdesc[k].font = "small"
		end
		
		wait.txt[100 + k] = Des.UI.Frame.Text:Create()
		wait.txt[100 + k]:Set({text = "", font = "small", align = "center", x = s.w / 2 - s.w / 3 / 2, y = pdy, width = s.w / 3, height = 100, border = fontborder[v.font], color = {r = 255, g = 255, b = 255, a = 255}, frameColor = {r = 0, g = 0, b = 0, a = 255}})
		wait.txt[100 + k]:Set(v)
		
		pdy = pdy + fontheight[v.font] + 10
		
		if not v.color then
			if k == 1 then
				wait.txt[100 + k]:Set({color = {r = 250, g = 250, b = 100}})
			else
				if k % 2 == 0 then
					wait.txt[100 + k]:Set({color = {r = 255, g = 255, b = 255}})
				else
					wait.txt[100 + k]:Set({color = {r = 200, g = 200, b = 200}})
				end
			end
		end
	end
	
	local udy = tget[3].y + (s.h - s.h / 7 * 2) / 2 - 10 + fontheight[wait.updatedesc[1].font] * 2
	
	local total_height = 0
	for _, v in pairs(wait.updatedesc) do
		if not v.font then
			wait.updatedesc[_].font = "small"
		end
		
		total_height = total_height + fontheight[v.font] + 10
	end
	local available_height = (s.h - s.h / 12 * 2) - 20 - s.h / 2
	local sk = math.max(1, math.ceil((total_height - available_height) / (fontheight.small + 10)))
	local tc = 0
	for k, v in pairs(wait.updatedesc) do
		if k == 1 or k > sk then
			wait.txt[200 + k] = Des.UI.Frame.Text:Create()
			wait.txt[200 + k]:Set({text = "", font = "small", align = "left", x = s.w / 2 - s.w / 3 / 2 + 25, y = udy, width = s.w / 3, height = 100, border = fontborder[v.font], color = {r = 255, g = 255, b = 255, a = 255}, frameColor = {r = 0, g = 0, b = 0, a = 255}})
			wait.txt[200 + k]:Set(v)
			udy = udy + fontheight[v.font] + 10
			
			if k == 1 or string.sub(v.text, 4, 4) == "." then
				tc = 1
				wait.txt[200 + k]:Set({color = {r = 125, g = 250, b = 125}})
			elseif tc == 1 then
				tc = 0
				wait.txt[200 + k]:Set({color = {r = 255, g = 255, b = 255}})
			else
				tc = 1
				wait.txt[200 + k]:Set({color = {r = 200, g = 200, b = 200}})
			end
			
			if k == 1 then
				wait.txt[200 + k]:Set({align = "center", x = 0, width = s.w})
			end
		end
	end
	
	for t = 1, 2 do
		local text = {
			format = {
				  [1] = f_getlanguage(language.wait.leftslot)
				, [2] = f_getlanguage(language.wait.rightslot)
			}
		}
		for i = 1, 12 do
			wait.box[1000 + 100 * t + i] = Des.UI.Box.Create()
			wait.box[1000 + 100 * t + i]:Set({x = tget[t].x + 6, y = s.h / 7 + 25 + (s.h - s.h / 7 * 2 - 50) / 12 * (i - 1), width = s.w / 4 - 25, height = (s.h - s.h / 7 * 2) / 12 - 15, r = 10, g = 10, b = 10, a = 50})
			wait.box[2000 + 100 * t + i] = Des.UI.Box.Create()
			wait.box[2000 + 100 * t + i]:Set({x = tget[t].x + 6, y = s.h / 7 + 25 + (s.h - s.h / 7 * 2 - 50) / 12 * (i - 1) - 1, width = 3, height = (s.h - s.h / 7 * 2) / 12 - 15 + 2, r = 100, g = 100, b = 100, a = 255})
			wait.box[3000 + 100 * t + i] = Des.UI.Box.Create()
			wait.box[3000 + 100 * t + i]:Set({x = tget[t].x + (s.w / 4 - 25 + 6), y = s.h / 7 + 25 + (s.h - s.h / 7 * 2 - 50) / 12 * (i - 1) - 1, width = 3, height = (s.h - s.h / 7 * 2) / 12 - 15 + 2, r = 100, g = 100, b = 100, a = 255})
			
			wait.txt[1000 + 100 * t + i] = Des.UI.Frame.Text:Create()
			wait.txt[1000 + 100 * t + i]:Set({text = string.format(text.format[t], i), font = "small", align = "center", x = tget[t].x + 6, y = s.h / 7 + 25 + (s.h - s.h / 7 * 2 - 50) / 12 * (i - 1) + 12, width = s.w / 4 - 25, height = (s.h - s.h / 7 * 2) / 12 - 15, border = 1, color = {r = 100, g = 100, b = 100, a = 255}, frameColor = {r = 0, g = 0, b = 0, a = 255}})
		end
	end
end

--------------------------------------------------
--------------------------------------------------

--------------------------------------------------
-- [[                測試測試                ]] --
--------------------------------------------------

--------------------------------------------------
-- [[                 記分板                 ]] --
--------------------------------------------------

function Des.UI.Load.uiScoreBoard()
	uiScoreBoard = {
		  SETUP = {
			  {UIC = "Box", INDEX = {1, 23, {17}}, ARGS = function(self, i) return {x = s.w / 2 - 200 + i, y = 13 + i * 3, width = 175 - i, height = 3, r = 50 - i * 2, g = 125 - i * 4, b = 250 - i * 6, a = 150} end}
			, {UIC = "Box", INDEX = {1, 23, {17}}, ARGS = function(self, i) return {x = s.w / 2 + 24, y = 13 + i * 3, width = 175 - i, height = 3, r = 200 - i * 6, g = 0, b = 0, a = 150} end}
			, {UIC = "Box", INDEX = {1, 25}, ARGS = function(self, i) return {x = s.w / 2 - 75 / 2 - i, y = 10 + i * 3, width = 75 + i * 2, height = 3, r = 50 - i, g = 50 - i / 1.5, b = 50 - i / 3, a = 255} end}
			
			, {UIN = "max", UIC = "Frame.Text", ARGS = {text = "0", font = "large", align = "center", x = 0, y = 0 + 13, width = s.w, height = 75, border = 1, color = {r = 255, g = 255, b = 255, a = 255}, frameColor = {r = 0, g = 0, b = 0, a = 255}}}
			, {UIC = "Frame.Text", ARGS = {text = "ROUND", font = "small", align = "center", x = 0, y = 35 + 13, width = s.w, height = 75, border = 1, color = {r = 255, g = 255, b = 255, a = 255}, frameColor = {r = 0, g = 0, b = 0, a = 255}}}
			, {UIC = "Frame.Text", ARGS = {text = "HM", font = "small", align = "center", x = -75, y = 3 + 13, width = s.w, height = 75, border = 1, color = {r = 200, g = 225, b = 250, a = 255}, frameColor = {r = 0, g = 0, b = 0, a = 255}}}
			, {UIC = "Frame.Text", ARGS = {text = "ZB", font = "small", align = "center", x = 75, y = 3 + 13, width = s.w, height = 75, border = 1, color = {r = 255, g = 200, b = 200, a = 255}, frameColor = {r = 0, g = 0, b = 0, a = 255}}}
			, {UIN = "sb.2", UIC = "Frame.Text", ARGS = {text = "0", font = "medium", align = "center", x = -125, y = 3 + 13, width = s.w, height = 75, border = 1, color = {r = 200, g = 225, b = 250, a = 255}, frameColor = {r = 0, g = 0, b = 0, a = 255}}}
			, {UIN = "sb.1", UIC = "Frame.Text", ARGS = {text = "0", font = "medium", align = "center", x = 125, y = 3 + 13, width = s.w, height = 75, border = 1, color = {r = 255, g = 200, b = 200, a = 255}, frameColor = {r = 0, g = 0, b = 0, a = 255}}}
			, {UIN = "cp.2", UIC = "Frame.Text", ARGS = {text = "0", font = "small", align = "center", x = -115, y = 38 + 13, width = s.w, height = 75, border = 1, color = {r = 150, g = 175, b = 200, a = 255}, frameColor = {r = 0, g = 0, b = 0, a = 255}}}
			, {UIN = "cp.1", UIC = "Frame.Text", ARGS = {text = "0", font = "small", align = "center", x = 115, y = 38 + 13, width = s.w, height = 75, border = 1, color = {r = 200, g = 150, b = 150, a = 255}, frameColor = {r = 0, g = 0, b = 0, a = 255}}}
			, {UIN = "time", UIC = "Frame.Text", ARGS = {text = "0:00", font = "small", align = "center", x = 0, y = 65 + 13, width = s.w, height = 75, border = 1, color = {r = 255, g = 255, b = 255, a = 255}, frameColor = {r = 0, g = 0, b = 0, a = 255}}}
		}
		, __INIT__ = function(self)
			
		end
		, DELEGATE = {
			Sync_scoreboard = function(sync, self)
				local infos = {
					  now = tonumber(string.sub(sync.value, 1, 2))
					, max = tonumber(string.sub(sync.value, 3, 4))
					, [1] = tonumber(string.sub(sync.value, 5, 6))
					, [2] = tonumber(string.sub(sync.value, 7, 8))
				}
				
				self.ui.max:Set({text = string.format("%d", infos.max)})
				for i = 1, 2 do
					self.ui[string.format("sb.%d", i)]:Set({text = string.format("%d", infos[i])})
				end
			end
			, Sync_countplayer = function(sync, self)
				local infos = {
					  all = tonumber(string.sub(sync.value, 1, 2))
					, [1] = tonumber(string.sub(sync.value, 3, 4))
					, [2] = tonumber(string.sub(sync.value, 5, 6))
				}
				
				for i = 1, 2 do
					self.ui[string.format("cp.%d", i)]:Set({text = string.format("%d", infos[i])})
				end
			end
			, Event_OnUpdate = function(time, self)
				local remtime = tonumber(Des.Sync.remaining.value)
				if remtime then
					if remtime - UI.GetTime() >= 0 then
						local sec = (remtime - UI.GetTime()) % 60
						local min = ((remtime - UI.GetTime()) // 60) % 60
						
						self.ui.time:Set({text = string.format("%.0f:%02.0f", min, sec)})
					end
				end
			end
		}
	}
end

--------------------------------------------------
-- [[                武器冷卻                ]] --
--------------------------------------------------

--[[
function Des.UI.DirLoad.weaponpostfire()
	local baseX = s.w / 2 - 35
	local baseY = s.h / 2 + 215
	local baseWidth = 70
	local baseHeight = 15
	
	
end
]]

--------------------------------------------------
-- [[                重新裝填                ]] --
--------------------------------------------------

function Des.UI.DirLoad.weaponreload()
	local baseX = s.w / 2 - 35
	local baseY = s.h / 2 + 140
	local baseWidth = 70
	local baseHeight = 15
	
	weaponreload = {
		time = 0,
		gettime = 0,
		
		SETUP = {
			{UIC = "Box", ARGS = {x = baseX, y = baseY, width = baseWidth, height = baseHeight, r = 0, g = 0, b = 0, a = 255}},
			{UIC = "Box", ARGS = {x = baseX + 1, y = baseY + 1, width = baseWidth - 2, height = baseHeight - 2, r = 125, g = 125, b = 125, a = 255}},
			{UIC = "Box", ARGS = {x = baseX + 3, y = baseY + 3, width = baseWidth - 6, height = baseHeight - 6, r = 0, g = 0, b = 0, a = 255}},
			{UIN = "bar", UIC = "Box", ARGS = {x = baseX + 5, y = baseY + 5, width = baseWidth - 10, height = baseHeight - 10, r = 0, g = 75, b = 200, a = 255}},
		},
		
		__INIT__ = function(self)
			for k, v in pairs(self:Getobjs()) do
				v:Hide()
			end
		end,
		
		DELEGATE = {
			Sync_PlayerWeaponReload = function(sync, i, self)
				if sync.value > 0 then
					if UI.PlayerIndex(index) == i then
						self.time = sync.value        -- 裝彈所需總時間 (秒)
						self.gettime = UI.GetTime()   -- 開始裝彈的時間點
					
						local fullWidth = baseWidth - 10
						-- 顯示裝彈條並初始設為滿條
						for k, v in pairs(self:Getobjs()) do
							v:Show()
						end
						self.ui.bar:Set({width = fullWidth, height = baseHeight - 10})
					end
				else
					for k, v in pairs(self:Getobjs()) do
						v:Hide()
					end
				end
			end,
			
			Event_OnUpdate = function(time, self)
				-- 如果沒有在裝彈，直接跳過
				if self.time <= 0 then return end

				local fullWidth = baseWidth - 10
				local elapsedTime = time - self.gettime -- 已經經過的時間
				
				-- 計算剩餘時間比例 (1.0 -> 0.0)
				local progress = 1 - (elapsedTime / self.time)
				
				-- 計算當前應該有的目標寬度
				local targetWidth = math.max(0, fullWidth * progress)

				-- 1. 使用漸變 (補間) 遞減
				f_ui_gradient({
					ui = self.ui.bar, 
					arg = {"width"}, 
					speed = 10,           -- 建議把漸變速度拉高，遞減反應才會精確跟上，否則會有延遲感
					into = targetWidth
				})

				-- 【備用方案】：如果 f_ui_gradient 遞減效果不順，可以註解上面的漸變，直接強設寬度：
				-- self.ui.bar:Set({width = targetWidth})

				-- 當時間到達或寬度歸零，隱藏 UI 並重置狀態
				if elapsedTime >= self.time or targetWidth <= 0 then
					self.time = 0 -- 標記結束，防止重複執行
					for k, v in pairs(self:Getobjs()) do
						v:Hide()
					end
				end
			end,
		}
	}
end

--------------------------------------------------
-- [[                區域標題                ]] --
--------------------------------------------------

function Des.UI.DirLoad.uiAreaTitle()
	local baseY = s.h - 120
	
	uiAreaTitle = {
		time = 0,
		SETUP = {
			{UIC = "Box", INDEX = {1, 10}, ARGS = function(self, i) return {x = s.w / 2 - 300 - 40 + 4 * (i - 1), y = baseY, width = 4, height = 2, r = 255, g = 255, b = 255, a = 25 * i} end},
			{UIC = "Box", ARGS = {x = s.w / 2 - 300, y = baseY, width = 600, height = 2, r = 255, g = 255, b = 255, a = 255}},
			{UIC = "Box", INDEX = {1, 10}, ARGS = function(self, i) return {x = s.w / 2 + 300 + 4 * (i - 1), y = baseY, width = 4, height = 2, r = 255, g = 255, b = 255, a = 255 - 25 * i} end},
			{UIN = "title", UIC = "Frame.Text", ARGS = {text = "區域", font = "medium", align = "center", x = s.w / 2 - 300, y = baseY - 30, width = 600, height = 33, r = 255, g = 255, b = 255, a = 255}},
			{UIN = "subtitle", UIC = "Frame.Text", ARGS = {text = "標題", font = "medium", align = "center", x = s.w / 2 - 300, y = baseY + 20, width = 600, height = 33, r = 255, g = 255, b = 255, a = 255}},
		},
		
		__OBJ_INIT__ = function(self)
			for k, v in pairs(self:Getobjs()) do
				v:Set({a = 0, color = {a = 0}, frameColor = {a = 0}})
			end
		end,
		
		DELEGATE = {
			Sync_ShowZoneTitle = function(sync, self)
				local data = LZE2D.ZONETITLE.DATA[sync.value]
				if data then
					self.time = UI.GetTime() + 3
					self.ui.title:Set({text = data.title})
					self.ui.subtitle:Set({text = data.subtitle})
				end
			end,
			Event_OnUpdate = function(time, self)
				if self.time < time then
					for k, v in pairs(self:Getobjs()) do
						f_ui_gradient({ui = v, arg = {"a", "color.a", "frameColor.a"}, speed = 5, into = 0})
					end
				else
					for k, v in pairs(self:Getobjs()) do
						local defarg = self:Getdefarg(v)
						f_ui_gradient({ui = v, arg = {"a", "color.a", "frameColor.a"}, speed = 5, into = defarg})
					end
				end
			end
		}
	}
end

--------------------------------------------------
-- [[                倒數時間                ]] --
--------------------------------------------------

function Des.UI.DirLoad.uiTimer()
	uiTimer = {
		SETUP = {
			
		},
	}
end

--------------------------------------------------
-- [[                頭上箭頭                ]] --
--------------------------------------------------

function Des.UI.DirLoad.uiMyArrow()
	uiMyArrow = {
		SETUP = {
			{UIC = "Frame.Text", ARGS = {text = "▼", font = "small", align = "center", x = 0, y = s.h / 2, width = s.w, height = 16, border = 1, color = {r = 255, g = 175, b = 0, a = 255}, frameColor = {r = 0, g = 0, b = 0, a = 255}}},
		},
	}
end

--------------------------------------------------
-- [[                觀戰提示                ]] --
--------------------------------------------------

function Des.UI.DirLoad.uiSpectator()
	uiSpectator = {
		SETUP = {
			{UIC = "Box", ARGS = {x = 0, y = s.h - 100, width = s.w, height = 100, r = 0, g = 0, b = 0, a = 255}},
			{UIC = "Frame.Text", ARGS = {text = "觀戰中", font = "medium", align = "center", x = 0, y = s.h - 65, width = s.w, height = 33, border = 2, color = {r = 255, g = 255, b = 255, a = 255}, frameColor = {r = 150, g = 150, b = 150, a = 255}}},
			{UIC = "Frame.Text", ARGS = {text = "請等待下一回合，WASD移動觀看", font = "small", align = "center", x = 0, y = s.h - 25, width = s.w, height = 16, border = 1, color = {r = 255, g = 255, b = 255, a = 255}, frameColor = {r = 150, g = 150, b = 150, a = 255}}},
		},
		
		__INIT__ = function(self)
			for k, v in pairs(self:Getobjs()) do
				v:Hide()
			end
		end,
		
		DELEGATE = {
			Sync_PlayerSpectator = function(sync, i, self)
				if UI.PlayerIndex(index) == i then
					if sync.value > 0 then
						for k, v in pairs(self:Getobjs()) do
							v:Show()
						end
					else
						for k, v in pairs(self:Getobjs()) do
							v:Hide()
						end
					end
				end
			end,
		}
	}
end

--------------------------------------------------
-- [[                按鍵顯示                ]] --
--------------------------------------------------

function Des.UI.DirLoad.uiKey()
	uiKey = {
		SETUP = {
			{UIN = "key", UIC = "Frame.Text", ARGS = {text = "【滾輪】視距縮放、【M】簡介", font = 'small', align = 'center', x = s.w / 2, y = s.h - 63, width = s.w / 2, height = 100, border = 1, color = {r = 250, g = 225, b = 100, a = 255}, frameColor = {r = 0, g = 0, b = 0, a = 255}}}
		}
		, DELEGATE = {
			
		}
	}
end

--------------------------------------------------
--------------------------------------------------

--------------------------------------------------
-- [[                計算數量                ]] --
--------------------------------------------------

ui_PreLoad = {}
ui_PreLoadFirst = {
	"black"
}
for k, v in pairs(Des.UI.PreLoad) do
	table.insert(ui_PreLoad, k)
end
for k, v in pairs(ui_PreLoadFirst) do
	for i, j in pairs(ui_PreLoad) do
		if v == j then
			table.remove(ui_PreLoad, i)
			break
		end
	end
	table.insert(ui_PreLoad, v)
end

for k, v in pairs(ui_PreLoad) do
	Des.UI.PreWaitLoad[#Des.UI.PreWaitLoad + 1] = v
	
	Des.UI.PreLoad[v]()
	Des.UI.LoadSetup(v)
	Des.UI.PreNowCount = Des.UI.PreNowCount + 1
end

ui_DirLoad = {}
ui_DirLoadFirst = {
	
}
for k, v in pairs(Des.UI.DirLoad) do
	table.insert(ui_DirLoad, k)
end
for k, v in pairs(ui_DirLoadFirst) do
	for i, j in pairs(ui_DirLoad) do
		if v == j then
			table.remove(ui_DirLoad, i)
			break
		end
	end
	table.insert(ui_DirLoad, v)
end

for k, v in pairs(ui_DirLoad) do
	Des.UI.DirWaitLoad[#Des.UI.DirWaitLoad + 1] = v
end

--------------------------------------------------