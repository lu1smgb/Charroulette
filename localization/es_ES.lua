return {
    descriptions = {
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
                    "{C:money}valor de venta{} del huevo vendido",
                    "Los huevos pueden aparecer varias veces",
                    "{C:inactive}(Actualmente: {X:mult,C:white}X#2#{C:inactive} multi)",
                    "{C:inactive,s:0.7}Anabólico"
                }
            },
            j_chr_roulette = {
                name = "La ruleta",
                text = {
                    "La ruleta gira en cada {C:blue}mano{} y {C:red}descarte{}",
                    "{C:red}Pagas {C:money}$#2#{} {C:red}por {C:blue}mano {C:red}jugada{}",
                    " ",
                    "Las cartas que anotan otorgan",
                    "{C:mult}multi{} segun el resultado",
                    "{C:green}#3# en #4#{} de que las cartas que anotan",
                    "otorguen {C:mult}+#5#{} multi y {C:money}$#6#{}",
                    "{C:inactive}(Resultado: {V:1}#1#{}{C:inactive})",
                    "{C:inactive,s:0.7}TODO AL {}{X:green,C:white,s:0.7}VERDE{}{C:inactive,s:0.7}!!!",
                }
            },
            j_chr_slotmachine = {
                name = "Tragaperras",
                text = {
                    "Gana {C:mult}+#1#{} de multi",
                    "por cada {C:attention}#2#{} que anota"
                }
            },
            j_chr_doublon = {
                name = "El doblón",
                text = {
                    "Crea una carta {C:attention}La templanza{} {C:dark_edition}negativa{} si",
                    "la primera mano de la ronda contiene un",
                    "{C:attention}As{} de {V:1}Diamantes{} que anota"
                }
            },
            j_chr_club = {
                name = "El basto",
                text = {
                    "Crea una carta {C:attention}La emperatriz{} {C:dark_edition}negativa{} si",
                    "la primera mano de la ronda contiene un",
                    "{C:attention}As{} de {V:1}Tréboles{} que anota"
                }
            },
            j_chr_sword = {
                name = "La espada",
                text = {
                    "Crea una carta {C:attention}El hierofante{} {C:dark_edition}negativa{} si",
                    "la primera mano de la ronda contiene un",
                    "{C:attention}As{} de {V:1}Picas{} que anota"
                }
            },
            j_chr_chalice = {
                name = "El cáliz",
                text = {
                    "Crea una carta {C:attention}El carruaje{} {C:dark_edition}negativa{} si",
                    "la primera mano de la ronda contiene un",
                    "{C:attention}As{} de {V:1}Corazones{} que anota"
                }
            },
            j_chr_jv = {
                name = "JV",
                text = {
                    "{C:inactive, s:1.5}???{}"
                }
            },
            j_chr_sigma = {
                name = "Sigma",
                text = {
                    "Al jugar una escalera, este comodín",
                    "gana la suma de la categoría de las",
                    "cartas que anotan en {C:chips}fichas{}",
                    "{C:inactive}(Actualmente: {}{C:chips}+#1#{}{C:inactive}){}",
                    "{C:inactive, s:0.7}esmegma{}"
                }
            }
        }
    },
    misc = {
        dictionary = {
            k_chr_created_card = "Carta!",
            k_chr_plus_upgrade = "+#1#"
        }
    }
}