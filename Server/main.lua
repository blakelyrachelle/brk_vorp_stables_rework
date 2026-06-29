-- SERVER_MAIN
local db = exports.oxmysql
local VorpCore = exports.vorp_core:GetCore()
local VorpInv = exports.vorp_inventory:vorp_inventoryApi()

local allowedResourceNames = {
    ["brk_vorp_stables_rework"] = true,
    ["vorp_stables"] = true
}

local currentResourceName = GetCurrentResourceName()

local function IsValidResourceName(src)
    if allowedResourceNames[currentResourceName] then
        return true
    end
    print(("^1[BRK Vorp Stables]^7 Invalid resource folder name: '^3%s^7'."):format(currentResourceName))
    print("^1[BRK Vorp Stables]^7 Expected folder name: '^2brk_vorp_stables_rework^7' or '^2vorp_stables^7'.")
    print("^3[BRK Vorp Stables]^7 Stable loading depends on the expected resource name.")
    if src then
        TriggerClientEvent("vorp:TipRight", src, "Stable resource folder name is invalid. Check server console.", 5000)
    end
    return false
end

CreateThread(function()
    if VorpCore.RegisterJobs then
        -- only register if jobs are actually used
        if Config.JobRequired then
            local jobsData <const> = {}
            if Config.JobForHorseDealer and Config.JobForHorseDealer ~= "" then 
                jobsData[Config.JobForHorseDealer] = {}
            end
            if Config.JobForCartDealer and Config.JobForCartDealer ~= "" then 
                jobsData[Config.JobForCartDealer] = {}
            end  
            if Config.JobForAllDealer and Config.JobForAllDealer ~= "" then 
                jobsData[Config.JobForAllDealer] = {}
            end  
            
            if next(jobsData) then
                VorpCore.RegisterJobs(jobsData, GetCurrentResourceName())
            end
        end
    else
        -- wait for some time to print this
        -- print("^1vorp_stables: server: RegisterJobs not found update vorp core to the latest version^7")
    end
end)

RegisterNetEvent(Events.loadStable, function(charid)
    local src = source
    if not IsValidResourceName(src) then
        return
    end
    LoadStableContent(src, charid, true)
end)

RegisterNetEvent(Events.loadStableRuntime, function()
    local src = source
    if not IsValidResourceName(src) then
        return
    end
    local id = VorpCore.getUser(src).getUsedCharacter.charIdentifier
    LoadStableContent(src, id, true)
end)

-- Everytime a DB action is made, this function gets called to sync data on the client with data in the DB
function LoadStableContent(src, charId, regInvs)
    db:execute("SELECT * FROM stables WHERE `charidentifier`=? OR `status` LIKE '%\"transferTarget\":?,%' OR `status` LIKE '%\"transferTarget\":?}'", { charId, charId, charId }, function(result)
        -- Retrieve owned rides, and rides transfered to this player
    db:execute("SELECT `complements` FROM horse_complements WHERE `charidentifier`=?", { charId }, function(compsResult)

    db:execute("SELECT * FROM horse_tack_storage WHERE `charidentifier` = ?", { charId }, function(tackStorage)

        db:execute("SELECT * FROM horse_tack_loadout WHERE `charidentifier` = ?", { charId }, function(tackLoadout)

            local comps

            if #compsResult == 0 then
                comps = {}
                db:execute(
                    "INSERT INTO horse_complements (`charidentifier`, `complements`, `identifier`) VALUES (?,?,?)",
                    { charId, "[]", tostring(charId) }
                )
            else
                comps = compsResult[1].complements
            end

            local ownedRides = {}
            local waitingRides = {}

            for _, v in ipairs(result) do
                if v.charidentifier == charId then
                    table.insert(ownedRides, 1, v)
                else
                    table.insert(waitingRides, 1, v)
                end
            end

            TriggerClientEvent(Events.onStableLoaded, src, {
                rides = ownedRides,
                transferedRides = waitingRides,
                availableComps = comps,
                tackStorage = tackStorage,
                tackLoadout = tackLoadout,
                charId = charId
            })
        end)
    end)
end)

        if regInvs ~= nil then
            for _, ride in pairs(result) do
                local limit
                if Config.CustomMaxWeight[ride.modelname] then
                    limit = Config.CustomMaxWeight[ride.modelname]
                else
                    limit = Config.DefaultMaxWeight
                end
                local id = ("%s_%s"):format(ride.modelname, charId)
                VorpInv.registerInventory(id, ride.name, limit, true, Config.ShareInv[ride.type], Config.StackInvIgnore[ride.type])
            end
        end
    end)

    db:execute("SELECT charidentifier, firstname, lastname, job FROM characters", function(result)
        TriggerClientEvent("charsLoaded", src, result)
    end)
