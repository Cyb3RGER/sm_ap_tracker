-- logic helper
function can_enter_and_leave_gauntlet_qty(pbs, tanks)
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOGIC then
        print(string.format("called can_enter_and_leave_gauntlet_qty: pbs %s, tanks %s", pbs, tanks))
    end
    local value = wand({
        wor({
            can_fly(),
            speed(),
            wand({
                knows('HiJumpGauntletAccess'),
                hijump()
            }),
            knows('HiJumpLessGauntletAccess')
        }),
        wor({
            screw(),
            wor({
                wand({
                    energy_reserve_count_ok_hard_room('Gauntlet'),
                    wand({
                        can_use_power_bombs(),
                        wor({
                            item_count_ok('pb', pbs),
                            wand({
                                speed(),
                                energy_reserve_count_ok(tanks)
                            })
                        })
                    })
                }),
                wand({
                    energy_reserve_count_ok_hard_room('Gauntlet', 0.51),
                    can_use_bombs()
                })
            })
        })
    })
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOGIC then
        print(string.format("\tcan_enter_and_leave_gauntlet_qty: value: %s", value))
    end
    if value > 0 then
        return 1
    end
    return 0
end

function can_enter_and_leave_gauntlet()
    local value = wor({
        wand({
            can_short_charge(),
            can_enter_and_leave_gauntlet_qty(2, 2)
        }),
        can_enter_and_leave_gauntlet_qty(2, 3)
    })
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOGIC then
        print(string.format("called can_enter_and_leave_gauntlet: value: %s", value))
    end
    if value > 0 then
        return 1
    end
    return 0
end

function can_short_charge()
    local value = wand({ speed(), knows('ShortCharge') })
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOGIC then
        print(string.format("called can_short_charge: value: %s", value))
    end
    if value > 0 then
        return 1
    end
    return 0
end

function can_fly()
    local value = wor({ space(), can_infinite_bomb_jump() })
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOGIC then
        print(string.format("called can_fly: value: %s", value))
    end
    if value > 0 then
        return 1
    end
    return 0
end

function can_infinite_bomb_jump()
    local value = wand({ morph(), bomb(), knows('InfiniteBombJump') })
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOGIC then
        print(string.format("called can_infinite_bomb_jump: value: %s", value))
    end
    if value > 0 then
        return 1
    end
    return 0
end

function item_count_ok(code, count)
    local value = get_consumable_qty(code)
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOGIC then
        print(string.format("called item_count_ok: code: %s, count: %s, value: %s", code, count, value))
    end
    if value >= count then
        return 1
    end
    return 0
end

function get_dmg_reduction(envDmg)
    if envDmg == nil then
        envDmg = true
    end
    local ret = 1
    local items = {}
    local hasVaria = varia() > 0
    local hasGrav = gravity() > 0
    if has_patch(1000) then --no grav env protection
        if hasVaria then
            items = { 'varia' }
            if envDmg then
                ret = 4
            else
                ret = 2
            end
        end
        if hasGrav and not envDmg then
            ret = 4
            items = { 'gravity' }
        end
    elseif has_patch(1003) then --progressive suits
        if hasVaria then
            items:insert('varia')
            ret = ret * 2
        end
    else
        if hasVaria then
            ret = 2
            items = { 'varia' }
        end
        if hasGrav then
            ret = 4
            items = { 'gravity' }
        end
    end
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOGIC then
        print(string.format("called get_dmg_reduction: envDmg: %s, hasVaria: %s, hasGrav: %s, ret: %s, items: %s", envDmg,
            hasVaria, hasGrav, ret, items))
    end
    return { ret, items }
end

function energy_reserve_count_ok_hard_room(room_name, mult)
    if mult == nil then
        mult = 1
    end
    local difficulties = get_difficulties_hard_room(room_name)
    local dmgRedPair = get_dmg_reduction()
    mult = mult * dmgRedPair[1]
    local result = energy_reserve_count_ok_diff(difficulties, mult)
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOGIC then
        print(string.format(
            "called energy_reserve_count_ok_hard_room: room_name: %s, mult: %s, difficulties: %s, result: %s",
            room_name, mult, difficulties, result))
    end
    if result > 0 then
        return 1
    end
    return 0
end

function energy_reserve_count_ok_diff(difficulties, mult)
    if mult == nil then
        mult = 1
    end
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOGIC then
        print(string.format("called energy_reserve_count_ok_diff: mult: %s, diffs: %s", mult, difficulties))
    end
    if not difficulties or type(difficulties) ~= "table" then
        return 0
    end
    local value = 0
    for k, v in pairs(difficulties) do
        value = wor({ value, energy_reserve_count_ok(round(v[1] / mult), v[2]) })
    end
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOGIC then
        print(string.format("\tvalue: %s", value))
    end
    if value > 0 then
        return 1
    end
    return 0
end

function energy_reserve_count_ok(count, difficulty)
    if difficulty == nil then
        difficulty = 0
    end
    local value = (energy_reserve_count() >= count and is_below_max_difficutly(difficulty) > 0)
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOGIC then
        print(string.format(
        "called energy_reserve_count_ok: count: %s, energy_reserve_count(): %s, difficulty: %s, value: %s", count,
            energy_reserve_count(), difficulty, value))
    end
    if value then
        return 1
    end
    return 0
end

function energy_reserve_count()
    local value = get_consumable_qty('etank') + get_consumable_qty('reserve')
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOGIC then
        print(string.format("called energy_reserve_count: value: %s", value))
    end
    return value
end

function can_use_bombs()
    local value = wand({ morph(), bomb() })
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOGIC then
        print(string.format("called can_use_bombs: value: %s", value))
    end
    if value > 0 then
        return 1
    end
    return 0
end

function can_use_power_bombs()
    local value = wand({ morph(), powerbomb() })
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOGIC then
        print(string.format("called can_use_power_bombs: value: %s", value))
    end
    if value > 0 then
        return 1
    end
    return 0
end

function can_do_low_gauntlet()
    local value = wand({ can_short_charge(), can_use_power_bombs(), item_count_ok('etank', 1), knows('LowGauntlet') })
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOGIC then
        print(string.format("called can_do_low_gauntlet: value: %s", value))
    end
    if value > 0 then
        return 1
    end
    return 0
end

function can_pass_terminator_bomb_wall(fromLandingSite)
    if fromLandingSite == nil then
        fromLandingSite = 1
    end
    local value = wor({
        wand({
            speed(),
            wor({
                wnot(fromLandingSite),
                knows('SimpleShortCharge'),
                knows('ShortCharge')
            })
        }),
        can_destroy_bomb_walls()
    })
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOGIC then
        print(string.format("called can_pass_terminator_bomb_wall: value: %s", value))
    end
    if value > 0 then
        return 1
    end
    return 0
end

function can_destroy_bomb_walls()
    local value = wor({
        wand({
            morph(),
            wor({
                bomb(),
                powerbomb()
            })
        }),
        screw()
    })
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOGIC then
        print(string.format("called can_destroy_bomb_walls: value: %s", value))
    end
    if value > 0 then
        return 1
    end
    return 0
end

function can_pass_moat_reverse()
    local value = wor({
        has_patch(41),
        grapple(),
        space(),
        gravity(),
        can_pass_bomb_passages()
    })
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOGIC then
        print(string.format("called can_pass_moat_reverse: value: %s", value))
    end
    if value > 0 then
        return 1
    end
    return 0
end

function can_pass_bomb_passages()
    local value = wor({
        can_use_bombs(),
        can_use_power_bombs(),
    })
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOGIC then
        print(string.format("called can_pass_bomb_passages: value: %s", value))
    end
    if value > 0 then
        return 1
    end
    return 0
end

function can_pass_moat_from_moat()
    local value = wor({
        grapple(),
        space(),
        wand({
            knows('DiagonalBombJump'),
            can_use_bombs()
        }),
        wand({
            gravity(),
            wor({
                knows('GravityJump'),
                hijump(),
                can_infinite_bomb_jump()
            })
        })
    })
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOGIC then
        print(string.format("called can_pass_moat_from_moat: value: %s", value))
    end
    if value > 0 then
        return 1
    end
    return 0
end

function can_pass_moat()
    local value = wor({
        grapple(),
        space(),
        knows('ContinuousWallJump'),
        wand({
            knows('DiagonalBombJump'),
            can_use_bombs()
        }),
        can_simple_short_charge(),
        wand({
            gravity(),
            wor({
                knows('GravityJump'),
                hijump(),
                can_infinite_bomb_jump()
            })
        }),
        wand({
            knows('MockballWs'),
            can_use_spring_ball()
        })
    })
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOGIC then
        print(string.format("called can_pass_moat: value: %s", value))
    end
    if value > 0 then
        return 1
    end
    return 0
end

function can_use_spring_ball()
    local value = wand({
        morph(),
        spring()
    })
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOGIC then
        print(string.format("called can_use_spring_ball: value: %s", value))
    end
    if value > 0 then
        return 1
    end
    return 0
end

function can_access_etecoons()
    local value = wor({
        can_use_power_bombs(),
        wand({
            knows('Moondance'),
            can_use_bombs(),
            traverse('door_gb_tr2'),
        })
    })
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOGIC then
        print(string.format("called can_access_etecoons: value: %s", value))
    end
    if value > 0 then
        return 1
    end
    return 0
end

function can_blue_gate_glitch()
    local value = wand({
        have_missile_or_super(),
        knows('GreenGateGlitch')
    })
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOGIC then
        print(string.format("called can_blue_gate_glitch: value: %s", value))
    end
    if value > 0 then
        return 1
    end
    return 0
end

function have_missile_or_super()
    local value = wor({
        missile(),
        super()
    })
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOGIC then
        print(string.format("called have_missile_or_super: value: %s", value))
    end
    if value > 0 then
        return 1
    end
    return 0
end

function can_pass_dachora_room()
    local value = wor({
        speed(),
        can_destroy_bomb_walls()
    })
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOGIC then
        print(string.format("called can_pass_dachora_room: value: %s", value))
    end
    if value > 0 then
        return 1
    end
    return 0
end

function can_pass_crateria_green_pirates()
    local value = wor({
        can_pass_bomb_passages(),
        have_missile_or_super(),
        energy_reserve_count_ok(1),
        wor({
            charge(),
            ice(),
            wave(),
            wor({
                spazer(),
                plasma(),
                screw()
            })
        })
    })
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOGIC then
        print(string.format("called can_pass_crateria_green_pirates: value: %s", value))
    end
    if value > 0 then
        return 1
    end
    return 0
end

