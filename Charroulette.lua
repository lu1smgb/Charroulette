-- #############################################
-- ############# UTILITY FUNCTIONS #############

---Create a Joker and add it to the Joker Space
---@param key string Key of the joker to add 
---@param editions table | nil Editions of the joker ('base', 'foil', 'holo', 'polychrome','negative')
---@param eternal boolean | nil If joker should be eterna
---@return Card | nil card The created joker
function chr_add_joker(key, editions, eternal)
    -- Create joker object
    local _joker = nil
    if not key then return _joker end
    _joker = create_card("Joker", G.jokers, nil, nil, nil, nil, key)
    -- Apply modifiers (editions, seal, upgrade)
    if editions then _joker:set_edition(editions, true, true) end
    if eternal then _joker:set_eternal(eternal) end
    -- if true then _joker:set_seal('Red', true, true) end
    -- Add to the joker space
    _joker:add_to_deck()
    G.jokers:emplace(_joker)
    return _joker
end

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
        return { vars = {self.config.extra.x_bonus} }
    end,
    cost = 6,
    config = {
        extra = {
            x_bonus = 3 -- TODO Move this variable into config.x_mult
        }
    },
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    calculate = function (self, card, context)

        if context.cardarea == G.jokers and not context.before and not context.after then

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
                    elseif context.scoring_hand[i]:is_suit('Diamonds')  or conditions["Hearts"] > 0 then 
                        conditions["Diamonds"] = conditions["Diamonds"] + 1 
                    end
                end
            end

            sendDebugMessage("H: " .. conditions['Hearts'] .. "; D: " .. conditions['Diamonds'], self.key)

            if conditions['Hearts'] > 0 and conditions['Diamonds'] > 0 then
                sendDebugMessage("Joker will trigger", self.key)
                return {
                    message = localize{ type='variable', key='a_xmult', vars={self.config.extra.x_bonus} },
                    Xmult_mod = self.config.extra.x_bonus
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

-- #################################
-- ############# MAZOS #############
-- Mazo debug
SMODS.Back {
    key = 'debug',
    loc_txt = localize{ type = 'descriptions', set='Back', key = 'b_chr_debug' },
    loc_vars = function (self)
        local millions = self.config.dollars / 1e6
        return { vars = { millions } }
    end,
    cost = 6,
    unlocked = true,
    discovered = true,
    config = {
        dollars = 1e6
    },
    apply = function (self)

        G.E_MANAGER:add_event(Event({
            func = function ()
                chr_add_joker("j_chr_helloworld", nil, nil)
                chr_add_joker("j_chr_eggsandwich", nil, nil)
                chr_add_joker("j_chr_eggsandwich", nil, nil)
                chr_add_joker("j_egg", nil, nil)
                chr_add_joker("j_egg", nil, nil)
                return true
            end
        }))

    end
}