-- Charroulette Balatro Mod
-- Jokers Module
-- lu1smgb@18/12/2024

-- ###########################################################################################################
-- Misc functions
-- ###########################################################################################################

-- Common function effect for the Doubloon, Club, Sword and Chalice jokers
function spanish_ace_effect(selfcard, card, context)
    local trigger = false
    if context.cardarea == G.jokers and not selfcard.debuff and context.after
    and G.GAME.current_round.hands_played == 0 then
        -- Searches for the required card
        for i=1, #context.scoring_hand do
            local pc = context.scoring_hand[i]
            if pc:is_suit(selfcard.config.req_card.suit) and pc:get_id() == selfcard.config.req_card.id then
                trigger = true
                break
            end
        end
        if trigger then
            G.E_MANAGER:add_event(Event({
                trigger = 'before',
                delay = 0,
                func = function ()
                    local created_card = create_card(
                        'Tarot',
                        G.consumeables,
                        nil,
                        nil,
                        nil,
                        nil,
                        selfcard.config.created_card,
                        selfcard.key
                    )
                    created_card:set_edition({negative = true}, true)
                    created_card:add_to_deck()
                    G.consumeables:emplace(created_card)
                    return true
                end
            }))
            return {
                message = localize('k_chr_created_card', 'misc'),
                colour = G.C.SUITS[selfcard.config.req_card.suit],
                card = selfcard
            }
        end
    end
end

-- ###########################################################################################################
-- Atlas
-- ###########################################################################################################

SMODS.Atlas {
    key = "jokers",
    px = 71,
    py = 95,
    path = {
        ['default'] = 'Jokers.png'
    },
    atlas_table = 'ASSET_ATLAS'
}

-- ###########################################################################################################
-- Jokers
-- ###########################################################################################################

-- Hello World (Test Joker, might be deleted)
SMODS.Joker {
    key = 'helloworld',
    atlas = 'jokers',
    rarity = 1,
    loc_txt = localize{ type = 'descriptions', set='Joker', key = 'j_chr_helloworld' },
    loc_vars = function(self)
        return { vars = {self.config.mult} }
    end,
    unlocked = true,
    discovered = true,
    cost = 3,
    pos = { x = 0, y = 0 },
    config = {
        mult = 10
    },
    blueprint_compat = true,
    eternal_compat = true,
    calculate = function (self, card, context)
        if context.cardarea == G.jokers and not context.after and not context.before then
            local mult = card.ability.mult
            local card_action = {
                message = localize{ type='variable', key='a_mult', vars={ mult } },
                mult_mod = mult
            }
            return card_action
        end
    end
}

-- Spain
SMODS.Joker {
    key = 'spain',
    atlas = 'jokers',
    pos = {x = 1, y = 0},
    rarity = 2,
    loc_txt = localize{ type = 'descriptions', set='Joker', key = 'j_chr_spain' },
    loc_vars = function(self)
        return { vars = { self.config.x_mult } }
    end,
    cost = 6,
    config = {
        x_mult = 3
    },
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    calculate = function (self, card, context)

        if context.cardarea == G.jokers and not context.before and not context.after and context.scoring_hand then

            -- Highly "inspired" Flower Pot code

            local conditions = {
                ['Hearts'] = 0,
                ['Diamonds'] = 0
            }

            for i = 1, #context.scoring_hand do
                if context.scoring_hand[i].ability.name ~= 'Wild Card' then
                    if context.scoring_hand[i]:is_suit('Hearts', true) 
                        then conditions["Hearts"] = conditions["Hearts"] + 1
                    elseif context.scoring_hand[i]:is_suit('Diamonds', true) then 
                        conditions["Diamonds"] = conditions["Diamonds"] + 1 
                    end
                elseif context.scoring_hand[i].ability.name == 'Wild Card' then
                    if context.scoring_hand[i]:is_suit('Hearts') or conditions["Diamonds"] > 0 then 
                        conditions["Hearts"] = conditions["Hearts"] + 1
                    elseif context.scoring_hand[i]:is_suit('Diamonds') or conditions["Hearts"] > 0 then 
                        conditions["Diamonds"] = conditions["Diamonds"] + 1 
                    end
                end
            end

            sendDebugMessage("H: " .. conditions['Hearts'] .. "; D: " .. conditions['Diamonds'], self.key)

            if conditions['Hearts'] > 0 and conditions['Diamonds'] > 0 then
                sendDebugMessage("Triggered", self.key)
                return {
                    message = localize{ type='variable', key='a_xmult', vars={self.config.x_mult} },
                    Xmult_mod = self.config.x_mult
                }
            end

        end
    end
}

