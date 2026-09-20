-- This is an example Hyprland Lua config file.
-- Refer to the wiki for more information.
-- https://wiki.hypr.land/Configuring/Start/

-- Please note not all available settings / options are set here.
-- For a full list, see the wiki

-- You can (and should!!) split this configuration into multiple files
-- Create your files separately and then require them like this:
-- require("myColors")


------------------
---- MONITORS ----
------------------

-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
hl.monitor({
  output   = "",
  mode     = "preferred",
  position = "auto",
  scale    = "auto",
})


---------------------
---- MY PROGRAMS ----
---------------------

-- Set programs that you use
local terminal    = "kitty"
local fileManager = "thunar"
local menu        = "~/.config/wofi/launch.sh"


-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

-- Autostart necessary processes (like notifications daemons, status bars, etc.)
-- Or execute your favorite apps at launch like this:
--
hl.on("hyprland.start", function()
  hl.exec_cmd("/usr/lib/polkit-kde-authentication-agent-1")
  hl.exec_cmd("hypridle")
  hl.exec_cmd("hyprsunset")
  hl.exec_cmd("hyprpaper")
  hl.exec_cmd("swaync")
  hl.exec_cmd("waybar")
  -- Mute the default microphone at session start.
  -- This is a preventive measure to avoid unintended audio capture.
  hl.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ 1")

  hl.exec_cmd("bluetoothctl power off")
end)


-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

-- Prefer Wayland-native backends so toolkits do not fall back to
-- XWayland. XWayland uses extra CPU (and therefore battery) because
-- every frame has to be translated.
hl.env("GDK_BACKEND", "wayland,x11,*")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("SDL_VIDEODRIVER", "wayland,x11")
hl.env("CLUTTER_BACKEND", "wayland")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")

-----------------------
----- PERMISSIONS -----
-----------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Permissions/
-- Please note permission changes here require a Hyprland restart and are not applied on-the-fly
-- for security reasons

-- hl.config({
--   ecosystem = {
--     enforce_permissions = true,
--   },
-- })

-- hl.permission("/usr/(bin|local/bin)/grim", "screencopy", "allow")
-- hl.permission("/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland", "screencopy", "allow")
-- hl.permission("/usr/(bin|local/bin)/hyprpm", "plugin", "allow")


-----------------------
---- LOOK AND FEEL ----
-----------------------

-- Refer to https://wiki.hypr.land/Configuring/Basics/Variables/
hl.config({
  general = {
    gaps_in          = 2,
    gaps_out         = 0,

    border_size      = 1,

    col              = {
      active_border = { colors = { "rgba(f5f5f5ff)", "rgba(999999ff)" }, angle = 45 },
      inactive_border = "rgba(595959aa)",
    },

    -- Set to true to enable resizing windows by clicking and dragging on borders and gaps
    resize_on_border = false,

    -- Please see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/ before you turn this on
    allow_tearing    = false,

    layout           = "master",
  },

  decoration = {
    rounding         = 4,
    rounding_power   = 3,

    -- Change transparency of focused and unfocused windows
    active_opacity   = 1.0,
    inactive_opacity = 1.0,

    -- Dimming inactive windows is pure extra GPU work.
    dim_inactive     = false,

    shadow           = {
      enabled = false,
    },

    blur             = {
      enabled = false,
    },
  },

  animations = {
    enabled = true,
  },
})

-- ─────────────────────────────────────────────────────────────
-- KINETIC PERSONALITIES — curves
-- Uwaga: Twoja wersja Hyprlanda wymaga `dampening` (nie `damping`).
-- ─────────────────────────────────────────────────────────────

hl.curve("confident", { type = "spring", mass = 1,   stiffness = 260, dampening = 32 })
hl.curve("playful",   { type = "spring", mass = 1,   stiffness = 180, dampening = 18 })
hl.curve("gliding",   { type = "spring", mass = 1,   stiffness = 110, dampening = 24 })
hl.curve("weighted",  { type = "spring", mass = 1.2, stiffness = 95,  dampening = 26 })
hl.curve("cinematic", { type = "spring", mass = 1,   stiffness = 70,  dampening = 20 })

hl.curve("crisp", { type = "bezier", points = { { 0.3, 0 }, { 0.15, 1 } } })
hl.curve("soft",  { type = "bezier", points = { { 0.4, 0 }, { 0.2,  1 } } })--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- Hide the border when there is only one window visible on a workspace.
-- Hyprland re-evaluates these selectors on every window open/close/move,
-- so the border appears again automatically when a second window shows up.
--
--   w[tv1] = workspace with exactly 1 tiled, visible window
--   f[1]   = workspace with exactly 1 floating window
--
-- Keeping `rounding = 4` means the single window still has soft corners;
-- only the 1 px outline disappears. If you want sharp corners too, add
-- `rounding = 0` to both rules.
hl.workspace_rule({
  workspace = "w[tv1]",
  gaps_in = 0,
  gaps_out = 0
})

hl.workspace_rule({
  workspace = "f[1]",
  gaps_in = 0,
  gaps_out = 0
})

