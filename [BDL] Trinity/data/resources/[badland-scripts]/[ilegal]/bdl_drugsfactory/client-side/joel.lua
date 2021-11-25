local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

vRPserver = Tunnel.getInterface("vRP")

src = {}
Tunnel.bindInterface("bdl_drugsfactory",src)
vSERVER = Tunnel.getInterface("bdl_drugsfactory")

local metaX = 1495.83
local metaY = 6392.11
local metaZ = 23.48

local prop = "prop_weed_01"
-- PROGRESSO GLOBAL DAS PLANTAS (SERVER SIDE)
local progress = {}
-- VARIAVEIS CADEIRA
local weedchairprogress = false
local weedchairtime = 0
-- LOCAL MACONHA
local weedX = 99.43
local weedY = 6346.94
local weedZ = 31.38
-- COORDENADAS MACONHA PLANTAS
local weed = {
	{ "maconha",96.41,6335.84,31.38 },
	{ "maconha",97.74,6336.72,31.38 },
	{ "maconha",99.44,6337.61,31.38 },
	{ "maconha",98.7,6339.51,31.38 },
	{ "maconha",97.99,6340.89,31.38 },
	{ "maconha",97.3,6342.45,31.38 },
	{ "maconha",96.38,6344.04,31.38 },
	{ "maconha",95.45,6345.49,31.38 },
	{ "maconha",94.57,6346.61,31.38 },
	{ "maconha",93.79,6347.86,31.38 },
	{ "maconha",93.13,6349.29,31.38 },
	{ "maconha",94.55,6349.23,31.38 },
	{ "maconha",95.96,6349.96,31.38 },
	{ "maconha",97.44,6350.54,31.38 },
	{ "maconha",98.88,6351.22,31.38 },
	{ "maconha",100.52,6353.05,31.38 },
	{ "maconha",102.03,6353.72,31.38 },
	{ "maconha",103.56,6354.78,31.38 },
}
-- COORDENADAS CADEIRA
local weedchair = {
	{ 118.24,6362.52,32.3 },
	{ 114.19,6360.46,32.31 },
	{ 112.06,6360.96,32.31 },
}

local incocaprocess = false
local inpastaprocess = false
local cocastep = 0
local cocaX = -1077.38
local cocaY = 4928.51
local cocaZ = 212.98
local cocaPX = -1107.55
local cocaPY = 4941.75
local cocaPZ = 218.65
local embalarCocaX = -1107.1
local embalarCocaY = 4942.38
local embalarCocaZ = 218.95

-- PASSOS DO FARM DE COCA
local stepCocaX = -1108.75
local stepCocaY = 4952.17
local stepCocaZ = 218.65
local step2CocaX = -1106.14
local step2CocaY = 4946.83
local step2CocaZ = 218.65
local step3CocaX = -1108.25
local step3CocaY = 4946.17
local step3CocaZ = 218.65

-- VARIAVEL DE TEMPO DO FARM DE COCA
local segundos = 0
local pastasegundos = 0
local methtime = 0
local methtime2 = 0

local coca = {
	{ "cocaina",-1080.55,4926.19,213.3 },
	{ "cocaina",-1078.42,4927.62,213.1 },
	{ "cocaina",-1076.56,4929.2,212.84 },
	{ "cocaina",-1081.58,4927.93,213.35 },
	{ "cocaina",-1079.4,4929.2,213.16 },
	{ "cocaina",-1077.66,4930.86,213.05 },
	
	{ "cocaina",-1079.51,4924.77,213.25 },
	{ "cocaina",-1077.14,4926.28,212.95 },
	{ "cocaina",-1075.15,4927.7,212.77 },
	{ "cocaina",-1075.97,4932.44,212.82 },
	{ "cocaina",-1074.52,4930.74,212.64 },
	{ "cocaina",-1072.93,4929.29,212.68 },
	
	{ "cocaina",-1074.2,4934.1,212.65 },
	{ "cocaina",-1072.8,4932.6,212.42 },
	{ "cocaina",-1071.32,4931.07,212.28 },
	{ "cocaina",-1084.44,4926.62,213.91 },
	{ "cocaina",-1082.8,4924.44,213.76 },
	{ "cocaina",-1081.48,4923.04,213.57 },
}

