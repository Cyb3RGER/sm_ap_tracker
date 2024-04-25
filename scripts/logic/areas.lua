CLEAN_REGIONS = {
    -- Ceres
    ['Ceres'] = {
        exits = {
            ['Landing Site'] = function()
                return 1
            end
        },
        traverse = function()
            return 1
        end
    },
    -- Crateria and Blue Brinstar
    ['Landing Site'] = {
        exits = {
            ['Lower Mushrooms Left'] = function()
                return wand({ can_pass_terminator_bomb_wall(), can_pass_crateria_green_pirates() })
            end,
            ['Keyhunter Room Bottom'] = function()
                return traverse('door_cr_ls_br')
            end,
            ['Blue Brinstar Elevator Bottom'] = function()
                return 1
            end
        },
        traverse = function()
            return 1
        end
    },
    ['Blue Brinstar Elevator Bottom'] = {
        exits = {
            ['Morph Ball Room Left'] = function()
                return can_use_power_bombs()
            end,
            ['Landing Site'] = function()
                return 1
            end
        },
        traverse = function()
            return 1
        end
    },
    ['Gauntlet Top'] = {
        exits = {
            ['Green Pirates Shaft Bottom Right'] = function()
                return wand({ morph(), can_pass_crateria_green_pirates() })
            end
        },
        traverse = function()
            return 1
        end
    },
    ['Lower Mushrooms Left'] = {
        exits = {
            ['Landing Site'] = function()
                return wand({ can_pass_terminator_bomb_wall(0), can_pass_crateria_green_pirates() })
            end,
            ['Green Pirates Shaft Bottom Right'] = function()
                return 1
            end
        },
        traverse = function()
            return 1
        end
    },
    ['Green Pirates Shaft Bottom Right'] = {
        exits = {
            ['Lower Mushrooms Left'] = function()
                return 1
            end
        },
        traverse = function()
            return wor({
                has_patch(105),
                traverse('door_cr_tourian')
            })
        end
    },
    ['Moat Right'] = {
        exits = {
            ['Moat Left'] = function()
                return can_pass_moat_reverse()
            end
        },
        traverse = function()
            return 1
        end
    },
    ['Moat Left'] = {
        exits = {
            ['Keyhunter Room Bottom'] = function()
                return 1
            end,
            ['Moat Right'] = function()
                return can_pass_moat_from_moat()
            end
        },
        traverse = function()
            return 1
        end
    },
    ['Keyhunter Room Bottom'] = {
        exits = {
            ['Moat Left'] = function()
                return traverse('door_cr_moat')
            end,
            ['Moat Right'] = function()
                return wand({ traverse('door_cr_moat'), can_pass_moat() })
            end,
            ['Landing Site'] = function()
                return 1
            end
        },
        traverse = function()
            return wor({
                has_patch(105),
                traverse('door_cr_rb')
            })
        end
    },
    ['Morph Ball Room Left'] = {
        exits = {
            ['Blue Brinstar Elevator Bottom'] = function()
                return can_use_power_bombs()
            end
        },
        traverse = function()
            return 1
        end
    },
    ['Climb Bottom Left'] = {
        exits = {
            ['Landing Site'] = function()
                return 1
            end
        },
        traverse = function()
            return 1
        end
    },
    ['Flyway Right'] = {
        exits = {},
        traverse = function()
            return 1
        end
    },
    ['Bomb Torizo Room Left'] = {
        exits = {},
        traverse = function()
            return 1
        end
    },
    -- Green and Pink Brinstar
    ['Green Brinstar Elevator'] = {
        exits = {
            ['Big Pink'] = function()
                return wand({
                    can_pass_dachora_room(),
                    traverse('door_gb_br')
                })
            end,
            ['Etecoons Bottom'] = function()
                return can_access_etecoons()
            end
        },
        traverse = function()
            return 1
        end
    },
    ['Big Pink'] = {
        exits = {
            ['Green Hill Zone Top Right'] = function()
                return wand({
                    morph(),
                    traverse('door_pb_br')
                })
            end,
            ['Green Brinstar Elevator'] = function()
                return can_pass_dachora_room()
            end
        },
        traverse = function()
            return wor({
                has_patch(104),
                traverse('door_gb_bb')
            })
        end
    },
    ['Green Hill Zone Top Right'] = {
        exits = {
            ['Noob Bridge Right'] = function()
                return 1
            end,
            ['Big Pink'] = function()
                return morph()
            end
        },
        traverse = function()
            return wor({
                has_patch(104),
                traverse('door_gb_rb')
            })
        end
    },
    ['Noob Bridge Right'] = {
        exits = {
            ['Green Hill Zone Top Right'] = function()
                return wor({
                    wave(),
                    wor({
                        can_blue_gate_glitch(),
                        has_patch(103)
                    })
                })
            end
        },
        traverse = function()
            return wor({
                has_patch(104),
                traverse('NoobBridgeRight')
            })
        end
    },
    ['Green Brinstar Main Shaft Top Left'] = {
        exits = {
            ['Green Brinstar Elevator'] = function()
                return 1
            end
        },
        traverse = function()
            return 1
        end
    },
    ['Brinstar Pre-Map Room Right'] = {
        exits = {},
        traverse = function()
            return 1
        end
    },
    ['Etecoons Supers'] = {
        exits = {
            ['Etecoons Bottom'] = function()
                return 1
            end
        },
        traverse = function()
            return 1
        end
    },
    ['Etecoons Bottom'] = {
        exits = {
            ['Etecoons Supers'] = function()
                return wor({
                    has_patch(26),
                    traverse('door_gb_b')
                })
            end,
            ['Green Brinstar Elevator'] = function()
                return can_use_power_bombs()
            end
        },
        traverse = function()
            return 1
        end
    },
    -- Wrecked Ship
    ['West Ocean Left'] = {
        exits = {
            ['Wrecked Ship Main'] = function()
                return traverse('door_ws_l')
            end
        },
        traverse = function()
            return 1
        end
    },
    ['Wrecked Ship Main'] = {
        exits = {
            ['West Ocean Left'] = function()
                return 1
            end,
            ['Wrecked Ship Back'] = function()
                return wor({
                    wand({
                        phantoon(),
                        can_pass_sponge_bath()
                    }),
                    wand({
                        wnot(phantoon()),
                        has_patch(42)
                    })
                })
            end,
            ['PhantoonRoomOut'] = function()
                return wand({
                    traverse('door_ws_b'),
                    can_pass_bomb_passages()
                })
            end
        },
        traverse = function()
            return 1
        end
    },
    ['Wrecked Ship Back'] = {
        exits = {
            ['Wrecked Ship Main'] = function()
                return 1
            end,
            ['Crab Maze Left'] = function()
                return can_pass_forgotten_highway(1)
            end
        },
        traverse = function()
            return wor({
                has_patch(104),
                traverse('LeCoudeBottom')
            })
        end
    },
    ['Crab Maze Left'] = {
        exits = {
            ['Wrecked Ship Back'] = function()
                return can_pass_forgotten_highway(0)
            end
        },
        traverse = function()
            return wor({
                has_patch(104),
                traverse('door_em_t')
            })
        end
    },
    ['PhantoonRoomOut'] = {
        exits = {
            ['Wrecked Ship Main'] = function()
                return can_pass_bomb_passages()
            end
        },
        traverse = function()
            return can_open_eye_doors()
        end
    },
    ['PhantoonRoomIn'] = {
        exits = {},
        traverse = function()
            return 1
        end
    },
    ['Basement Left'] = {
        exits = {
            ['Wrecked Ship Main'] = function()
                return 1
            end
        },
        traverse = function()
            return 1
        end
    },
    ['Wrecked Ship Map Room'] = {
        exits = {},
        traverse = function()
            return 1
        end
    },
    -- Lower Norfair
    ['Lava Dive Right'] = {
        exits = {
            ['LN Entrance'] = function()
                return can_pass_lava_pit()
            end
        },
        traverse = function()
            return 1
        end
    },
    ['LN Entrance'] = {
        exits = {
            ['Lava Dive Right'] = function()
                return can_pass_lava_pit_reverse()
            end,
            ['LN Above GT'] = function()
                return can_pass_lower_norfair_chozo()
            end,
            ['Screw Attack Bottom'] = function()
                return wand({
                    can_hell_run(HELL_RUNS_TABLE['LowerNorfair']['Main']),
                    can_green_gate_glitch(),
                    can_destroy_bomb_walls()
                })
            end,
            ['Firefleas'] = function()
                return wand({
                    can_hell_run(HELL_RUNS_TABLE['LowerNorfair']['Main']),
                    can_pass_worst_room(),
                    can_use_power_bombs()
                })
            end
        },
        traverse = function()
            return 1
        end
    },
    ['LN Above GT'] = {
        exits = {
            ['Screw Attack Bottom'] = function()
                return wand({
                    can_hell_run(HELL_RUNS_TABLE['LowerNorfair']['Main']),
                    enough_stuff_gt()
                })
            end
        },
        traverse = function()
            return 1
        end
    },
    ['Screw Attack Bottom'] = {
        exits = {
            ['LN Entrance'] = function()
                return wand({
                    can_hell_run(HELL_RUNS_TABLE['LowerNorfair']['Main']),
                    can_exit_screw_attack_area(),
                    super(),
                    can_use_power_bombs(),
                })
            end
        },
        traverse = function()
            return 1
        end
    },
    ['Firefleas'] = {
        exits = {
            ['LN Entrance'] = function()
                return wand({
                    can_hell_run(HELL_RUNS_TABLE['LowerNorfair']['Main']),
                    can_pass_amphitheater_reverse(),
                    can_pass_worst_room_pirates(),
                    can_use_power_bombs()
                })
            end,
            ['Three Muskateers Room Left'] = function()
                return wand({
                    can_hell_run(HELL_RUNS_TABLE['LowerNorfair']['Main']),
                    morph(),
                    can_pass_red_ki_hunters()
                })
            end,
            ['Ridley Zone'] = function()
                return wand({
                    can_hell_run(HELL_RUNS_TABLE['LowerNorfair']['Main']),
                    traverse('WastelandLeft'),
                    traverse('RedKihunterShaftBottom'),
                    can_get_back_from_ridley_zone(),
                    can_pass_red_ki_hunters(),
                    can_pass_wasteland_dessgeegas(),
                    can_pass_ninja_pirates()
                })
            end,
            ['Screw Attack Bottom'] = function()
                return wand({
                    can_hell_run(HELL_RUNS_TABLE['LowerNorfair']['Main']),
                    can_pass_amphitheater_reverse(),
                    can_destroy_bomb_walls(),
                    can_green_gate_glitch()
                })
            end,
            ['Firefleas Top'] = function()
                return wand({
                    can_pass_bomb_passages(),
                    can_hell_run(HELL_RUNS_TABLE['LowerNorfair']['Main']),
                })
            end
        },
        traverse = function()
            return 1
        end
    },
    ['Firefleas Top'] = {
        exits = {
            ['Firefleas'] = function()
                return wor({
                    wnot(has_patch(34)),
                    heat_proof()
                })
            end
        },
        traverse = function()
            return 1
        end
    },
    ['Ridley Zone'] = {
        exits = {
            ['Firefleas'] = function()
                return wand({
                    can_hell_run(HELL_RUNS_TABLE['LowerNorfair']['Main']),
                    can_get_back_from_ridley_zone(),
                    can_pass_wasteland_dessgeegas(),
                    can_pass_red_ki_hunters()
                })
            end,
            ['RidleyRoomOut'] = function()
                return can_hell_run(HELL_RUNS_TABLE['LowerNorfair']['Main'])
            end,
            ['Wasteland'] = function()
                return wand({
                    can_hell_run(HELL_RUNS_TABLE['LowerNorfair']['Main']),
                    can_get_back_from_ridley_zone(),
                    can_pass_wasteland_dessgeegas()
                })
            end
        },
        traverse = function()
            return 1
        end
    },
    ['Wasteland'] = {
        exits = {
            ['Ridley Zone'] = function()
                return wand({
                    can_hell_run(HELL_RUNS_TABLE['LowerNorfair']['Main']),
                    traverse('WastelandLeft'),
                    can_get_back_from_ridley_zone(),
                    can_pass_wasteland_dessgeegas(),
                    can_pass_ninja_pirates()
                })
            end
        },
        traverse = function()
            return 1
        end
    },
    ['Three Muskateers Room Left'] = {
        exits = {
            ['Firefleas'] = function()
                return wand({
                    can_hell_run(HELL_RUNS_TABLE['LowerNorfair']['Main']),
                    morph(),
                    can_pass_three_muskateers()
                })
            end
        },
        traverse = function()
            return 1
        end
    },
    ['RidleyRoomOut'] = {
        exits = {
            ['Ridley Zone'] = function()
                return can_hell_run(HELL_RUNS_TABLE['LowerNorfair']['Main'])
            end
        },
        traverse = function()
            return wand({
                can_hell_run(HELL_RUNS_TABLE['LowerNorfair']['Main']),
                can_open_eye_doors()
            })
        end
    },
    ['RidleyRoomIn'] = {
        exits = {},
        traverse = function()
            return 1
        end
    },
    -- Kraid
    ['Warehouse Zeela Room Left'] = {
        exits = {
            ['KraidRoomOut'] = function()
                return can_pass_bomb_passages()
            end
        },
        traverse = function()
            return 1
        end
    },
    ['KraidRoomOut'] = {
        exits = {
            ['Warehouse Zeela Room Left'] = function()
                return can_pass_bomb_passages()
            end
        },
        traverse = function()
            return can_open_eye_doors()
        end
    },
    ['KraidRoomIn'] = {
        exits = {},
        traverse = function()
            return 1
        end
    },
    -- Upper Norfair
    ['Warehouse Entrance Left'] = {
        exits = {
            ['Warehouse Entrance Right'] = function()
                return can_access_kraids_lair()
            end,
            ['Business Center'] = function()
                return 1
            end
        },
        traverse = function()
            return 1
        end
    },
    ['Warehouse Entrance Right'] = {
        exits = {
            ['Warehouse Entrance Left'] = function()
                return super()
            end
        },
        traverse = function()
            return 1
        end
    },
    ['Business Center'] = {
        exits = {
            ['Cathedral'] = function()
                return can_enter_cathedral(HELL_RUNS_TABLE['MainUpperNorfair']['Norfair Entrance -> Cathedral Missiles']
                ['mult'])
            end,
            ['Bubble Mountain'] = function()
                return wand({
                    traverse('CathedralRight'),
                    can_enter_cathedral(HELL_RUNS_TABLE['MainUpperNorfair']['Norfair Entrance -> Bubble']['mult'])
                })
            end,
            ['Bubble Mountain Bottom'] = function()
                return speed()
            end,
            ['Crocomire Speedway Bottom'] = function()
                return wor({
                    wand({
                        speed(),
                        wor({
                            wand({
                                wave(),
                                can_hell_run(HELL_RUNS_TABLE['MainUpperNorfair']
                                ['Norfair Entrance -> Croc via Frog w/Wave'])
                            }),
                            can_hell_run(HELL_RUNS_TABLE['MainUpperNorfair']['Norfair Entrance -> Croc via Frog'])
                        }),
                        wor({
                            can_blue_gate_glitch(),
                            wave()
                        })
                    }),
                    wand({
                        traverse('BusinessCenterTopLeft'),
                        speed(),
                        can_use_power_bombs(),
                        can_hell_run(HELL_RUNS_TABLE['Ice']['Norfair Entrance -> Croc via Ice'])
                    })
                })
            end,
            ['Warehouse Entrance Left'] = function()
                return 1
            end
        },
        traverse = function()
            return 1
        end
    },
    ['Single Chamber Top Right'] = {
        exits = {
            ['Bubble Mountain Top'] = function()
                return wand({
                    can_destroy_bomb_walls(),
                    morph(),
                    can_hell_run(HELL_RUNS_TABLE['MainUpperNorfair']['Single Chamber <-> Bubble Mountain'])
                })
            end
        },
        traverse = function()
            return 1
        end
    },
    ['Cathedral'] = {
        exits = {
            ['Business Center'] = function()
                return can_exit_cathedral(HELL_RUNS_TABLE['MainUpperNorfair']['Bubble -> Cathedral Missiles'])
            end,
            ['Bubble Mountain'] = function()
                return wand({
                    traverse('CathedralRight'),
                    can_hell_run(HELL_RUNS_TABLE['MainUpperNorfair']['Norfair Entrance -> Cathedral Missiles'])
                })
            end
        },
        traverse = function()
            return 1
        end
    },
    ['Kronic Boost Room Bottom Left'] = {
        exits = {
            ['Bubble Mountain Bottom'] = function()
                return can_hell_run(HELL_RUNS_TABLE['MainUpperNorfair']['Single Chamber <-> Bubble Mountain'])
            end,
            ['Bubble Mountain Top'] = function()
                return wand({
                    morph(),
                    can_hell_run(HELL_RUNS_TABLE['MainUpperNorfair']['Kronic Boost Room -> Bubble Mountain Top'])
                })
            end,
            ['Crocomire Speedway Bottom'] = function()
                return wand({
                    can_hell_run(HELL_RUNS_TABLE['MainUpperNorfair']['Kronic Boost Room <-> Croc']),
                    wor({
                        wave(),
                        can_blue_gate_glitch()
                    })
                })
            end
        },
        traverse = function()
            return wor({
                has_patch(104),
                traverse('KronicBoostBottomLeft')
            })
        end
    },
    ['Crocomire Speedway Bottom'] = {
        exits = {
            ['Business Center'] = function()
                return wor({
                    wand({
                        can_pass_frog_speedway_right_to_left(),
                        can_hell_run(HELL_RUNS_TABLE['Ice']['Croc -> Norfair Entrance'])
                    }),
                    wand({
                        can_hell_run(HELL_RUNS_TABLE['MainUpperNorfair']['Croc -> Norfair Entrance']),
                        can_grapple_escape(),
                        super()
                    })
                })
            end,
            ['Bubble Mountain Bottom'] = function()
                return can_hell_run(HELL_RUNS_TABLE['Ice']['Croc -> Bubble Mountain'])
            end,
            ['Kronic Boost Room Bottom Left'] = function()
                return wand({
                    can_hell_run(HELL_RUNS_TABLE['MainUpperNorfair']['Kronic Boost Room <-> Croc']),
                    morph()
                })
            end
        },
        traverse = function()
            return wor({
                has_patch(106),
                traverse('CrocomireSpeedwayBottom')
            })
        end
    },
    ['Bubble Mountain'] = {
        exits = {
            ['Business Center'] = function()
                return can_exit_cathedral(HELL_RUNS_TABLE['MainUpperNorfair']['Bubble -> Norfair Entrance'])
            end,
            ['Bubble Mountain Top'] = function()
                return can_climb_bubble_mountain()
            end,
            ['Cathedral'] = function()
                return can_hell_run(HELL_RUNS_TABLE['MainUpperNorfair']['Bubble -> Cathedral Missiles'])
            end,
            ['Bubble Mountain Bottom'] = function()
                return can_pass_bomb_passages()
            end
        },
        traverse = function()
            return 1
        end
    },
    ['Bubble Mountain Top'] = {
        exits = {
            ['Kronic Boost Room Bottom Left'] = function()
                return wand({
                    morph(),
                    can_hell_run(HELL_RUNS_TABLE['MainUpperNorfair']['Bubble -> Kronic Boost Room wo/Bomb'])
                })
            end,
            ['Single Chamber Top Right'] = function()
                return wand({
                    can_hell_run(HELL_RUNS_TABLE['MainUpperNorfair']['Single Chamber <-> Bubble Mountain']),
                    can_destroy_bomb_walls(),
                    morph(),
                    has_patch(101)
                })
            end,
            ['Bubble Mountain'] = function()
                return 1
            end,
            ['Bubble Mountain Bottom'] = function()
                return wand({
                    morph(),
                    can_hell_run(HELL_RUNS_TABLE['MainUpperNorfair']['Bubble Top <-> Bubble Bottom'])
                })
            end
        },
        traverse = function()
            return 1
        end
    },
    ['Bubble Mountain Bottom'] = {
        exits = {
            ['Bubble Mountain'] = function()
                return can_pass_bomb_passages()
            end,
            ['Crocomire Speedway Bottom'] = function()
                return wand({
                    can_hell_run(HELL_RUNS_TABLE['MainUpperNorfair']['Bubble -> Croc']),
                    wor({
                        can_blue_gate_glitch(),
                        wave()
                    })
                })
            end,
            ['Kronic Boost Room Bottom Left'] = function()
                return can_hell_run(HELL_RUNS_TABLE['MainUpperNorfair']['Bubble -> Kronic Boost Room'])
            end,
            ['Business Center'] = function()
                return can_pass_frog_speedway_right_to_left()
            end,
            ['Bubble Mountain Top'] = function()
                return wand({
                    morph(),
                    can_hell_run(HELL_RUNS_TABLE['MainUpperNorfair']['Bubble Top <-> Bubble Bottom'])
                })
            end
        },
        traverse = function()
            return 1
        end
    },
    ['Business Center Mid Left'] = {
        exits = {
            ['Warehouse Entrance Left'] = function()
                return 1
            end
        },
        traverse = function()
            return 1
        end
    },
    ['Norfair Map Room'] = {
        exits = {},
        traverse = function()
            return 1
        end
    },
    -- Croc
    ['Crocomire Room Top'] = {
        exits = {},
        traverse = function()
            return wor({
                has_patch(106),
                enough_stuff_croc()
            })
        end
    },
    -- West Maridia
    ['Main Street Bottom'] = {
        exits = {
            ['Red Fish Room Left'] = function()
                return wand({
                    can_go_up_mt_everest(),
                    morph()
                })
            end,
            ['Crab Hole Bottom Left'] = function()
                return wand({
                    morph(),
                    can_traverse_crab_tunnel_left_to_right()
                })
            end,
            ['Oasis Bottom'] = function()
                return wand({
                    wnot(has_patch(108)),
                    traverse('MainStreetBottomRight'),
                    wor({
                        super(),
                        has_patch(103)
                    }),
                    can_traverse_west_sand_hall_left_to_right()
                })
            end,
            ['Crab Shaft Left'] = function()
                return can_pass_mt_everest()
            end
        },
        traverse = function()
            return 1
        end
    },
    ['Mama Turtle'] = {
        exits = {
            ['Main Street Bottom'] = function()
                return can_jump_underwater()
            end
        },
        traverse = function()
            return 1
        end
    },
    ['Crab Hole Bottom Left'] = {
        exits = {
            ['Main Street Bottom'] = function()
                return wand({
                    can_exit_crab_hole(),
                    wor({
                        can_green_gate_glitch(),
                        has_patch(103)
                    })
                })
            end,
            ['Oasis Bottom'] = function()
                return wand({
                    wnot(has_patch(108)),
                    can_exit_crab_hole(),
                    can_traverse_west_sand_hall_left_to_right()
                })
            end
        },
        traverse = function()
            return 1
        end
    },
    ['Red Fish Room Left'] = {
        exits = {
            ['Main Street Bottom'] = function()
                return morph()
            end
        },
        traverse = function()
            return 1
        end
    },
    ['Crab Shaft Left'] = {
        exits = {
            ['Main Street Bottom'] = function()
                return 1
            end,
            ['Beach'] = function()
                return can_do_outer_maridia()
            end,
            ['Crab Shaft Right'] = function()
                return 1
            end,
        },
        traverse = function()
            return 1
        end
    },
    ['Watering Hole'] = {
        exits = {
            ['Beach'] = function()
                return morph()
            end,
            ['Watering Hole Bottom'] = function()
                return 1
            end
        },
        traverse = function()
            return 1
        end
    },
    ['Watering Hole Bottom'] = {
        exits = {
            ['Watering Hole'] = function()
                return can_jump_underwater()
            end
        },
        traverse = function()
            return 1
        end
    },
    ['Beach'] = {
        exits = {
            ['Crab Shaft Left'] = function()
                return 1
            end,
            ['Watering Hole'] = function()
                return wand({
                    wor({
                        can_pass_bomb_passages(),
                        can_use_spring_ball()
                    }),
                    can_do_outer_maridia()
                })
            end
        },
        traverse = function()
            return 1
        end
    },
    ['Crab Shaft Right'] = {
        exits = {
            ['Crab Shaft Left'] = function()
                return can_jump_underwater()
            end
        },
        traverse = function()
            return wor({
                has_patch(107),
                traverse('CrabShaftRight')
            })
        end
    },
    ['Crab Hole Bottom Right'] = {
        exits = {
            ['Crab Hole Bottom Left'] = function()
                return 1
            end
        },
        traverse = function()
            return 1
        end
    },
    ['Maridia Map Room'] = {
        exits = {},
        traverse = function()
            return 1
        end
    },
    -- East Maridia
    ['Aqueduct Top Left'] = {
        exits = {
            ['Aqueduct Bottom'] = function()
                return can_use_power_bombs()
            end
        },
        traverse = function()
            return 1
        end
    },
    ['Aqueduct Bottom'] = {
        exits = {
            ['Aqueduct Top Left'] = function()
                return wand({
                    can_destroy_bomb_walls_underwater(),
                    can_jump_underwater()
                })
            end,
            ['Post Botwoon'] = function()
                return wand({
                    can_jump_underwater(),
                    can_defeat_botwoon()
                })
            end,
            ['Left Sandpit'] = function()
                return can_access_sand_pits()
            end,
            ['Right Sandpit'] = function()
                return can_access_sand_pits()
            end,
            ['Aqueduct'] = function()
                return wand({
                    wor({
                        speed(),
                        wand({
                            knows('SnailClip'),
                            morph()
                        })
                    }),
                    gravity()
                })
            end
        },
        traverse = function()
            return 1
        end
    },
    ['Aqueduct'] = {
        exits = {
            ['Aqueduct Bottom'] = function()
                return 1
            end
        },
        traverse = function()
            return 1
        end
    },
    ['Post Botwoon'] = {
        exits = {
            ['Aqueduct Bottom'] = function()
                return wor({
                    wand({
                        can_jump_underwater(),
                        morph()
                    }),
                    wand({
                        gravity(),
                        speed()
                    })
                })
            end,
            ['Colosseum Top Right'] = function()
                return can_botwoon_exit_to_colosseum()
            end,
            ['Toilet Top'] = function()
                return wand({
                    can_reach_cacatac_alley_from_botowoon(),
                    can_pass_cacatac_alley()
                })
            end
        },
        traverse = function()
            return 1
        end
    },
    ['West Sand Hall Left'] = {
        exits = {
            ['Oasis Bottom'] = function()
                return gravity()
            end,
            ['Aqueduct Bottom'] = function()
                return has_patch(108)
            end,
            ['Main Street Bottom'] = function()
                return wand({
                    wnot(has_patch(108)),
                    wor({
                        can_green_gate_glitch(),
                        has_patch(103)
                    })
                })
            end,
            ['Crab Hole Bottom Left'] = function()
                return wand({
                    wnot(has_patch(108)),
                    morph()
                })
            end
        },
        traverse = function()
            return 1
        end
    },
    ['Left Sandpit'] = {
        exits = {
            ['West Sand Hall Left'] = function()
                return can_access_sand_pits()
            end,
            ['Oasis Bottom'] = function()
                return can_access_sand_pits()
            end
        },
        traverse = function()
            return 1
        end
    },
    ['Oasis Bottom'] = {
        exits = {
            ['Toilet Top'] = function()
                return wand({
                    traverse('OasisTop'),
                    can_destroy_bomb_walls_underwater()
                })
            end,
            ['West Sand Hall Left'] = function()
                return can_access_sand_pits()
            end
        },
        traverse = function()
            return 1
        end
    },
    ['Right Sandpit'] = {
        exits = {
            ['Oasis Bottom'] = function()
                return can_access_sand_pits()
            end
        },
        traverse = function()
            return 1
        end
    },
    ['Le Coude Right'] = {
        exits = {
            ['Toilet Top'] = function()
                return 1
            end
        },
        traverse = function()
            return 1
        end
    },
    ['Toilet Top'] = {
        exits = {
            ['Oasis Bottom'] = function()
                return wand({
                    traverse('PlasmaSparkBottom'),
                    can_destroy_bomb_walls_underwater()
                })
            end,
            ['Le Coude Right'] = function()
                return 1
            end,
            ['Colosseum Top Right'] = function()
                return wand({
                    draygon(),
                    gravity(),
                    morph()
                })
            end
        },
        traverse = function()
            return 1
        end
    },
    ['Colosseum Top Right'] = {
        exits = {
            ['Post Botwoon'] = function()
                return can_colosseum_to_botwoon_exit()
            end,
            ['Precious Room Top'] = function()
                return traverse('ColosseumBottomRight')
            end
        },
        traverse = function()
            return 1
        end
    },
    ['Precious Room Top'] = {
        exits = {
            ['Colosseum Top Right'] = function()
                return can_climb_colosseum()
            end,
            ['DraygonRoomOut'] = function()
                return 1
            end
        },
        traverse = function()
            return 1
        end
    },
    ['DraygonRoomOut'] = {
        exits = {
            ['Precious Room Top'] = function()
                return can_exit_precious_room()
            end
        },
        traverse = function()
            return can_open_eye_doors()
        end
    },
    ['DraygonRoomIn'] = {
        exits = {
            ['Draygon Room Bottom'] = function()
                return wor({
                    draygon(),
                    wand({
                        can_fight_draygon(),
                        enough_stuff_draygon()
                    })
                })
            end
        },
        traverse = function()
            return 1
        end
    },
    ['Draygon Room Bottom'] = {
        exits = {
            ['DraygonRoomIn'] = function()
                return wand({
                    draygon(),
                    can_exit_draygon()
                })
            end
        },
        traverse = function()
            return 1
        end
    },
    -- Red Brinstar
    ['Red Tower Top Left'] = {
        exits = {
            ['Red Brinstar Elevator'] = function()
                return can_climb_red_tower()
            end,
            ['Caterpillar Room Top Right'] = function()
                return wand({
                    can_pass_red_tower_to_maridia_node(),
                    can_climb_red_tower()
                })
            end,
            ['East Tunnel Right'] = function()
                return 1
            end
        },
        traverse = function()
            return 1
        end
    },
    ['Caterpillar Room Top Right'] = {
        exits = {
            ['Red Brinstar Elevator'] = function()
                return wand({
                    morph(),
                    wor({
                        has_patch(102),
                        super()
                    })
                })
            end
        },
        traverse = function()
            return 1
        end
    },
    ['Red Brinstar Elevator'] = {
        exits = {
            ['Caterpillar Room Top Right'] = function()
                return can_pass_red_tower_to_maridia_node()
            end,
            ['Red Tower Top Left'] = function()
                return wor({
                    has_patch(25),
                    traverse('door_rb_tyd')
                })
            end
        },
        traverse = function()
            return wor({
                has_patch(22),
                traverse('RedBrinstarElevatorTop')
            })
        end
    },
    ['East Tunnel Right'] = {
        exits = {
            ['East Tunnel Top Right'] = function()
                return 1
            end,
            ['Glass Tunnel Top'] = function()
                return wand({
                    can_use_power_bombs(),
                    wor({
                        gravity(),
                        hijump()
                    })
                })
            end,
            ['Red Tower Top Left'] = function()
                return can_climb_bottom_red_tower()
            end
        },
        traverse = function()
            return 1
        end
    },
    ['East Tunnel Top Right'] = {
        exits = {
            ['East Tunnel Right'] = function()
                return wor({
                    has_patch(102),
                    super()
                })
            end
        },
        traverse = function()
            return has_patch(102)
        end
    },
    ['Glass Tunnel Top'] = {
        exits = {
            ['East Tunnel Right'] = function()
                return wor({
                    has_patch(51),
                    can_use_power_bombs()
                })
            end
        },
        traverse = function()
            return wand({
                wor({
                    gravity(),
                    hijump()
                }),
                wor({
                    has_patch(51),
                    can_use_power_bombs()
                })
            })
        end
    },
    -- Tourian
    ['Golden Four'] = {
        exits = {},
        traverse = function()
            return 1
        end
    },
    ['Tourian Escape Room 4 Top Right'] = {
        exits = {},
        traverse = function()
            return 1
        end
    }
}
REGIONS = CLEAN_REGIONS