end

local function GetVendorRideInfo(vendorIndex, rideType, rideModel)
    vendorIndex = tonumber(vendorIndex)

    local vendor = Config.Stables[vendorIndex]
    if not vendor then return nil end

    local vendorList = rideType == "horse" and vendor.horses or vendor.carts
    local dataList = rideType == "horse" and Data.Horses or Data.Carts

    if not dataList[rideModel] then return nil end

    local function defaultInfo()
        return {
            name = rideModel,
            price = tonumber(dataList[rideModel]),
            currency = 0
        }
    end

    if type(vendorList) ~= "table" or next(vendorList) == nil then
        return defaultInfo()
    end

    local function resolveEntry(entry)
        if type(entry) == "string" and entry == rideModel then
            return defaultInfo()
        end
        if type(entry) ~= "table" then return nil end
        for model, value in pairs(entry) do
            if model == rideModel then
                if type(value) == "table" then
                    return {
                        name = value.name or model,
                        price = tonumber(value.price) or tonumber(dataList[model]),
                        currency = tonumber(value.currency) or 0
                    }
                end
                if type(value) == "number" then
                    return {
                        name = model,
                        price = tonumber(value),
                        currency = 0
                    }
                end
                if type(value) == "string" then
                    return {
                        name = value,
                        price = tonumber(dataList[model]),
                        currency = 0
                    }
                end
            end
        end
        return nil
    end
    local function searchList(list)
        for key, value in pairs(list) do
            if type(key) == "number" then
                local found = resolveEntry(value)
                if found then return found end
            elseif type(value) == "table" and not value.price and not value.currency and not dataList[key] then
                local found = searchList(value)
                if found then return found end
            else
                local found = resolveEntry({ [key] = value })
                if found then return found end
            end
        end
        return nil
    end
    return searchList(vendorList)
end

RegisterNetEvent(Events.onBuyRide, function(rideName, rideModel, rideType, vendorIndex)
    local src = source
    local player = VorpCore.getUser(src).getUsedCharacter
    local id = player.charIdentifier
    local price = 0

    --local price = GetVendorRidePrice(vendorIndex, rideType, rideModel)

    local rideInfo = GetVendorRideInfo(vendorIndex, rideType, rideModel)

if not rideInfo then
    return TriggerClientEvent("vorp:TipRight", src, "This stable does not sell that horse.", 4000)
end
local price = rideInfo.price
local currency = rideInfo.currency
if currency == 0 and price > player.money then
    return TriggerClientEvent("vorp:TipRight", src, Config.Lang.TipCantAfford, 4000)
end
if currency == 1 and price > player.gold then
    return TriggerClientEvent("vorp:TipRight", src, Config.Lang.TipCantAfford, 4000)
end

player.removeCurrency(currency, price)
    db:execute("INSERT INTO stables (`charidentifier`, `name`, `type`, `modelname`, `identifier`) VALUES (?, ?, ?, ?, 'steam:')", { id, rideName, rideType, rideModel },
        function(result)
            if result.affectedRows > 0 then
                TriggerClientEvent("vorp:TipRight", src,
                    Config.Lang.TipRidePurchased:gsub("%{rideName}", rideName):gsub("%{price}", price), 4000)
                local limit
                if Config.CustomMaxWeight[rideModel] ~= nil then
                    limit = Config.CustomMaxWeight[rideModel]
                else
                    limit = Config.DefaultMaxWeight
                end
                local invid = ("%s_%s"):format(rideModel, id)
                VorpInv.registerInventory(invid, rideName, limit, true, Config.ShareInv[rideType], false)
                LoadStableContent(src, id)
            end
        end)
end)

local TackColumnByType = {
    ["Saddles"] = "saddles",
    ["Blankets"] = "blankets",
    ["Saddle Horns"] = "saddle_horns",
    ["Saddlebags"] = "saddlebags",
    ["Stirrups"] = "stirrups",
    ["Bedrolls"] = "bedrolls",
    ["Lanterns"] = "lanterns",
    ["Masks"] = "masks"
}

