------------------
---- MONITORS ----
------------------

hl.monitor({
	output = "eDP-1",
	mode = "1920x1080@120.00",
	position = "auto",
	scale = "1",
})
hl.monitor({
	output = "DP-1",
	mode = "2560x1440@165.00",
	position = "auto",
	scale = "1",
})
hl.monitor({
	output = "HDMI-A-1",
	mode = "preferred",
	position = "auto-left",
	scale = "1",
	-- mirror = "DP-1",
	-- disabled = true,
})

---------------------
---- MY PROGRAMS ----
---------------------

local ipc = function(args) return "noctalia msg " .. args end

local terminal = "ghostty"
local file_manager = "dolphin"
local browser = "helium-browser"
local menu = "vicinae toggle || " .. ipc("panel-toggle launcher")
local emoji = "vicinae vicinae://launch/core/search-emojis || " .. ipc("panel-toggle launcher /emo")
local windows = "vicinae vicinae://launch/wm/switch-windows || " .. ipc("window-switcher")
local screenshot_area = ipc("screenshot-region") .. " || grimblast --freeze --notify copysave area $HOME/Pictures/Screenshots/\"$(date '+%FT%T.%N').png\""
local screenshot_screen = ipc("screenshot-fullscreen") .. " || grimblast --freeze --notify copysave output $HOME/Pictures/Screenshots/\"$(date '+%FT%T.%N').png\""

-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function()
	hl.exec_cmd("noctalia")
	hl.exec_cmd("/usr/lib/pam_kwallet_init")
	hl.exec_cmd("playerctld daemon")
	hl.exec_cmd("dolphin --daemon")
	hl.exec_cmd("kdeconnectd")
	hl.exec_cmd("xembedsniproxy")
	hl.exec_cmd("vicinae server")
	hl.exec_cmd("sleep 5s && bitwarden --silent")
	hl.exec_cmd("gsr-ui")
end)

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

hl.env("XCURSOR_SIZE", 40)
hl.env("HYPRCURSOR_SIZE", 40)
hl.env("XCURSOR_THEME", "BreezeX-RoséPine")
hl.env("HYPRCURSOR_THEME", "rose-pine-hyprcursor")
hl.env("XDG_MENU_PREFIX", "arch-")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", 1)

-----------------------
---- LOOK AND FEEL ----
-----------------------

hl.config({
	general = {
		border_size = 2,
		gaps_in = 3,
		gaps_out = 4,
		col = {
			active_border = { colors = { "rgb(cba6f7)", "rgb(f5c2e7)" }, angle = 90 },
			inactive_border = "rgb(45475a)",
		},
		no_focus_fallback = true,
		allow_tearing = true,
	},
	decoration = {
		rounding = 10,
		blur = { size = 3 },
		shadow = { enabled = false },
	},
	misc = {
		force_default_wallpaper = 0,
		middle_click_paste = false,
	},
	xwayland = {
		force_zero_scaling = true,
	},
	render = {
		direct_scanout = 2,
	},
})

hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })

hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows", enabled = true, speed = 4.79, bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 4.1, bezier = "easeOutQuint", style = "popin 87%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 1.49, bezier = "linear", style = "popin 87%" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade", enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers", enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 4, bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 1.5, bezier = "linear", style = "fade" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn", enabled = true, speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "zoomFactor", enabled = true, speed = 7, bezier = "quick" })

hl.config({
	dwindle = {
		preserve_split = true,
	},
})

---------------
---- INPUT ----
---------------

hl.config({
	input = {
		kb_layout = "us,ru",
		kb_options = "grp:win_space_toggle,ctrl:nocaps",
		touchpad = { natural_scroll = true },
		accel_profile = "flat",
	},
})
-- asus rog zephyrus touchpad
hl.device({
	name = "elan1201:00-04f3:3098-touchpad",
	accel_profile = "adaptive",
})

---------------------
---- KEYBINDINGS ----
---------------------
local mod = function(keys) return "SUPER + " .. keys end

