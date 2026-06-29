Ride = {
    id = 0,
    name = "",
    model = "",
    type = "",
    isDefault = 0,
    comps = {},
    owner = 0
}

PlayerStable = {
    characterId = 0,
    rides = {},
    transferedRides = {},
    availableComps = {},
    tackStorage = {},
    tackLoadout = {}
}

function Ride:new(rideFromDB)
    local comps = {}

    if rideFromDB.gear and rideFromDB.gear ~= "" then
        local ok, decoded = pcall(json.decode, rideFromDB.gear)

        if ok and type(decoded) == "table" then
            comps = decoded
        end
    end

    local ride = {
        id = rideFromDB.id,
        name = rideFromDB.name,
        model = rideFromDB.modelname,
        type = rideFromDB.type,
        isDefault = rideFromDB.isDefault,
        comps = comps,
        owner = rideFromDB.charidentifier,
        lth = rideFromDB.injured
    }

    setmetatable(ride, self)
    self.__index = self
    return ride
end

function PlayerStable:new(ridesAsDBList, charId, availableComps, waitingRides, tackStorage, tackLoadout)
    if type(availableComps) == "string" then
        local ok, decoded = pcall(json.decode, availableComps)
        availableComps = ok and decoded or {}
    end

    availableComps = availableComps or {}
    waitingRides = waitingRides or {}
    ridesAsDBList = ridesAsDBList or {}

    local playerStable = {
        characterId = charId,
        availableComps = {},
        rides = {},
        transferedRides = {},
        tackStorage = tackStorage or {},
        tackLoadout = tackLoadout or {}
    }

    for compFamily, _ in pairs(Config.StaticData.Complements) do
        playerStable.availableComps[compFamily] = {}
    end

    for _, compHash in pairs(availableComps) do
        for compFamily, compModels in pairs(Config.StaticData.Complements) do
            for modelName, modelVariants in pairs(compModels) do
                local currTable = {}

                for _, variantHash in ipairs(modelVariants) do
                    if tonumber(variantHash) == tonumber(compHash) then
                        table.insert(currTable, 1, compHash)
                    end
                end

                if #currTable > 0 then
                    playerStable.availableComps[compFamily][modelName] = currTable
                end
            end
        end
    end

    for _, rideFromDB in ipairs(ridesAsDBList) do
        local rideData = Ride:new(rideFromDB)

        if rideFromDB.isDefault > 0 then
            if rideFromDB.type == "horse" then
                local entity
                if CurrentHorse ~= nil then
                    entity = CurrentHorse.pedId
                end
                CurrentHorse = rideData
                CurrentHorse.pedId = entity
            elseif rideFromDB.type == "cart" then
                local entity
                if CurrentCart ~= nil then
                    entity = CurrentCart.pedId
                end
                CurrentCart = rideData
                CurrentCart.pedId = entity
            end
        end

        table.insert(playerStable.rides, 1, rideData)
    end

    for _, rideFromDB in ipairs(waitingRides) do
        local rideData = Ride:new(rideFromDB)
        local ok, decodedStatus = pcall(json.decode, rideFromDB.status or "{}")
        rideData.price = ok and decodedStatus and decodedStatus.price or 0
        table.insert(playerStable.transferedRides, 1, rideData)
    end

    setmetatable(playerStable, self)
    self.__index = self
    return playerStable
end

function PlayerStable:horseCount(stable)
    local count = 0
    for _, v in ipairs(stable.rides) do
        if v.type == "horse" then
            count = count + 1
        end
    end
    return count
end

function PlayerStable:cartCount(stable)
    local count = 0
    for _, v in ipairs(stable.rides) do
        if v.type == "cart" then
            count = count + 1
        end
    end
    return count
end

function PlayerStable:isFull(stable, rideType)
    if not stable or not stable.rides then
        return true
    end

    local retval = ((rideType == "horse" and PlayerStable:horseCount(stable) <= Config.MaxHorses) or
               (rideType == "cart" and PlayerStable:cartCount(stable) <= Config.MaxCarts)) and
               (#stable.rides <= Config.StableSlots)
    return not retval
end
