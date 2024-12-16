-- English traductions
return {
    descriptions = {
        Joker = {
            j_chr_helloworld = {
                name = "Hello World!",
                text = {
                    "{C:mult}+#1#{} mult", 
                    "{C:inactive,s:0.7}print(\"Hello world!\")" 
                }
            },
            j_chr_spain = {
                name = "Spain",
                text = {
                    "{X:mult,C:white}X#1#{} mult if playing hand",
                    "has at least one scoring",
                    "{C:hearts}heart{} and {C:diamonds}diamond{} cards",
                    "{C:inactive,s:0.7}ñ"
                }
            },
            j_chr_eggsandwich = {
                name = "Egg Sandwich",
                text = {
                    "When an {C:attention,T:j_egg}Egg{} is sold," ,
                    "this joker earns {X:mult,C:white}X#1#{} multiplied by", 
                    "the {C:money}sell value{} of the sold {C:attention,T:j_egg}Egg{}",
                    "{C:inactive}(Currently: {X:mult,C:white}X#2#{C:inactive} mult)",
                    "{C:inactive,s:0.7}Anabolic"
                }
            },
            j_chr_roulette = {
                name = "The roulette",
                text = {
                    "Spin a casino roulette every {C:blue}hand{} and {C:red}discard{}",
                    "{C:red}Lose {C:money}$#2#{} {C:red}for each played {C:blue}hand",
                    " ",
                    "Each scoring card of the {C:attention}result{} color grants",
                    "{C:mult}base mult{} according to the number of the {C:attention}result",
                    "If the {C:attention}result{} is {X:green,C:white}0{}, all scoring cards",
                    "grant {C:mult}+#3#{} mult and {C:money}$#4#{}",
                    "{C:inactive}(Result: {V:1}#1#{}{C:inactive})",
                    "{C:inactive,s:0.7}ALL ON {X:green,C:white,s:0.7}GREEN{}{C:inactive,s:0.7}!!!",
                }
            }
        }
    }
}