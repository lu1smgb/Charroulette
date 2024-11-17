-- English traductions
return {
    descriptions = {
        Back = {
            b_chr_debug = {
                name = 'Debug deck',
                text = {
                    "Start with {C:money}$#1#M{} and", 
                    "an {C:dark_edition,T:j_chr_helloworld}Hello World! {C:dark_edition,T:e_negative}negative joker"
                }
            }
        },
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
        }
    }
}