local coca_p = {
	{ "cocaina-p",-1108.26,4938.33,219.65 },
}

function src.returnPlanting(status)
	progress = status
end
-- THREAD DAS PLANTAS (MACONHA & COCA)
Citizen.CreateThread(function()
	while true do
		local idle = 1000
		local ped = PlayerPedId()
		local x,y,z = table.unpack(GetEntityCoords(ped))
		local disPlantWeed = Vdist(x,y,z,weedX,weedY,weedZ)
		if disPlantWeed <= 60 then
			for k,v in pairs(weed) do
				local distance = Vdist(x,y,z,v[2],v[3],v[4])
				if distance <= 5 then
					idle = 5
					if parseInt(progress[k]) >= 100 then
						DrawText3Ds(v[2],v[3],v[4]-0.7,"[~p~E~w~] para ~p~COLHER~w~.")
					elseif progress[k] then
						DrawText3Ds(v[2],v[3],v[4]-0.7,"REAGINDO: ~p~"..progress[k].."~w~%.")
					else
						DrawText3Ds(v[2],v[3],v[4]-0.7,"[~p~E~w~] para ~p~ADUBAR~w~.")
					end

					if distance <= 1 and IsControlJustPressed(1,38) then
						vSERVER.startPlanting(k,v[1])
					end
				end
			end
		end
		local disPlantCoca = Vdist(x,y,z,cocaX,cocaY,cocaZ)
		if disPlantCoca <= 30 then
			for k,v in pairs(coca) do
				local distance = Vdist(x,y,z,v[2],v[3],v[4])
				if distance <= 5 then
					idle = 5
					if parseInt(progress[k]) >= 100 then
						DrawText3Ds(v[2],v[3],v[4]-0.7,"[~g~E~w~] para ~g~COLHER~w~.")
					elseif progress[k] then
						DrawText3Ds(v[2],v[3],v[4]-0.7,"REAGINDO: ~g~"..progress[k].."~w~%.")
					else
						DrawText3Ds(v[2],v[3],v[4]-0.7,"[~g~E~w~] para ~g~ADUBAR~w~.")
					end

					if distance <= 1 and IsControlJustPressed(1,38) then
						vSERVER.startPlanting(k,v[1])
					end
				end
			end
		end
		local disProcMeta = Vdist(x,y,z,metaX,metaY,metaZ)
		if disProcMeta <= 30 then

		end
		Citizen.Wait(idle)
	end
end)
-- EMBALAR MACONHA
Citizen.CreateThread(function()
	while true do
		local idle = 1000
		local ped = PlayerPedId()
		local x,y,z = table.unpack(GetEntityCoords(ped))
		for k,v in pairs(weedchair) do
			local distance = Vdist(v[1],v[2],v[3],x,y,z)
			if distance <= 2 and not weedchairprogress then
				idle = 5
				DrawText3Ds(v[1],v[2],v[3], "[~p~E~w~] Para ~p~EMBALAR~w~ o produto.")
			end
			if distance <= 1.2 then
				idle = 5
				if IsControlJustPressed(0,38) then
					if vSERVER.tryPackProduct() then
						weedchairprogress = true
						isWeedChairTimeTrue()
						weedchairtime = 10
					end
				end
			end
			if weedchairprogress then
				DrawText3Ds(x,y,z, "Aguarde [ ~p~"..weedchairtime.."~w~ ] segundos")
			end
		end
		Wait(idle)
	end
end)

-- THREAD DE TEMPO DE EMBALAR MACONHA
function isWeedChairTimeTrue()
	Citizen.CreateThread(function()
		while true do
			if weedchairprogress then
				if weedchairtime > 0 then
					weedchairtime = weedchairtime - 1
				end
				if weedchairtime <= 0 then
					weedchairtime = 0
					weedchairprogress = false
				end
			else
				break
			end
			Wait(1000)
		end
	end)
