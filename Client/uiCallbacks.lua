RidePreviewRef = 0
StableMenuOpen = StableMenuOpen or false
local instanceCam = nil
local previewToken = 0
local isClosingStableMenu = false
local currentlyPreviewedCompModel = nil


local function ResetCompPreview()
    currentlyPreviewedCompModel = nil
end

local function DeleteRidePreview()
    if RidePreviewRef and RidePreviewRef ~= 0 and DoesEntityExist(RidePreviewRef) then
        SetEntityAsMissionEntity(RidePreviewRef, true, true)

        if IsEntityAVehicle(RidePreviewRef) then
            DeleteVehicle(RidePreviewRef)
        else
            DeletePed(RidePreviewRef)
        end
        DeleteEntity(RidePreviewRef)
    end
    RidePreviewRef = 0
end

local function ForceStableMenuCleanup()
    previewToken = previewToken + 1

    DeleteRidePreview()
    ResetCompPreview()

    FreezeEntityPosition(PlayerPedId(), false)
    TriggerEvent("vorp:setInstancePlayer", false)

    RenderScriptCams(false, false, 0, true, true, 0)

    if instanceCam then
        DestroyCam(instanceCam, true)
    end

    DestroyAllCams(true)
    ClearFocus()
    instanceCam = nil

    SetNuiFocus(false, false)
    SetNuiFocusKeepInput(false)
end

local function CloseStableMenu()
    if isClosingStableMenu then
        return
    end

    isClosingStableMenu = true
    StableMenuOpen = false

    ForceStableMenuCleanup()

    Citizen.SetTimeout(1000, function()
        isClosingStableMenu = false
    end)
end

local function GetCompHash(comp)
    if type(comp) == "table" then
        return tonumber(comp.hash or comp.comp_hash or comp.model or comp[1])
    end
    return tonumber(comp)
end

local function ApplySavedCompToRide(entity, comp)
    local compHash = GetCompHash(comp)

    if not compHash or compHash == 0 then
        return
    end
    ApplyShopItemToPed(entity, compHash)
end

RegisterNuiCallback("buyRide", function(data, callback)
    if not Stable or not Stable.rides then
        TriggerServerEvent(Events.loadStableRuntime)
        return TriggerEvent("vorp:TipRight", "Stable data is still loading. Try again.", 4000)
    end

    if PlayerStable:isFull(Stable, data.rideType) then
        return TriggerEvent("vorp:TipRight", Config.Lang.TipStableFull, 4000)
    end

    TriggerEvent("vorpinputs:getInput", Config.Lang.Ok, Config.Lang.PlaceHolderRideName, function(rideName)
        if #rideName < 3 then
            TriggerEvent("vorp:TipRight", "~e~" .. Config.Lang.TipNameTooShort, 3000);
        else
            TriggerServerEvent(Events.onBuyRide, rideName, data.rideModel, data.rideType, CurrentVendorIndex);
        end
    end)
end)

RegisterNuiCallback("showRide", function(data, callback)
    if isClosingStableMenu or not StableMenuOpen then
        if callback then callback({ ok = true }) end
        return
    end

    previewToken = previewToken + 1
    local myToken = previewToken
    DeleteRidePreview()
    ResetCompPreview()
    Citizen.CreateThread(function()
        if isClosingStableMenu or not StableMenuOpen then return end

        local rideHash = GetHashKey(data.rideName)
        if not LoadModel(rideHash) then return end
        if isClosingStableMenu or not StableMenuOpen then
            SetModelAsNoLongerNeeded(rideHash)
            return
        end
        if myToken ~= previewToken then
            SetModelAsNoLongerNeeded(rideHash)
            return
        end
        local entityRef = 0
        if data.rideType == "horse" then
            local x, y, z, h = table.unpack(Config.Stables[CurrentVendorIndex].SpawnHorse)
            entityRef = CreatePed(rideHash, x, y, z, h, false, false, false, false)
            if entityRef and entityRef ~= 0 then
                Citizen.InvokeNative(0x283978A15512B2FE, entityRef, true)
                if data.rideComps ~= nil then
                    for _, comp in pairs(data.rideComps) do
                            ApplySavedCompToRide(entityRef, comp)
                    end
                            UpdatePedVariation(entityRef)
                    else
                        Citizen.InvokeNative(0xC8A9481A01E63C28, entityRef, 1)
                    end
            end
        elseif data.rideType == "cart" then
            local x, y, z, h = table.unpack(Config.Stables[CurrentVendorIndex].SpawnCart)
            entityRef = CreateVehicle(rideHash, x, y, z, h, false, false, false, false)
            if entityRef and entityRef ~= 0 then
                Citizen.InvokeNative(0xAF35D0D2583051B0, entityRef, true)
            end
        end
        SetModelAsNoLongerNeeded(rideHash)
        if not entityRef or entityRef == 0 or not DoesEntityExist(entityRef) then return end
        if myToken ~= previewToken then
            SetEntityAsMissionEntity(entityRef, true, true)
            DeleteEntity(entityRef)
            return
        end
        SetEntityAsMissionEntity(entityRef, true, true)
        SetEntityCanBeDamaged(entityRef, false)
        SetEntityInvincible(entityRef, true)
        FreezeEntityPosition(entityRef, true)
        SetEntityCollision(entityRef, false, false)
        RidePreviewRef = entityRef
    end)
end)