function can_pass_sponge_bath()
    local value = wor({
        wand({
            can_pass_bomb_passages(),
            knows('SpongeBathBombJump')
        }),
        wand({
            hijump(),
            knows('SpongeBathHiJump')
        }),
        gravity(),
        space(),
        wand({
            speed(),
            knows('SpongeBathSpeed')
        }),
        can_spring_ball_jump()
    })
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOGIC then
        print(string.format("called can_pass_sponge_bath: value: %s", value))
    end
    if value > 0 then
        return 1
    end
    return 0
end

function can_spring_ball_jump()
    local value = wand({
        can_use_spring_ball(),
        knows('SpringBallJump')
    })
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOGIC then
        print(string.format("called can_spring_ball_jump: value: %s", value))
    end
    if value > 0 then
        return 1
    end
    return 0
end

function can_pass_forgotten_highway(from_ws)
    local suitless = wand({ hijump(), knows('GravLessLevel1') })
    if from_ws > 0 and has_patch(43) == 0 then
        suitless = wand({
            suitless,
            wor({
                can_spring_ball_jump(),
                space()
            })
        })
    end
    local value = wand({
        wor({
            gravity(),
            suitless
        }),
        morph()
    })
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOGIC then
        print(string.format("called can_pass_forgotten_highway: value: %s", value))
    end
    if value > 0 then
        return 1
    end
    return 0
end

function can_pass_lava_pit()
    local tanks_for_dive = 8 / get_dmg_reduction()[1]
    if hijump() == 0 then
        tanks_for_dive = math.ceil(tanks_for_dive * 1.25)
    end
    local value = wand({
        wor({
            wand({
                gravity(),
                space()
            }),
            wand({
                knows('GravityJump'),
                gravity(),
                wor({
                    hijump(),
                    knows('LavaDive')
                })
            }),
            wand({
                wor({
                    wand({
                        knows('LavaDive'),
                        hijump()
                    }),
                    knows('LavaDiveNoHiJump')
                }),
                energy_reserve_count_ok(tanks_for_dive)
            })
        }),
        can_use_power_bombs()
    })
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOGIC then
        print(string.format("called can_pass_lava_pit: value: %s, tanks_for_dive: %s", value, tanks_for_dive))
    end
    if value > 0 then
        return 1
    end
    return 0
end

function can_pass_lava_pit_reverse()
    local tanks = 2
    if heat_proof() == 0 then
        tanks = 6
    end
    local value = energy_reserve_count_ok(tanks)
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOGIC then
        print(string.format("called can_pass_lava_pit_reverse: value: %s, tanks: %s", value, tanks))
    end
    if value > 0 then
        return 1
    end
    return 0
end

function heat_proof()
    local value = wor({
        varia(),
        wand({
            wnot(has_patch(1000)),
            wnot(has_patch(1003)),
            gravity()
        })
    })
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOGIC then
        print(string.format("called heat_proof: value: %s", value))
    end
    if value > 0 then
        return 1
    end
    return 0
end

function can_pass_lower_norfair_chozo()
    local value = wand({
        can_hell_run(HELL_RUNS_TABLE['LowerNorfair']['Main'])
    })
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOGIC then
        print(string.format("called heat_proof: value: %s", value))
    end
    if value > 0 then
        return 1
    end
    return 0
end

function can_hell_run(hell_run, mult, min_e)
    if type(hell_run) == "table" then
        mult = hell_run.mult
        min_e = hell_run.minE
        hell_run = hell_run.hellRun
    end
    if mult == nil then
        mult = 1
    end
    if min_e == nil then
        min_e = 2
    end

    local value = 0
    if heat_proof() > 0 then
        return 1
    end
    if wand({ has_patch(1003), gravity() }) > 0 then
        mult = mult * 2
        min_e = min_e / 2
    end
    if energy_reserve_count() >= min_e then
        if hell_run ~= 'LowerNorfair' then
            value = energy_reserve_count_ok_hell_run(hell_run, mult)
        else
            local tanks = energy_reserve_count()
            local multCF = mult
            if tanks >= 14 then
                multCF = multCF * 2
            end
            local nCF = math.ceil(2 / multCF)
            if gravity() > 0 then
                mult = mult * .7
            elseif screw() > 0 then
                mult = mult * .7
            end

            value = wand({
                energy_reserve_count_ok_hell_run(hell_run, mult),
                can_crystal_flash(nCF)
            })
        end
    end
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOGIC then
        print(string.format("called can_hell_run: value: %s", value))
    end
    if value > 0 then
        return 1
    end
    return 0
end

function can_crystal_flash(n)
    if n == nil then
        n = 1
    end
    local value = wand({
        can_use_power_bombs(),
        item_count_ok('missile', 2 * n),
        item_count_ok('super', 2 * n),
        item_count_ok('pb', 2 * n + 1),
    })
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOGIC then
        print(string.format("called can_crystal_flash: value: %s", value))
    end
    if value > 0 then
        return 1
    end
    return 0
end

function energy_reserve_count_ok_hell_run(hell_run_name, mult)
    if mult == nil then
        mult = 1
    end
    local difficulties = get_difficulties_hell_run(hell_run_name)
    local value = energy_reserve_count_ok_diff(difficulties, mult)
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOGIC then
        print(string.format("called energy_reserve_count_ok_hell_run: value: %s", value))
    end
    if value > 0 then
        return 1
    end
    return 0
end

function can_pass_worst_room()
    local value = wand({
        can_destroy_bomb_walls(),
        can_pass_worst_room_pirates(),
        wor({
            can_fly(),
            wand({
                knows('WorstRoomIceCharge'),
                ice(),
                can_fire_charged_shots()
            }),
            wor({
                wand({
                    knows('GetAroundWallJump'),
                    hijump()
                }),
                knows('WorstRoomWallJump')
            }),
            wand({
                knows('SpringBallJumpFromWall'),
                can_use_spring_ball()
            })
        })
    })
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOGIC then
        print(string.format("called can_pass_worst_room: value: %s", value))
    end
    if value > 0 then
        return 1
    end
    return 0
end

function can_pass_worst_room_pirates()
    local value = wor({
        screw(),
        item_count_ok('missile', 6),
        item_count_ok('super', 3),
        wand({
            can_fire_charged_shots(),
            plasma()
        }),
        wand({
            charge(),
            wor({
                spazer(),
                wave(),
                ice()
            })
        }),
        knows('DodgeLowerNorfairEnemies')
    })
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOGIC then
        print(string.format("called can_pass_worst_room_pirates: value: %s", value))
    end
    if value > 0 then
        return 1
    end
    return 0
end

function enough_stuff_gt()
    local has_beams = wand({
        charge(),
        plasma()
    })
    local ammo_margin, _ = can_inflict_enough_damages(9000, nil, nil, nil, has_beams, true, nil)
    local value = 1
    local low_stuff = knows('LowStuffGT')
    if ammo_margin == 0 then
        value = low_stuff
    else
        value = wor({
            energy_reserve_count_ok(math.ceil(8 / get_dmg_reduction(false)[1])),
            low_stuff
        })
    end
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOGIC then
        print(string.format("called can_pass_worst_room_pirates: value: %s", value))
    end
    if value > 0 then
        return 1
    end
    return 0
end

function can_inflict_enough_damages(boss_energy, double_super, _charge, power, gives_drops, ignore_missiles,
                                    ignore_supers)
    if double_super == nil then
        double_super = false
    end
    if _charge == nil then
        _charge = true
    end
    if power == nil then
        power = false
    end
    if gives_drops == nil then
        gives_drops = true
    end
    if ignore_missiles == nil then
        ignore_missiles = false
    end
    if ignore_supers == nil then
        ignore_supers = false
    end
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOGIC then
        print(string.format("called can_inflict_enough_damages: " ..
            "boss_energy: %s, double_super: %s, _charge: %s, power: %s, gives_drops: %s, ignore_missiles: %s, ignore_supers: %s ",
            boss_energy, double_super, _charge, power, gives_drops, ignore_missiles, ignore_supers
        ))
    end
    local standard_damage = 0
    if can_fire_charged_shots() > 0 and _charge then
        standard_damage = get_beam_damage()
    end
    local charge_damage = standard_damage
    if charge() > 0 then
        charge_damage = charge_damage * 3
    end
    local missiles_damage = 0
    local missiles_amount = get_consumable_qty('missile') * 5
    if not ignore_missiles then
        missiles_damage = missiles_amount * 100
    end
    local supers_damage = 0
    local supers_amount = get_consumable_qty('super') * 5
    local one_super = 300
    if ignore_supers then
        one_super = 0
    end

    if double_super then
        one_super = one_super * 2
    end
    supers_damage = supers_amount * one_super

    local power_damage = 0
    local power_amount = 0
    if power then
        power_amount = get_consumable_qty('pb') * 5
        power_damage = power_amount * 200
    end
    local can_beat_boss = charge_damage > 0 or gives_drops or (missiles_damage + supers_damage + power_damage) >=
    boss_energy
    if not can_beat_boss then
        return 0, 0
    end
    local ammo_margin = (missiles_damage + supers_damage + power_damage) / boss_energy
    if charge_damage > 0 then
        ammo_margin = ammo_margin + 2
    end

    local missiles_dps = MISSILES_PER_SEC * 100
    local supers_dps = SUPERS_PER_SEC * 300
    if double_super then
        supers_dps = supers_dps * 2
    end
    local power_dps
    if power_damage > 0 then
        power_dps = PB_PER_SEC * 200
    else
        power_dps = 0
    end
    local charge_dps = CHARGED_PER_SEC * charge_damage
    local dps_dict = {
        { missiles_dps, missiles_amount, 100 },
        { supers_dps,   supers_amount,   one_super },
        { power_dps,    power_amount,    200 },
        { charge_dps,   10000,           charge_damage }
    }
    table.sort(dps_dict, function(a, b) return a[1] > b[1] end)
    dump_table(dps_dict)
    local secs = 0
    for _, v in ipairs(dps_dict) do
        local dps = v[1]
        local amount = v[2]
        local one = v[3]
        if dps == 0 or one == 0 or amount == 0 then
            --do nothing
        else
            local fire = math.min(boss_energy / one, amount)
            secs = secs + fire * (one / dps)
            boss_energy = boss_energy - fire * one
            if boss_energy <= 0 then
                break
            end
        end
    end
    if boss_energy > 0 then
        secs = secs + boss_energy * MISSILES_DROP_PER_MIN * 100 / 60
    end
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOGIC then
        print(string.format("called can_inflict_enough_damages: ammo_margin: %s, secs: %s", ammo_margin, secs))
    end
    return ammo_margin, secs