-- Egg Sandwich
-- TODO IDEA: Eggs are likely to appear more (showman effect)
SMODS.Joker {
    key = 'eggsandwich',
    atlas = 'jokers',
    pos = {x = 2, y = 0},
    rarity = 2,
    loc_txt = localize{ type='descriptions', set='Joker', key='j_chr_eggsandwich' },
    loc_vars = function (self, info_queue, center)
        return { 
            vars = {
                center.ability.extra.sell_bonus_factor, 
                center.ability.x_mult
            } 
        }
    end,
    cost = 5,
    config = {
        x_mult = 1,
        name = "Egg Sandwich",
        extra = {
            sell_bonus_factor = 0.1
        }
    },
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    calculate = function (self, card, context)
        local _xmult = card.ability.x_mult
        if context.cardarea == G.jokers and not context.before and not context.after and _xmult > 1 then
            return {
                message = localize{ type='variable', key='a_xmult', vars = {_xmult}},
                Xmult_mod = _xmult
            }
        end
    end
}

-- Implementation of Egg synergies
SMODS.Joker:take_ownership('egg', {
    calculate = function (self, card, context)
        if not card.debuff and context.selling_self and not context.blueprint then
            local sandwiches = SMODS.find_card('j_chr_eggsandwich')
            for _, sandwich in ipairs(sandwiches) do
                local actual_mult = sandwich.ability.x_mult
                local added_mult = sandwich.ability.extra.sell_bonus_factor * card.sell_cost
                local upgraded_mult = actual_mult + added_mult
                sendDebugMessage('Mejora ' .. actual_mult .. ' + ' .. added_mult .. ' -> ' .. upgraded_mult, sandwich.key)
                sandwich.ability.x_mult = upgraded_mult
                G.E_MANAGER:add_event(Event({
                    func = function()
                        card_eval_status_text(
                            sandwich, 
                            'extra', 
                            nil, 
                            nil, 
                            nil, 
                            {message = localize {
                                type='variable', 
                                key='a_xmult', 
                                vars={ sandwich.ability.x_mult }}
                            }
                        )
                        return true
                    end               
                }))
            end
        end
    end
})