end

-- PROCESSAMENTO DE COCAINA
local cl_progress = 0
local incl_process = false
local isready = false
local isprocessing = false
Citizen.CreateThread(function()
	while true do
		local idle = 1000
		local ped = PlayerPedId()
		local x,y,z = table.unpack(GetEntityCoords(ped))
		local disProcCoca = Vdist(x,y,z,-1105.58,4948.24,218.65)
		if disProcCoca <= 30 then
			idle = 5
			local distance = Vdist(x,y,z,-1108.26,4938.33,219.65)
			if distance <= 5 then
				idle = 5
				if parseInt(cl_progress) >= 100 then
					DrawText3Ds(-1108.26,4938.33,219.65-0.7,"[~g~E~w~] para ~g~PEGAR~w~ a droga.")
				elseif parseInt(cl_progress) > 0 and parseInt(cl_progress) < 100 then
					DrawText3Ds(-1108.26,4938.33,219.65-0.7,"PROCESSANDO: ~g~"..cl_progress.."~w~%.")
				else
					DrawText3Ds(-1108.26,4938.33,219.65-0.7,"[~g~E~w~] para ~g~PROCESSAR~w~ a pasta.")
				end
				if distance <= 1.3 then
					if IsControlJustPressed(0,38) and not isprocessing and not isready then
						if vSERVER.tryGetDrugsFromInv("pasta-coca") then
							incl_process = true
							startcl_process()
							isprocessing = true
						else
							TriggerEvent("Notify","negado","Quantidade inválida.")
						end
					end
					if isready and IsControlJustPressed(0,38) then
						if vSERVER.tryGiveDrugsToInv() then
							cl_progress = 0
							incl_process = false
							isready = false
						end
					end
				end
			end
		end
		Wait(idle)
	end
end)
-- FARM DE COCAINA
Citizen.CreateThread(function()
	while true do
		local idle = 1000
		local ped = PlayerPedId()
		local x,y,z = table.unpack(GetEntityCoords(ped))
		local distance = Vdist(stepCocaX,stepCocaY,stepCocaZ,x,y,z)
		local distance2 = Vdist(step2CocaX,step2CocaY,step2CocaZ,x,y,z)
		local distance3 = Vdist(step3CocaX,step3CocaY,step3CocaZ,x,y,z)
		local distance4 = Vdist(embalarCocaX,embalarCocaY,embalarCocaZ,x,y,z)
		local generalDist = Vdist(-1106.51,4949.12,219.52,x,y,z)
		if generalDist <= 12 then
			idle = 5
			if distance <= 3 and cocastep == 0 then
				DrawText3Ds(stepCocaX,stepCocaY,stepCocaZ, "[~g~E~w~] Para ~g~PEGAR~w~ o reagente.")
				if distance <= 1.2 then
					if IsControlJustPressed(0,38) then
						updateFactoryText()
						cocastep = 1
					end
				end
			end
			
			if distance2 <= 3 and cocastep == 1 and not incocaprocess then
				DrawText3Ds(step2CocaX,step2CocaY,step2CocaZ, "[~g~E~w~] Para ~g~ADICIONAR~w~ o reagente.")
				if distance2 <= 1.2 then
					if IsControlJustPressed(0,38) then
						if vSERVER.takeCokeFlower() then
							incocaprocess = true
							isCocaTimeTrue()
							segundos = 15
						end
					end
				end
			end
			
			if distance3 <= 3 and cocastep == 2 and not inpastaprocess then
				DrawText3Ds(step3CocaX,step3CocaY,step3CocaZ, "[~g~E~w~] Para ~g~FABRICAR~w~ a pasta.")
				if distance3 <= 1.2 then
					if IsControlJustPressed(0,38) then
						 if vSERVER.getCokePasta() then
							inpastaprocess = true
							isPastaTimeTrue()
							pastasegundos = 15
						end
					end
				end
			end
			local embalando = false
			if distance4 <= 3 and not embalando then
				DrawText3Ds(embalarCocaX,embalarCocaY,embalarCocaZ, "[~g~E~w~] Para ~g~EMBALAR~w~ a droga.")
				if distance4 <= 1.2 then
					if IsControlJustPressed(0,38) then
						vSERVER.tryPackCoca()
					end
				end
			end
			if inpastaprocess then
				DrawText3Ds(step3CocaX,step3CocaY,step3CocaZ, "~g~FABRICANDO~w~, aguarde [ ~g~"..pastasegundos.."~w~ ] segundos")
			end
			if incocaprocess then
				DrawText3Ds(step2CocaX,step2CocaY,step2CocaZ, "~g~REAGINDO~w~, aguarde [ ~g~"..segundos.."~w~ ] segundos")
			end
		end
		Wait(idle)
	end
end)

