LOCATIONS = {
    ["Energy Tank, Gauntlet"] = {
        access_from = function()
            return has_access_to('Landing Site')
        end,
        available = function()
            return wor({
                can_enter_and_leave_gauntlet(),
                wand({
                    can_short_charge(),
                    can_enter_and_leave_gauntlet_qty(1, 0)
                }),
                can_do_low_gauntlet()
            })
        end        
    },
    ["Bomb"] = {
        access_from = function()
            return has_access_to('Landing Site')
        end,
        available = function()
            return wand({
                morph(),
                traverse('FlywayRight')
            })
        end,
        post_available = function()
            return wor({
                knows('AlcatrazEscape'),
                can_pass_bomb_passages()
            })
        end
    },
    ["Energy Tank, Terminator"] = {
        access_from = function()
            return wor({
                wand({
                    has_access_to('Landing Site'),
                    can_pass_terminator_bomb_wall()
                }),
                wand({
                    has_access_to('Lower Mushrooms Left'),
                    can_pass_crateria_green_pirates()
                }),
                wand({
                    has_access_to('Gauntlet Top'),
                    morph()
                })
            })
        end               
    },
    ["Reserve Tank, Brinstar"] = {
        access_from = function()
            return wand({
                has_access_to('Green Brinstar Elevator'),
                wor({
                    has_patch(24),
                    traverse('MainShaftRight')
                })
            })
        end,
        available = function()
            return wand({
                wor({
                    can_mockball(),
                    speed()
                }),
                wor({
                    has_patch(24),
                    traverse('EarlySupersRight')
                })
            })
        end
    },
    ["Charge Beam"] = {
        access_from = function()
            return has_access_to('Big Pink')
        end,
        available = function()
            return can_pass_bomb_passages()
        end
    },
    ["Morphing Ball"] = {
        access_from = function()
            return has_access_to('Blue Brinstar Elevator Bottom')
        end        
    },
    ["Energy Tank, Brinstar Ceiling"] = {
        access_from = function()
            return wand({
                has_access_to('Blue Brinstar Elevator Bottom'),
                wor({
                    has_patch(10),
                    traverse('ConstructionZoneRight')
                })
            })
        end,
        available = function()
            return wor({
                knows('CeilingDBoost'),
                can_fly(),
                wor({
                    hijump(),
                    ice(),
                    wand({
                        can_use_power_bombs(),
                        speed()
                    }),
                    can_simple_short_charge()
                })
            })
        end
    },
    ["Energy Tank, Etecoons"] = {
        access_from = function()
            return has_access_to('Etecoons Bottom')
        end            
    },
    ["Energy Tank, Waterway"] = {
        access_from = function()
            return has_access_to('Big Pink')
        end,
        available = function()
            return wand({
                can_use_power_bombs(),
                traverse('BigPinkBottomLeft'),
                speed(),
                wor({
                    gravity(),
                    can_simple_short_charge()
                })
            })
        end
    },
    ["Energy Tank, Brinstar Gate"] = {
        access_from = function()
            return has_access_to('Big Pink')
        end,
        available = function()
            return wand({
                traverse('BigPinkRight'),
                wor({
                    wave(),
                    wand({
                        super(),
                        hijump(),
                        knows('ReverseGateGlitch')
                    }),
                    wand({
                        super(),
                        knows('ReverseGateGlitchHiJumpLess')
                    })
                })
            })
        end
    },
    ["X-Ray Scope"] = {
        access_from = function()
            return has_access_to('Red Tower Top Left')
        end,
        available = function()
            return wand({
                can_use_power_bombs(),
                traverse('RedTowerLeft'),
                traverse('RedBrinstarFirefleaLeft'),
                wor({
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
            })
        end
    },
    ["Spazer"] = {
        access_from = function()
            return has_access_to('East Tunnel Right')
        end,
        available = function()
            return wand({
                traverse('BelowSpazerTopRight'),
                wor({
                    can_pass_bomb_passages(),
                    wand({
                        morph(),
                        has_patch(20),
                    })
                })
            })
        end
    },
    ["Energy Tank, Kraid"] = {
        access_from = function()
            return has_access_to('Warehouse Zeela Room Left')
        end,
        available = function()
            return wand({
                kraid(),
                can_kill_beetoms()
            })
        end
    },
    ["Kraid"] = {
        access_from = function()
            return has_access_to('KraidRoomIn')
        end,
        available = function()
            return enough_stuff_kraid()
        end
    },
    ["Varia Suit"] = {
        access_from = function()
            return has_access_to('KraidRoomIn')
        end,
        available = function()
            return kraid()
        end
    },
    ["Ice Beam"] = {
        access_from = function()
            return wand({
                has_access_to('Business Center'),
                traverse('BusinessCenterTopLeft')
            })
        end,
        available = function()
            return wand({
                can_hell_run(HELL_RUNS_TABLE['Ice']['Norfair Entrance -> Ice Beam']),
                wor({
                    can_pass_bomb_passages(),
                    wand({
                        ice(),
                        morph(),
                        knows('IceEscape')
                    })
                }),
                wor({
                    wand({
                        morph(),
                        knows('Mockball')
                    }),
                    speed()
                })
            })
        end
    },
    ["Energy Tank, Crocomire"] = {
        access_from = function()
            return has_access_to('Crocomire Room Top')
        end,
        available = function()
            return wand({
                enough_stuff_croc(),
                wor({
                    grapple(),
                    space(),
                    energy_reserve_count_ok(3/get_dmg_reduction()[1])
                })
            })
        end
    },
    ["Hi-Jump Boots"] = {
        access_from = function()
            return wand({
                has_access_to('Business Center'),
                wor({
                    has_patch(32),
                    traverse('BusinessCenterBottomLeft')
                })
            })
        end,
        available = function()
            return morph()
        end,
        post_avaible = function()
            return wor({
                can_pass_bomb_passages(),
                wand({
                    morph(),
                    has_patch(30)
                })
            })
        end
    },
    ["Grapple Beam"] = {
        access_from = function()
            return has_access_to('Crocomire Room Top')
        end,
        available = function()
            return wand({
                enough_stuff_croc(),
                wor({
                    wand({
                        morph(),
                        can_fly()
                    }),
                    wand({
                        speed(),
                        wor({
                            knows('ShortCharge'),
                            can_use_power_bombs()
                        })
                    }),
                    wand({
                        morph(),
                        wor({
                            speed(),
                            can_spring_ball_jump()
                        }),
                        hijump()
                    }),
                    can_green_gate_glitch()
                })
            })
        end,
        post_avaible = function()
            return wor({
                morph(),
                wand({
                    super(),
                    wor({
                        can_fly(),
                        morph(),
                        grapple()
                    }),
                    wor({
                        gravity(),
                        space(),
                        grapple()
                    })
                })
            })
        end
    },
    ["Reserve Tank, Norfair"] = {
        access_from = function()
            return wor({
                wand({
                    has_access_to('Bubble Mountain'),
                    can_enter_norfair_reserve_area_from_bubble_mountain()
                }),
                wand({
                    has_access_to('Bubble Mountain Top'),
                    can_enter_norfair_reserve_area_from_bubble_mountain_top()
                }),
            })
        end,
        available = function()
            return wand({
                morph(),
                can_hell_run(HELL_RUNS_TABLE['MainUpperNorfair']['Bubble -> Norfair Reserve'])
            })
        end
    },
    ["Speed Booster"] = {
        access_from = function()
            return wand({
                has_access_to('Bubble Mountain Top'),
                wor({
                    has_patch(33),
                    wand({
                        traverse('BubbleMountainTopRight'),
                        traverse('SpeedBoosterHallRight')
                    })
                })
            })
        end,
        available = function()
            return can_hell_run_to_speed_booster()
        end
    },
    ["Wave Beam"] = {
        access_from = function()
            return wand({
                has_access_to('Bubble Mountain Top'),
                can_access_double_chamber_items()
            })
        end,
        available = function()
            return traverse('DoubleChamberRight')
        end,
        post_available = function()
            return wor({
                morph(),
                wand({
                    wor({
                        space(),
                        grapple()
                    }),
                    wor({
                        wand({
                            can_blue_gate_glitch(),
                            heat_proof()
                        }),
                        wave()
                    })
                })
            })
        end
    },
    ["Ridley"] = {
        access_from = function()
            return has_access_to('RidleyRoomIn')
        end,
        available = function()
            return wand({
                can_hell_run(HELL_RUNS_TABLE['LowerNorfair']['Main']),
                enough_stuff_ridley()
            })
        end
    },
    ["Energy Tank, Ridley"] = {
        access_from = function()
            return wand({
                has_access_to('RidleyRoomIn'),
                ridley()
            })
        end,
        available = function()
            return morph()
        end
    },
    ["Screw Attack"] = {
        access_from = function()
            return has_access_to('Screw Attack Bottom')
        end,
        post_available = function()
            return can_exit_screw_attack_area()
        end
    },
    ["Energy Tank, Firefleas"] = {
        access_from = function()
            return has_access_to('Firefleas')
        end,
        available = function()
            return wor({
                has_patch(35),
                super(),
                can_pass_bomb_passages(),
                can_use_spring_ball()
            })
        end,
        post_available = function()
            return wor({
                knows('FirefleasWalljump'),
                wor({
                    ice(),
                    hijump(),
                    can_fly(),
                    can_spring_ball_jump()
                })
            })
        end
    },
    ["Reserve Tank, Wrecked Ship"] = {
        access_from = function()
            return has_access_to('Wrecked Ship Main')
        end,
        available = function()
            return wand({
                can_use_power_bombs(),
                speed(),
                can_pass_bowling()
            })
        end
    },
    ["Energy Tank, Wrecked Ship"] = {
        access_from = function()
            return wand({
                has_access_to('Wrecked Ship Back'),
                wor({
                    has_patch(53),
                    traverse('ElectricDeathRoomTopLeft')
                })
            })
        end,
        available = function()
            return wor({
                phantoon(),
                has_patch(1001)
            })
        end
    },
    ["Phantoon"] = {
        access_from = function()
            return has_access_to('PhantoonRoomIn')
        end,
        available = function()
            return enough_stuff_phantoon()
        end
    },
    ["Right Super, Wrecked Ship"] = {
        access_from = function()
            return wand({
                has_access_to('Wrecked Ship Main'),
                phantoon()
            })
        end,
        available = function()
            return can_pass_bomb_passages()
        end
    },
    ["Gravity Suit"] = {
        access_from = function()
            return has_access_to('Wrecked Ship Main')
        end,
        available = function()
            return wand({
                can_pass_bomb_passages(),
                can_pass_bowling()
            })
        end
    },
    ["Energy Tank, Mama turtle"] = {
        access_from = function()            
            return wor({
                wand({
                    has_access_to('Main Street Bottom'),
                    can_do_outer_maridia(),
                    wor({
                        traverse('FishTankRight'),
                        has_patch(52)
                    }),
                    wor({
                        wor({
                            can_fly(),
                            wand({
                                gravity(),
                                speed()
                            }),
                            wand({
                                hijump(),
                                speed(),
                                knows('HiJumpMamaTurtle')
                            })
                        }),
                        wor({
                            wand({
                                can_use_spring_ball(),
                                wor({
                                    wand({
                                        hijump(),
                                        knows('SpringBallJump')
                                    }),
                                    knows('SpringBallJumpFromWall')
                                })
                            }),
                            grapple()
                        })
                    })
                }),
                has_access_to('Mama Turtle')
            })
        end
    },
    ["Plasma Beam"] = {
        access_from = function()
            return has_access_to('Toilet Top')
        end,
        available = function()
            return draygon()
        end,
        post_available = function()
            return wand({
                wor({
                    wand({
                        can_short_charge(),
                        knows('KillPlasmaPiratesWithSpark')
                    }),
                    wand({
                        can_fire_charged_shots(),
                        knows('KillPlasmaPiratesWithCharge'),
                        energy_reserve_count_ok(math.floor(10*get_pirates_pseudo_screw_coeff()/get_dmg_reduction(false)[1]))
                    }),
                    screw(),
                    plasma()
                }),
                wor({
                    can_fly(),
                    wand({
                        hijump(),
                        knows('GetAroundWallJump')
                    }),
                    can_short_charge(),
                    wand({
                        can_spring_ball_jump(),
                        knows('SpringBallJumpFromWall')
                    })
                })
            })
        end
    },
    ["Reserve Tank, Maridia"] = {
        access_from = function()
            return wand({
                has_access_to('Left Sandpit'),
                can_climb_west_sand_hole()
            })
        end,
        avaiable = function()
            return can_access_items_in_west_sand_hole()
        end
    },
    ["Spring Ball"] = {
        access_from = function()
            return wand({
                has_access_to('Oasis Bottom'),
                can_traverse_sand_pits()
            })
        end,
        avaiable = function()
            return wand({
                can_use_power_bombs(),
                wor({
                    wand({
                        ice(),
                        wor({
                            wand({
                                gravity(),
                                knows('PuyoClip')
                            }),
                            wand({
                                gravity(),
                                xray(),
                                knows('PuyoClipXRay')
                            }),
                            knows('SuitlessPuyoClip')
                        })
                    }),
                    wand({
                        grapple(),
                        wor({
                            wand({
                                gravity(),
                                wor({
                                    wor({
                                        wand({
                                            hijump(),
                                            knows('AccessSpringBallWithHiJump')
                                        }),
                                        space()
                                    }),
                                    knows('AccessSpringBallWithGravJump'),
                                    wand({
                                        bomb(),
                                        wor({
                                            knows('AccessSpringBallWithBombJumps'),
                                            wand({
                                                spring(),
                                                knows('AccessSpringBallWithSpringBallBombJumps')
                                            })
                                        })
                                    }),
                                    wand({
                                        spring(),
                                        knows('AccessSpringBallWithSpringBallJump')
                                    })
                                })
                            })
                        })
                    }),
                    wand({
                        xray(),
                        knows('AccessSpringBallWithXRayClimb')
                    }),
                    can_crystal_flash_clip()
                }),
                wor({
                    gravity(),
                    can_use_spring_ball()
                })
            })
        end,
        post_available = function()
            return wor({
                wand({
                    gravity(),
                    wor({
                        hijump(),
                        can_fly(),
                        knows('MaridiaWallJumps')
                    })
                }),
                can_spring_ball_jump()
            })
        end
    },
    ["Energy Tank, Botwoon"] = {
        access_from = function()
            return wand({
                has_access_to('Post Botwoon'),
                can_jump_underwater()
            })
        end,
        available = function()
            return morph()
        end
    },
    ["Draygon"] = {
        access_from = function()
            return has_access_to('Draygon Room Bottom')            
        end
    },
    ["Space Jump"] = {
        access_from = function()
            return has_access_to('Draygon Room Bottom')
        end,
        post_available = function()
            return draygon()
        end        
    },
    ["Mother Brain"] = {
        access_from = function()
            return wand({
                has_access_to('Golden Four'),
                all_bosses_dead()
            })
        end,
        available = function()
            return enough_stuff_tourian()
        end
    },
    ["Power Bomb (Crateria surface)"] = {
        access_from = function()
            return has_access_to('Landing Site')
        end,
        available = function()
            return wand({
                traverse('LandingSiteTopRight'),
                wor({
                    speed(),
                    can_fly()
                })
            })
        end
    },
    ["Missile (outside Wrecked Ship bottom)"] = {
        access_from = function()            
            return has_access_to('West Ocean Left')
        end,
        available = function()
            return morph()
        end,
        post_available = function()
            return can_pass_bomb_passages()
        end
    },
    ["Missile (outside Wrecked Ship top)"] = {
        access_from = function()
            return has_access_to('Wrecked Ship Main')
        end,
        available = function()
            return phantoon()
        end
    },
    ["Missile (outside Wrecked Ship middle)"] = {
        access_from = function()
            return has_access_to('Wrecked Ship Main')
        end,
        available = function()
            return wand({
                super(),
                morph(),
                phantoon()
            })
        end
    },
    ["Missile (Crateria moat)"] = {
        access_from = function()
            return has_access_to('Moat Left')
        end
    },
    ["Missile (Crateria bottom)"] = {
        access_from = function()
            return has_access_to('Landing Site')
        end,
        available = function()
            return wor({
                can_destroy_bomb_walls(),
                wand({
                    speed(),
                    knows('OldMBWithSpeed')
                })
            })
        end
    },
    ["Missile (Crateria gauntlet right)"] = {
        access_from = function()
            return wor({
                wand({
                    has_access_to('Landing Site'),
                    wor({
                        wand({
                            can_enter_and_leave_gauntlet(),
                            can_pass_bomb_passages()
                        }),
                        can_do_low_gauntlet()
                    })
                }),
                has_access_to('Gauntlet Top')
            })
        end        
    },
    ["Missile (Crateria gauntlet left)"] = {
        access_from = function()
            return wor({
                wand({
                    has_access_to('Landing Site'),
                    wor({
                        wand({
                            can_enter_and_leave_gauntlet(),
                            can_pass_bomb_passages()
                        }),
                        can_do_low_gauntlet()
                    })
                }),
                has_access_to('Gauntlet Top')
            })
        end    
    },
    ["Super Missile (Crateria)"] = {
        access_from = function()
            return has_access_to('Landing Site')
        end,
        available = function()
            return wand({
                can_pass_bomb_passages(),
                traverse("ClimbRight"),
                speed(),
                wor({
                    wand({
                        energy_reserve_count_ok(2),
                        item_count_ok('etank', 1)
                    }),
                    wand({
                        item_count_ok('etank', 1),
                        wor({
                            grapple(),
                            space(),
                            heat_proof()
                        })
                    })
                }),
                wor({
                    ice(),
                    wand({
                        can_simple_short_charge(),
                        can_use_power_bombs()
                    })
                })
            })
        end
    },
    ["Missile (Crateria middle)"] = {
        access_from = function()
            return has_access_to('Landing Site')
        end,
        available = function()
            return can_pass_bomb_passages()
        end
    },
    ["Power Bomb (green Brinstar bottom)"] = {
        access_from = function()
            return has_access_to('Etecoons Bottom')
        end,
        available = function()
            return wand({
                morph(),
                can_kill_beetoms()
            })
        end
    },
    ["Super Missile (pink Brinstar)"] = {
        access_from = function()
            return has_access_to('Big Pink')
        end,
        available = function()
            return wor({
                wand({
                    traverse('BigPinkTopRight'),
                    enough_stuff_spore_spawn(),
                }),
                wand({
                    can_open_green_doors(),
                    can_pass_bomb_passages()
                })
            })
        end,
        post_available = function()
            return wand({
                can_open_green_doors(),
                can_pass_bomb_passages()
            })
        end
    },
    ["Missile (green Brinstar below super missile)"] = {
        access_from = function()
            return wand({
                has_access_to('Green Brinstar Elevator'),
                wor({
                    has_patch(24),
                    traverse('MainShaftRight')
                })
            })
        end,
        post_available = function()
            return wor({
                has_patch(23),
                can_pass_bomb_passages()
            })
        end
    },
    ["Super Missile (green Brinstar top)"] = {
        access_from = function()
            return wand({
                has_access_to('Green Brinstar Elevator'),
                wor({
                    has_patch(24),
                    traverse('MainShaftRight')
                })
            })
        end,
        available = function()
            return wor({
                can_mockball(),
                speed()
            })
        end
    },
    ["Missile (green Brinstar behind missile)"] = {
        access_from = function()
            return wand({
                has_access_to('Green Brinstar Elevator'),
                wor({
                    has_patch(24),
                    traverse('MainShaftRight')
                })
            })
        end,
        available = function()
            return wand({
                morph(),
                wor({
                    can_mockball(),
                    speed()
                }),
                traverse('EarlySupersRight'),
                wor({
                    can_pass_bomb_passages(),
                    wand({
                        knows('RonPopeilScrew'),
                        screw()
                    })
                })
            })
        end
    },
    ["Missile (green Brinstar behind reserve tank)"] = {
        access_from = function()
            return wand({
                has_access_to('Green Brinstar Elevator'),
                wor({
                    has_patch(24),
                    traverse('MainShaftRight')
                })
            })
        end,
        available = function()
            return wand({
                traverse('EarlySupersRight'),
                morph(),
                wor({
                    can_mockball(),
                    speed()
                })
            })
        end
    },
    ["Missile (pink Brinstar top)"] = {
        access_from = function()
            return has_access_to('Big Pink')
        end
    },
    ["Missile (pink Brinstar bottom)"] = {
        access_from = function()
            return has_access_to('Big Pink')
        end
    },
    ["Power Bomb (pink Brinstar)"] = {
        access_from = function()
            return has_access_to('Big Pink')
        end,
        available = function()
            return wand({
                can_use_power_bombs(),
                super()
            })
        end
    },
    ["Missile (green Brinstar pipe)"] = {
        access_from = function()
            return has_access_to('Green Hill Zone Top Right')
        end,
        available = function()
            return morph()
        end
    },
    ["Power Bomb (blue Brinstar)"] = {
        access_from = function()
            return wor({
                wand({
                    has_access_to('Blue Brinstar Elevator Bottom'),
                    can_use_power_bombs()
                }),
                wand({
                    has_access_to('Morph Ball Room Left'),
                    wor({
                        can_pass_bomb_passages(),
                        wand({
                            morph(),
                            can_short_charge()
                        })
                    })
                })
            })
        end
    },
    ["Missile (blue Brinstar middle)"] = {
        access_from = function()
            return has_access_to('Blue Brinstar Elevator Bottom')
        end,
        available = function()
            return wand({
                wor({
                    has_patch(11),
                    morph()
                }),
                wor({
                    has_patch(10),
                    traverse('ConstructionZoneRight')
                })
            })
        end
    },
    ["Super Missile (green Brinstar bottom)"] = {
        access_from = function()
            return has_access_to('Etecoons Supers')
        end
    },
    ["Missile (blue Brinstar bottom)"] = {
        access_from = function()
            return has_access_to('Blue Brinstar Elevator Bottom')
        end,
        available = function()
            return morph()
        end
    },
    ["Missile (blue Brinstar top)"] = {
        access_from = function()
            return has_access_to('Blue Brinstar Elevator Bottom')
        end,
        available = function()
            return can_access_billy_mays()
        end
    },
    ["Missile (blue Brinstar behind missile)"] = {
        access_from = function()
            return has_access_to('Blue Brinstar Elevator Bottom')
        end,
        available = function()
            return can_access_billy_mays()
        end
    },
    ["Power Bomb (red Brinstar sidehopper room)"] = {
        access_from = function()
            return has_access_to('Red Brinstar Elevator')
        end,
        available = function()
            return wand({
                traverse('RedTowerElevatorTopLeft'),
                can_use_power_bombs()
            })
        end
    },
    ["Power Bomb (red Brinstar spike room)"] = {
        access_from = function()
            return has_access_to('Red Brinstar Elevator')
        end,
        available = function()
            return traverse('RedTowerElevatorBottomLeft')
        end
    },
    ["Missile (red Brinstar spike room)"] = {
        access_from = function()
            return has_access_to('Red Brinstar Elevator')
        end,
        available = function()
            return wand({
                traverse('RedTowerElevatorBottomLeft'),
                can_use_power_bombs()
            })
        end
    },
    ["Missile (Kraid)"] = {
        access_from = function()
            return has_access_to('Warehouse Zeela Room Left')
        end,
        available = function()
            return can_use_power_bombs()
        end
    },
    ["Missile (lava room)"] = {
        access_from = function()
            return has_access_to('Cathedral')
        end,
        available = function()
            return morph()
        end
    },
    ["Missile (below Ice Beam)"] = {
        access_from = function()
            return wor({
                wand({
                    has_access_to('Business Center'),
                    wand({
                        traverse('BusinessCenterTopLeft'),
                        can_use_power_bombs(),
                        can_hell_run(HELL_RUNS_TABLE['Ice']['Norfair Entrance -> Ice Beam']),
                        wor({
                            wand({
                                morph(),
                                knows('Mockball')
                            }),
                            speed()
                        })
                    })
                }),
                wand({
                    has_access_to('Crocomire Speedway Bottom'),
                    wand({
                        can_use_croc_room_to_charge_speed(),
                        can_hell_run(HELL_RUNS_TABLE['MainUpperNorfair']['Croc -> Ice Missiles']),
                        speed(),
                        knows('IceMissileFromCroc')
                    })
                })
            })
        end
    },
    ["Missile (above Crocomire)"] = {
        access_from = function()
            return wand({
                has_access_to('Crocomire Speedway Bottom'),
                can_hell_run(HELL_RUNS_TABLE['MainUpperNorfair']['Croc -> Grapple Escape Missiles'])
            })
        end,
        available = function()
            return can_grapple_escape()
        end,
    },
    ["Missile (Hi-Jump Boots)"] = {
        access_from = function()
            return wand({
                has_access_to('Business Center'),
                wor({
                    has_patch(32),
                    traverse('BusinessCenterBottomLeft')
                })
            })
        end,
        available = function()
            return morph()
        end,
        post_available = function()
            return wor({
                can_pass_bomb_passages(),
                wand({
                    has_patch(30),
                    morph()
                })
            })
        end
    },
    ["Energy Tank (Hi-Jump Boots)"] = {
        access_from = function()
            return wand({
                has_access_to('Business Center'),
                wor({
                    has_patch(32),
                    traverse('BusinessCenterBottomLeft')
                })
            })
        end
    },
    ["Power Bomb (Crocomire)"] = {
        access_from = function()
            return has_access_to('Crocomire Room Top')
        end,
        available = function()
            return wand({
                traverse('PostCrocomireUpperLeft'),
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
    },
    ["Missile (below Crocomire)"] = {
        access_from = function()
            return has_access_to('Crocomire Room Top')
        end,
        available = function()
            return wand({
                traverse('PostCrocomireShaftRight'),
                enough_stuff_croc(),
                morph()
            })
        end
    },
    ["Missile (Grapple Beam)"] = {
        access_from = function()
            return has_access_to('Crocomire Room Top')
        end,
        available = function()
            return wand({
                enough_stuff_croc(),
                wor({
                    wor({
                        wand({
                            morph(),
                            can_fly()
                        }),
                        wand({
                            speed(),
                            wor({
                                knows('ShortCharge'),
                                can_use_power_bombs()
                            })
                        })
                    }),
                    wand({
                        can_green_gate_glitch(),
                        can_fly()
                    })
                })
            })
        end,
        post_available = function()
            return wor({
                morph(),
                wand({
                    super(),
                    wor({
                        space(),
                        wand({
                            speed(),
                            hijump()
                        })
                    })
                })
            })
        end
    },
    ["Missile (Norfair Reserve Tank)"] = {
        access_from = function()
            return wor({
                wand({
                    has_access_to('Bubble Mountain'),
                    can_enter_norfair_reserve_area_from_bubble_mountain()
                }),
                wand({
                    has_access_to('Bubble Mountain Top'),
                    can_enter_norfair_reserve_area_from_bubble_mountain_top()
                })
            })
        end,
        available = function()
            return wand({
                morph(),
                can_hell_run(HELL_RUNS_TABLE['MainUpperNorfair']['Bubble -> Norfair Reserve'])
            })
        end
    },
    ["Missile (bubble Norfair green door)"] = {
        access_from = function()
            return wor({
                wand({
                    has_access_to('Bubble Mountain'),
                    can_enter_norfair_reserve_area_from_bubble_mountain()
                }),
                wand({
                    has_access_to('Bubble Mountain Top'),
                    can_enter_norfair_reserve_area_from_bubble_mountain_top()
                })
            })
        end,
        available = function()
            return can_hell_run(HELL_RUNS_TABLE['MainUpperNorfair']['Bubble -> Norfair Reserve Missiles'])
        end
    },
    ["Missile (bubble Norfair)"] = {
        access_from = function()
            return has_access_to('Bubble Mountain')
        end
    },
    ["Missile (Speed Booster)"] = {
        access_from = function()
            return wand({
                has_access_to('Bubble Mountain Top'),
                wor({
                    has_patch(33),
                    traverse('BubbleMountainTopRight')
                })
            })
        end,
        available = function()
            return can_hell_run_to_speed_booster()
        end
    },
    ["Missile (Wave Beam)"] = {
        access_from = function()
            return wand({
                has_access_to('Bubble Mountain Top'),
                can_access_double_chamber_items()
            })
        end
    },
    ["Missile (Gold Torizo)"] = {
        access_from = function()
            return has_access_to('LN Above GT')
        end,
        available = function()
            return can_hell_run(HELL_RUNS_TABLE['LowerNorfair']['Main'])
        end,
        post_available = function()
            return enough_stuff_gt()
        end
    },
    ["Super Missile (Gold Torizo)"] = {
        access_from = function()
            return has_access_to('Screw Attack Bottom')
        end,
        post_available = function()
            return enough_stuff_gt()
        end
    },
    ["Missile (Mickey Mouse room)"] = {
        access_from = function()
            return wand({
                has_access_to('LN Entrance'),
                wand({
                    can_use_power_bombs(),
                    can_pass_worst_room()
                })
            })
        end,
        available = function()
            return can_hell_run(HELL_RUNS_TABLE['LowerNorfair']['Main'])
        end
    },
    ["Missile (lower Norfair above fire flea room)"] = {
        access_from = function()
            return wand({
                has_access_to('Firefleas'),
                can_hell_run(HELL_RUNS_TABLE['LowerNorfair']['Main'])
            })
        end
    },
    ["Power Bomb (lower Norfair above fire flea room)"] = {
        access_from = function()
            return has_access_to('Firefleas Top')
        end
    },
    ["Power Bomb (Power Bombs of shame)"] = {
        access_from = function()
            return wand({
                has_access_to('Ridley Zone'),
                can_use_power_bombs()
            })
        end,
        available = function()
            return can_hell_run(HELL_RUNS_TABLE['LowerNorfair']['Main'])
        end
    },
    ["Missile (lower Norfair near Wave Beam)"] = {
        access_from = function()
            return has_access_to('Firefleas')
        end,
        available = function()
            return wand({
                can_hell_run(HELL_RUNS_TABLE['LowerNorfair']['Main']),
                can_destroy_bomb_walls(),
                morph()
            })
        end
    },
    ["Missile (Wrecked Ship middle)"] = {
        access_from = function()
            return has_access_to('Wrecked Ship Main')
        end,
        available = function()
            return can_pass_bomb_passages()
        end
    },
    ["Missile (Gravity Suit)"] = {
        access_from = function()
            return has_access_to('Wrecked Ship Main')
        end,
        available = function()
            return wand({
                can_pass_bowling(),
                can_pass_bomb_passages()
            })
        end
    },
    ["Missile (Wrecked Ship top)"] = {
        access_from = function()
            return has_access_to('Wrecked Ship Main')
        end,
        available = function()
            return phantoon()
        end
    },
    ["Super Missile (Wrecked Ship left)"] = {
        access_from = function()
            return has_access_to('Wrecked Ship Main')
        end,
        available = function()
            return phantoon()
        end
    },
    ["Missile (green Maridia shinespark)"] = {
        access_from = function()
            return has_access_to('Main Street Bottom')
        end,
        available = function()
            return wand({
                gravity(),
                speed(),
                wor({
                    wand({
                        traverse('MainStreetBottomRight'),
                        wor({
                            has_patch(103),
                            super()
                        }),
                        item_count_ok('etank', 1)
                    }),
                    can_simple_short_charge()
                })
            })
        end
    },
    ["Super Missile (green Maridia)"] = {
        access_from = function()
            return wand({
                has_access_to('Main Street Bottom'),
                can_do_outer_maridia()
            })
        end,
        available = function()
            return morph()
        end
    },
    ["Missile (green Maridia tatori)"] = {
        access_from = function()
            return wor({
                wand({
                    has_access_to('Main Street Bottom'),
                    wand({
                        wor({
                            traverse('FishTankRight'),
                            has_patch(52)
                        }),
                        can_do_outer_maridia()
                    })
                }),
                has_access_to('Mama Turtle')
            })
        end
    },
    ["Super Missile (yellow Maridia)"] = {
        access_from = function()
            return has_access_to('Watering Hole Bottom')
        end
    },
    ["Missile (yellow Maridia super missile)"] = {
        access_from = function()
            return has_access_to('Watering Hole Bottom')
        end
    },
    ["Missile (yellow Maridia false wall)"] = {
        access_from = function()
            return has_access_to('Beach')
        end
    },
    ["Missile (left Maridia sand pit room)"] = {
        access_from = function()
            return wand({
                has_access_to('Left Sandpit'),
                can_climb_west_sand_hole()
            })
        end,
        available = function()
            return can_access_items_in_west_sand_hole()
        end
    },
    ["Missile (right Maridia sand pit room)"] = {
        access_from = function()
            return has_access_to('Right Sandpit')
        end,
        available = function()
            return wor({
                gravity(),
                wand({
                    hijump(),
                    knows('GravLessLevel3')
                })
            })
        end
    },
    ["Power Bomb (right Maridia sand pit room)"] = {
        access_from = function()
            return wand({
                has_access_to('Right Sandpit'),
                morph()
            })
        end,
        available = function()
            return wor({
                gravity(),
                wand({
                    knows('GravLessLevel3'),
                    hijump(),
                    can_spring_ball_jump()
                })
            })
        end
    },
    ["Missile (pink Maridia)"] = {
        access_from = function()
            return has_access_to('Aqueduct')
        end        
    },
    ["Super Missile (pink Maridia)"] = {
        access_from = function()
            return has_access_to('Aqueduct')
        end        
    },
    ["Missile (Draygon)"] = {
        access_from = function()
            return has_access_to('Precious Room Top')
        end 
    }

}

function get_access_to_loc(name)    
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOCATION then
        print(string.format("called get_access_to_loc: name: %s", name))
    end
    local loc = LOCATIONS[name]
    if loc == nil or type(loc) ~= "table" then
        if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOCATION then
            print(string.format("\tunknown location: %s", name))
        end
        return 0
    end
    if loc.access_from == nil then
        loc.access_from = function()
            return 1
        end
    end
    if loc.available == nil then
        loc.available = function()
            return 1
        end
    end
    if loc.post_available == nil then
        loc.post_available = function()
            return 1
        end
    end
    local value_access_from = loc.access_from()
    local value_available = loc.available()
    local value_post_available = loc.post_available()
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOCATION then
        if value_access_from == nil then
            print(string.format("\taccess_from has no return value: %s", name))      
        else
            print(string.format("\taccess_from: %s value: %s", string.dump(loc.access_from), value_access_from))
        end
        if value_available == nil then
            print(string.format("\tavailable has no return value: %s", name))      
        else
            print(string.format("\tavailable: %s value: %s", string.dump(loc.available), value_available))
        end
        if value_post_available == nil then
            print(string.format("\tpost_available has no return value: %s", name))      
        else
            print(string.format("\tpost_available: %s value: %s", string.dump(loc.post_available), value_post_available))
        end
    end
    local value = wand({
        value_access_from,
        value_available,
        value_post_available
    })
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_LOCATION then
        print(string.format("\tvalue: %s", value))
    end
    if value > 0 then
        return 1
    end
    return 0
end