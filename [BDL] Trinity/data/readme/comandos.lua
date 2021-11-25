-- [ BADLAND BASE v3.0.4 - TRINITY ] --
-- Comandos (Commands)

-- Administração (Staff Team)
--[[ pt-BR

    /item [item] [quantidade] # Spawnar item
    /clearinv [id] # Limpar inventário
    /uservehs [id] # Veículos do usuário
    /vroupas # Código de roupas
    /adm [mensagem] # Mensagem de ADM
    /addcar [veiculo] [id] # Adicionar carro
    /remcar [veiculo] [id] # Remover carro
    /veh [veiculo] # Spawnar veículo 
    /uncuff # Tirar algema
    /limpararea # Limpar Área
    /apagao # Apagão na cidade
    /raios [quantidade] # Raios na cidade
    /skin [id] [modelo] # Setar skin
    /showinfo # Mostrar informações do cenário
    /fix # Arrumar veículo
    /god # Reviver
    /god [id] # Reviver ID
    /cargod # Reviver dentro do carro
    /cargod [id] # Reviver ID dentro do carro
    /godall # Reviver todos
    /tuning # Tunar veículo
    /100fuel # Setar gasolina como 100
    /wl [id] # Adicionar na WL
    /unwl [id] # Remover da WL
    /kick [id] # Expulsar jogador
    /kickall # Expulsar a todos
    /ban [id] # Banir jogador
    /unban [id] # Desbanir jogador
    /money [quantidade] # Pegar Dinheiro
    /nc # Ativar NoClip
    /tpcds # Teletransportar para coordenadas
    /cds # Pegar coordenadas
    /cds2 # Pegar coordenadas 2
    /group [id] [grupo] # Setar jogador no grupo
    /ungroup [id] [grupo] # Tirar jogador do grupo
    /tptome [id] # Teletransportar jogador à mim 
    /tpto [id] # Teletransportar para o jogador
    /tpway # Teletransportar para Waypoint
    /delnpcs # Deletar NPCs
    /players # Players online
    /carcolor # Mudar cor do veiculo
    /killall # Matar a todos
    /kill # Se matar
    /kill [id] # Matar jogador

    en-US

    /item [item] [amount] # Spawn item
    /clearinv [id] # Clear player inventory
    /uservehs [id] # Get player vehicle list
    /vroupas # Get clothes ID
    /adm [mensagem] # Send staff message to all players
    /addcar [vehicle] [id] # Add vehicle in player garage
    /remcar [vehicle] [id] # Remove vehicle from player garage
    /veh [vehicle] # Spawn vehicle
    /uncuff # Uncuff
    /limpararea # Clear area around
    /apagao # City blackout
    /raios # Thunder
    /skin [id] [model] # Set player skin
    /showinfo # Show scenario info
    /fix # Fix vehicle
    /god # Revive
    /god [id] # Revive player
    /cargod # Revive inside vehicle
    /cargod [id] # Revive player inside vehicle
    /godall # Revive all players
    /tuning # Upgrade a vehicle
    /100fuel # Set vehicle fuel to 100
    /wl [id] # Add user in whitelist
    /unwl [id] # Remove user from whitelist
    /kick [id] # Kick player from server
    /kickall # Kick all players
    /ban [id] # Ban player
    /unban [id] # Unban player
    /money [amount] # Give money
    /nc # Toogle NoClip
    /tpcds # Teleport to coordinates
    /cds # Get coordinates
    /cds2 # Get coordinates 2
    /group [id] [group] # Add player to group
    /ungroup [id] [group] # Remove player from group
    /tptome [id] # Teleport player to me
    /tpto [id] # Teleport to player
    /tpway # Teleport to waypoint
    /delnpcs # Delete NPCs
    /players # Get number of players online
    /carcolor # Set vehicle color
    /killall # Kill all player
    /kill # Kill yourself
    /kill [id] Kill Player

]]

