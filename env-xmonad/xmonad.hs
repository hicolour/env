-- Import ----------------------------------------------------------------------

import XMonad

import Data.Monoid

import System.Exit
import System.IO


import qualified XMonad.StackSet as W -- keyboard bindings
import qualified Data.Map        as M -- mouse bindings

import Control.Monad (liftM2)

-- hooks --
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.UrgencyHook

import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.InsertPosition
import XMonad.Hooks.EwmhDesktops

import XMonad.Hooks.SetWMName

--import XMonad.Hooks.ICCMFocus
import XMonad.Hooks.ICCCMFocus

-- util --
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.NamedScratchpad


-- layout --
import XMonad.Layout.ToggleLayouts
import XMonad.Layout.WindowNavigation
import XMonad.Layout.ResizableTile

import XMonad.Layout.NoBorders
import XMonad.Layout.Renamed
import XMonad.Layout.Reflect
import XMonad.Layout.Grid
import XMonad.Layout.IM
import XMonad.Layout.PerWorkspace (onWorkspace)


-- 
--
--
-- quick config:
-- ┌─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┲━━━━━━━━━━┓
-- │  w1 │  w2 │  w3 │  w4 │  w5 │  w6 │  w7 │  w8 │  w9 │  w10│  w11│  w12│  w13┃          ┃
-- │ `   │ 1   │ 2   │ 3   │ 4   │ 5   │ 6   │ 7   │ 8   │ 9   │ 0   │ -   │ =   ┃ ⌫        ┃
-- ┢━━━━━┷━━┱──┴──┬──┴──┬──┴──┬──┴──┬──┴──┬──┴──┬──┴──┬──┴──┬──┴──┬──┴──┬──┴──┬──┺━━┯━━━━━━━┩
-- ┃        ┃close│     │     │     │     │     │     │     │     │dmenu│     │ }   │ |     │
-- ┃ ↹      ┃ q   │ w   │ e   │ r   │ t   │ y   │ u   │ i   │ o   │ p   │ [   │ ]   │ \     │
-- ┣━━━━━━━━┻┱────┴┬────┴┬────┴┬────┴┬────┴┬────┴┬────┴┬────┴┬────┴┬────┴┬────┴┲━━━━┷━━━━━━━┪
-- ┃         ┃     │     │     │ full│     │     │     │     │     │     │     ┃ terminal   ┃
-- ┃ ⇬       ┃ a   │ s   │ d   │ f   │ g   │ h   │ j   │ k   │ l   │ ;   │ '   ┃ ⏎          ┃
-- ┣━━━━━━━━━┻━━┱──┴──┬──┴──┬──┴──┬──┴──┬──┴──┬──┴──┬──┴──┬──┴──┬──┴──┬──┴──┲━━┻━━━━━━━━━━━━┫       ┌─────┐
-- ┃            ┃     │     │     │     │ subl│     │     │     │     │     ┃               ┃       │     │
-- ┃ ⇧          ┃ z   │ x   │ c   │ v   │ b   │ n   │ m   │ ,   │ .   │ /   ┃ ⇧             ┃       │ ↑   │
-- ┣━━━━━━━┳━━━━┻━━┳━━┷━━━━┱┴─────┴─────┴─────┴─────┴─────┴─┲━━━┷━━━┳━┷━━━━━╋━━━━━━━┳━━━━━━━┫ ┌─────┼─────┼─────┐
-- ┃       ┃ *mod* ┃       ┃         layout                 ┃       ┃       ┃       ┃       ┃ │     │     │     │
-- ┃ Ctrl  ┃ super ┃ Alt   ┃ Space                          ┃ AltGr ┃ super ┃ menu  ┃ Ctrl  ┃
-- ┗━━━━━━━┻━━━━━━━┻━━━━━━━┹────────────────────────────────┺━━━━━━━┻━━━━━━━┻━━━━━━━┻━━━━━━━┛
--
 --      ┌─────┐
 --      │     │
 --      │ ↑   │
 -- ┌─────┼─────┼─────┐
 -- │     │     │     │
 -- │ ←   │ ↓   │ →   │
 -- └─────┴─────┴─────┘




-- Main ------------------------------------------------------------------------

main = do


  myDzenMonitoring_ <- spawnPipe myDzenMonitoring
  myDzenXmonad_     <- spawnPipe myDzenXmonad

  xmonad $ withUrgencyHook NoUrgencyHook $ ewmh defaultConfig {

    -- simple stuff
    terminal           = myTerminal,
    focusFollowsMouse  = myFocusFollowsMouse,
    borderWidth        = myBorderWidth,
    modMask            = myModMask,
    workspaces         = myWorkspaces,
    normalBorderColor  = myNormalBorderColor,
    focusedBorderColor = myFocusedBorderColor,

    -- key bindings
    keys               = myKeys,
    mouseBindings      = myMouseBindings,

    --hooks, layouts
    layoutHook         = myLayout,
    manageHook         = myManageHook,
    handleEventHook    = myEventHook,
    logHook            = takeTopFocus >> myLogHook myDzenXmonad_,
    --logHook            = takeTopFocus,
    startupHook      = myStartupHook
  }

myTerminal          = "roxterm"
myFocusFollowsMouse = True
myBorderWidth       = 1
myModMask           = mod4Mask

myNormalBorderColor  = "#111111"
myFocusedBorderColor = "#5a676b"
--myNormalBorderColor  = "#111111"
--myFocusedBorderColor = "#353b3e"



myWorkspaces= ["~:","1:t","2:t","3:w","4:w","5:n","6:i","7:i","8:im","9:tw","0:n","-:m","=:n"]

-- Layouts ---------------------------------------------------------------------

myLayout = windowNavigation $
           avoidStruts $
           smartBorders $
           full $
           onWorkspace "dev"  (gtile ||| grid ||| tile ||| mtile) $
           onWorkspace "8:im"   im $
           onWorkspace "serv" (grid ||| tile) $
           tile ||| mtile ||| grid

  where
  rt    = ResizableTall 1 (2/100) (1/2) []

  grt   = ResizableTall 1 (2/100) goldenratio []
  goldenratio  = 2/(1+(toRational(sqrt(5)::Double)))


  tile    = renamed [Replace "t" ] $ rt
  mtile   = renamed [Replace "mt"] $ Mirror rt

  gtile   = renamed [Replace "gt"] $ grt


  --grid    = renamed [Replace "g" ] $ spacing 2 $ smartBorders Grid
  grid    = renamed [Replace "g" ] $ Grid

  full    = toggleLayouts (renamed [Replace "f" ] $ noBorders Full)

  skypeRoster     = (ClassName "Skype") `And` (Not (Title "Options")) `And` (Not (Role "ConversationsWindow")) `And` (Not (Role "CallWindowForm"))

  pidginRoster     = (ClassName "Pidgin") `And` (Not (Title "Options")) `And` (Not (Role "ConversationsWindow")) `And` (Not (Role "CallWindowForm"))

  hototRoster     = (ClassName "Hotot") 


  im = renamed [Replace "im" ] $ withIM (0.18) skypeRoster $ withIM (0.18) pidginRoster $
                                 reflectHoriz $
                                 withIM (0.25) (ClassName "Mumble") grid


-- Window Management -----------------------------------------------------------

myManageHook = (composeAll . concat $
  [
    [resource  =? r --> doIgnore              | r <- myIgnores    ]
  , [className =? c --> viewShift "8:im"      | c <- myIm         ]
  , [className =? c --> viewShift "9:tw"      | c <- myTwitt      ]
  , [className =? c --> viewShift "5:n"      | c <- myNote      ]



  --, [className =? c --> viewShift "gfx"     | c <- myGfxs       ]
  --, [className =? c --> viewShift "6:d-ide" | c <- myDevIde     ]
  --, [className =? c --> viewShift "9:tw"    | c <- myTwitt       ]
 -- , [className =? c --> doShift "3:www"    | c <- myWww       ]
  --, [role      =? r --> doShift   "serv"    | r <- myServ       ]
  --, [role      =? r --> doShift   "gen"     | r <- myGen        ]
  --, [role      =? r --> doShift   "fs"      | r <- myFs         ]


  , [name      =? n --> doCenterFloat      | n <- myNames      ]
  , [className =? c --> doCenterFloat      | c <- myFloats     ]
  , [className =? c --> doFullFloat        | c <- myFullFloats ]

  , [isDialog       --> doFocusCenterFloat                     ]
  , [isFullscreen   --> doFullFloat                            ]

  , [insertPosition Below Newer                                ]
  ])

  <+> namedScratchpadManageHook scratchpads

  where
  viewShift = doF . liftM2 (.) W.greedyView W.shift

  role = stringProperty "WM_WINDOW_ROLE"
  name = stringProperty "WM_NAME"

  doFocusCenterFloat = doF W.shiftMaster <+> doF W.swapDown <+> doCenterFloat

  doFocusFullFloat   = doFullFloat

  -- classnames
  myFloats      = ["MPlayer", "Vlc", "Smplayer", "Lxappearance", "XFontSel"]
  myFullFloats  = ["feh", "Mirage", "Zathura", "Mcomix"]
  myIm          = ["Pidgin", "Mumble", "Skype"]
  myTwitt       = ["Hotot-gtk3"]
  myGfxs        = ["Inkscape", "Gimp"]

  -- Gerally IntelliJ
  myDevIde      = ["sun-awt-X11-XFramePeer,", "jetbrains-idea-ce"]

  -- Sublime text
  myNote        = ["sublime-text"]

  -- Chrome
  --myWww         = ["Google-chrome"]

  -- roles
  myServ        = ["rails_dobroserver", "rails_fitlog", "rails_mili"]
  myGen         = ["roxterm_startup"]
  myFs          = ["ranger_startup"]

  -- resources
  myIgnores = ["desktop", "desktop_window"]

  -- names
  myNames   = ["Google Chrome Options", "Chromium Options", "Firefox Preferences"]


-- Event handling --------------------------------------------------------------

myEventHook = mempty

-- Status bars and logging -----------------------------------------------------

myLogHook h = dynamicLogWithPP $ myDzenPP { ppOutput = hPutStrLn h }



-- b8a761

--  { ppCurrent          = wrap "^fg(#72aca9)[^fg(#d3d0c8)" "^fg(#72aca9)]"
--   , ppLayout           = wrap "^fg(#72aca9)[^fg(#72aca9)" "^fg(#72aca9)]"

myDzenPP = dzenPP
  { ppCurrent          = wrap "^fg(#c4a000)[^fg(#b8a761)" "^fg(#c4a000)]"
  , ppHidden           = wrap " ^fg(#d3d0c8)" " "
  , ppHiddenNoWindows  = wrap " ^fg(#747369)" " "
  , ppUrgent           = wrap "^fg(#8ab3b5)[^fg(#cdc5b3)" "^fg(#8ab3b5)]"

  , ppSep              = "  "
  , ppLayout           = wrap "^fg(#775681)[^fg(#8e5276)" "^fg(#775681)]"
  , ppTitle            = (" " ++) . dzenColor "#5b709b" "" . dzenEscape
  , ppSort             = fmap (.namedScratchpadFilterOutWorkspace) $ ppSort defaultPP
  }


--myDzenXmonad="dzen2 -y 1030 -x 0 -w 1280 -ta l " ++ myDzenStyle
myDzenXmonad="dzen2 -y 0 -x 0 -w 800 -ta l " ++ myDzenStyle

myDzenMonitoring="~/.dzen/dzen_xmonad.sh"

-- Dzen helpers
myDzenStyle = "-fg '" ++ myFgColor ++
              "' -bg '" ++ myBgColor ++
              "' -fn '" ++ myFont ++
              "' -h 20"

myFgColor = "#d3d0c8"
--myBgColor = "#0f0f0f"
myBgColor = "#1B1B1B"

myFocusedFGColor = "#8ab1c1"
myAlertColor = "#934a5a"

myColorH  = "#999999"
myColorHN = "#686868"

--myFont = "Terminus"
--myFont = "-*-terminus-medium-*-*-*-14-*-*-*-*-*-iso10646-*"
-- myFont = "misc-ohsnap-medium-r-normal--12-87-100-100-c-70-iso8859-1"
--myFont = "-xos4-terminus-medium-r-normal--12-120-72-72-c-60-iso8859-1"
--myFont = "-*-envypn-medium-*-*--13-*-*-*-*-*-*-1"
myFont = "-*-envypn-medium-*-*--14-*-*-*-*-*-*-1"

-- Startup hook ----------------------------------------------------------------
-- Fix for Java GUI
myStartupHook = setWMName "LG3D"

-- Scratchpads -----------------------------------------------------------------

scratchpads = [
                     -- RationalRect left top width height

  NS "terminal" "roxterm --role scratchpad"
    (role =? "scratchpad")
    (customFloating $ W.RationalRect 0.15 0.6 0.7 0.35),

  NS "notes" "gvim --role notes ~/notes/org.txt"
    (role =? "notes")
    nonFloating,

  -- NS "keepassx" "keepassx"
  --   (className =? "Keepassx")
  --   (customFloating $ W.RationalRect 0.15 0.1 0.7 0.4),

  NS "htop" "roxterm --role htop -e htop"
    (role =? "htop")
    (customFloating $ W.RationalRect 0.15 0.2 0.7 0.7),

  NS "wicd-curses" "roxterm --role wicd-curses -e wicd-curses"
    (role =? "wicd-curses")
    (customFloating $ W.RationalRect 0.15 0.2 0.7 0.7),

  NS "ncmpcpp" "roxterm --role ncmpcpp -e ncmpcpp"
    (role =? "ncmpcpp")
    (customFloating $ W.RationalRect 0.15 0.2 0.7 0.7),

  NS "spacefm" "spacefm"
    (className =? "Spacefm")
    nonFloating,

  NS "ranger" "roxterm --role ranger -e ranger"
    (role =? "ranger")
    nonFloating

  ]
  where role = stringProperty "WM_WINDOW_ROLE"

-- Bindings --------------------------------------------------------------------

myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

  [ ((modm,                 xK_Return), spawn $ XMonad.terminal conf) -- launch a terminal
  , ((modm,                 xK_c     ), spawn "google-chrome-stable")
  , ((modm,                 xK_b     ), spawn "subl")
  , ((modm,                 xK_o     ), spawn "dmenu_run -nb '#242424' -nf '#ccc' -sb '#909090'")
  --, ((modm,		              xK_p     ), spawn "dmenu_run -nb '#0f0f0f' -fn '-xos4-terminus-medium-r-normal--12-120-72-72-c-60-iso8859-1'") 
  , ((modm,                 xK_p     ), spawn "dmenu_run -fn '-*-envypn-medium-*-*--15-*-*-*-*-*-*-1' -nb '#1B1B1B' -nf '#ccc' -sb '#909090' -sf '#111'") 
  , ((modm,                 xK_q     ), kill) -- close focused window
  , ((modm,                 xK_space ), sendMessage NextLayout)  -- Rotate through the available layout algorithms
  , ((modm .|. shiftMask,   xK_space ), setLayout $ XMonad.layoutHook conf) --  Reset the layouts on the current workspace to default
  , ((modm,                 xK_n     ), refresh) -- Resize viewed windows to the correct size

  , ((modm,                 xK_t     ), withFocused $ windows . W.sink) -- Push window back into tiling

  , ((modm .|. shiftMask,   xK_comma ), sendMessage (IncMasterN 1)) -- Increment the number of windows in the master area
  , ((modm .|. shiftMask,   xK_period), sendMessage (IncMasterN (-1))) -- Deincrement the number of windows in the master area

  -- power
  , ((modm .|. controlMask, xK_r     ), spawn "~/scripts/close_all.sh && sleep 3 && systemctl reboot")
  , ((modm .|. controlMask, xK_h     ), spawn "~/scripts/close_all.sh && sleep 3 && systemctl poweroff")

  -- bookmarks
  , ((mod1Mask,   xK_m  ), spawn "xdg-open https://mail.google.com/")
  , ((mod1Mask,   xK_r  ), spawn "xdg-open http://www.google.com/reader/view/")

  -- resizing
  , ((modm .|. shiftMask,   xK_Left  ), sendMessage Shrink)
  , ((modm .|. shiftMask,   xK_Right ), sendMessage Expand)
  , ((modm .|. shiftMask,   xK_Down  ), sendMessage MirrorShrink)
  , ((modm .|. shiftMask,   xK_Up    ), sendMessage MirrorExpand)

  -- navigation
  , ((modm,                 xK_Right ), sendMessage $ Go R)
  , ((modm,                 xK_Left  ), sendMessage $ Go L)
  , ((modm,                 xK_Up    ), sendMessage $ Go U)
  , ((modm,                 xK_Down  ), sendMessage $ Go D)
  , ((modm .|. controlMask, xK_Right ), sendMessage $ Swap R)
  , ((modm .|. controlMask, xK_Left  ), sendMessage $ Swap L)
  , ((modm .|. controlMask, xK_Up    ), sendMessage $ Swap U)
  , ((modm .|. controlMask, xK_Down  ), sendMessage $ Swap D)

     --take a screenshot of entire display 
   , ((modm, xK_F9), spawn "scrot 'screen_%Y-%m-%d-%H-%M-%S.png' -d 1")

   --take a screenshot of focused window 
   , ((modm, xK_F10), spawn "scrot 'window_%Y-%m-%d-%H-%M-%S.png' -d 1-u")

  -- custom
  , ((modm, xK_f), sendMessage ToggleLayout)

  , ((modm, xK_F1 ), namedScratchpadAction scratchpads "terminal")
  , ((modm, xK_F2 ), namedScratchpadAction scratchpads "htop")
  , ((modm, xK_F3 ), namedScratchpadAction scratchpads "wicd-curses")
  , ((modm, xK_F4 ), namedScratchpadAction scratchpads "alsamixer")


  --, ((modm, xK_r), namedScratchpadAction scratchpads "ranger")
  , ((modm, xK_s), namedScratchpadAction scratchpads "spacefm")

  , ((0,    xK_Print), spawn "scrot")
  , ((modm, xK_Print), spawn "scrot -d 3")

  -- XF86AudioLowerVolume
  , ((0, 0x1008ff11), spawn "amixer -q set Master 1%-")
  -- XF86AudioRaiseVolume
  , ((0, 0x1008ff13), spawn "amixer -q set Master 1%+")

  , ((modm, xK_comma),  spawn  "ncmpcpp prev"  )
  , ((modm, xK_period), spawn  "ncmpcpp next"  )
  , ((modm, xK_slash),  spawn  "ncmpcpp toggle")

  -- XF86AudioMute
  --, ((0            , 0x1008ff12), spawn "amixer -q set Master toggle")
  -- XF86AudioNext
  --, ((0            , 0x1008ff17), spawn "mocp -f")
  -- XF86AudioPrev
  --, ((0            , 0x1008ff16), spawn "mocp -r")
  -- XF86AudioPlayic
  --, ((0            , 0x1008ff14), spawn "mocp -G")

  , ((modm .|. shiftMask,   xK_q     ), io (exitWith ExitSuccess)) -- Quit xmonad

  , ((modm .|. controlMask, xK_q     ), spawn "killall dzen2 && xmonad --recompile && xmonad --restart") -- Restart xmonad
  ]


  ++

  -- mod-[1..9], Switch to workspace N
  -- mod-shift-[1..9], Move client to workspace N
  --
  --[((m .|. modm, k), windows $ f i)
  --    | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
  --    , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]!!

  [((m .|. modm, k), windows $ f i)
           | (i, k) <- zip myWorkspaces [xK_quoteleft,xK_1,xK_2,xK_3,xK_4,xK_5,xK_6,xK_7,xK_8,xK_9,xK_0,xK_minus,xK_equal]
         , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]
  ++

  --
  -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
  -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
  --
  [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
      | (key, sc) <- zip [xK_Insert, xK_End, xK_r] [0..]
      , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]

-- Mouse bindings: default actions bound to mouse events -----------------------

myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $

  -- mod-button1, Set the window to floating mode and move by dragging
  [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w
                                     >> windows W.shiftMaster))

  -- mod-button2, Raise the window to the top of the stack
  , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))

  -- mod-button3, Set the window to floating mode and resize by dragging
  , ((modm, button3), (\w -> focus w >> mouseResizeWindow w
                                     >> windows W.shiftMaster))

  -- you may also bind events to the mouse scroll wheel (button4 and button5)
  ]

