--SETTINGS======================================--
--                [[ 製作名單 ]]                --
--==============================================--
--[[

地圖製作：

程式設計：DestroyerI滅世I // Czack

-- ==============================================================================

-- Project: Czack Framework 26s3.1 (Lua Zombie Escape 2D / LZE2D)
-- Module:  settings.lua
-- Author:  DestroyerI滅世I ( Czack )
-- 
-- [ 創作者使用與維護建議 / Creator Guidelines ]
-- 1. 這是為地圖創作者準備的設定檔，您可以依需求自由調整各項參數。
--    (This configuration file is provided for creators to customize freely.)
-- 2. 為了避免邏輯衝突與遊戲異常，其他核心系統檔（common, system, ui 等）建議盡量保持原樣。
--    (To avoid game-breaking errors, please avoid modifying other core system files.)
-- 
-- [ 疑問與問題修正回報 / Inquiries & Bug Reports ]
-- Gmail: czacknightw@gmail.com | Discord: czktw.1207 | QQ: 3775231711

-- ==============================================================================

]]--
--==============================================--
--                [[ 讀取確認 ]]                --
--==============================================--

print(string.format("<aaffaa>[%s]settings.lua is loaded.", Des.Mapsys))
log(string.format("<aaffaa>[%s]settings.lua is loaded.", Des.Mapsys))

--==============================================--
--                [[ 常見問題 ]]                --
--==============================================--



--==============================================--
--                [[ 提醒事項 ]]                --
--==============================================--
--[[

使用 Notepad++ 撰寫
大空格用 TAB鍵 會比 SPACE鍵 方便對齊

]]
--==============================================--
--                [[ 參考列表 ]]                --
--==============================================--
--[[

透過 Ctrl + F 搜尋

{{ 框架設置 }}

	

{{ 內容設置 }}

	

]]
--==============================================--
--                [[ 框架設置 ]]                --
--==============================================--