hl.window_rule({
  name = "no-border-single-tiled",
  match = {
    float = false,
    workspace = "w[tv1]"
  },
  border_size = 0,
})

hl.window_rule({
  name = "no-border-single-floating",
  match = {
    float = false,
    workspace = "f[1]"
  },
  border_size = 0,
})

-- See https://wiki.hypr.land/Configuring/Layouts/Dwindle-Layout/ for more
hl.config({
  dwindle = {
    preserve_split = true, -- You probably want this
  },
})

-- See https://wiki.hypr.land/Configuring/Layouts/Master-Layout/ for more
hl.config({
  master = {
    new_status = "master",
  },
})

-- See https://wiki.hypr.land/Configuring/Layouts/Scrolling-Layout/ for more
hl.config({
  scrolling = {
    fullscreen_on_one_column = true,
  },
})

----------------
----  MISC  ----
----------------

hl.config({
  misc = {
    -- No anime wallpaper, no Hyprland logo, no splash text.
    force_default_wallpaper  = -1,
    disable_hyprland_logo    = true,
    disable_splash_rendering = true,

    -- VRR (Adaptive Sync). 0 = off, 1 = on, 2 = fullscreen only,
    -- 3 = fullscreen with video/game content type.
    -- "2" is a good battery compromise: panels stay at a low fixed
    -- refresh rate in normal use and only sync when it actually helps.
    vrr                      = 2,

    -- Cap the FPS of unfocused windows in the background. kitty
    -- already throttles its own repaints via repaint_delay, but
    -- this caps the compositor's cost for every background window.
    render_unfocused_fps     = 10,

    -- Wake monitors from DPMS on keyboard / mouse input.
    key_press_enables_dpms   = true,
    mouse_move_enables_dpms  = true,

    -- Keep autoreload on for convenience. Set to true if you would
    -- rather reload manually with `hyprctl reload` (saves a tiny
    -- amount of CPU by not watching files).
    disable_autoreload       = false,

    -- Do not auto-focus newly opened windows. Avoids spurious
    -- window switches and redraws when background apps pop up.
    focus_on_activate        = false,

    -- Close the special workspace if the last window is removed.
    close_special_on_empty   = true,
  },

  -- Xwayland: keep enabled for compatibility, but prefer nearest-
  -- neighbor scaling so legacy apps are not rendered blurry (which
  -- would cost extra GPU work).
  xwayland = {
    enabled              = true,
    use_nearest_neighbor = true,
  },

  -- Render tuning.
  render = {
    -- Direct scanout reduces lag and power for fullscreen apps
    -- (games, fullscreen video). 0 = off, 1 = on, 2 = auto.
    direct_scanout = 2,

    -- Color management stays on; disabling it is not worth the
    -- visual regressions.
    cm_enabled = true,
  },

  -- Debug: keep the efficient defaults but make them explicit.
  debug = {
    damage_tracking = 2,    -- full damage tracking (most efficient)
    vfr             = true, -- only render frames when there is damage
    disable_logs    = true, -- do not write logs (saves disk I/O)
    disable_time    = true,
  },

  -- Binds tuning.
  binds = {
    -- Wait 300 ms after a scroll event before allowing another.
    -- Slightly reduces CPU wakeups during fast scrolling.
    scroll_event_delay = 300,
  },
})

---------------
---- INPUT ----
---------------

hl.config({
  input = {
    kb_layout    = "pl",
    kb_variant   = "",
    kb_model     = "",
    kb_options   = "",
    kb_rules     = "",

    follow_mouse = 1,
    sensitivity  = 0,

    touchpad     = {
      -- Natural scroll is off in your original config; keep it.
      -- Consider `natural_scroll = true` if you prefer macOS-style
      -- scrolling — it does not affect battery.
      natural_scroll       = false,

      -- These are on by default but made explicit: they help avoid
      -- accidental input while typing (and therefore avoid waking
      -- the compositor unnecessarily).
      disable_while_typing = true,
      tap_to_click         = true,
    },
  },
})

hl.gesture({
  fingers = 3,
  direction = "horizontal",
  action = "workspace"
})

-- Example per-device config
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Devices/ for more
hl.device({
  name        = "epic-mouse-v1",
  sensitivity = -0.5,
})


---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER" -- Sets "Windows" key as main modifier

-- Example binds, see https://wiki.hypr.land/Configuring/Basics/Binds/ for more
-- Terminal: SUPER + T (Terminal)
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd(terminal))
hl.bind("CTRL + ALT + T", hl.dsp.exec_cmd(terminal)) -- fallback

-- File manager: SUPER + E (Explorer)
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))

-- Application launcher: SUPER + R (Run)
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + SHIFT + R", hl.dsp.exec_cmd("~/.config/wofi/launch_duckduckgo.sh"))

-- Screen lock: SUPER + L (Lock)
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("hyprlock"))

-- Turn off monitors (DPMS) - SUPER + ALT + L (lock + screen off)
-- hl.bind(mainMod .. " + ALT + L", hl.dsp.dpms({ state = "off" }))

-- Close window: SUPER + Q (Quit)
hl.bind(mainMod .. " + Q", hl.dsp.window.close())