end

function get_beam_damage()
    local standard_damage = 20
    if wand({
            ice(),
            wave(),
            plasma()
        }) > 0 then
        standard_damage = 300
    elseif wand({
            wave(),
            plasma(),
        }) > 0 then
        standard_damage = 250
    elseif wand({
            ice(),
            plasma()
        }) > 0 then
        standard_damage = 200
    elseif plasma() > 0 then
        standard_damage = 150
    elseif wand({
            ice(),
            wave(),
            spazer()
        }) > 0 then
        standard_damage = 100
    elseif wand({
            wave(),
            spazer()
        }) > 0 then
        standard_damage = 70
    elseif wand({
            ice(),
            spazer()
        }) > 0 then
        standard_damage = 60
    elseif wand({
            ice(),
            wave()
        }) > 0 then
        standard_damage = 60
    elseif wave() > 0 then
        standard_damage = 50
    elseif spazer() > 0 then
        standard_damage = 40
    elseif ice() > 0 then
        standard_damage = 30
    end
    return standard_damage
end

function can_green_gate_glitch()
    local value = wand({
        super(),
        knows('GreenGateGlitch')
    })
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOGIC then
        print(string.format("called can_green_gate_glitch: value: %s", value))
    end
    if value > 0 then
        return 1
    end
    return 0
end

function can_exit_screw_attack_area()
    local value = wand({
        can_destroy_bomb_walls(),
        wor({
            can_fly(),
            wand({
                hijump(),
                speed(),
                wor({
                    wand({
                        screw(),
                        knows('ScrewAttackExit')
                    }),
                    knows('ScrewAttackExitWithoutScrew')
                })
            }),
            wand({
                can_use_spring_ball(),
                knows('SpringBallJumpFromWall')
            }),
            wand({
                can_simple_short_charge(),
                enough_stuff_gt()
            })
        })
    })
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOGIC then
        print(string.format("called can_exit_screw_attack_area: value: %s", value))
    end
    if value > 0 then
        return 1
    end
    return 0
end

function can_simple_short_charge()
    local value = wand({
        speed(),
        wor({
            knows('SimpleShortCharge'),
            knows('ShortCharge'),
        })
    })
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOGIC then
        print(string.format("called can_simple_short_charge: value: %s", value))
    end
    if value > 0 then
        return 1
    end
    return 0
end

function can_fire_charged_shots()
    local value = wor({
        charge(),
        has_patch(1004)
    })
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOGIC then
        print(string.format("called can_fire_charged_shots: value: %s", value))
    end
    if value > 0 then
        return 1
    end
    return 0
end

function can_pass_amphitheater_reverse()
    local dmg_red = get_dmg_reduction()[1]
    local tanks_grav = 4 * 4 / dmg_red
    local tanks_no_grav = 6 * 4 / dmg_red
    local value = wor({
        wand({
            gravity(),
            energy_reserve_count_ok(tanks_grav)
        }),
        wand({
            energy_reserve_count_ok(tanks_no_grav),
            knows('LavaDive')
        })
    })
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOGIC then
        print(string.format("called can_pass_amphitheater_reverse: value: %s", value))
    end
    if value > 0 then
        return 1
    end
    return 0
end

function can_pass_red_ki_hunters()
    return can_kill_red_ki_hunters(3)
end

function can_kill_red_ki_hunters(n)
    local value = wor({
        plasma(),
        screw(),
        wand({
            heat_proof(),
            wor({
                spazer(),
                ice(),
                wand({
                    charge(),
                    wave()
                })
            })
        }),
        can_go_through_lower_norfair_enemy(1800, n, 200)
    })
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOGIC then
        print(string.format("called can_kill_red_ki_hunters: value: %s", value))
    end
    if value > 0 then
        return 1
    end
    return 0
end

function can_go_through_lower_norfair_enemy(enemy_health, enemy_num, enemy_hit_damage, super_damage)
    if super_damage == nil then
        super_damage = 300
    end
    local value
    if get_consumable_qty('super') * 5 * super_damage >= enemy_num * enemy_health then
        value = 1
    else
        local dmg_red = get_dmg_reduction()[1]
        local dmg = enemy_hit_damage / dmg_red

        if heat_proof() and (get_consumable_qty('super') * 5 * super_damage) / enemy_health + (energy_reserve_count() * 100 - 2) / dmg >= enemy_num then
            value = heat_proof()
        else
            value = knows('DodgeLowerNorfairEnemies')
        end
    end
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOGIC then
        print(string.format("called can_go_through_lower_norfair_enemy: value: %s", value))
    end
    if value > 0 then
        return 1
    end
    return 0
end

function can_get_back_from_ridley_zone()
    local value = wand({
        can_use_power_bombs(),
        wor({
            can_use_spring_ball(),
            can_use_bombs(),
            item_count_ok('pb', 2),
            screw(),
            can_short_charge(),
        }),
        wnot(hyper())
    })
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOGIC then
        print(string.format("called can_get_back_from_ridley_zone: value: %s", value))
    end
    if value > 0 then
        return 1
    end
    return 0
end

function can_pass_wasteland_dessgeegas()
    local value = wor({
        plasma(),
        screw(),
        wand({
            heat_proof(),
            wor({
                spazer(),
                wand({
                    charge(),
                    wave()
                })
            })
        }),
        item_count_ok('pb', 4),
        can_go_through_lower_norfair_enemy(800, 3, 160)
    })
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOGIC then
        print(string.format("called can_pass_wasteland_dessgeegas: value: %s", value))
    end
    if value > 0 then
        return 1
    end
    return 0
end

function can_pass_ninja_pirates()
    local value = wor({
        item_count_ok('missile', 10),
        item_count_ok('super', 2),
        plasma(),
        wor({
            spazer(),
            wand({
                charge(),
                wor({
                    wave(),
                    ice()
                })
            })
        }),
        can_short_charge()
    })
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOGIC then
        print(string.format("called can_pass_ninja_pirates: value: %s", value))
    end
    if value > 0 then
        return 1
    end
    return 0
end

function can_pass_three_muskateers()
    local value = can_kill_red_ki_hunters(6)
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOGIC then
        print(string.format("called can_pass_ninja_pirates: value: %s", value))
    end
    if value > 0 then
        return 1
    end
    return 0
end

function can_open_eye_doors()
    local value = wor({
        has_patch(200),
        have_missile_or_super()
    })
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOGIC then
        print(string.format("called can_open_eye_doors: value: %s", value))
    end
    if value > 0 then
        return 1
    end
    return 0
end

function can_access_kraids_lair()
    local value = wand({
        super(),
        wor({
            hijump(),
            can_fly(),
            knows('EarlyKraid')
        })
    })
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOGIC then
        print(string.format("called can_access_kraids_lair: value: %s", value))
    end
    if value > 0 then
        return 1
    end
    return 0
end

function can_access_cathedral_entrance_right()
    local mult = HELL_RUNS_TABLE['MainUpperNorfair']['Norfair Entrance -> Cathedral Missiles']['mult']
    if mult == nil then
        mult = 1
    end
    return wor({
        wand({
            can_hell_run('MainUpperNorfair', mult),
            wor({
                wor({
                    has_patch(31),
                    hijump(),
                    can_fly()
                }),
                wor({
                    speed(),
                    can_spring_ball_jump()
                })
            }),
        }),
        wand({
            can_hell_run('MainUpperNorfair', 0.5 * mult),
            morph(),
            knows('NovaBoost')
        })
    })
end

function can_enter_cathedral(mult)
    if mult == nil then
        mult = 1
    end
    local value = wand({
        traverse('CathedralEntranceRight'),
        wor({
            wand({
                can_hell_run('MainUpperNorfair', mult),
                wor({
                    wor({
                        has_patch(31),
                        hijump(),
                        can_fly()
                    }),
                    wor({
                        speed(),
                        can_spring_ball_jump()
                    })
                }),
            }),
            wand({
                can_hell_run('MainUpperNorfair', 0.5 * mult),
                morph(),
                knows('NovaBoost')
            })
        })
    })
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOGIC then
        print(string.format("called can_enter_cathedral: value: %s", value))
    end
    if value > 0 then
        return 1
    end
    return 0
end

function can_exit_cathedral(hell_run)
    local value = wand({
        wor({
            can_hell_run(hell_run),
            heat_proof()
        }),
        wor({
            wor({
                can_pass_bomb_passages(),
                speed()
            }),
            wor({
                space(),
                hijump(),
                knows('WallJumpCathedralExit'),
                wand({
                    knows('SpringBallJumpFromWall'),
                    can_use_spring_ball()
                })
            })
        })
    })
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOGIC then
        print(string.format("called can_exit_cathedral: value: %s", value))
    end
    if value > 0 then
        return 1
    end
    return 0
end

function can_pass_frog_speedway_right_to_left()
    local value = wor({
        speed(),
        wand({
            knows('FrogSpeedwayWithoutSpeed'),
            wave(),
            wor({
                spazer(),
                plasma()
            })
        })
    })
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOGIC then
        print(string.format("called can_pass_frog_speedway_right_to_left: value: %s", value))
    end
    if value > 0 then
        return 1
    end
    return 0
end

function can_grapple_escape()
    local value = wor({
        wor({
            space(),
            wand({
                can_infinite_bomb_jump(),
                wor({
                    heat_proof(),
                    gravity(),
                    ice()
                })
            })
        }),
        grapple(),
        wand({
            speed(),
            wor({
                hijump(),
                knows('ShortCharge')
            })
        }),
        wand({
            hijump(),
            can_spring_ball_jump()
        })
    })
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOGIC then
        print(string.format("called can_grapple_escape: value: %s", value))
    end
    if value > 0 then
        return 1
    end
    return 0
end

function can_climb_bubble_mountain()
    local value = wor({
        hijump(),
        can_fly(),
        ice(),
        knows('BubbleMountainWallJump')
    })
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOGIC then
        print(string.format("called can_grapple_escape: value: %s", value))
    end
    if value > 0 then
        return 1
    end
    return 0
end

function enough_stuff_croc()
    local ammo_margin = can_inflict_enough_damages(5000, nil, nil, nil, false, nil, nil)[1]
    local value
    if ammo_margin == 0 then
        value = wand({
            knows('LowAmmoCroc'),
            wor({
                item_count_ok('missile', 2),
                wand({
                    missile(),
                    super()
                })
            })
        })
    else
        value = 1
    end
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOGIC then
        print(string.format("called enough_stuff_croc: value: %s", value))
    end
    if value > 0 then
        return 1
    end
    return 0
end