__DESYSTEM__ = {
	
	tVERSION	= {
		iNUMBER	= 26080101,											-- 版本號
		bTEXT	= true,												-- 版本號顯示
	},
	
	sLANGUAGE	= "tw",												-- 預設語言 ( tw / en / kr / chn )
	
	tDEVELOPERS = {													-- 開發者名單
		--[[
			
			指令：
			
			#sw
			在編輯模式一人的情況下跳過準備階段
			
			#ss
			跳過階段
			
			#wc
			切換回合結束判斷
			
			#stoptest
			遊玩模式中結束遊戲測試
			
			※ 已移除：
			
			#kill
			#kick
			#kick2
			
		]]
		"DestroyerI滅世I",
	},
	
	tDEVELOPERMODE = {
		bTEXT	= true,												-- 開發者模式啟用狀態顯示
	},
	
	tOPENINGANIMATION = {
		bEDITSKIP	= true,											-- 編輯模式跳過開頭動畫
	},
	
	tWAIT = {
		
		bACTIVE			= true,										-- 等待玩家階段啟用與否
		bEDITSKIP		= true,										-- 編輯模式跳過等待階段
		iMINPLAYERS		= 2,										-- 最少開始人數
		iWAITINGTIME	= 90,										-- 等待階段倒數 ( 當全員準備完成，會剩下 5 秒 )
		
		sMAPNAME		= "Czack's LZE2D",							-- 地圖名稱
		tPLAYDESC		= {											-- 如何遊玩
			"殭屍大逃殺，但是2.5D視角",
			"以 A/D 移動為主，以 W/S 移動為輔",
			"跳躍時會有額外助力速度，需要特別習慣一下",
			"梯子建議跳躍接觸，面向梯子並且頭部根據仰角改變後利用 W/S 上下爬",
			"攻擊殭屍或殭屍感染人類，需要雙方在相同的 X軸(W/S) 才能成功",
			"",
			"Code Made by. DestroyerI滅世I ( Czack )",
		},
		tUPDATEDESC 	= {											-- 更新內容
			string.format("HVC.%X ( %d )", 0, 0),
			"測試。",
		},
	},
	
	tDSG = {
		bACTIVE					= false,							-- 反作弊系統啟用與否
		
		bBANNED_WEAPON_LIST		= {},								-- 作弊武器清單
		
		tSPAWNPASS				= {x = 0, y = 0, z = 0},			-- 檢查玩家是否使用作弊 retry 重新加入遊戲 ※ 需要在地圖上找個地方留 1x1x2 的大小，下面那格放上觸發裝置，填入裝置座標					
	},
	
	tWEAPON = {
		tBUYMENU_LIST			= {
			
			   1, -- 228 緊緻型
			   3, -- SCHMIDT SCOUT
			   5, -- LEONE YG1265 連發散彈槍
			   7, -- 英格倫 MAC-10
			   8, -- BULLPUP
			  10, -- .40 槍神雙槍
			  11, -- ES FIVE-SEVEN
			  12, -- K&M UMP45
			  13, -- KRIEG 550 COMMANDO
			  14, -- IDF 防衛者
			  15, -- Clarion 5.56
			  16, -- K&M .45 戰術手槍
			  17, -- 9X19MM 手槍
			  18, -- 麥格農狙擊槍(AWP)
			  19, -- K&M 衝鋒槍
			  20, -- M249
			  21, -- LEONE 12 GAUGE SUPER
			  22, -- MAVERICK M4A1 卡賓
			  23, -- Schmidt 衝鋒槍
			  24, -- D3/AU-1
			  26, -- 夜鷹 .50C
			  27, -- KRIEG 552
			  28, -- CV-47
			  30, -- ES C90
			  31, -- SCAR（強化版）
			  33, -- XM-8（強化版）
			  35, -- SVD
			  36, -- MP7A1
			  38, -- K1A
			  39, -- USAS12
			  40, -- VSK94
			  41, -- QBB95
			  42, -- SCAR（基本版）
			  43, -- XM-8（基本版）
			4000, -- 小刀
			
		},							-- 預設購物車清單
		
		-- tBUYMENU_LOCK_LIST 	= {},								-- 鎖住設定的武器ID ( 近戰武器、投擲型手榴彈無法使用 )，與 tBUYMENU_UNLOCK_LIST 擇一使用
		-- tBUYMENU_UNLOCK_LIST	= {},								-- 會先將所有武器鎖住，僅解鎖設定的武器ID ( 近戰武器、投擲型手榴彈無法使用 )，與 tBUYMENU_LOCK_LIST 擇一使用
		
		-- 自訂數值 Common.WeaponOption
		tOPTION = {
			[0] = {
				damage			= 1,							-- 傷害倍率 ( 和 Game.Weapon 一起設定時兩者皆會加倍 )
				penetration		= 100,							-- 穿透力倍率
				rangemod		= 1,							-- 依照距離減弱的傷害倍率
				cycletime		= 1,							-- 連發速度倍率
				reloadtime		= 1,							-- 裝彈速度倍率
				accuracy		= 100,							-- 準確度倍率
				spread			= 0,							-- 執行動作時準確度降低程度的倍率
				SetBulletColor	= {r = 255, g = 255, b = 0},	-- 子彈顏色
			},
		},
		
		-- 自訂數值 Game.Weapon
		tSET = {
			[0] = {
				infiniteclip = true,							-- 無限彈藥
			},
		},
	},
}

--==============================================--
--                [[ 內容設置 ]]                --
--==============================================--

--------------------------------------------------
--                [[ 基礎資料 ]]                --
--------------------------------------------------

LZE2D = {
	-- 資料
	DATA = {
		iVERSION					= 1,		-- 版本號
		
		bBREAKABLE					= false,	-- 破壞與否
	},
}

--------------------------------------------------
--                [[ 尚未歸類 ]]                --
--------------------------------------------------

LZE2D.NOCATEGORY = {
	-- 文本
	TEXT = {
		tw = {
			
		},
	},
}

--------------------------------------------------
--                [[ 難度相關 ]]                --
--------------------------------------------------

LZE2D.DIFFICULTY = {
	-- 文本
	TEXT = {
		tw = {
			
		},
	},
	
	-- 資料
	DATA = {
		--[[
			確保 Lua 能讀取世界設定難度資訊，
			
			請在地圖上找個小區域放置：
				裝置控制Script方塊 > 一般殭屍LV.0
				( 殭屍下方 ) 怪物區域觸發方塊A > 函數呼叫Script方塊
				( 觸發下方 ) 擊殺方塊(殭屍)
				
				裝置控制Script方塊：
					Lua呼叫的名稱：difficulty
			
				一般殭屍LV.0：
					[不編輯]
					
				函數呼叫Script方塊：
					欲呼叫的Lua函數名稱：difficulty
					函數中欲傳達的參數：[空]
		]]
		
		bDIFFICULTY_ACTIVE						= false,		-- 啟用難度選項 [ 簡單(=困難) > 普通 > 困難 > 極限 > 地獄 ]
		bDIFFICULTY_OFFICIAL_TAKEDAMAGEBONUS	= false,		-- 怪物(限裝置怪物)血量、怪物攻擊傷害與玩家摔傷等設定是否根據世界設定加倍
		
		fDIFFICULTY_OPTION = function(self, difficulty)			-- 各項難度調整
			if difficulty == Des.Game.DIFFICULTY.EASY then
				
			elseif difficulty == Des.Game.DIFFICULTY.NORMAL then
				
			elseif difficulty == Des.Game.DIFFICULTY.HARD then
				
			elseif difficulty == Des.Game.DIFFICULTY.EXTREME then
				
			elseif difficulty == Des.Game.DIFFICULTY.HELL then
				
			end
		end,
	}
}

