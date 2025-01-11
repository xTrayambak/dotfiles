local wezterm = require('wezterm')
local config  = {}

-- config.font = wezterm.font('JetBrainsMono')
config.enable_wayland = true -- :rip:
config.tiling_desktop_environments = {
	'Wayland Hyprland'
}
config.max_fps = 144
config.animation_fps = 144
config.prefer_egl = true
config.window_background_opacity = 0.7007 
config.window_decorations = "NONE"
config.enable_tab_bar = false
config.window_close_confirmation = 'NeverPrompt'
config.cursor_blink_ease_in = 'EaseIn'
config.cursor_blink_ease_out = 'EaseOut'
config.default_cursor_style = 'BlinkingBar'

return config