START_LOCATIONS = {
    [0] = 'Ceres',
    [1] = 'Landing Site',
    [2] = 'Gauntlet Top',
    [3] = 'Green Brinstar Elevator',
    [4] = 'Big Pink',
    [5] = 'Etecoons Supers',
    [6] = 'Wrecked Ship Main',
    [7] = 'Firefleas Top',
    [8] = 'Business Center',
    [9] = 'Bubble Mountain',
    [10] = 'Mama Turtle',
    [11] = 'Watering Hole',
    [12] = 'Aqueduct',
    [13] = 'Red Brinstar Elevator',
    [14] = 'Golden Four',
}

function has_access_to(region_name)
    local start = get_start_location()

    if not start or not REGIONS[start] then
        if AUTOTRACKER_ENABLE_DEBUG_LOGGING_ACCESS then
            print(string.format("called has_access_to: unknown start location %s", start))
        end
        return 0
    end
    if start == region_name then
        return 1
    end
    local value = check_access(start, region_name, {})
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_ACCESS then
        print(string.format("called has_access_to: region_name: %s, start: %s, value: %s", region_name, start, value))
    end
    if value > 0 then
        if AUTOTRACKER_ENABLE_DEBUG_LOGGING_ACCESS then
            print(string.format("\t we found a way from %s to %s! yay \\o/", start, region_name))
        end
        return 1
    end
    return 0