function can_go_up_mt_everest()
    local value = wor({
        wand({
            gravity(),
            wor({
                grapple(),
                speed(),
                can_fly(),
                wand({
                    knows('GravityJump'),
                    wor({
                        hijump(),
                        knows('MtEverestGravJump')
                    })
                })
            })
        }),
        wand({
            can_do_suitless_outer_maridia(),
            grapple()
        })
    })
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOGIC then
        print(string.format("called can_go_up_mt_everest: value: %s", value))
    end
    if value > 0 then
        return 1
    end
    return 0
end

function can_do_suitless_outer_maridia()
    local value = wand({
        knows('GravLessLevel1'),
        hijump(),
        wor({
            ice(),
            can_spring_ball_jump()
        })
    })
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOGIC then
        print(string.format("called can_do_suitless_outer_maridia: value: %s", value))
    end
    if value > 0 then
        return 1
    end
    return 0
end

function can_traverse_crab_tunnel_left_to_right()
    local value = wand({
        traverse('MainStreetBottomRight'),
        wor({
            super(),
            has_patch(103)
        })
    })
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOGIC then
        print(string.format("called can_traverse_crab_tunnel_left_to_right: value: %s", value))
    end
    if value > 0 then
        return 1
    end
    return 0
end

function can_traverse_west_sand_hall_left_to_right()
    local value = gravity()
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOGIC then
        print(string.format("called can_traverse_west_sand_hall_left_to_right: value: %s", value))
    end
    if value > 0 then
        return 1
    end
    return 0
end

function can_pass_mt_everest()
    local value = wor({
        wand({
            gravity(),
            wor({
                grapple(),
                speed(),
                can_fly(),
                knows('GravityJump')
            })
        }),
        wand({
            can_do_suitless_outer_maridia(),
            wor({
                grapple(),
                wand({
                    ice(),
                    knows('TediousMountEverest'),
                    super()
                }),
                can_double_spring_ball_jump()
            })
        })
    })
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOGIC then
        print(string.format("called can_pass_mt_everest: value: %s", value))
    end
    if value > 0 then
        return 1
    end
    return 0
end

function can_double_spring_ball_jump()
    local value = wand({
        can_use_spring_ball(),
        hijump(),
        knows('DoubleSpringBallJump')
    })
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOGIC then
        print(string.format("called can_double_spring_ball_jump: value: %s", value))
    end
    if value > 0 then
        return 1
    end
    return 0
end

function can_jump_underwater()
    local value = wor({
        gravity(),
        wand({
            knows('GravLessLevel1'),
            hijump()
        })
    })
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOGIC then
        print(string.format("called can_jump_underwater: value: %s", value))
    end
    if value > 0 then
        return 1
    end
    return 0
end

function can_exit_crab_hole()
    local value = wand({
        morph(),
        wor({
            wand({
                gravity(),
                wor({
                    ice(),
                    wand({
                        hijump(),
                        knows('MaridiaWallJumps')
                    }),
                    knows('GravityJump'),
                    can_fly()
                })
            }),
            wand({
                ice(),
                can_do_suitless_outer_maridia()
            }),
            can_double_spring_ball_jump()
        }),
    })
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOGIC then
        print(string.format("called can_exit_crab_hole: value: %s", value))
    end
    if value > 0 then
        return 1
    end
    return 0
end

function can_do_outer_maridia()
    local value = wor({
        gravity(),
        can_do_suitless_outer_maridia()
    })
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOGIC then
        print(string.format("called can_do_outer_maridia: value: %s", value))
    end
    if value > 0 then
        return 1
    end
    return 0
end

function can_destroy_bomb_walls_underwater()
    local value = wor({
        wand({
            gravity(),
            can_destroy_bomb_walls()
        }),
        wand({
            morph(),
            wor({
                bomb(),
                powerbomb()
            })
        })
    })
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOGIC then
        print(string.format("called can_destroy_bomb_walls_underwater: value: %s", value))
    end
    if value > 0 then
        return 1
    end
    return 0
end

function can_defeat_botwoon()
    local value = wand({
        enough_stuff_botwoon(),
        can_pass_botwoon_hallway()
    })
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOGIC then
        print(string.format("called can_defeat_botwoon: value: %s", value))
    end
    if value > 0 then
        return 1
    end
    return 0
end

function enough_stuff_botwoon()
    local ammo_margin = can_inflict_enough_damages(6000, nil, nil, nil, false, nil, nil)
    local low_stuff = knows('LowStuffBotwoon')
    local value
    if ammo_margin == 0 then
        value = low_stuff
    else
        value = wor({
            energy_reserve_count_ok(math.ceil(8 / get_dmg_reduction(false)[1])),
            low_stuff
        })
    end
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOGIC then
        print(string.format("called enough_stuff_botwoon: value: %s", value))
    end
    if value > 0 then
        return 1
    end
    return 0
end

function can_pass_botwoon_hallway()
    local value = wor({
        wand({
            speed(),
            gravity()
        }),
        wand({
            knows('MochtroidClip'),
            ice()
        }),
        can_crystal_flash_clip()
    })
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOGIC then
        print(string.format("called can_pass_botwoon_hallway: value: %s", value))
    end
    if value > 0 then
        return 1
    end
    return 0
end

function can_crystal_flash_clip()
    local value = wand({
        can_crystal_flash(),
        wor({
            wand({
                gravity(),
                can_use_bombs(),
                knows('CrystalFlashClip')
            }),
            wand({
                knows('SuitlessCrystalFlashClip'),
                item_count_ok('pb', 4)
            })
        })
    })
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOGIC then
        print(string.format("called can_crystal_flash_clip: value: %s", value))
    end
    if value > 0 then
        return 1
    end
    return 0
end

function can_access_sand_pits()
    local value = wor({
        gravity(),
        wand({
            hijump(),
            knows('GravLessLevel3')
        })
    })
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOGIC then
        print(string.format("called can_access_sand_pits: value: %s", value))
    end
    if value > 0 then
        return 1
    end
    return 0
end

function can_botwoon_exit_to_colosseum()
    local value = wand({
        wor({
            wand({
                gravity(),
                speed()
            }),
            wand({
                morph(),
                can_jump_underwater()
            })
        }),
        wor({
            gravity(),
            wand({
                knows('GravLessLevel2'),
                hijump(),
                wor({
                    grapple(),
                    ice(),
                    wand({
                        can_double_spring_ball_jump(),
                        space()
                    })
                }),
                can_go_through_colosseum_suitless()
            })
        })
    })
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOGIC then
        print(string.format("called can_botwoon_exit_to_colosseum: value: %s", value))
    end
    if value > 0 then
        return 1
    end
    return 0
end

function can_go_through_colosseum_suitless()
    local value = wor({
        grapple(),
        space(),
        wand({
            ice(),
            energy_reserve_count_ok(7 / get_dmg_reduction(false)[1]),
            knows('BotwoonToDraygonWithIce')
        })
    })
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOGIC then
        print(string.format("called can_go_through_colosseum_suitless: value: %s", value))
    end
    if value > 0 then
        return 1
    end
    return 0
end

function can_reach_cacatac_alley_from_botowoon()
    local value = wor({
        gravity(),
        wand({
            knows('GravLessLevel2'),
            hijump(),
            wor({
                grapple(),
                ice(),
                can_double_spring_ball_jump()
            })
        })
    })
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOGIC then
        print(string.format("called can_reach_cacatac_alley_from_botowoon: value: %s", value))
    end
    if value > 0 then
        return 1
    end
    return 0
end

function can_pass_cacatac_alley()
    local value = wand({
        draygon(),
        morph(),
        wor({
            gravity(),
            wand({
                knows('GravLessLevel2'),
                hijump(),
                space()
            })
        })
    })
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOGIC then
        print(string.format("called can_pass_cacatac_alley: value: %s", value))
    end
    if value > 0 then
        return 1
    end
    return 0
end

function can_colosseum_to_botwoon_exit()
    local value = wor({
        gravity(),
        wand({
            knows('GravLessLevel2'),
            hijump(),
            can_go_through_colosseum_suitless()
        })
    })
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOGIC then
        print(string.format("called can_colosseum_to_botwoon_exit: value: %s", value))
    end
    if value > 0 then
        return 1
    end
    return 0
end

function can_climb_colosseum()
    local value = wor({
        gravity(),
        wand({
            knows('GravLessLevel2'),
            hijump(),
            wor({
                grapple(),
                ice(),
                knows('PreciousRoomGravJumpExit')
            })
        })
    })
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOGIC then
        print(string.format("called can_climb_colosseum: value: %s", value))
    end
    if value > 0 then
        return 1
    end
    return 0
end

function can_exit_precious_room()
    local vanilla = is_vanilla_draygon()
    local value
    if vanilla > 1 then
        value = can_exit_precious_room_vanilla()
    else
        value = can_exit_precious_room_randomized()
    end
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOGIC then
        print(string.format("called can_exit_precious_room: value: %s", value))
    end
    if value > 0 then
        return 1
    end
    return 0
end

function can_exit_precious_room_vanilla()
    return 1
end

function can_exit_precious_room_randomized()
    local suitless_room_exit = can_spring_ball_jump()
    if suitless_room_exit == 0 then
        if get_connection('DraygonRoomOut') == 'KraidRoomIn' then
            suitless_room_exit = can_short_charge()
        elseif get_connection('DraygonRoomOut') == 'RidleyRoomIn' then
            suitless_room_exit = wand({
                xray(),
                knows('PreciousRoomXRayExit')
            })
        end
    end
    local value = wor({
        wand({
            gravity(),
            wor({
                can_fly(),
                knows('GravityJump'),
                hijump()
            })
        }),
        suitless_room_exit
    })
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOGIC then
        print(string.format("called can_exit_precious_room_randomized: value: %s", value))
    end
    if value > 0 then
        return 1
    end
    return 0
end

function can_fight_draygon()
    local value = wor({
        gravity(),
        wand({
            hijump(),
            wor({
                knows('GravLessLevel2'),
                knows('GravLessLevel3')
            })
        })
    })
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOGIC then
        print(string.format("called can_fight_draygon: value: %s", value))
    end
    if value > 0 then
        return 1
    end
    return 0
end