-- Exit session / shutdown: SUPER + ALT + DELETE (rarely used)
hl.bind(mainMod .. " + ALT + DELETE",
  hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))

-- Toggle floating mode: SUPER + F (Float)
hl.bind(mainMod .. " + F", hl.dsp.window.float({ action = "toggle" }))

-- Toggle pseudo mode (for dwindle): SUPER + P (Pseudo)
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())

-- Toggle split layout: SUPER + J (adjacent to H/J – Vim‑like navigation)
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))

-- Reload Waybar: SUPER + B (Bar)
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("pkill -SIGUSR1 waybar"))

-- Notification center: SUPER + N (Notifications)
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd("swaync-client -t"))

-- =============================================
-- Screenshots
-- =============================================
hl.bind(mainMod .. " + PRINT", hl.dsp.exec_cmd("~/.local/bin/screenshot full"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd("~/.local/bin/screenshot area"))   -- Selection
hl.bind(mainMod .. " + SHIFT + W", hl.dsp.exec_cmd("~/.local/bin/screenshot window")) -- Window

-- =============================================
-- Hyprpicker – two color‑picking modes
-- =============================================
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.exec_cmd("hyprpicker -a")) -- HEX format
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.exec_cmd("hyprpicker -a -f rgb"))   -- RGB format

-- Toggle between Dwindle and Master: SUPER + ALT + L
hl.bind(mainMod .. " + ALT + L", function()
  local current_layout = hl.get_config("general.layout")
  if current_layout == "dwindle" then
    hl.config({ general = { layout = "master" } })
  else
    hl.config({ general = { layout = "dwindle" } })
  end
end)

-- =============================================
-- Window / workspace navigation
-- =============================================

-- Toggle fullscreen (maximized, without gaps) – SUPER + SHIFT + F
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.fullscreen({ internal = 1, client = 1 }))

-- Resize active window with keyboard (SUPER + CTRL + arrows)
hl.bind(mainMod .. " + CTRL + right", hl.dsp.window.resize({ x = 10, y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + CTRL + left", hl.dsp.window.resize({ x = -10, y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + CTRL + down", hl.dsp.window.resize({ x = 0, y = 10, relative = true }), { repeating = true })
hl.bind(mainMod .. " + CTRL + up", hl.dsp.window.resize({ x = 0, y = -10, relative = true }), { repeating = true })

-- Drag / resize windows with SUPER + LMB/RMB
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Sticky window (visible on all workspaces) – SUPER + SHIFT + P
hl.bind(mainMod .. " + SHIFT + P", hl.dsp.window.pin())

-- Move focus with arrow keys: SUPER + arrows
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

-- Swap windows in tiled layout (SUPER + SHIFT + arrows)
hl.bind(mainMod .. " + SHIFT + left", hl.dsp.window.swap({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.swap({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + up", hl.dsp.window.swap({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + down", hl.dsp.window.swap({ direction = "down" }))

-- Switch workspaces: SUPER + [0-9]
-- Move active window to workspace: SUPER + SHIFT + [0-9]
for i = 1, 10 do
  local key = i % 10 -- maps 10 to 0
  hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
  hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Special workspace (scratchpad): SUPER + M (Magic)
hl.bind(mainMod .. " + M", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + M", hl.dsp.window.move({ workspace = "special:magic" }))

-- Quick switch to previous workspace (ALT+TAB style) – SUPER + TAB
hl.bind(mainMod .. " + TAB", hl.dsp.focus({ workspace = "previous" }))

-- Move window to previous workspace – SUPER + SHIFT + TAB
hl.bind(mainMod .. " + SHIFT + TAB", hl.dsp.window.move({ workspace = "previous" }))

-- Scroll through workspaces with SUPER + mouse wheel
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
  { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
  { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
  { locked = true, repeating = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -n2 set 5%-"), { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

-- Example window rules that are useful

local suppressMaximizeRule = hl.window_rule({
  -- Ignore maximize requests from all apps. You'll probably like this.
  name           = "suppress-maximize-events",
  match          = { class = ".*" },

  suppress_event = "maximize",
})
-- suppressMaximizeRule:set_enabled(false)

hl.window_rule({
  -- Fix some dragging issues with XWayland
  name     = "fix-xwayland-drags",
  match    = {
    class      = "^$",
    title      = "^$",
    xwayland   = true,
    float      = true,
    fullscreen = false,
    pin        = false,
  },

  no_focus = true,
})

-- Layer rules also return a handle.
-- local overlayLayerRule = hl.layer_rule({
--     name  = "no-anim-overlay",
--     match = { namespace = "^my-overlay$" },
--     no_anim = true,
-- })
-- overlayLayerRule:set_enabled(false)

-- Hyprland-run windowrule
hl.window_rule({
  name  = "move-hyprland-run",
  match = { class = "hyprland-run" },

  move  = "20 monitor_h-120",
  float = true,
})

hl.window_rule({
  match     = { class = "wofi" },
  animation = "fadeIn 80ms easeOutQuint, fadeOut 80ms easeOutQuint",
  rounding  = 12,
  float     = true,
  center    = true,
})