local MaxTackPerItem = Config.MaxTackPerItem == false and false or tonumber(Config.MaxTackPerItem) or 20

local function DecodeTackList(value)
    if not value or value == "" then
        return {}
    end

    local ok, decoded = pcall(json.decode, value)

    if not ok or type(decoded) ~= "table" then
        return {}
    end

    return decoded
end

local function CountHashInList(list, hash)
    local count = 0

    for _, storedHash in ipairs(list) do
        if tostring(storedHash) == tostring(hash) then
            count = count + 1
        end
    end

    return count
end

local function AddHashToList(list, hash)
    table.insert(list, tostring(hash))
    return list
end

local function RemoveHashFromList(list, hash)
    for i, storedHash in ipairs(list) do
        if tostring(storedHash) == tostring(hash) then
            table.remove(list, i)
            return list
        end
    end

    return list
end

local function GetTackDisplayName(compType, compHash)
    if not Data.Complements.Tack or not Data.Complements.Tack[compType] then
        return compType
    end
    for groupName, variants in pairs(Data.Complements.Tack[compType]) do
        for i = 1, #variants - 1 do
            if tostring(variants[i]) == tostring(compHash) then
                return groupName
            end
        end
    end
    return compType
end

RegisterNetEvent(Events.onBuyComp, function(compModel, compType, price, horseId, horseComps, playerAvailableComps)
    local src = source
    local player = VorpCore.getUser(src).getUsedCharacter
    local id = player.charIdentifier

    price = tonumber(price) or 0
    local compHash = tostring(compModel)
    compModel = tonumber(compModel)
    horseId = tonumber(horseId)
    horseComps = horseComps or {}

    if not compModel or not horseId then
        return TriggerClientEvent("vorp:TipRight", src, "Invalid equipment.", 4000)
    end

    if price > player.money then
        return TriggerClientEvent("vorp:TipRight", src, Config.Lang.TipCantAfford, 4000)
    end

    local isHair = Data.Complements.Hair and Data.Complements.Hair[compType] ~= nil
    local isTack = Data.Complements.Tack and Data.Complements.Tack[compType] ~= nil

    if not isHair and not isTack then
        return TriggerClientEvent("vorp:TipRight", src, "Invalid equipment type.", 4000)
    end

    if isHair then
        horseComps[compType] = compHash

        db:execute("UPDATE stables SET `gear` = ? WHERE `id` = ? AND `charidentifier` = ?", {
            json.encode(horseComps),
            horseId,
            id
        }, function(result)
            if result.affectedRows > 0 then
                player.removeCurrency(0, price)
                TriggerClientEvent("vorp:TipRight", src, Config.Lang.TipSuccessfulBuyComp:gsub("%{0}", compType):gsub("%{1}", price), 4000)
                LoadStableContent(src, id)
            else
                TriggerClientEvent("vorp:TipRight", src, Config.Lang.TipErrorOnPurchase, 4000)
            end
        end)

        return
    end

    local tackColumn = TackColumnByType[compType]

    if not tackColumn then
        return TriggerClientEvent("vorp:TipRight", src, "Invalid tack type.", 4000)
    end

    db:execute("INSERT IGNORE INTO horse_tack_storage (`charidentifier`, `" .. tackColumn .. "`) VALUES (?, ?)", {
        id,
        "[]"
    }, function()

        db:execute("SELECT * FROM horse_tack_storage WHERE `charidentifier` = ?", {
            id
        }, function(storageResult)

            local storageRow = storageResult[1]
            local storedList = DecodeTackList(storageRow and storageRow[tackColumn])

            db:execute("SELECT `" .. tackColumn .. "` FROM horse_tack_loadout WHERE `horse_id` = ? AND `charidentifier` = ?", {
                horseId,
                id
            }, function(loadoutResult)

                local oldHash = loadoutResult[1] and loadoutResult[1][tackColumn]

                    if (not oldHash or oldHash == "" or tostring(oldHash) == "0") and horseComps[compType] then
                        oldHash = tostring(horseComps[compType])
                    end
                local ownedAmount = CountHashInList(storedList, compHash)

                if oldHash and tostring(oldHash) == compHash then
                    ownedAmount = ownedAmount + 1
                end

                if MaxTackPerItem ~= false and ownedAmount >= MaxTackPerItem then
                    return TriggerClientEvent("vorp:TipRight", src, "You already own the max amount of this item.", 4000)
                end

                if oldHash and oldHash ~= "" and tostring(oldHash) ~= "0" then
                    AddHashToList(storedList, oldHash)
                end

                horseComps[compType] = compHash

                db:execute("UPDATE horse_tack_storage SET `" .. tackColumn .. "` = ? WHERE `charidentifier` = ?", {
                    json.encode(storedList),
                    id
                }, function()

                    db:execute(("INSERT INTO horse_tack_loadout (`charidentifier`, `horse_id`, `%s`) VALUES (?, ?, ?) ON DUPLICATE KEY UPDATE `%s` = VALUES(`%s`)"):format(tackColumn, tackColumn, tackColumn), {
                        id,
                        horseId,
                        compHash
                    }, function()

                        db:execute("UPDATE stables SET `gear` = ? WHERE `id` = ? AND `charidentifier` = ?", {
                            json.encode(horseComps),
                            horseId,
                            id
                        }, function(gearResult)
                            if gearResult.affectedRows > 0 then
                                player.removeCurrency(0, price)
                                TriggerClientEvent("vorp:TipRight", src, Config.Lang.TipSuccessfulBuyComp:gsub("%{0}", compType):gsub("%{1}", price), 4000)
                                LoadStableContent(src, id)
                            else
                                TriggerClientEvent("vorp:TipRight", src, Config.Lang.TipErrorOnPurchase, 4000)
                            end
                        end)
                    end)
                end)
            end)
        end)
    end)
end)