hl.bind(mod("T"), hl.dsp.exec_cmd(terminal))
hl.bind(mod("B"), hl.dsp.exec_cmd(browser))
hl.bind(mod("Q"), hl.dsp.window.close())
hl.bind(mod("E"), hl.dsp.exec_cmd(file_manager))
hl.bind("ALT + SPACE", hl.dsp.exec_cmd(menu))
hl.bind(mod("SHIFT + E"), hl.dsp.exec_cmd(emoji))
hl.bind(mod("W"), hl.dsp.exec_cmd(windows))
hl.bind(mod("P"), hl.dsp.window.pin())
hl.bind(mod("F"), hl.dsp.window.fullscreen({ mode = "maximized" }))
hl.bind(mod("SHIFT + F"), hl.dsp.window.fullscreen({ mode = "fullscreen" }))
hl.bind(mod("SHIFT + V"), hl.dsp.window.float())
hl.bind(mod("ALT + V"), hl.dsp.window.cycle_next())
hl.bind(mod("CTRL + SHIFT + L"), hl.dsp.exec_cmd("loginctl lock-session"))
hl.bind(mod("A"), hl.dsp.exec_cmd("~/.local/bin/audio_changer.py"))
hl.bind(mod("N"), hl.dsp.exec_cmd(ipc("panel-toggle control-center notifications")))
hl.bind(mod("up"), hl.dsp.send_shortcut({ mods = "", key = "page_up" }))
hl.bind(mod("down"), hl.dsp.send_shortcut({ mods = "", key = "page_down" }))
hl.bind(mod("escape"), hl.dsp.exec_cmd("pkill noctalia && noctalia || noctalia"))
hl.bind(mod("grave"), hl.dsp.exec_cmd(ipc("window-switcher")))
hl.bind(mod("comma"), hl.dsp.exec_cmd(ipc("settings-toggle")))

-- move focus
hl.bind(mod("H"), hl.dsp.focus({ direction = "l" }))
hl.bind(mod("L"), hl.dsp.focus({ direction = "r" }))
hl.bind(mod("K"), hl.dsp.focus({ direction = "u" }))
hl.bind(mod("J"), hl.dsp.focus({ direction = "d" }))

-- swap windows
hl.bind(mod("SHIFT + H"), hl.dsp.window.swap({ direction = "l" }))
hl.bind(mod("SHIFT + L"), hl.dsp.window.swap({ direction = "r" }))
hl.bind(mod("SHIFT + K"), hl.dsp.window.swap({ direction = "u" }))
hl.bind(mod("SHIFT + J"), hl.dsp.window.swap({ direction = "d" }))

-- resize windows
hl.bind(mod("CTRL + H"), hl.dsp.window.resize({ x = -60, y = 0 }))
hl.bind(mod("CTRL + L"), hl.dsp.window.resize({ x = 60, y = 0 }))
hl.bind(mod("CTRL + K"), hl.dsp.window.resize({ x = 0, y = -60 }))
hl.bind(mod("CTRL + J"), hl.dsp.window.resize({ x = 0, y = 60 }))

-- switch workspaces with mainMod + [0-9]
hl.bind(mod("1"), hl.dsp.focus({ workspace = 1 }))
hl.bind(mod("2"), hl.dsp.focus({ workspace = 2 }))
hl.bind(mod("3"), hl.dsp.focus({ workspace = 3 }))
hl.bind(mod("4"), hl.dsp.focus({ workspace = 4 }))
hl.bind(mod("5"), hl.dsp.focus({ workspace = 5 }))
hl.bind(mod("6"), hl.dsp.focus({ workspace = 6 }))
hl.bind(mod("7"), hl.dsp.focus({ workspace = 7 }))
hl.bind(mod("8"), hl.dsp.focus({ workspace = 8 }))
hl.bind(mod("9"), hl.dsp.focus({ workspace = 9 }))
hl.bind(mod("0"), hl.dsp.focus({ workspace = 10 }))

-- move active window to a workspace with mainMod + SHIFT + [0-9]
hl.bind(mod("SHIFT + 1"), hl.dsp.window.move({ workspace = 1 }))
hl.bind(mod("SHIFT + 2"), hl.dsp.window.move({ workspace = 2 }))
hl.bind(mod("SHIFT + 3"), hl.dsp.window.move({ workspace = 3 }))
hl.bind(mod("SHIFT + 4"), hl.dsp.window.move({ workspace = 4 }))
hl.bind(mod("SHIFT + 5"), hl.dsp.window.move({ workspace = 5 }))
hl.bind(mod("SHIFT + 6"), hl.dsp.window.move({ workspace = 6 }))
hl.bind(mod("SHIFT + 7"), hl.dsp.window.move({ workspace = 7 }))
hl.bind(mod("SHIFT + 8"), hl.dsp.window.move({ workspace = 8 }))
hl.bind(mod("SHIFT + 9"), hl.dsp.window.move({ workspace = 9 }))
hl.bind(mod("SHIFT + 0"), hl.dsp.window.move({ workspace = 10 }))