function enough_stuff_draygon()
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOGIC then
        print(string.format("called enough_stuff_draygon"))
    end
    if morph() == 0 and gravity() == 0 then
        return 0
    end
    if have_missile_or_super() == 0 then
        return 0
    end
    local ammo_margin, secs = can_inflict_enough_damages(6000)
    local fight
    if ammo_margin > 0 then
        local diff, energy_ok = compute_boss_difficulty(ammo_margin, secs, get_boss_difficulty('Draygon'))

        if diff < 0 then
            fight = 0
        else
            if gravity() == 0 then
                diff = diff * DRAYGON_NO_GRAV_MALUS
            end
            if morph() == 0 then
                diff = diff * DRAYGON_NO_MORPH_MALUS
            end
            if gravity() > 0 and screw() > 0 then
                diff = diff / DRAYGON_SCREW_BONUS
            end
            diff = adjust_health_drop_diff(diff)
            if only_boss_left() > 0 then
                diff = 1
            end
            fight = wand({ energy_ok, is_below_max_difficutly(diff) })
        end
    else
        fight = 0
    end
    local tanks_grapple = (240 / get_dmg_reduction(true)[1] + 2 * 160 / get_dmg_reduction(false)[1]) / 100
    local value = wor({
        fight,
        wand({
            knows('DraygonGrappleKill'),
            grapple(),
            energy_reserve_count_ok(tanks_grapple)
        }),
        wand({
            knows('MicrowaveDraygon'),
            plasma(),
            can_fire_charged_shots(),
            xray()
        }),
        wand({
            gravity(),
            energy_reserve_count_ok(3),
            knows('DraygonSparkKill'),
            speed()
        })
    })
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOGIC then
        print(string.format("called enough_stuff_draygon: value: %s", value))
    end
    if value > 0 then
        return 1
    end
    return 0
end

function only_boss_left()
    -- ToDo: test
    -- in post_fill: if all other items can be collected but bosses could not be reached this will force thier difficulty to 1 (easy)
    --local value = 1
    --for k,_ in pairs(LOCATIONS) do
    --    if k ~= "Kraid" or k ~= "Ridley" or k ~= "Phantoon" or k ~= "Draygon" or k ~= "Mother Brain" then
    --        local obj = Tracker:FindObjectForCode("@"..k.."/")
    --        if obj then
    --            value = value and (obj.item_count == 0)
    --        end
    --    end
    --end
    --if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOGIC then
    --    print(string.format("called only_boss_left: value: %s", value))
    --end
    --return value
    return 0
end

function all_bosses_dead()
    local value = kraid() + phantoon() + draygon() + ridley()
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOGIC then
        print(string.format("called all_bosses_dead: value: %s", value))
    end
    if value > 3 then
        return 1
    end
    return 0
end

function can_mockball()
    local value = wand({
        morph(),
        knows('Mockball')
    })
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOGIC then
        print(string.format("called can_climb_red_tower: value: %s", value))
    end
    if value > 0 then
        return 1
    end
    return 0
end

function can_kill_beetoms()
    local value = wor({
        have_missile_or_super(),
        can_use_power_bombs(),
        screw()
    })
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOGIC then
        print(string.format("called can_kill_beetoms: value: %s", value))
    end
    if value > 0 then
        return 1
    end
    return 0
end

function can_climb_red_tower()
    local value = wor({
        knows('RedTowerClimb'),
        ice(),
        space()
    })
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOGIC then
        print(string.format("called can_climb_red_tower: value: %s", value))
    end
    if value > 0 then
        return 1
    end
    return 0
end

function can_climb_bottom_red_tower()
    local value = wor({
        has_patch(21),
        hijump(),
        ice(),
        can_fly(),
        can_short_charge()
    })
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOGIC then
        print(string.format("called can_climb_bottom_red_tower: value: %s", value))
    end
    if value > 0 then
        return 1
    end
    return 0
end

function can_pass_red_tower_to_maridia_node()
    local value = wand({
        morph(),
        has_patch(102)
    })
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOGIC then
        print(string.format("called can_climb_red_tower: value: %s", value))
    end
    if value > 0 then
        return 1
    end
    return 0
end

function can_exit_draygon()
    local value
    if is_vanilla_draygon() then
        value = can_exit_draygon_vanilla()
    else
        value = can_exit_draygon_randomized()
    end
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOGIC then
        print(string.format("called can_exit_draygon: value: %s", value))
    end
    if value > 0 then
        return 1
    end
    return 0
end

function can_exit_draygon_vanilla()
    local value = wor({
        can_exit_draygon_room_with_gravity(),
        wand({
            can_draygon_crystal_flash_suit(),
            wor({
                can_grapple_exit_draygon(),
                wand({
                    xray(),
                    knows('PreciousRoomXRayExit')
                }),
                can_spring_ball_jump()
            })
        }),
        wand({
            can_grapple_exit_draygon(),
            wor({
                wand({
                    xray(),
                    knows('PreciousRoomXRayExit')
                })
            })
        }),
        can_double_spring_ball_jump()
    })
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOGIC then
        print(string.format("called can_exit_draygon_vanilla: value: %s", value))
    end
    if value > 0 then
        return 1
    end
    return 0
end

function can_exit_draygon_randomized()
    local value = wor({
        can_exit_draygon_room_with_gravity(),
        can_draygon_crystal_flash_suit(),
        can_grapple_exit_draygon(),
        can_double_spring_ball_jump()
    })
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOGIC then
        print(string.format("called can_exit_draygon_randomized: value: %s", value))
    end
    if value > 0 then
        return 1
    end
    return 0
end

function can_exit_draygon_room_with_gravity()
    local value = wand({
        gravity(),
        wor({
            can_fly(),
            knows('GravityJump'),
            wand({
                hijump(),
                speed()
            })
        })
    })
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOGIC then
        print(string.format("called can_exit_draygon_room_with_gravity: value: %s", value))
    end
    if value > 0 then
        return 1
    end
    return 0
end

function can_draygon_crystal_flash_suit()
    local value = wand({
        can_crystal_flash(),
        knows('DraygonRoomCrystalFlash'),
        item_count_ok('pb', 4)
    })
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOGIC then
        print(string.format("called can_draygon_crystal_flash_suit: value: %s", value))
    end
    if value > 0 then
        return 1
    end
    return 0
end

function can_grapple_exit_draygon()
    local value = wand({
        grapple(),
        knows('DraygonRoomGrappleExit')
    })
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOGIC then
        print(string.format("called can_grapple_exit_draygon: value: %s", value))
    end
    if value > 0 then
        return 1
    end
    return 0
end

function enough_stuff_kraid()
    local value
    local ammo_margin, secs = can_inflict_enough_damages(1000)

    if ammo_margin == 0 then
        value = 0
    else
        local diff = compute_boss_difficulty(ammo_margin, secs, get_boss_difficulty('Kraid'))
        if only_boss_left() then
            diff = 1
        end
        if diff < 0 then
            value = 0
        else
            value = is_below_max_difficutly(diff)
        end
    end
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOGIC then
        print(string.format("called enough_stuff_kraid: value: %s", value))
    end
    if value > 0 then
        return 1
    end
    return 0
end

function enough_stuff_croc()
    local value
    local ammo_margin, secs = can_inflict_enough_damages(5000, nil, nil, nil, false, nil, nil)
    if ammo_margin == 0 then
        value = wand({
            knows('LowAmmoCroc'),
            wor({
                item_count_ok('missile', 2),
                wand({
                    missile(),
                    super()
                })
            })
        })
    else
        value = 1
    end
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOGIC then
        print(string.format("called enough_stuff_croc: value: %s", value))
    end
    if value > 0 then
        return 1
    end
    return 0
end

function can_enter_norfair_reserve_area_from_bubble_mountain()
    local value = wand({
        traverse('BubbleMountainTopLeft'),
        wor({
            can_fly(),
            ice(),
            wand({
                hijump(),
                knows('GetAroundWallJump')
            }),
            wand({
                can_use_spring_ball(),
                knows('SpringBallJumpFromWall')
            })
        })
    })
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOGIC then
        print(string.format("called can_enter_norfair_reserve_area_from_bubble_mountain: value: %s", value))
    end
    if value > 0 then
        return 1
    end
    return 0
end

function can_enter_norfair_reserve_area_from_bubble_mountain_top()
    local value = wand({
        traverse('BubbleMountainTopLeft'),
        wor({
            grapple(),
            space(),
            knows('NorfairReserveDBoost')
        })
    })
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOGIC then
        print(string.format("called can_enter_norfair_reserve_area_from_bubble_mountain_top: value: %s", value))
    end
    if value > 0 then
        return 1
    end
    return 0
end

function can_hell_run_to_speed_booster()
    local value
    if speed() > 0 then
        value = can_hell_run(HELL_RUNS_TABLE['MainUpperNorfair']['Bubble -> Speed Booster w/Speed'])
    else
        value = can_hell_run(HELL_RUNS_TABLE['MainUpperNorfair']['Bubble -> Speed Booster'])
    end
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOGIC then
        print(string.format("called can_hell_run_to_speed_booster: value: %s", value))
    end
    if value > 0 then
        return 1
    end
    return 0
end

function can_access_double_chamber_items()
    local hell_run = HELL_RUNS_TABLE['MainUpperNorfair']['Bubble -> Wave']
    local value = wor({
        wand({
            traverse('SingleChamberRight'),
            can_hell_run(hell_run)
        }),
        wand({
            wor({
                hijump(),
                can_simple_short_charge(),
                can_fly(),
                knows('DoubleChamberWallJump')
            }),
            can_hell_run(hell_run['hellRun'], hell_run['mult'] * 0.8, hell_run['minE'])
        })
    })

    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOGIC then
        print(string.format("called can_hell_run_to_speed_booster: value: %s", value))
    end
    if value > 0 then
        return 1
    end
    return 0
end

function enough_stuff_ridley()
    local value
    if morph() == 0 and screw() == 0 then
        value = 0
    else
        local ammo_margin, secs = can_inflict_enough_damages(18000, true, nil, true, false, nil, nil)
        if ammo_margin == 0 then
            value = 0
        else
            local diff = compute_boss_difficulty(ammo_margin, secs, get_boss_difficulty('Ridley'))
            if only_boss_left() > 0 then
                diff = 1
            end
            if diff < 0 then
                value = 0
            else
                value = is_below_max_difficutly(diff)
            end
        end
    end
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOGIC then
        print(string.format("called enough_stuff_ridley: value: %s", value))
    end
    if value > 0 then
        return 1
    end
    return 0
end

