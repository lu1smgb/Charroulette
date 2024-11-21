return {
    descriptions = {
        Back = {
            b_chr_debug = {
                name = 'Baraja debug',
                text = {
                    "Comienza con {C:money}$#1#{} y", 
                    "un comodín {C:dark_edition,T:j_chr_helloworld}HelloWorld {C:dark_edition,T:e_negative}negativo" 
                }
            }
        },
        Joker = {
            j_chr_helloworld = {
                name = "Hola mundo!",
                text = {
                    "{C:mult}+#1#{} multi", 
                    "{C:inactive,s:0.7}print(\"Hola mundo!\")" 
                }
            },
            j_chr_spain = {
                name = "España",
                text = {
                    "{X:mult,C:white}X#1#{} de multi si la mano jugada",
                    "contiene al menos una carta de",
                    "{C:hearts}corazones{} y de {C:diamonds}diamantes{}",
                    "que anotan",
                    "{C:inactive,s:0.7}ñ"
                }
            },
            j_chr_eggsandwich = {
                name = "Bocata de huevo",
                text = {
                    "Cuando se vende un {C:attention,T:j_egg}Huevo{}," ,
                    "este comodín gana {X:mult,C:white}X#1#{} por el", 
                    "{C:money}valor de venta{} del {C:attention,T:j_egg}Huevo{} vendido",
                    "{C:inactive}(Actualmente: {X:mult,C:white}X#2#{C:inactive} multi)",
                    "{C:inactive,s:0.7}Anabólico"
                }
            },
            j_chr_roulette = {
                name = "Ruleta",
                text = {
                    "Gira una ruleta de casino en cada {C:blue}mano{} y {C:red}descarte{}",
                    "{C:red}Pagas {C:money}$#2#{} {C:red}por cada {C:blue}mano{} usada al final de la ronda",
                    " ",
                    "Cada carta del color del {C:attention}resultado{} otorga",
                    "{C:mult}multi base{} según el número del {C:attention}resultado{}",
                    "Si el resultado es {X:green,C:white}0{}, todas las cartas",
                    "que anotan otorgan {C:mult}+#3#{} multi y {C:money}$#4#",
                    "{C:inactive}(Resultado: {V:1}#1#{}{C:inactive})",
                    "{C:inactive,s:0.7}TODO AL {}{X:green,C:white,s:0.7}VERDE{}{C:inactive,s:0.7}!!!",
                }
            }
        }
    }
}