-- layout.lua is useless anymore, use this

hl.config({
	general = {
		gaps_in = 4,
		gaps_out = 4,
		border_size = 2,
		resize_on_border = false,
	},
  decoration = {
    rounding = 12,
    blur = {
      enabled = true,
      size = 1,
      passes = 0,
      new_optimizations = true,
      ignore_opacity = true,
    },
  },
})

hl.layer_rule({
	match = { namespace = "^dms:bar$" },
	xray = true,
})
