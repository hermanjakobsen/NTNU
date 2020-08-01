
#= ***** Oppgave 1 ***** =#
function can_use_greedy(coins)
    for i = 1 : length(coins) - 1
        if (coins[i] % coins[i+1] != 0) # Sjekker om c_i / c_(i+1) er et naturlig tall (heltall)
            return false
        end
    end
    return true
end

#= ***** Oppgave 2 ***** =#
function min_coins_greedy(coins, value)
    remainingValue = value
    minCoins = 0
    for i = 1 : length(coins)
        while (remainingValue - coins[i] >= 0) # Kunne også brukt heltallsdivisjon. Hadde spart en løkke
            remainingValue -= coins[i]
            minCoins += 1
        end
    end
    return minCoins
end

#= ***** Oppgave 3 ***** =#
# Føler at oppgaven har likheter med stavkutting
# Forskjellen er at nå skal man bygge opp en stav av lengde value, ved å bruke færrest mulig deler.
# De ulike delene har lengde gitt av elementene i coins.
function min_coins_dynamic(coins, value)
    r = Array{Int}(undef, value) # Kanskje unødvendig stort array. Fines sikkert noe mer plassbesparende
    for i = 1 : length(r)
        r[i] = 0
    end
    return aux(coins, value, r) # Finner den beste løsningen for value, og returnerer den.
end


function aux(coins, value, r)

    if value == 0 # Trenger ingen mynter
        return 0
    end

    if r[value] != 0 # Allerede løst delproblemet
        return r[value]
    end

    # Løser delproblemet
    opt_numb_coins = typemax(Int)

    for i = 1 : length(coins)
        if (coins[i] <= value) # Det er "lovlig" å bruke mynten
            newValue = value - coins[i]
            curr_numb_coins = 1 + aux(coins, newValue, r) # Den resterende "value"-en må så løses optimalt
            opt_numb_coins = min(curr_numb_coins, opt_numb_coins) # opt_numb_coins settes til den beste løsningen av curr og opt. Ble den nye løsningen bedre enn den vi hadde?
        end
    end
    r[value] = opt_numb_coins # Lagrer verdien til delproblemet
    return opt_numb_coins
end


coins = [1000, 500, 100, 20, 5, 1]

println(min_coins_dynamic(coins, 1226))