function enough_stuff_phantoon()
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOGIC then
        print(string.format("called enough_stuff_phantoon"))
    end
    local value
    local ammo_margin, secs = can_inflict_enough_damages(2500, true, nil, nil, nil, nil, nil)
    if ammo_margin == 0 then
        value = 0
    else
        local diff = compute_boss_difficulty(ammo_margin, secs, get_boss_difficulty('Phantoon'))
        if diff < 0 then
            value = 0
        else
            local has_charge = can_fire_charged_shots()
            local has_screw = screw()
            if has_screw > 0 then
                diff = diff / PHANTOON_FLAMES_AVOID_BONUS_SCREW
            elseif has_charge > 0 then
                diff = diff / PHANTOON_FLAMES_AVOID_BONUS_CHARGE
            elseif has_charge == 0 and get_consumable_qty('missile') <= 2 then
                diff = diff * PHANTOON_LOW_MISSILE_MALUS
            end
            diff = adjust_health_drop_diff(diff)
            if only_boss_left() > 0 then
                diff = 1
            end
            local fight = is_below_max_difficutly(diff)
            value = wor({
                fight,
                wand({
                    knows('MicrowavePhantoon'),
                    plasma(),
                    can_fire_charged_shots(),
                    xray()
                })
            })
        end
    end
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOGIC then
        print(string.format("called enough_stuff_phantoon: value: %s", value))
    end
    if value > 0 then
        return 1
    end
    return 0
end

function can_pass_bowling()
    local temp = 0
    if get_dmg_reduction()[1] >= 2 then
        temp = 1
    end
    local value = wand({
        phantoon(),
        wor({
            temp,
            energy_reserve_count_ok(1),
            space(),
            grapple()
        })
    })
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOGIC then
        print(string.format("called can_pass_bowling: value: %s", value))
    end
    if value > 0 then
        return 1
    end
    return 0
end

function get_pirates_pseudo_screw_coeff()
    local value = 1
    if has_patch(1004) > 0 then
        value = 4
    end
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOGIC then
        print(string.format("called get_pirates_pseudo_screw_coeff: value: %s", value))
    end
    if value > 0 then
        return 1
    end
    return 0
end

function can_climb_west_sand_hole()
    local value = wor({
        gravity(),
        wand({
            hijump(),
            knows('GravLessLevel3'),
            wor({
                space(),
                can_spring_ball_jump(),
                knows('WestSandHoleSuitlessWallJumps')
            })
        })
    })
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOGIC then
        print(string.format("called can_climb_west_sand_hole: value: %s", value))
    end
    if value > 0 then
        return 1
    end
    return 0
end

function can_access_items_in_west_sand_hole()
    local value = wor({
        wand({
            hijump(),
            can_use_spring_ball()
        }),
        wand({
            space(),
            wor({
                can_use_spring_ball(),
                can_use_bombs()
            })
        }),
        wand({
            can_pass_bomb_passages(),
            knows('MaridiaWallJumps')
        })
    })
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOGIC then
        print(string.format("called can_access_items_in_west_sand_hole: value: %s", value))
    end
    if value > 0 then
        return 1
    end
    return 0
end

function can_traverse_sand_pits()
    local value = wor({
        gravity(),
        wand({
            knows('GravLessLevel3'),
            hijump(),
            ice()
        })
    })
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOGIC then
        print(string.format("called can_traverse_sand_pits: value: %s", value))
    end
    if value > 0 then
        return 1
    end
    return 0
end

function enough_stuff_tourian()
    local value = wand({
        wor({
            has_patch(201),
            wand({
                can_pass_metroids(),
                can_pass_zebetites()
            })
        }),
        can_open_red_doors(),
        enough_stuff_motherbrain(),
        wor({
            has_patch(202),
            morph()
        })
    })
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOGIC then
        print(string.format("called enough_stuff_tourian: value: %s", value))
    end
    if value > 0 then
        return 1
    end
    return 0
end

function can_pass_zebetites()
    local ammo_margin, _ = can_inflict_enough_damages(1100, nil, false, nil, false, nil, true)
    local temp = 0
    if ammo_margin >= 1 then
        temp = 1
    end
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOGIC then
        print(string.format("called can_pass_zebetites: temp: %s", temp))
    end
    local value = wor({
        wand({
            ice(),
            knows('IceZebSkip')
        }),
        wand({
            speed(),
            knows('SpeedZebSkip')
        }),
        temp
    })
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOGIC then
        print(string.format("called can_pass_zebetites: value: %s", value))
    end
    if value > 0 then
        return 1
    end
    return 0
end

function can_pass_metroids()
    local value = wor({
        wand({
            ice(),
            have_missile_or_super()
        }),
        item_count_ok('pb', 3)
    })
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOGIC then
        print(string.format("called can_pass_metroids: value: %s", value))
    end
    if value > 0 then
        return 1
    end
    return 0
end

function enough_stuff_motherbrain()
    local value
    local ammo_margin, secs = can_inflict_enough_damages(3000, nil, false, nil, false, nil, nil)
    if ammo_margin == 0 then
        value = 0
    else
        if get_consumable_qty('missile') <= 1 or get_consumable_qty('super') <= 1 then
            value = 0
        else
            ammo_margin, secs = can_inflict_enough_damages(18000 + 3000, nil, nil, nil, false, nil, nil)
            if ammo_margin == 0 then
                value = 0
            else
                local possible, energy_diff = mb_etank_check()
                if possible == 0 then
                    value = 0
                else
                    local diff = compute_boss_difficulty(ammo_margin, secs, get_boss_difficulty('MotherBrain'),
                        energy_diff)
                    if only_boss_left() > 0 then
                        diff = 1
                    end
                    if diff < 0 then
                        value = 0
                    else
                        value = is_below_max_difficutly(diff)
                    end
                end
            end
        end
    end
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOGIC then
        print(string.format("called enough_stuff_motherbrain: value: %s", value))
    end
    if value > 0 then
        return 1
    end
    return 0
end

function enough_stuff_spore_spawn()
    local value = wor({
        missile(),
        super(),
        charge()
    })
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOGIC then
        print(string.format("called enough_stuff_spore_spawn: value: %s", value))
    end
    if value > 0 then
        return 1
    end
    return 0
end

function can_open_green_doors()
    return super()
end

function can_open_red_doors()
    return wor({
        wand({
            wnot(has_patch(1006)),
            have_missile_or_super()
        }),
        missile()
    })
end

function can_access_billy_mays()
    local value = wand({
        wor({
            has_patch(10),
            traverse('ConstructionZoneRight')
        }),
        can_use_power_bombs(),
        wor({
            knows('BillyMays'),
            gravity(),
            space()
        })
    })
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOGIC then
        print(string.format("called can_access_billy_mays: value: %s", value))
    end
    if value > 0 then
        return 1
    end
    return 0
end

function can_use_croc_room_to_charge_speed()
    local croc_room = REGIONS['Crocomire Room Top']
    local speedway = REGIONS['Crocomire Speedway Bottom']
    local is_connected = (croc_room.exits['Crocomire Speedway Bottom'] ~= nil and type(croc_room.exits['Crocomire Speedway Bottom']) == "function")
    local temp = 0
    if is_connected then
        temp = 1
    end
    local value = wand({
        temp,
        croc_room.traverse(),
        speedway.traverse()
    })
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOGIC then
        print(string.format("called can_use_croc_room_to_charge_speed: value: %s", value))
    end
    if value > 0 then
        return 1
    end
    return 0
end

function mb_etank_check()
    local energy_diff
    local value
    local temp = wor({
        has_patch(1005),
        has_patch(201)
    })
    if temp > 0 then
        energy_diff = 2.6
        if varia() > 0 then
            energy_diff = 2.8
        end
        value = 1
    else
        local tanks = energy_reserve_count()
        energy_diff = 0
        if varia() == 0 then
            if tanks < 6 then
                value = 0
            else
                energy_diff = -3
                value = 1
            end
        else
            if tanks < 3 then
                value = 0
            else
                value = 1
            end
        end
    end
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOGIC then
        print(string.format("called mb_etank_check: value: %s, energy_diff: %s", value, energy_diff))
    end
    return value, energy_diff
end

function adjust_health_drop_diff(diff)
    local dmg_red = get_dmg_reduction(false)[1]
    if dmg_red < 2 then
        diff = diff * DMG_REDUCTION_DIFFICULTY_FACTOR
    elseif dmg_red > 2 then
        diff = diff / DMG_REDUCTION_DIFFICULTY_FACTOR
    end
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOGIC then
        print(string.format("called adjust_health_drop_diff: diff: %s", diff))
    end
    return diff
end

function compute_boss_difficulty(ammo_margin, secs, diff_tbl, energy_diff)
    if diff_tbl == nil then
        return 0
    end
    if energy_diff == nil then
        energy_diff = 0
    end
    local rate = nil
    local duration
    if diff_tbl['Rate'] then
        rate = diff_tbl['Rate']
    end
    if not rate then
        duration = 120
    else
        duration = secs / rate
    end
    local suitCoeff = get_dmg_reduction()[1]
    suitCoeff = suitCoeff / 2
    local energy_count = energy_reserve_count()
    local energy = suitCoeff * (1 + energy_count + energy_diff)
    local energy_ok = energy_reserve_count_ok(energy_count)
    local energy_dict = nil
    if diff_tbl['Energy'] then
        energy_dict = diff_tbl['Energy']
    end
    local diff = DIFFICULTY.medium
    if energy_dict then
        --table.sort(energy_dict)
        local keys = {}
        for k, _ in pairs(energy_dict) do
            table.insert(keys, tonumber(k))
        end
        table.sort(keys)
        if #keys > 0 then
            local current = keys[1]
            if energy < current then
                return -1, {}
            end
            local sup = nil
            diff = energy_dict[tostring(current)]
            for _, k in ipairs(keys) do
                if k > energy then
                    sup = k
                    break
                end
                current = k
                diff = energy_dict[tostring(current)]
            end
            if energy > current and sup then
                diff = diff + ((energy_dict[tostring(sup)] - diff) / (sup - current) * (energy - current))
            end
        end
    end
    diff = diff * (duration / 120)
    local diff_adjust = (1 - (ammo_margin - AMMO_MARGIN_IF_NO_CHARGE))
    if diff_adjust > 1 then
        diff = diff * diff_adjust
    end
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOGIC then
        print(string.format("called compute_boss_difficulty: diff: %s, energy_ok: %s", diff, energy_ok))
    end
    return round(diff, 2), energy_ok
end

function knows(name)
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOGIC then
        print(string.format("called knows: name: %s", name))
    end
    if not SLOT_DATA or not SLOT_DATA['Preset'] or not SLOT_DATA['Preset']['Knows'] then
        return 0
    end
    local entry = SLOT_DATA['Preset']['Knows'][name]
    if not entry then
        if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOGIC then
            print(string.format("\tknows: %s, unknown name", name))
        end
        return 0
    end
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOGIC then
        print(string.format("\tvalue: %s, difficulty: %s", entry[1], entry[2]))
    end
    if entry[1] and is_below_max_difficutly(entry[2]) > 0 then
        return 1
    else
        return 0
    end