RegisterNetEvent("brk_stables:equipStoredTack", function(horseId, compType, compHash)
    local src = source
    local player = VorpCore.getUser(src).getUsedCharacter
    local id = player.charIdentifier

    horseId = tonumber(horseId)
    compHash = tostring(compHash)

    local tackColumn = TackColumnByType[compType]

    if not horseId or not tackColumn then
        return TriggerClientEvent("vorp:TipRight", src, "Invalid tack.", 4000)
    end

    db:execute("SELECT gear FROM stables WHERE `id` = ? AND `charidentifier` = ?", {
        horseId,
        id
    }, function(rideResult)
        if not rideResult[1] then
            return TriggerClientEvent("vorp:TipRight", src, "Horse not found.", 4000)
        end

        local horseComps = {}

        if rideResult[1].gear and rideResult[1].gear ~= "" then
            local ok, decoded = pcall(json.decode, rideResult[1].gear)

            if ok and type(decoded) == "table" then
                horseComps = decoded
            end
        end

        db:execute("SELECT * FROM horse_tack_storage WHERE `charidentifier` = ?", {
            id
        }, function(storageResult)
            local storageRow = storageResult[1]

            if not storageRow then
                return TriggerClientEvent("vorp:TipRight", src, "No stored tack found.", 4000)
            end

            local storedList = DecodeTackList(storageRow[tackColumn])

            if CountHashInList(storedList, compHash) <= 0 then
                return TriggerClientEvent("vorp:TipRight", src, "That tack is not in storage.", 4000)
            end

            db:execute("SELECT `" .. tackColumn .. "` FROM horse_tack_loadout WHERE `horse_id` = ? AND `charidentifier` = ?", {
                horseId,
                id
            }, function(loadoutResult)
                local oldHash = loadoutResult[1] and loadoutResult[1][tackColumn]

                    if (not oldHash or oldHash == "" or tostring(oldHash) == "0") and horseComps[compType] then
                        oldHash = tostring(horseComps[compType])
                    end

                RemoveHashFromList(storedList, compHash)

                if oldHash and oldHash ~= "" and tostring(oldHash) ~= "0" then
                    AddHashToList(storedList, oldHash)
                end

                horseComps[compType] = compHash

                db:execute("UPDATE horse_tack_storage SET `" .. tackColumn .. "` = ? WHERE `charidentifier` = ?", {
                    json.encode(storedList),
                    id
                }, function()
                    db:execute(("INSERT INTO horse_tack_loadout (`charidentifier`, `horse_id`, `%s`) VALUES (?, ?, ?) ON DUPLICATE KEY UPDATE `%s` = VALUES(`%s`)"):format(tackColumn, tackColumn, tackColumn), {
                        id,
                        horseId,
                        compHash
                    }, function()
                        db:execute("UPDATE stables SET `gear` = ? WHERE `id` = ? AND `charidentifier` = ?", {
                            json.encode(horseComps),
                            horseId,
                            id
                        }, function(result)
                            if result.affectedRows > 0 then
                                local newName = GetTackDisplayName(compType, compHash)
                                local oldName = oldHash and GetTackDisplayName(compType, oldHash) or nil

                                TriggerClientEvent("vorp:TipRight", src, newName .. " equipped.", 4000)

                                if oldName then
                                    TriggerClientEvent("vorp:TipRight", src, oldName .. " stored.", 4000)
                                end

                                LoadStableContent(src, id)
                            else
                                TriggerClientEvent("vorp:TipRight", src, "Could not equip tack.", 4000)
                            end
                        end)
                    end)
                end)
            end)
        end)
    end)
end)

