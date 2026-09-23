-- Programs
Terminal = "kitty"
FileManager = "nautilus"
Menu = "fuzzel"
KillMenu = "pkill fuzzel"
Browser = "brave-browser"

-- Key binds
MainMod = "SUPER"
hl.bind(MainMod .. " + Q", hl.dsp.exec_cmd(Terminal), { description = "Launch a terminal (" .. Terminal .. ")" })
hl.bind(MainMod .. " + C", hl.dsp.window.kill(), { description = "Kill the process of the active window" })
hl.bind(MainMod .. " + M", hl.dsp.exit(), { description = "Exit Hyprland" })
hl.bind(MainMod .. " + E", hl.dsp.exec_cmd(FileManager),
  { description = "Launch a file browser (" .. FileManager .. ")" })
hl.bind(MainMod .. " + V", hl.dsp.window.float({ action = "toggle" }), { description = "Toggle window float" })
for _, key in pairs({ "D", "SUPER_L", "SUPER_R" }) do
  hl.bind(MainMod .. " + " .. key, hl.dsp.exec_cmd(KillMenu .. " || " .. Menu),
    { description = "Toggle the app launcher (" .. Menu .. ")" })
end
hl.bind(MainMod .. " + P", hl.dsp.window.pseudo({ action = "toggle" }),
  { description = "Toggle the window's pseudotiling state" })
hl.bind(MainMod .. " + J", hl.dsp.layout("togglesplit"), { description = "Toggle split" })
hl.bind(MainMod .. " + slash", hl.dsp.exec_cmd(Browser), { description = "Launch a web browser (" .. Browser .. ")" })

VimDirections = { left = "H", right = "L", up = "K", down = "J" }
for dir, key in pairs(VimDirections) do
  -- Focus window
  hl.bind(MainMod .. " + " .. key, hl.dsp.focus({ direction = dir }), { description = "Focus " .. dir })
  hl.bind(MainMod .. " + " .. dir, hl.dsp.focus({ direction = dir }), { description = "Focus " .. dir })

  -- Move window
  hl.bind(MainMod .. " + SHIFT + " .. dir, hl.dsp.window.move({ direction = dir }),
    { description = "Move window " .. dir })
  hl.bind(MainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ direction = dir }),
    { description = "Move window " .. dir })
end

Workspaces = { "1", "2", "3", "4", "5", "6", "7", "8", "9", "0" }
for i, key in pairs(Workspaces) do
  hl.bind(MainMod .. " + " .. key, hl.dsp.focus({ workspace = i }),
    { description = "Focus workspace " .. i })
  hl.bind(MainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }),
    { description = "Move window to workspace " .. i })
end

hl.bind(MainMod .. " + S", hl.dsp.workspace.toggle_special("magic"),
  { description = "Toggle special workspace" })
hl.bind(MainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }),
  { description = "Move window to special workspace" })

hl.bind(MainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true, description = "Drag window" })
hl.bind(MainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true, description = "Resize window" })

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"),
  { description = "Increase volume by %5%" })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
  { description = "Decrease volume by %5%" })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
  { description = "Toggle mute" })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
  { description = "Toggle microphone mute" })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl s 10%+"),
  { description = "Increase screen brightness by 10%" })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl s 10%-"),
  { description = "Decrease screen brightness by 10%" })

-- Displays
hl.monitor({ output = "eDP-2", mode = "highres", position = "auto", scale = 1.0 }) -- Framework 16
hl.monitor({ output = "eDP-1", mode = "highres", position = "auto", scale = 1.8 }) -- MBP
hl.monitor({ output = "desc:Panasonic Industry Company PanasonicTV0 0x01010101", mode = "highres", position = "auto-left", scale = 1.0 })
hl.monitor({ output = "desc:BNQ BenQ EW3270U C1K01981019", mode = "highres", position = "auto-up", scale = 1.0, transform = 2 })
hl.monitor({ output = "", mode = "preferred", position = "auto", scale = "auto" })

-- Autostart
hl.exec_cmd("mako")                                       -- notification center
hl.exec_cmd("systemctl --user start plasma-polkit-agent") -- authentication agent
hl.exec_cmd("killall waybar; waybar")                     -- task bar
hl.exec_cmd("hypridle")                                   -- screen lock and fade
hl.exec_cmd("nm-applet")                                  -- taskbar applet for wifi

-- Env
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

-- Config
hl.config({
  debug = {
    disable_logs = true,
  },
  general = {
    gaps_in = 2,
    gaps_out = 0,

    border_size = 2,

    col = {
      active_border = { colors = { "rgba(33ccffee)", "rgba(00ff99ee)" }, angle = 45.0 },
      inactive_border = "rgba(595959aa)",
    },
    resize_on_border = true,
    allow_tearing = false,
    layout = "dwindle",
  },
  decoration = {
    rounding = 6,
    active_opacity = 1.0,
    inactive_opacity = 1.0,
    blur = {
      enabled = true,
      size = 3,
      passes = 1,
      vibrancy = 0.1696,
    },
  },
  gestures = {
    workspace_swipe_cancel_ratio = 0.3,
  },
  dwindle = {
    preserve_split = true,
  },
  master = {
    new_status = "master"
  },
  misc = {
    force_default_wallpaper = 0, -- 2=enable
    disable_hyprland_logo = false,
  },
  input = {
    kb_layout = "us",
    kb_options = "ctrl:swapcaps",
    follow_mouse = 1,
    sensitivity = 0.0, -- -1.0 - 1.0, 0 means no modification
    natural_scroll = true,
    touchpad = {
      natural_scroll = true,
      clickfinger_behavior = true, -- enable 2-finger right click instead of bottom-right right click
      tap_to_click = false,
    },
  },
})

-- Animations
hl.curve("rubber", { type = "spring", mass = 1, stiffness = 150, dampening = 17 })
hl.animation({ leaf = "windows", enabled = true, speed = 15.0, spring = "rubber", style = "popin 80%" })
-- hl.animation({ leaf = "windowsOut", enabled = true, speed = 7.0, spring = "rubber", style = "popin 80%" })
hl.animation({ leaf = "border", enabled = true, speed = 10.0, spring = "rubber" })
hl.animation({ leaf = "borderangle", enabled = true, speed = 8.0, spring = "rubber" })
hl.animation({ leaf = "fade", enabled = true, speed = 7.0, spring = "rubber" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 10.0, spring = "rubber" })

-- Gesture
hl.gesture({ fingers = 3, direction = "horizontal", scale = 1.5, action = "workspace" })

-- Disable maximize so that apps don't automatically try to take over the screen and glitch (I think).
hl.window_rule({ match = { class = ".*" }, suppress_event = "maximize" })
