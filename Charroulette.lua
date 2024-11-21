-- ###########################################
-- ############# ATLAS (SPRITES) #############
-- Textures for the jokers
SMODS.Atlas {
    key = "jokers",
    px = 71,
    py = 95,
    path = {
        ['default'] = 'Jokers.png'
    },
    atlas_table = 'ASSET_ATLAS'
}

-- ######################################
-- ############### JOKERS ###############
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

-- Spain Ñ
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
    calculate = function (self, card, context)

        if context.cardarea == G.jokers and not context.before and not context.after and context.scoring_hand then

            -- Highly "inspired" of Flower Pot code

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
    calculate = function (self, card, context)
        -- This just applies the current xmult, check lovely.toml for the sell egg effect
        local _xmult = card.ability.x_mult
        if context.cardarea == G.jokers 
            and not context.before 
            and not context.after 
            and _xmult > 1 then
            return {
                message = localize{ type='variable', key='a_xmult', vars = {_xmult}},
                Xmult_mod = _xmult
            }
        end
    end
}

-- Roulette
SMODS.Joker {
    key = 'roulette',
    atlas = 'jokers',
    pos = { x = 3, y = 0 },
    rarity = 3,
    loc_txt = localize{ type='descriptions', set='Joker', key='j_chr_roulette' },
    loc_vars = function (self, info_queue, center)
        return {
            vars = {
                self.config.extra.result.number or '?',
                self.config.extra.dollar_penalty_per_round,
                self.config.extra.big_prize.mult,
                self.config.extra.big_prize.dollars,
                colours = {
                    self.config.extra.result.color.code
                }
            },
        }
    end,
    cost = 5,
    config = {
        extra = {
            rigged = false,
            min_result = 0,
            max_result = 36,
            result = {
                number = nil,
                color = {
                    text = nil,
                    code = G.C.UI.TEXT_DARK
                }
            },
            color_codes = {
                red = HEX('EB3434'),
                black = HEX('101010'),
                green = G.C.GREEN
            },
            color_relations = {
                red = {1, 3, 5, 7, 9, 12, 14, 16, 18, 19, 21, 23, 25, 27, 30, 32, 34, 36},
                black = {2, 4, 6, 8, 10, 11, 13, 15, 17, 20, 22, 24, 26, 28, 29, 31, 33, 35},
                green = {0}
            },
            dollar_penalty_per_round = 1,
            big_prize = {
                mult = 100,
                dollars = 10
            }
        }
    },
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    calculate = function (self, card, context)

        -- Spin the roulette
        if context.before or (context.discard and context.other_card == context.full_hand[#context.full_hand]) and not context.blueprint then
            sendDebugMessage(self.config.name, self.key)
            -- Generate the random number based on the run seed
            local _seed = G.GAME.pseudorandom.seed
            local _min, _max = self.config.extra.min_result, self.config.extra.max_result
            self.config.extra.result.number = self.config.extra.rigged and 0 or pseudorandom(_seed, _min, _max)
            -- Determine the result color
            self.config.extra.result.color.text = nil
            self.config.extra.result.color.code = G.C.UI.TEXT_DARK
            for c, t in pairs(self.config.extra.color_relations) do
                for _, v in ipairs(t) do
                    if self.config.extra.result.number == v then
                        self.config.extra.result.color.text = c
                        self.config.extra.result.color.code = self.config.extra.color_codes[c]
                        break
                    end
                end
                if self.config.extra.result.color.text then break end
            end

            sendDebugMessage("Result: " .. self.config.extra.result.number .. '(' .. self.config.extra.result.color.text .. ')', self.key)

            return {
                message = ''..self.config.extra.result.number,
                colour = self.config.extra.result.color.code
            }

        end

        -- Apply the effects
        if context.individual and context.cardarea == G.play then
            if self.config.extra.result.color.text == 'red' and (context.other_card:is_suit('Hearts') or context.other_card:is_suit('Diamonds')) 
            or self.config.extra.result.color.text == 'black' and (context.other_card:is_suit('Spades') or context.other_card:is_suit('Clubs')) then
                return {
                    mult = self.config.extra.result.number,
                    card = context.other_card
                }
            elseif self.config.extra.result.color.text == 'green' and self.config.extra.result.number == 0 then
                return {
                    mult = self.config.extra.big_prize.mult,
                    dollars = self.config.extra.big_prize.dollars,
                    card = context.other_card
                }
            end
        end

        -- End of round penalty
        if context.end_of_round and not context.individual and not context.repetition and not context.blueprint then
            sendDebugMessage("Calculating Roulette Penalty...", self.key)
            local _hands_played = G.GAME.current_round.hands_played or 0
            sendDebugMessage("Hands played: ".._hands_played, self.key)
            local _penalty = _hands_played * self.config.extra.dollar_penalty_per_round
            sendDebugMessage("Penalty: ".._penalty, self.key)
            ease_dollars(-_penalty)
            card_eval_status_text(card, 'dollars', -_penalty)
        end

    end
}

-- #################################
-- ############# MAZOS #############
-- Mazo debug
SMODS.Back {
    key = 'debug',
    loc_txt = localize{ type = 'descriptions', set='Back', key = 'b_chr_debug' },
    loc_vars = function (self)
        return { vars = { self.config.dollars } }
    end,
    unlocked = true,
    discovered = true,
    config = {
        dollars = 1000
    },
    apply = function (self)

        G.E_MANAGER:add_event(Event({
            func = function ()
                add_joker("j_chr_helloworld")
                add_joker("j_chr_roulette")
                return true
            end
        }))

    end
}