-- THREAD DE TEMPO DE COCAINA
function isCocaTimeTrue()
	Citizen.CreateThread(function()
		while true do
			if incocaprocess then
				if segundos > 0 then
					segundos = segundos - 1
				end
				if segundos <= 0 then
					segundos = 0
					incocaprocess = false
					cocastep = 2
				end
			else
				break
			end
			Wait(1000)
		end
	end)
end

-- THREAD DE TEMPO DE PASTA DE COCA
function isPastaTimeTrue()
	Citizen.CreateThread(function()
		while true do
			if inpastaprocess then
				if pastasegundos > 0 then
					pastasegundos = pastasegundos - 1
				end
				if pastasegundos <= 0 then
					pastasegundos = 0
					inpastaprocess = false
					cocastep = 0
				end
			else
				break
			end
			Wait(1000)
		end
	end)
end
-- UPDATE TEXT COCA
function updateFactoryText()
	Citizen.CreateThread(function()
		while true do
			if cocastep == 1 then
				DrawText3Ds(stepCocaX,stepCocaY,stepCocaZ, "REAGENTE PEGO...")
			elseif cocastep == 2 then
				DrawText3Ds(step2CocaX,step2CocaY,step2CocaZ, "REAGENTE ADICIONADO...")
			else
				break
			end
			Wait(5)
		end
	end)
end

