--COMMON========================================--
--                [[ 製作名單 ]]                --
--==============================================--
--[[

地圖製作：

程式設計：DestroyerI滅世I ( Czack )

-- ==============================================================================

-- Project: Czack Framework 26s3.1 (Lua Zombie Escape 2D / LZE2D)
-- Module:  common.lua
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
-- [[                模組設定                ]] --
--==============================================--

DESYSTEM = {}

Des = {
	  Sys = Game or UI
	
	, Game = {
		  RENDERFX = {
			  NONE				= 0
			, PULSESLOW			= 1
			, PULSEFAST			= 2
			, PULSESLOWWIDE		= 3
			, PULSEFASTWIDE		= 4
			, FADESLOW			= 5
			, FADEFAST			= 6
			, SOLIDSLOW			= 7
			, SOLIDFAST			= 8
			, STROBESLOW		= 9
			, STROBEFAST		= 10
			, STROBEFASTER		= 11
			, FLICKERSLOW		= 12
			, FLICKERFAST		= 13
			, NODISSIPATION		= 14
			, DISTORT			= 15
			, HOLOGRAM			= 16
			, DEADPLAYER		= 17
			, EXPLODE			= 18
			, GLOWSHELL			= 19
			, CLAMPMINSCALE		= 20
			, LIGHTMULTIPLIER	= 21
		}
		, MONSTERTYPE = {
			  NORMAL0				= {ID = 246 , NAME = "一般殭屍LV.0"     , SPEED =  40}
			, NORMAL1				= {ID = 200 , NAME = "一般殭屍LV.1"     , SPEED =  40}
			, NORMAL2				= {ID = 201 , NAME = "一般殭屍LV.2"     , SPEED =  50}
			, NORMAL3				= {ID = 202 , NAME = "一般殭屍LV.3"     , SPEED =  60}
			, NORMAL4				= {ID = 203 , NAME = "一般殭屍LV.4"     , SPEED =  70}
			, NORMAL5				= {ID = 204 , NAME = "一般殭屍LV.5"     , SPEED =  80}
			, NORMAL6				= {ID = 205 , NAME = "一般殭屍LV.6"     , SPEED =  80}
			, RUNNER0				= {ID = 247 , NAME = "奔跑殭屍LV.0"     , SPEED = 250}
			, RUNNER1				= {ID = 206 , NAME = "奔跑殭屍LV.1"     , SPEED = 260}
			, RUNNER2				= {ID = 207 , NAME = "奔跑殭屍LV.2"     , SPEED = 270}
			, RUNNER3				= {ID = 208 , NAME = "奔跑殭屍LV.3"     , SPEED = 280}
			, RUNNER4				= {ID = 209 , NAME = "奔跑殭屍LV.4"     , SPEED = 290}
			, RUNNER5				= {ID = 210 , NAME = "奔跑殭屍LV.5"     , SPEED = 280}
			, RUNNER6				= {ID = 211 , NAME = "奔跑殭屍LV.6"     , SPEED = 290}
			, HEAVY1				= {ID = 244 , NAME = "重甲殭屍LV.1"     , SPEED =  80}
			, HEAVY2				= {ID = 245 , NAME = "重甲殭屍LV.2"     , SPEED =  65}
			, MUSHROOM1				= {ID = 248 , NAME = "菇菇寶貝"         , SPEED =  40}
			, MUSHROOM2				= {ID = 249 , NAME = "小路菇菇"         , SPEED = 100}
			, MUSHROOM3				= {ID = 250 , NAME = "刺菇菇"           , SPEED = 100}
			, SLIME1				= {ID = 251 , NAME = "水精靈"           , SPEED = 150}
			, SLIME2				= {ID = 687 , NAME = "綠精靈"           , SPEED =  50}
			, CHINASOLDIER1			= {ID = 688 , NAME = "黃巾兵"           , SPEED = 250}
			, CHINASOLDIER2			= {ID = 689 , NAME = "黃巾將領"         , SPEED = 250}
			, SNOWMAN				= {ID = 763 , NAME = "雪人"             , SPEED = 200}
			, MINION1				= {ID = 940 , NAME = "赫克特(紅)"       , SPEED = 250}
			, MINION2				= {ID = 941 , NAME = "赫克特(藍)"       , SPEED = 220}
			, HOOLIGANMELEE1		= {ID = 1097, NAME = "球迷騷亂A"        , SPEED = 220}
			, HOOLIGANMELEE2		= {ID = 1098, NAME = "球迷騷亂B"        , SPEED = 200}
			, GHOST					= {ID = 1284, NAME = "布袋幽靈"         , SPEED = 300}
			, PUMPKIN				= {ID = 1285, NAME = "南瓜頭稻草人"     , SPEED = 250}
			, PUMPKINHEAD			= {ID = 1286, NAME = "南瓜頭"           , SPEED = 150}
			, ZBS_BOSSL_BIG1		= {ID = 1289, NAME = "巨獸雷比亞"       , SPEED = 250}
			, A101AR				= {ID = 1477, NAME = "步槍機器人"       , SPEED = 200}
			, A104RL				= {ID = 1478, NAME = "飛彈機器人"       , SPEED = 200}
			, GASTURRET				= {ID = 1509, NAME = "殭屍毒氣塔"       , SPEED =  40}
			, SHELTERNORMAL			= {ID = 1520, NAME = "投擲殭屍"         , SPEED =   0}
			, SHELTERRUNNER			= {ID = 1521, NAME = "自爆殭屍"         , SPEED = 210}
			, KINGZOMBIE			= {ID = 1650, NAME = "君主殭屍"         , SPEED =  80}
			, KINGDOMZOMBIE1		= {ID = 1651, NAME = "朝鮮男性殭屍 LV.1", SPEED = 260}
			, KINGDOMZOMBIE2		= {ID = 1652, NAME = "朝鮮男性殭屍 LV.2", SPEED = 270}
			, KINGDOMZOMBIE3		= {ID = 1653, NAME = "朝鮮女性殭屍 LV.1", SPEED = 260}
			, BOSS_AMPSUIT			= {ID = 1950, NAME = "機甲魁儡"         , SPEED = 250}
			, BOSS_INFECTEDTITAN	= {ID = 1951, NAME = "奧茲"             , SPEED = 250}
		}
		, WEAPONTYPE = {
			  NONE			= {ID = 0, NAME = "未知"}
			, KNIFE			= {ID = 1, NAME = "近戰武器"}
			, PISTOL		= {ID = 2, NAME = "手槍"}
			, GRENADE		= {ID = 3, NAME = "手榴彈"}
			, SUBMACHINEGUN	= {ID = 4, NAME = "衝鋒槍"}
			, SHOTGUN		= {ID = 5, NAME = "散彈槍"}
			, MACHINEGUN	= {ID = 6, NAME = "機槍"}
			, RIFLE			= {ID = 7, NAME = "步槍"}
			, SNIPERRIFLE	= {ID = 8, NAME = "狙擊槍"}
			, EQUIPMENT		= {ID = 9, NAME = "裝備"}
		}
		, WEAPONCOLOR = {
			  NONE		= {ID = 0, NAME = "無顏色", COLOR = {r = 255, g = 255, b = 255}}
			, GREEN		= {ID = 1, NAME = "綠色"  , COLOR = {r =   0, g = 255, b =   0}}
			, WHITE		= {ID = 2, NAME = "白色"  , COLOR = {r = 255, g = 255, b = 255}}
			, RED		= {ID = 3, NAME = "紅色"  , COLOR = {r = 255, g =   0, b =   0}}
			, BLUE		= {ID = 4, NAME = "藍色"  , COLOR = {r = 100, g = 100, b = 255}}
			, YELLOW	= {ID = 5, NAME = "黃色"  , COLOR = {r = 255, g = 255, b =   0}}
			, ORANGE	= {ID = 6, NAME = "橘色"  , COLOR = {r = 255, g =  97, b =   0}}
		}
		, DIFFICULTY = {
			NORMAL	= 0,
			
			EASY	= 1,
			HARD	= 2,
			EXTREME	= 3,
			HELL	= 4,
		}
		, MODEL = {
			DEFAULT					= 0,	
			SEAL					= 1,	-- 美國第六海豹特遣隊
			GSG9					= 2,	-- 德國第九國境防衛隊
			GIGN					= 3,	-- 法國憲兵特勤隊
			SAS						= 4,	-- 英國皇家特種空勤隊
			SPETSNAZ				= 5,	-- 俄羅斯特種部隊
			GUERILLA				= 6,	-- 中東武裝游擊部隊
			PHOENIX					= 7,	-- 東歐鳳凰武裝組織
			ELITE					= 8,	-- 中東精銳武裝份子
			ARCTIC					= 9,	-- 瑞典北極復仇者
			MILITIA					= 10,	-- 美國中西部城市傭兵
			HERO					= 11,	-- 男性英雄
			HEROINE					= 12,	-- 女性英雄
			NORMAL_ZOMBIE			= 13,	-- 一般殭屍
			LIGHT_ZOMBIE			= 14,	-- 莎拉
			HEAVY_ZOMBIE			= 15,	-- 達叔
			PHYCHO_ZOMBIE			= 16,	-- 法蘭克
			VOODOO_ZOMBIE			= 17,	-- 庫卡
			DEIMOS_ZOMBIE			= 18,	-- 雷比亞進化體
			GANYMEDE_ZOMBIE			= 19,	-- 殘暴雷比亞
			STAMPER_ZOMBIE			= 20,	-- 薩旦
			BANSHEE_ZOMBIE			= 21,	-- 笆蒂
			VENOMGUARD_ZOMBIE		= 22,	-- 保羅獄長
			STINGFINGER_ZOMBIE		= 23,	-- 血腥瑪麗
			METATRON_ZOMBIE			= 24,	-- 阿基里斯
			LILITH_ZOMBIE			= 25,	-- 鬼步伊西斯
			CHASER_ZOMBIE			= 26,	-- 機械女娃
			BLOTTER_ZOMBIE			= 27,	-- 黑闇哥德
			RUSTYWING_ZOMBIE		= 28,	-- 魅魔莉麗絲
			AKSHA_ZOMBIE			= 29,	-- 魔神蚩尤
			SOLDIER_ZOMBIE			= 30,	-- 雷恩
			FIST_ZOMBIE				= 31,	-- FIST
			NORMAL_ZOMBIE_HOST		= 32,	-- 一般殭屍(王)
			LIGHT_ZOMBIE_HOST		= 33,	-- 莎拉(王)
			HEAVY_ZOMBIE_HOST		= 34,	-- 達叔(王)
			PHYCHO_ZOMBIE_HOST		= 35,	-- 法蘭克(王)
			VOODOO_ZOMBIE_HOST		= 36,	-- 庫卡(王)
			DEIMOS_ZOMBIE_HOST		= 37,	-- 雷比亞進化體(王)
			GANYMEDE_ZOMBIE_HOST	= 38,	-- 殘暴雷比亞(王)
			STAMPER_ZOMBIE_HOST		= 39,	-- 薩旦(王)
			BANSHEE_ZOMBIE_HOST		= 40,	-- 笆蒂(王)
			VENOMGUARD_ZOMBIE_HOST	= 41,	-- 保羅獄長(王)
			STINGFINGER_ZOMBIE_HOST	= 42,	-- 血腥瑪麗(王)
			METATRON_ZOMBIE_HOST	= 43,	-- 阿基里斯(王)
			LILITH_ZOMBIE_HOST		= 44,	-- 鬼步伊西斯(王)
			CHASER_ZOMBIE_HOST		= 45,	-- 機械女娃(王)
			BLOTTER_ZOMBIE_HOST		= 46,	-- 黑闇哥德(王)
			RUSTYWING_ZOMBIE_HOST	= 47,	-- 魅魔莉麗絲(王)
			AKSHA_ZOMBIE_HOST		= 48,	-- 魔神蚩尤(王)
			SOLDIER_ZOMBIE_HOST		= 49,	-- 雷恩(王)
			FIST_ZOMBIE_HOST		= 50,	-- FIST(王)
		}
		
		, Rule = {
			  Load = {}
			, Api = {
				  OnPlayerConnect      = {["params"] = {"player"}, ["return"] = {}}
				, OnPlayerDisconnect   = {["params"] = {"player"}, ["return"] = {}}
				, OnRoundStart         = {["params"] = {}, ["return"] = {}}
				, OnRoundStartFinished = {["params"] = {}, ["return"] = {}}
				, OnPlayerSpawn        = {["params"] = {"player"}, ["return"] = {}}
				, OnPlayerJoiningSpawn = {["params"] = {"player"}, ["return"] = {}}
				, OnPlayerKilled       = {["params"] = {"victim", "killer", "weapontype", "hitbox"}, ["return"] = {}}
				, OnKilled             = {["params"] = {"victim", "killer"}, ["return"] = {}}
				, OnPlayerSignal       = {["params"] = {"player", "signal"}, ["return"] = {}}
				, OnUpdate             = {["params"] = {"time"}, ["return"] = {}}
				, OnPlayerAttack       = {["params"] = {"victim", "attacker", "damage", "weapontype", "hitbox"}, ["return"] = {"damage"}}
				, OnTakeDamage         = {["params"] = {"victim", "attacker", "damage", "weapontype", "hitbox"}, ["return"] = {"damage"}}
				, CanBuyWeapon         = {["params"] = {"player", "weaponid"}, ["return"] = {"[boolean]"}}
				, CanHaveWeaponInHand  = {["params"] = {"player", "weaponid", "weapon"}, ["return"] = {"[boolean]"}}
				, OnGetWeapon          = {["params"] = {"player", "weaponid", "weapon"}, ["return"] = {"[boolean]"}}
				, OnSwitchWeapon       = {["params"] = {"player"}, ["return"] = {}}
				, OnDeployWeapon       = {["params"] = {"player", "weapon"}, ["return"] = {}}
				, OnReload             = {["params"] = {"player", "weapon", "time"}, ["return"] = {}}
				, OnReloadFinished     = {["params"] = {"player", "weapon"}, ["return"] = {}}
				, PostFireWeapon       = {["params"] = {"player", "weapon", "time"}, ["return"] = {}}
				, OnGameSave           = {["params"] = {"player"}, ["return"] = {}}
				, OnLoadGameSave       = {["params"] = {"player"}, ["return"] = {}}
				, OnClearGameSave      = {["params"] = {"player"}, ["return"] = {}}
				, OnReceiveGameSave    = {["params"] = {"player"}, ["return"] = {}}
			}
			
			, Custom = {
				
			}
		}
		, EntityBlock = {
			  Data = {}
			, Create = function() end
		}
		
		, Monster = {}
		, Blua = {
			ADD = function() end
		}
		
		, Delegate = {}
		, Section = {}
	}
	
	, UI = {
		  DirNowCount  = 0
		, DirLoadTime  = 0
		, DirLoadDelay = 0
		
		, PreNowCount  = 0
		, PreLoadTime  = 0
		, PreLoadDelay = 0
		
		, DirWaitLoad  = {}
		, DirLoad      = {}
		, PreWaitLoad  = {}
		, PreLoad      = {}
		, Load         = {}
		, Loaded       = {}
		
		, Frame        = {}
		, Hollow       = {}
		, Gradient     = {}
		, Pixel        = {
			Letter = {}
		}
		, Cnsv         = {
			  Supptext = {}
			, Regitext = {}
		}
		
		, Box          = {}
		, Text         = {}
		, Event        = {
			  Load = {}
			, Api = {
				  OnRoundStart = {["params"] = {}, ["return"] = {}}
				, OnSpawn      = {["params"] = {}, ["return"] = {}}
				, OnKilled     = {["params"] = {}, ["return"] = {}}
				, OnInput      = {["params"] = {"inputs"}, ["return"] = {}}
				, OnUpdate     = {["params"] = {"time"}, ["return"] = {}}
				, OnChat       = {["params"] = {"msg"}, ["return"] = {}}
				, OnSignal     = {["params"] = {"signal"}, ["return"] = {}}
				, OnKeyDown    = {["params"] = {"inputs"}, ["return"] = {}}
				, OnKeyUp      = {["params"] = {"inputs"}, ["return"] = {}}
			}
			, Custom = {
				
			}
		}
		, Max1024      = {
			  All = {
				  Box  = {}
				, Text = {}
			}
			, Using    = {
				  Box  = {}
				, Text = {}
			}
			
			, Unusing  = {
				  Box  = {}
				, Text = {}
			}
			
		}
		
		, Delegate = {}
		, Section = {}
	}
	
	, Common = {
		SetWeaponOptionCompleted = {}
	}

	, Dsg = {}
	, Error = {}
	, Batch = {}
	, Loadedrun = {
		  ["game.lua"] = {}
		, ["ui.face.lua"] = {}
		, ["ui.func.lua"] = {}
	}
}

if Des.Sys == UI then
	-- 補齊 Game 資料
	Game = {
		MONSTERTYPE = {},
		RENDERFX = Des.Game.RENDERFX,
		WEAPONTYPE = Des.Game.WEAPONTYPE,
		WEAPONCOLOR = {},
		
		SetTrigger = function() end,
	}
	
	for k, v in pairs(Des.Game.MONSTERTYPE) do
		Game.MONSTERTYPE[k] = v.ID
	end
	
	for k, v in pairs(Des.Game.WEAPONCOLOR) do
		Game.WEAPONCOLOR[k] = v.color
	end
end

--==============================================--
-- [[                遊戲版本                ]] --
--==============================================--

Des.Version = {
	  phase  = "publicbeta"
	, number = 20
	, phasecht = {
		  ["releaseyet"] = "尚未釋出"
		, ["pre-alpha"]  = "阿爾法前"
		, ["alpha"]      = "阿爾法"
		, ["closedbeta"] = "封測"
		, ["publicbeta"] = "公測"
		, ["beta"]       = "貝塔"
		, ["official"]   = "正式版"
	}
}

Des.Mapsys = "#lze2d"

-- releaseyet
-- pre-alpha
-- alpha
-- beta
-- official

--==============================================--
--                [[ 讀取確認 ]]                --
--==============================================--

print(string.format("<aaffaa>[%s]common.lua is loaded.", Des.Mapsys))
log(string.format("<aaffaa>[%s]common.lua is loaded.", Des.Mapsys))

--==============================================--
-- [[                地圖配置                ]] --
--==============================================--

--[[ 使用武器背包 ]] Common.UseWeaponInven             	(  true )
--[[ 目前武器儲存 ]] Common.SetSaveCurrentWeapons      	(  true )
--[[ 背包武器儲存 ]] Common.SetSaveWeaponInven         	(  true )
--[[ 自動讀取存檔 ]] Common.SetAutoLoad                	( false )
--[[ 關閉武器部件 ]] Common.DisableWeaponParts         	(  true )
--[[ 關閉武器強化 ]] Common.DisableWeaponEnhance       	(  true )
--[[ 關閉開場武器 ]] Common.DontGiveDefaultItems       	(  true )
--[[ 隊友團隊攻擊 ]] Common.DontCheckTeamKill          	(  true )
--[[ 災厄之章商店 ]] Common.UseScenarioBuymenu         	(  true )
--[[ 購買需要金錢 ]] Common.SetNeedMoney               	( false )
--[[ 新型槍口效果 ]] Common.UseAdvancedMuzzle          	(  true )
--[[ 槍口效果大小 ]] Common.SetMuzzleScale             	(   2.0 )
--[[ 攻擊噴血效果 ]] Common.SetBloodScale              	(   2.0 )
--[[ 射到牆壁效果 ]] Common.SetGunsparkScale           	(   1.0 )
--[[ 修正準心大小 ]] Common.SetHitboxScale             	(   5.0 )
--[[ 主武彈匣價格 ]] Common.SetUnitedPrimaryAmmoPrice  	(   0   )
--[[ 副武彈匣價格 ]] Common.SetUnitedSecondaryAmmoPrice	(   0   )
--[[ 游標實體外框 ]] Common.SetMouseoverOutline			(  true, {r = 255, g = 0, b = 0})

--==============================================--
--                [[ 購買清單 ]]                --
--==============================================--

Common.SetBuymenuWeaponList({
	0
})

--[[
for i = 1, 5000 do
	local option = Common.GetWeaponOption(i)
	if option then
		option.damage		= 1								-- 傷害倍率 ( 和 Game.Weapon 一起設定時兩者皆會加倍 )
		option.penetration	= 100							-- 穿透力倍率
		option.rangemod		= 1								-- 依照距離減弱的傷害倍率
		option.cycletime	= 1								-- 連發速度倍率
		option.reloadtime	= 1								-- 裝彈速度倍率
		option.accuracy		= 100							-- 準確度倍率
		option.spread		= 0								-- 執行動作時準確度降低程度的倍率
		option:SetBulletColor({r = 255, g = 255, b = 0})
	end
end
]]

--==============================================--
-- [[                變數宣告                ]] --
--==============================================--

language = {
	  use = "tw"
	
	, badreason = {
		  [0] = {
			  tw = "【警告】玩家「%s」因先前違規紀錄而無法加入遊戲，將再次踢除。"
			, en = "[WARNING] Player \"%s\" cannot join the game due to previous violations and will be kicked again."
		}
		, [1] = {
			  tw = "【警告】玩家「%s」以不正當手段獲得武器。 ( #%s )"
			, en = "[WARNING] Player \"%s\" has acquired weapons through improper means. (#%s)"
			, chn = "玩家 %s 使用不当武器"
		}
		, [2] = {
			  tw = "【警告】玩家「%s」進入遊戲的方式異常。"
			, en = "[WARNING] Player \"%s\" entered the game in an abnormal manner."
			, chn = "玩家 %s 进入游戏异常"
		}
		, [3] = {
			  tw = "【警告】玩家「%s」以非法手段進入編輯模式讀取 Lua 遭到系統強制踢除。"
			, en = "[WARNING] Player \"%s\" accessed the editor mode with illegal methods to load Lua scripts and was forcibly removed by the system."
			, chn = "玩家 %s 以非法手段进入编辑模式"
		}
		, [4] = {
			  tw = "【警告】玩家「%s」疑似使用不當未知武器。"
			, en = "[WARNING] Player \"%s\" is suspected of using unauthorized or unknown weapons."
			, chn = "玩家 %s 使用不当武器"
		}
		, [5] = {
			  tw = "【警告】地圖裝置遭到作弊者重置，無法確認作弊者身分。"
			, en = "[WARNING] Map settings were reset by a cheater, and the identity of the cheater could not be verified."
			, chn = "地图检测异常重置"
		}
		, [6] = {
			  tw = "【警告】地圖檢測到了未知的異常。"
			, en = "[WARNING] An unidentified anomaly has been detected on the map."
			, chn = "地图检测异常"
		}
		, [7] = {
			  tw = "【系統】玩家「%s」遭到開發者踢除，將無法再次加入此遊戲室。"
			, en = "[SYSTEM] Player \"%s\" was removed by the developer and will not be allowed to rejoin this game room."
			, chn = "玩家 %s 遭到开发者踢除"
		}
		, [8] = {
			  tw = "【警告】玩家「%s」請立即停止洗屏，否則您將被踢除。"
			, en = "[WARNING] Player \"%s\" please stop spamming immediately, or you will be removed."
			, chn = "玩家 %s 洗屏警告"
		}
		, [9] = {
			  tw = "【警告】玩家「%s」因洗屏而遭到系統強制踢除。"
			, en = "[WARNING] Player \"%s\" was forcibly removed by the system due to spamming."
			, chn = "玩家 %s 洗屏踢除"
		}
		, [10] = {
			  tw = "【警告】玩家「%s」請注意您的發言，否則您將被踢除。"
			, en = "[WARNING] Player \"%s\" please mind your language, or you will be removed."
			, chn = "玩家 %s 发言不当警告"
		}
		, [11] = {
			  tw = "【警告】玩家「%s」因發言不當而遭到系統強制踢除。"
			, en = "[WARNING] Player \"%s\" was forcibly removed by the system for inappropriate language."
			, chn = "玩家 %s 发言不当踢除"
		}
		, [12] = {
			  tw = "【警告】玩家「%s」因接收警告屢勸不聽而遭到系統強制踢除。"
			, en = ""
			, chn = "玩家 %s 屡劝不听踢除"
		}
		, [13] = {
			  tw = "【警告】玩家「%s」的隊伍「%s」異常而遭到系統強制踢除。"
			, en = ""
			, chn = ""
		}
		, [14] = {
			  tw = "【警告】玩家「%s」以非法手段修改客戶端 Lua 發送開發者訊號遭到系統強制踢除。"
			, en = ""
		}
		, [15] = {
			  tw = "【警告】玩家「%s」以非法手段重新加載存檔。"
			, en = ""
		}
		, [16] = {
			  tw = "【警告】玩家「%s」以非法手段清除存檔。"
			, en = ""
		}
		, [17] = {
			  tw = "【警告】玩家「%s」以非法手段讀取他人存檔。"
			, en = ""
		}
	}
	
	, devmode = {
		  opened = {
			  tw = "開發者模式"
			, en = "DEV"
			, chn = "DEV"
		}
		, detail = {
			  fps = {
				  tw = "偵數"
				, en = "FPS"
			}
			, box = {
				  tw = "方塊"
				, en = "UI.Box"
			}
			, text = {
				  tw = "文字"
				, en = "UI.Text"
			}
		}
	}
	
	, command = {
		  nopermissions = {
			  tw = "【錯誤】沒有權限！"
			, en = "[ERROR] No permissions!"
		}
		, nopermissionsinserver = {
			  tw = "【錯誤】經伺服器驗證後沒有權限！"
			, en = "[ERROR] No permissions!"
		}
		, formaterror = {
			  tw = "【錯誤】格式有誤: %s // %s"
			, en = "[ERROR] Format error: %s // %s"
		}
		, unknown = {
			  tw = "【錯誤】未知的指令！ ( %s )"
			, en = "[ERROR] Unknown command! ( %s )"
		}
		
		, stoptest = {
			  tw = "【系統】開發者「%s」使用指令結束了該場遊戲！"
			, en = "[SYSTEM] Developer \"%s\" ended the game with a command!"
			, chn = "开发者结束了游戏"
		}
		
		, getindex = {
			  tw = "【系統】當前遊戲室的玩家名單已列在控制台！"
			, en = "[SYSTEM] The current game's player list has been listed in the console!"
			, chn = "玩家名单已列出"
		}
		
		, getdroper = {
			  tw = "【系統】當前遊戲室的踢除或封鎖名單已列在控制台！"
			, en = "[SYSTEM] The current game's kick or ban list has been listed in the console!"
			, chn = "踢除或封锁名单已列出"
		}
		
		, toggledsg = {
			  tw = "【系統】開發者「%s」將 DSG 反作弊踢除功能設為了「%s」！"
			, en = "[SYSTEM] Developer \"%s\" has disabled the DSG anti-cheat kick function!"
		}
		
		, skipwait = {
			  tw = "【系統】您已將最小遊玩人數設置為 1！"
			, en = "[SYSTEM] You have set the minimum number of players to 1!"
			, chn = "最小游玩人数设置为 1"
		}
		
		, skipstate = {
			  tw = "【系統】開發者「%s」跳過了此階段！ ( #%s )"
			, en = "[SYSTEM] Developer \"%s\" has skipped this stage! ( #%s )"
			, chn = "开发者跳过了阶段"
		}
		
		, changeteam = {
			  tw = "【系統】您已成功更換隊伍！"
			, en = "[SYSTEM] You have successfully changed teams!"
		}

		, wincheck = {
			  tw = "【系統】您已將勝利條件判斷設置為「%s」！"
			, en = "[SYSTEM] You have set the victory condition to \"%s\"!"
		}
		
		, kickdev = {
			  tw = "【錯誤】您無法踢除同樣身為開發者的「%s」"
			, en = "[ERROR] You cannot kick \"%s,\" who is also a developer."
			, chn = "无法踢除开发者"
		}
		
		, delkick = {
			  tw = "【系統】開發者「%s」已解除對「%s」的踢除！"
			, en = "[SYSTEM] Developer \"%s\" has removed the kick on \"%s\"!"
			, chn = "开发者已解除对 %s 的踢除"
		}
		
		, kill = {
			  tw = "【系統】開發者「%s」殺死了「%s」！"
			, en = "[SYSTEM] Developer \"%s\" killed \"%s\"!"
			, chn = "开发者杀死了 %s"
		}
		
		, indexinvalid = {
			  tw = "【錯誤】不存在此索引號！"
			, en = "[ERROR] This index number does not exist!"
			, chn = "不存在的索引"
		}
		
		, output = {
			  tw = "【系統】所有可用指令已輸出至控制台！"
			, en = "[SYSTEM] All available commands have been output to the console!"
			, chn = "指令清单已列出"
		}
	}
	
	, system = {
		  runerror = {
			  tw = "【系統】運行 %s 時發生錯誤，請檢查 Script.log 並回報給開發者。"
			, en = "[SYSTEM] An error occurred while running %s, please check Script.log and report back to the developer."
			, chn = "运行 %s 时出现错误"
		}
		, reui = {
			  title = {
				  tw = "重新加載中"
				, en = "Reloading"
				, chn = "重新加载中"
			}
			, desc = {
				  tw = "請您稍微等候幾秒 ... 還剩餘 %d 個項目"
				, en = "Please wait a few seconds... %d items remaining"
				, chn = "请稍后 ... 还剩余 %d 个项目"
			}
		}
	}
	
	, wait = {
		  map = {
			  tw = "．地圖名稱 ( %s )．"
			, en = "- Map Name ( %s ) -"
			, chn = "．地圖名稱 ( %s )．"
		}
		, minplayers = {
			  tw = "等待中，至少需要 2 位玩家開始遊戲"
			, en = "Waiting... a minimum of 2 players are required to start the game"
			, chn = "等待 2 位玩家开始游戏"
		}
		, toggle = {
			  tw = "【T】切換"
			, en = "[T]Toggle"
			, chn = "[T]切换"
		}
		, remain = {
			  tw = "．距離下一階段還剩餘「%d」秒．"
			, en = "- Next state remaining \"%d\" second(s) -"
			, chn = "．距离下一阶段还剩 %d 秒．"
		}
		, holdon = {
			  tw = "．請稍待幾秒．"
			, en = "- Hold on -"
			, chn = "．请稍等．"
		}
		, leftslot = {
			  tw = "【 欄位 %02d 】"
			, en = "[ Slot %02d ]"
		}
		, rightslot = {
			  tw = "【 %02d 欄位 】"
			, en = "[ %02d Slot ]"
		}
		, connecting = {
			  tw = "【連接中】"
			, en = " [ Connecting ] "
		}
		, waiting = {
			  tw = "【等待中】"
			, en = " [ Waiting ] "
		}
		, ready = {
			  tw = "【已就緒】"
			, en = " [ Ready ] "
		}
		
		, playdesc = {
			tw = {
				{text = "如何遊玩？", font = "medium"},
			}
			, en = {
				  {text = "How to Play?", font = "medium"}
			}
			, kr = {
				  {text = "플레이 방법?", font = "medium"}
			}
			, chn = {
				  {text = "如何游玩？", font = "medium"}
			},
		}
		
		, updatedesc = {
			tw = {
				  {text = "更新內容？", align = "center", font = "medium"}
			}
			, en = {
				  {text = "Update Notes?", align = "center", font = "medium"}
				, {text = string.format("HVC.%X ( %d )", 0, 0)}
				, {text = "0"}
			}
			, kr = {
				  {text = "업데이트 내용?", align = "center", font = "medium"}
				, {text = string.format("HVC.%X ( %d )", 0, 0)}
				, {text = "0"}
			}
			, chn = {
				  {text = "更新内容？", align = "center", font = "medium"}
				, {text = string.format("HVC.%X ( %d )", 0, 0)}
				, {text = "0"}
			}
		}
	}
}

function f_getlanguage(systemname)
	if not systemname then
		return
	end
	
	if systemname[language.use] then
		local getype = tostring(type(systemname[language.use]))
		if getype == "string" then
			return systemname[language.use]
		elseif getype == "table" then
			return systemname[language.use][math.random(#systemname[language.use])]
		end
	else
		local getype = tostring(type(systemname["en"]))
		if getype == "string" then
			return systemname["en"]
		elseif getype == "table" then
			return systemname["en"][math.random(#systemname["en"])]
		end
	end
end

--==============================================--
-- [[                自訂涵式                ]] --
--==============================================--

--------------------------------------------------
-- [[                分離文字                ]] --
--------------------------------------------------

function string.split(str, symbol, count, unpack_result)
	if type(str) ~= "string" or type(symbol) ~= "string" or symbol == "" then
		return {}
	end

	local t = {}
	local pos = 1
	local c = 1

	while true do
		local start_pos, end_pos = string.find(str, symbol, pos, true) -- true 表示使用純文字匹配
		if not start_pos or (count and c >= count) then
			table.insert(t, string.sub(str, pos))
			break
		end
		table.insert(t, string.sub(str, pos, start_pos - 1))
		pos = end_pos + 1
		c = c + 1
	end

	if unpack_result then
		return table.unpack(t)
	else
		return t
	end
end


--------------------------------------------------
-- [[                範圍約束                ]] --
--------------------------------------------------

--[[
	# Code by ChatGPT #
]]

function math.clamp(value, min, max)
    return math.min(math.max(value, min), max)
end

--------------------------------------------------
-- [[                四捨五入                ]] --
--------------------------------------------------

function math.round(value)
	if not tonumber(value) then
		return
	end
	return math.floor(value + 0.5)
end


--------------------------------------------------
-- [[                字串計算                ]] --
--------------------------------------------------

function math.eval(expr)
    if not expr:match("^[%d%+%-%*/%%%^%(%)%.%s%w_]+$") then
        return nil, "Invalid characters in expression"
    end
	
    local chunk, err = load("return " .. expr, "math.eval", "t", {math = math})
    if not chunk then
        return nil, err
    end
	
    local ok, result = pcall(chunk)
    if not ok then
        return nil, result
    end
    return result
end

--------------------------------------------------
-- [[                格式字串                ]] --
--------------------------------------------------

function string.nformat(str, ...)
    local rawArgs = {...}
    local named = {}

    -- 如果最後一個參數是 table 而且不是數字索引表 → 當作命名參數
    if type(rawArgs[#rawArgs]) == "table" then
        local last = rawArgs[#rawArgs]
        local isIndexTable = true
        for k,_ in pairs(last) do
            if type(k) ~= "number" then
                isIndexTable = false
                break
            end
        end
        if not isIndexTable then
            named = rawArgs[#rawArgs]
            rawArgs[#rawArgs] = nil
        end
    end

    -- 處理第一個參數是 table 的情況（順序參數）
    if #rawArgs == 1 and type(rawArgs[1]) == "table" then
		local t = rawArgs[1]
		rawArgs = {}
		local i = 1
		while i <= math.max(1000, #t) do
			rawArgs[i] = t[i]  -- nil 也保留
			i = i + 1
		end
	end

    -- 跳脫大括號
    str = str:gsub("{{", "\1"):gsub("}}", "\2")

    -- 檢查是否全部都沒索引
    local hasExplicit = false
    for content in str:gmatch("{(.-)}") do
        if content:match("^[%w_]+") then
            hasExplicit = true
            break
        end
    end

    -- 若完全沒索引 → 自動編號
    if not hasExplicit then
        local i = 0
        str = str:gsub("{(.-)}", function(content)
            i = i + 1
            if content == "" then
                return "{"..i.."}"
            elseif content:sub(1,1) == ":" then
                return "{"..i..content.."}"
            else
                return "{"..i..":"..content.."}"
            end
        end)
    end

    local function getValue(key)
        local num = tonumber(key)
        if num then return rawArgs[num] end
        return named[key]
    end

    local function autoFormat(val)
        if val == nil then return "%s", "{}" end
        local n = tonumber(val)
        if n then
            if math.type and math.type(n) == "integer" or n % 1 == 0 then
                return "%d", n
            else
                return "%.2f", n
            end
        end
        return "%s", tostring(val)
    end

    local function apply(val, fmt)
        if val == nil then return "{}" end

        local format = fmt
        local v = val

        if not format or format == "" then
            format, v = autoFormat(val)
        else
            format = "%" .. format
        end

        local ok, res = pcall(string.format, format, v)
        if not ok then return "{}" end
        return res
    end

    -- {key:%fmt}
    str = str:gsub("{([^:{}]+):%%([^}]+)}", function(key, fmt)
        return apply(getValue(key), fmt)
    end)

    -- {key}
    str = str:gsub("{([^:{}]+)}", function(key)
        return apply(getValue(key))
    end)

    -- 還原跳脫
    str = str:gsub("\1", "{"):gsub("\2", "}")

    return str
end

--------------------------------------------------
-- [[                字串長度                ]] --
--------------------------------------------------

function string.csolen(str)
	local len = 0
	for uchar in string.gmatch(str, "[%z\1-\127\194-\244][\128-\191]*") do
		if #uchar > 1 then
			len = len + 2
		else
			len = len + 1
		end
	end
	return len
end

function string.lenutf8(str)
	local len = 0
	for uchar in string.gmatch(str, "[%z\1-\127\194-\244][\128-\191]*") do
		if #uchar > 1 then
			len = len + 1
		else
			len = len + 1
		end
	end
	return len
end

--------------------------------------------------
-- [[                嘗試代碼                ]] --
--------------------------------------------------

--[[
	# Made by Destroyertw1207 with ChatGPT #
]]

function f_setnewcode_try(code)
    local func, err = load(code)
    if func then
        local success, runtime_err = pcall(func)
        if not success then
            log("Runtime error: " .. runtime_err)
			return false
        end
		return true
    else
        log("Syntax error: " .. err)
		return false
    end
end

--------------------------------------------------
-- [[                陣列字串                ]] --
--------------------------------------------------

function table.tostring(tbl)
    local function serialize(t)
        if type(t) == "userdata" and getmetatable(t) and getmetatable(t).__pairs then
            local result = "{"
            local first = true
            for k, v in pairs(t) do
                if not first then
                    result = result .. ","
                end
                first = false
                result = result .. string.format("[\"%s\"]=%s", k, serialize(v))
            end
            return result .. "}"
        elseif type(t) == "table" then
            local result = "{"
            local first = true
            for k, v in pairs(t) do
                if not first then
                    result = result .. ","
                end
                first = false
                
                if type(k) == "string" then
                    result = result .. string.format("[\"%s\"]=", k)
                elseif type(k) == "number" then
                    result = result .. string.format("[%d]=", k)
                end
                
                result = result .. serialize(v)
            end
            return result .. "}"
        elseif type(t) == "string" then
            return string.format("\"%s\"", t)
        else
            return tostring(t)
        end
    end
    return serialize(tbl)
end

function string.totable(str)
    local func, err = load("return " .. str, "tbl_loader", "t", {})
    if not func then error("Invalid table format: " .. err) end
    return func()
end

--------------------------------------------------
--                 [[ 深層表 ]]                 --
--------------------------------------------------

function table.deepcopy(orig, seen, suntil)
    seen = seen or {}

    -- 非 table 直接返回
    if type(orig) ~= "table" then
        return orig
    end

    -- 循環引用檢查
    if seen[orig] then
        return seen[orig]
    end

    -- 如果 suntil 回傳 true，停止遞迴，直接返回原始 table
    if suntil and suntil(orig) then
        return orig
    end

    local copy = {}
    seen[orig] = copy

    for k, v in pairs(orig) do
        copy[table.deepcopy(k, seen, suntil)] = table.deepcopy(v, seen, suntil)
    end

    -- 保留 metatable，不遞迴
    setmetatable(copy, getmetatable(orig))

    return copy
end

function table.deepsearch(tbl, suntil, path, results, seen)
	local function __FUNC_MODULECLASS(obj)
		local mt = getmetatable(obj)
		while mt do
			if mt == Module then
				return true
			end
			mt = getmetatable(mt)
		end
		return false
	end
	
    path = path or {}
    results = results or {}
    seen = seen or {}
    if seen[tbl] then return results end
    seen[tbl] = true

    for k, v in pairs(tbl) do
        table.insert(path, k)
        local result = suntil(k, v, path)
        if result ~= nil then
            local path_copy = {table.unpack(path)}
            table.insert(results, { path = path_copy, value = result })
        end
        if type(v) == "table" and not __FUNC_MODULECLASS(v) then
            table.deepsearch(v, suntil, path, results, seen)
        end
        table.remove(path)
    end
    return results
end

function table.deepmerge(target, source)
    for k, v in pairs(source) do
        if type(v) == "table" then
            -- 如果目標沒有這個表，先建立一個空的
            if type(target[k]) ~= "table" then
                target[k] = {}
            end
            table.deepmerge(target[k], v)
        else
            target[k] = v
        end
    end
end

function table.extend(target, source)
    for _, v in ipairs(source) do
        table.insert(target, v)
    end
end

function table.patch(target, source)
    for k, v in pairs(source) do
        -- 直接將 source 的 key 賦值給 target
        -- 如果 key 已存在會覆蓋，不存在會新增
        target[k] = v
    end
end

function table.merge(target, source)
    -- 檢查 source 是否為陣列 (判斷第一個 key 是不是數字 1)
    if source[1] ~= nil then
        -- 走 Extend 模式：使用 table.insert 往後排隊
        for _, v in ipairs(source) do
            table.insert(target, v)
        end
    else
        -- 走 Patch 模式：使用 pairs 直接對準 Key 賦值
        for k, v in pairs(source) do
            target[k] = v
        end
    end
end

--------------------------------------------------
--                [[ 隨機抽選 ]]                --
--------------------------------------------------

function table.randomselect(tbl, max, filter)
	local selected = {}
	local list = {}
	local tblc = #tbl

	if max == nil then
		max = tblc
	end
	if max <= 0 then
		return
	end

	-- 建立索引
	for i = 1, tblc do
		list[i] = i
	end

	-- Fisher-Yates shuffle
	for i = tblc, 2, -1 do
		local n = math.random(1, i)
		list[i], list[n] = list[n], list[i]
	end

	local now = 0
	for i = 1, tblc do
		local t = tbl[list[i]]
		if t and (not filter or filter(t)) then
			now = now + 1
			selected[now] = t
			if now >= max then
				break
			end
		end
	end

	return selected
end

--------------------------------------------------
-- [[                文字數位                ]] --
--------------------------------------------------

function string.tobyte(str)
	local bytes = {}
	for i = 1, #str do
		table.insert(bytes, string.format("%x", string.byte(str, i)))
	end
	return table.concat(bytes, "")
end

function string.rebyte(bstr)
    local bytes = {}
    for i = 1, #bstr, 2 do
        bytes[#bytes+1] = string.char(tonumber(bstr:sub(i,i+1),16))
    end
    return table.concat(bytes)
end

--------------------------------------------------
-- [[                漸變顯示                ]] --
--------------------------------------------------

DESYSTEM.GRADIENT = {
	ACTIVE = {},
	
	-- 核心處理邏輯：獨立出來，不論是 Game 還是 UI 環境都能呼叫
	UPDATE_PROCESS = function(self)
		for obj, state in pairs(self.ACTIVE) do
			local real_obj = obj
			local is_valid = false

			if state.is_entity then
				if obj:IsMonster() then
					local m = obj:ToMonster()
					is_valid = m and not m.user.dead
				elseif obj:IsPlayer() then
					local p = obj:ToPlayer()
					is_valid = p and p.user.lobby
				end
			else
				is_valid = obj:IsVisible()
			end
			
			if not is_valid then
				self.ACTIVE[real_obj] = nil
			else
				-- 推進進度
				state.tick = state.tick + 1
				local progress = math.min(state.tick / state.duration, 1)
				
				local start_c = state.start_color
				local target_c = state.targets[state.target_idx]
				
				-- 線性插值計算
				local curr_r = math.floor(start_c.r + (target_c.r - start_c.r) * progress)
				local curr_g = math.floor(start_c.g + (target_c.g - start_c.g) * progress)
				local curr_b = math.floor(start_c.b + (target_c.b - start_c.b) * progress)
				local color_data = {r = curr_r, g = curr_g, b = curr_b}

				-- 執行渲染：區分 Entity 與 UI
				if state.is_entity then
					obj:SetRenderColor(color_data)
				else
					obj:Set(color_data)
				end
				
				-- 狀態切換邏輯
				if progress == 1 then
					state.tick = 0
					state.start_color = target_c
					state.target_idx = state.target_idx + 1
					
					-- 循環與結束判斷
					if state.target_idx > #state.targets then
						if state.loop_max == -1 then
							state.target_idx = 1
						elseif state.loop_count < state.loop_max then
							state.loop_count = state.loop_count + 1
							state.target_idx = 1
						else
							self.ACTIVE[obj] = nil
						end
					end
				end
			end
		end
	end,

	__DELEGATE__ = {
		-- 根據環境動態掛載
		Rule_OnUpdate = function(time, self) self:UPDATE_PROCESS() end,
		Event_OnUpdate = function(time, self) self:UPDATE_PROCESS() end,
	},
	
	ADD = function(self, data)
		if not data or not data.target or not data.gradient_color or #data.gradient_color == 0 then
			return
		end
		
		local obj = data.target
		-- 判斷是否為實體 (entity 通常有 index 屬性或特定的 userdata 類型)
		local is_entity = (type(obj) == "userdata" and obj.index ~= nil)
		
		local duration = data.duration or data.speed or 20 
		local loop_max = (data.loop == true and -1) or (type(data.loop) == "number" and data.loop) or 0
		
		-- 獲取初始顏色
		local init_color
		if data.color then
			init_color = data.color
		else
			-- 如果沒給初始色，試著從對象獲取
			if is_entity then
				-- 假設實體有預設顏色，或從 user table 讀取舊值
				init_color = obj.user.SetRenderColor or {r=255, g=255, b=255}
			else
				local ui_get = obj:Get()
				init_color = {r = ui_get.r or 255, g = ui_get.g or 255, b = ui_get.b or 255}
			end
		end
		
		local targets = {}
		for _, c in ipairs(data.gradient_color) do
			table.insert(targets, {r = c.r, g = c.g, b = c.b})
		end
		
		if data.restc then
			table.insert(targets, {r = init_color.r, g = init_color.g, b = init_color.b})
		end
		
		-- 套用初始色
		if is_entity then
			obj:SetRenderColor(init_color)
		else
			obj:Set(init_color)
		end
		
		self.ACTIVE[obj] = {
			is_entity = is_entity,
			duration = duration,
			tick = 0,
			loop_max = loop_max,
			loop_count = 0,
			target_idx = 1,
			targets = targets,
			start_color = {r = init_color.r, g = init_color.g, b = init_color.b}
		}
		
		return obj 
	end,
	
	REMOVE = function(self, obj)
		if self.ACTIVE[obj] then
			-- 選擇性：在移除時恢復預設顏色
			if self.ACTIVE[obj].is_entity then
				obj:SetRenderColor({r=255, g=255, b=255})
			else
				obj:Set({r=255, g=255, b=255})
			end
			self.ACTIVE[obj] = nil
		end
	end
}

--------------------------------------------------
-- [[                錯誤代碼                ]] --
--------------------------------------------------

function f_errortranslate(msg)
	local msg = tostring(msg)
	local dict = {
		-- long // original
		{ "attempt to index a nil value", "試圖索引一個空值" },
		{ "attempt to call a nil value", "試圖呼叫一個空值" },
		{ "attempt to compare nil with ([^%.]+)", function(captured)
			return "試圖將空值與" .. captured .. "進行比較"
		end },
		{ "attempt to compare two nil values", "試圖將兩個空值進行比較" },
		{ "attempt to concatenate", "試圖串接" },
		{ "attempt to perform arithmetic on a nil value", "試圖對空值執行算術運算" },
		{ "attempt to get length of a nil value", "試圖取得空值的長度" },
		{ "attempt to call a nil value %(method '.-'%)", "試圖呼叫空值方法" }, -- 用 pattern 模糊匹配
		{ "unexpected symbol near", "符號附近語法錯誤" },
		{ "syntax error near", "語法錯誤靠近" },
		{ "index out of range", "索引超出範圍" },
		{ "stack overflow", "堆疊溢位" },
		{ "memory allocation error", "記憶體分配錯誤" },
		
		-- long // cso
		{ "lua: error: SyncValue only can save bool, number, string!!!", "同步變量只允許儲存布林值、數字、字串！" },
		{ "sol: cannot write to a sol::readonly variable", "sol: 無法寫入被標記為唯讀的變數" },
		{ "sol.sol::detail::unique_usertype<([^%.]+)>", function(captured)
			return "CSO 物件 " .. string.gsub(captured, "::", ":")
		end },

		-- short // original
		{ "not a", "不是一個" },
		{ "it is not recognized as a container", "它不被認為是一個容器" },
		{ "class not found", "類別未被找到" },
		{ "nil value", "空值" },
		{ "bad argument", "無效的參數" },
		{ "number expected", "期望為數字" },
		{ "boolean expected", "期望為布林值" },
		{ "string expected", "期望為字串" },
		{ "iterator", "迭代器" },
		{ "received", "接收到" },
		{ "expected", "期望" },
		{ "initial value", "初始值" },
		{ "initial", "初始" },
		{ "value", "值" },
		{ "must be", "必須是" },
		{ "must", "必須" },
		{ "got", "但取得" },
		{ "string value", "字串值" },
		{ "string", "字串" },
		{ "with", "與" },
		{ "nil", "空" },
		{ "boolean", "布林值" },
		{ "bool", "布林值" },
		{ "number value", "數值" },
		{ "number", "數字" },
		{ "numeric", "數字" },
		{ "float", "浮點數" },
		{ "integer", "整數" },
		{ "has no", "不為" },
		{ "has", "為" },
		{ "attempt to", "試圖" },
		{ "bad argument", "錯誤的參數" },
		{ "arguments", "參數" },
		{ "argument", "參數" },
		{ "to 'format'", "來自 'string.format' ( 格式化字串 )" },
		{ "class", "類別" },
		{ "index", "索引" },
		{ "types", "類型" },
		{ "type", "類型" },
		{ "stack", "堆疊" },
		{ "overflow", "溢位" },
		{ "call", "呼叫" },
		{ "compare", "比較" },
		{ "length", "長度" },
		{ "concatenate", "串接" },
		{ "variable", "變數" },
		{ "readonly", "唯讀" },
		{ "write", "寫入" },
		{ "local", "區域變數" },
		{ "global", "全域變數" },
		{ "field", "欄位" },
		{ "invalid", "無效的" },
		{ "monster", "怪物" },
		{ "object", "物件" },
		{ "cannot", "無法" },
		{ "error", "錯誤" },
		{ "this", "這是" },
		{ "it", "它" },
		{ "is not", "不是" },
		{ "is", "是" },
		{ "container", "容器" },
		{ "recognized", "被認可" },
		{ "as", "為" },
		{ " a ", "一個" },
	}
	
	local source, line, content = string.match(msg, '%[string "(.-)"%]:(%d+): (.+)')
	
	if source and line and content then
		for _, v in ipairs(dict) do
			local pattern = v[1]
			local replacement = v[2]
			if type(replacement) == "function" then
				-- 用 function 做動態替換
				content = content:gsub(pattern, replacement)
			else
				content = content:gsub(pattern, replacement)
			end
		end

		local filename = string.match(source, "%-%-([^.=]+[%.%w_]*)==") or source
		
		return string.format("【錯誤】 %s.lua // %s 行 // %s", string.lower(filename), line, content)
	else
		for _, v in ipairs(dict) do
			local pattern = v[1]
			local replacement = v[2]
			if type(replacement) == "function" then
				msg = msg:gsub(pattern, replacement)
			else
				msg = msg:gsub(pattern, replacement)
			end
		end
		return string.format("【錯誤】 ?.lua // ? 行 // %s", msg)
	end
end

--------------------------------------------------
-- [[                涵式委託                ]] --
--------------------------------------------------

function f_tryload(func, errortitle, args)
	local success, result = pcall(func, table.unpack(args, 1, 10))
	if not success then
		print("<ffaaaa>" .. result)
		log("<ffaaaa>" .. result)
		local errormsg = string.format("[ %s ] %s", errortitle, f_errortranslate(result))
		print("<ffaaaa>" .. errormsg)
		log("<ffaaaa>" .. errormsg)
		if not Des.Error[errormsg] then
			table.insert(msgreg, {
				  to = "all"
				, msg = errormsg
				, clr = {r = 250, g = 100, b = 100}
			})
			table.insert(msgreg, {
				  to = "all"
				, msg = string.format(f_getlanguage(language.system.runerror), errortitle)
				, clr = {r = 250, g = 100, b = 100}
			})
			Des.Error[errormsg] = true
		end
	end
	return success, result
end

function f_setdelegate(func, oriarg, arglen)
	local SYS = (Des.Sys == Game and "Game") or (Des.Sys == UI and "UI")
	
	-- 1. 解析 func 名稱，找出對應的 Api 定義
	local returnParamIndex = nil
	local prefix, eventName = func:match("^(%w+)_(.+)$")
	if eventName then
		local apiDef = (prefix == "Rule" and Des.Game.Rule.Api[eventName]) or 
		               (prefix == "Event" and Des.UI.Event.Api[eventName])
		
		-- 如果有 return 定義，且不是標記型別 (例如 "[boolean]")
		if apiDef and apiDef["return"] and #apiDef["return"] > 0 then
			local returnName = apiDef["return"][1]
			if not returnName:match("^%[") then 
				-- 找出該 return 變數在 params 裡的索引位置
				for i, paramName in ipairs(apiDef["params"] or {}) do
					if paramName == returnName then
						returnParamIndex = i
						break
					end
				end
			end
		end
	end
	
	oriarg = oriarg or {}
	arglen = arglen or #oriarg
	
	-- 建立當前參數的副本，這樣才不會污染原始傳入的 table
	local current_args = {}
	for i = 1, arglen do
		current_args[i] = oriarg[i]
	end
	
	local final_delegate_result = nil 
	
	for source, content in pairs(Des[SYS].Delegate[func] or {}) do
		local args = {}
		-- 每次呼叫 delegate 時，使用可能已經被上一個 delegate 更新過的 current_args
		for i = 1, arglen do
			args[i] = current_args[i]
		end
		for i = 1, #content[2] do
			args[arglen + i] = content[2][i]
		end
		
		local d_success, d_result = f_tryload(content[1], string.format("Des.%s.Delegate.%s", SYS, func), args)
		
		if d_success and d_result ~= nil then
			final_delegate_result = d_result
			-- 2. 如果觸發了符合的回傳參數，將更新的值存回 current_args 給下一個使用
			if returnParamIndex then
				current_args[returnParamIndex] = d_result
			end
		end
	end
	
	return final_delegate_result
end

-- 【修改】新增了第 6 個參數：catchUp (布林值)
function f_adddelegate(func, name, call, cusarg, once, catchUp)
    local SYS = (Des.Sys == Game and "Game") or (Des.Sys == UI and "UI")
    
    local __FUNC_ONCE
    if once then
        __FUNC_ONCE = function(...)
            if once then
                call(...)
                f_remdelegate(func, name)
            end
        end
        call = __FUNC_ONCE
    end
    
    Des[SYS].Delegate[func] = Des[SYS].Delegate[func] or {}
	
	if Des[SYS].Delegate[func][name] then
		error(string.nformat("Des.{}.Delegate.{}.{} 已被註冊。", SYS, func, name))
		return
	end
	
    Des[SYS].Delegate[func][name] = {call, cusarg or {}}
	
    if catchUp and Des.Game.Rule.LastArgsCache and Des.Game.Rule.LastArgsCache[func] then
		
        local lastArgs = Des.Game.Rule.LastArgsCache[func]
        
        local execArgs = {}
        if cusarg then
            for i = 1, #cusarg do table.insert(execArgs, cusarg[i]) end
        end
        if lastArgs then
            for i = 1, #lastArgs do table.insert(execArgs, lastArgs[i]) end
        end
        
        call(table.unpack(execArgs))
    end
end

function f_remdelegate(func, name)
	local SYS = (Des.Sys == Game and "Game") or (Des.Sys == UI and "UI")
	
	Des[SYS].Delegate[func] = Des[SYS].Delegate[func] or {}
	Des[SYS].Delegate[func][name] = nil
end

function f_checkdelegate(func, name)
	local SYS = (Des.Sys == Game and "Game") or (Des.Sys == UI and "UI")
	
	return Des[SYS].Delegate[func][name]
end

--------------------------------------------------
-- [[                區塊包裝               ]] --
--------------------------------------------------

local function f_sort_sections(sys_table)
    table.sort(sys_table, function(a, b)
        return a.priority < b.priority
    end)
end

function f_addsection(func_name, block_name, priority, callback, extra_args)
    local SYS = (Des.Sys == Game and "Game") or (Des.Sys == UI and "UI")
    Des[SYS].Section[func_name] = Des[SYS].Section[func_name] or {}
    
    local sec_list = Des[SYS].Section[func_name]
    
    -- 如果已經有同名區塊，更新它；否則新增
    local exists = false
    for i, block in ipairs(sec_list) do
        if block.name == block_name then
            block.priority = priority
            block.callback = callback
            block.extra_args = extra_args or {}
            exists = true
            break
        end
    end
    
    if not exists then
        table.insert(sec_list, {
            name = block_name,
            priority = priority,
            callback = callback,
            extra_args = extra_args or {}
        })
    end
    
    f_sort_sections(sec_list)
end

function f_remsection(func_name, block_name)
    local SYS = (Des.Sys == Game and "Game") or (Des.Sys == UI and "UI")
    if not Des[SYS].Section[func_name] then return end
    
    local sec_list = Des[SYS].Section[func_name]
    for i, block in ipairs(sec_list) do
        if block.name == block_name then
            table.remove(sec_list, i)
            break
        end
    end
end

function f_runsection(func_name, context)
    local SYS = (Des.Sys == Game and "Game") or (Des.Sys == UI and "UI")
    if not Des[SYS].Section[func_name] then return context end
    
    local sec_list = Des[SYS].Section[func_name]
    for _, block in ipairs(sec_list) do
        
        local pass_args = { context }
        
        if block.extra_args then
            for _, v in ipairs(block.extra_args) do
                table.insert(pass_args, v)
            end
        end
        
        local d_success, d_result = f_tryload(
            block.callback, 
            string.format("Des.%s.Section.%s", SYS, func_name), 
            pass_args
        )
        
        if d_success then
            if d_result == "STOP" then
                break
            end
        end
    end
    
    return context
end

--------------------------------------------------
-- [[                間隔更新                ]] --
--------------------------------------------------

function f_interval(id, intervaltime)
	if not interval then
		interval = {}
	end
	if not interval[id] then
		interval[id] = 0
	end
	
	local t = interval[id]
    if not t then
        interval[id] = Game.GetTime()
        return false
    end

    if Game.GetTime() - t >= intervaltime then
        interval[id] = Game.GetTime()
        return true
    end

    return false
end

--==============================================--
-- [[                同步變量                ]] --
--==============================================--

--==============================================--
-- [[                同步變量                ]] --
--==============================================--

Des.Sync = {
	__REG__ = {}
	, BufferQueue = {}
	, _listeners = {} -- 結構改為: _listeners[proxy] = { cb1, cb2, cb3... }

	-- 【修改】OnChanged 支援多元註冊 (Delegate 效果)
	, OnChanged = function(self, sync_obj, callback)
		if type(sync_obj) == "table" and type(callback) == "function" then
			-- 如果該物件還沒有監聽清單，先建立一個空 Table
			self._listeners[sync_obj] = self._listeners[sync_obj] or {}
			-- 將新的 callback 加進清單中 (相當於 += Delegate)
			table.insert(self._listeners[sync_obj], callback)
		end
	end

	-- 【新增】取消監聽 (相當於 -= Delegate)
	, OffChanged = function(self, sync_obj, callback)
		if self._listeners[sync_obj] then
			for i, cb in ipairs(self._listeners[sync_obj]) do
				if cb == callback then
					table.remove(self._listeners[sync_obj], i)
					break
				end
			end
		end
	end

	, Wrap = function(self, real_sync, delegate_key)
		local proxy = {}
		local _last_time = "0"
		
		local _shadow_value = nil
		local _has_shadow = false

		-- 【私有輔助】觸發現有的 Delegate 系統
		local function trigger_delegate(new_val, old_val)
			if new_val ~= old_val and delegate_key then
				-- 傳遞參數：{新值, 舊值, proxy物件本身}
				f_setdelegate(delegate_key, {new_val, old_val, proxy})
			end
		end
		
		setmetatable(proxy, {
			__index = function(t, k)
				if k == "value" then
					if _has_shadow then 
						return _shadow_value 
					end
					return real_sync.value
				end
				return real_sync[k]
			end,
			__newindex = function(t, k, v)
				if k == "value" then
					local old_val = _has_shadow and _shadow_value or real_sync.value

					local sys_time = Des.Sys.GetTime() or 0
					local curr_time = tostring(sys_time)
					
					_shadow_value = v
					_has_shadow = true
					
					if _last_time == curr_time then
						table.insert(Des.Sync.BufferQueue, function()
							_last_time = tostring(Des.Sys.GetTime() or 0)
							if Des.Sys == Game then
								real_sync.value = v
							end
							_has_shadow = false
						end)
					else
						_last_time = curr_time
						if Des.Sys == Game then
							real_sync.value = v
						end
						_has_shadow = false
					end

					-- 【新增】觸發 Delegate
					trigger_delegate(v, old_val)
				else
					real_sync[k] = v
				end
			end
		})
		
		return proxy
	end

	, __INIT__ = function(self)
		if Game then
			f_adddelegate(
				  "Rule_OnUpdate"
				, string.format("Des.Sync.ADDSYNC ( Game )")
				, function(time)
					-- =========================================
					-- 處理緩存中的同步變量 (Buffer Queue)
					-- =========================================
					if #Des.Sync.BufferQueue > 0 then
						local current_queue = Des.Sync.BufferQueue
						Des.Sync.BufferQueue = {}
						
						for i, apply_func in ipairs(current_queue) do
							apply_func()
						end
					end

					-- 原本的 ADDSYNC 邏輯
					for k, v in pairs(Des.Sync.__REG__ or {}) do
						Des.Sync.ADDSYNC.value = table.tostring(v)
						table.remove(Des.Sync.__REG__, k)
						break
					end
				end
				, nil
			)
		end

		if UI then
			f_adddelegate(
				  "Sync_ADDSYNC"
				, string.format("Des.Sync.ADDSYNC ( UI )")
				, function(sync)
					local data = string.totable(sync.value)
					if Des.Sync[data.name] then
						
					else
						Des.Sync:ADD(data)
					end
				end
				, nil
			)
		end

		for i, data in pairs(Des.Sync.SETUP) do
			Des.Sync:ADD(data)
		end
	end
	
	, ADD = function(self, data, sync)
		local SYS = (Des.Sys == Game and "Game") or (Des.Sys == UI and "UI")
		
		if not Des.Sync[data.name] then
			
			-- =========================================
			-- 1. 全局變量 (非玩家專屬)
			-- =========================================
			if not data.player then
				if not data.sort then
					-- [1-A] 單一全局變數
					local d_key = string.format("SyncChanged_%s", data.name)
					Des.Sync[data.name] = self:Wrap(Des.Sys.SyncValue.Create(string.format("Des.Sync.%s", data.name)), d_key)
					
					if Game and data.value then
						Des.Sync[data.name].value = data.value
					end
					
					if UI then
						Des.Sync[data.name].OnSync = function(sync_self)
							if Des.Sync.Exec[data.name] then
								f_tryload(Des.Sync.Exec[data.name], string.format("Des.Sync.Exec.%s", data.name), {sync_self})
							end
							f_setdelegate(string.format("Sync_%s", data.name), {sync_self})
						end
					end
				else
					-- [1-B] 全局陣列變數
					Des.Sync[data.name] = {}
					for i = 1, data.sort do
						local d_key = string.format("SyncChanged_%s_%d", data.name, i)
						Des.Sync[data.name][i] = self:Wrap(Des.Sys.SyncValue.Create(string.format("Des.Sync.%s[%.0f]", data.name, i)), d_key)
						
						if UI then
							Des.Sync[data.name][i].OnSync = function(sync_self)
								if Des.Sync.Exec[data.name] then
									f_tryload(Des.Sync.Exec[data.name], string.format("Des.Sync.Exec.%s[%.0f]", data.name, i), {sync_self, i})
								end
								f_setdelegate(string.format("Sync_%s", data.name), {sync_self, i})
							end
						end
					end
				end

			-- =========================================
			-- 2. 玩家專屬變量 (player = true)
			-- =========================================
			else
				if Game then
					Des.Sync[data.name] = {}
					if not data.sort then
						-- [2-A] 每個玩家 1 個變數
						f_adddelegate("Rule_OnPlayerConnect", string.format("SyncPlayerConnect_%s", data.name), function(player)
							if not Des.Sync[data.name][player.index] then
								local d_key = string.format("SyncChanged_%s_p%d", data.name, player.index)
								Des.Sync[data.name][player.index] = self:Wrap(Game.SyncValue.Create(string.format("Des.Sync.%s[%.0f]", data.name, player.index)), d_key)
							end
						end, nil)
						
						f_adddelegate("Rule_OnPlayerDisconnect", string.format("SyncPlayerDisconnect_%s", data.name), function(player)
							if Des.Sync[data.name][player.index] then Des.Sync[data.name][player.index] = nil end
						end, nil)
					else
						-- [2-B] 每個玩家擁有一個陣列
						f_adddelegate("Rule_OnPlayerConnect", string.format("SyncPlayerConnect_%s", data.name), function(player)
							if not Des.Sync[data.name][player.index] then
								Des.Sync[data.name][player.index] = {}
								for i = 1, data.sort do
									local d_key = string.format("SyncChanged_%s_p%d_%d", data.name, player.index, i)
									Des.Sync[data.name][player.index][i] = self:Wrap(Game.SyncValue.Create(string.format("Des.Sync.%s[%.0f][%.0f]", data.name, player.index, i)), d_key)
								end
							end
						end, nil)
						
						f_adddelegate("Rule_OnPlayerDisconnect", string.format("SyncPlayerDisconnect_%s", data.name), function(player)
							if Des.Sync[data.name][player.index] then Des.Sync[data.name][player.index] = nil end
						end, nil)
					end
				end

				if UI then
					if data.self then
						-- [3-A] 僅限本地玩家的 UI
						if not data.sort then
							Des.Sync[data.name] = self:Wrap(UI.SyncValue.Create(string.format("Des.Sync.%s[%.0f]", data.name, UI.PlayerIndex(index))))
							Des.Sync[data.name].OnSync = function(sync_self)
								if Des.Sync.Exec[data.name] then
									f_tryload(Des.Sync.Exec[data.name], string.format("Des.Sync.Exec.%s", data.name), {sync_self})
								end
								f_setdelegate(string.format("Sync_%s", data.name), {sync_self})
							end
						else
							Des.Sync[data.name] = {}
							for i = 1, data.sort do
								Des.Sync[data.name][i] = self:Wrap(UI.SyncValue.Create(string.format("Des.Sync.%s[%.0f][%.0f]", data.name, UI.PlayerIndex(index), i)))
								Des.Sync[data.name][i].OnSync = function(sync_self)
									if Des.Sync.Exec[data.name] then
										f_tryload(Des.Sync.Exec[data.name], string.format("Des.Sync.Exec.%s[%.0f]", data.name, i), {sync_self, i})
									end
									f_setdelegate(string.format("Sync_%s", data.name), {sync_self, i})
								end
							end
						end
					else
						-- =========================================
						-- [3-B] 所有玩家的 UI 同步 (修正版)
						-- =========================================
						Des.Sync[data.name] = {}
						if not data.sort then
							-- 直接預先建立 1 到 32 號玩家的 SyncValue
							for pIdx = 1, 32 do
								Des.Sync[data.name][pIdx] = self:Wrap(UI.SyncValue.Create(string.format("Des.Sync.%s[%.0f]", data.name, pIdx)))
								Des.Sync[data.name][pIdx].OnSync = function(s_self)
									if Des.Sync.Exec[data.name] then 
										f_tryload(Des.Sync.Exec[data.name], string.format("Des.Sync.Exec.%s[%.0f]", data.name, pIdx), {s_self, pIdx}) 
									end
									f_setdelegate(string.format("Sync_%s", data.name), {s_self, pIdx})
								end
							end
						else
							for pIdx = 1, 32 do
								Des.Sync[data.name][pIdx] = {}
								for i = 1, data.sort do
									Des.Sync[data.name][pIdx][i] = self:Wrap(UI.SyncValue.Create(string.format("Des.Sync.%s[%.0f][%.0f]", data.name, pIdx, i)))
									Des.Sync[data.name][pIdx][i].OnSync = function(s_self)
										if Des.Sync.Exec[data.name] then 
											f_tryload(Des.Sync.Exec[data.name], string.format("Des.Sync.Exec.%s_p%d_%d", data.name, pIdx, i), {s_self, pIdx, i}) 
										end
										f_setdelegate(string.format("Sync_%s", data.name), {s_self, pIdx, i})
									end
								end
							end
						end
					end
				end
			end
			
			if sync then
				table.insert(Des.Sync.__REG__, data)
			end
		end
	end
	
	, SETUP = {
		  {name = "ADDSYNC"      }
		, {name = "editmode"     , value = "000"}
		, {name = "localmode"    }
		, {name = "varisync"     , sort = 2           }
		, {name = "stload"       }
		, {name = "developer"    }
		, {name = "drop"         }
		, {name = "countplayer"  }
		, {name = "difficulty"   }
		, {name = "connect"      }
		, {name = "disconnect"   }
		, {name = "output"       }
		, {name = "state"                  , value = 0}
		, {name = "remaining"    }
		, {name = "maxremaining" }
		, {name = "scoreboard"   }
		
		, {name = "joined"       , player = true, self = true}
		, {name = "rejoin"       , player = true, self = true}
		, {name = "plrswait"     , sort   = 24               }
		, {name = "plrsinfo"     , player = true             }
		, {name = "dialoguesend" , player = true, self = true}
	}
	
	, Exec = {}
}
Des.Sync:__INIT__()

--==============================================--
-- [[                訊號傳遞                ]] --
--==============================================--

Des.Signals = {
	  __ID__ = {}
	, __DEADREG__ = {}
	, __REG__ = {}
	
	, __GET_HASH__ = function(str)
		local hash = 5381
		for i = 1, #str do
			-- 使用質數 33 讓碰撞率降到最低，並限制在安全整數範圍
			hash = (hash * 33 + string.byte(str, i)) % 2147483647
		end
		return hash
	end
	  
	, __INIT__ = function(self)
		Des.Sync:ADD(
			  {name = "ADDSIGNAL"}
			, true
		)
		
		if Game then
			f_adddelegate(
				  "Rule_OnUpdate"
				, string.format("Des.Sync.ADDSIGNAL ( Game )")
				, function(time)
					for k, v in pairs(Des.Signals.__REG__ or {}) do
						Des.Sync.ADDSIGNAL.value = table.tostring(v)
						table.remove(Des.Signals.__REG__, k)
						break
					end
				end
				, nil
			)
			
			f_adddelegate(
				  "Rule_OnPlayerSignal"
				, string.format("Des.Signals.INIT ( Game )")
				, function(player, signal)
					local cmdstate = player.user["Des.Commands"]
					if cmdstate then
						if cmdstate.MODE ~= "__NORMAL__" then
							return
						end
					end
					
					local data = Des.Signals.__ID__[signal]
					if data then
						if not data.custom then
							data.func(player, signal)
						end
					end
				end
				, nil
			)
		end
		
		if UI then
			f_adddelegate(
				  "Sync___ADDSIGNAL__"
				, string.format("Des.Sync.__ADDSIGNAL__ ( UI )")
				, function(sync)
					local data = string.totable(sync.value)
					if not Des.Signals[data.name] then
						Des.Signals:ADD(data)
					end
				end
				, nil
			)
		end
		
		for i, data in pairs(Des.Signals.SETUP) do
			Des.Signals:ADD(data)
		end
	end
	
	, ADD = function(self, data, sync)
		if not Des.Signals[data.name] then
			
			-- [修正] 直接透過字串名稱產生固定的 Signal ID
			local fixed_id = data.signal or self.__GET_HASH__(data.name)
			
			Des.Signals[data.name] = data
			Des.Signals[data.name].signal = fixed_id
			Des.Signals.__ID__[fixed_id] = Des.Signals[data.name]
			
			if sync then
				table.insert(Des.Signals.__REG__, data)
			end
		end
	end
	
	, SETUP = {
		{
			  name = "dsg_!harass"
			, desc = "DSG 警告：洗屏"
			, func = function(player, signal)
				f_dialogue_send("all", string.format(f_getlanguage(language.badreason[8]), player.name), {r = 250, g = 100, b = 100})
			end
		}
		, {
			  name = "dsg_/harass"
			, desc = "DSG 踢除：洗屏"
			, func = function(player, signal)
				f_cheat_detected(player, 9)
			end
		}
		, {
			  name = "dsg_!badmsg"
			, desc = "DSG 警告：不雅文字"
			, func = function(player, signal)
				f_dialogue_send("all", string.format(f_getlanguage(language.badreason[10]), player.name), {r = 250, g = 100, b = 100})
			end
		}
		, {
			  name = "dsg_/badmsg"
			, desc = "DSG 踢除：不雅文字"
			, func = function(player, signal)
				f_cheat_detected(player, 11)
			end
		}
		, {
			  name = "dsg_!editmode"
			, desc = "DSG 偵測：編輯模式"
			, func = function(player, signal)
				if Des.Sync.editmode.value == "000" then
					Des.Sync.editmode.value = string.format("%02d%f", player.index, Game.GetTime())
				end
			end
		}
		, {
			  name = "dsg_/editmode"
			, desc = "DSG 踢除：編輯模式"
			, func = function(player, signal)
				editmode = true
			end
		}
		, {
			  name = "dsg_/localmode"
			, desc = "DSG 踢除：本機伺服器"
			, func = function(player, signal)
				localmode = true
				if player.name ~= "DestroyerI滅世I" then
					f_cheat_detected(player, 12)
				end
			end
		}
	}
}
Des.Signals:__INIT__()

--==============================================--
-- [[                指令設置                ]] --
--==============================================--

Des.Commands = {
	  __SIGNAL__ = {
		  __LOADFUNC__  = -120701
		, __SETNUMARG__ = -120702
		, __SETSTRARG__ = -120703
		, __GETSTRARG__ = -120704
	}
	
	, __INIT__ = function(self)
		if Game then
			f_adddelegate(
				  "Rule_OnPlayerConnect"
				, "Des.Commands.INIT ( Rule_OnPlayerConnect )"
				,  function(player)
					local cmdstate = {
						MODE = "__NORMAL__",
						CONTENT = {
							__ARGS__ = {},
							__STRARG__ = ""
						}
					}
					
					player.user["Des.Commands"] = cmdstate
				end
			)
			
			f_adddelegate(
				  "Rule_OnPlayerSignal"
				, "Des.Commands.INIT ( Rule_OnPlayerSignal )"
				, function(player, signal)
					local cmdstate = player.user["Des.Commands"]
					
					local MODE = cmdstate.MODE
					local CONTENT = cmdstate.CONTENT
					
					for k, v in pairs(Des.Commands.__SIGNAL__) do
						if signal == v then
							MODE = k
							cmdstate.MODE = MODE

							if MODE == "__GETSTRARG__" then
								local t = {}
								-- 【修改1】將正則表達式改成嚴格匹配 3 個數字
								for n in CONTENT.__STRARG__:gmatch("%d%d%d") do
									t[#t + 1] = tonumber(n)
								end
								CONTENT.__ARGS__[#CONTENT.__ARGS__ + 1] = string.char(table.unpack(t))
								return
							end
							return
						end
					end
					
					if MODE == "__LOADFUNC__" then
						local data = Des.Signals.__ID__[signal]
						
						if not data then
							return
						end

						if data.dev
						and not player.user.developer then
							f_dialogue_send(
								  player.index
								, f_getlanguage(language.command.nopermissionsinserver)
								, { r = 250, g = 100, b = 100 }
							)
							f_cheat_detected(player, 14)
						else
							data.func(player, signal, table.unpack(CONTENT.__ARGS__))
						end

						CONTENT.__ARGS__ = {}
						CONTENT.__STRARG__ = ""
						cmdstate.MODE = "__NORMAL__"
						return
					end
					
					if MODE == "__SETNUMARG__" then
						CONTENT.__ARGS__[#CONTENT.__ARGS__ + 1] = signal
						return
					end
					
					if MODE == "__SETSTRARG__" then
						-- 【修改2】接收時，把我們為了防呆加的 "1" 拔掉，還原真實的數字字串
						local str_sig = tostring(signal)
						if string.sub(str_sig, 1, 1) == "1" then
							str_sig = string.sub(str_sig, 2)
						end
						CONTENT.__STRARG__ = CONTENT.__STRARG__ .. str_sig
						return
					end
				end
				, nil
			)
		end
		
		if UI then
			f_adddelegate(
				  "Event_OnChat"
				, "Des.Commands.Setup"
				, function(msg)
					local cmd, argstr = msg:match("^(%S+)%s*(.*)")
					local args = {}
					if argstr then
						for v in argstr:gmatch("%S+") do
							table.insert(args, v)
						end
					end
					
					local data = Des.Commands[cmd]
					
					if  cmd
					and data then
						if data.dev and not Des.UI.Loaded.developer then
							f_dialogue_send(
								  f_getlanguage(language.command.nopermissions)
								, { r = 250, g = 100, b = 100 }
							)
							return
						end
						
						local function __FUNC_ARGSMATCH(rules, inputargs)
							for index, rulegroup in ipairs(rules or {}) do
								local value = inputargs[index]
								local optional = (rulegroup[1] == "/optional")
								local matched = false
								
								if not value then
									if optional then
										return true
									else
										return false, "缺少必要參數：" .. rulegroup[1][2]
									end
								end
								
								for i = optional and 2 or 1, #rulegroup do
									local rule = rulegroup[i]
									if type(rule) == "table" then
										if value:match("^" .. rule[1] .. "+$") then
											matched = true
											break
										end
									end
								end

								if not matched then
									return false, "參數格式錯誤：" .. value
								end
							end

							return true
						end
						local success, err = __FUNC_ARGSMATCH(data.args, args)
						if not success then
							local usage = Des.Commands:USAGE(cmd)
							f_dialogue_send(string.format(f_getlanguage(language.command.formaterror), usage, err), {r = 250, g = 100, b = 100})
						else
							for i, arg in pairs(args or {}) do
								if arg and #arg > 0 then
									local numarg = tonumber(arg)
									-- 檢查是否為數字，且必須是「整數」(math.floor(numarg) == numarg)
									if numarg and math.floor(numarg) == numarg then
										Des.UI.Signal(Des.Commands.__SIGNAL__.__SETNUMARG__)
										Des.UI.Signal(numarg)
									else
										Des.UI.Signal(Des.Commands.__SIGNAL__.__SETSTRARG__)

										local strarg = "1" -- 【修改3】開頭塞一個 "1"，防止前導 0 在轉整數時消失

										for i = 1, #arg do
											-- 【修改4】強制格式化為 3 位數 (如 48 會變成 "048")
											local byte = string.format("%03d", string.byte(arg, i)) 
											local test = tonumber(strarg .. byte)
											
											if test and test >= 2147483647 then
												Des.UI.Signal(tonumber(strarg))
												strarg = "1" .. byte -- 滿了重新開始時，一樣要塞一個 "1"
											else
												strarg = strarg .. byte
											end
										end
										
										if #strarg > 1 then
											Des.UI.Signal(tonumber(strarg))
										end
										
										Des.UI.Signal(Des.Commands.__SIGNAL__.__GETSTRARG__)
									end
								end
							end
							
							if data.trigger then
								data.trigger(msg)
							end
							
							if data.gamesignal then
								Des.UI.Signal(Des.Commands.__SIGNAL__.__LOADFUNC__)
								Des.UI.Signal(Des.Signals[cmd].signal)
							end
						end
					else
						if string.sub(msg, 1, 1) == "#" then
							f_dialogue_send(string.format(f_getlanguage(language.command.unknown), cmd), {r = 250, g = 100, b = 100})
						end
					end
				end
				, nil
			)
		end
		
		for i, data in pairs(Des.Commands.SETUP) do
			if data.__INIT__ then
				data:__INIT__()
			end
			
			Des.Signals:ADD({
				  name   = data.cmd
				, desc   = "指令：" .. data.desc
				, func   = data.gamesignal
				, dev    = data.dev
				, custom = true
			})
			Des.Commands[data.cmd] = data
		end
	end
	
	, ADD = function(self, data, default)
        if Des.Commands[data.cmd] then
            return -- 已經存在就跳過
        else
            if not default then
                table.insert(self.SETUP, data)
            end
            
            if data.__INIT__ then
                data:__INIT__()
            end
            
			if data.gamesignal then
				Des.Signals:ADD({
					name   = data.cmd
					, desc   = "指令：" .. (data.desc or "無說明") -- [修正] 防止 data.desc 為 nil 引發拼接報錯
					, func   = data.gamesignal
					, dev    = data.dev
					, custom = true
				})
			end
            Des.Commands[data.cmd] = data
        end
    end
	
	, USAGE = function(self, cmd)
		local parts = { cmd }

		for index, rulegroup in ipairs(Des.Commands[cmd].args or {}) do
			local optional = (rulegroup[1] == "/optional")
			local names = {}

			for i = optional and 2 or 1, #rulegroup do
				table.insert(names, rulegroup[i][2])
			end

			local prefix = optional and "" or "*"
			table.insert(
				parts,
				string.format("%s(%s)", prefix, table.concat(names, " | "))
			)
		end

		return table.concat(parts, " ")
	end
	
	, SETUP = {
		  {
			  cmd  = "#"
			, desc = "輸出所有指令至控制台"
			, trigger = function(msg)
				print("")
				print("--------------------")
				print("        指令        ")
				print("--------------------")
				print("")
				for k, v in pairs(Des.Commands.SETUP) do
					if not v.dev then
						local usage = Des.Commands:USAGE(v.cmd)
						print(usage)
						-- print(v.cmd .. " - " .. v.desc or "無說明")
					end
				end
				print("")
				print("--------------------")
				print("")
				if Des.UI.Loaded.developer then
					print("--------------------")
					print("     開發者指令     ")
					print("--------------------")
					print("")
					for k, v in pairs(Des.Commands.SETUP) do
						if v.dev then
							local usage = Des.Commands:USAGE(v.cmd)
							print(usage)
							-- print(v.cmd .. " - " .. v.desc or "無說明")
						end
					end
					print("")
					print("--------------------")
					print("")
				end
				
				f_dialogue_send(f_getlanguage(language.command.output), {r = 50, g = 100, b = 200})
			end
		},
		
		{
			  cmd  = "#reui"
			, desc = "重新加載 UI"
			, trigger = function(msg)
				if prelobby.reset then
					if not prelobby.complete then
						return
					end
				end
				
				for k, v in pairs(Des.UI.Loaded) do
					Des.UI.Loaded[k] = nil
					table.insert(ui_Reset, k)
				end
				Des.UI.Loaded = {}
				
				for i = 1, 1024 do
					Des.UI.Max1024.All.Box [i]:Show()
					Des.UI.Max1024.All.Text[i]:Show()
				end
				Des.UI.DirNowCount = 0
				Des.UI.PreNowCount = 0
				
				prelobby = {
					  state    = 5
					, delay    = 0
					, bool     = true
					, complete = true
					, reset    = true
				}
				
				setmetatable(Des.UI.Frame.Text, Module)
				setmetatable(Des.UI.Frame.Box, Module)
				setmetatable(Des.UI.Hollow.Box, Module)
				setmetatable(Des.UI.Gradient.Text, Module)
				setmetatable(Des.UI.Cnsv.Text, Module)
				setmetatable(Des.UI.Pixel.Text, Module)
				
				table.insert(ui_Loading, {
					sys = "reui"
				})
				
				if UI then
					s = {
						  w = UI.ScreenSize().width
						, h = UI.ScreenSize().height
					}
				end
			end
		},
		
		{
			  cmd  = "#stoptest"
			, desc = "結束測試"
			, dev  = true
			, gamesignal = function(player, signal)
				player:Win()
				f_dialogue_send("all", string.format(f_getlanguage(language.command.stoptest), player.name), {r = 250, g = 150, b = 50})
			end
		},
		
		{
			  cmd  = "#getindex"
			, desc = "獲取玩家索引號"
			, dev  = true
			, gamesignal = function(player, signal)
				print("--------------------")
				print(" players index list ")
				print("--------------------")
				for k, v in pairs(players) do
					if v then
						print(string.format("%02d | %s", k, v.name))
					end
				end
				print("--------------------")
				
				f_dialogue_send(player.index, f_getlanguage(language.command.getindex), {r = 50, g = 100, b = 200})
			end
		},
		
		{
			  cmd  = "#getdroper"
			, desc = "獲取被踢除者索引號"
			, dev  = true
			, gamesignal = function(player, signal)
				print("--------------------")
				print(" dropers index list ")
				print("--------------------")
				for k, v in pairs(drop) do
					if v then
						print(string.format("%02d | %s", k, v))
					end
				end
				print("--------------------")
				
				f_dialogue_send(player.index, f_getlanguage(language.command.getdroper), {r = 50, g = 100, b = 200})
			end
		},
		
		{
			  cmd  = "#dsg"
			, desc = "開關 DSG 反作弊"
			, dev  = true
			, gamesignal = function(player, signal)
				dsgac = not dsgac
				f_dialogue_send("all", string.format(f_getlanguage(language.command.toggledsg), player.name, dsgac), {r = 250, g = 150, b = 50})
			end
		},
		
		{
			  cmd  = "#sw"
			, desc = "一人執行遊戲"
			, dev  = 110005
			, gamesignal = function(player, signal)
				minplayers = 1
				f_dialogue_send(player.index, f_getlanguage(language.command.skipwait), {r = 250, g = 150, b = 50})
			end
		},
		
		{
			  cmd  = "#ss"
			, desc = "跳過目前階段"
			, dev  = true
			, gamesignal = function(player, signal)
				Des.Sync.remaining.value = Game.GetTime() + 0.1
				f_dialogue_send("all", string.format(f_getlanguage(language.command.skipstate), player.name, Des.Sync.state.value), {r = 250, g = 150, b = 50})
			end
		},
		
		{
			  cmd  = "#ct"
			, desc = "更換隊伍"
			, dev  = true
			, gamesignal = function(player, signal)
				player.team = (player.team % 2) + 1
				f_dialogue_send(player.index, f_getlanguage(language.command.changeteam), {r = 250, g = 150, b = 50})
			end
		},
		
		{
			  cmd  = "#wc"
			, desc = "切換勝利條件判斷"
			, dev  = true
			, gamesignal = function(player, signal)
				wincheck = not wincheck
				f_dialogue_send(player.index, string.format(f_getlanguage(language.command.wincheck), wincheck), {r = 250, g = 150, b = 50})
			end
		},
		
		{
			  cmd  = "#win"
			, desc = "強制進入下一回合"
			, dev  =  true
			, gamesignal = function(player, signal)
				Game.Rule:Win(3, false)
			end
		},
		
		{
			  cmd  = "#szb"
			, desc = "允許抽選殭屍"
			, dev  = true
			, gamesignal = function(player, signal)
				LZE2D.ZOMBIE.toggle = not LZE2D.ZOMBIE.toggle
				f_dialogue_send(player.index, LZE2D.ZOMBIE.toggle, {r = 250, g = 150, b = 50})
			end
		},
		
		{
			  cmd  = "#test"
			, desc = "測試用指令"
			, dev  = true
			, gamesignal = function(player, signal, arg)
				-- player.health = 1
				-- player.position = {x = -165, y = 72, z = -20} -- Z1-3
				-- player.position = {x = -161, y = 152, z = -43} -- Z1-E
				-- player.position = {x = -158, y = 73, z = -18} -- Z1-E2
				
				-- player.position = {x = -97, y = 121, z = -53} -- Z2-1
				-- player.position = {x = -102, y = 56, z = -49} -- Z2-1 電梯
				
				-- player.position = {x = -98, y = 26, z = -33} -- Z2-2 SPIKE
				
				-- player.position = {x = -98, y = -68, z = -33} -- Z2-4
				-- player.position = {x = -98, y = -123, z = -33} -- Z2-E
				
				-- player.position = {x = -98, y = -109, z = -68} -- Z3
				
				test = not test
				f_dialogue_send("all", test, {r = 250, g = 150, b = 50})
			end
		},
		
		{
			  cmd  = "#zbflinch"
			, desc = "殭屍僵直"
			, args = {
				{
					{"[%d%.]", "倍率"} -- 【修正1】只允許輸入數字 ( %d ) 和小數點 ( %. )
				}
			}
			, dev  = true
			, gamesignal = function(player, signal, arg)
				local val = tonumber(arg) -- 將字串轉換為數字
				if not val then return end -- 【修正2】防呆：如果輸入的不是有效數字則中斷執行
				
				LZE2D.ZOMBIE.DATA.flFLINCH = val
				for k, v in pairs(LZE2D.ZOMBIE:GETPLAYERS()) do
					v.flinch = val -- 使用轉換好的 val
				end
				
				-- 【修正3】string.format 裡面的參數要傳入轉換後的數字 val，才能匹配 %f
				f_dialogue_send(player.index, string.format("【系統】開發者「%s」將殭屍僵直倍率設為了「%f」！", player.name, val), {r = 250, g = 150, b = 50})
			end
		},
		
		{
			  cmd  = "#zbknockback"
			, desc = "殭屍擊退"
			, args = {
				{
					{"[%d%.]", "倍率"} -- 【修正1】只允許輸入數字和小數點
				}
			}
			, dev  = true
			, gamesignal = function(player, signal, arg)
				local val = tonumber(arg)
				if not val then return end -- 【修正2】防呆
				
				LZE2D.ZOMBIE.DATA.flKNOCKBACK = val
				for k, v in pairs(LZE2D.ZOMBIE:GETPLAYERS()) do
					-- 注意：你原本的程式碼這裡寫 v.flinch = ... 
					-- 如果擊退應該對應 v.knockback，記得檢查你的變數名稱，這邊我先照你原本的寫法改
					v.flinch = val 
				end
				
				f_dialogue_send(player.index, string.format("【系統】開發者「%s」將殭屍擊退倍率設為了「%f」！", player.name, val), {r = 250, g = 150, b = 50})
			end
		},
	}
}
Des.Commands.__INIT__()

--==============================================--
-- [[                按鍵綁定                ]] --
--==============================================--

Des.Keybind = {
	  __API__ = {
		  [ 0] = {sys = "NUM1"    , desc = "數字 1"}
		, [ 1] = {sys = "NUM2"    , desc = "數字 2"}
		, [ 2] = {sys = "NUM3"    , desc = "數字 3"}
		, [ 3] = {sys = "NUM4"    , desc = "數字 4"}
		, [ 4] = {sys = "NUM5"    , desc = "數字 5"}
		, [ 5] = {sys = "NUM6"    , desc = "數字 6"}
		, [ 6] = {sys = "NUM7"    , desc = "數字 7"}
		, [ 7] = {sys = "NUM8"    , desc = "數字 8"}
		, [ 8] = {sys = "NUM9"    , desc = "數字 9"}
		, [ 9] = {sys = "NUM0"    , desc = "數字 0"}
		, [10] = {sys = "A"                        }
		, [11] = {sys = "B"                        }
		, [12] = {sys = "C"                        }
		, [13] = {sys = "D"                        }
		, [14] = {sys = "E"                        }
		, [15] = {sys = "F"                        }
		, [16] = {sys = "G"                        }
		, [17] = {sys = "H"                        }
		, [18] = {sys = "I"                        }
		, [19] = {sys = "J"                        }
		, [20] = {sys = "K"                        }
		, [21] = {sys = "L"                        }
		, [22] = {sys = "M"                        }
		, [23] = {sys = "N"                        }
		, [24] = {sys = "O"                        }
		, [25] = {sys = "P"                        }
		, [26] = {sys = "Q"                        }
		, [27] = {sys = "R"                        }
		, [28] = {sys = "S"                        }
		, [29] = {sys = "T"                        }
		, [30] = {sys = "U"                        }
		, [31] = {sys = "V"                        }
		, [32] = {sys = "W"                        }
		, [33] = {sys = "X"                        }
		, [34] = {sys = "Y"                        }
		, [35] = {sys = "Z"                        }
		, [36] = {sys = "SHIFT"                    }
		, [37] = {sys = "SPACE" , desc = "空白鍵"  }
		, [38] = {sys = "ENTER"                    }
		, [39] = {sys = "UP"    , desc = "↑"      }
		, [40] = {sys = "DOWN"  , desc = "↓"      }
		, [41] = {sys = "LEFT"  , desc = "←"      }
		, [42] = {sys = "RIGHT" , desc = "→"      }
		, [43] = {sys = "MOUSE1", desc = "滑鼠左鍵"}
		, [44] = {sys = "MOUSE2", desc = "滑鼠右鍵"}
	}
	
	, __REC__ = {
		  OnKeyDown = {
			count = 0
		}
		, OnKeyUp = {
			count = 0
		}
		, __SEQ__ = {
			OnKeyDown = {},
			OnKeyUp   = {}
		}
	}
	
	, __INIT__ = function(self)
		for key, _ in pairs(Des.Keybind.__API__) do
			for fname, _ in pairs(Des.Keybind.__REC__) do
				Des.Keybind.__REC__[fname][key] = 0
			end
		end
		
		if UI then
			local rev = {
				  OnKeyDown = "OnKeyUp"
				, OnKeyUp   = "OnKeyDown"
			}
			for fname, _ in pairs(Des.Keybind.__REC__) do
				f_adddelegate(
					  string.format("Event_%s", fname)
					, string.format("Des.Keybind_%s", fname)
					, function(inputs)

						-- =========================
						-- 1. 記錄按鍵順序
						-- =========================
						for k, v in pairs(inputs) do
							if v then
								if Des.Keybind.__REC__[fname][k] == 0 then
									local rec = Des.Keybind.__REC__[fname]
									rec.count = rec.count + 1
									rec[k] = rec.count
									Des.Keybind.__REC__[rev[fname]][k] = 0
								end
								local seq = Des.Keybind.__REC__.__SEQ__[fname]
								table.insert(seq, {
									key = k,
									time = UI.GetTime()
								})

								-- 只保留最近0.4秒輸入
								local now = UI.GetTime()
								for i=#seq,1,-1 do
									if now - seq[i].time > 0.2 then
										table.remove(seq, i)
									end
								end
							end
						end

						-- =========================
						-- 2. 收集所有「成立的快捷鍵」
						-- =========================
						local bestData = nil
						local bestKeyCount = 0
						local bestSortValue = -1

						for _, data in pairs(Des.Keybind.Data) do
							local keys = data.keys
							local signal = Des.Signals[fname .. data.name]
							if signal then
								local prikey = keys[1]
								local seckey = keys[2]
	
								-- 檢查一組 key 是否完全符合，並回傳「最後按下的鍵」
								local function check_keys(getkey)
									if not getkey then return -1 end
	
									local seq = Des.Keybind.__REC__.__SEQ__[fname]
									local si = #seq
									local ki = #getkey
	
									local lastMatchKey = nil
	
									while si > 0 and ki > 0 do
										local expect = UI.KEY[getkey[ki]]
										if seq[si].key == expect then
											-- ★ 修正1：只在第一次匹配（即該組合鍵的最後一個按鍵）時記錄
											if lastMatchKey == nil then
												lastMatchKey = seq[si].key
											end
											ki = ki - 1
										end
										si = si - 1
									end
	
									-- 沒完整匹配
									if ki ~= 0 then
										return -1
									end
	
									-- 最後輸入必須等於最後匹配鍵
									if seq[#seq].key ~= lastMatchKey then
										return -1
									end
	
									return lastMatchKey
								end
	
								local sortvalue = check_keys(prikey)
								local matchLength = 0
								
								if sortvalue ~= -1 then
									matchLength = #prikey
								else
									sortvalue = check_keys(seckey)
									if sortvalue ~= -1 then
										matchLength = #seckey
									end
								end
	
								-- 成立就納入候選
								if sortvalue > 0 and inputs[sortvalue] then
									-- ★ 修正2：使用實際匹配成功的按鍵數量（陣列長度）來做比較，而不是 #keys
									local keyCount = matchLength
	
									-- 只保留「按鍵數最多」的那一組
									if keyCount > bestKeyCount then
										bestKeyCount = keyCount
										bestData = data
										bestSortValue = sortvalue
									end
								end
							end
						end

						-- =========================
						-- 3. 只執行最精確的那一組
						-- =========================
						if bestData and bestData[fname] then
							local cfg = bestData[fname]

							if cfg.trigger then
								cfg.trigger(inputs, isDoubleClick)
							end

							if cfg.gamesignal then
								local sig = Des.Signals[fname .. bestData.name]
								if sig then
									Des.UI.Signal(sig.signal)
								end
							end
						end
					end
					, nil
				)
			end
		end
		
		for i, data in pairs(Des.Keybind.SETUP) do
            self:ADD(data, true) -- [修正] 明確傳入 true
        end
    end
    
    , ADD = function(self, data, default)
        if not default then
            table.insert(self.SETUP, data)
        end
        
        if data.OnKeyDown then
            Des.Signals:ADD({
                  name   = "OnKeyDown" .. (data.name or "Unknown")
                , desc   = "按下：" .. (data.desc or "無說明") -- [修正] 防呆
                , func   = data.OnKeyDown.gamesignal
            })
        end
        if data.OnKeyUp then
            Des.Signals:ADD({
                  name   = "OnKeyUp" .. (data.name or "Unknown")
                , desc   = "放開：" .. (data.desc or "無說明") -- [修正] 防呆
                , func   = data.OnKeyUp.gamesignal
            })
        end
        Des.Keybind.Data = Des.Keybind.Data or {}
        Des.Keybind.Data[data.name] = data
        
        if data.__INIT__ then
            data.__INIT__(data)
        end
		
		if data.__DELEGATE__ then
			for dname, dfunc in pairs(data.__DELEGATE__ or {}) do
				f_adddelegate(dname, string.format("REYL4D.KEYBIND.%s#%s", data.name, dname), dfunc, {data})
			end
		end
    end
	
	, SETUP = {
		{
			  keys       = {{"T"}}
			, name       = "waitui"
			, desc       = "等待階段介面收縮"
			  
			, conflict   = true
			, deadsignal = false
			
			, OnKeyDown = {
				  trigger = function(inputs)
					if Des.UI.Loaded.wait then
						if not wait.bool then
							wait.toggle = not wait.toggle
						end
					end
				end
			}
		}
	}
}

Des.Keybind:__INIT__()

--==============================================--
-- [[                批次處理                ]] --
--==============================================--

function f_setbatch(name, ntable, batch, time)
	local SYS = (Game and "Game") or (UI and "UI")
	
	Des.Batch[name] = {
		  table   = {
			  origin = ntable
			, sorted = {}
		}
		, batch   = batch
		, time    = time
		, start   = 1
		, handler = nil
	}
	
	for k in pairs(Des.Batch[name].table.origin) do
		table.insert(Des.Batch[name].table.sorted, k)
	end
	
	--[[
	f_adddelegate(
		"Blua_fasterupdate"
		, string.format("batch_%s", name)
		, function(self)
			local data = Des.Batch[name]
			if data.start > #data.table.sorted then
				data.start = 1
				
				data.table.sorted = {}
				for k, v in pairs(data.table.origin) do
					table.insert(data.table.sorted, v)
				end
			end
			
			for i = data.start, math.min(data.start + data.batch, #data.table.sorted) do
				if data.handler then
					data.handler(_G[SYS].GetTime(), data.table.sorted[i])
				end
			end
			
			data.start = data.start + data.batch
		end
		, nil
	)
	]]
end

--------------------------------------------------