RegisterNuiCallback("activateCam", function(data, callback)
    if isClosingStableMenu or not StableMenuOpen then
        if callback then callback({ ok = true }) end
        return
    end

    FreezeEntityPosition(PlayerPedId(), true);

    local x, y, z, rx, ry, rz, fov
    if data.rideType == "horse" then
        x, y, z, rx, ry, rz = table.unpack(Config.Stables[CurrentVendorIndex].CamHorse)
        fov = 70.0
    elseif data.rideType == "cart" then
        x, y, z, rx, ry, rz = table.unpack(Config.Stables[CurrentVendorIndex].CamCart)
        fov = 50.0
    end

    DestroyCam(instanceCam, true)
    instanceCam = Citizen.InvokeNative(0x40C23491CE83708E, "DEFAULT_SCRIPTED_CAMERA", x, y, z, rx, ry, rz, fov, false, 0);
    SetCamActive(instanceCam, true);
    RenderScriptCams(true, true, 1000, true, true, 0);
end)

local function SafeRemoveCompFromPreview(model)
    if not model then return end
    if not RidePreviewRef or RidePreviewRef == 0 or not DoesEntityExist(RidePreviewRef) then return end
    RemoveShopItemFromPed(RidePreviewRef, tonumber(model))
    UpdatePedVariation(RidePreviewRef)
end

local function SafeApplyCompToPreview(model)
    if not model then return end
    if not RidePreviewRef or RidePreviewRef == 0 or not DoesEntityExist(RidePreviewRef) then return end
    ApplyShopItemToPed(RidePreviewRef, tonumber(model))
    UpdatePedVariation(RidePreviewRef)
end

RegisterNuiCallback("viewComp", function(data, callback)
    if isClosingStableMenu or not StableMenuOpen then
        if callback then callback({ ok = true }) end
        return
    end

    local newModel = tonumber(data.modelHash)
    if currentlyPreviewedCompModel and currentlyPreviewedCompModel ~= newModel then
        SafeRemoveCompFromPreview(currentlyPreviewedCompModel)
    end
    SafeApplyCompToPreview(newModel)
    currentlyPreviewedCompModel = newModel
end)

RegisterNuiCallback("removeAllComps", function(data, callback)
    TriggerServerEvent(Events.onRemoveComps, data.rideId)
    if RidePreviewRef and RidePreviewRef ~= 0 and DoesEntityExist(RidePreviewRef) then
        Citizen.InvokeNative(0xC8A9481A01E63C28, RidePreviewRef, false)
        UpdatePedVariation(RidePreviewRef)
    end
    ResetCompPreview()
    for _, ride in pairs(Stable.rides) do
        if ride.id == data.rideId then
            ride.comps = {}
            break
        end
    end
end)

RegisterNuiCallback("buyComp", function(data, callback)
    local currentRide
    for k, ride in pairs(Stable.rides) do
        if (ride.id == data.horseId) then
            currentRide = ride
            break
        end
    end
    TriggerServerEvent(Events.onBuyComp, data.compModel, data.compType, data.price, data.horseId, currentRide.comps, Stable.availableComps);
end)

RegisterNuiCallback("equipStoredTack", function(data, callback)
    TriggerServerEvent("brk_stables:equipStoredTack", data.horseId, data.compType, data.compHash)
end)

RegisterNuiCallback("setDefault", function(data, callback)
    TriggerServerEvent(Events.setDefault, data.newRide, data.prevRide)
end)

RegisterNuiCallback("transfer", function(data, callback)
    local actPlayers = {}
    for i, v in ipairs(GetActivePlayers()) do
        actPlayers[i] = GetPlayerServerId(v)
    end
    TriggerServerEvent(Events.onTransfer, data.rideId, data.selectedChar, data.price, actPlayers)
end)

RegisterNuiCallback("transferRecieve", function(data, callback)
    local actPlayers = {}
    for i, v in ipairs(GetActivePlayers()) do
        actPlayers[i] = GetPlayerServerId(v)
    end
    TriggerServerEvent(Events.onTransferRecieve, data.rideId, data.selectedChar, data.state, CurrentVendorIndex, actPlayers)
end)

RegisterNuiCallback("free", function(data, callback)
    previewToken = previewToken + 1
    DeleteRidePreview()
    ResetCompPreview()
    TriggerServerEvent(Events.onDelete, data.rideId)
end)

function ApplyShopItemToPed(entity, model)
    Citizen.InvokeNative(0xD3A7B003ED343FD9, entity, model, true, true, true);
end

function RemoveShopItemFromPed(entity, model)
    Citizen.InvokeNative(0x0D7FFA1B2F69ED82, entity, model, true, true);
end

function UpdatePedVariation(ped)
    Citizen.InvokeNative(0xCC8CA3E88256E58F, ped, 0, 1, 1, 1, 0);
end

function ReloadCompFromCurrent(previousModel, model)
    if previousModel then
        SafeRemoveCompFromPreview(previousModel)
    end
    SafeApplyCompToPreview(model)
end

RegisterNuiCallback("exit", function(data, callback)
    CloseStableMenu()
    if callback then
        callback({ ok = true })
    end
end)

function LoadModel(hash)
    if IsModelValid(hash) then
        if not HasModelLoaded(hash) then
            RequestModel(hash, false)
            repeat Wait(0) until HasModelLoaded(hash)
        end
        return true
    end
    print("Model not valid: " .. hash)
    return false
end
