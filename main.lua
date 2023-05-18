register_blueprint "level_cot"
{
	blueprint   = "level_base",
    text = {
		name  = "Purgatory",
    },
    level_info = {
        returnable = true,
        store      = true,
    },
	level_vo = {
		silly   = 0.0,
		serious = 1.0,
    },
    attributes = {
        spawn_bulk = 0.0,
    },
	callbacks = {
		on_create = [[
			function ( self )
				self.environment.lut   = math.random_pick( luts.standard )
				self.environment.music = "music_cot_01"
                local generate = function( self, params )
                    return cot.generate( self, params, 1678 )
                end
                local spawn = function( self )
                    return cot.spawn( self, 1678 )
                end
                generator.run( self, nil, generate, spawn )
			end
		]],
        on_enter_level = [[
            function ( self, player, reenter )
                ui:set_hint( " ", 666, 0, true )
                local curse   = player:child("cot_curse") or player:attach( "cot_curse" )
                local tick    = math.max( 2, ( DIFFICULTY * 2 ) - 1 )
                local current = curse.attributes.health_lost
                local hattr   = player.attributes.health
                if current < 80 and hattr > 20 then
                    curse.attributes.health_lost = current + tick
                    player.attributes.health     = hattr   - tick
                end
                curse.attributes.experience_mult = math.max( 1.0 - ( curse.attributes.health_lost * 0.02 ), 0.1 )
            end
        ]],
    }
}