-- Roulette
-- TODO: Check if works well when duplicated (invis joker)
SMODS.Joker {
    key = 'roulette',
    atlas = 'jokers',
    pos = { x = 3, y = 0 },
    rarity = 3,
    loc_txt = localize{ type='descriptions', set='Joker', key='j_chr_roulette' },
    loc_vars = function (self, info_queue, center)
        local number = center.ability.extra.result.number or '?'
        local penalty = center.ability.extra.globals.dollar_penalty_per_round or '?'
        local big_prize = center.ability.extra.globals.big_prize
        local color = center.ability.extra.result.color or G.C.UI.TEXT_DARK
        local odds = tostring(G.GAME and G.GAME.probabilities.normal or 1)
        return {
            vars = {
                number,
                penalty,
                odds,
                big_prize.prob or '?',
                big_prize.mult or '?',
                big_prize.dollars or '?',
                colours = { color }
            },
        }
    end,
    cost = 5,
    config = {
        extra = {
            rigged = false, -- Always 0
            result = {
                number = nil,
                color = nil
            },
            -- TODO: Optimize this, move this declaration to other file
            globals = {
                number_limits = {
                    min = 0,
                    max = 36
                },
                colors = {
                    red = HEX('EB3434'),
                    black = HEX('101010'),
                    green = G.C.GREEN
                },
                dollar_penalty_per_round = 1,
                big_prize = {
                    prob = 100,
                    mult = 100,
                    dollars = 10
                }
            },
        }
    },
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    calculate = function (self, card, context)

        -- Spin the roulette
        if context.before or (context.discard and context.other_card == context.full_hand[#context.full_hand]) and not context.blueprint then
            
            -- Seed for random generation
            local seed = G.GAME.pseudorandom.seed..self.key

            local number_limits = self.config.extra.globals.number_limits
            local colors = self.config.extra.globals.colors

            -- Decide if big prize is triggered
            if card.ability.extra.rigged or pseudorandom(seed) < G.GAME.probabilities.normal / self.config.extra.globals.big_prize.prob then
                card.ability.extra.result.number = 0
                card.ability.extra.result.color = self.config.extra.globals.colors.green
            else
                card.ability.extra.result.number = pseudorandom(seed, number_limits.min, number_limits.max)
                card.ability.extra.result.color = (pseudorandom(seed, 1, 2) == 1) and colors.red or colors.black
            end
            -- Outputs the result
            return {
                message = tostring(card.ability.extra.result.number),
                colour = card.ability.extra.result.color
            }

        end

        -- Apply the effects, blueprint compat
        if context.individual and context.cardarea == G.play then

            local is_red_card = context.other_card:is_suit('Hearts') or context.other_card:is_suit('Diamonds')
            local is_black_card = context.other_card:is_suit('Spades') or context.other_card:is_suit('Clubs')
            local colors = self.config.extra.globals.colors
            local result_color = card.ability.extra.result.color

            -- Normal scoring
            if (result_color == colors.red and is_red_card) or (result_color == colors.black and is_black_card) then
                return {
                    mult = card.ability.extra.result.number,
                    card = context.other_card
                }
            -- Big prize scoring
            elseif result_color == colors.green and card.ability.extra.result.number == 0 then
                return {
                    mult = card.ability.extra.globals.big_prize.mult,
                    dollars = card.ability.extra.globals.big_prize.dollars,
                    card = context.other_card
                }
            end

        end

        -- Dollar per hand penalty
        if context.after and not context.blueprint then
            local penalty = card.ability.extra.globals.dollar_penalty_per_round
            ease_dollars(-penalty)
            card_eval_status_text(card, 'dollars', -penalty)
        end

    end
}

-- Slot Machine
SMODS.Joker{
    key = 'slotmachine',
    atlas = 'jokers',
    pos = {x=4, y=0}, -- TODO Placeholder
    rarity = 1,
    loc_txt = localize{ type='descriptions', set='Joker', key='j_chr_slotmachine' },
    loc_vars = function (self, info_queue, center)
        return {
            vars = {
                self.config.extra.mult,
                self.config.extra.category
            }
        }
    end,
    cost = 5,
    config = {
        extra = {
            category = 7,
            mult = 7
        }
    },
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    calculate = function (self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card:get_id() == 7 then
            return {
                mult = card.ability.extra.mult,
                card = card
            }
        end
    end
}

-- SMODS.Joker{
--     key = 'pizza',
--     atlas = 'jokers',
--     pos = {x=0, y=0}, -- TODO Placeholder
--     rarity = 2,
--     loc_txt = localize{type='descriptions', set='Joker', key='j_chr_pizza'},
--     -- loc_vars = function (self, info_queue, center)
--     --     return {
--     --         vars = {
--
--     --         }
--     --     }
--     -- end,
--     cost = 8,
--     config = {
--         extra = {
--             repetitions = 1,
--             desired = {
                -- "j_egg",
                -- "j_ice_cream",
                -- "j_popcorn",
                -- "j_ramen",
                -- "j_gros_michel",
                -- "j_cavendish",
                -- "j_diet_cola",
                -- "j_turtle_bean",
                -- "j_selzer"
--             }
--         }
--     },
--     unlocked = true,
--     discovered = true,
--     blueprint_compat = true,
--     calculate = function (self, card, context)
--        
--     end
-- }

SMODS.Joker{
    key = 'doublon',
    atlas = 'jokers',
    pos = {x=0, y=1},
    rarity = 3,
    loc_txt = localize{type='descriptions', set='Joker', key='j_chr_doublon'},
    loc_vars = function (self, info_queue, center)
        return {
            vars = {
                colours = {
                    G.C.SUITS[self.config.req_card.suit]
                }
            }
        }
    end,
    cost = 7,
    config = {
        req_card = {
            id = 14, -- Ace
            suit = "Diamonds"
        },
        created_card = "c_temperance"
    },
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    calculate = function (self, card, context)
        return spanish_ace_effect(self, card, context)
    end
}

SMODS.Joker{
    key = 'club',
    atlas = 'jokers',
    pos = {x=0, y=1},
    rarity = 3,
    loc_txt = localize{type='descriptions', set='Joker', key='j_chr_club'},
    loc_vars = function (self, info_queue, center)
        return {
            vars = {
                colours = {
                    G.C.SUITS[self.config.req_card.suit]
                }
            }
        }
    end,
    cost = 7,
    config = {
        req_card = {
            id = 14, -- Ace
            suit = "Clubs"
        },
        created_card = "c_empress"
    },
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    calculate = function (self, card, context)
        return spanish_ace_effect(self, card, context)
    end
}

SMODS.Joker{
    key = 'sword',
    atlas = 'jokers',
    pos = {x=0, y=1},
    rarity = 3,
    loc_txt = localize{type='descriptions', set='Joker', key='j_chr_sword'},
    loc_vars = function (self, info_queue, center)
        return {
            vars = {
                colours = {
                    G.C.SUITS[self.config.req_card.suit]
                }
            }
        }
    end,
    cost = 7,
    config = {
        req_card = {
            id = 14, -- Ace
            suit = "Spades"
        },
        created_card = "c_heirophant"
    },
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    calculate = function (self, card, context)
        return spanish_ace_effect(self, card, context)
    end
}

SMODS.Joker{
    key = 'chalice',
    atlas = 'jokers',
    pos = {x=0, y=1},
    rarity = 3,
    loc_txt = localize{type='descriptions', set='Joker', key='j_chr_chalice'},
    loc_vars = function (self, info_queue, center)
        return {
            vars = {
                colours = {
                    G.C.SUITS[self.config.req_card.suit]
                }
            }
        }
    end,
    cost = 7,
    config = {
        req_card = {
            id = 14, -- Ace
            suit = "Hearts"
        },
        created_card = "c_chariot"
    },
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    calculate = function (self, card, context)
        return spanish_ace_effect(self, card, context)
    end
}

-- SMODS.Joker{
--     key = 'slotmachine',
--     atlas = 'jokers',
--     pos = {x=0, y=0},
--     rarity = 2,
--     loc_txt = localize{type='descriptions', set='Joker', key='j_chr_slotmachine'},
--     loc_vars = function (self, info_queue, center)
--         return {
--             vars = {
--
--             }
--         }
--     end,
--     cost = 7,
--     config = {},
--     unlocked = true,
--     discovered = true,
--     blueprint_compat = true,
--     calculate = function (self, card, context)
--
--     end
-- }