RegisterNetEvent(Events.onRemoveComps, function(rideId)
    local src = source
    local player = VorpCore.getUser(src).getUsedCharacter
    local id = player.charIdentifier
    rideId = tonumber(rideId)
    if not rideId then
        return TriggerClientEvent("vorp:TipRight", src, "Invalid horse.", 4000)
    end
    local function NormalizeCompHash(comp)
        if type(comp) == "table" then
            comp = comp.hash or comp.comp_hash or comp.model or comp[1]
        end
        if not comp then
            return nil
        end
        return tostring(comp)
    end
    local function IsValidTackHash(hash)
        hash = NormalizeCompHash(hash)
        return hash
            and hash ~= ""
            and hash ~= "0"
            and hash ~= "0x0"
            and hash ~= "0X0"
    end
    db:execute("SELECT gear FROM stables WHERE `id` = ? AND `charidentifier` = ?", {
        rideId,
        id
        }, function(rideResult)
            if not rideResult[1] then
                return TriggerClientEvent("vorp:TipRight", src, "Horse not found.", 4000)
            end
            local horseComps = {}
            if rideResult[1].gear and rideResult[1].gear ~= "" then
                local ok, decoded = pcall(json.decode, rideResult[1].gear)

                if ok and type(decoded) == "table" then
                    horseComps = decoded
                end
            end
        db:execute("INSERT IGNORE INTO horse_tack_storage (`charidentifier`) VALUES (?)", {
            id
        }, function()
            db:execute("SELECT * FROM horse_tack_storage WHERE `charidentifier` = ?", {
                id
            }, function(storageResult)
                local storageRow = storageResult[1] or {}
                db:execute("SELECT * FROM horse_tack_loadout WHERE `horse_id` = ? AND `charidentifier` = ?", {
                    rideId,
                    id
                }, function(loadoutResult)
                    local loadoutRow = loadoutResult[1] or {}
                    local storageUpdates = {}
                    local storageParams = {}
                    local storedCount = 0
                    for compType, tackColumn in pairs(TackColumnByType) do
                        local hashToStore = NormalizeCompHash(loadoutRow[tackColumn])
                        if not IsValidTackHash(hashToStore) then
                            hashToStore = NormalizeCompHash(horseComps[compType])
                        end
                        if IsValidTackHash(hashToStore) then
                            local storedList = DecodeTackList(storageRow[tackColumn])
                            AddHashToList(storedList, hashToStore)
                            table.insert(storageUpdates, "`" .. tackColumn .. "` = ?")
                            table.insert(storageParams, json.encode(storedList))
                            storedCount = storedCount + 1
                        end
                        horseComps[compType] = nil
                    end
                    local function ClearHorseTack()
                        db:execute([[
                            UPDATE horse_tack_loadout
                            SET
                                `saddles` = NULL,
                                `blankets` = NULL,
                                `saddle_horns` = NULL,
                                `saddlebags` = NULL,
                                `stirrups` = NULL,
                                `bedrolls` = NULL,
                                `lanterns` = NULL,
                                `masks` = NULL
                            WHERE `horse_id` = ? AND `charidentifier` = ?
                        ]], {
                            rideId,
                            id
                        }, function()
                            db:execute("UPDATE stables SET `gear` = ? WHERE `id` = ? AND `charidentifier` = ?", {
                                json.encode(horseComps),
                                rideId,
                                id
                            }, function(result)
                                if result.affectedRows > 0 then
                                    if storedCount > 0 then
                                        TriggerClientEvent("vorp:TipRight", src, storedCount .. " tack item(s) stored.", 4000)
                                            else
                                                TriggerClientEvent("vorp:TipRight", src, "Horse equipment removed.", 4000)
                                            end
                                    LoadStableContent(src, id)
                                else
                                    TriggerClientEvent("vorp:TipRight", src, "Could not remove horse equipment.", 4000)
                                end
                            end)
                        end)
                    end
                    if #storageUpdates > 0 then
                        table.insert(storageParams, id)
                        db:execute("UPDATE horse_tack_storage SET " .. table.concat(storageUpdates, ", ") .. " WHERE `charidentifier` = ?", storageParams, function()
                            ClearHorseTack()
                        end)
                    else
                        ClearHorseTack()
                    end
                end)
            end)
        end)
    end)
end)

