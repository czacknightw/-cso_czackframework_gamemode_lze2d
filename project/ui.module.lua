--UI.MODULE---------------------------------------
-- [[                製作名單                ]] --
--------------------------------------------------
--[[

地圖製作：

程式設計：DestroyerI滅世I ( Czack )

-- ==============================================================================

-- Project: Czack Framework 26s3.1 (Lua Zombie Escape 2D / LZE2D)
-- Module:  ui.module.lua
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
--------------------------------------------------
-- [[                讀取確認                ]] --
--------------------------------------------------

print(string.format("<aaffaa>[%s]ui.module.lua is loaded.", Des.Mapsys))
log(string.format("<aaffaa>[%s]ui.module.lua is loaded.", Des.Mapsys))

--------------------------------------------------
-- [[ 　            1024　限制               ]] --
--------------------------------------------------

for i = 1, 1024 do
	Des.UI.Max1024.All.Box [i] = UI.Box .Create()
	Des.UI.Max1024.All.Text[i] = UI.Text.Create()
	Des.UI.Max1024.Unusing.Box [i] = Des.UI.Max1024.All.Box [i]
	Des.UI.Max1024.Unusing.Text[i] = Des.UI.Max1024.All.Text[i]
end

function Des.UI.Loading(tbln)
	if not Des.UI.Load[tbln] then
		return
	end
	if Des.UI.Loaded[tbln] then
		return
	end
	
	Des.UI.Load[tbln]()
	Des.UI.LoadSetup(tbln)
	Des.UI.Loaded[tbln] = true
end

function Des.UI.Remove(tbln)
    local function __FUNC_ENQUEUE(tbl)
        if not tbl then
            return
        end
        table.insert(ui_RemoveQueue, tbl)
    end

    if Des.UI.Load   [tbln]
	or Des.UI.DirLoad[tbln]
	or Des.UI.PreLoad[tbln] then
        local data = _G[tbln]
		
		f_remdelegate("Event_OnUpdate", string.format("DesUI_Offset_%s", tbln))
		for dname, func in pairs(data and data.DELEGATE or {}) do
			f_remdelegate(dname, string.format("DesUI_Delegate_%s_%s", tbln, dname))
		end
		
		__FUNC_ENQUEUE(data)
		
        _G[tbln] = nil
        Des.UI.Loaded[tbln] = nil
    end
end

function Des.UI.Box.Create()
	local none = true
	for k, v in pairs(Des.UI.Max1024.Unusing.Box) do
		if Des.UI.Max1024.Unusing.Box[k] then
			Des.UI.Max1024.  Using.Box[k] = Des.UI.Max1024.Unusing.Box[k]
			Des.UI.Max1024.  Using.Box[k]:Show()
			Des.UI.Max1024.Unusing.Box[k] = nil
			return Des.UI.Max1024.Using.Box[k]
		end
	end
	if none then
		-- assert(nil, "\nUI.Box 創建已達到遊戲上限！\n請使用 Des.UI.Box.Remove(uivar) 移除多餘的 UI.Box！")
	end
end

function Des.UI.Box.Remove(uivar)
	if not uivar then
		return
	end
	local max = 0
	local num = 0
	for k, v in pairs(Des.UI.Max1024.Using.Box) do
		if type(uivar) == "table" then
			max = #uivar.UI
			for i, j in pairs(uivar.UI) do
				if j == v then
					num = num + 1
					Des.UI.Max1024.Unusing.Box[k] = Des.UI.Max1024.Using.Box[k]
					Des.UI.Max1024.Unusing.Box[k]:Set({a = 0})
					Des.UI.Max1024.  Using.Box[k] = nil
					if num == max then
						return nil
					end
				end
			end
		elseif type(uivar) == "userdata" then
			if uivar == v then
				Des.UI.Max1024.Unusing.Box[k] = Des.UI.Max1024.Using.Box[k]
				Des.UI.Max1024.Unusing.Box[k]:Set({a = 0})
				Des.UI.Max1024.  Using.Box[k] = nil
				return nil
			end
		end
	end
end

function Des.UI.Text.Create()
	local none = true
	for k, v in pairs(Des.UI.Max1024.Unusing.Text) do
		if Des.UI.Max1024.Unusing.Text[k] then
			Des.UI.Max1024.  Using.Text[k] = Des.UI.Max1024.Unusing.Text[k]
			Des.UI.Max1024.  Using.Text[k]:Show()
			Des.UI.Max1024.Unusing.Text[k] = nil
			return Des.UI.Max1024.Using.Text[k]
		end
	end
	if none then
		-- assert(nil, "\nUI.Text 創建已達到遊戲上限！\n請使用 Des.UI.Text.Remove(uivar) 移除多餘的 UI.Text！")
	end
end

function Des.UI.Text.Remove(uivar)
	if not uivar then
		return
	end
	local max = 0
	local num = 0
	for k, v in pairs(Des.UI.Max1024.Using.Text) do
		if type(uivar) == "table" then
			max = #uivar.UI
			for i, j in pairs(uivar.UI) do
				if j == v then
					num = num + 1
					Des.UI.Max1024.Unusing.Text[k] = Des.UI.Max1024.Using.Text[k]
					Des.UI.Max1024.Unusing.Text[k]:Set({a = 0})
					Des.UI.Max1024.  Using.Text[k] = nil
					if num == max then
						return nil
					end
				end
			end
		elseif type(uivar) == "userdata" then
			if uivar == v then
				Des.UI.Max1024.Unusing.Text[k] = Des.UI.Max1024.Using.Text[k]
				Des.UI.Max1024.Unusing.Text[k]:Set({a = 0})
				Des.UI.Max1024.  Using.Text[k] = nil
				return nil
			end
		end
	end
end

--------------------------------------------------
-- [[                前置動作                ]] --
--------------------------------------------------

screen = UI.ScreenSize()

fontstr = {
	  ["small"    ] = 16
	, ["medium"   ] = 33
	, ["large"    ] = 50
	, ["verylarge"] = 90
}

fontnum = {
	  [16] = "small"
	, [33] = "medium"
	, [50] = "large"
	, [90] = "verylarge"
}

--------------------------------------------------
-- [[                設定模組                ]] --
--------------------------------------------------

local function setArgs(data, args)
    for k in pairs(data) do
        if type(data[k]) == type(args[k]) then
            if type(data[k]) == "table" then
                setArgs(data[k], args[k])
            else
                data[k] = args[k]
            end
        end
    end
end

local function deepCall(table, funcName, args)
    for _,v in pairs(table) do
        if type(v) == "table" then
            deepCall(v, funcName)
        elseif type(v) == "userdata" then
            v[funcName](v, args)
        end
    end
end

local function clone(table)
    local temp = {}
    for k, v in pairs(table) do
        if type(v) == "table" then
            temp[k] = clone(v)
        else
            temp[k] = v
        end
    end
    return temp
end

Module = {}
Module.__index = Module

function Module:Set(args)
	local oldarg = table.deepcopy(self.SetArg)
	local newarg = args
	if type(args) == "table" then
		setArgs(self.SetArg, args)
	end
	self:Update(oldarg, newarg)
end

function Module:Get()
	return clone(self.SetArg)
end

function Module:Show()
	deepCall(self.UI, "Show")
	self.visible = true
end

function Module:Hide()
	deepCall(self.UI, "Hide")
	self.visible = false
end

function Module:IsVisible()
	return self.visible
end

--------------------------------------------------
-- [[                文字邊框                ]] --
--------------------------------------------------

Des.UI.Frame.Text = setmetatable({}, Module)
Des.UI.Frame.Text.__index = Des.UI.Frame.Text

function Des.UI.Frame.Text:Create()
	local data = {
		SetArg = {
			text = ""
			, font = "small"
			, align = "left"
			, x = 0
			, y = 0
			, width = 0
			, height = 0
			, border = 1
			, color = {r = 255, g = 255, b = 255, a = 255}
			, frameColor = {r = 0, g = 0, b = 0, a = 255}
		}
		, UI = {}
		, visible = true
	}
	for i = 1, 5 do
		data.UI[i] = Des.UI.Text.Create()
	end
	return setmetatable(data, self)
end

function Des.UI.Frame.Text:Update()
	local arg = self.SetArg
	local border = arg.border
	local offset = {
		  {-border, -border}
		, {border,  -border}
		, {border,   border}
		, {-border,  border}
		, {0,             0}
	}
	for k, v in pairs(self.UI) do
		local color = (k == #self.UI and arg.color or arg.frameColor)
		local temp = {
			  x = arg.x + offset[k][1]
			, y = arg.y + offset[k][2]
			, width = arg.width
			, height = arg.height
			
			, r = color.r
			, g = color.g
			, b = color.b
			, a = color.a

			, text = arg.text
			, font = arg.font
			, align = arg.align
		}
		v:Set(temp)
	end
end

--------------------------------------------------
-- [[                方塊邊框                ]] --
--------------------------------------------------

Des.UI.Frame.Box = setmetatable({}, Module)
Des.UI.Frame.Box.__index = Des.UI.Frame.Box

function Des.UI.Frame.Box:Create()
	local data = {
		SetArg = {
			  x = 0
			, y = 0
			, width = 0
			, height = 0
			, border = 2
			, color = {r = 255, g = 255, b = 255, a = 255}
			, frameColor = {r = 0, g = 0, b = 0, a = 255}
		}
		, UI = {}
		, visible = true
	}
	for i = 1, 2 do
		data.UI[i] = Des.UI.Box.Create()
	end
	return setmetatable(data, self)
end

function Des.UI.Frame.Box:Update()
	local arg = self.SetArg
	local border = arg.border
	local offset = {
		  {     0,        0}
		, {border,   border}
	}
	for k, v in pairs(self.UI) do
		local color = (k == #self.UI and arg.color or arg.frameColor)
		local temp = {
			  x = arg.x + offset[k][1]
			, y = arg.y + offset[k][2]
			, width = arg.width - offset[k][1] * 2
			, height = arg.height - offset[k][2] * 2
			
			, r = color.r
			, g = color.g
			, b = color.b
			, a = color.a
		}
		v:Set(temp)
	end
end

--------------------------------------------------
-- [[                 方塊框                 ]] --
--------------------------------------------------

Des.UI.Hollow.Box = setmetatable({}, Module)
Des.UI.Hollow.Box.__index = Des.UI.Hollow.Box

function Des.UI.Hollow.Box:Create()
	local data = {
		SetArg = {
			  x = 0
			, y = 0
			, width = 0
			, height = 0
			, border = 1
			, r = 255
			, g = 255
			, b = 255
			, a = 255
		}
		, UI = {}
		, visible = true
	}
	for i = 1, 4 do
		data.UI[i] = Des.UI.Box.Create()
	end
	return setmetatable(data, self)
end

function Des.UI.Hollow.Box:Update()
	local arg = self.SetArg
	local offset = {
		    {x = arg.x                         , y = arg.y, width = arg.width, height = arg.border}
		  , {x = arg.x                         , y = arg.y, width = arg.border, height = arg.height}
		  , {x = arg.x + arg.width - arg.border, y = arg.y, width = arg.border, height = arg.height}
		  , {x = arg.x                         , y = arg.y + arg.height - arg.border, width = arg.width, height = arg.border}
	}
	for k, v in pairs(self.UI) do
		local temp = {
			  x = offset[k].x
			, y = offset[k].y
			, width = offset[k].width
			, height = offset[k].height
			
			, r = arg.r
			, g = arg.g
			, b = arg.b
			, a = arg.a
		}
		v:Set(temp)
	end
end

--------------------------------------------------
-- [[                文字漸層                ]] --
--------------------------------------------------

Des.UI.Gradient.Text = setmetatable({}, Module)
Des.UI.Gradient.Text.__index = Des.UI.Gradient.Text

function Des.UI.Gradient.Text:Create()
	local data = {
		SetArg = {
			  text = ""
			, font = "small"
			, align = "left"
			, x = 0
			, y = 0
			, width = 0
			, fine = 10
			, color = {
				  r = 255
				, g = 255
				, b = 255
				, a = 255
			}
			, tocolor = {
				  r = 0
				, g = 0
				, b = 0
				, a = 100
			}
		}
		, UI = {}
		, visible = true
	}
	for i = 1, 11 do
		data.UI[i] = Des.UI.Text.Create()
	end
	return setmetatable(data, self)
end

function Des.UI.Gradient.Text:Update()
	local arg = self.SetArg
	
	if arg.fine then
		if arg.fine > #self.UI then
			for i = 1, math.abs(arg.fine - #self.UI) do
				self.UI[#self.UI + 1] = Des.UI.Text.Create()
			end
		elseif arg.fine < #self.UI then
			for i = #self.UI, arg.fine + 1, -1 do
				Des.UI.Text.Remove(self.UI[i])
				self.UI[i] = nil
			end
		end
	end
	
	for k, v in pairs(self.UI) do
		local y = (k == 1) and (arg.y) or (arg.y + (fontstr[arg.font] / arg.fine) * k / 2)
		local height = fontstr[arg.font] - (fontstr[arg.font] / arg.fine) * k
		
		local ncolor = {
			  r = arg.color.r - (arg.color.r - arg.tocolor.r) / arg.fine * k
			, g = arg.color.g - (arg.color.g - arg.tocolor.g) / arg.fine * k
			, b = arg.color.b - (arg.color.b - arg.tocolor.b) / arg.fine * k
			, a = arg.color.a - (arg.color.a - arg.tocolor.a) / arg.fine * k
		}
		local temp = {
			  text = arg.text
			, font = arg.font
			, align = arg.align
			, x = arg.x
			, y = y
			, width = arg.width
			, height = height
			, r = ncolor.r
			, g = ncolor.g
			, b = ncolor.b
			, a = ncolor.a
		}
		v:Set(temp)
	end
end

--------------------------------------------------
-- [[                支援大陸                ]] --
--------------------------------------------------

if cnsvt then
	for i, j in pairs(cnsvt) do
		for k, v in pairs(j) do
			Des.UI.Cnsv.Supptext[k] = v
		end
	end
end

function string.subutf8(str, startIndex, endIndex)
    -- 計算字串中 UTF-8 字元數
    local function utf8_len(s)
        local count, i = 0, 1
        while i <= #s do
            local c = string.byte(s, i)
            if not c then break end
            if c < 0x80 then
                i = i + 1
            elseif c < 0xE0 then
                i = i + 2
            elseif c < 0xF0 then
                i = i + 3
            elseif c < 0xF8 then
                i = i + 4
            else
                i = i + 1 -- 防呆：遇到無效字元就跳過
            end
            count = count + 1
        end
        return count
    end

    -- 把 UTF-8 位置轉成 byte 索引
    local function utf8_byte_index(s, index)
        local cur, i = 0, 1
        while i <= #s do
            local c = string.byte(s, i)
            local size = 1
            if c < 0x80 then
                size = 1
            elseif c < 0xE0 then
                size = 2
            elseif c < 0xF0 then
                size = 3
            elseif c < 0xF8 then
                size = 4
            end
            cur = cur + 1
            if cur == index then
                return i
            end
            i = i + size
        end
        return #s + 1
    end

    local total = utf8_len(str)

    -- 處理負數 index
    if startIndex < 0 then
        startIndex = total + startIndex + 1
    end
    if endIndex and endIndex < 0 then
        endIndex = total + endIndex + 1
    end

    -- 預設 endIndex 為字串末尾
    if not endIndex then
        return string.sub(str, utf8_byte_index(str, startIndex))
    else
        return string.sub(str, utf8_byte_index(str, startIndex), utf8_byte_index(str, endIndex + 1) - 1)
    end
end

Des.UI.Cnsv.Text = setmetatable({}, Module)
Des.UI.Cnsv.Text.__index = Des.UI.Cnsv.Text

function Des.UI.Cnsv.Text:Create()
	local data = {
		SetArg = {
			  text = ""
			, font = fontstr["small"]
			, align = "left"
			, x = 0
			, y = 0
			, width = 1
			, height = 1
			, limit = 0
			, space = 2
			, r = 255
			, g = 255
			, b = 255
			, a = 255
		}
		, total_box = 0
		, total_width = 0
		, Text = {}
		, UI = {}
		, visible = true
	}
	return setmetatable(data, self)
end

function Des.UI.Cnsv.Text:Update(oldarg, newarg)
	local arg = self.SetArg
	
	-- font size
	if newarg then
		if type(newarg.font) == "string" then
			arg.font = fontstr[newarg.font] - 4
		elseif type(newarg.font) == "number" then
			arg.font = newarg.font
		elseif newarg.font then
			arg.font = fontstr["small"]
		end
	end
	
	-- 獲取字量
	self.Text = {}
	
	local length = string.lenutf8(arg.text)
	self.total_box = 0
	self.total_width = 0
	for i = 1, length do
	
		if arg.limit > 0
		and i > arg.limit then
			break
		end
		
		local char = string.subutf8(arg.text, i, i)
		
		-- 例外處理 ( 允許數字, 符號 )
		if tonumber(char) then
			
		end
		
		local st = Des.UI.Cnsv.Supptext[char] or {{0,4,1,1,0,7,1,1,1,5,3,2,2,3,1,6,4,4,1,1,4,7,1,1},{5,6,6}}
		
		if not Des.UI.Cnsv.Regitext[char] or not Des.UI.Cnsv.Regitext[char].text then
			local data = {
				  text = char
				, width = st[2][1]
				, height = st[2][2]
				, consumption = st[2][3]
				, arg = {}
			}
			for j = 1, #st[1], 4 do
				local textarg = {
					  x = st[1][j + 0]
					, y = st[1][j + 1] + 8
					, width = st[1][j + 2]
					, height = st[1][j + 3]
				}
				
				if textarg.width == 0 or textarg.height == 0 then
				
				else
					table.insert(data.arg, textarg)
				end
			end
			Des.UI.Cnsv.Regitext[char] = data
		end
		
		self.total_box = self.total_box + st[2][3]
		table.insert(self.Text, Des.UI.Cnsv.Regitext[char])
		
		self.total_width = self.total_width + Des.UI.Cnsv.Regitext[char].width + arg.space
	end
	
	-- 移除多餘 Box 或 增加 Box
	if #self.UI > self.total_box then
		for i = self.total_box + 1, #self.UI do
			Des.UI.Box.Remove(self.UI[i])
			self.UI[i] = nil
		end
	else
		for i = #self.UI + 1, self.total_box do
			self.UI[i] = Des.UI.Box.Create()
		end
	end
	
	-- 設定初始 x 偏移
	local offset_x = 0
	if arg.align == "center" then
		offset_x = (arg.width - self.total_width * arg.font / 10) / 2
	elseif arg.align == "right" then
		offset_x = (arg.width - self.total_width * arg.font / 10)
	end

	-- 建立與調整 UI
	local x = 0
	local id = 0
	for tid, tdata in pairs(self.Text) do
		if tdata.arg then
			for i, v in pairs(tdata.arg) do
				id = id + 1
				if self.UI[id] then
					self.UI[id]:Set({
						  x = x + arg.x + offset_x + (v.x + arg.space) * arg.font / 10
						, y = arg.y + v.y * arg.font / 10 + 8
						, width = math.ceil(v.width * arg.font / 10)
						, height = math.ceil(v.height * arg.font / 10)
						, r = arg.r
						, g = arg.g
						, b = arg.b
						, a = arg.a
					})
					if self.visible then
						self.UI[id]:Show()
					else
						self.UI[id]:Hide()
					end
				end
			end
			x = x + (arg.space + tdata.width) * arg.font / 10
		end
	end
	
	-- 如果不顯示則清除文字留空間
	if arg.a == 0 then
		for k, v in pairs(self.UI) do
			Des.UI.Box.Remove(v)
		end
		self.Text = {}
		self.UI = {}
	end
end

--------------------------------------------------
-- [[                像素文字                ]] --
--------------------------------------------------

Des.UI.Pixel.Letter = {
	A = {
		  "　＃＃＃　"
		, "＃　　　＃"
		, "＃　　　＃"
		, "＃　　　＃"
		, "＃＃＃＃＃"
		, "＃　　　＃"
		, "＃　　　＃"
	}
	, C = {
		  "　＃＃＃　"
		, "＃　　　＃"
		, "＃　　　　"
		, "＃　　　　"
		, "＃　　　　"
		, "＃　　　＃"
		, "　＃＃＃　"
	}
	, D = {
		  "＃＃＃＃　"
		, "＃　　　＃"
		, "＃　　　＃"
		, "＃　　　＃"
		, "＃　　　＃"
		, "＃　　　＃"
		, "＃＃＃＃　"
	}
	, E = {
		  "＃＃＃＃＃"
		, "＃　　　　"
		, "＃　　　　"
		, "＃＃＃＃　"
		, "＃　　　　"
		, "＃　　　　"
		, "＃＃＃＃＃"
	}
	, K = {
		  "＃　　　＃"
		, "＃　　＃　"
		, "＃　＃　　"
		, "＃＃　　　"
		, "＃　＃　　"
		, "＃　　＃　"
		, "＃　　　＃"
	}
	, O = {
		  "　＃＃＃　"
		, "＃　　　＃"
		, "＃　　　＃"
		, "＃　　　＃"
		, "＃　　　＃"
		, "＃　　　＃"
		, "　＃＃＃　"
	}
	, R = {
		  "＃＃＃＃　"
		, "＃　　　＃"
		, "＃　　　＃"
		, "＃＃＃＃　"
		, "＃　　　＃"
		, "＃　　　＃"
		, "＃　　　＃"
	}
	, S = {
		  "　＃＃＃　"
		, "＃　　　＃"
		, "＃　　　　"
		, "　＃＃＃　"
		, "　　　　＃"
		, "＃　　　＃"
		, "　＃＃＃　"
	}
	, T = {
		  "＃＃＃＃＃"
		, "　　＃　　"
		, "　　＃　　"
		, "　　＃　　"
		, "　　＃　　"
		, "　　＃　　"
		, "　　＃　　"
	}
	, W = {
		  "＃　　　＃"
		, "＃　　　＃"
		, "＃　　　＃"
		, "＃　　　＃"
		, "＃　＃　＃"
		, "＃＃　＃＃"
		, "＃　　　＃"
	}
	, Y = {
		  "＃　　　＃"
		, "＃　　　＃"
		, "　＃　＃　"
		, "　　＃　　"
		, "　　＃　　"
		, "　　＃　　"
		, "　　＃　　"
	}
	, Z = {
		  "＃＃＃＃＃"
		, "　　　　＃"
		, "　　　＃　"
		, "　　＃　　"
		, "　＃　　　"
		, "＃　　　　"
		, "＃＃＃＃＃"
	}
}

Des.UI.Pixel.Text = setmetatable({}, Module)
Des.UI.Pixel.Text.__index = Des.UI.Pixel.Text

function Des.UI.Pixel.Text:Object()
	return self
end

function Des.UI.Pixel.Text:Create()
	local data = {
		SetArg = {
			  text = ""
			, x = 0
			, y = 0
			, width = 1
			, height = 1
			, r = 255
			, g = 255
			, b = 255
			, a = 255
			, shadow = {
				  r = 0
				, g = 0
				, b = 0
				, bool = false
				, offset = {x = 5, y = 5}
			}
			, split = {}
		}
		, Text = {}
		, UI = {}
		, Obj = {}
		, visible = true
	}
	return setmetatable(data, self)
end

function Des.UI.Pixel.Text:Update(oldarg, newarg)
	local arg = self.SetArg
	
	local length = string.len(arg.text)
	
	local obj = self.Obj
	local index = 0
	for l = 1, length do
		local char = string.sub(arg.text, l, l)
		local letter = Des.UI.Pixel.Letter[char]
		
        if not obj[l] then obj[l] = {} end
        for i = 1, #letter do
			obj[l][i] = obj[l][i] or {}
        end
        
        if letter then
            for k, v in pairs(letter) do
                for i = 1, string.len(v) // 3 do
                    if string.sub(v, 1 + 3 * (i - 1), i * 3) == "＃" then
                        obj[l][k] = obj[l][k] or {}
                        obj[l][k][i] = obj[l][k][i] or {}
						
                        if not obj[l][k][i][1] then
                            if arg.shadow.bool
							and not obj[l][k][i][2] then
                                obj[l][k][i][2] = Des.UI.Box.Create()
                            end

                            obj[l][k][i][1] = Des.UI.Box.Create()
                        end
						
						index = index + 1
						if not self.UI[index] then
							self.UI[index] = {
								  main   = obj[l][k][i][1]
								, shadow = obj[l][k][i][2]
							}
						end
						
                        local drawX = arg.x + arg.width * (i - 1) + arg.width * 6 * (l - 1)
                        local drawY = arg.y + arg.height * (k - 1)
						
                        local temp_main = {
                            x = drawX,
                            y = drawY,
                            width = arg.width,
                            height = arg.height,
                            r = arg.r,
                            g = arg.g,
                            b = arg.b,
                            a = arg.a
                        }
						local temp_shadow = {
                            x = drawX + arg.shadow.offset.x,
                            y = drawY + arg.shadow.offset.y,
                            width = arg.width,
                            height = arg.height,
                            r = arg.shadow.r, g = arg.shadow.g, b = arg.shadow.b,
                            a = arg.a
                        }
						for k, v in pairs(arg.ignore or {}) do
							temp_main[v] = obj[l][k][i][1]:Get()[v]
							temp_shadow[v] = obj[l][k][i][2]:Get()[v]
						end
						
                        obj[l][k][i][1]:Set(temp_main)
                        if obj[l][k][i][2] then
                            obj[l][k][i][2]:Set(temp_shadow)
                        end
						
                        for j = 1, 2 do
                            if obj[l][k][i][j] then
                                if self.visible then
                                    obj[l][k][i][j]:Show()
                                else
                                    obj[l][k][i][j]:Hide()
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

--------------------------------------------------
-- [[                建立設置                ]] --
--------------------------------------------------

function Des.UI.LoadSetup(objname)
	local __FUNC_MODULECLASS, __FUNC_UICREATE, __FUNC_UIRETBL, copy_filter
	
	local data = _G[objname]
	
	if not data then
		error(objname)
		return
	end
	
	-- SETUP
	data.__ui = {}
	
	if data.SETUP then
		data.SETUP.__SORT__ = data.SETUP.__SORT__ or {}
	end
	
	local sorted = {}
	for k, v in pairs(data.SETUP and data.SETUP.__SORT__ or {}) do
		sorted[v] = true
	end
	for k, v in pairs(data.SETUP or {}) do
		if k ~= "__SORT__" then
			if not sorted[k] then
				table.insert(data.SETUP.__SORT__, k)
			end
		end
	end
	
	local search_results = table.deepsearch(data.SETUP or {}, function(k, v)
		if type(v) == "table" and v.UIC then
			return v
		end
	end)
	
	local sorted_sr = {}
	for k, v in pairs(data.SETUP and data.SETUP.__SORT__ or {}) do
		for _, result in pairs(search_results or {}) do
			local setup = result.value
			local groupname = result.path[1]
			
			if groupname == v then
				table.insert(sorted_sr, {setup = setup, groupname = groupname})
			end
		end
	end
	
	function __FUNC_MODULECLASS(obj)
		local mt = getmetatable(obj)
		while mt do
			if mt == Module then
				return true
			end
			mt = getmetatable(mt)
		end
		return false
	end
	
	function __FUNC_UICREATE(setup, groupname, i)
		local load_cmd = string.format("return Des.UI.%s.Create(Des.UI.%s)", setup.UIC, setup.UIC)
		local uic = load(load_cmd)()
		local arg = {}
		
		if type(setup.ARGS) == "table" then
			arg = setup.ARGS
		elseif type(setup.ARGS) == "function" then
			arg = setup.ARGS(data, i)
		end
		uic:Set(arg)
		
		-- 1. 動態決定要存放的私有容器
		local target_container
		-- 確保只有字串名稱才被當作獨立 Group，數字索引則丟回 data.__ui
		if groupname and type(groupname) == "string" then
			local priv_group = "__ui_group_" .. groupname
			data[priv_group] = data[priv_group] or {}
			target_container = data[priv_group]
		else
			target_container = data.__ui
		end
		
		-- 2. 將原本的 data.__ui 改為 target_container
		local target = setup.UIN
		if i then
			if target then
				if not target_container[target] then
					target_container[target] = {}
				else
					if  type(target_container[target][2]) == "userdata"
					or (type(target_container[target][2]) == "table" and __FUNC_MODULECLASS(target_container[target][2])) then
						local old = target_container[target]
						target_container[target] = { old }
					end
				end
				table.insert(target_container[target], {groupname, uic, arg})
			else
				table.insert(target_container, {groupname, uic, arg})
			end
		else
			if target then
				if not target_container[target] then
					target_container[target] = {groupname, uic, arg}
				else
					local current = target_container[target]
					if type(current[2]) == "userdata" or (type(current[2]) == "table" and __FUNC_MODULECLASS(current[2])) then
						-- 如果已經是一個 UI 物件陣列，就把它包裝成多個元素的陣列
						target_container[target] = { current, {groupname, uic, arg} }
					else
						-- 如果已經是多個元素的陣列，就直接 Append
						table.insert(target_container[target], {groupname, uic, arg})
					end
				end
			else
				table.insert(target_container, {groupname, uic, arg})
			end
		end
		return uic
	end
	
	for _, result in pairs(sorted_sr or {}) do
		local setup = result.setup
		local groupname = result.groupname

		if setup.INDEX then
			local excludes = {}
			if setup.INDEX[3] then
				for _, exclude in pairs(setup.INDEX[3]) do
					excludes[exclude] = true
				end
			end
			
			for i = setup.INDEX[1], setup.INDEX[2] do
				if not excludes[i] then
					__FUNC_UICREATE(setup, groupname, i)
				end
			end
		else
			__FUNC_UICREATE(setup, groupname)
		end
	end
	
	function __FUNC_UIRETBL(tbl)
		local retbl = {}
		if type(tbl) ~= "table" then
			return tbl
		end
		for k, v in pairs(tbl) do
			if type(v) == "table" then
				if type(v[2]) == "userdata" then
					retbl[k] = v[2]
				elseif type(v[2]) == "table" and __FUNC_MODULECLASS(v[2]) then
					retbl[k] = v[2]
				else
					retbl[k] = __FUNC_UIRETBL(v)
				end
			else
				retbl[k] = v
			end
		end
		return retbl
	end
	-- 把過濾邏輯獨立出來
	function copy_filter(obj)
		if type(obj) == "userdata" then
			return true
		elseif type(obj) == "table" and __FUNC_MODULECLASS(obj) then
			return true
		elseif type(obj) == "table" and obj.UIC then
			return true
		end
		return false
	end

	-- 處理沒有 groupname 的元素 (放入 self.ui)
	data.ui = __FUNC_UIRETBL(table.deepcopy(data.__ui, nil, copy_filter))
	
	-- 處理有 groupname 的元素 (分別放入 self[groupname])
	for k, v in pairs(data.SETUP or {}) do
		-- 只處理字串鍵值，忽略數字索引
		if k ~= "__SORT__" and type(k) == "string" then
			local priv_group = "__ui_group_" .. k
			if data[priv_group] then
				data[k] = __FUNC_UIRETBL(table.deepcopy(data[priv_group], nil, copy_filter))
			end
		end
	end
	
	local function __FUNC_REFRESHOBJS()
		data.__OBJS = data.__OBJS or {}
		data.__OBJS.obj = {}
		data.__OBJS.groupobj = {}
		data.__OBJS.defarg = data.__OBJS.defarg or {}
		
		for k, v in pairs(data.SETARG or {}) do
			local uic = v[1]
			local arg = v[2]
			local groupname = v[3]
			
			table.insert(data.__OBJS.obj, uic)
			if not data.__OBJS.defarg[uic] then
				data.__OBJS.defarg[uic] = arg
			end
			if groupname then
				if not data.__OBJS.groupobj[groupname] then
					data.__OBJS.groupobj[groupname] = {}
				end
				table.insert(data.__OBJS.groupobj[groupname], uic)
			end
		end
	end
	
	data.SETARG = data.SETARG or {}
	
	-- 建立一個暫存的合併容器，讓 deepsearch 可以找到所有 UI
	local all_ui_data = { ui = data.__ui }
	for k, v in pairs(data.SETUP or {}) do
		if k ~= "__SORT__" and type(k) == "string" then
			local priv_group = "__ui_group_" .. k
			if data[priv_group] then
				all_ui_data[k] = data[priv_group]
			end
		end
	end

	local found_uis = table.deepsearch(all_ui_data, function(k, v)
		if type(v) == "table" then
			if type(v[2]) == "userdata" then
				return v
			elseif type(v[2]) == "table" and __FUNC_MODULECLASS(v[2]) then
				return v
			end
		end
	end)
	for _, result in ipairs(found_uis) do
		local item = result.value 
		
		local uic = item[2]
		local arg = item[3]
		local groupname = item[1]
		
		table.insert(data.SETARG, { uic, arg, groupname })
	end
	__FUNC_REFRESHOBJS()
	
	-- OFFSET
	local function __FUNC_OFFSET(tbl)
		tbl.OFFSET = tbl.OFFSET or {
			  GLOBAL = {}
			, GROUP = {}
		}
		tbl.__OFFSET = tbl.__OFFSET or {
			  GLOBAL = {}
			, GROUP = {}
		}
		for groupname, _ in pairs(tbl.SETUP or {}) do
			if groupname ~= "__SORT__" then
				tbl.OFFSET.GROUP[groupname] = tbl.OFFSET.GROUP[groupname] or {}
				tbl.__OFFSET.GROUP[groupname] = tbl.__OFFSET.GROUP[groupname] or {}
			end
		end
		
		local change = false
		for k, v in pairs(tbl.OFFSET.GLOBAL) do
			if not tbl.__OFFSET.GLOBAL[k] then
				tbl.__OFFSET.GLOBAL[k] = v
			end
			if tbl.__OFFSET.GLOBAL[k] ~= v then
				if tbl.__OFFSET.GLOBAL[k] > v then
					tbl.__OFFSET.GLOBAL[k] = math.max(tbl.__OFFSET.GLOBAL[k] - tbl.OFFSET.GLOBAL.SPEED, v)
				elseif tbl.__OFFSET.GLOBAL[k] < v then
					tbl.__OFFSET.GLOBAL[k] = math.min(tbl.__OFFSET.GLOBAL[k] + tbl.OFFSET.GLOBAL.SPEED, v)
				end
				change = true
			end
		end
		for groupname, _ in pairs(tbl.SETUP or {}) do
			if groupname ~= "__SORT__" then
				for argk, value in pairs(tbl.OFFSET.GROUP[groupname]) do
					if not tbl.__OFFSET.GROUP[groupname][argk] then
						tbl.__OFFSET.GROUP[groupname][argk] = value
					end
					if tbl.__OFFSET.GROUP[groupname][argk] ~= value then
						if tbl.__OFFSET.GROUP[groupname][argk] > value then
							tbl.__OFFSET.GROUP[groupname][argk] = math.max(tbl.__OFFSET.GROUP[groupname][argk] - tbl.OFFSET.GROUP[groupname].SPEED, value)
						elseif tbl.__OFFSET.GROUP[groupname][argk] < value then
							tbl.__OFFSET.GROUP[groupname][argk] = math.min(tbl.__OFFSET.GROUP[groupname][argk] + tbl.OFFSET.GROUP[groupname].SPEED, value)
						end
						change = true
					end
				end
			end
		end
		
		if not change then
			tbl.OFFSET.GLOBAL.SPEED = 0
			tbl.__OFFSET.GLOBAL.SPEED = 0
			for groupname, _ in pairs(tbl.SETUP or {}) do
				if groupname ~= "__SORT__" then
					tbl.OFFSET.GROUP[groupname].SPEED = 0
					tbl.__OFFSET.GROUP[groupname].SPEED = 0
				end
			end
		else
			for _, remix in pairs(tbl.SETARG or {}) do
				local obj = remix[1]
				local initarg = remix[2]
				local ingroup = remix[3]
				
				local newarg = {}
				for argk, value in pairs(tbl.__OFFSET.GLOBAL) do
					if initarg[argk] then
						newarg[argk] = (newarg[argk] or 0) + initarg[argk] + value
					end
				end
				
				for groupname, _ in pairs(tbl.SETUP or {}) do
					if groupname ~= "__SORT__" then
						if ingroup == groupname then
							for argk, value in pairs(tbl.__OFFSET.GROUP[groupname] or {}) do
								if initarg[argk] then
									newarg[argk] = (newarg[argk] or 0) + initarg[argk] + value
								end
							end
						end
					end
				end
				
				obj:Set(newarg)
			end
		end
	end
	
	__FUNC_OFFSET(data)
	local function __OFFSET_UPDATE(time)
		if Des.UI.Loaded[objname] then
			__FUNC_OFFSET(data)
		end
	end
	f_adddelegate("Event_OnUpdate", string.format("DesUI_Offset_%s", objname), __OFFSET_UPDATE, {_G[objname]})
	
	-- DELEGATE
	for dname, func in pairs(data.DELEGATE or {}) do
		local function nfunc(v1, v2, v3, v4, v5)
			if Des.UI.Loaded[objname] then
				func(v1, v2, v3, v4, v5)
			end
		end
		f_adddelegate(dname, string.format("DesUI_Delegate_%s_%s", objname, dname), nfunc, {_G[objname]})
	end
	
	-- API
	data.API = function(data)
		for k, v in pairs(data) do
			if type(v) == "function" then
				print(k)
			end
		end
	end
	data.Getobjs = function(data, groupname)
		if groupname then
			return data.__OBJS.groupobj[groupname]
		else
			return data.__OBJS.obj
		end
	end
	data.Getdefarg = function(data, obj)
		return data.__OBJS.defarg[obj]
	end
	data.SetGroup = function(data, groupname, setup)
		data.SETUP[groupname] = data.SETUP[groupname] or {}
		
		-- 確保有把 groupname 傳遞進去
		local uic = __FUNC_UICREATE(setup, groupname)
		
		-- 針對指定的 group 進行更新
		local priv_group = "__ui_group_" .. groupname
		if data[priv_group] then
			data[groupname] = __FUNC_UIRETBL(table.deepcopy(data[priv_group]))
		end
		
		table.insert(data.SETARG, { uic, uic:Get(), groupname })
		__FUNC_REFRESHOBJS()
	end
	data.GetGroup = function(data)
		local retbl = {}
		for k, v in pairs(data.SETUP or {}) do
			if not string.find(k, "__") then
				table.insert(retbl, k)
			end
		end
		return retbl
	end
	data.SetOffset = function(data, args, groupname)
		if groupname then
			for k, v in pairs(args) do
				data.OFFSET.GROUP[groupname][k] = v
			end
		else
			for k, v in pairs(args) do
				data.OFFSET.GLOBAL[k] = v
			end
		end
	end
	data.GetOffset = function(data, groupname)
		if groupname then
			return data.OFFSET.GROUP[groupname]
		else
			return data.OFFSET.GLOBAL
		end
	end
	data.AddSetup = function(data, groupname, setup)
		if not data or not setup then return end
		
		-- 確保 SETUP 容器存在
		data.SETUP = data.SETUP or {}
		data.SETUP.__SORT__ = data.SETUP.__SORT__ or {}
		if not data.SETUP[groupname] then
			data.SETUP[groupname] = setup
		end
		
		-- 更新 __SORT__
		local exists = false
		for _, v in ipairs(data.SETUP.__SORT__) do
			if v == groupname then exists = true break end
		end
		if not exists and type(groupname) == "string" then
			table.insert(data.SETUP.__SORT__, groupname)
		end
		
		-- 模組判斷函式
		local function __FUNC_MODULECLASS(obj)
			local mt = getmetatable(obj)
			while mt do
				if mt == Module then return true end
				mt = getmetatable(mt)
			end
			return false
		end
		
		-- UI 建立函式
		local function __FUNC_UICREATE(setup, groupname, i)
			local load_cmd = string.format("return Des.UI.%s.Create(Des.UI.%s)", setup.UIC, setup.UIC)
			local uic = load(load_cmd)()
			local arg = {}
			if type(setup.ARGS) == "table" then
				arg = setup.ARGS
			elseif type(setup.ARGS) == "function" then
				arg = setup.ARGS(data, i)
			end
			uic:Set(arg)
			
			-- 決定放哪個 container
			local target_container
			if groupname and type(groupname) == "string" then
				local priv_group = "__ui_group_" .. groupname
				data[priv_group] = data[priv_group] or {}
				target_container = data[priv_group]
			else
				target_container = data.__ui
			end
			
			local target = setup.UIN
			if target then
				if not target_container[target] then
					target_container[target] = {groupname, uic, arg}
				else
					-- 如果原本不是 table array，先轉成 array
					if type(target_container[target][2]) == "userdata"
					   or (type(target_container[target][2]) == "table" and __FUNC_MODULECLASS(target_container[target][2])) then
						local old = target_container[target]
						target_container[target] = { old }
					end
					table.insert(target_container[target], {groupname, uic, arg})
				end
			else
				table.insert(target_container, {groupname, uic, arg})
			end
			return uic
		end
		
		-- 處理 INDEX 支援多個生成
		if setup.INDEX then
			local excludes = {}
			if setup.INDEX[3] then
				for _, ex in pairs(setup.INDEX[3]) do
					excludes[ex] = true
				end
			end
			for i = setup.INDEX[1], setup.INDEX[2] do
				if not excludes[i] then
					__FUNC_UICREATE(setup, groupname, i)
				end
			end
		else
			__FUNC_UICREATE(setup, groupname)
		end
		
		-- 更新 SETARG 與 __OBJS
		data.SETARG = data.SETARG or {}
		data.__OBJS = data.__OBJS or {}
		data.__OBJS.obj = data.__OBJS.obj or {}
		data.__OBJS.groupobj = data.__OBJS.groupobj or {}
		data.__OBJS.defarg = data.__OBJS.defarg or {}
		
		local all_ui_data = { ui = data.__ui }
		for k, v in pairs(data.SETUP or {}) do
			if k ~= "__SORT__" and type(k) == "string" then
				local priv_group = "__ui_group_" .. k
				if data[priv_group] then all_ui_data[k] = data[priv_group] end
			end
		end
		
		local found_uis = table.deepsearch(all_ui_data, function(k, v)
			if type(v) == "table" then
				if type(v[2]) == "userdata" then return v end
				if type(v[2]) == "table" and __FUNC_MODULECLASS(v[2]) then return v end
			end
		end)
		
		for _, result in ipairs(found_uis) do
			local item = result.value
			local uic = item[2]
			local arg = item[3]
			local grp = item[1]
			local exists = false
			for _, v in ipairs(data.SETARG) do
				if v[1] == uic then exists = true break end
			end
			if not exists then
				table.insert(data.SETARG, { uic, arg, grp })
				table.insert(data.__OBJS.obj, uic)
				data.__OBJS.defarg[uic] = arg
				if grp then
					data.__OBJS.groupobj[grp] = data.__OBJS.groupobj[grp] or {}
					table.insert(data.__OBJS.groupobj[grp], uic)
				end
			end
		end
		
		-- 更新 data.ui 與 data[groupname]
		local function copy_filter(obj)
			if type(obj) == "userdata" then return true end
			if type(obj) == "table" and __FUNC_MODULECLASS(obj) then return true end
			if type(obj) == "table" and obj.UIC then return true end
			return false
		end
		local function __FUNC_UIRETBL(tbl)
			local retbl = {}
			if type(tbl) ~= "table" then return tbl end
			for k, v in pairs(tbl) do
				if type(v) == "table" then
					if type(v[2]) == "userdata" or (type(v[2]) == "table" and __FUNC_MODULECLASS(v[2])) then
						retbl[k] = v[2]
					else
						retbl[k] = __FUNC_UIRETBL(v)
					end
				else
					retbl[k] = v
				end
			end
			return retbl
		end
		
		data.ui = __FUNC_UIRETBL(table.deepcopy(data.__ui, nil, copy_filter))
		if groupname then
			local priv_group = "__ui_group_" .. groupname
			if data[priv_group] then
				data[groupname] = __FUNC_UIRETBL(table.deepcopy(data[priv_group], nil, copy_filter))
			end
		end
	end
	-- === 新增：只清除物件但不破壞系統的方法 ===
	data.ClearObjs = function(data, groupname)
		-- 1. 決定要清理的 UI 陣列
		local target_objs = {}
		if groupname then
			if data.__OBJS and data.__OBJS.groupobj and data.__OBJS.groupobj[groupname] then
				for _, uic in ipairs(data.__OBJS.groupobj[groupname]) do
					table.insert(target_objs, uic)
				end
			end
		else
			if data.__OBJS and data.__OBJS.obj then
				for _, uic in ipairs(data.__OBJS.obj) do
					table.insert(target_objs, uic)
				end
			end
		end

		-- 2. 推入非同步刪除佇列 (ui_RemoveQueue) 進行回收
		-- 這裡模擬原本 Remove 的機制，將物件丟進你原本寫好的每幀上限 1024 回收池
		for _, uic in ipairs(target_objs) do
			table.insert(ui_RemoveQueue, uic)
		end

		-- 3. 清理資料庫內的引用，避免殘留
		if groupname then
			-- 清理特定群組的暫存
			if data.__OBJS and data.__OBJS.groupobj then
				data.__OBJS.groupobj[groupname] = nil
			end
			-- 清理 SETARG 裡面的特定群組物件
			if data.SETARG then
				for i = #data.SETARG, 1, -1 do
					if data.SETARG[i][3] == groupname then
						local uic = data.SETARG[i][1]
						if data.__OBJS and data.__OBJS.defarg then data.__OBJS.defarg[uic] = nil end
						table.remove(data.SETARG, i)
					end
				end
			end
			-- 清除對外的暴露實體與私有容器
			data[groupname] = nil
			local priv_group = "__ui_group_" .. groupname
			data[priv_group] = nil
		else
			-- 全域清理 (保留 SETUP 與 DELEGATE)
			data.__OBJS.obj = {}
			data.__OBJS.groupobj = {}
			data.__OBJS.defarg = {}
			data.SETARG = {}
			data.ui = {}
			data.__ui = {}
			
			-- 順便清空所有私有群組
			for k, v in pairs(data.SETUP or {}) do
				if k ~= "__SORT__" and type(k) == "string" then
					data[k] = nil
					data["__ui_group_" .. k] = nil
				end
			end
		end
	end

	data.RecreateObjs = function(data)
		-- 1. 先完整的把舊物件全部乾淨回收
		data:ClearObjs()

		-- 2. 重新跑一次原本 LoadSetup 內部的「從 SETUP 生成物件」邏輯
		-- 因為這段代碼是在 LoadSetup 閉包(Closure) 內，它能直接存取外面的 sorted_sr 與 __FUNC_UICREATE
		for _, result in pairs(sorted_sr or {}) do
			local setup = result.setup
			local groupname = result.groupname

			if setup.INDEX then
				local excludes = {}
				if setup.INDEX[3] then
					for _, exclude in pairs(setup.INDEX[3]) do
						excludes[exclude] = true
					end
				end
				for i = setup.INDEX[1], setup.INDEX[2] do
					if not excludes[i] then
						__FUNC_UICREATE(setup, groupname, i)
					end
				end
			else
				__FUNC_UICREATE(setup, groupname)
			end
		end

		-- 3. 重新建立對外表格 (data.ui 與 data[groupname])
		data.ui = __FUNC_UIRETBL(table.deepcopy(data.__ui, nil, copy_filter))
		for k, v in pairs(data.SETUP or {}) do
			if k ~= "__SORT__" and type(k) == "string" then
				local priv_group = "__ui_group_" .. k
				if data[priv_group] then
					data[k] = __FUNC_UIRETBL(table.deepcopy(data[priv_group], nil, copy_filter))
				end
			end
		end

		-- 4. 重新刷洗 SETARG 核心索引
		data.SETARG = data.SETARG or {}
		local all_ui_data = { ui = data.__ui }
		for k, v in pairs(data.SETUP or {}) do
			if k ~= "__SORT__" and type(k) == "string" then
				local priv_group = "__ui_group_" .. k
				if data[priv_group] then all_ui_data[k] = data[priv_group] end
			end
		end

		local found_uis = table.deepsearch(all_ui_data, function(k, v)
			if type(v) == "table" then
				if type(v[2]) == "userdata" or (type(v[2]) == "table" and __FUNC_MODULECLASS(v[2])) then
					return v
				end
			end
		end)
		for _, result in ipairs(found_uis) do
			local item = result.value 
			table.insert(data.SETARG, { item[2], item[3], item[1] })
		end

		-- 5. 重新整理快取物件
		__FUNC_REFRESHOBJS()
		
		-- 6. 初始化 Offset 基礎資料
		__FUNC_OFFSET(data)
		
		if data.__OBJ_INIT__ then
			data:__OBJ_INIT__()
		end
	end
	-- ============================================
	
	Des.UI.Loaded[objname] = true
	
	-- INIT
	
	if data.__INIT__ then
		data:__INIT__()
	end
	if data.__OBJ_INIT__ then
		data:__OBJ_INIT__()
	end
end

--------------------------------------------------
-- [[                動態數字                ]] --
--------------------------------------------------

DESYSTEM.LERPVALUE = {
	ANIMATION = {},
	
	__INIT__ = function(self)
		
	end,
	__DELEGATE__ = {
		Event_OnUpdate = function(time, self)
			for _, obj in pairs(self.ANIMATION) do
				if obj.__GOAL then
					local goal = obj.__GOAL[1]
					if goal and tonumber(goal) then
						if obj.NOW > goal then
							obj.NOW = math.max(obj.NOW - obj.SPEED * f_get_deltatime() * 100, goal)
						elseif obj.NOW < goal then
							obj.NOW = math.min(obj.NOW + obj.SPEED * f_get_deltatime() * 100, goal)
						end
					end
				end
			end
		end,
	},
	
	CREATE = function(self, name, track)
		if self.ANIMATION[name] then
			return self.ANIMATION[name]
		end

		local container = {}

		local function makeAnim(key, refTable)
			local anim = {
				SPEED = 5,
				NOW   = refTable[key],
				GOAL  = refTable[key],

				__GOAL = setmetatable({},{
					__index = function() return refTable[key] end,
					__newindex = function(_,_,v) refTable[key] = v end
				})
			}

			self.ANIMATION[name.."."..key] = anim
			return anim
		end

		if type(track) == "table" then
			for k,_ in pairs(track) do
				container[k] = makeAnim(k, track)
			end
		else
			container = makeAnim("value",{ value = track })
		end

		self.ANIMATION[name] = container
		return container
	end
}

--------------------------------------------------
-- [[                文字多色                ]] --
--------------------------------------------------

DESYSTEM.MULTICOLORTEXT = {
	__INIT__ = function(self) end,
	__DELEGATE__ = { },
	
	HEXTORGB = function(self, str)
		-- 移除可能的 # 符號
		str = str:gsub("#","")

		if #str == 6 then
			-- 當作十六進位
			return {
				r = tonumber(str:sub(1,2),16),
				g = tonumber(str:sub(3,4),16),
				b = tonumber(str:sub(5,6),16),
			}
		elseif #str == 9 then
			-- 當作 10 進位，每 3 位一個通道
			return {
				r = tonumber(str:sub(1,3),10),
				g = tonumber(str:sub(4,6),10),
				b = tonumber(str:sub(7,9),10),
			}
		else
			-- 不合法長度
			error("HEXTORGB: invalid input length")
		end
	end,
	
	CLEANMULTILINE = function(self, str)
		str = str:gsub("^\n+", "")
		str = str:gsub("\n+$", "")
		local cleaned = str:gsub("^[ \t]+", ""):gsub("\n[ \t]+", "\n")
		return { cleaned }
	end,
	
	PARSECOLOREDSTRING = function(self, str, defaultcolor)
		local result = {}
		local baseColor = defaultcolor or {r=255, g=255, b=255}
		local currentColor = baseColor
		local pos = 1
		
		while pos <= #str do
			-- 尋找下一個 <標籤>
			local start_idx, end_idx, tag = str:find("<([^>]*)>", pos)
			
			if not start_idx then
				-- 如果後面沒有標籤了，就把剩下的純文字全部塞入
				local text = str:sub(pos)
				if text ~= "" then
					table.insert(result, {text = text, color = currentColor})
				end
				break
			end
			
			-- 擷取標籤「前面」的純文字
			if start_idx > pos then
				local text = str:sub(pos, start_idx - 1)
				table.insert(result, {text = text, color = currentColor})
			end
			
			-- 判斷標籤種類並處理顏色
			if tag == "/" then
				-- 遇到 </>，變回預設顏色
				currentColor = baseColor
			elseif #tag == 6 and tag:match("^%x+$") then
				-- 遇到 <RRGGBB> 正常色碼
				currentColor = self:HEXTORGB(tag)
			elseif #tag == 9 and tag:match("^%d+$") then
				-- 遇到 <RRRGGGBBB> 十進位色碼
				currentColor = self:HEXTORGB(tag)
			else
				-- 容錯處理：遇到奇怪的標籤 (例如 <abc>) 就當作一般文字印出來
				table.insert(result, {text = "<" .. tag .. ">", color = currentColor})
			end
			
			-- 將搜尋位置推進到標籤之後
			pos = end_idx + 1
		end
		
		return result
	end,
	
	GENERATEALIGNEDBLOCKS = function(self, parsed, defaultcolor)
		local blocks = {}
		local baseColor = defaultcolor or {r=255, g=255, b=255}
		
		-- 1. 產生完整的底層 (blocks[1])
		local totalText = ""
		for _, seg in ipairs(parsed) do
			totalText = totalText .. seg.text
		end
		table.insert(blocks, {text = totalText, color = baseColor})
		
		-- 2. 紀錄顏色與出現順序
		local colorMap = {}
		local order = {}
		for _, seg in ipairs(parsed) do
			local hex = string.format("%02x%02x%02x", seg.color.r, seg.color.g, seg.color.b)
			if not colorMap[hex] then
				colorMap[hex] = seg.color
				table.insert(order, hex)
			end
		end
		
		-- 3. 合併同色區塊並補齊異色空白
		for _, hex in ipairs(order) do
			local blockText = ""
			for _, seg in ipairs(parsed) do
				local segHex = string.format("%02x%02x%02x", seg.color.r, seg.color.g, seg.color.b)
				
				if segHex == hex then
					blockText = blockText .. seg.text
				else
					local fill = ""
					local k = 1
					while k <= #seg.text do
						local byte = seg.text:byte(k)
						if byte == 10 then       -- \n
							fill = fill .. "\n"
							k = k + 1
						elseif byte < 128 then   -- ASCII
							fill = fill .. " "
							k = k + 1
						else                     -- 多位元組中文字
							fill = fill .. "　"
							if byte >= 240 then k = k + 4
							elseif byte >= 224 then k = k + 3
							elseif byte >= 192 then k = k + 2
							else k = k + 1 end
						end
					end
					blockText = blockText .. fill
				end
			end
			table.insert(blocks, {text = blockText, color = colorMap[hex]})
		end
		
		return blocks
	end,
}

--------------------------------------------------
-- [[                 跑馬燈                 ]] --
--------------------------------------------------

DESYSTEM.MARQUEE = {
	PAUSE = {},
	ACTIVE = {},
	
	__INIT__ = function(self) end,
	__DELEGATE__ = {
		Event_OnUpdate = function(time, self)
			for main, data in pairs(self.PAUSE) do
				for i, ui in pairs(self.PAUSE[main].uis) do
					if ui:IsVisible() then
						self.PAUSE[main] = nil
					end
				end
			end
			for main, data in pairs(self.ACTIVE) do
				if not main:IsVisible() then
					self.PAUSE[main] = data
					self.ACTIVE[main] = nil
					break
				end
				if f_interval(string.format("DESYSTEM.MARQUEE.%s", tostring(main)), 0.2) then
					local m = f_getdialoguelen(data.text, data.font)
					if m.width > main:Get().width then
						-- 1. 主層 (main) 位移
						local chars = m.dismantle
						if chars and #chars > 1 then
							local first = table.remove(chars, 1)
							table.insert(chars, first)
							data.text = table.concat(chars)
							main:Set({text = data.text})
						end
						
						-- 2. 副層 (多色圖層) 同步位移
						for k, ui in pairs(data.uis) do
							if data.ui_texts[k] then
								local sub_m = f_getdialoguelen(data.ui_texts[k])
								local sub_chars = sub_m.dismantle
								if sub_chars and #sub_chars > 1 then
									local sub_first = table.remove(sub_chars, 1)
									table.insert(sub_chars, sub_first)
									data.ui_texts[k] = table.concat(sub_chars)
									ui:Set({text = data.ui_texts[k]})
								end
							end
						end
					end
				end
			end
		end,
	},
	
	ADD = function(self, ...)
		local uis = {...}
		local main = table.remove(uis, 1)
		
		if self.ACTIVE[main] then 
			return self.ACTIVE[main] 
		end
		
		-- 記錄副層的初始文字
		local ui_texts = {}
		for k, ui in pairs(uis) do
			ui_texts[k] = ui:Get().text
		end
		
		self.ACTIVE[main] = { 
			uis = uis,
			text = main:Get().text,
			ui_texts = ui_texts,
			font = main:Get().font or "small"
		}
		return self.ACTIVE[main]
	end,
	
	REMOVE = function(self, main)
		self.PAUSE[main] = nil
		self.ACTIVE[main] = nil
	end,
}

--------------------------------------------------
-- [[                顏色變化                ]] --
--------------------------------------------------

--[[
	# Original by dowgen #
]]

f_rgb_stage = 0
f_rgb_range = 0
f_rgb_speed = 0
function f_rgb_gradient()
	f_rgb_range = f_rgb_range * f_rgb_speed
	if f_rgb_range > 255 then
		f_rgb_range = f_rgb_range - 255
		if f_rgb_stage < 2 then
			f_rgb_stage = f_rgb_stage + 1
		else
			f_rgb_stage = 0
		end
	end
end
function f_rgb_return()
	if f_rgb_stage == 0 then
		return {r = 255 - f_rgb_range, g =       f_rgb_range, b =   0              }
	elseif stage1 == 1 then
		return {r =   0              , g = 255 - f_rgb_range, b =       f_rgb_range}
	elseif stage1 == 2 then
		return {r =       f_rgb_range, g =   0              , b = 255 - f_rgb_range}
	end
end

--------------------------------------------------
-- [[                官方等級                ]] --
--------------------------------------------------

function f_official_lv(args)
	if not args then
		return
	end
	
	if not args.ui then
		return
	end
	
	if not args.index then
		return
	end
	
	if not args.text then
		return
	end
	
	local size = args.size or 1
	local color = args.color or {r = 255, g = 255, b = 255}
	local align = args.align or "left"
	
	local bits = #tostring(args.text)
	
	local official_lv = {
		  ["L"] = {
			  {x = 0, y = 0, width = 3, height = 13}
			, {x = 0, y = 10, width = 10, height = 3}
		}
		, ["v"] = {
			  {x = 0, y = 4, width = 3, height = 2}
			, {x = 1, y = 6, width = 3, height = 2}
			, {x = 6, y = 4, width = 3, height = 2}
			, {x = 5, y = 6, width = 3, height = 2}
			, {x = 2, y = 8, width = 5, height = 3}
			, {x = 3, y = 11, width = 3, height = 2}
		}
		, ["."] = {
			  {x = 0, y = 10, width = 3, height = 3}
		}
	}
	
	local bitnum = {}
	for i = 1, bits do
		bitnum[i] = string.sub(tostring(args.text), i, i)
		for k, v in pairs(official_lv[bitnum[i]]) do
			if not args.ui[args.index] then
				args.ui[args.index] = Des.UI.Box.Create()
			end
			args.ui[args.index]:Set({x = args.x + v.x * size + 13 * (i - 1) * size, y = args.y + v.y * size, width = v.width * size, height = v.height * size, a = 255})
			args.ui[args.index]:Set(color)
			
			if align == "center" then
				args.ui[args.index]:Set({x = args.ui[args.index]:Get().x - bits * 13 * size + bits * 13 * size / 2})
			end
			if align == "right" then
				args.ui[args.index]:Set({x = args.ui[args.index]:Get().x - bits * 13 * size})
			end
			
			args.index = args.index + 1
		end
	end
	
	local check = 1
	while args.ui[args.index + check] do
		args.ui[args.index + check]:Set({y = s.h})
		check = check + 1
	end
end

--------------------------------------------------
-- [[                官方數字                ]] --
--------------------------------------------------

function f_official_number(args)
	if not args then
		return
	end
	
	if not args.ui then
		return
	end
	
	if not args.index then
		return
	end
	
	if not args.number then
		return
	end
	
	local size = args.size or 1
	local color = args.color or {r = 255, g = 255, b = 255}
	local align = args.align or "left"
	
	local bits = #string.format(args.format or "%.0f", args.number)
	
	local official_number = {
		  [0] = {
			  {x = 0 + 1, y = 0, width = 9, height = 3}
			, {x = 0, y = 0 + 1, width = 3, height = 11}
			, {x = 0 + 8, y = 0 + 1, width = 3, height = 11}
			, {x = 0 + 1, y = 0 + 10, width = 9, height = 3}
		}
		, [1] = {
			  {x = 0 + 2, y = 0, width = 6, height = 2}
			, {x = 0 + 6, y = 0, width = 3, height = 13}
		}
		, [2] = {
			  {x = 0, y = 0 + 1, width = 3, height = 3}
			, {x = 0 + 1, y = 0, width = 9, height = 2}
			, {x = 0 + 8, y = 0 + 1, width = 3, height = 6}
			, {x = 0 + 1, y = 0 + 6, width = 9, height = 2}
			, {x = 0, y = 0 + 7, width = 3, height = 6}
			, {x = 0, y = 0 + 11, width = 11, height = 2}
		}
		, [3] = {
			  {x = 0, y = 0 + 1, width = 3, height = 3}
			, {x = 0 + 1, y = 0, width = 9, height = 2}
			, {x = 0 + 8, y = 0 + 1, width = 3, height = 5}
			, {x = 0 + 4, y = 0 + 5, width = 6, height = 3}
			, {x = 0 + 8, y = 0 + 7, width = 3, height = 5}
			, {x = 0 + 1, y = 0 + 11, width = 9, height = 2}
			, {x = 0, y = 0 + 9, width = 3, height = 3}
		}
		, [4] = {
			  {x = 0 + 7, y = 0, width = 3, height = 13}
			, {x = 0, y = 0 + 9, width = 11, height = 2}
			, {x = 0 + 6, y = 0 + 1, width = 1, height = 3}
			, {x = 0 + 5, y = 0 + 2, width = 1, height = 3}
			, {x = 0 + 4, y = 0 + 3, width = 1, height = 3}
			, {x = 0 + 3, y = 0 + 4, width = 1, height = 3}
			, {x = 0 + 2, y = 0 + 5, width = 1, height = 2}
			, {x = 0 + 1, y = 0 + 6, width = 1, height = 1}
			, {x = 0, y = 0 + 7, width = 3, height = 2}
		}
		, [5] = {
			  {x = 0 + 1, y = 0, width = 10, height = 2}
			, {x = 0 + 1, y = 0, width = 3, height = 7}
			, {x = 0 + 1, y = 0 + 5, width = 9, height = 2}
			, {x = 0 + 8, y = 0 + 6, width = 3, height = 6}
			, {x = 0 + 2, y = 0 + 11, width = 8, height = 2}
			, {x = 0 + 1, y = 0 + 9, width = 3, height = 3}
		}
		, [6] = {
			  {x = 0 + 1, y = 0, width = 9, height = 2}
			, {x = 0 + 8, y = 0 + 1, width = 3, height = 3}
			, {x = 0, y = 0 + 1, width = 3, height = 11}
			, {x = 0 + 3, y = 0 + 5, width = 7, height = 2}
			, {x = 0 + 1, y = 0 + 11, width = 9, height = 2}
			, {x = 0 + 8, y = 0 + 6, width = 3, height = 6}
		}
		, [7] = {
			  {x = 0, y = 0, width = 3, height = 4}
			, {x = 0, y = 0, width = 11, height = 2}
			, {x = 0 + 8, y = 0, width = 3, height = 6}
			, {x = 0 + 7, y = 0 + 6, width = 3, height = 2}
			, {x = 0 + 6, y = 0 + 7, width = 3, height = 2}
			, {x = 0 + 5, y = 0 + 8, width = 3, height = 2}
			, {x = 0 + 4, y = 0 + 9, width = 3, height = 2}
			, {x = 0 + 3, y = 0 + 10, width = 3, height = 2}
			, {x = 0 + 2, y = 0 + 11, width = 3, height = 2}
			, {x = 0 + 1, y = 0 + 12, width = 4, height = 1}
		}
		, [8] = {
			  {x = 0 + 1, y = 0, width = 9, height = 2}
			, {x = 0, y = 0 + 1, width = 3, height = 5}
			, {x = 0 + 8, y = 0 + 1, width = 3, height = 5}
			, {x = 0 + 1, y = 0 + 5, width = 9, height = 3}
			, {x = 0, y = 0 + 7, width = 3, height = 5}
			, {x = 0 + 8, y = 0 + 7, width = 3, height = 5}
			, {x = 0 + 1, y = 0 + 11, width = 9, height = 2}
		}
		, [9] = {
			  {x = 0 + 1, y = 0, width = 9, height = 2}
			, {x = 0, y = 0 + 1, width = 3, height = 5}
			, {x = 0 + 1, y = 0 + 5, width = 7, height = 2}
			, {x = 0 + 8, y = 0 + 1, width = 3, height = 11}
			, {x = 0 + 1, y = 0 + 11, width = 9, height = 2}
			, {x = 0, y = 0 + 9, width = 3, height = 3}
		}
	}
	
	local bitnum = {}
	for i = 1, bits do
		bitnum[i] = tonumber(string.sub(string.format(args.format or "%.0f", args.number), i, i))
		for k, v in pairs(official_number[bitnum[i]]) do
			if not args.ui[args.index] then
				args.ui[args.index] = Des.UI.Box.Create()
			end
			args.ui[args.index]:Set({x = args.x + v.x * size + 13 * (i - 1) * size, y = args.y + v.y * size, width = v.width * size, height = v.height * size, a = 255})
			args.ui[args.index]:Set(color)
			
			if align == "center" then
				args.ui[args.index]:Set({x = args.ui[args.index]:Get().x - bits * 13 * size + bits * 13 * size / 2})
			end
			if align == "right" then
				args.ui[args.index]:Set({x = args.ui[args.index]:Get().x - bits * 13 * size})
			end
			
			args.index = args.index + 1
		end
	end
	
	local check = 0
	while args.ui[args.index + check] do
		args.ui[args.index + check]:Set({a = 0})
		check = check + 1
	end
end

--------------------------------------------------
-- [[                官方英文                ]] --
--------------------------------------------------

function f_official_english(args)
	if not args then
		return
	end
	
	if not args.ui then
		return
	end
	
	if not args.index then
		return
	end
	
	if not args.text then
		return
	end
	
	local size = args.size or 1
	local color = args.color or {r = 255, g = 255, b = 255}
	local align = args.align or "left"
	
	local bits = #tostring(args.text)
	
	local official_english = {
		  ["S"] = {
			  {x = 2, y = 0, width = 18, height = 6}
			, {x = 16, y = 2, width = 6, height = 5}
			, {x = 0, y = 2, width = 6, height = 12}
			, {x = 2, y = 10, width = 18, height = 6}
			, {x = 16, y = 12, width = 6, height = 12}
			, {x = 2, y = 20, width = 18, height = 6}
			, {x = 0, y = 19, width = 6, height = 5}
		}
		, ["T"] = {
			  {x = 0, y = 0, width = 22, height = 6}
			, {x = 8, y = 0, width = 6, height = 26}
		}
		, ["K"] = {
			  {x = 0, y = 0, width = 6, height = 26}
			, {x = 6, y = 11, width = 8, height = 4}
		}
		, ["I"] = {
			  {x = 8, y = 0, width = 6, height = 26}
		}
		, ["L"] = {
			  {x = 0, y = 0, width = 6, height = 26}
			, {x = 0, y = 20, width = 22, height = 6}
		}
		, ["H"] = {
			  {x = 0, y = 0, width = 6, height = 26}
			, {x = 16, y = 0, width = 6, height = 26}
			, {x = 6, y = 10, width = 10, height = 6}
		}
		, ["D"] = {
			  {x = 6, y = 0, width = 10, height = 6}
			, {x = 0, y = 0, width = 6, height = 26}
			, {x = 6, y = 20, width = 10, height = 6}
			, {x = 14, y = 1, width = 4, height = 6}
			, {x = 15, y = 2, width = 4, height = 6}
			, {x = 16, y = 3, width = 4, height = 6}
			, {x = 17, y = 4, width = 4, height = 4}
			, {x = 18, y = 6, width = 4, height = 2}
			, {x = 16, y = 8, width = 6, height = 12}
			, {x = 15, y = 18, width = 6, height = 4}
			, {x = 14, y = 19, width = 6, height = 4}
			, {x = 14, y = 20, width = 5, height = 4}
			, {x = 14, y = 24, width = 4, height = 1}
		}
		, ["E"] = {
			  {x = 0, y = 0, width = 6, height = 26}
			, {x = 6, y = 0, width = 16, height = 6}
			, {x = 6, y = 10, width = 16, height = 6}
			, {x = 6, y = 20, width = 16, height = 6}
		}
		, ["F"] = {
			  {x = 0, y = 0, width = 6, height = 26}
			, {x = 6, y = 0, width = 16, height = 6}
			, {x = 6, y = 10, width = 16, height = 6}
		}
		, ["N"] = {
			  {x = 0, y = 0, width = 6, height = 26}
			, {x = 16, y = 0, width = 6, height = 26}
		}
		, ["!"] = {
			  {x = 8, y = 0, width = 6, height = 18}
			, {x = 8, y = 20, width = 6, height = 6}
		}
		, ["C"] = {
			  {x = 7, y = 0, width = 8, height = 6}
			, {x = 4, y = 1, width = 5, height = 6}
			, {x = 2, y = 2, width = 5, height = 7}
			, {x = 1, y = 4, width = 5, height = 18}
			, {x = 0, y = 7, width = 1, height = 12}
			, {x = 1, y = 17, width = 6, height = 5}
			, {x = 2, y = 19, width = 7, height = 5}
			, {x = 4, y = 20, width = 14, height = 5}
			, {x = 7, y = 25, width = 8, height = 1}
			, {x = 13, y = 1, width = 5, height = 6}
			, {x = 15, y = 2, width = 5, height = 7}
			, {x = 15, y = 4, width = 6, height = 5}
			, {x = 16, y = 7, width = 6, height = 5}
			, {x = 16, y = 14, width = 6, height = 5}
			, {x = 15, y = 17, width = 6, height = 5}
			, {x = 13, y = 19, width = 7, height = 5}
			, {x = 13, y = 19, width = 5, height = 6}
		}
		, ["R"] = {
			  {x = 0, y = 0, width = 6, height = 26}
			, {x = 0, y = 0, width = 17, height = 6}
			, {x = 14, y = 1, width = 5, height = 6}
			, {x = 15, y = 2, width = 5, height = 6}
			, {x = 16, y = 3, width = 5, height = 5}
			, {x = 16, y = 5, width = 6, height = 21}
			, {x = 6, y = 13, width = 10, height = 6}
		}
		, ["O"] = {
			  {x = 4, y = 0, width = 14, height = 6}
			, {x = 2, y = 1, width = 5, height = 6}
			, {x = 1, y = 2, width = 6, height = 5}
			, {x = 0, y = 4, width = 6, height = 18}
			, {x = 1, y = 19, width = 6, height = 5}
			, {x = 2, y = 24, width = 2, height = 1}
			, {x = 4, y = 20, width = 14, height = 6}
			, {x = 15, y = 19, width = 5, height = 6}
			, {x = 20, y = 22, width = 1, height = 2}
			, {x = 16, y = 4, width = 6, height = 18}
		}
		, ["U"] = {
			  {x = 0, y = 0, width = 6, height = 22}
			, {x = 1, y = 19, width = 6, height = 5}
			, {x = 2, y = 24, width = 2, height = 1}
			, {x = 4, y = 20, width = 14, height = 6}
			, {x = 15, y = 19, width = 5, height = 6}
			, {x = 20, y = 22, width = 1, height = 2}
			, {x = 16, y = 0, width = 6, height = 22}
		}
		, ["P"] = {
			  {x = 0, y = 0, width = 6, height = 26}
			, {x = 0, y = 0, width = 17, height = 6}
			, {x = 14, y = 1, width = 5, height = 6}
			, {x = 15, y = 2, width = 5, height = 6}
			, {x = 16, y = 3, width = 5, height = 5}
			, {x = 16, y = 5, width = 6, height = 13}
			, {x = 6, y = 13, width = 10, height = 6}
		}
		, ["A"] = {
			  {x = 0, y = 0, width = 6, height = 26}
			, {x = 16, y = 0, width = 6, height = 26}
			, {x = 6, y = 0, width = 10, height = 6}
			, {x = 6, y = 14, width = 10, height = 6}
		}
		, ["P"] = {
			  {x = 0, y = 0, width = 6, height = 26}
			, {x = 0, y = 0, width = 17, height = 6}
			, {x = 14, y = 1, width = 5, height = 6}
			, {x = 15, y = 2, width = 5, height = 6}
			, {x = 16, y = 3, width = 5, height = 5}
			, {x = 16, y = 5, width = 6, height = 13}
			, {x = 6, y = 13, width = 10, height = 6}
		}
	}
	for i = 1, 11 do
		table.insert(official_english["K"], {x = 6 + i, y = 11 - i, width = 8, height = 3})
		table.insert(official_english["K"], {x = 6 + i, y = 11 + 2 + i, width = 8, height = 3})
		if i <= 10 then
			table.insert(official_english["N"], {x = 6 + i, y = 4 + i, width = 2, height = 9})
		end
	end
	
	
	local bitnum = {}
	for i = 1, bits do
		bitnum[i] = string.sub(tostring(args.text), i, i)
		for k, v in pairs(official_english[bitnum[i]]) do
			if not args.ui[args.index] then
				args.ui[args.index] = Des.UI.Box.Create()
			end
			args.ui[args.index]:Set({x = args.x + v.x * size + 26 * (i - 1) * size, y = args.y + v.y * size, width = v.width * size, height = v.height * size, a = 255})
			args.ui[args.index]:Set(color)
			
			if align == "center" then
				args.ui[args.index]:Set({x = args.ui[args.index]:Get().x - bits * 26 * size + bits * 26 * size / 2})
			end
			if align == "right" then
				args.ui[args.index]:Set({x = args.ui[args.index]:Get().x - bits * 26 * size})
			end
			
			args.index = args.index + 1
		end
	end
	
	local check = 1
	while args.ui[args.index + check] do
		args.ui[args.index + check]:Set({y = s.h})
		check = check + 1
	end
end

--------------------------------------------------
-- [[                漸變顯示                ]] --
--------------------------------------------------

--[[
	# Made by Destroyertw1207 with Goldfish (Enhanced for table into) #
	
	f_ui_gradient({
		  ui    = UI.Box / UI.Text / CustomUI.X
		, arg   = UI的屬性 (ex. width / height / r / g / b / a / color.a / frameColor.a)
		, add   = 增加的值 (正負數) ※ 與參數 speed 衝突
		, speed = 增加速度 ( 正數 ) ※ 與參數 add 衝突
		, into  = 增加至... (正負數 或 Table) ※非必要
	})
]]

function f_ui_gradient(value)
	if not value then
		return
	end
	
	if value.add then
		value.speed = math.abs(value.add)
		value.add = nil
	end
	
	local function setui(arg)
		local config = value.ui:Get()
		
		local a, b, c, var
		local target_into = value.into -- 預設目標值
		
		-- 解析字串與從 into table 中尋找對應目標值
		if string.find(arg, "%.") then
			a, b = arg:match("(%w+)%.(%w+)")
			if config[a] then
				var = config[a][b]
			end
			-- 如果 into 是 table，試著找 into.color.a 或 into.a (兼容兩種設計)
			if type(value.into) == "table" then
				if value.into[a] and type(value.into[a]) == "table" then
					target_into = value.into[a][b]
				else
					target_into = value.into[b] or value.into[arg]
				end
			end
		else
			c = arg
			var = config[c]
			-- 如果 into 是 table，直接找 into.a
			if type(value.into) == "table" then
				target_into = value.into[c] or value.into[arg]
			end
		end
		
		-- 如果沒找到對應的 into 目標值，且 into 是 table，就代表該屬性不參與漸變
		if type(value.into) == "table" and target_into == nil then
			return
		end
		
		if var then
			if var ~= target_into then
				if value.speed then
					local dt = f_get_deltatime() * 100
					
					local diff
					if target_into then
						diff = target_into - var
					else
						diff = (var + value.speed * dt) - var
					end
					
					-- 防止 diff 為 0 導致除以 0 的錯誤
					if diff ~= 0 then
						local dire = diff / math.abs(diff)
						if dire > 0 then
							var = math.min(var + value.speed * dire * dt, target_into or var + value.speed * dire * dt)
						else
							var = math.max(var + value.speed * dire * dt, target_into or var + value.speed * dire * dt)
						end
					end
				end
				
				local temp = {}
				if c then
					temp[c] = var
					value.ui:Set(temp)
				end
				if a then
					temp[a] = {}
					temp[a][b] = var
					value.ui:Set(temp)
				end
			end
		end
	end
	
	if type(value.arg) == "table" then
		for k, v in pairs(value.arg) do
			setui(v)
		end
	else
		setui(value.arg)
	end
end

--------------------------------------------------
-- [[                對話漸出                ]] --
--------------------------------------------------

function f_getdialoguelen(msg, font)
	local dismantle = {}
	
	-- 預設為 small 的字元寬度
	local width = 25
	local asc_w = 8
	local asc_il_w = 9
	local cht_w = 16
	
	-- 根據傳入的字體大小替換寬度比例
	if font == "medium" then
		width = 40
		asc_w, asc_il_w, cht_w = 16, 18, 33
	elseif font == "large" then
		width = 60
		asc_w, asc_il_w, cht_w = 25, 28, 50
	elseif font == "verylarge" then
		width = 100
		asc_w, asc_il_w, cht_w = 45, 50, 90
	end
	
	local len = #msg
	local i = 1
	while i <= len do
		local byte = string.byte(msg, i)
		local bytecount = 1
		if byte > 0 and byte <= 127 then
			bytecount = 1
			if byte == 105 or byte == 108 then
				width = width + asc_il_w
			else
				width = width + asc_w
			end
		elseif byte >= 192 and byte <= 223 then
			bytecount = 2
		elseif byte >= 224 and byte <= 239 then
			bytecount = 3
			width = width + cht_w
		elseif byte >= 240 and byte <= 247 then
			bytecount = 4
		end
		dismantle[#dismantle + 1] = string.sub(msg, i, i + bytecount - 1)
		i = i + bytecount
	end
	return {width = width, dismantle = dismantle}
end

--[[
	# Original by Goldfish #
]]

function f_dialogue_send(msg, color)
	if Des.UI.Loaded.dialogue then
		if not msg
		or     msg == "" then
			return
		end
		for i = 1, dialogue.count do
			if dialogue.msg[i] == "" then
				dialogue.msg[i] = msg
				dialogue.txt[i]:Set({color = color or {r = 255, g = 255, b = 255}})
				break
			end
		end
	end
end

function f_dialogue_show(i, msg)
	if Des.UI.Loaded.dialogue then
		if msg ~= "" then
			local time = UI.GetTime()
			if dialogue.delay[i] < time then
				dialogue.delay[i] = time + 0.05
				if dialogue.time[i] < time then
					dialogue.index[i] = (dialogue.reverse[i] and dialogue.index[i] - 1 or dialogue.index[i] + 1)
					
					dialogue.remix[i] = ""
					for j = 1, dialogue.index[i] do
						dialogue.remix[i] = dialogue.remix[i] .. f_getdialoguelen(msg).dismantle[j]
					end
					
					if dialogue.reverse[i] then
						dialogue.txt[i]:Set({text = dialogue.remix[i]})
					else
						local input = "|"
						if dialogue.index[i] >= #f_getdialoguelen(msg).dismantle then 
							input = ""
						end
						dialogue.txt[i]:Set({text = dialogue.remix[i] .. input})
					end
					
					local globalx = s.w / 2 - f_getdialoguelen(dialogue.txt[i]:Get().text).width / 2
					local globaly = s.h - 201
					local gtwidth = f_getdialoguelen(dialogue.txt[i]:Get().text).width
					
					for j = 1, 7 do
						dialogue.box[i * 100 + 0 + j]:Set({x = globalx - j * 2, y = globaly + 17 - j * 2 - 50 * (i - 1), width = gtwidth + j * 4})
						dialogue.box[i * 100 + 7 + j]:Set({x = globalx - j * 2, y = globaly + 15 + j * 2 - 50 * (i - 1), width = gtwidth + j * 4})
						if j == 1 then
							dialogue.box[i * 100 + 7 + j]:Set({y = dialogue.box[i * 100 + 7 + j]:Get().y - 1})
						else
							dialogue.box[i * 100 + 7 + j]:Set({y = dialogue.box[i * 100 + 7 + j]:Get().y - 2})
						end
					end
					
					if not dialogue.box[i * 100 + 1]:IsVisible() then
						for j = i * 100 + 1, i * 100 + 14 do
							dialogue.box[j]:Show()
						end
					end
					
					if dialogue.index[i] >= #f_getdialoguelen(msg).dismantle then
						dialogue.reverse[i] = true
						dialogue.time[i] = time + 2.5
					elseif dialogue.index[i] < 0 and dialogue.reverse[i] then
						dialogue.msg[i] = ""
						dialogue.reverse[i] = false
						for j = i * 100 + 1, i * 100 + 14 do
							dialogue.box[j]:Hide()
						end
					end
				end
			end
		end
		if dialogue.msg[i] == "" then
			if dialogue.msg[i + 1] then
				if dialogue.msg[i + 1] ~= "" then
					local s = {
						  ["msg"]     = ""
						, ["index"]   = 0
						, ["time"]    = 0
						, ["reverse"] = false
						, ["remix"]   = false
					}
					for k, v in pairs(s) do
						dialogue[k][i    ] = dialogue[k][i + 1]
						dialogue[k][i + 1] = v
					end
					dialogue.txt[i    ]:Set({text = dialogue.txt[i + 1]:Get().text, color = dialogue.txt[i + 1]:Get().color})
					dialogue.txt[i + 1]:Set({text = ""})
					for j = (i + 1) * 100 + 1, (i + 1) * 100 + 14 do
						dialogue.box[j]:Hide()
					end
					for j = i * 100 + 1, i * 100 + 14 do
						dialogue.box[j]:Show()
					end
					for j = 1, 7 do
						for k = 1, 2 do
							dialogue.box[i * 100 + (k - 1) * 7 + j]:Set({x = dialogue.box[(i + 1) * 100 + (k - 1) * 7 + j]:Get().x, width = dialogue.box[(i + 1) * 100 + (k - 1) * 7 + j]:Get().width})
						end
					end
				end
			end
		end
	end
end

--------------------------------------------------