-- Jogadores (Players)
--[[ pt-BR
    /debug # Desbugar
    /sequestro # Sequestrar player próximo
    /enviar [quantidade] # Enviar dinheiro
    /garmas # Guardar armas
    /roubar # Roubar jogador próximo
    /saquear # Saquear jogador próximo (morto)
    /revistar # Revistar jogador próximo
    /mascara [id]
    /blusa [id]
    /colete [id]
    /jaqueta [id]
    /maos [id]
    /calca [id]
    /acessorios [id]
    /sapatos [id]
    /chapeu [id]
    /oculos [id]
    /me [mensagem] # Mensagem 3D
    /id # Pegar ID no player proximo

    en-US

    /debug # Try debug player
    /sequestro # Hijack nearest player
    /enviar [amount] # Send money
    /garmas # Store weapons
    /roubar # Rob nearest player
    /saquear # Loot nearest dead player
    /revistar # Search nearest player
    /mascara [id]
    /blusa [id]
    /colete [id]
    /jaqueta [id]
    /maos [id]
    /calca [id]
    /acessorios [id]
    /sapatos [id]
    /chapeu [id]
    /oculos [id]
    /me [message] # Send 3D Message
    /id # Get ID from nearest player
]]

-- Polícia (Police)
--[[ pt-BR
    /placa # Checar placa do veículo
    /ptr # Ver oficiais em PTR
    /porte [id] [ação] # Administrar porte
    /p # Mandar localização
    /911 [mensagem] # Chat da policia
    /pd  [mensagem] # Chat interno
    /multar # Multar jogador
    /ocorrencia # Registrar ocorrencia
    /detido # Confiscar veiculo
    /prender [id] [tempo] # Prender jogador
    /rg [id] # Pegar RG do jogador
    /rg # Pegar RG do jogador proximo
    /rmascara # Remover mascara do jogador proximo
    /rchapeu # Remover chapeu do jogador proximo
    /rcapuz # Remover chapeu do jogador proximo
    /cv # Colocar no veiculo
    /rv # Remover do veiculo
    /apreender # Apreender itens ilegais
    /extras # Extras das viaturas
    /cone # Colocar cone
    /barreira # Colocar barreira
    /spike # Colocar spike
    /anuncio [mensagem] # Anunciar como oficial

    en-US

    /placa # Check vehicle plate
    /ptr # See officers on duty
    /porte [id] [ação] # Administrate gun license
    /p # Send localization
    /911 [message] # Police chat
    /pd  [message] # Intern chat
    /multar # Citate player
    /ocorrencia # Register report
    /detido # Impound vehicle
    /prender [id] [time] # Put player in jail
    /rg [id] # Take player ID
    /rg # Take nearest player ID
    /rmascara # Remove player mask
    /rchapeu # Remove player hat
    /rcapuz # Remove player blind
    /cv # Put in vehicle
    /rv # Remove from vehicle
    /apreender # Take ilegal itens
    /extras # Extra models for cop cars
    /cone # Put cone
    /barreira # Put barrier
    /spike # Put spike
    /anuncio [mensagem] # Make an announcement
]]

-- Hospital (Hospital)
--[[ pt-BR
    /112 [mensagem] # Chat do hospital
    /pr [mensagem] # Chat interno do hospital
    /re # Reviver jogador
    /tratamento # Tratar jogador proximo

    en-US
    /112 [message] # Hospital chat
    /pr [message] # Intern chat
    /re # Revive player
    /tratamento # Take care of player
]]

-- Bennys (Benny's workshop)
--[[ pt-BR
    /bnns [mensagem] # Chat da bennys
    /br [mensagem] # Chat interno da bennys
    /contratar [id] [cargo] # Contratar player
    /promover [id] [cargo] # Promover player
    /demitir [id] # Demitir player
    /mecs # Ver mecânicos em serviço

    en-US

    /bnns [message] # Bennys chat
    /br [message] # Intern chat
    /contratar [id] [cargo] # Hire player
    /promover [id] [cargo] # Promote player
    /demitir [id] # Dismiss player
    /mecs # Number of workers working
]]

-- Botões (Keys)
--[[ pt-BR
    G - Algemar (policia ou com item)
    H - Carregar (policia)
    " - Abrir inventário
    I - Menu de interação da HUD
    E - Interagir
    T - Chat
    SHIFT + SPACE + E - Tackle (se jogar)
]]