--------------------------------------------------
--------------------------------------------------

--------------------------------------------------
--                [[ 系統相關 ]]                --
--------------------------------------------------

LZE2D.SYSTEM = {
	-- 資料
	DATA = {
		flTIME_READY = 30,
		flTIME_ROUND = 900,
		
		tBUYCAR = {
			
		},
		
		tWEAPONBASE_PRIMARY = {
			
		},
		tWEAPONBASE_SECONDARY = {
			
		},
		
		tDIALOGUE = {
			"提示：測試",
		},
	},
	
	-- 藍 Lua
	BLUA = {
		SetReadyTime	= "SetReadyTime",		-- 參數：秒		// 設定準備時間
		SetRoundTime	= "SetRoundTime",		-- 參數：秒		// 設定回合時間
		
		SetBook			= "SetBook",			-- 參數：x,y,z	// 設定簡介書本裝置座標
		SetDialogue		= "SetDialogue",		-- 參數：對話ID	// 顯示 tDIALOGUE 對話
	},
	
	-- 紅 Lua
	RLUA = {
		OnGameStart 	= "LZE2D.OnGameStart",	-- 遊戲開始時觸發
		
		OnReset			= "LZE2D.OnReset",		-- 每回合開始時瞬間觸發 ON OFF			( 用於使用重置裝置 )
		OnRoundStart	= "LZE2D.OnRoundStart",	-- 每回合開始的 0.2 秒瞬間觸發 ON OFF	( 避免被重置 )
		
		OnState			= "OnState/%d",			-- 每階段更新時觸發	( 等待玩家階段 0，準備階段 1，開始階段 2 )
	},
}

--------------------------------------------------
--                [[ 視角切換 ]]                --
--------------------------------------------------

LZE2D.VIEW = {
	-- 資料
	DATA = {
		tDEFAULT = {		-- 預設視角
			yaw		= 0,		-- 偏航角 ( 0 ~ 360 )
			pitch	= 0,		-- 俯仰角 ( 0 ~ 360 )
			mindist	= 350,		-- 最小縮放距離
			maxdist	= 550,		-- 最大縮放距離
			plane 	= "YZ",		-- 移動平面定義 ( "XZ" / "YZ" / "XY" )
		}
	},
	
	-- 藍 Lua
	BLUA = {
		DimViewDefault	= "DimViewDefault",	-- 參數：偏航角,俯仰角,最小縮放距離,最大縮放距離,移動平面定義	// 定義預設視角		( 也可在上面設置 )
		SetPlayerView	= "SetPlayerView",	-- 參數：偏航角,俯仰角,最小縮放距離,最大縮放距離,移動平面定義	// 設定觸發者視角	( 參數留空 = 預設視角 )
	}
}

--------------------------------------------------
--                [[ 牆壁推力 ]]                --
--------------------------------------------------

LZE2D.WALLPUSH = {
	DATA = {
		
	},
	
	BLUA = {
		AddWallPush = "AddWallPush",		-- 參數：x1,y1,z1,x2,y2,z2,推的方向x(-1~1),推的方向y(-1~1),推的方向z(-1~1)	// 牆壁推力	( 不建議使用 )
	},
}

--------------------------------------------------
--                [[ 牆壁破壞 ]]                --
--------------------------------------------------

LZE2D.WALLBREAK = {
	DATA = {
		
	},
	
	BLUA = {
		ChainWallBreak = "ChainWallBreak",	-- 參數：x,y,z	// 以座標點為中心，相鄰且相同的裝置會被串聯觸發，用於觸發破壞牆壁
	},
}

--------------------------------------------------
--                [[ 回合進度 ]]                --
--------------------------------------------------