RegisterNetEvent(Events.onDelete, function(rideId)
    local src = source
    local player = VorpCore.getUser(src).getUsedCharacter
    local id = player.charIdentifier

    rideId = tonumber(rideId)

    if not rideId then
        return TriggerClientEvent("vorp:TipRight", src, "Invalid horse.", 4000)
    end

    db:execute("SELECT charidentifier, name FROM stables WHERE `id` = ?", { rideId }, function(result)
        if result[1] and result[1].charidentifier == id then
            local rideName = result[1].name or "Horse"

            db:execute("DELETE FROM stables WHERE `id` = ? AND `charidentifier` = ?", {
                rideId,
                id
            }, function(deleteResult)
                if deleteResult.affectedRows > 0 then
                    db:execute("DELETE FROM horse_tack_loadout WHERE `horse_id` = ?", {
                        rideId
                    }, function()
                        local message = Config.Lang.TipHorseFreed
                        message = message:gsub("{horseName}", rideName):gsub("{horsename}", rideName)

                        TriggerClientEvent("vorp:TipRight", src, message, 4000)
                        LoadStableContent(src, id)
                    end)
                end
            end)
        end
    end)
end)

RegisterNetEvent(Events.onTransfer, function(rideId, targetChar, price, activePlayers)
    local src = source
    local player = VorpCore.getUser(src).getUsedCharacter
    local id = player.charIdentifier
    local targetSource = nil
    -- Check if recieving player is connected so their stable content gets refreshed
    for _, v in ipairs(activePlayers) do
        local u = VorpCore.getUser(v)
        if u ~= nil then
            local p = u.getUsedCharacter
            local i = p.charIdentifier
            if i == targetChar then
                targetSource = v
                break
            end
        end
    end

    -- The ride isn't directly transfered, the offer is stored in the ride status for the recieving player to accept or not
    db:execute("UPDATE stables SET status = ? WHERE `id` = ?", { json.encode({
        transferTarget = targetChar,
        price = price
    }), rideId }, function()
        TriggerClientEvent("vorp:TipRight", src, Config.Lang.TipOfferSent, 4000)
        LoadStableContent(src, id)
        if targetSource ~= nil then
            LoadStableContent(targetSource, targetChar)
        end
    end)
end)

RegisterNetEvent(Events.onTransferRecieve, function(rideId, targetChar, accepted, index, activePlayers)
    local src = source
    local player = VorpCore.getUser(src).getUsedCharacter -- seller ?
    local id = player.charIdentifier
    local targetSource = nil

    for _, v in ipairs(activePlayers) do
        local u = VorpCore.getUser(v)
        if u then
            local p = u.getUsedCharacter
            local i = p.charIdentifier
            if i == targetChar then
                targetSource = v
                break
            end
        end
    end

    -- get horsemodel from riderid
    db:execute("SELECT modelname FROM stables WHERE `id` = ?", { rideId }, function(result)
        if result[1] then
            local horseModel = result[1].modelname
            local value = Config.Stables[index]
            if not value then
                return print("stable not found: ", index)
            end

            local horsePrice = value.horses[horseModel]
            if not horsePrice then
                return print("horse not found: ", horseModel)
            end

            if not accepted then
                db:execute("UPDATE stables SET status = NULL WHERE `id` = ?", { rideId }, function()
                    TriggerClientEvent("vorp:TipRight", src, Config.Lang.TipOfferDeclined, 4000)
                    LoadStableContent(src, id)
                end)
            elseif player.money >= horsePrice then
                db:execute("UPDATE stables SET status = NULL, charidentifier = ? WHERE `id` = ?", {
                    id,
                    rideId
                }, function()
                    db:execute("UPDATE horse_tack_loadout SET `charidentifier` = ? WHERE `horse_id` = ?", {
                        id,
                        rideId
                    }, function()
                        TriggerClientEvent("vorp:TipRight", src, Config.Lang.TipOfferAccepted:gsub("%{price}", horsePrice), 4000)
                        LoadStableContent(src, id)
                        player.removeCurrency(0, horsePrice)
                        if targetSource then
                            local tPlayer = VorpCore.getUser(targetSource).getUsedCharacter
                            tPlayer.addCurrency(0, horsePrice)
                            LoadStableContent(targetSource, targetChar)
                        end
                        -- //TODO add currency to seller if disconnected
                    end)
                end)
            else
                TriggerClientEvent("vorp:TipRight", src, Config.Lang.TipCantAfford .. " " .. Config.Lang.TipOfferStillOn, 4000)
            end
        end
    end)
end)

