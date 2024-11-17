return {
    descriptions = {
        Back = {
            b_chr_debug = {
                name = 'Baraja debug',
                text = {
                    "Comienza con {C:money}$#1#M{} y", 
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
        }
    }
}