LZE2D.ROUNDPROGRESS = {
	DATA = {
	
	},
	
	BLUA = {
		ToggleRoundProgress		= "ToggleRoundProgress",	-- 參數：[無]	// 切換永遠顯示玩家進度開關
		
		DimProgressStart		= "DimProgressStart",		-- 參數：[無]	// 定義玩家確認方塊裝置 01 的點 ( 藍Lua放置於正上方 )
		DimProgressEnd			= "DimProgressEnd",			-- 參數：[無]	// 定義玩家確認方塊裝置 20 的點 ( 藍Lua放置於正上方 )
															-- 參數：[無]	// 系統會自動計算 01 ~ 20 座標之間的所有玩家確認方塊裝置位置
		
		SetPlayerRoundProgress	= "SetPlayerRoundProgress",	-- 參數：1~20	// 設定玩家進度點
	},
}

--------------------------------------------------
--                [[ 回合結束 ]]                --
--------------------------------------------------

LZE2D.ROUNDEND = {
	DATA = {
		
	},
	
	BLUA = {
		TriggerRoundEnd = "TriggerRoundEnd",	-- 參數：觸發座標x,y,z	// 觸發回合勝利，檢查觸發隊伍，如果是殭屍直接讓殭屍勝利
		SetHumanWin		= "SetHumanWin",		-- 參數：觸發座標x,y,z	// 觸發人類勝利
	},
}

--------------------------------------------------
--                [[ 裝填提示 ]]                --
--------------------------------------------------

LZE2D.WEAPONRELOAD = {
	DATA = {
		
	},
}

--------------------------------------------------
--                [[ 人類相關 ]]                --
--------------------------------------------------

LZE2D.HUMAN = {
	-- 資料
	DATA = {
		iHEALTH		= 1000,					-- 血量
		iARMOR		= 100,					-- 護甲
		iSPEED		= 1,					-- 速率
		
		tSPAWNPOINT = {						-- 重生點
			
		},
	},
	
	-- 藍Lua
	BLUA = {
		DimHumanSpawn		= "DimHumanSpawn",		-- 定義人類初始重生點	// 參數：(選填)x,y,z	( 也可在上面設置 )
		
		DimHumanHealth		= "DimHumanHealth",		-- 定義人類最大血量		// 參數：*血量數值		( 也可在上面設置 )
		DimHumanArmor		= "DimHumanArmor",		-- 定義人類最大護甲		// 參數：*護甲數值		( 也可在上面設置 )
		DimHumanSpeedRate	= "DimHumanSpeedRate",	-- 定義人類速度倍率		// 參數：*速度倍率		( 也可在上面設置 )
	}
}

--------------------------------------------------
--                [[ 殭屍相關 ]]                --
--------------------------------------------------