local defaultHorse = {}
RegisterNetEvent(Events.openInventory, function(rideModel, newRide)
    local src = source
    local user = VorpCore.getUser(src)
    if not user then return end

    local character = user.getUsedCharacter
    local charId = character.charIdentifier
    local id = ("%s_%s"):format(rideModel, charId)

    local isRegistered = exports.vorp_inventory:isCustomInventoryRegistered(id)
    if not isRegistered then
        TriggerClientEvent("vorp:TipRight", src, "This inventory is not registered id: " .. id, 4000)
        return
    end

    if defaultHorse[src] and not defaultHorse[src] == newRide then
        return TriggerClientEvent("vorp:TipRight", src, "cant open inventory of a horse that is not your default", 4000)
    end

    exports.vorp_inventory:openInventory(src, id)
end)

RegisterNetEvent(Events.setDefault, function(newRide, prevRide)
    local src = source
    local player = VorpCore.getUser(src).getUsedCharacter
    local id = player.charIdentifier
    db:execute("UPDATE stables SET `isDefault` = 1 WHERE `id` = ?", { newRide }, function(updated)
        if updated.affectedRows > 0 and prevRide ~= nil then
            db:execute("UPDATE stables SET `isDefault` = 0 WHERE `id` = ?", { prevRide }, function(secondUpdate)
                if secondUpdate.affectedRows > 0 then
                    TriggerClientEvent("vorp:TipRight", src, Config.Lang.TipChanged, 4000)
                    LoadStableContent(src, id)
                else
                    TriggerClientEvent("vorp:TipRight", src, Config.Lang.TipErrorOnUpdate, 4000)
                    LoadStableContent(src, id)
                end
            end)
        elseif updated.affectedRows > 0 then
            TriggerClientEvent("vorp:TipRight", src, Config.Lang.TipChanged, 4000)
            LoadStableContent(src, id)
        else
            TriggerClientEvent("vorp:TipRight", src, Config.Lang.TipErrorOnUpdate, 4000)
        end

        defaultHorse[src] = newRide -- id of the horse
    end)
end)

RegisterNetEvent(Events.onHorseDown, function(rideId, killerObjectHash)
    -- HardDeath management
    if not Config.HardDeath then return end

    local src = source
    local player = VorpCore.getUser(src).getUsedCharacter
    local id = player.charIdentifier

    rideId = tonumber(rideId)

    if not rideId then
        return
    end

    local LTDamages = DeathReasons[killerObjectHash] or DeathReasons.Default

    db:execute("UPDATE stables SET injured = injured + ? WHERE `id` = ? AND `charidentifier` = ?", {
        LTDamages,
        rideId,
        id
    }, function(updated)
        if updated.affectedRows > 0 then
            db:execute("SELECT injured FROM stables WHERE `id` = ? AND `charidentifier` = ?", {
                rideId,
                id
            }, function(result)
                if result[1] and result[1].injured >= Config.LongTermHealth then
                    db:execute("DELETE FROM stables WHERE `id` = ? AND `charidentifier` = ?", {
                        rideId,
                        id
                    }, function(deleted)
                        if deleted.affectedRows > 0 then
                            db:execute("DELETE FROM horse_tack_loadout WHERE `horse_id` = ?", {
                                rideId
                            }, function()
                                TriggerClientEvent("vorp:TipRight", src, Config.Lang.TipHorseDeadDefinitive, 4000)
                                LoadStableContent(src, id)
                            end)
                        end
                    end)
                end
            end)
        end
    end)
end)