end

function is_below_max_difficutly(value)
    if value == nil or get_max_difficulty() == nil then
        return 0
    end
    local result = (value <= get_max_difficulty())
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOGIC then
        print(string.format("called is_below_max_difficutly: value: %s, get_max_difficulty(): %s, result: %s", value,
            get_max_difficulty(), result))
    end
    if result then
        return 1
    end
    return 0
end

--slot data
function get_max_difficulty()
    if not SLOT_DATA or not SLOT_DATA['max_difficulty'] or not DIFFICULTY_MAPPING[SLOT_DATA['max_difficulty']] then
        return nil
    end
    return DIFFICULTY_MAPPING[SLOT_DATA['max_difficulty']]
end

function get_setting(name)
    if not SLOT_DATA or not SLOT_DATA['Preset'] or not SLOT_DATA['Preset']['Settings'] or not SLOT_DATA['Preset']['Settings'][name] then
        return nil
    end
    return SLOT_DATA['Preset']['Settings'][name]
end

function get_boss_difficulty(boss_name)
    local setting_boss = get_setting('bossesDifficulty')
    if not setting_boss then
        return nil
    end
    return setting_boss[boss_name]
end

function get_difficulties_hard_room(room_name)
    local hard_rooms = get_setting('hardRooms')
    if not hard_rooms then
        return nil
    end
    return hard_rooms[room_name]
end

function get_difficulties_hell_run(hell_run_name)
    local hell_runs = get_setting('hellRuns')
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOGIC then
        print(string.format("called get_difficulties_hell_run: hell_runs: %s", dump_table(hell_runs)))
    end
    if not hell_runs then
        return nil
    end
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOGIC then
        print(string.format("called get_difficulties_hell_run: hell_run_name: %s, result: %s", hell_run_name,
            dump_table(hell_runs[hell_run_name])))
    end
    return hell_runs[hell_run_name]
end

-- for patch numbers check: https://github.com/ArchipelagoMW/Archipelago/blob/main/worlds/sm/variaRandomizer/rom/rom_patches.py
function has_patch(patch_num)
    if not SLOT_DATA then
        return 0
    end
    local patches = SLOT_DATA['RomPatches']
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOGIC then
        print(string.format("called has_patch: patch_num: %s, patches: %s", patch_num, patches))
    end
    for i = 1, #patches do
        if patches[i] == patch_num then
            return 1
        end
    end
    return 0
end

function is_area_rando()
    if not SLOT_DATA or not SLOT_DATA['area_randomization'] then
        return 0
    end
    if SLOT_DATA['area_randomization'] > 0 then
        return 1
    end
    return 0
end

function is_boss_rando()
    if not SLOT_DATA or not SLOT_DATA['boss_randomization'] then
        return 0
    end
    if SLOT_DATA['boss_randomization'] ~= 0 and SLOT_DATA['boss_randomization'] ~= false then
        return 1
    end
    return 0
end

function is_door_rando()
    if not SLOT_DATA or not SLOT_DATA['doors_colors_rando'] then
        return 0
    end
    if SLOT_DATA['doors_colors_rando'] ~= 0 and SLOT_DATA['doors_colors_rando'] ~= false then
        return 1
    end
    return 0
end

function can_get_through_xray()
    return wor({
        grapple(),
        space(),
        wand({
            energy_reserve_count_ok_hard_room('X-Ray'),
            wor({
                knows('XrayDboost'),
                wand({
                    ice(),
                    wor({
                        hijump(),
                        knows('XrayIce')
                    })
                }),
                can_infinite_bomb_jump(),
                wand({
                    hijump(),
                    wor({
                        speed(),
                        can_spring_ball_jump()
                    })
                })
            })
        })
    })
end

function can_access_croc_pb_door()
    return wand({
        enough_stuff_croc(),
        wor({
            wor({
                can_fly(),
                grapple(),
                wand({
                    speed(),
                    wor({
                        heat_proof(),
                        energy_reserve_count_ok(1)
                    })
                })
            }),
            wor({
                hijump(),
                wand({
                    ice(),
                    knows('CrocPBsIce')
                }),
                knows('CrocPBsDBoost')
            })
        })
    })
end

--mapping
DIFFICULTY = {
    ['easy'] = 1,
    ['medium'] = 5,
    ['hard'] = 10,
    ['harder'] = 25,
    ['hardcore'] = 50,
    ['mania'] = 100,
    ['god'] = 200,
    ['samus'] = 400,
    ['impossibru'] = 800,
    ['infinity'] = 99999,
}
DIFFICULTY_MAPPING = {
    [0] = DIFFICULTY.easy,
    [1] = DIFFICULTY.medium,
    [2] = DIFFICULTY.hard,
    [3] = DIFFICULTY.harder,
    [4] = DIFFICULTY.hardcore,
    [5] = DIFFICULTY.mania,
    [6] = DIFFICULTY.infinity
}


HARD_ROOM_PERSETS = {
    ['X-Ray'] = {
        ['Aarghh'] = { { 10, DIFFICULTY['hard'] }, { 14, DIFFICULTY['medium'] } },
        ["I don't like spikes"] = { { 8, DIFFICULTY['hard'] }, { 10, DIFFICULTY['medium'] }, { 14, DIFFICULTY['easy'] } },
        ['Default'] = { { 6, DIFFICULTY['hard'] }, { 8, DIFFICULTY['medium'] }, { 10, DIFFICULTY['easy'] } },
        ["I don't mind spikes"] = { { 4, DIFFICULTY['hard'] }, { 6, DIFFICULTY['medium'] }, { 8, DIFFICULTY['easy'] } },
        ['D-Boost master'] = { { 1, DIFFICULTY['hardcore'] }, { 2, DIFFICULTY['harder'] }, { 3, DIFFICULTY['hard'] }, { 4, DIFFICULTY['medium'] }, { 6, DIFFICULTY['easy'] } },
        ['Solution'] = { { 1, DIFFICULTY['samus'] }, { 4, DIFFICULTY['mania'] }, { 6, DIFFICULTY['hard'] }, { 8, DIFFICULTY['medium'] }, { 10, DIFFICULTY['easy'] } },
    },
    ['Gauntlet'] = {
        ['Aarghh'] = { { 5, DIFFICULTY['hard'] }, { 10, DIFFICULTY['medium'] } },
        ["I don't like acid"] = { { 1, DIFFICULTY['harder'] }, { 2, DIFFICULTY['hard'] }, { 5, DIFFICULTY['medium'] }, { 10, DIFFICULTY['easy'] } },
        ['Default'] = { { 0, DIFFICULTY['harder'] }, { 1, DIFFICULTY['hard'] }, { 3, DIFFICULTY['medium'] }, { 6, DIFFICULTY['easy'] } }
    }
}

HELL_RUN_PRESETS = {
    ['Ice'] = {
        ['No thanks'] = {},
        ['Gimme energy'] = { { 4, DIFFICULTY.hardcore }, { 5, DIFFICULTY.harder }, { 6, DIFFICULTY.hard }, { 10, DIFFICULTY.medium } },
        ['Default'] = { { 3, DIFFICULTY.harder }, { 4, DIFFICULTY.hard }, { 5, DIFFICULTY.medium } },
        ['Bring the heat'] = { { 2, DIFFICULTY.harder }, { 3, DIFFICULTY.hard }, { 4, DIFFICULTY.medium } },
        ['I run RBO'] = { { 2, DIFFICULTY.medium }, { 3, DIFFICULTY.easy } },
        ['Solution'] = { { 2, DIFFICULTY.hardcore }, { 3, DIFFICULTY.harder }, { 4, DIFFICULTY.hard }, { 5, DIFFICULTY.medium } },
    },
    ['MainUpperNorfair'] = {
        ['No thanks'] = {},
        ['Gimme energy'] = { { 5, DIFFICULTY.mania }, { 6, DIFFICULTY.hardcore }, { 8, DIFFICULTY.harder }, { 10, DIFFICULTY.hard }, { 14, DIFFICULTY.medium } },
        ['Default'] = { { 4, DIFFICULTY.mania }, { 5, DIFFICULTY.hardcore }, { 6, DIFFICULTY.hard }, { 9, DIFFICULTY.medium } },
        ['Bring the heat'] = { { 3, DIFFICULTY.mania }, { 4, DIFFICULTY.harder }, { 5, DIFFICULTY.hard }, { 7, DIFFICULTY.medium } },
        ['I run RBO'] = { { 3, DIFFICULTY.harder }, { 4, DIFFICULTY.hard }, { 5, DIFFICULTY.medium }, { 6, DIFFICULTY.easy } },
        ['Solution'] = { { 3, DIFFICULTY.samus }, { 4, DIFFICULTY.mania }, { 5, DIFFICULTY.hardcore }, { 6, DIFFICULTY.hard }, { 9, DIFFICULTY.medium } }
    },
    ['LowerNorfair'] = {
        ['Default'] = {},
        ['Bring the heat'] = { { 10, DIFFICULTY.mania }, { 13, DIFFICULTY.hardcore }, { 18, DIFFICULTY.harder } },
        ['I run RBO'] = { { 8, DIFFICULTY.mania }, { 9, DIFFICULTY.hardcore }, { 11, DIFFICULTY.harder }, { 14, DIFFICULTY.hard }, { 18, DIFFICULTY.medium } },
        ['Solution'] = { { 8, DIFFICULTY.impossibru }, { 18, DIFFICULTY.mania } }
    }
}