end

function check_access(region_name, goal, checked_regions)
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_ACCESS then
        print(string.format("called check_access: region_name: %s, goal: %s, checked_regions: %s", region_name, goal,
            #checked_regions))
        for k, v in pairs(checked_regions) do
            print(string.format('\t already checked %s', v))
        end
    end
    local value = 0
    if not REGIONS[region_name] or not REGIONS[region_name].exits then
        return 0
    end
    for k, v in pairs(REGIONS[region_name].exits) do
        local exit_func_return = v()
        if AUTOTRACKER_ENABLE_DEBUG_LOGGING_ACCESS then
            if exit_func_return == nil then
                print(string.format("\t exits function has no return value: region_name: %s -> k: %s", region_name, k))
            end
            print(string.format("\t region_name: %s -> k: %s, v(): %s", region_name, k, exit_func_return))
        end
        if k == goal and exit_func_return > 0 then
            return 1
        elseif exit_func_return > 0 then
            local already_checked = false
            for _, region in pairs(checked_regions) do
                if region == k then
                    already_checked = true
                end
            end
            if not already_checked then
                table.insert(checked_regions, region_name)
                value = check_access(k, goal, checked_regions)
                if value > 0 then
                    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_ACCESS then
                        print(string.format(
                        "\t we found it \\o/, returning 1; region_name: %s, goal: %s, checked_regions: %s", region_name,
                            goal, #checked_regions))
                    end
                    return 1
                end
            else
                if AUTOTRACKER_ENABLE_DEBUG_LOGGING_ACCESS then
                    print(string.format("\t skipping k %s: already checked", k))
                end
            end
        end
    end
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_ACCESS then
        print(string.format("\t deadend returning 0; region_name: %s, goal: %s, checked_regions: %s", region_name, goal,
            #checked_regions))
    end
    return 0
end

function get_start_location()
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_ACCESS then
        print(string.format("called get_start_location"))
    end
    if not SLOT_DATA or not SLOT_DATA['start_location'] or not START_LOCATIONS[SLOT_DATA['start_location']] then
        return nil
    end
    return START_LOCATIONS[SLOT_DATA['start_location']]
end

function set_transitions(slot_data)
    REGIONS = CLEAN_REGIONS
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_ACCESS then
        print(string.format("called set_transitions"))
    end
    if slot_data == nil or slot_data['InterAreaTransitions'] == nil or slot_data['area_randomization'] == nil then
        return
    end
    for k, v in pairs(slot_data['InterAreaTransitions']) do
        local obj = Tracker:FindObjectForCode("trans_" .. k:gsub("[%s]+", ""))
        if obj then
            obj:Set("state", 0)
            obj:Set("active", false)
        end
    end
    for k, v in pairs(slot_data['InterAreaTransitions']) do
        local obj = Tracker:FindObjectForCode("trans_" .. k:gsub("[%s]+", ""))
        if obj then
            obj:Set("state", Transition.STATES[v])
            if k:find('In') or k:find('Out') then
                obj:Set("active", is_boss_rando() == 0)
            else
                obj:Set("active", is_area_rando() == 0)
            end
        end
    end
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_ACCESS then
        --print(string.format("REGIONS: %s", dump_table(REGIONS)))
    end
end

--function inject_area_trans(slot_data)
--    REGIONS = CLEAN_REGIONS
--    if AUTOTRACKER_ENABLE_DEBUG_LOGGING then
--        print(string.format("called inject_area_trans"))
--    end
--    if slot_data == nil or slot_data['InterAreaTransitions'] == nil then
--       return
--    end
--    for k, v in pairs(slot_data['InterAreaTransitions']) do
--        if REGIONS[k] and not REGIONS[k].exits[v] and REGIONS[k].traverse then
--            if AUTOTRACKER_ENABLE_DEBUG_LOGGING then
--                print(string.format("\tinjecting %s exit into %s", v, k))
--            end
--            REGIONS[k].exits[v] = REGIONS[k].traverse
--        else
--            if AUTOTRACKER_ENABLE_DEBUG_LOGGING then
--                print(string.format("\tskipping injecting %s exit into %s", v, k))
--            end
--        end
--    end
--end

function get_connection(region_name)
    if REGIONS == nil or REGIONS[region_name] == nil then
        return nil
    end
    return REGIONS[region_name]
end

function is_vanilla_draygon()
    if get_connection('DraygonRoomOut') == 'DraygonRoomIn' then
        return 1
    end
    return 0
end
