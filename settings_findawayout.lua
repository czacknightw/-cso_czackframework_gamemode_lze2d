--SETTINGS======================================--
--                [[ 製作名單 ]]                --
--==============================================--
--[[

地圖製作：DestroyerI滅世I // Czack

程式設計：DestroyerI滅世I // Czack

]]--
--==============================================--
--                [[ 讀取確認 ]]                --
--==============================================--

print(string.format("<aaffaa>[%s]settings.lua is loaded.", Des.Mapsys))
log(string.format("<aaffaa>[%s]settings.lua is loaded.", Des.Mapsys))

--==============================================--
--                [[ 常見問題 ]]                --
--==============================================--
--[[

1-Q. 為什麼要把 project.json 放在好幾層資料夾內?
1-A. 這能避免一些作弊者直接修改遊戲進入編輯模式透過 V+8 釋出 Lua Script ( 但不能 100% 避免 )

2-Q. 
2-A. 

]]
--==============================================--
--                [[ 提醒事項 ]]                --
--==============================================--
--[[

使用 Notepad++ 撰寫
大空格用 TAB鍵 會比 SPACE鍵 方便對齊

--------------------------------------------------

--------------------------------------------------

在此寫下你的留言，或是透過其他聯繫管道提出問題。

ex.
想新增的功能?
想修改的功能?
想移除的功能?
BUG?



--------------------------------------------------

--------------------------------------------------



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
	
	tDEVELOPERMODE = {
		bTEXT	= true,												-- 開發者模式啟用狀態顯示
	},
	
	tOPENINGANIMATION = {
		bACTIVE		= true,											-- 開頭動畫啟用與否
		bEDITSKIP	= true,											-- 編輯模式跳過開頭動畫
	},
	
	tWAIT = {
		
		bACTIVE			= true,										-- 等待玩家階段啟用與否
		bEDITSKIP		= true,										-- 編輯模式跳過等待階段
		iMINPLAYERS		= 2,										-- 最少開始人數
		iWAITINGTIME	= 90,										-- 等待階段倒數 ( 當全員準備完成，會剩下 5 秒 )
		
		sMAPNAME		= "LZE - 生死突圍",						-- 地圖名稱
		tPLAYDESC		= {											-- 如何遊玩
			"殭屍大逃殺，但是2.5D視角",
			"以 A/D 移動為主，以 W/S 移動為輔",
			"跳躍時會有額外助力速度，需要特別習慣一下",
			"梯子建議跳躍接觸，面向梯子並且頭部根據仰角改變後利用 W/S 上下爬",
			"攻擊殭屍或殭屍感染人類，需要雙方在相同的 X軸(W/S) 才能成功",
			"",
			"Made by. DestroyerI滅世I ( Czack )",
			"",
			"[ 感謝你的遊玩 ]",
			"[ 如有 BUG、平衡性問題須迭代調適 ]",
		},
		tUPDATEDESC 	= {											-- 更新內容
			string.format("HVC.%X ( %d )", 0, 0),
			"測試。",
			string.format("HVC.%X ( %d )", 1, 1),
			"修正子彈軌跡在遊玩模式沒有顯示的問題。",
			"修正裝彈UI會導致所有人都顯示的問題。",
			"修正中途加入的玩家會因為模型預先重生導致反作弊誤觸發被踢掉的問題。",
			"修正使用裝置 Round Clear/Failed 會導致遊戲異常結束的問題。",
			"修正下一回合第三人稱視角可能不會改變回預設的問題。",
			"修正觸碰紀錄點後死亡重生可能回到出生點的問題。",
			"修正 Z2-4 站對顏色關卡 通過道路不會出現的問題。",
			"微調 Z2-4 站對顏色關卡 速度。 ( 3s >> 5s 爆 )",
			"提高 移動更新頻率。",
			"移除 殭屍跳躍移動加速。",
			string.format("HVC.%X ( %d )", 2, 2),
			"調整 Z1 殭屍門開啟時間 ( 3s >> 5s )。",
			"調整 Z1-1 窄度。",
			"新增 Z1-3 隨機岔路。",
			"調整 Z2 殭屍門開啟時間 ( 3s >> 5s )。",
			"新增 Z2-2 尖刺躲閃關卡 警示燈。",
			string.format("HVC.%X ( %d )", 3, 3),
			"修正 殭屍進度 > 人類進度 +1 沒有結束的問題。",
			"修正 重生時可能回到準備階段重生點的問題。",
			"修正 部分記錄點重生點異常問題。",
			"移除 Z1-E 運輸梯 Lua 推力。",
			"修正 Z1-E2 路線有可能不會切換視角的問題。",
			"調整 Z2 陷阱傷害、移除致死陷阱。",
			"修正 Z2-1 彎路黑牆壁沒有破開的問題。",
			"新增 Z2-1 電梯 Lua 計算推力。",
			"新增 Z2-1 電梯上沙包。",
			"調整 Z2-2 尖刺躲閃關卡 每次下落間隔。 ( 3.5s >> 4.0s )",
			"調整 Z2-2 尖刺躲閃關卡 現在抵達後會關閉裝置。",
			"修正 Z2-4 返回 Z2-3 時，視角不會切換的問題。",
			"修正 Z2-4 殭屍暫停 沒有復原的問題。",
			string.format("HVC.%X ( %d )", 4, 4),
			"修正 重生後會往特定方向推的問題。",
			"修正 玩家退出不會判斷回合結束的問題。",
			"新增 滾輪縮放功能。",
			"調整 Z-1 電梯裝置推力位置。",
			string.format("HVC.%X ( %d )", 5, 5),
			"修正 #reui 的中斷問題。",
			"新增 Z1-2 岩漿區通路。",
			"調整 Z1-E 運輸梯殭屍道路與人類電梯的距離。 ( 靠近 1 格 )",
			"修正 Z2-1 電梯彎路 門可以被打開提前走的問題。",
			"調整 Z2-2 尖刺躲閃關卡 現在過記錄點會延遲 2 秒才觸發機關。",
			"降低 全域殭屍受到僵直與擊退。( 1.0 >> 0.5 )",
			string.format("HVC.%X ( %d )", 6, 6),
			"新增 現在進入 Z2 區會強制感染前面的敢死隊。",
			"調整 Z2-E 電梯速度。 ( 35 >> 25 )",
			"修正 Z2-E 電梯故障 可以從底下鑽到 Z3 的問題。",
			"降低 全域殭屍受到僵直與擊退。( 0.5 >> 0.4 )",
			string.format("HVC.%X ( %d )", 7, 7),
			"修正 中途加入玩家的視角異常問題。",
			"修正 Z2-1 電梯殭屍推力沒有啟用的問題。",
			"調整 Z2-1 電梯彎路開放時間。( 3s >> 5s )",
			"調整 Z2-1 電梯上彎路開放時間。( 3s >> 0s )",
			string.format("HVC.%X ( %d )", 8, 8),
			"調整框架。",
			"現在等待玩家就緒階段不會顯示進度與記分板。",
			"現在中途加入的玩家會直接死亡進入官方觀戰模式。",
			"修正 XZ 平面的跳躍加速度異常問題。",
			string.format("HVC.%X ( %d )", 9, 9),
			"新增 按鍵提示。",
			"修正 使用 #reui 時不會重新取得解析度的問題。",
			"調整 Z1-2 路線。",
			"調整 Z1-3 路線。",
			"新增 Z1-3 斷路。",
			string.format("HVC.%X ( %d )", 10, 10),
			"移除 框架中更快的更新率，嘗試改善人數多的異常卡噸問題。",
			"移除 武器背包。",
			"修正 中途加入的玩家視角異常問題。( Z1-1重新校正觸發 )",
			"調整 Z2-2 尖刺躲閃關卡 第一次尖刺下落時間。( 3.0s >> 3.5s )",
			"調整 Z2-2 尖刺躲閃關卡 每次尖刺下落間隔。( 4.0s >> 4.5s )",
			string.format("HVC.%X ( %d )", 11, 11),
			"修正 重新加入遊戲卡在重生點的問題。",
			"修正 中途加入的玩家視角異常問題。(3)",
			"修正 Z軸的加速度計算問題。",
			"支援 大陸伺服器。",
			"新增 M鍵 書本簡介。",
			"新增 更多劇情對話。",
			string.format("HVC.%X ( %d )", 12, 12),
			"修正 Z2-1 電梯重生點異常問題。",
			"新增 Z1-2 Z1-3 殭屍推力。",
			"降低 殭屍移動速度。 ( *0.95 )",
			string.format("HVC.%X ( %d )", 13, 13),
			"修正 重生後視角異常問題。",
			"修正 簡介按鍵無效問題。",
			"調整 燈光。",
			"新增 區域標題。",
			"調整 Z2-1 捷徑。( 尖刺上新增更廣的玻璃半磚能更好跳 )",
			"調整 Z2-1 上路捷徑地形。( 不須蹲下，可更快協助隊友 )",
			"新增 Z2-3 開門提示綠箭頭與綠燈。",
			"調整 Z2-4 站對顏色關卡的顏色指示。",
			"調整 Z2-4 站對顏色關卡的重生位置與視角觸發位置。",
			string.format("HVC.%X ( %d )", 14, 14),
			"新增 游標實體外框。( 如果能正常運作的話 )",
			"修正 Z2-4 站對顏色關卡視角異常問題。",
			string.format("HVC.%X ( %d )", 15, 15),
			"調整 人類跳躍加速度公式。",
			"調整 殭屍母體血量。( 1000 >> 5000 )",
			"調整 殭屍感染者血量。( 1000 >> 3000 )",
			"新增 劇情對話。",
			"新增 Z1-1 上路平台。",
			"移除 Z1-2 熔岩池死亡方塊。",
			"調整 Z1-2 殭屍路線。",
			"新增 Z1-2 捷徑中間平台。",
			"新增 Z1-2 捷徑尾部平台。",
			"調整 Z2-1 捷徑路線。",
			"補完 Fight a Way Out ( Find a Way Out 2 ) 前路線。",
			string.format("HVC.%X ( %d )", 16, 16),
			"調整 Z2-1 捷徑天花板高度。",
			"新增 提示。",
			string.format("HVC.%X ( %d )", 17, 17),
			"修改 區域標題文字。",
			"新增 更多提示。",
			"新增 簡介中滑水與滑坡的簡易說明。",
			"調整 Z2-2 尖刺躲閃關卡 第一次尖刺下落時間。( 3.5s >> 4.0s )",
			string.format("HVC.%X ( %d )", 18, 18),
			"調整 抽選殭屍母體公式，盡量讓每個人都能當到，且不重複。",
			"修正 Z2-4 站對顏色關卡 地板重置不完全的問題。",
			string.format("HVC.%X ( %d )", 19, 19),
			"修正 中途加入的玩家會在外面變成殭屍的問題。",
			string.format("HVC.%X ( %d )", 20, 20),
			"修正 玩家被弓箭陷阱裝置擊殺不會重生的問題。",
			"調整 Z2-1 上路管子接滑坡地形。",
			"調整 Z2-1 尾部蹲道區地形。",
			
			string.format("HVC.%X ( %d )", 1, 1),
			"修正 抽選為殭屍的立即重進不會重新選為殭屍的問題。",
			"測試版 ( 23天20版 ) 結束。",
		},
	},
	
	tDSG = {
		bACTIVE					= true,								-- 反作弊系統啟用與否
		
		bBANNER_STACKOVERFLOW	= true,								-- 使作弊者遊戲當機
		bBANNER_KICKTOLOBBY		= true,								-- 使作弊者返回大廳
		
		bBANNED_WEAPON_LIST		= {},								-- 作弊武器清單
		
		tSPAWNPASS				= {x = -175, y = -172, z = -3},		-- 檢查玩家是否使用作弊 retry 重新加入遊戲 ※ 需要在地圖上找個地方留 1x1x2 的大小，下面那格放上觸發裝置，填入裝置座標					
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
				infiniteclip = true,
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
	DATA = {
		flTIME_READY = 30,
		flTIME_ROUND = 900,
		
		tBUYCAR = {
			{x = -175, y = -176, z = 2},
			{x = -165, y = -130, z = -23},
		},
		
		tWEAPONBASE_PRIMARY = {
			{x = -191, y = -186, z = 5},
		},
		tWEAPONBASE_SECONDARY = {
			{x = -191, y = -185, z = 5},
		},
		
		tDIALOGUE = {
			"提示：AD空中接觸梯子後，改用 WS 上下。( 抬頭面對梯子 )",
			
			"Z1-2提示：此處人類可直接走中路碎石橋，通過上方按鈕可以破壞橋樑。",
			"Z1-E提示：滑水：空格壓住，順著方向AD，適時通過WS提速。",
			
			"Z2-1提示：走上路可以略過陷阱裝置。",
			"Z2-1提示：滑坡：上滑坡後壓住W，適時點按AD下滑提速。。",
			"Z2-1提示：彎路會比電梯快，記得進行防守。",
			"Z2-2提示：別太著急與貪心，有管子就先跳。",
		},
	}
}

--------------------------------------------------
--                [[ 視角切換 ]]                --
--------------------------------------------------

LZE2D.VIEW = {
	DATA = {
		tDEFAULT = {
			yaw		= 0,
			pitch	= 0,
			mindist	= 350,
			maxdist	= 550,
			plane 	= "YZ",
		}
	},
	
	BLUA = {
		DimViewDefault	= "DimViewDefault",
		SetPlayerView	= "SetPlayerView",
	}
}

--------------------------------------------------
--                [[ 牆壁推力 ]]                --
--------------------------------------------------

LZE2D.WALLPUSH = {
	DATA = {
		
	}
}

--------------------------------------------------
--                [[ 牆壁破壞 ]]                --
--------------------------------------------------

LZE2D.WALLBREAK = {
	DATA = {
		
	}
}

--------------------------------------------------
--                [[ 回合進度 ]]                --
--------------------------------------------------

LZE2D.ROUNDPROGRESS = {
	DATA = {
	
	}
}

--------------------------------------------------
--                [[ 回合結束 ]]                --
--------------------------------------------------

LZE2D.ROUNDEND = {
	DATA = {
		
	}
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
		DimHumanSpawn = "DimHumanSpawn",	-- 定義人類初始重生點	// 參數：(選填)x,y,z
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
		iHOST_SPEED		= 0.95,										-- 母體速率
		iHOST_MODEL		= Des.Sys == Game and Game.MODEL.NORMAL_ZOMBIE_HOST or Des.Game.MODEL.NORMAL_ZOMBIE_HOST,	-- 母體人物模型
		
		iINFECT_HEALTH	= 3000,										-- 感染者血量
		iINFECT_ARMOR	= 100,										-- 感染者護甲
		iINFECT_SPEED	= 0.95,										-- 感染者速率
		iINFECT_MODEL	= Des.Sys == Game and Game.MODEL.NORMAL_ZOMBIE or Des.Game.MODEL.NORMAL_ZOMBIE,			-- 感染者人物模型
		
		flFLINCH	= 0.4,											-- 僵直倍率
		flKNOCKBACK	= 0.4,											-- 擊退倍率
		
		tSPAWNPOINT = {												-- 重生點
			
		},
	},
	
	-- 藍Lua
	BLUA = {
		DimZombieSpawn		= "DimZombieSpawn",					-- 定義殭屍初始重生點	// 參數：(選填)x,y,z
		
		SetZombieFlinch		= "SetZombieFlinch",				-- 設置全體殭屍僵直倍率	// 參數：倍率(0.0~3.0)
		SetZombieKnockback	= "SetZombieKnockback",				-- 設置全體殭屍擊退倍率	// 參數：倍率(0.0~3.0)
	},
}

--------------------------------------------------
--                [[ 觀戰相關 ]]                --
--------------------------------------------------

--[[



]]

LZE2D.SPECTATOR = {
	-- 資料
	DATA = {
		bCUSTOM		= false,						-- 使用自訂模式
		
		tSPAWNPOINT = {x = 0, y = 0, z = 2},		-- 重生點
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
		[1] = {
			title = "Chapter 1",
			subtitle = "沙漠之下的秘密實驗",
		},
		[2] = {
			title = "Chapter 2",
			subtitle = "茶餘飯後的餘興節目",
		},
		[3] = {
			title = "Chapter 3",
			subtitle = "能力與進化的白老鼠",
		},
		[4] = {
			title = "Chapter 4",
			subtitle = "核心過載的轉捩點",
		},
		[5] = {
			title = "Chapter 5",
			subtitle = "破壞與數據備份",
		},
		[6] = {
			title = "Chapter 6",
			subtitle = "設施自我毀滅：FIGHT A WAY OUT",
		},
	}
}

-- language.use = "chn"
if language.use == "chn" then
	LZE2D.ZONETITLE = {
		DATA = {
			[1] = {
				title = "Chapter 1",
				subtitle = "沙漠之下的秘密实验",
			},
			[2] = {
				title = "Chapter 2",
				subtitle = "茶余饭后的余兴节目",
			},
			[3] = {
				title = "Chapter 3",
				subtitle = "能力与进化的白老鼠",
			},
			[4] = {
				title = "Chapter 4",
				subtitle = "核心过载的转捩点",
			},
			[5] = {
				title = "Chapter 5",
				subtitle = "破坏与数据备份",
			},
			[6] = {
				title = "Chapter 6",
				subtitle = "设施自我毁灭：FIGHT A WAY OUT",
			},
		}
	}
end

--------------------------------------------------
--------------------------------------------------

--------------------------------------------------
--                [[ 自訂執行 ]]                --
--------------------------------------------------

LZE2D.CUSEXEC = {
	-- FIND WAY OUT
	-- 重生設置
	[1] = {
		PREZOMBIE = function(self, player)
			-- player.position = {x = -160, y = math.random(-140, -137), z = -10}
			player.position = LZE2D.ZOMBIE.DATA.tSPAWNPOINT[math.random(#LZE2D.ZOMBIE.DATA.tSPAWNPOINT)]
			player.team = Game.TEAM.TR
		end,
		
		__INIT__ = function(self)
			self.RoundZombieLeave = {}
			
			self:__REMOVE_DELEGATE__()
		end,
		
		__RUN__ = function(self)
			self:__ADD_DELEGATE__()
		end,
		
		__DELEGATE__ = {
			Rule_OnRoundStart = function(self)
				self.RoundZombieLeave = {}
				f_addsection("Rule_OnRoundStart", "LZE2D.ZOMBIE", 20, function(context, self)
					if Des.Sync.state.value == 1 then
						LZE2D.ZOMBIE.RoundZombies = LZE2D.ZOMBIE:SELECT()
						for k, v in pairs(LZE2D.ZOMBIE.RoundZombies) do
							self:PREZOMBIE(v)
						end
					end
				end, {self})
			end,
			Rule_OnPlayerDisconnect = function(player, self)
				if player.user.inround then
					if player.team == Game.TEAM.TR then
						table.insert(self.RoundZombieLeave, player.name)
					end
				end
			end,
			Rule_OnPlayerSpawn = function(player, self)
				if player.user.inround then
					if player.team == Game.TEAM.TR then
						self:PREZOMBIE(player)
					else
						-- player.position = {x = math.random(-167, -162), y = math.random(-141, -136), z = 5}
						player.position = LZE2D.HUMAN.DATA.tSPAWNPOINT[math.random(#LZE2D.HUMAN.DATA.tSPAWNPOINT)]
					end
				end
			end,
			Rule_OnPlayerSignal = function(player, signal, self)
				if signal == 0 then
					if Des.Sync.state.value == 1 then
						LZE2D.HUMAN:SET(player)
						
						local pass = false
						
						for k, v in pairs(self.RoundZombieLeave or {}) do
							if player.name == v.name then
								self:PREZOMBIE(player)
								pass = true
								break
							end
						end
						
						if not pass then
							LZE2D.ZOMBIE.RoundZombies = LZE2D.ZOMBIE:SELECT(player)
							for k, v in pairs(LZE2D.ZOMBIE.RoundZombies) do
								if player == v then
									self:PREZOMBIE(player)
									break
								end
							end
						end
						
						if player.team == Game.TEAM.CT then
							-- player.position = {x = math.random(-167, -162), y = math.random(-141, -136), z = 5}
							player.position = LZE2D.HUMAN.DATA.tSPAWNPOINT[math.random(#LZE2D.HUMAN.DATA.tSPAWNPOINT)]
						end
						
					elseif Des.Sync.state.value == 2 then
						
					end
				end
			end,
			
			Rule_OnPlayerUpdate = function(player, time, self)
				if Des.Sync.state.value == 1 then
					if player.user.inround then
						if player.team == Game.TEAM.TR then
							if player.model == Game.MODEL.DEFAULT then
								player.user.__zglow__ = not player.user.__zglow__
								if player.user.__zglow__ then
									player:SetRenderFX(Des.Game.RENDERFX.GLOWSHELL)
									player:SetRenderColor({r = 0, g = 255, b = 0})
								else
									player:SetRenderFX(Des.Game.RENDERFX.LIGHTMULTIPLIER)
									player:SetRenderColor({r = 0, g = 0, b = 0})
								end
							end
						end
					end
				end
			end,
			
			SyncChanged_state = function(new, old, proxy, self)
				if new == 2 then
					for k, v in pairs(LZE2D.ZOMBIE.RoundZombies) do
						v.user.__zglow__ = nil
						
						v:SetRenderFX(Des.Game.RENDERFX.NONE)
						v:SetRenderColor({r = 0, g = 0, b = 0})
					end
				end
			end,
		}
	},
	
	-- Zone2-3 斷路
	[2] = {
		__INIT__ = function(self)
			
		end,
		__RUN__ = function(self)
			for t = 1, 29 do
				LZE2D.__GAMETIMER__:ONCE(string.format("LZE2D.CUSEXEC[2].t%d", t), t / 10, function()
					for i = 1, 3 do
						local posXi = -99 + i - 1
						local posYt = -32 - t + 1
						local posZ = -34
						
						local entityblock = Des.Game.EntityBlock.Create({x = posXi, y = posYt, z = posZ})
						if entityblock then
							entityblock:Event({action = "signal"})
						end
					end
				end)
			end
		end,
		__DELEGATE__ = {
			Rule_OnRoundStart = function(self)
				self:__REMOVE_DELEGATE__()
			end,
		},
	},
	
	-- Zone2-1 射箭陷阱
	[3] = {
		i = 0,
		delay = 0,
		
		__INIT__ = function(self)
			self.EB_BOW = {}
			
			for i = 1, 11 do
				local entityblock = Des.Game.EntityBlock.Create({x = -93 - i + 1, y = 95, z = -52})
				self.EB_BOW[i] = entityblock
			end
		end,
		
		__RUN__ = function(self)
			self.i = 0
			self.delay = 0
		end,
		__DELEGATE__ = {
			Rule_OnRoundStart = function(self)
				self:__REMOVE_DELEGATE__()
			end,
			Rule_OnUpdate = function(time, self)
				if self.delay > time then
					return
				end
				
				if self.i < 11 then
					self.i = self.i + 1
					
					self.EB_BOW[self.i]:Event({action = "signal", value = true})
					self.EB_BOW[self.i]:Event({action = "signal", value = false})
					
					if self.i == 11 then
						self.i = 0
						self.delay = time + 0.5
					end
				end
			end,
		},
	},
	
	-- Zone1-2 斷路
	[4] = {
		__INIT__ = function(self)
			
		end,
		__RUN__ = function(self)
			for t = 1, 33 do
				LZE2D.__GAMETIMER__:ONCE(string.format("LZE2D.CUSEXEC[4].t%d", t), t / 10, function()
					for i = 1, 3 do
						local posXi = -164 - i + 1
						local posYt = -21 + t - 1
						local posZ = -25
						
						local entityblock = Des.Game.EntityBlock.Create({x = posXi, y = posYt, z = posZ})
						if entityblock then
							entityblock:Event({action = "signal"})
						end
					end
				end)
			end
		end,
		__DELEGATE__ = {
			Rule_OnRoundStart = function(self)
				self:__REMOVE_DELEGATE__()
			end,
		},
	},
	
	-- Zone2-2 尖刺躲閃
	[5] = {
		i = 0,
		every = 0,
		delay = 0,
		
		__INIT__ = function(self)
			
		end,
		
		__RUN__ = function(self)
			self.i = 0
			self.every = 0
			self.delay = 0
			
			self.EB_SPIKE_F1 = {}
			self.EB_SPIKE_F2 = {}
			
			for i = 1, 11 do
				local entityblock = Des.Game.EntityBlock.Create({x = -99, y = 20 - 4 * (i - 1), z = -28})
				self.EB_SPIKE_F1[i] = entityblock
				
				local entityblock = Des.Game.EntityBlock.Create({x = -99, y = 20 - 4 * (i - 1), z = -27})
				self.EB_SPIKE_F2[i] = entityblock
			end
		end,
		__DELEGATE__ = {
			Rule_OnRoundStart = function(self)
				self:__REMOVE_DELEGATE__()
			end,
			Rule_OnUpdate = function(time, self)
				if self.delay > time then
					return
				end
				
				if self.every > time then
					return
				end
				self.every = time + 0.3
				
				if self.i < 16 then
					self.i = self.i + 1
					
					-- ====================================================
					-- 1. 前置落石預告 (改成 COUNT 9 次 = 0.9 秒，完美避開 signal)
					-- ====================================================
					
					-- 預判 F1：當前 i 指向的目標，會在 0.9 秒後發射
					local f1_target = self.EB_SPIKE_F1[self.i]
					if f1_target then
						local timer_name = string.format("spike_warning_f1_%d", self.i)
						-- 【關鍵修正】次數改為 9 次！最後一次 reset 在 0.9s，不擋 1.0s 的 signal
						LZE2D.__GAMETIMER__:COUNT(timer_name, 0.1, 9, function()
							f1_target:Event({action = "signal", value = false})
							f1_target:Event({action = "reset"})
						end)
						
						Game.SetTrigger(string.format("spikelight#%d", self.i), true)
					end
					
					-- 預判 F2：i-2 的目標，會在 0.9 秒後發射
					local f2_target_idx = self.i - 2
					if f2_target_idx > 0 and self.EB_SPIKE_F2[f2_target_idx] then
						local f2_target = self.EB_SPIKE_F2[f2_target_idx]
						local timer_name = string.format("spike_warning_f2_%d", f2_target_idx)
						LZE2D.__GAMETIMER__:COUNT(timer_name, 0.1, 9, function()
							f2_target:Event({action = "signal", value = false})
							f2_target:Event({action = "reset"})
						end)
					end
					
					-- ====================================================
					-- 2. 獨立觸發 Signal
					-- ====================================================
					
					-- 觸發 F1 尖刺 (當 i > 3 時，發射 i - 3 的位置)
					local f1_sig_idx = self.i - 3
					if f1_sig_idx > 0 and self.EB_SPIKE_F1[f1_sig_idx] then
						self.EB_SPIKE_F1[f1_sig_idx]:Event({action = "signal"})
						Game.SetTrigger(string.format("spikelight#%d", f1_sig_idx), false)
					end
					
					-- 觸發 F2 尖刺 (當 i > 5 時，發射 i - 5 的位置)
					local f2_sig_idx = self.i - 5
					if f2_sig_idx > 0 and self.EB_SPIKE_F2[f2_sig_idx] then
						self.EB_SPIKE_F2[f2_sig_idx]:Event({action = "signal"})
					end
					
					-- ====================================================
					-- 3. 重置與延遲循環
					-- ====================================================
					if self.i == 16 then
						self.i = 0
						self.delay = time + 4.5
					end
				end
			end,
		},
	},
	
	-- Zone2-4 站對顏色
	[6] = {
		-- 1紅 2黃 3綠 4藍 5白
		ColorsMap = {
			1,3,5,2,4,
			2,4,1,3,5,
			3,5,2,4,1,
			4,1,3,5,2,
			5,2,4,1,3,
		},
		
		color = 0,
		bACTIVE = false,
		bINBREAK = false,
		
		-- 儲存 5x5 的大地板，每個大地板裡面包含 9 個小方塊 (3x3)
		EB_BREAKFLOOR_MAP = {},
		-- 儲存 4 個警告裝置的實體方塊
		EB_WARNINGS = {},
		
		__INIT__ = function(self)
			-- 1. 計算並寫入 5x5 大地板 (包含內部 3x3 小方塊)
			self.EB_BREAKFLOOR_MAP = {}
			for r = 1, 5 do
				self.EB_BREAKFLOOR_MAP[r] = {}
				for c = 1, 5 do
					self.EB_BREAKFLOOR_MAP[r][c] = {}
					
					-- 計算該 3x3 區域的「中心點」
					local centerX = -86 - (c - 1) * 6
					local centerY = -75 - (r - 1) * 6
					local posZ = -34
					
					-- 迴圈抓取 3x3 九個格子
					for dx = -1, 1 do
						for dy = -1, 1 do
							local eb = Des.Game.EntityBlock.Create({x = centerX + dx, y = centerY + dy, z = posZ})
							table.insert(self.EB_BREAKFLOOR_MAP[r][c], eb)
						end
					end
				end
			end
			
			-- 2. 初始化 4 個警告閃爍裝置
			local warn_coords = {
				{x = -106, y = -79, z = -29},
				{x = -91,  y = -79, z = -29},
				{x = -106, y = -94, z = -29},
				{x = -91,  y = -94, z = -29},
			}
			for i, v in ipairs(warn_coords) do
				self.EB_WARNINGS[i] = Des.Game.EntityBlock.Create(v)
			end
		end,
		
		__OFF__ = function(self)
			self.bACTIVE = false
			LZE2D.__GAMETIMER__:STOP("Z2_4_WARNING")
			LZE2D.__GAMETIMER__:STOP("Z2_4_WARN_2")
			LZE2D.__GAMETIMER__:STOP("Z2_4_WARN_1")
			LZE2D.__GAMETIMER__:STOP("Z2_4_DROP")
			LZE2D.__GAMETIMER__:STOP("Z2_4_RESET")
			LZE2D.__GAMETIMER__:STOP("Z2_4_NEXT")
			
			for r = 1, 5 do
				for c = 1, 5 do
					local index = (r - 1) * 5 + c
					local tileColor = self.ColorsMap[index]
					
					-- 迴圈恢復這區塊內的 9 個小方塊
					for _, eb in ipairs(self.EB_BREAKFLOOR_MAP[r][c]) do
						if eb then
							if eb.onoff then
								eb:Event({action = "reset"})
							end
						end
					end
				end
			end
		end,
		
		__RUN__ = function(self)
			self.bACTIVE = true
			self:NEXT_ROUND()
		end,
		
		-- 控制 4 個裝置閃爍次數 (間隔 0.15 秒)
		DO_WARNING = function(self, count)
			if not self.bACTIVE then return end
			for i = 1, 4 do
				if self.EB_WARNINGS[i] then
					self.EB_WARNINGS[i]:Event({action = "reset"})
				end
			end
			LZE2D.__GAMETIMER__:COUNT("Z2_4_WARNING", 0.15, count, function()
				for i = 1, 4 do
					if self.EB_WARNINGS[i] then
						self.EB_WARNINGS[i]:Event({action = "signal"})
					end
				end
			end)
		end,

		-- 小遊戲循環主體
		NEXT_ROUND = function(self)
			if not self.bACTIVE then return end
			
			-- ==========================================
			-- [ 第 0 秒 ]：抽顏色並廣播提示，倒數 5 秒閃 5 下
			-- ==========================================
			self.color = math.random(1, 5)
			Game.SetTrigger(string.format("rightcolor#%d", self.color), true)
			Game.SetTrigger(string.format("rightcolor#%d", self.color), false)
			
			self:DO_WARNING(5)
			
			-- ==========================================
			-- [ 第 1 秒 ]：倒數 4 秒，閃 4 下
			-- ==========================================
			LZE2D.__GAMETIMER__:ONCE("Z2_4_WARN_4", 1.0, function() 
				self:DO_WARNING(4) 
			end)
			
			-- ==========================================
			-- [ 第 2 秒 ]：倒數 3 秒，閃 3 下
			-- ==========================================
			LZE2D.__GAMETIMER__:ONCE("Z2_4_WARN_3", 2.0, function() 
				self:DO_WARNING(3) 
			end)
			
			-- ==========================================
			-- [ 第 3 秒 ]：倒數 2 秒，閃 2 下
			-- ==========================================
			LZE2D.__GAMETIMER__:ONCE("Z2_4_WARN_2", 3.0, function() 
				self:DO_WARNING(2) 
			end)

			-- ==========================================
			-- [ 第 4 秒 ]：倒數 1 秒，閃 1 下
			-- ==========================================
			LZE2D.__GAMETIMER__:ONCE("Z2_4_WARN_1", 4.0, function() 
				self:DO_WARNING(1) 
			end)
			
			-- ==========================================
			-- [ 第 5 秒 ]：不對的顏色執行 Signal (9格一起爆掉)
			-- ==========================================
			LZE2D.__GAMETIMER__:ONCE("Z2_4_DROP", 5.0, function()
				if not self.bACTIVE then return end
				
				for r = 1, 5 do
					for c = 1, 5 do
						-- 【修正】：橫的跟直的相反，所以把索引讀取方式改為 (c-1)*5+r
						local index = (r - 1) * 5 + c
						local tileColor = self.ColorsMap[index]
						
						if tileColor ~= self.color then
							-- 迴圈觸發這區塊內的 9 個小方塊
							for _, eb in ipairs(self.EB_BREAKFLOOR_MAP[c][r]) do
								if eb then
									eb:Event({action = "signal"})
								end
							end
						end
					end
				end
				
				self.bINBREAK = true
				
				Game.SetTrigger("Z2_4_BREAK", true)
			end)
			
			-- ==========================================
			-- [ 第 7 秒 ]：爆掉的地板恢復 (9格一起 Reset) —— 維持爆掉 2 秒後恢復
			-- ==========================================
			LZE2D.__GAMETIMER__:ONCE("Z2_4_RESET", 7.0, function()
				if not self.bACTIVE then return end
				
				for r = 1, 5 do
					for c = 1, 5 do
						local index = (r - 1) * 5 + c
						local tileColor = self.ColorsMap[index]
						
						-- 迴圈恢復這區塊內的 9 個小方塊
						for _, eb in ipairs(self.EB_BREAKFLOOR_MAP[r][c]) do
							if eb then
								if eb.onoff then
									eb:Event({action = "reset"})
								end
							end
						end
					end
				end
				
				self.bINBREAK = false
				
				Game.SetTrigger("Z2_4_BREAK", false)
			end)
			
			-- ==========================================
			-- [ 第 8 秒 ]：休息 1 秒後，進入下一輪抽籤 —— 維持恢復 1 秒後開新一輪
			-- ==========================================
			LZE2D.__GAMETIMER__:ONCE("Z2_4_NEXT", 8.0, function()
				if self.bACTIVE then
					self:NEXT_ROUND()
				end
			end)
		end,
		
		__DELEGATE__ = {
			Rule_OnRoundStart = function(self)
				self:__OFF__()
			end,
			Rule_OnPlayerUpdate = function(player, time, self)
				if self.bACTIVE and self.bINBREAK then
					if player.team == Game.TEAM.CT then
						if player.user.inround then
							if player.position.x >= -117
							and player.position.x <= -79
							and player.position.y >= -70
							and player.position.y <= -68
							and player.position.z >= -33
							and player.position.z <= -31 then
								player.health = 1
								player:Kill()
								player:Respawn()
								player.user.alive = false
								player.user.respawning = true
							end
							
							if player.position.x >= -117
							and player.position.x <= -115
							and player.position.y >= -106
							and player.position.y <= -68
							and player.position.z >= -33
							and player.position.z <= -31 then
								player.health = 1
								player:Kill()
								player:Respawn()
								player.user.alive = false
								player.user.respawning = true
							end
							
							if player.position.x >= -81
							and player.position.x <= -79
							and player.position.y >= -106
							and player.position.y <= -68
							and player.position.z >= -33
							and player.position.z <= -31 then
								player.health = 1
								player:Kill()
								player:Respawn()
								player.user.alive = false
								player.user.respawning = true
							end
						end
					end
				end
			end,
		}
	},
	
	-- Zone2-4 站對顏色 ( 殭屍暫停 )
	[7] = {
		__RUN__ = function(self)
			for k, v in pairs(LZE2D.ZOMBIE:GETPLAYERS()) do
				v.maxspeed = 0.001
			end
			
			LZE2D.__GAMETIMER__:ONCE("Z2_4_ZOMBIE_STUN", 5.0, function()
				for k, v in pairs(LZE2D.ZOMBIE:GETPLAYERS()) do
					v.maxspeed = 1
				end
			end)
		end,
	},
	
	-- Zone1-E 運輸梯
	[8] = {
		__RUN__ = function(self)
			
		end,
		
		__OFF__ = function(self)
			self:__REMOVE_DELEGATE__()
		end,
		
		__DELEGATE__ = {
			Rule_OnRoundStart = function(self)
				self:__OFF__()
			end,
			Rule_OnPlayerUpdate = function(player, time, self)
				if player.team == Game.TEAM.CT then
					if player.position.x >= -157
					and player.position.x <= -113
					and player.position.y >= 148
					and player.position.y <= 158
					and player.position.z == -43 then
						if not player.user.movekey.w
						and not player.user.movekey.s
						and not player.user.movekey.a
						and not player.user.movekey.d
						and player.velocity.z == 0 then
							player.velocity = {x = math.max(player.velocity.x, 75)}
						end
					end
				end
			end,
		},
	},
	
	-- Zone2-1 電梯
	[9] = {
		__RUN__ = function(self)
			self.gettime = Game.GetTime()
		end,
		
		__OFF__ = function(self)
			self.__REMOVE_DELEGATE__()
			
			for k, v in pairs(players) do
				if v then
					if v.user.lobby then
						if v.user.__cusexec9_gravity__ then
							v.gravity = 1
							v.user.__cusexec9_gravity__ = false
						end
					end
				end
			end
		end,
		
		__DELEGATE__ = {
			Rule_OnRoundStart = function(self)
				self:__OFF__()
			end,
			Rule_OnPlayerUpdate = function(player, time, self)
				if player.position.x >= -103
				and player.position.x <= -101
				and player.position.y >= 52
				and player.position.y <= 54
				and player.position.z >= -49 + (time - self.gettime)
				and player.position.z <= -35 then
					player.user.__cusexec9_gravity__ = true
					player.gravity = 0.001
					if player.velocity.z == 0 then
						player.position = {x = player.position.x, y = player.position.y, z = player.position.z + 1}
					end
					player.velocity = {z = 50}
				else
					if player.user.__cusexec9_gravity__ then
						player.gravity = 1
						player.user.__cusexec9_gravity__ = false
					end
				end
			end,
		},
	},
	
	-- Z2 Kill Human
	[10] = {
		__RUN__ = function(self)
			for k, v in pairs(LZE2D.HUMAN:GETPLAYERS()) do
				if v.user.progress < 8 then
					v.health = 1
					v:Kill()
					v:Respawn()
					v.user.alive = false
					v.user.respawning = true
					
					LZE2D.ZOMBIE:SETINFECT(v)
				end
			end
			
			if #LZE2D.HUMAN:GETPLAYERS() <= 0 then
				LZE2D.ROUNDEND:ZOMBIE()
			end
		end,
	},
	
	-- Zone1-3 斷路
	[11] = {
		__INIT__ = function(self)
			
		end,
		__RUN__ = function(self)
			for t = 1, 20 do
				LZE2D.__GAMETIMER__:ONCE(string.format("LZE2D.CUSEXEC[2].t%d", t), t / 10, function()
					local posX = -170
					local posYt = 50 + t - 1
					local posZ = -21
					
					local entityblock = Des.Game.EntityBlock.Create({x = posX, y = posYt, z = posZ})
					if entityblock then
						entityblock:Event({action = "signal"})
					end
				end)
			end
		end,
		__DELEGATE__ = {
			Rule_OnRoundStart = function(self)
				self:__REMOVE_DELEGATE__()
			end,
		},
	},
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