LZE2D.ZOMBIE = {
	-- 資料
	DATA = {
		tSELECT = {													-- 定義殭屍抽選數量 ( <人數，抽選數 )
			{ 5, 1},													-- 1~4位玩家時，抽出1位殭屍
			{ 9, 2},													-- 5~8位玩家時，抽出2位殭屍
			{13, 3},
			{17, 4},
			{25, 5},
			{33, 6},
		},
		
		iHOST_HEALTH	= 5000,										-- 母體血量
		iHOST_ARMOR		= 100,										-- 母體護甲
		iHOST_SPEED		= 1,										-- 母體速率
		iHOST_MODEL		= Des.Sys == Game and Game.MODEL.NORMAL_ZOMBIE_HOST or Des.Game.MODEL.NORMAL_ZOMBIE_HOST,	-- 母體人物模型
		
		iINFECT_HEALTH	= 3000,										-- 感染者血量
		iINFECT_ARMOR	= 100,										-- 感染者護甲
		iINFECT_SPEED	= 1,										-- 感染者速率
		iINFECT_MODEL	= Des.Sys == Game and Game.MODEL.NORMAL_ZOMBIE or Des.Game.MODEL.NORMAL_ZOMBIE,				-- 感染者人物模型
		
		flFLINCH	= 1.0,											-- 僵直倍率 ( 0.0 ~ 3.0 )
		flKNOCKBACK	= 1.0,											-- 擊退倍率 ( 0.0 ~ 3.0 )
		
		tSPAWNPOINT = {												-- 重生點
			
		},
	},
	
	-- 藍Lua
	BLUA = {
		DimZombieSpawn				= "DimZombieSpawn",					-- 定義殭屍初始重生點			// 參數：(選填)x,y,z			( 也可在上面設置 )
		
		DimZombieHostHealth			= "DimZombieHostHealth",			-- 定義殭屍母體最大血量			// 參數：*血量數值				( 也可在上面設置 )
		DimZombieHostArmor			= "DimZombieHostArmor",				-- 定義殭屍母體最大護甲			// 參數：*護甲數值				( 也可在上面設置 )
		DimZombieHostSpeedRate		= "DimZombieHostSpeedRate",			-- 定義殭屍母體速度倍率			// 參數：*速度倍率				( 也可在上面設置 )
		DimZombieHostModel			= "DimZombieHostModel",				-- 定義殭屍母體模型				// 參數：*API:Game.MODEL.XXX	( 也可在上面設置 )
		
		DimZombieInfectHealth		= "DimZombieInfectHealth",			-- 定義殭屍感染者最大血量		// 參數：*血量數值				( 也可在上面設置 )
		DimZombieInfectArmor		= "DimZombieInfectArmor",			-- 定義殭屍感染者最大護甲		// 參數：*護甲數值				( 也可在上面設置 )
		DimZombieInfectSpeedRate	= "DimZombieInfectSpeedRate",		-- 定義殭屍感染者速度倍率		// 參數：*速度倍率				( 也可在上面設置 )
		DimZombieInfectModel		= "DimZombieInfectModel",			-- 定義殭屍感染者模型			// 參數：*API:Game.MODEL.XXX	( 也可在上面設置 )
		
		DimZombieFlinch				= "DimZombieFlinch",				-- 定義全體殭屍受到僵直倍率		// 參數：倍率 ( 0.0 ~ 3.0 )
		DimZombieKnockback			= "DimZombieKnockback",				-- 定義全體殭屍受到擊退倍率		// 參數：倍率 ( 0.0 ~ 3.0 )
		
		SetTriggerZombieFlinch		= "SetTriggerZombieFlinch",			-- 設定觸發者(殭屍)受到僵直倍率	// 參數：倍率 ( 0.0 ~ 3.0 )
		SetTriggerZombieKnockback	= "SetTriggerZombieKnockback",		-- 設定觸發者(殭屍)受到擊退倍率	// 參數：倍率 ( 0.0 ~ 3.0 )
	},
}

--------------------------------------------------
--                [[ 觀戰相關 ]]                --
--------------------------------------------------

--[[

	不建議使用

]]

LZE2D.SPECTATOR = {
	-- 資料
	DATA = {
		bCUSTOM		= false,						-- 使用自訂模式 ( 不建議開啟 )
		
		tSPAWNPOINT = {x = 0, y = 0, z = 0},		-- 重生點
	},
	
	-- 藍Lua
	BLUA = {
		DimSpectatorSpawn = "DimSpectatorSpawn",	-- 定義觀戰者初始重生點
	},
}

--------------------------------------------------
--                [[ 區域標題 ]]                --
--------------------------------------------------

LZE2D.ZONETITLE = {
	DATA = {
		--[[
		[1] = {
			title = "Title: Chapter 1",
			subtitle = "副標題：章節 1",
		},
		[2] = {
			title = "Title: Chapter 2",
			subtitle = "副標題：章節 2",
		},
		]]
	},
	
	BLUA = {
		ShowZoneTitle = "ShowZoneTitle",	-- 參數：區域標題ID	// 顯示區域標題
	},
}

--------------------------------------------------
--------------------------------------------------

--------------------------------------------------
--                [[ 自訂執行 ]]                --
--------------------------------------------------

LZE2D.CUSEXEC = {
	
}

--------------------------------------------------
--                 [[ 藍 Lua ]]                 --
--------------------------------------------------

-- 其他自訂義藍 Lua

LZE2D.BLUA = {
	CAMERA			= "CameraUI",		-- 參數：座標X,Y,Z // 在使用官方攝影機裝置時也能顯示 UI ( ※ 此功能會讓所有玩家強制重生與清除武器 )
	ENTITYTRIGGER	= "EntityTrigger",	-- 參數：座標X,Y,Z // (讓觸發者)觸發指定座標裝置
	ENTITYRESET		= "EntityReset",	-- 參數：座標X,Y,Z // 重置指定座標裝置
}

--------------------------------------------------
--                [[ 按鍵相關 ]]                --
--------------------------------------------------

-- 其他自訂義按鍵

LZE2D.KEYBIND = {
	
}

--------------------------------------------------
--                [[ 指令相關 ]]                --
--------------------------------------------------

-- 其他自訂義指令

LZE2D.COMMAND = {
	
}

--------------------------------------------------