-- FARM DE METANFETAMINA
local isTimeUp = false
local startedMeth = false
local needTime = false
local needTime2 = false
local metastep = 0
local inwashprocess = false
Citizen.CreateThread(function()
	while true do
		local idle = 1000
		local ped = PlayerPedId()
		local x,y,z = table.unpack(GetEntityCoords(ped))
		local general_distance = Vdist(1497.6,6391.99,22.6,x,y,z)
		local distance = Vdist(1505.46,6391.97,20.79,x,y,z) -- PEGAR REAGENTE
		local distance2 = Vdist(1493.17,6390.25,21.26,x,y,z) -- MISTURAR REAGENTE
		local distance3 = Vdist(1490.43,6391.15,20.79,x,y,z) -- MISTURAR COMPOSITO
		if general_distance <= 30 then
			idle = 5
			if distance < 3 and metastep == 0 and not inwashprocess then
				DrawText3Ds(1505.46,6391.97,20.79, "[~y~E~w~] Para ~y~PEGAR~w~ o reagente.")
				if distance <= 1.2 then
					if IsControlJustPressed(0,38) and not startedMeth then
						updateMethText()
						startedMeth = true
						metastep = 1
					end
				end
			end
			if distance2 < 3 and metastep == 1 and not needTime then
				if not isTimeUp then
					DrawText3Ds(1493.17,6390.25,21.26, "[~y~E~w~] Para ~y~MISTURAR~w~ os ingredientes.")
				end
				if distance2 <= 1.2 then
					if IsControlJustPressed(0,38) then
						if not isTimeUp then
							if vSERVER.takeIngredients() then
								needTime = true
								isMethTimeTrue()
								methtime = 15
								
							end
						else
							if vSERVER.getComposit() then
								metastep = 2
							end
						end
					end
				end
			end
		end
		if distance3 < 3 and metastep == 2 then
			if parseInt(cl_progress) >= 100 then
				DrawText3Ds(1490.43,6391.15,20.79, "[~y~E~w~] Para ~y~PEGAR~w~ a metanfetamina.")
			elseif parseInt(cl_progress) > 0 and parseInt(cl_progress) < 100 then
				DrawText3Ds(1490.43,6391.15,20.79, "COZINHANDO: ~y~"..cl_progress.."~w~%.")
			else
				DrawText3Ds(1490.43,6391.15,20.79, "[~y~E~w~] Para ~y~MISTURAR~w~ o compósito com querosene.")
			end
			if distance3 <= 1.3 then
				if IsControlJustPressed(0,38) and not isready and not isprocessing then
					if vSERVER.mixComposit() then
						incl_process = true
						startcl_process()
						isprocessing = true
					end
				end
				if isready and IsControlJustPressed(0,38) then
					if vSERVER.getMethFromFactory() then
						cl_progress = 0
						incl_process = false
						isready = false
						startedMeth = false
						metastep = 0
					end
				end
			end
		end
		if needTime then
			DrawText3Ds(1493.17,6390.25,21.26, "~y~REAGINDO~w~, aguarde [ ~y~"..methtime.."~w~ ] segundos")
		end
		Wait(idle)
	end
end)
-- EMBALAR METANFETAMINA
local washstep = 0
local lavada = false
Citizen.CreateThread(function()
	while true do
		local idle = 1000
		local ped = PlayerPedId()
		local x,y,z = table.unpack(GetEntityCoords(ped))
		local general_distance = Vdist(1497.6,6391.99,22.6,x,y,z)
		local distance = Vdist(1494.64,6395.5,20.79,x,y,z)
		local distance2 = Vdist(1500.48,6394.17,20.79,x,y,z)
		if general_distance <= 30 then
			idle = 5
			if distance <= 3 and not startedMeth then
				if parseInt(cl_progress) >= 100 then
					DrawText3Ds(1494.64,6395.5,20.79, "DROGA LAVADA...")
				elseif parseInt(cl_progress) > 0 and parseInt(cl_progress) < 100 then
					DrawText3Ds(1494.64,6395.5,20.79, "LAVANDO: ~y~"..cl_progress.."~w~%.")
				else
					DrawText3Ds(1494.64,6395.5,20.79, "[~y~E~w~] Para ~y~LAVAR~w~ a metanfetamina.")
				end
				if distance <= 1.2 then
					if IsControlJustPressed(0,38) and not isready and not isprocessing then
						if vSERVER.tryWashItem() then
							incl_process = true
							startcl_process()
							isprocessing = true
							inwashprocess = true
							lavada = true
							washstep = 1
						end
					end
				end
			end
			if distance2 <= 8 and isready then
				if washstep == 1 then
					DrawText3Ds(1500.48,6394.17,20.79, "[~y~E~w~] Para ~y~EMBALAR~w~ a metanfetamina.")
				end
				if distance2 <= 1.2 then
					if IsControlJustPressed(0,38) then
						if vSERVER.tryPackMeth() then
							washstep = 0
							lavada = false
							incl_process = false
							inwashprocess = false
							cl_progress = 0
							isready = false
						end
					end
				end
			end
		end
		Wait(idle)
	end
end)

-- THREAD DO PROCESSO NO CLIENT-SIDE
function startcl_process()
	Citizen.CreateThread(function()
		while true do
			if incl_process and not isready then
				if cl_progress ~= nil and cl_progress < 100 then
					cl_progress = cl_progress + 1
					Citizen.Wait(10)
				end
				if cl_progress == 100 then
					isready = true
					isprocessing = false
				end
			else
				break
			end
			Citizen.Wait(200)
		end
	end)