-- scroll through existing workspaces with mainMod + scroll
hl.bind(mod("mouse_down"), hl.dsp.focus({ workspace = "+1" }))
hl.bind(mod("mouse_up"), hl.dsp.focus({ workspace = "-1" }))

-- move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mod("mouse:272"), hl.dsp.window.drag(), { mouse = true })
hl.bind(mod("mouse:273"), hl.dsp.window.resize(), { mouse = true })

hl.bind("Print", hl.dsp.exec_cmd(screenshot_area))
hl.bind("SHIFT + Print", hl.dsp.exec_cmd(screenshot_screen))
hl.bind("CTRL + SHIFT + Print", hl.dsp.exec_cmd(ipc("screenshot-annotate")))
hl.bind(mod("S"), hl.dsp.exec_cmd(screenshot_area))
hl.bind(mod("SHIFT + S"), hl.dsp.exec_cmd(screenshot_screen))

-- multimedia keys
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+"))
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%-"))
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"))
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"))
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd(ipc("media toggle")))
hl.bind("XF86AudioNext", hl.dsp.exec_cmd(ipc("media next")))
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd(ipc("media previous")))
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd(ipc("brightness-up")))
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd(ipc("brightness-down")))

-- switch to DP-1
hl.bind(mod("SHIFT + comma"), hl.dsp.exec_cmd("ddcutil -b 8 setvcp 60 0x0f"))
-- switch to HDMI-1
hl.bind(mod("SHIFT + period"), hl.dsp.exec_cmd("ddcutil -b 8 setvcp 60 0x11"))

-- clipboard
hl.bind(mod("V"), hl.dsp.exec_cmd("vicinae vicinae://launch/clipboard/history || " .. ipc("panel-toggle clipboard")))

-- discord mute
hl.bind(mod("M"), hl.dsp.send_shortcut({ mods = "CTRL SHIFT", key = "M", window = "class:^(discord)$" }))

-- gpu-screen-recorder-ui
hl.bind("ALT + Print", hl.dsp.exec_cmd("gsr-ui-cli replay-save"))

--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

hl.workspace_rule({ workspace = "1", persistent = true })
hl.workspace_rule({ workspace = "2", persistent = true })
hl.workspace_rule({ workspace = "3", persistent = true })
hl.workspace_rule({ workspace = "4", persistent = true })
hl.workspace_rule({ workspace = "5", persistent = true })
hl.workspace_rule({ workspace = "6", persistent = true })

-- gaming
hl.window_rule({ match = { class = "steam", title = "negative:Steam" }, float = true })
hl.window_rule({ match = { class = "steam_app_[0-9]+" }, content = "game", workspace = "6 silent" })
hl.window_rule({ match = { class = "cs2" }, content = "game", workspace = "6 silent" })
hl.window_rule({ match = { class = "Slay the Spire 2" }, content = "game", workspace = "6 silent" })
hl.window_rule({
	name = "games",
	match = { content = "game" },
	immediate = true,
	idle_inhibit = "always",
})

-- thunderbird float
hl.window_rule({
	match = { class = "org.mozilla.Thunderbird", initial_title = "negative:Mozilla Thunderbird" },
	float = true,
})

-- no screensharing for password managers
hl.window_rule({ match = { class = "^org\\.keepassxc\\.KeePassXC$" }, no_screen_share = true })
hl.window_rule({ match = { class = "^org\\.kde\\.kwalletmanager$" }, no_screen_share = true })
hl.window_rule({ match = { class = "^org\\.gnome\\.World\\.Secrets$" }, no_screen_share = true })
hl.window_rule({ match = { class = "^1Password$" }, no_screen_share = true })
hl.window_rule({ match = { class = "^Bitwarden$" }, no_screen_share = true })
hl.window_rule({ match = { title = "^Bitwarden$" }, no_screen_share = true })

hl.window_rule({
	name = "picture-in-picture",
	match = { title = "Picture(-| )in(-| )[Pp]icture" },
	float = true,
	keep_aspect_ratio = true,
	border_size = 1,
	pin = true,
})

hl.window_rule({
	name = "telegram-media-view",
	match = {
		class = "org.telegram.desktop",
		title = "Media viewer",
	},
	float = true,
	center = 1,
	maximize = true,
	idle_inhibit = "focus",
})

hl.layer_rule({
	name = "vicinae",
	match = { namespace = "vicinae" },
	blur = true,
	no_anim = true,
	ignore_alpha = 0,
})

hl.layer_rule({
	name = "noctalia",
	match = {
		namespace = "^noctalia-(bar-.+|notification|dock|panel)$",
	},
	ignore_alpha = 0.5,
	blur = true,
	blur_popups = true,
})
