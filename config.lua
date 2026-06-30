Config = {
    -- turn on if you need to hot restart the plugin
    DevMode = false,
    Lang = Langs.En,
    StaticData = Data,
    MaxHorses = 3,
    MaxCarts = 4,
    StableSlots = 3,

    CallHorseKey = Keys.H,
    CallCartKey = Keys.J,
    FollowKey = Keys.E,
    InvKeyToPress = "U",

    DisableBuyOption = false,
    JobRequired = false,
    JobForHorseDealer = "horsetrainer",
    JobForCartDealer = "wagondealer",
    JobForAllDealer = "HorseAndCarriagesdealer",

    -- When a horse dies, make it unavailable for x seconds
    SecondsToRespawn = 120,

    -- The hard death mechanism will make a horse unavailable after it has died too many times
    -- Set false to disable or set true, then set overall health, and Check deathResasons.lua To
    -- adjust the long term damages dealt by any death reasons.
    -- the reasons can really be vast and will be updated.
    HardDeath = true,
    LongTermHealth = 100,

    ShowTagsOnHorses = false,

    HorseSkillPullUpFailPercent = 20,
    DistanceToTeleport = 200,

    -- Should everyone Access the inventories of the horses/carts
    -- //TODO To fully implement, let anyone open the inventory, not just the owner
    ShareInv = {
        horse = true,
        cart = true
    },
    -- Should the horse or cart inventory ignore items stack limit
    StackInvIgnore = {
        horse = true,
        cart = true
    },

    MaxTackPerItem = 20, --max number of indivudual tack items to purchase (limited to 20 saddles, horns, etc) or false for unlimited
    
    
    DefaultMaxWeight = 9000,
    CustomMaxWeight = {

        wagonPrison01x = 200,
        warwagon2 = 200,
        policeWagongatling01x = 200,
        POLICEWAGON01X = 200,
        COACH6 = 200,
        COACH5 = 200,
        COACH4 = 200,
        buggy03 = 100,
        buggy02 = 100,
        buggy01 = 100,
        CART08 = 200,
        CART07 = 200,
        CART06 = 500,
        CART05 = 200,
        CART04 = 200,
        CART03 = 200,
        CART02 = 200,
        CART01 = 200,
        CHUCKWAGON000X = 3000,
        CHUCKWAGON002X = 5000,
        coal_wagon = 5000,
        gatchuck = 3000,
        LOGWAGON = 2000,
        OILWAGON01X = 1000,
        oilWagon02x = 1000,
        supplywagon = 5000,
        utilliwag = 8000,
        WAGON02X = 4000,
        WAGON03X = 4000,
        WAGON04X = 4000,
        WAGON05X = 3000,
        WAGON06X = 5000,
        COACH2 = 2000,
        COACH3 = 1000,
        coach3_cutscene = 1000,
        STAGECOACH001X = 3000,
        STAGECOACH002X = 3000,
        STAGECOACH003X = 3000,
        STAGECOACH004X = 3000,
        STAGECOACH004_2x = 3000,
        STAGECOACH005X = 3000,
        STAGECOACH006X = 3000,
        armysupplywagon = 9000,
        gatchuck_2 = 8000,
        bountywagon01x = 1000,
        huntercart01 = 5000,
        wagonarmoured01x = 1000,
        wagondairy01x = 3000,
        wagonDoc01x = 7000,
        wagontraveller01x = 6000,
        wagonWork01x = 6000,

    },

    Stables = {
--[[
    To setup a custom inventory for the stable, define:
        horses = {}
        carts = {}

    If horses/carts are not defined or are left empty, the vendor will sell everything.

    You can define vendor-specific pricing/currency like this:
        horses = {
            { A_C_Horse_AmericanPaint_Overo = "name" }, -- uses default price/currency from Data

            { A_C_Horse_AmericanPaint_Greyovero = {
                name = "name",
                price = 50,
                currency = 0, -- 0 for money, 1 for gold
            } },

]]
    {
        Name = "Valentine Stables",
        BlipIcon = 1938782895,
        EnterStable = { -365.87, 789.51, 116.17, 2.0 },
        StableNPC = { -365.15, 792.68, 115.18, 178.47 },
        SpawnHorse = { -366.07, 781.81, 115.14, 5.97 },
        CamHorse = { -367.9267, 783.0237, 117.7778, -36.42624, 0.0, -100.9786 },
        CamHorseGear = { -367.9267, 783.0237, 117.7778, -36.42624, 0.0, -100.9786 },
        SpawnCart = { -370.11, 786.99, 115.16, 274.18 },
        CamCart = { -363.5831, 792.1113, 118.0419, -16.35144, 0.0, 143.9759 },
        -- horses available and prices per location

        -- configured all horses for valentine for example, other stables have limited selection
        horses = {

            ["American Standardbred"] = {
                { A_C_Horse_AmericanStandardbred_Black = { name = "Black", price = 1100, currency = 1, } },
                { A_C_Horse_AmericanStandardbred_Buckskin = { name = "Buckskin", price = 800, currency = 0, } },
                { A_C_Horse_AmericanStandardbred_Lightbuckskin = { name = "Light Buckskin", price = 850, currency = 0, } },
                { A_C_Horse_AmericanStandardbred_PalominoDapple = { name = "Dapple Palomino", price = 800, currency = 0, } },
                { A_C_Horse_AmericanStandardbred_SilverTailBuckskin = { name = "Silver Tail Buckskin", price = 800, currency = 0, } },
            },

            ["Breton"] = {
                { A_C_Horse_Breton_GrulloDun = { name = "Grullo Dun", price = 900, currency = 0, } },
                { A_C_Horse_Breton_RedRoan = { name = "Red Roan", price = 850, currency = 0, } },
                { A_C_Horse_Breton_Sorrel = { name = "Sorrel", price = 850, currency = 0, } },
                { A_C_Horse_Breton_SteelGrey = { name = "Steel Grey", price = 850, currency = 0, } },
                { A_C_Horse_Breton_SealBrown = { name = "Seal Brown", price = 900, currency = 0, } },
                { A_C_Horse_Breton_MealyDappleBay = { name = "Mealy Dapple Bay", price = 800, currency = 0, } },
            },

            ["Kentucky Saddler"] = {
                { A_C_Horse_KentuckySaddle_Black = { name = "Black", price = 350, currency = 0, } },
                { A_C_Horse_KentuckySaddle_ButterMilkBuckskin_PC = { name = "Buttermilk Buckskin", price = 350, currency = 0, } },
                { A_C_Horse_KentuckySaddle_ChestnutPinto = { name = "Chestnut Pinto", price = 300, currency = 0, } },
                { A_C_Horse_KentuckySaddle_Grey = { name = "Grey", price = 300, currency = 0, } },
                { A_C_Horse_KentuckySaddle_SilverBay = { name = "Silver Bay", price = 500, currency = 0, } },
            },

            ["Kladruber"] = {
                { A_C_Horse_Kladruber_Black = { name = "Black", price = 3000, currency = 0, } },
                { A_C_Horse_Kladruber_Silver = { name = "Silver", price = 3200, currency = 0, } },
                { A_C_Horse_Kladruber_Cremello = { name = "Cremello", price = 3200, currency = 0, } },
                { A_C_Horse_Kladruber_DappleRoseGrey = { name = "Dapple Rose Grey", price = 3200, currency = 0, } },
                { A_C_Horse_Kladruber_White = { name = "White", price = 3200, currency = 0, } },
                { A_C_Horse_Kladruber_Grey = { name = "Grey", price = 3000, currency = 0, } },
            },

            ["Morgan"] = {
                { A_C_Horse_Morgan_FlaxenChestnut = { name = "Flaxen Chestnut", price = 100, currency = 0, } },
                { A_C_Horse_Morgan_LiverChestnut_PC = { name = "Liver Chestnut", price = 500, currency = 0, } },
                { A_C_Horse_Morgan_Bay = { name = "Bay", price = 300, currency = 0, } },
                { A_C_Horse_Morgan_BayRoan = { name = "Bay Roan", price = 300, currency = 0, } },
                { A_C_Horse_Morgan_Palomino = { name = "Palomino", price = 200, currency = 0, } },
            },

            ["Gang Horses"] = {
                { A_C_Horse_Gang_Lenny = { name = "Lenny's Horse", price = 500, currency = 0, } },
                { A_C_Horse_Gang_Uncle = { name = "Uncle's Horse", price = 400, currency = 0, } },
                { A_C_Horse_Gang_Uncle_EndlessSummer = { name = "Uncle's Horse 2", price = 600, currency = 0, } },
                { A_C_Horse_Gang_Sadie = { name = "Sadie's Horse", price = 4000, currency = 0, } },
                { A_C_Horse_Gang_Sadie_EndlessSummer = { name = "Sadie's Horse 2", price = 2000, currency = 0, } },
                { A_C_Horse_Gang_Hosea = { name = "Hosea's Horse", price = 4000, currency = 0, } },
                { A_C_Horse_Gang_Dutch = { name = "Dutch's Horse", price = 12000, currency = 0, } },
                { A_C_Horse_Gang_Charles = { name = "Charles' Horse", price = 600, currency = 0, } },
                { A_C_Horse_Gang_Charles_EndlessSummer = { name = "Charles' Horse 2", price = 600, currency = 0, } },
                { A_C_Horse_Gang_Trelawney = { name = "Trelawney's Horse", price = 600, currency = 0, } },
                { A_C_Horse_Gang_Javier = { name = "Javier's Horse", price = 600, currency = 0, } },
                { A_C_Horse_Gang_Bill = { name = "Bill's Horse", price = 900, currency = 0, } },
                { A_C_Horse_Gang_Kieran = { name = "Kieran's Horse", price = 4500, currency = 0, } },
                { A_C_Horse_Gang_Karen = { name = "Karen's Horse", price = 900, currency = 0, } },
                { A_C_Horse_Gang_John = { name = "John's Horse", price = 3000, currency = 0, } },
                { A_C_Horse_John_EndlessSummer = { name = "John's Horse", price = 5000, currency = 0, } },
                { A_C_Horse_Gang_Sean = { name = "Sean's Horse", price = 850, currency = 0, } },
                { A_C_Horse_Gang_Micah = { name = "Micah's Horse", price = 3200, currency = 0, } },
                { A_C_Horse_EagleFlies = { name = "Eagle Flies' Horse", price = 600, currency = 0, } },
                { A_C_Horse_Buell_WarVets = { name = "Buell", price = 5500, currency = 0, } },
                { MP_Horse_Owlhootvictim_01 = { name = "Owlhoot Victim Horse", price = 500, currency = 0, } },
            },

            ["Norfolk Roadster"] = {
                { A_C_Horse_NorfolkRoadster_RoseGrey = { name = "Rose Grey", price = 2700, currency = 0, } },
                { A_C_Horse_NorfolkRoadster_SpeckledGrey = { name = "Speckled Grey", price = 2500, currency = 0, } },
                { A_C_Horse_NorfolkRoadster_SpottedTricolor = { name = "Spotted Tricolor", price = 3500, currency = 0, } },
                { A_C_Horse_NorfolkRoadster_Black = { name = "Black", price = 3500, currency = 0, } },
                { A_C_Horse_NorfolkRoadster_DappledBuckskin = { name = "Dappled Buckskin", price = 3500, currency = 0, } },
                { A_C_Horse_NorfolkRoadster_PiebaldRoan = { name = "Piebald Roan", price = 2700, currency = 0, } },
            },

            ["Shire"] = {
                { A_C_Horse_Shire_DarkBay = { name = "Dark Bay", price = 450, currency = 0, } },
                { A_C_Horse_Shire_LightGrey = { name = "Light Grey", price = 500, currency = 0, } },
                { A_C_Horse_Shire_RavenBlack = { name = "Raven Black", price = 550, currency = 0, } },
            },

            ["Tennessee Walker"] = {
                { A_C_Horse_TennesseeWalker_BlackRabicano = { name = "Black Rabicano", price = 350, currency = 0, } },
                { A_C_Horse_TennesseeWalker_Chestnut = { name = "Chestnut", price = 300, currency = 0, } },
                { A_C_Horse_TennesseeWalker_MahoganyBay = { name = "Mahogany Bay", price = 300, currency = 0, } },
                { A_C_Horse_TennesseeWalker_RedRoan = { name = "Red Roan", price = 300, currency = 0, } },
                { A_C_Horse_TennesseeWalker_GoldPalomino_PC = { name = "Gold Palomino", price = 350, currency = 0, } },
                { A_C_Horse_TennesseeWalker_FlaxenRoan = { name = "Flaxen Roan", price = 300, currency = 0, } },
                { A_C_Horse_TennesseeWalker_DappleBay = { name = "Dapple Bay", price = 300, currency = 0, } },
            },

            ["Turkoman"] = {
                { A_C_Horse_Turkoman_Black = { name = "Black", price = 3800, currency = 0, } },
                { A_C_Horse_Turkoman_Chestnut = { name = "Chestnut", price = 3800, currency = 0, } },
                { A_C_Horse_Turkoman_Grey = { name = "Grey", price = 3800, currency = 0, } },
                { A_C_Horse_Turkoman_Perlino = { name = "Perlino", price = 3800, currency = 0, } },
                { A_C_Horse_Turkoman_Gold = { name = "Gold", price = 3700, currency = 0, } },
                { A_C_Horse_Turkoman_Silver = { name = "Silver", price = 3400, currency = 0, } },
                { A_C_Horse_Turkoman_DarkBay = { name = "Dark Bay", price = 3400, currency = 0, } },
            },

            ["Mustang"] = {
                { A_C_Horse_Mustang_Buckskin = { name = "Buckskin", price = 1500, currency = 0, } },
                { A_C_Horse_Mustang_ChestnutTovero = { name = "Chestnut Tovero", price = 1500, currency = 0, } },
                { A_C_Horse_Mustang_RedDunOvero = { name = "Red Dun Overo", price = 1200, currency = 0, } },
                { A_C_Horse_Mustang_TigerStripedBay = { name = "Tiger Striped Bay", price = 950, currency = 0, } },
                { A_C_Horse_Mustang_GoldenDun = { name = "Golden Dun", price = 900, currency = 0, } },
                { A_C_Horse_Mustang_GrulloDun = { name = "Grullo Dun", price = 900, currency = 0, } },
                { A_C_Horse_Mustang_WildBay = { name = "Wild Bay", price = 900, currency = 0, } },
            },

            ["Missouri Fox Trotter"] = {
                { A_C_Horse_MissouriFoxTrotter_BlackTovero = { name = "Black Tovero", price = 2700, currency = 0, } },
                { A_C_Horse_MissouriFoxTrotter_BlueRoan = { name = "Blue Roan", price = 2700, currency = 0, } },
                { A_C_Horse_MissouriFoxTrotter_BuckskinBrindle = { name = "Buckskin Brindle", price = 2700, currency = 0, } },
                { A_C_Horse_MissouriFoxTrotter_DappleGrey = { name = "Dapple Grey", price = 2700, currency = 0, } },
                { A_C_Horse_MissouriFoxTrotter_AmberChampagne = { name = "Amber Champagne", price = 2500, currency = 0, } },
                { A_C_Horse_MissouriFoxTrotter_SableChampagne = { name = "Sable Champagne", price = 2500, currency = 0, } },
                { A_C_Horse_MissouriFoxTrotter_SilverDapplePinto = { name = "Silver Dapple Pinto", price = 2500, currency = 0, } },
            },

            ["Arabian"] = {
                { A_C_Horse_Arabian_RoseGreyBay = { name = "Rose Grey Bay", price = 10000, currency = 0, } },
                { A_C_Horse_Arabian_Black = { name = "Black", price = 9500, currency = 0, } },
                { A_C_Horse_Arabian_White = { name = "White", price = 9500, currency = 0, } },
                { A_C_Horse_Arabian_WarpedBrindle_PC = { name = "Warped Brindle", price = 9000, currency = 0, } },
                { A_C_Horse_Arabian_Grey = { name = "Grey", price = 9000, currency = 0, } },
                { A_C_Horse_Arabian_RedChestnut_PC = { name = "Red Chestnut", price = 8500, currency = 0, } },
                { A_C_Horse_Arabian_RedChestnut = { name = "Red Chestnut/Blaze", price = 8500, currency = 0, } },
            },

            ["Thoroughbred"] = {
                { A_C_Horse_Thoroughbred_BlackChestnut = { name = "Black Chestnut", price = 4000, currency = 0, } },
                { A_C_Horse_Thoroughbred_ReverseDappleBlack = { name = "Reverse Dapple Black", price = 3900, currency = 0, } },
                { A_C_Horse_Thoroughbred_Brindle = { name = "Brindle", price = 3700, currency = 0, } },
                { A_C_Horse_Thoroughbred_BloodBay = { name = "Blood Bay", price = 3700, currency = 0, } },
                { A_C_Horse_Thoroughbred_DappleGrey = { name = "Dapple Grey", price = 3500, currency = 0, } },
            },

            ["Appaloosa"] = {
                { A_C_Horse_Appaloosa_Leopard = { name = "Leopard", price = 500, currency = 0, } },
                { A_C_Horse_Appaloosa_FewSpotted_PC = { name = "Few Spotted", price = 500, currency = 0, } },
                { A_C_Horse_Appaloosa_BrownLeopard = { name = "Brown Leopard", price = 450, currency = 0, } },
                { A_C_Horse_Appaloosa_LeopardBlanket = { name = "Leopard Blanket", price = 450, currency = 0, } },
                { A_C_Horse_Appaloosa_BlackSnowflake = { name = "Black Snowflake", price = 400, currency = 0, } },
                { A_C_Horse_Appaloosa_Blanket = { name = "Blanket", price = 400, currency = 0, } },
            },

            ["American Paint"] = {
                { A_C_Horse_AmericanPaint_SplashedWhite = { name = "Splashed White", price = 400, currency = 0, } },
                { A_C_Horse_AmericanPaint_Greyovero = { name = "Grey Overo", price = 400, currency = 0, } },
                { A_C_Horse_AmericanPaint_Overo = { name = "Overo", price = 450, currency = 0, } },
                { A_C_Horse_AmericanPaint_Tobiano = { name = "Tobiano", price = 450, currency = 0, } },
            },

            ["Criollo"] = {
                { A_C_Horse_Criollo_BayBrindle = { name = "Bay Brindle", price = 3500, currency = 0, } },
                { A_C_Horse_Criollo_BlueRoanOvero = { name = "Blue Roan Overo", price = 3500, currency = 0, } },
                { A_C_Horse_Criollo_BayFrameOvero = { name = "Bay Frame Overo", price = 3000, currency = 0, } },
                { A_C_Horse_Criollo_MarbleSabino = { name = "Marble Sabino", price = 3000, currency = 0, } },
                { A_C_Horse_Criollo_Dun = { name = "Dun", price = 2600, currency = 0, } },
                { A_C_Horse_Criollo_SorrelOvero = { name = "Sorrel Overo", price = 2600, currency = 0, } },
            },

            ["Andalusian"] = {
                { A_C_Horse_Andalusian_Perlino = { name = "Perlino", price = 400, currency = 0, } },
                { A_C_Horse_Andalusian_RoseGray = { name = "Rose Gray", price = 350, currency = 0, } },
                { A_C_Horse_Andalusian_DarkBay = { name = "Dark Bay", price = 300, currency = 0, } },
            },

            ["Ardennes"] = {
                { A_C_Horse_Ardennes_StrawberryRoan = { name = "Strawberry Roan", price = 700, currency = 0, } },
                { A_C_Horse_Ardennes_BayRoan = { name = "Bay Roan", price = 650, currency = 0, } },
                { A_C_Horse_Ardennes_IronGreyRoan = { name = "Iron Grey Roan", price = 650, currency = 0, } },
            },

            ["Dutch Warmblood"] = {
                { A_C_Horse_DutchWarmblood_ChocolateRoan = { name = "Chocolate Roan", price = 4000, currency = 0, } },
                { A_C_Horse_DutchWarmblood_SealBrown = { name = "Seal Brown", price = 3500, currency = 0, } },
                { A_C_Horse_DutchWarmblood_SootyBuckskin = { name = "Sooty Buckskin", price = 3500, currency = 0, } },
            },

            ["Nokota"] = {
                { A_C_Horse_Nokota_ReverseDappleRoan = { name = "Reverse Dapple Roan", price = 700, currency = 0, } },
                { A_C_Horse_Nokota_BlueRoan = { name = "Blue Roan", price = 650, currency = 0, } },
                { A_C_Horse_Nokota_WhiteRoan = { name = "White Roan", price = 650, currency = 0, } },
            },

            ["Belgian"] = {
                { A_C_Horse_Belgian_BlondChestnut = { name = "Blond Chestnut", price = 300, currency = 0, } },
                { A_C_Horse_Belgian_MealyChestnut = { name = "Mealy Chestnut", price = 300, currency = 0, } },
            },

            ["Suffolk Punch"] = {
                { A_C_Horse_SuffolkPunch_RedChestnut = { name = "Red Chestnut", price = 250, currency = 0, } },
                { A_C_Horse_SuffolkPunch_Sorrel = { name = "Sorrel", price = 250, currency = 0, } },
            },

            ["Gypsy Cob"] = {
                { A_C_Horse_GypsyCob_PalominoBlagdon = { name = "Palomino Blagdon", price = 6000, currency = 0, } },
                { A_C_Horse_GypsyCob_Piebald = { name = "Piebald", price = 6000, currency = 0, } },
                { A_C_Horse_GypsyCob_Skewbald = { name = "Skewbald", price = 5500, currency = 0, } },
                { A_C_Horse_GypsyCob_SplashedBay = { name = "Splashed Bay", price = 5500, currency = 0, } },
                { A_C_Horse_GypsyCob_SplashedPiebald = { name = "Splashed Piebald", price = 5000, currency = 0, } },
                { A_C_Horse_GypsyCob_WhiteBlagdon = { name = "White Blagdon", price = 5000, currency = 0, } },
            },

            ["Hungarian Halfbred"] = {
                { A_C_Horse_HungarianHalfbred_LiverChestnut = { name = "Liver Chestnut", price = 2000, currency = 0, } },
                { A_C_Horse_HungarianHalfbred_PiebaldTobiano = { name = "Piebald Tobiano", price = 1800, currency = 0, } },
                { A_C_Horse_HungarianHalfbred_DarkDappleGrey = { name = "Dark Dapple Grey", price = 1600, currency = 0, } },
                { A_C_Horse_HungarianHalfbred_FlaxenChestnut = { name = "Flaxen Chestnut", price = 1600, currency = 0, } },
            },

            ["Murfree Brood"] = {
                { A_C_Horse_MurfreeBrood_Mange_01 = { name = "Mangey 1", price = 50, currency = 0, } },
                { A_C_Horse_MurfreeBrood_Mange_02 = { name = "Mangey 2", price = 50, currency = 0, } },
                { A_C_Horse_MurfreeBrood_Mange_03 = { name = "Mangey 3", price = 50, currency = 0, } },
                { A_C_Horse_MP_Mangy_Backup = { name = "Mangey 4", price = 50, currency = 0, } },
            },

            ["Mules & Donkeys"] = {
                { A_C_HorseMule_01 = { name = "Mule", price = 100, currency = 0, } },
                { A_C_Donkey_01 = { name = "Donkey", price = 30, currency = 0, } },
                { A_C_HorseMulePainted_01 = { name = "Painted Mule", price = 2000, currency = 0, } },
            },

        },
        -- carts available and prices
        carts = {
                    --wagonPrison01x = 200,
                    --warwagon2 = 200,
                    --policeWagongatling01x = 200,
                    --POLICEWAGON01X = 200,
                    --COACH6 = 500,
                    --COACH5 = 500,
                    --COACH4 = 500,
                    buggy03 = 400,
                    buggy02 = 400,
                    buggy01 = 400,
                    CART08 = 500,
                    CART07 = 500,
                    CART06 = 700,
                    CART05 = 500,
                    CART04 = 500,
                    CART03 = 500,
                    CART02 = 500,
                    CART01 = 500,
                    CHUCKWAGON000X = 700,
                    CHUCKWAGON002X = 700,
                    --coal_wagon = 5000,
                    --gatchuck = 3000,
                    --LOGWAGON = 2000,
                    --OILWAGON01X = 1000,
                    --oilWagon02x = 1000,
                    supplywagon = 800,
                    utilliwag = 800,
                    WAGON02X = 700,
                    WAGON03X = 700,
                    WAGON04X = 700,
                    WAGON05X = 600,
                    WAGON06X = 600,
                    --COACH2 = 2000,
                    --COACH3 = 1000,
                    --coach3_cutscene = 1000,
                    --STAGECOACH001X = 3000,
                    --STAGECOACH002X = 3000,
                    --STAGECOACH003X = 3000,
                    --STAGECOACH004X = 3000,
                    --STAGECOACH004_2x = 3000,
                    --STAGECOACH005X = 3000,
                    --STAGECOACH006X = 3000,
                    --armysupplywagon = 9000,
                    --gatchuck_2 = 8000,
                    --bountywagon01x = 1000,
                    huntercart01 = 200,
                    --wagonarmoured01x = 1000,
                    --wagondairy01x = 3000,
                    --wagonDoc01x = 7000,
                    --wagontraveller01x = 6000,
                    wagonWork01x = 500,
        }
    }, 
    -------------------------------------------------------------------------------------------------
    {
        Name = "Rhodes Stable",
        BlipIcon = 1938782895,
        EnterStable = { 1432.97, -1295.39, 76.82, 2.0 },
        StableNPC = { 1434.64, -1294.89, 76.82, 105.08 },
        SpawnHorse = { 1431.56, -1288.21, 76.82, 87.28 },
        CamHorse = { 1431.58, -1292.27, 79.0, -16.0, 0.0, 6.0 },
        CamHorseGear = { 1431.58, -1292.27, 79.0, -16.0, 0.0, 6.0 },
        SpawnCart = { 1414.53, -1294.22, 77.95, 285.53 },
        CamCart = { 1416.7, -1301.12, 81.0, -16.0, 0.0, 6.0 },
        horses = {

        ["American Standardbred"] = {
                { A_C_Horse_AmericanStandardbred_Black = { name = "Black", price = 1100, currency = 0, } },
                { A_C_Horse_AmericanStandardbred_Buckskin = { name = "Buckskin", price = 800, currency = 0, } },
                { A_C_Horse_AmericanStandardbred_Lightbuckskin = { name = "Light Buckskin", price = 850, currency = 0, } },
                { A_C_Horse_AmericanStandardbred_PalominoDapple = { name = "Dapple Palomino", price = 800, currency = 0, } },
                { A_C_Horse_AmericanStandardbred_SilverTailBuckskin = { name = "Silver Tail Buckskin", price = 800, currency = 0, } },
            },

            ["Kentucky Saddler"] = {
                { A_C_Horse_KentuckySaddle_Black = { name = "Black", price = 350, currency = 0, } },
                { A_C_Horse_KentuckySaddle_ButterMilkBuckskin_PC = { name = "Buttermilk Buckskin", price = 350, currency = 0, } },
                { A_C_Horse_KentuckySaddle_ChestnutPinto = { name = "Chestnut Pinto", price = 300, currency = 0, } },
                { A_C_Horse_KentuckySaddle_Grey = { name = "Grey", price = 300, currency = 0, } },
                { A_C_Horse_KentuckySaddle_SilverBay = { name = "Silver Bay", price = 500, currency = 0, } },
            },

            ["Tennessee Walker"] = {
                { A_C_Horse_TennesseeWalker_BlackRabicano = { name = "Black Rabicano", price = 350, currency = 0, } },
                { A_C_Horse_TennesseeWalker_Chestnut = { name = "Chestnut", price = 300, currency = 0, } },
                { A_C_Horse_TennesseeWalker_MahoganyBay = { name = "Mahogany Bay", price = 300, currency = 0, } },
                { A_C_Horse_TennesseeWalker_RedRoan = { name = "Red Roan", price = 300, currency = 0, } },
                { A_C_Horse_TennesseeWalker_GoldPalomino_PC = { name = "Gold Palomino", price = 350, currency = 0, } },
                { A_C_Horse_TennesseeWalker_FlaxenRoan = { name = "Flaxen Roan", price = 300, currency = 0, } },
                { A_C_Horse_TennesseeWalker_DappleBay = { name = "Dapple Bay", price = 300, currency = 0, } },
            },

            ["Turkoman"] = {
                { A_C_Horse_Turkoman_Black = { name = "Black", price = 3800, currency = 0, } },
                { A_C_Horse_Turkoman_Chestnut = { name = "Chestnut", price = 3800, currency = 0, } },
                { A_C_Horse_Turkoman_Grey = { name = "Grey", price = 3800, currency = 0, } },
                { A_C_Horse_Turkoman_Perlino = { name = "Perlino", price = 3800, currency = 0, } },
                { A_C_Horse_Turkoman_Gold = { name = "Gold", price = 3700, currency = 0, } },
                { A_C_Horse_Turkoman_Silver = { name = "Silver", price = 3400, currency = 0, } },
                { A_C_Horse_Turkoman_DarkBay = { name = "Dark Bay", price = 3400, currency = 0, } },
            },

            ["Thoroughbred"] = {
                { A_C_Horse_Thoroughbred_BlackChestnut = { name = "Black Chestnut", price = 4000, currency = 0, } },
                { A_C_Horse_Thoroughbred_ReverseDappleBlack = { name = "Reverse Dapple Black", price = 3900, currency = 0, } },
                { A_C_Horse_Thoroughbred_Brindle = { name = "Brindle", price = 3700, currency = 0, } },
                { A_C_Horse_Thoroughbred_BloodBay = { name = "Blood Bay", price = 3700, currency = 0, } },
                { A_C_Horse_Thoroughbred_DappleGrey = { name = "Dapple Grey", price = 3500, currency = 0, } },
            },

            ["Andalusian"] = {
                { A_C_Horse_Andalusian_Perlino = { name = "Perlino", price = 400, currency = 0, } },
                { A_C_Horse_Andalusian_RoseGray = { name = "Rose Gray", price = 350, currency = 0, } },
                { A_C_Horse_Andalusian_DarkBay = { name = "Dark Bay", price = 300, currency = 0, } },
            },

            ["Dutch Warmblood"] = {
                { A_C_Horse_DutchWarmblood_ChocolateRoan = { name = "Chocolate Roan", price = 4000, currency = 0, } },
                { A_C_Horse_DutchWarmblood_SealBrown = { name = "Seal Brown", price = 3500, currency = 0, } },
                { A_C_Horse_DutchWarmblood_SootyBuckskin = { name = "Sooty Buckskin", price = 3500, currency = 0, } },
            },

            ["Hungarian Halfbred"] = {
                { A_C_Horse_HungarianHalfbred_LiverChestnut = { name = "Liver Chestnut", price = 2000, currency = 0, } },
                { A_C_Horse_HungarianHalfbred_PiebaldTobiano = { name = "Piebald Tobiano", price = 1800, currency = 0, } },
                { A_C_Horse_HungarianHalfbred_DarkDappleGrey = { name = "Dark Dapple Grey", price = 1600, currency = 0, } },
                { A_C_Horse_HungarianHalfbred_FlaxenChestnut = { name = "Flaxen Chestnut", price = 1600, currency = 0, } },
            },

            ["Mules & Donkeys"] = {
                { A_C_HorseMule_01 = { name = "Mule", price = 100, currency = 0, } },
                { A_C_Donkey_01 = { name = "Donkey", price = 30, currency = 0, } },
            },

        },
        carts = {
                    COACH4 = 500,
                    buggy03 = 400,
                    buggy02 = 400,
                    buggy01 = 400,
                    CART08 = 500,
                    CART07 = 500,
                    CART06 = 700,
                    CART05 = 500,
                    CART04 = 500,
                    CART03 = 500,
                    CART02 = 500,
                    CART01 = 500,
                    CHUCKWAGON000X = 700,
                    CHUCKWAGON002X = 700,
                    supplywagon = 800,
                    utilliwag = 800,
                    WAGON02X = 700,
                    WAGON03X = 700,
                    WAGON04X = 700,
                    WAGON05X = 600,
                    WAGON06X = 600,
                    coach3_cutscene = 1000,
                    huntercart01 = 200,
                    wagondairy01x = 3000,
                    wagonDoc01x = 7000,
                    wagontraveller01x = 6000,
                    wagonWork01x = 500,
        }
    }, 
    -------------------------------------------------------------------------
    {
        Name = "Wapiti Stables",
        BlipIcon = 1938782895,
        EnterStable = { 482.06, 2215.17, 247.16, 2.0 },
        StableNPC = { 480.43, 2213.17, 245.90, -44.71 },
        SpawnHorse = { 485.49, 2209.0, 245.70, -27.54 },
        CamHorse = { 483.39, 2211.93, 248.0, -19.14523, 0.0, 225.0 },
        CamHorseGear = { 483.39, 2211.93, 247.58, -19.14523, 0.0, 225.0 },
        SpawnCart = { 489.04, 2212.9, 246.95, -67.0 },
        CamCart = { 483.36, 2219.16, 250.76, -25.0, 0.0, 233.68 },
        horses = {

            ["Mustang"] = {
                { A_C_Horse_Mustang_Buckskin = { name = "Buckskin", price = 1500, currency = 0, } },
                { A_C_Horse_Mustang_ChestnutTovero = { name = "Chestnut Tovero", price = 1500, currency = 0, } },
                { A_C_Horse_Mustang_RedDunOvero = { name = "Red Dun Overo", price = 1200, currency = 0, } },
                { A_C_Horse_Mustang_TigerStripedBay = { name = "Tiger Striped Bay", price = 950, currency = 0, } },
                { A_C_Horse_Mustang_BlackOvero = { name = "Black Overo", price = 1100, currency = 0, } },
                { A_C_Horse_Mustang_GoldenDun = { name = "Golden Dun", price = 900, currency = 0, } },
                { A_C_Horse_Mustang_GrulloDun = { name = "Grullo Dun", price = 900, currency = 0, } },
                { A_C_Horse_Mustang_WildBay = { name = "Wild Bay", price = 900, currency = 0, } },
            },

            ["Appaloosa"] = {
                { A_C_Horse_Appaloosa_Leopard = { name = "Leopard", price = 500, currency = 0, } },
                { A_C_Horse_Appaloosa_FewSpotted_PC = { name = "Few Spotted", price = 500, currency = 0, } },
                { A_C_Horse_Appaloosa_BrownLeopard = { name = "Brown Leopard", price = 450, currency = 0, } },
                { A_C_Horse_Appaloosa_LeopardBlanket = { name = "Leopard Blanket", price = 450, currency = 0, } },
                { A_C_Horse_Appaloosa_BlackSnowflake = { name = "Black Snowflake", price = 400, currency = 0, } },
                { A_C_Horse_Appaloosa_Blanket = { name = "Blanket", price = 400, currency = 0, } },
            },

            ["American Paint"] = {
                { A_C_Horse_AmericanPaint_SplashedWhite = { name = "Splashed White", price = 400, currency = 0, } },
                { A_C_Horse_AmericanPaint_Greyovero = { name = "Grey Overo", price = 400, currency = 0, } },
                { A_C_Horse_AmericanPaint_Overo = { name = "Overo", price = 450, currency = 0, } },
                { A_C_Horse_AmericanPaint_Tobiano = { name = "Tobiano", price = 450, currency = 0, } },
            },

            ["Unique Horses"] = {
                { A_C_Horse_EagleFlies = { name = "Eagle Flies' Horse", price = 600, currency = 0, } },
            },

            ["Criollo"] = {
                { A_C_Horse_Criollo_BayBrindle = { name = "Bay Brindle", price = 3500, currency = 0, } },
                { A_C_Horse_Criollo_BlueRoanOvero = { name = "Blue Roan Overo", price = 3500, currency = 0, } },
                { A_C_Horse_Criollo_BayFrameOvero = { name = "Bay Frame Overo", price = 3000, currency = 0, } },
                { A_C_Horse_Criollo_MarbleSabino = { name = "Marble Sabino", price = 3000, currency = 0, } },
                { A_C_Horse_Criollo_Dun = { name = "Dun", price = 2600, currency = 0, } },
                { A_C_Horse_Criollo_SorrelOvero = { name = "Sorrel Overo", price = 2600, currency = 0, } },
            },

            ["Nokota"] = {
                { A_C_Horse_Nokota_ReverseDappleRoan = { name = "Reverse Dapple Roan", price = 700, currency = 0, } },
                { A_C_Horse_Nokota_BlueRoan = { name = "Blue Roan", price = 650, currency = 0, } },
                { A_C_Horse_Nokota_WhiteRoan = { name = "White Roan", price = 650, currency = 0, } },
            },

            ["Mules & Donkeys"] = {
                { A_C_HorseMule_01 = { name = "Mule", price = 100, currency = 0, } },
            },

        },
        carts = {
                    CART08 = 500,
                    CHUCKWAGON000X = 700,
                    supplywagon = 800,
                    utilliwag = 800,
                    WAGON02X = 700,
                    huntercart01 = 200,
                    wagonWork01x = 500,
        }
    },
    -----------------------------------------------------------
    {
      Name = "Saint Denis Stable",
      BlipIcon = 1938782895,
      EnterStable = { 2510.58, -1456.83, 46.31, 2.0 },
      StableNPC = { 2512.35, -1456.89, 45.2, 91.68 },
      SpawnHorse = { 2508.59, -1449.96, 45.5, 90.09 },
      CamHorse = { 2506.807, -1452.29, 48.61699, -34.77003, 0.0, -35.20742 },
      CamHorseGear = { 2508.876, -1451.953, 48.67999, -35.29771, 0.0, -0.4993192 },
      SpawnCart = { 2503.47, -1441.89, 46.31, 0.24 },
      CamCart = { 2506.428, -1437.7, 50.57832, -39.4497, 0.0, 120.535 },

        horses = {

            ["Breton"] = {
                { A_C_Horse_Breton_GrulloDun = { name = "Grullo Dun", price = 900, currency = 0, } },
                { A_C_Horse_Breton_RedRoan = { name = "Red Roan", price = 850, currency = 0, } },
                { A_C_Horse_Breton_Sorrel = { name = "Sorrel", price = 850, currency = 0, } },
                { A_C_Horse_Breton_SteelGrey = { name = "Steel Grey", price = 850, currency = 0, } },
                { A_C_Horse_Breton_SealBrown = { name = "Seal Brown", price = 900, currency = 0, } },
                { A_C_Horse_Breton_MealyDappleBay = { name = "Mealy Dapple Bay", price = 800, currency = 0, } },
            },

            ["Kladruber"] = {
                { A_C_Horse_Kladruber_Black = { name = "Black", price = 3000, currency = 0, } },
                { A_C_Horse_Kladruber_Silver = { name = "Silver", price = 3200, currency = 0, } },
                { A_C_Horse_Kladruber_Cremello = { name = "Cremello", price = 3200, currency = 0, } },
                { A_C_Horse_Kladruber_DappleRoseGrey = { name = "Dapple Rose Grey", price = 3200, currency = 0, } },
                { A_C_Horse_Kladruber_White = { name = "White", price = 3200, currency = 0, } },
                { A_C_Horse_Kladruber_Grey = { name = "Grey", price = 3000, currency = 0, } },
            },

            ["Turkoman"] = {
                { A_C_Horse_Turkoman_Black = { name = "Black", price = 3800, currency = 0, } },
                { A_C_Horse_Turkoman_Chestnut = { name = "Chestnut", price = 3800, currency = 0, } },
                { A_C_Horse_Turkoman_Grey = { name = "Grey", price = 3800, currency = 0, } },
                { A_C_Horse_Turkoman_Perlino = { name = "Perlino", price = 3800, currency = 0, } },
                { A_C_Horse_Turkoman_Gold = { name = "Gold", price = 3700, currency = 0, } },
                { A_C_Horse_Turkoman_Silver = { name = "Silver", price = 3400, currency = 0, } },
                { A_C_Horse_Turkoman_DarkBay = { name = "Dark Bay", price = 3400, currency = 0, } },
            },

            ["Missouri Fox Trotter"] = {
                { A_C_Horse_MissouriFoxTrotter_BlackTovero = { name = "Black Tovero", price = 2700, currency = 0, } },
                { A_C_Horse_MissouriFoxTrotter_BlueRoan = { name = "Blue Roan", price = 2700, currency = 0, } },
                { A_C_Horse_MissouriFoxTrotter_BuckskinBrindle = { name = "Buckskin Brindle", price = 2700, currency = 0, } },
                { A_C_Horse_MissouriFoxTrotter_DappleGrey = { name = "Dapple Grey", price = 2700, currency = 0, } },
                { A_C_Horse_MissouriFoxTrotter_AmberChampagne = { name = "Amber Champagne", price = 2500, currency = 0, } },
                { A_C_Horse_MissouriFoxTrotter_SableChampagne = { name = "Sable Champagne", price = 2500, currency = 0, } },
                { A_C_Horse_MissouriFoxTrotter_SilverDapplePinto = { name = "Silver Dapple Pinto", price = 2500, currency = 0, } },
            },

            ["Arabian"] = {
                { A_C_Horse_Arabian_RoseGreyBay = { name = "Rose Grey Bay", price = 10000, currency = 0, } },
                { A_C_Horse_Arabian_Black = { name = "Black", price = 9500, currency = 0, } },
                { A_C_Horse_Arabian_White = { name = "White", price = 9500, currency = 0, } },
                { A_C_Horse_Arabian_WarpedBrindle_PC = { name = "Warped Brindle", price = 9000, currency = 0, } },
                { A_C_Horse_Arabian_Grey = { name = "Grey", price = 9000, currency = 0, } },
                { A_C_Horse_Arabian_RedChestnut_PC = { name = "Red Chestnut", price = 8500, currency = 0, } },
                { A_C_Horse_Arabian_RedChestnut = { name = "Red Chestnut", price = 8500, currency = 0, } },
            },

            ["Thoroughbred"] = {
                { A_C_Horse_Thoroughbred_BlackChestnut = { name = "Black Chestnut", price = 4000, currency = 0, } },
                { A_C_Horse_Thoroughbred_ReverseDappleBlack = { name = "Reverse Dapple Black", price = 3900, currency = 0, } },
                { A_C_Horse_Thoroughbred_Brindle = { name = "Brindle", price = 3700, currency = 0, } },
                { A_C_Horse_Thoroughbred_BloodBay = { name = "Blood Bay", price = 3700, currency = 0, } },
                { A_C_Horse_Thoroughbred_DappleGrey = { name = "Dapple Grey", price = 3500, currency = 0, } },
            },

            ["Shire"] = {
                { A_C_Horse_Shire_RavenBlack = { name = "Raven Black", price = 900, currency = 0, } },
                { A_C_Horse_Shire_DarkBay = { name = "Dark Bay", price = 850, currency = 0, } },
                { A_C_Horse_Shire_LightGrey = { name = "Light Grey", price = 850, currency = 0, } },
            },

            ["Ardennes"] = {
                { A_C_Horse_Ardennes_StrawberryRoan = { name = "Strawberry Roan", price = 700, currency = 0, } },
                { A_C_Horse_Ardennes_BayRoan = { name = "Bay Roan", price = 650, currency = 0, } },
                { A_C_Horse_Ardennes_IronGreyRoan = { name = "Iron Grey Roan", price = 650, currency = 0, } },
            },

            ["Gypsy Cob"] = {
                { A_C_Horse_GypsyCob_PalominoBlagdon = { name = "Palomino Blagdon", price = 6000, currency = 0, } },
                { A_C_Horse_GypsyCob_Piebald = { name = "Piebald", price = 6000, currency = 0, } },
                { A_C_Horse_GypsyCob_Skewbald = { name = "Skewbald", price = 5500, currency = 0, } },
                { A_C_Horse_GypsyCob_SplashedBay = { name = "Splashed Bay", price = 5500, currency = 0, } },
                { A_C_Horse_GypsyCob_SplashedPiebald = { name = "Splashed Piebald", price = 5000, currency = 0, } },
                { A_C_Horse_GypsyCob_WhiteBlagdon = { name = "White Blagdon", price = 5000, currency = 0, } },
            },

            ["Mules & Donkeys"] = {
                { A_C_HorseMule_01 = { name = "Mule", price = 100, currency = 0, } },
                { A_C_Donkey_01 = { name = "Donkey", price = 30, currency = 0, } },
                { A_C_HorseMulePainted_01 = { name = "Painted Mule", price = 2000, currency = 0, } },
            },

        },
        -- carts available and prices
        carts = {
                    --wagonPrison01x = 200,
                    --warwagon2 = 200,
                    --policeWagongatling01x = 200,
                    --POLICEWAGON01X = 200,
                    COACH6 = 500,
                    COACH5 = 500,
                    COACH4 = 500,
                    buggy03 = 400,
                    buggy02 = 400,
                    buggy01 = 400,
                    CART08 = 500,
                    CART07 = 500,
                    CART06 = 700,
                    CART05 = 500,
                    CART04 = 500,
                    CART03 = 500,
                    CART02 = 500,
                    CART01 = 500,
                    CHUCKWAGON000X = 700,
                    CHUCKWAGON002X = 700,
                    --coal_wagon = 5000,
                    --gatchuck = 3000,
                    --LOGWAGON = 2000,
                    OILWAGON01X = 1000,
                    oilWagon02x = 1000,
                    supplywagon = 800,
                    utilliwag = 800,
                    WAGON02X = 700,
                    WAGON03X = 700,
                    WAGON04X = 700,
                    WAGON05X = 600,
                    WAGON06X = 600,
                    COACH2 = 2000,
                    COACH3 = 1000,
                    coach3_cutscene = 1000,
                    STAGECOACH001X = 3000,
                    STAGECOACH002X = 3000,
                    STAGECOACH003X = 3000,
                    STAGECOACH004X = 3000,
                    STAGECOACH004_2x = 3000,
                    STAGECOACH005X = 3000,
                    STAGECOACH006X = 3000,
                    --armysupplywagon = 9000,
                    --gatchuck_2 = 8000,
                    --bountywagon01x = 1000,
                    --huntercart01 = 200,
                    --wagonarmoured01x = 1000,
                    --wagondairy01x = 3000,
                    --wagonDoc01x = 7000,
                    wagontraveller01x = 6000,
                    wagonWork01x = 500,
        }

    },
    {
      Name = "Strawberry Stable",
      BlipIcon = 1938782895,
      EnterStable = { -1816.81, -561.99, 156.07, 2.0 },
      StableNPC = { -1818.45, -564.83, 155.06, 347.22 },
      SpawnHorse = { -1820.26, -555.84, 155.16, 163.01 },
      CamHorse = { -1819.512, -558.6999, 157.6765, -23.95241, 0.0, 28.46066 },
      CamHorseGear = { -1819.512, -558.6999, 157.6765, -23.95241, 0.0, 28.46066 },
      SpawnCart = { -1821.46, -561.41, 155.06, 256.24 },
      CamCart = { -1816.372, -560.2017, 157.6678, -22.02157, 0.0, 124.3779 },

              horses = {

                  ["Norfolk Roadster"] = {
                      { A_C_Horse_NorfolkRoadster_RoseGrey = { name = "Rose Grey", price = 2700, currency = 0, } },
                      { A_C_Horse_NorfolkRoadster_SpeckledGrey = { name = "Speckled Grey", price = 2500, currency = 0, } },
                      { A_C_Horse_NorfolkRoadster_SpottedTricolor = { name = "Spotted Tricolor", price = 3500, currency = 0, } },
                      { A_C_Horse_NorfolkRoadster_Black = { name = "Black", price = 3500, currency = 0, } },
                      { A_C_Horse_NorfolkRoadster_DappledBuckskin = { name = "Dappled Buckskin", price = 3500, currency = 0, } },
                      { A_C_Horse_NorfolkRoadster_PiebaldRoan = { name = "Piebald Roan", price = 2700, currency = 0, } },
                  },

                  ["Missouri Fox Trotter"] = {
                      { A_C_Horse_MissouriFoxTrotter_BlackTovero = { name = "Black Tovero", price = 2700, currency = 0, } },
                      { A_C_Horse_MissouriFoxTrotter_BlueRoan = { name = "Blue Roan", price = 2700, currency = 0, } },
                      { A_C_Horse_MissouriFoxTrotter_BuckskinBrindle = { name = "Buckskin Brindle", price = 2700, currency = 0, } },
                      { A_C_Horse_MissouriFoxTrotter_DappleGrey = { name = "Dapple Grey", price = 2700, currency = 0, } },
                      { A_C_Horse_MissouriFoxTrotter_AmberChampagne = { name = "Amber Champagne", price = 2500, currency = 0, } },
                      { A_C_Horse_MissouriFoxTrotter_SableChampagne = { name = "Sable Champagne", price = 2500, currency = 0, } },
                      { A_C_Horse_MissouriFoxTrotter_SilverDapplePinto = { name = "Silver Dapple Pinto", price = 2500, currency = 0, } },
                  },

                  ["Andalusian"] = {
                      { A_C_Horse_Andalusian_Perlino = { name = "Perlino", price = 400, currency = 0, } },
                      { A_C_Horse_Andalusian_RoseGray = { name = "Rose Gray", price = 350, currency = 0, } },
                      { A_C_Horse_Andalusian_DarkBay = { name = "Dark Bay", price = 300, currency = 0, } },
                  },

                  ["Ardennes"] = {
                      { A_C_Horse_Ardennes_StrawberryRoan = { name = "Strawberry Roan", price = 700, currency = 0, } },
                      { A_C_Horse_Ardennes_BayRoan = { name = "Bay Roan", price = 650, currency = 0, } },
                      { A_C_Horse_Ardennes_IronGreyRoan = { name = "Iron Grey Roan", price = 650, currency = 0, } },
                  },

                  ["Dutch Warmblood"] = {
                      { A_C_Horse_DutchWarmblood_ChocolateRoan = { name = "Chocolate Roan", price = 4000, currency = 0, } },
                      { A_C_Horse_DutchWarmblood_SealBrown = { name = "Seal Brown", price = 3500, currency = 0, } },
                      { A_C_Horse_DutchWarmblood_SootyBuckskin = { name = "Sooty Buckskin", price = 3500, currency = 0, } },
                  },

                  ["Belgian"] = {
                      { A_C_Horse_Belgian_BlondChestnut = { name = "Blond Chestnut", price = 300, currency = 0, } },
                      { A_C_Horse_Belgian_MealyChestnut = { name = "Mealy Chestnut", price = 300, currency = 0, } },
                  },

                  ["Suffolk Punch"] = {
                      { A_C_Horse_SuffolkPunch_RedChestnut = { name = "Red Chestnut", price = 250, currency = 0, } },
                      { A_C_Horse_SuffolkPunch_Sorrel = { name = "Sorrel", price = 250, currency = 0, } },
                  },

                  ["Hungarian Halfbred"] = {
                      { A_C_Horse_HungarianHalfbred_LiverChestnut = { name = "Liver Chestnut", price = 2000, currency = 0, } },
                      { A_C_Horse_HungarianHalfbred_PiebaldTobiano = { name = "Piebald Tobiano", price = 1800, currency = 0, } },
                      { A_C_Horse_HungarianHalfbred_DarkDappleGrey = { name = "Dark Dapple Grey", price = 1600, currency = 0, } },
                      { A_C_Horse_HungarianHalfbred_FlaxenChestnut = { name = "Flaxen Chestnut", price = 1600, currency = 0, } },
                  },

                  ["Mules & Donkeys"] = {
                      { A_C_HorseMule_01 = { name = "Mule", price = 100, currency = 0, } },
                      { A_C_Donkey_01 = { name = "Donkey", price = 30, currency = 0, } },
                      { A_C_HorseMulePainted_01 = { name = "Painted Mule", price = 2000, currency = 0, } },
                  },

              },
        -- carts available and prices
        carts = {
                    buggy03 = 400,
                    buggy02 = 400,
                    buggy01 = 400,
                    CART08 = 500,
                    CART07 = 500,
                    CART06 = 700,
                    CART05 = 500,
                    CART04 = 500,
                    CART03 = 500,
                    CART02 = 500,
                    CART01 = 500,
                    CHUCKWAGON000X = 700,
                    CHUCKWAGON002X = 700,
                    LOGWAGON = 2000,
                    supplywagon = 800,
                    utilliwag = 800,
                    WAGON02X = 700,
                    WAGON03X = 700,
                    WAGON04X = 700,
                    WAGON05X = 600,
                    WAGON06X = 600,
                    STAGECOACH003X = 3000,
                    STAGECOACH006X = 3000,
                    bountywagon01x = 1000,
                    huntercart01 = 200,
                    wagonWork01x = 500,
        },

    },
    {
      Name = "Blackwater Stable",
      BlipIcon = 1938782895,
      EnterStable = { -876.57, -1365.1, 43.53, 2.0 },
      StableNPC = { -878.35, -1364.81, 42.53, 266.28 },
      SpawnHorse = { -864.25, -1361.8, 42.7, 177.48 },
      CamHorse = { -862.6163, -1362.927, 45.58158, -40.96593, 0.0, 71.8129 },
      CamHorseGear = { -862.6163, -1362.927, 45.58158, -40.96593, 0.0, 71.8129 },
      SpawnCart = { -872.58, -1366.57, 42.53, 270.35 },
      CamCart = { -869.7852, -1361.103, 45.26991, -17.11994, 0.0, 161.4039 },

              horses = {

                  ["American Standardbred"] = {
                      { A_C_Horse_AmericanStandardbred_Black = { name = "Black", price = 1100, currency = 0, } },
                      { A_C_Horse_AmericanStandardbred_Buckskin = { name = "Buckskin", price = 800, currency = 0, } },
                      { A_C_Horse_AmericanStandardbred_Lightbuckskin = { name = "Light Buckskin", price = 850, currency = 0, } },
                      { A_C_Horse_AmericanStandardbred_PalominoDapple = { name = "Dapple Palomino", price = 800, currency = 0, } },
                      { A_C_Horse_AmericanStandardbred_SilverTailBuckskin = { name = "Silver Tail Buckskin", price = 800, currency = 0, } },
                  },

                  ["Breton"] = {
                      { A_C_Horse_Breton_GrulloDun = { name = "Grullo Dun", price = 900, currency = 0, } },
                      { A_C_Horse_Breton_RedRoan = { name = "Red Roan", price = 850, currency = 0, } },
                      { A_C_Horse_Breton_Sorrel = { name = "Sorrel", price = 850, currency = 0, } },
                      { A_C_Horse_Breton_SteelGrey = { name = "Steel Grey", price = 850, currency = 0, } },
                      { A_C_Horse_Breton_SealBrown = { name = "Seal Brown", price = 900, currency = 0, } },
                      { A_C_Horse_Breton_MealyDappleBay = { name = "Mealy Dapple Bay", price = 800, currency = 0, } },
                  },

                  ["Kentucky Saddler"] = {
                      { A_C_Horse_KentuckySaddle_Black = { name = "Black", price = 350, currency = 0, } },
                      { A_C_Horse_KentuckySaddle_ButterMilkBuckskin_PC = { name = "Buttermilk Buckskin", price = 350, currency = 0, } },
                      { A_C_Horse_KentuckySaddle_ChestnutPinto = { name = "Chestnut Pinto", price = 300, currency = 0, } },
                      { A_C_Horse_KentuckySaddle_Grey = { name = "Grey", price = 300, currency = 0, } },
                      { A_C_Horse_KentuckySaddle_SilverBay = { name = "Silver Bay", price = 500, currency = 0, } },
                  },

                  ["Kladruber"] = {
                      { A_C_Horse_Kladruber_Black = { name = "Black", price = 3000, currency = 0, } },
                      { A_C_Horse_Kladruber_Silver = { name = "Silver", price = 3200, currency = 0, } },
                      { A_C_Horse_Kladruber_Cremello = { name = "Cremello", price = 3200, currency = 0, } },
                      { A_C_Horse_Kladruber_DappleRoseGrey = { name = "Dapple Rose Grey", price = 3200, currency = 0, } },
                      { A_C_Horse_Kladruber_White = { name = "White", price = 3200, currency = 0, } },
                      { A_C_Horse_Kladruber_Grey = { name = "Grey", price = 3000, currency = 0, } },
                  },

                  ["Morgan"] = {
                      { A_C_Horse_Morgan_FlaxenChestnut = { name = "Flaxen Chestnut", price = 100, currency = 0, } },
                      { A_C_Horse_Morgan_LiverChestnut_PC = { name = "Liver Chestnut", price = 500, currency = 0, } },
                      { A_C_Horse_Morgan_Bay = { name = "Bay", price = 300, currency = 0, } },
                      { A_C_Horse_Morgan_BayRoan = { name = "Bay Roan", price = 300, currency = 0, } },
                      { A_C_Horse_Morgan_Palomino = { name = "Palomino", price = 200, currency = 0, } },
                  },

                  ["Norfolk Roadster"] = {
                      { A_C_Horse_NorfolkRoadster_RoseGrey = { name = "Rose Grey", price = 2700, currency = 0, } },
                      { A_C_Horse_NorfolkRoadster_SpeckledGrey = { name = "Speckled Grey", price = 2500, currency = 0, } },
                      { A_C_Horse_NorfolkRoadster_SpottedTricolor = { name = "Spotted Tricolor", price = 3500, currency = 0, } },
                      { A_C_Horse_NorfolkRoadster_Black = { name = "Black", price = 3500, currency = 0, } },
                      { A_C_Horse_NorfolkRoadster_DappledBuckskin = { name = "Dappled Buckskin", price = 3500, currency = 0, } },
                      { A_C_Horse_NorfolkRoadster_PiebaldRoan = { name = "Piebald Roan", price = 2700, currency = 0, } },
                  },

                  ["Shire"] = {
                      { A_C_Horse_Shire_DarkBay = { name = "Dark Bay", price = 450, currency = 0, } },
                      { A_C_Horse_Shire_LightGrey = { name = "Light Grey", price = 500, currency = 0, } },
                      { A_C_Horse_Shire_RavenBlack = { name = "Raven Black", price = 550, currency = 0, } },
                  },

                  ["Tennessee Walker"] = {
                      { A_C_Horse_TennesseeWalker_BlackRabicano = { name = "Black Rabicano", price = 350, currency = 0, } },
                      { A_C_Horse_TennesseeWalker_Chestnut = { name = "Chestnut", price = 300, currency = 0, } },
                      { A_C_Horse_TennesseeWalker_MahoganyBay = { name = "Mahogany Bay", price = 300, currency = 0, } },
                      { A_C_Horse_TennesseeWalker_RedRoan = { name = "Red Roan", price = 300, currency = 0, } },
                      { A_C_Horse_TennesseeWalker_GoldPalomino_PC = { name = "Gold Palomino", price = 350, currency = 0, } },
                      { A_C_Horse_TennesseeWalker_FlaxenRoan = { name = "Flaxen Roan", price = 300, currency = 0, } },
                      { A_C_Horse_TennesseeWalker_DappleBay = { name = "Dapple Bay", price = 300, currency = 0, } },
                  },

                  ["Turkoman"] = {
                      { A_C_Horse_Turkoman_Black = { name = "Black", price = 3800, currency = 0, } },
                      { A_C_Horse_Turkoman_Chestnut = { name = "Chestnut", price = 3800, currency = 0, } },
                      { A_C_Horse_Turkoman_Grey = { name = "Grey", price = 3800, currency = 0, } },
                      { A_C_Horse_Turkoman_Perlino = { name = "Perlino", price = 3800, currency = 0, } },
                      { A_C_Horse_Turkoman_Gold = { name = "Gold", price = 3700, currency = 0, } },
                      { A_C_Horse_Turkoman_Silver = { name = "Silver", price = 3400, currency = 0, } },
                      { A_C_Horse_Turkoman_DarkBay = { name = "Dark Bay", price = 3400, currency = 0, } },
                  },

                  ["Mustang"] = {
                      { A_C_Horse_Mustang_Buckskin = { name = "Buckskin", price = 1500, currency = 0, } },
                      { A_C_Horse_Mustang_ChestnutTovero = { name = "Chestnut Tovero", price = 1500, currency = 0, } },
                      { A_C_Horse_Mustang_RedDunOvero = { name = "Red Dun Overo", price = 1200, currency = 0, } },
                      { A_C_Horse_Mustang_BlackOvero = { name = "Black Overo", price = 1100, currency = 0, } },
                      { A_C_Horse_Mustang_TigerStripedBay = { name = "Tiger Striped Bay", price = 950, currency = 0, } },
                      { A_C_Horse_Mustang_GoldenDun = { name = "Golden Dun", price = 900, currency = 0, } },
                      { A_C_Horse_Mustang_GrulloDun = { name = "Grullo Dun", price = 900, currency = 0, } },
                      { A_C_Horse_Mustang_WildBay = { name = "Wild Bay", price = 900, currency = 0, } },
                  },

                  ["Missouri Fox Trotter"] = {
                      { A_C_Horse_MissouriFoxTrotter_BlackTovero = { name = "Black Tovero", price = 2700, currency = 0, } },
                      { A_C_Horse_MissouriFoxTrotter_BlueRoan = { name = "Blue Roan", price = 2700, currency = 0, } },
                      { A_C_Horse_MissouriFoxTrotter_BuckskinBrindle = { name = "Buckskin Brindle", price = 2700, currency = 0, } },
                      { A_C_Horse_MissouriFoxTrotter_DappleGrey = { name = "Dapple Grey", price = 2700, currency = 0, } },
                      { A_C_Horse_MissouriFoxTrotter_AmberChampagne = { name = "Amber Champagne", price = 2500, currency = 0, } },
                      { A_C_Horse_MissouriFoxTrotter_SableChampagne = { name = "Sable Champagne", price = 2500, currency = 0, } },
                      { A_C_Horse_MissouriFoxTrotter_SilverDapplePinto = { name = "Silver Dapple Pinto", price = 2500, currency = 0, } },
                  },

                  ["Arabian"] = {
                      { A_C_Horse_Arabian_RoseGreyBay = { name = "Rose Grey Bay", price = 10000, currency = 0, } },
                      { A_C_Horse_Arabian_Black = { name = "Black", price = 9500, currency = 0, } },
                      { A_C_Horse_Arabian_White = { name = "White", price = 9500, currency = 0, } },
                      { A_C_Horse_Arabian_WarpedBrindle_PC = { name = "Warped Brindle", price = 9000, currency = 0, } },
                      { A_C_Horse_Arabian_Grey = { name = "Grey", price = 9000, currency = 0, } },
                      { A_C_Horse_Arabian_RedChestnut_PC = { name = "Red Chestnut", price = 8500, currency = 0, } },
                      { A_C_Horse_Arabian_RedChestnut = { name = "Red Chestnut", price = 8500, currency = 0, } },
                  },

                  ["Thoroughbred"] = {
                      { A_C_Horse_Thoroughbred_BlackChestnut = { name = "Black Chestnut", price = 4000, currency = 0, } },
                      { A_C_Horse_Thoroughbred_ReverseDappleBlack = { name = "Reverse Dapple Black", price = 3900, currency = 0, } },
                      { A_C_Horse_Thoroughbred_Brindle = { name = "Brindle", price = 3700, currency = 0, } },
                      { A_C_Horse_Thoroughbred_BloodBay = { name = "Blood Bay", price = 3700, currency = 0, } },
                      { A_C_Horse_Thoroughbred_DappleGrey = { name = "Dapple Grey", price = 3500, currency = 0, } },
                  },

                  ["Appaloosa"] = {
                      { A_C_Horse_Appaloosa_Leopard = { name = "Leopard", price = 500, currency = 0, } },
                      { A_C_Horse_Appaloosa_FewSpotted_PC = { name = "Few Spotted", price = 500, currency = 0, } },
                      { A_C_Horse_Appaloosa_BrownLeopard = { name = "Brown Leopard", price = 450, currency = 0, } },
                      { A_C_Horse_Appaloosa_LeopardBlanket = { name = "Leopard Blanket", price = 450, currency = 0, } },
                      { A_C_Horse_Appaloosa_BlackSnowflake = { name = "Black Snowflake", price = 400, currency = 0, } },
                      { A_C_Horse_Appaloosa_Blanket = { name = "Blanket", price = 400, currency = 0, } },
                  },

                  ["American Paint"] = {
                      { A_C_Horse_AmericanPaint_SplashedWhite = { name = "Splashed White", price = 400, currency = 0, } },
                      { A_C_Horse_AmericanPaint_Greyovero = { name = "Grey Overo", price = 400, currency = 0, } },
                      { A_C_Horse_AmericanPaint_Overo = { name = "Overo", price = 450, currency = 0, } },
                      { A_C_Horse_AmericanPaint_Tobiano = { name = "Tobiano", price = 450, currency = 0, } },
                  },

                  ["Criollo"] = {
                      { A_C_Horse_Criollo_BayBrindle = { name = "Bay Brindle", price = 3500, currency = 0, } },
                      { A_C_Horse_Criollo_BlueRoanOvero = { name = "Blue Roan Overo", price = 3500, currency = 0, } },
                      { A_C_Horse_Criollo_BayFrameOvero = { name = "Bay Frame Overo", price = 3000, currency = 0, } },
                      { A_C_Horse_Criollo_MarbleSabino = { name = "Marble Sabino", price = 3000, currency = 0, } },
                      { A_C_Horse_Criollo_Dun = { name = "Dun", price = 2600, currency = 0, } },
                      { A_C_Horse_Criollo_SorrelOvero = { name = "Sorrel Overo", price = 2600, currency = 0, } },
                  },

                  ["Andalusian"] = {
                      { A_C_Horse_Andalusian_Perlino = { name = "Perlino", price = 400, currency = 0, } },
                      { A_C_Horse_Andalusian_RoseGray = { name = "Rose Gray", price = 350, currency = 0, } },
                      { A_C_Horse_Andalusian_DarkBay = { name = "Dark Bay", price = 300, currency = 0, } },
                  },

                  ["Ardennes"] = {
                      { A_C_Horse_Ardennes_StrawberryRoan = { name = "Strawberry Roan", price = 700, currency = 0, } },
                      { A_C_Horse_Ardennes_BayRoan = { name = "Bay Roan", price = 650, currency = 0, } },
                      { A_C_Horse_Ardennes_IronGreyRoan = { name = "Iron Grey Roan", price = 650, currency = 0, } },
                  },

                  ["Dutch Warmblood"] = {
                      { A_C_Horse_DutchWarmblood_ChocolateRoan = { name = "Chocolate Roan", price = 4000, currency = 0, } },
                      { A_C_Horse_DutchWarmblood_SealBrown = { name = "Seal Brown", price = 3500, currency = 0, } },
                      { A_C_Horse_DutchWarmblood_SootyBuckskin = { name = "Sooty Buckskin", price = 3500, currency = 0, } },
                  },

                  ["Nokota"] = {
                      { A_C_Horse_Nokota_ReverseDappleRoan = { name = "Reverse Dapple Roan", price = 700, currency = 0, } },
                      { A_C_Horse_Nokota_BlueRoan = { name = "Blue Roan", price = 650, currency = 0, } },
                      { A_C_Horse_Nokota_WhiteRoan = { name = "White Roan", price = 650, currency = 0, } },
                  },

                  ["Belgian"] = {
                      { A_C_Horse_Belgian_BlondChestnut = { name = "Blond Chestnut", price = 300, currency = 0, } },
                      { A_C_Horse_Belgian_MealyChestnut = { name = "Mealy Chestnut", price = 300, currency = 0, } },
                  },

                  ["Suffolk Punch"] = {
                      { A_C_Horse_SuffolkPunch_RedChestnut = { name = "Red Chestnut", price = 250, currency = 0, } },
                      { A_C_Horse_SuffolkPunch_Sorrel = { name = "Sorrel", price = 250, currency = 0, } },
                  },

                  ["Gypsy Cob"] = {
                      { A_C_Horse_GypsyCob_PalominoBlagdon = { name = "Palomino Blagdon", price = 6000, currency = 0, } },
                      { A_C_Horse_GypsyCob_Piebald = { name = "Piebald", price = 6000, currency = 0, } },
                      { A_C_Horse_GypsyCob_Skewbald = { name = "Skewbald", price = 5500, currency = 0, } },
                      { A_C_Horse_GypsyCob_SplashedBay = { name = "Splashed Bay", price = 5500, currency = 0, } },
                      { A_C_Horse_GypsyCob_SplashedPiebald = { name = "Splashed Piebald", price = 5000, currency = 0, } },
                      { A_C_Horse_GypsyCob_WhiteBlagdon = { name = "White Blagdon", price = 5000, currency = 0, } },
                  },

                  ["Hungarian Halfbred"] = {
                      { A_C_Horse_HungarianHalfbred_LiverChestnut = { name = "Liver Chestnut", price = 2000, currency = 0, } },
                      { A_C_Horse_HungarianHalfbred_PiebaldTobiano = { name = "Piebald Tobiano", price = 1800, currency = 0, } },
                      { A_C_Horse_HungarianHalfbred_DarkDappleGrey = { name = "Dark Dapple Grey", price = 1600, currency = 0, } },
                      { A_C_Horse_HungarianHalfbred_FlaxenChestnut = { name = "Flaxen Chestnut", price = 1600, currency = 0, } },
                  },

                  ["Murfree Brood"] = {
                      { A_C_Horse_MurfreeBrood_Mange_01 = { name = "Mangey 1", price = 50, currency = 0, } },
                      { A_C_Horse_MurfreeBrood_Mange_02 = { name = "Mangey 2", price = 50, currency = 0, } },
                      { A_C_Horse_MurfreeBrood_Mange_03 = { name = "Mangey 3", price = 50, currency = 0, } },
                      { A_C_Horse_MP_Mangy_Backup = { name = "Mangey 4", price = 50, currency = 0, } },
                  },

                  ["Mules & Donkeys"] = {
                      { A_C_HorseMule_01 = { name = "Mule", price = 100, currency = 0, } },
                      { A_C_Donkey_01 = { name = "Donkey", price = 30, currency = 0, } },
                      { A_C_HorseMulePainted_01 = { name = "Painted Mule", price = 2000, currency = 0, } },
                  },

              },
        -- carts available and prices
        carts = {
                    COACH6 = 500,
                    COACH5 = 500,
                    buggy03 = 400,
                    buggy01 = 400,
                    CART06 = 700,
                    CART05 = 500,
                    CART02 = 500,
                    CART01 = 500,
                    CHUCKWAGON002X = 700,
                    supplywagon = 800,
                    utilliwag = 800,
                    WAGON02X = 700,
                    WAGON03X = 700,
                    WAGON04X = 700,
                    WAGON05X = 600,
                    WAGON06X = 600,
                    COACH2 = 2000,
                    coach3_cutscene = 1000,
                    STAGECOACH004_2x = 3000,
                    armysupplywagon = 9000,
                    bountywagon01x = 1000,
                    huntercart01 = 200,
                    wagondairy01x = 3000,
                    wagonDoc01x = 7000,
                    wagontraveller01x = 6000,
        },

    },
    {
      Name = "Tumbleweed Stable",
      BlipIcon = 1938782895,
      EnterStable = { -5514.24, -3041.81, -2.39, 2.0 },
      StableNPC = { -5515.07, -3039.51, -3.39, 179.88 },
      SpawnHorse = { -5519.47, -3039.32, -3.31, 181.62 },
      CamHorse = { -5517.651, -3041.113, -0.50949, -33.14523, 0.0, 55.47822 },
      CamHorseGear = { -5517.651, -3041.113, -0.50949, -33.14523, 0.0, 55.47822 },
      SpawnCart = { -5520.65, -3044.3, -3.39, 270.83 },
      CamCart = { -5514.191, -3040.633, -0.5108569, -18.79705, 0.0, 141.3175 },

              horses = {

                  ["American Standardbred"] = {
                      { A_C_Horse_AmericanStandardbred_Black = { name = "Black", price = 1100, currency = 0, } },
                      { A_C_Horse_AmericanStandardbred_SilverTailBuckskin = { name = "Silver Tail Buckskin", price = 800, currency = 0, } },
                  },

                  ["Breton"] = {
                      { A_C_Horse_Breton_GrulloDun = { name = "Grullo Dun", price = 900, currency = 0, } },
                  },

                  ["Kentucky Saddler"] = {
                      { A_C_Horse_KentuckySaddle_Black = { name = "Black", price = 350, currency = 0, } },
                      { A_C_Horse_KentuckySaddle_ButterMilkBuckskin_PC = { name = "Buttermilk Buckskin", price = 350, currency = 0, } },
                  },

                  ["Morgan"] = {
                      { A_C_Horse_Morgan_Bay = { name = "Bay", price = 300, currency = 0, } },
                      { A_C_Horse_Morgan_Palomino = { name = "Palomino", price = 200, currency = 0, } },
                  },

                  ["Shire"] = {
                      { A_C_Horse_Shire_DarkBay = { name = "Dark Bay", price = 450, currency = 0, } },
                  },

                  ["Tennessee Walker"] = {
                      { A_C_Horse_TennesseeWalker_Chestnut = { name = "Chestnut", price = 300, currency = 0, } },
                      { A_C_Horse_TennesseeWalker_FlaxenRoan = { name = "Flaxen Roan", price = 300, currency = 0, } },
                  },

                  ["Mustang"] = {
                      { A_C_Horse_Mustang_TigerStripedBay = { name = "Tiger Striped Bay", price = 950, currency = 0, } },
                      { A_C_Horse_Mustang_GoldenDun = { name = "Golden Dun", price = 900, currency = 0, } },
                      { A_C_Horse_Mustang_GrulloDun = { name = "Grullo Dun", price = 900, currency = 0, } },
                      { A_C_Horse_Mustang_BlackOvero = { name = "Black Overo", price = 1100, currency = 0, } },
                      { A_C_Horse_Mustang_WildBay = { name = "Wild Bay", price = 900, currency = 0, } },
                  },

                  ["Arabian"] = {
                      { A_C_Horse_Arabian_WarpedBrindle_PC = { name = "Warped Brindle", price = 9000, currency = 0, } },
                  },

                  ["Belgian"] = {
                      { A_C_Horse_Belgian_BlondChestnut = { name = "Blond Chestnut", price = 300, currency = 0, } },
                  },

                  ["Unique Horses"] = {
                      { MP_Horse_Owlhootvictim_01 = { name = "Owlhoot Victim Horse", price = 500, currency = 0, } },
                  },

                  ["Suffolk Punch"] = {
                      { A_C_Horse_SuffolkPunch_RedChestnut = { name = "Red Chestnut", price = 250, currency = 0, } },
                  },

                  ["Murfree Brood"] = {
                      { A_C_Horse_MurfreeBrood_Mange_01 = { name = "Mangey 1", price = 50, currency = 0, } },
                      { A_C_Horse_MurfreeBrood_Mange_02 = { name = "Mangey 2", price = 50, currency = 0, } },
                      { A_C_Horse_MurfreeBrood_Mange_03 = { name = "Mangey 3", price = 50, currency = 0, } },
                      { A_C_Horse_MP_Mangy_Backup = { name = "Mangey 4", price = 50, currency = 0, } },
                  },

                  ["Mules & Donkeys"] = {
                      { A_C_HorseMule_01 = { name = "Mule", price = 100, currency = 0, } },
                      { A_C_Donkey_01 = { name = "Donkey", price = 30, currency = 0, } },
                  },

              },
        -- carts available and prices
        carts = {
                    buggy01 = 400,
                    CART08 = 500,
                    supplywagon = 800,
                    utilliwag = 800,
                    WAGON02X = 700,
                    huntercart01 = 200,
                    wagonWork01x = 500,
        },

    },


    }
}