end
-- UPDATE DE TEXTO DE META
function updateMethText()
	Citizen.CreateThread(function()
		while true do
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local general_distance = Vdist(1497.6,6391.99,22.6,x,y,z)
			if general_distance <= 30 then
				if startedMeth then
					if metastep == 1 then
						DrawText3Ds(1505.46,6391.97,20.79, "REAGENTE PEGO...")
						if isTimeUp then
							DrawText3Ds(1493.17,6390.25,21.26, "[~y~E~w~] Para ~y~PEGAR~w~ o compósito.")
						end
					elseif metastep == 2 then
						DrawText3Ds(1493.17,6390.25,21.26, "COMPÓSITO PEGO...")
						isTimeUp = false
					
					end
				else
					break
				end
			end
			Wait(1)
		end
	end)
end
-- THREAD DE TEMPO DE META
function isMethTimeTrue()
	Citizen.CreateThread(function()
		while true do
			if startedMeth then
				if methtime > 0 then
					methtime = methtime - 1
				end
				if methtime <= 0 then
					methtime = 0
					needTime = false
					isTimeUp = true
				end
			else
				break
			end
			Wait(1000)
		end
	end)
end
-- LOJA DE INGREDIENTES DE META
systemX = 337.91
systemY = -1101.02
systemZ = 29.41
onMenu = false

local menuactive = false
function ToggleActionMenu()
	menuactive = not menuactive
	if menuactive then
		onMenu = true
		SetNuiFocus(true,true)
		TransitionToBlurred(1000)
		SendNUIMessage({ showmenu = true })
		TriggerEvent("bdl:triggerhud")
	else
		onMenu = false
		SetNuiFocus(false)
		TransitionFromBlurred(1000)
		SendNUIMessage({ hidemenu = true })
		TriggerEvent("bdl:triggerhud")
	end
end


RegisterNUICallback("ButtonClick",function(data,cb)
	local ped = PlayerPedId()
	if data == "querosene" then
        TriggerServerEvent("meth-comprar","querosene")
		
	elseif data == "acido" then
		TriggerServerEvent("meth-comprar","acido")
		
	elseif data == "comprimidos" then
		TriggerServerEvent("meth-comprar","comprimidos")
		
	elseif data == "fechar" then
		ToggleActionMenu()
	end
end)

Citizen.CreateThread(function()
    while true do
        local sleep = 1000
        local ped = PlayerPedId()
        local x,y,z = table.unpack(GetEntityCoords(ped))
        local distance2 = Vdist(systemX,systemY,systemZ,x,y,z)
        if distance2 <= 4 then
            sleep = 5
            if not onMenu then
                DrawMarker(30, systemX,systemY,systemZ-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,255,180,0,90,0,0,0,1)
                if distance2 <= 2 then
                    DrawText3Ds(systemX,systemY,systemZ, "[~y~E~w~] Para ~y~ABRIR~w~ o sistema.")
                    if distance2 <= 1.1 then
                        if IsControlJustPressed(0,38) and vSERVER.getUserPermission("vagos.permission") then
                            ToggleActionMenu()
                        end
                    end
                end
            end
        end
        Wait(sleep)
    end
end)

-- FUNÇÕES DE TEXTO GERAIS
function drawTxt(text,font,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextScale(scale,scale)
	SetTextColour(r,g,b,a)
	SetTextOutline()
	SetTextCentre(1)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x,y)
end

function DrawText3Ds(x,y,z,text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.4, 0.4)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
end
-- SETAR O PROP DAS PLANTAS NO CHÃO
Citizen.CreateThread(function()
	local hash = GetHashKey(prop)
	for k,v in pairs(coca) do
		RequestModel(hash)
		while not HasModelLoaded(hash) do
			RequestModel(hash)
			Citizen.Wait(10)
		end

		local weed = CreateObject(hash,v[2],v[3],v[4]-1,false,true,true)
		PlaceObjectOnGroundProperly(weed)
	end
end)