HELL_RUNS_TABLE = {
    ['Ice'] = {
        ['Norfair Entrance -> Ice Beam'] = { mult = 1.0, minE = 2, hellRun = 'Ice' },
        ['Norfair Entrance -> Croc via Ice'] = { mult = 1.5, minE = 2, hellRun = 'Ice' },
        ['Croc -> Norfair Entrance'] = { mult = 2.0, minE = 1, hellRun = 'Ice' },
        ['Croc -> Bubble Mountain'] = { mult = 2.0, minE = 1, hellRun = 'Ice' }
    },
    ['MainUpperNorfair'] = {
        ['Norfair Entrance -> Bubble'] = { mult = 1.0, minE = 2, hellRun = 'MainUpperNorfair' },
        ['Bubble -> Norfair Entrance'] = { mult = 0.75, minE = 2, hellRun = 'MainUpperNorfair' },
        ['Norfair Entrance -> Cathedral Missiles'] = { mult = 0.66, minE = 2, hellRun = 'MainUpperNorfair' },
        ['Bubble -> Cathedral Missiles'] = { mult = 0.66, minE = 2, hellRun = 'MainUpperNorfair' },
        ['Norfair Entrance -> Croc via Frog'] = { mult = 2.0, minE = 1, hellRun = 'MainUpperNorfair' },
        ['Norfair Entrance -> Croc via Frog w/Wave'] = { mult = 4.0, minE = 1, hellRun = 'MainUpperNorfair' },
        ['Bubble -> Norfair Reserve Missiles'] = { mult = 3.0, minE = 1, hellRun = 'MainUpperNorfair' },
        ['Bubble -> Norfair Reserve'] = { mult = 1.0, minE = 2, hellRun = 'MainUpperNorfair' },
        ['Bubble -> Speed Booster'] = { mult = 1.0, minE = 3, hellRun = 'MainUpperNorfair' },
        ['Bubble -> Speed Booster w/Speed'] = { mult = 2.0, minE = 2, hellRun = 'MainUpperNorfair' },
        ['Bubble -> Wave'] = { mult = 0.75, minE = 2, hellRun = 'MainUpperNorfair' },
        ['Bubble -> Kronic Boost Room'] = { mult = 1.25, minE = 2, hellRun = 'MainUpperNorfair' },
        ['Bubble -> Kronic Boost Room wo/Bomb'] = { mult = 0.5, minE = 2, hellRun = 'MainUpperNorfair' },
        ['Bubble -> Croc'] = { mult = 2.0, minE = 2, hellRun = 'MainUpperNorfair' },
        ['Bubble Top <-> Bubble Bottom'] = { mult = 0.357, minE = 2, hellRun = 'MainUpperNorfair' },
        ['Croc -> Grapple Escape Missiles'] = { mult = 1.0, minE = 2, hellRun = 'MainUpperNorfair' },
        ['Croc -> Ice Missiles'] = { mult = 1.0, minE = 2, hellRun = 'MainUpperNorfair' },
        ['Single Chamber <-> Bubble Mountain'] = { mult = 1.25, minE = 2, hellRun = 'MainUpperNorfair' },
        ['Kronic Boost Room -> Bubble Mountain Top'] = { mult = 0.5, minE = 2, hellRun = 'MainUpperNorfair' },
        ['Kronic Boost Room <-> Croc'] = { mult = 1.0, minE = 2, hellRun = 'MainUpperNorfair' },
        ['Croc -> Norfair Entrance'] = { mult = 1.25, minE = 2, hellRun = 'MainUpperNorfair' }
    },
    ['LowerNorfair'] = {
        ['Main'] = { mult = 1.0, minE = 8, hellRun = 'LowerNorfair' },
        ['Entrance -> GT via Chozo'] = { mult = 0.8, minE = 8, hellRun = 'LowerNorfair' }
    }
}

BOSSES_PRESET_TABLE = {
    ['Kraid'] = {
        ["He's annoying"] = {
            ['Rate'] = 0.0075,
            ['Energy'] = {
                [0.5] = DIFFICULTY.hard,
                [1] = DIFFICULTY.medium,
                [2] = DIFFICULTY.easy
            }
        },
        ['Default'] = {
            ['Rate'] = 0.015,
            ['Energy'] = {
                [0.5] = DIFFICULTY.hard,
                [1.5] = DIFFICULTY.medium,
                [2.5] = DIFFICULTY.easy
            }
        },
        ['Quick Kill'] = {
            ['Rate'] = 1,
            ['Energy'] = {
                [0.5] = DIFFICULTY.easy
            }
        }
    },
    ['Phantoon'] = {
        ['A lot of trouble'] = {
            ['Rate'] = 0.01,
            ['Energy'] = {
                [1.5] = DIFFICULTY.mania,
                [3] = DIFFICULTY.hardcore,
                [4] = DIFFICULTY.harder,
                [5] = DIFFICULTY.hard,
                [7] = DIFFICULTY.medium,
                [10] = DIFFICULTY.easy
            }
        },
        ['Default'] = {
            ['Rate'] = 0.015,
            ['Energy'] = {
                [0.5] = DIFFICULTY.samus,
                [1] = DIFFICULTY.mania,
                [2] = DIFFICULTY.hardcore,
                [4] = DIFFICULTY.harder,
                [5] = DIFFICULTY.hard,
                [6] = DIFFICULTY.medium,
                [10] = DIFFICULTY.easy
            }
        },
        ['Used to it'] = {
            ['Rate'] = 0.02,
            ['Energy'] = {
                [0.5] = 150,
                [1] = (DIFFICULTY.mania + DIFFICULTY.hardcore) / 2,
                [2] = DIFFICULTY.harder,
                [2.5] = DIFFICULTY.hard,
                [4] = DIFFICULTY.medium,
                [6] = DIFFICULTY.easy
            }
        },
        ['No problemo'] = {
            ['Rate'] = 0.02,
            ['Energy'] = {
                [0.5] = DIFFICULTY.harder,
                [1] = DIFFICULTY.hard,
                [2] = DIFFICULTY.medium,
                [3] = DIFFICULTY.easy
            }
        }
    },
    ['Draygon'] = {
        ['A lot of trouble'] = {
            ['Rate'] = 0.025,
            ['Energy'] = {
                [1] = DIFFICULTY.mania,
                [6] = DIFFICULTY.hardcore,
                [8] = DIFFICULTY.harder,
                [11] = DIFFICULTY.hard,
                [14] = DIFFICULTY.medium,
                [20] = DIFFICULTY.easy
            },
        },
        ['Default'] = {
            ['Rate'] = 0.05,
            ['Energy'] = {
                [0.5] = DIFFICULTY.samus,
                [1] = DIFFICULTY.mania,
                [6] = DIFFICULTY.hardcore,
                [8] = DIFFICULTY.harder,
                [11] = DIFFICULTY.hard,
                [14] = DIFFICULTY.medium,
                [20] = DIFFICULTY.easy
            },
        },
        ['Used to it'] = {
            ['Rate'] = 0.06,
            ['Energy'] = {
                [1] = DIFFICULTY.mania,
                [4] = DIFFICULTY.hardcore,
                [6] = DIFFICULTY.harder,
                [8] = DIFFICULTY.hard,
                [11] = DIFFICULTY.medium,
                [14] = DIFFICULTY.easy
            },
        },
        ['No problemo'] = {
            ['Rate'] = 0.08,
            ['Energy'] = {
                [1] = DIFFICULTY.mania,
                [4] = DIFFICULTY.hardcore,
                [5] = DIFFICULTY.harder,
                [6] = DIFFICULTY.hard,
                [8] = DIFFICULTY.medium,
                [12] = DIFFICULTY.easy
            },
        }
    },
    ['Ridley'] = {
        ["I'm scared!"] = {
            ['Rate'] = 0.047,
            ['Energy'] = {
                [1] = DIFFICULTY.mania,
                [7] = DIFFICULTY.hardcore,
                [11] = DIFFICULTY.harder,
                [14] = DIFFICULTY.hard,
                [20] = DIFFICULTY.medium
            },
        },
        ['Default'] = {
            ['Rate'] = 0.12,
            ['Energy'] = {
                [0.5] = DIFFICULTY.samus,
                [1] = DIFFICULTY.mania,
                [6] = DIFFICULTY.hardcore,
                [8] = DIFFICULTY.harder,
                [12] = DIFFICULTY.hard,
                [20] = DIFFICULTY.medium,
                [36] = DIFFICULTY.easy
            },
        },
        ['Used to it'] = {
            ['Rate'] = 0.16,
            ['Energy'] = {
                [1] = DIFFICULTY.mania,
                [6] = DIFFICULTY.hardcore,
                [8] = DIFFICULTY.harder,
                [10] = DIFFICULTY.hard,
                [14] = DIFFICULTY.medium,
                [20] = DIFFICULTY.easy
            },
        },
        ['Piece of cake'] = {
            ['Rate'] = 0.3,
            ['Energy'] = {
                [1] = DIFFICULTY.mania,
                [3] = DIFFICULTY.hardcore,
                [4] = DIFFICULTY.harder,
                [6] = DIFFICULTY.hard,
                [8] = DIFFICULTY.medium,
                [10] = DIFFICULTY.easy
            }
        }
    },
    ['MotherBrain'] = {
        ["It can get ugly"] = {
            ['Rate'] = 0.18,
            ['Energy'] = {
                [2] = DIFFICULTY.impossibru,
                [4] = DIFFICULTY.mania,
                [8] = DIFFICULTY.hardcore,
                [12] = DIFFICULTY.harder,
                [16] = DIFFICULTY.hard,
                [24] = DIFFICULTY.medium,
                [32] = DIFFICULTY.easy
            }
        },
        ['Default'] = {
            ['Rate'] = 0.25,
            ['Energy'] = {
                [2] = DIFFICULTY.impossibru,
                [4] = DIFFICULTY.mania,
                [8] = DIFFICULTY.hardcore,
                [12] = DIFFICULTY.harder,
                [16] = DIFFICULTY.hard,
                [20] = DIFFICULTY.medium,
                [24] = DIFFICULTY.easy
            }
        },
        ['Is this really the last boss?'] = {
            ['Rate'] = 0.5,
            ['Energy'] = {
                [2] = DIFFICULTY.impossibru,
                [4] = DIFFICULTY.mania,
                [6] = DIFFICULTY.hardcore,
                [8] = DIFFICULTY.harder,
                [12] = DIFFICULTY.hard,
                [14] = DIFFICULTY.medium,
                [20] = DIFFICULTY.easy
            }
        },
        ['Nice cutscene bro'] = {
            ['Rate'] = 0.6,
            ['Energy'] = {
                [2] = DIFFICULTY.mania,
                [4] = DIFFICULTY.hard,
                [8] = DIFFICULTY.medium,
                [12] = DIFFICULTY.easy
            }
        }
    }
}

MISSILES_PER_SEC = 3
SUPERS_PER_SEC = 1.85
PB_PER_SEC = 0.33
CHARGED_PER_SEC = 0.75
MISSILES_DROP_PER_MIN = 12
AMMO_MARGIN_IF_NO_CHARGE = 1.5
PHANTOON_FLAMES_AVOID_BONUS_CHARGE = 1.2
PHANTOON_FLAMES_AVOID_BONUS_SCREW = 1.5
PHANTOON_LOW_MISSILE_MALUS = 1.2
DRAYGON_NO_GRAV_MALUS = 2
DRAYGON_NO_MORPH_MALUS = 2
DRAYGON_SCREW_BONUS = 2
DMG_REDUCTION_DIFFICULTY_FACTOR = 1.5
