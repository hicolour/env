{-# LANGUAGE AllowAmbiguousTypes, DeriveDataTypeable, TypeSynonymInstances, MultiParamTypeClasses #-}
---------------------------------------------------------------------------
--                                                                       --
--     _|      _|  _|      _|                                      _|    --
--       _|  _|    _|_|  _|_|    _|_|    _|_|_|      _|_|_|    _|_|_|    --
--         _|      _|  _|  _|  _|    _|  _|    _|  _|    _|  _|    _|    --
--       _|  _|    _|      _|  _|    _|  _|    _|  _|    _|  _|    _|    --
--     _|      _|  _|      _|    _|_|    _|    _|    _|_|_|    _|_|_|    --
--                                                                       --
---------------------------------------------------------------------------
--                       current as of XMonad 0.13                       --
---------------------------------------------------------------------------
--                                Modules                                --
---------------------------------------------------------------------------
import Control.Monad (liftM, liftM2, join)  -- myManageHookShift
import Data.List
import qualified Data.Map as M
import Data.Monoid
import System.Exit
import System.IO                            -- for xmonbar
import System.Posix.Process(executeFile)

import XMonad hiding ( (|||) )              -- ||| from X.L.LayoutCombinators
import qualified XMonad.StackSet as W       -- myManageHookShift

import XMonad.Actions.Commands
import XMonad.Actions.ConditionalKeys       -- bindings per workspace or layout
import qualified XMonad.Actions.ConstrainedResize as Sqr
import XMonad.Actions.CopyWindow            -- like cylons, except x windows
import XMonad.Actions.CycleWS
import XMonad.Actions.DynamicProjects
import XMonad.Actions.DynamicWorkspaces
import XMonad.Actions.FloatSnap
import XMonad.Actions.MessageFeedback       -- pseudo conditional key bindings
import XMonad.Actions.Navigation2D
import XMonad.Actions.Promote               -- promote window to master
import XMonad.Actions.SinkAll
import XMonad.Actions.SpawnOn
import XMonad.Actions.WindowGo
import XMonad.Actions.WithAll               -- action all the things
import XMonad.Actions.FloatKeys

import XMonad.Hooks.DynamicLog              -- for xmobar
import XMonad.Hooks.DynamicProperty         -- 0.12 broken; works with github version
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.FadeWindows
import XMonad.Hooks.InsertPosition
import XMonad.Hooks.ManageDocks             -- avoid xmobar
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.UrgencyHook
import XMonad.Hooks.SetWMName

import XMonad.Layout.Accordion
import XMonad.Layout.BinarySpacePartition
import XMonad.Layout.BorderResize
import XMonad.Layout.Column
import XMonad.Layout.Combo
import XMonad.Layout.ComboP
import XMonad.Layout.DecorationMadness      -- testing alternative accordion styles
import XMonad.Layout.Dishes
import XMonad.Layout.DragPane
import XMonad.Layout.Drawer
import XMonad.Layout.Gaps
import XMonad.Layout.Hidden
import XMonad.Layout.LayoutBuilder
import XMonad.Layout.LayoutCombinators
import XMonad.Layout.LayoutScreens
import XMonad.Layout.MultiToggle
import XMonad.Layout.MultiToggle.Instances
import XMonad.Layout.NoFrillsDecoration
import XMonad.Layout.PerScreen              -- Check screen width & adjust layouts
import XMonad.Layout.PerWorkspace           -- Configure layouts on a per-workspace
import XMonad.Layout.Reflect
import XMonad.Layout.Renamed
import XMonad.Layout.ResizableTile          -- Resizable Horizontal border
import XMonad.Layout.ShowWName
import XMonad.Layout.Simplest
import XMonad.Layout.SimplestFloat
import XMonad.Layout.Spacing                -- this makes smart space around windows
import XMonad.Layout.StackTile
import XMonad.Layout.SubLayouts             -- Layouts inside windows. Excellent.
import XMonad.Layout.ThreeColumns
import XMonad.Layout.ToggleLayouts          -- Full window at any time
import XMonad.Layout.TrackFloating
import XMonad.Layout.TwoPane
import XMonad.Layout.WindowNavigation

import XMonad.Prompt                        -- to get my old key bindings working
import XMonad.Prompt.ConfirmPrompt          -- don't just hard quit

import XMonad.Util.Cursor
import XMonad.Util.EZConfig                 -- removeKeys, additionalKeys
import XMonad.Util.Loggers
import XMonad.Util.NamedActions
import XMonad.Util.NamedScratchpad
import XMonad.Util.NamedWindows
import XMonad.Util.Paste as P               -- testing
import XMonad.Util.Run                      -- for spawnPipe and hPutStrLn
import XMonad.Util.SpawnOnce
import XMonad.Util.WorkspaceCompare         -- custom WS functions filtering NSP
import XMonad.Util.XSelection
import XMonad.Actions.GroupNavigation

-- experimenting with tripane
import XMonad.Layout.Decoration
import XMonad.Layout.ResizableTile
import XMonad.Layout.Tabbed
import XMonad.Layout.Maximize
import XMonad.Layout.SimplestFloat
import XMonad.Layout.Fullscreen as LF
import XMonad.Layout.NoBorders


---------------------------------------------------------------------------
-- Main
---------------------------------------------------------------------------

main = do

    xmproc <- spawnPipe myDzenXmonad
    myDzenMonitoring_ <- spawnPipe myDzenMonitoring

    -- for independent screens
    -- nScreens <- countScreens

    -- for taffybar, add pagerHints below

    xmonad
        $ dynamicProjects projects
        $ withNavigation2DConfig myNav2DConf
        $ withUrgencyHook LibNotifyUrgencyHook
        $ ewmh
        $ addDescrKeys' ((myModMask, xK_F1), showKeybindings) myKeys
        $ myConfig xmproc

myConfig p = def
        { borderWidth        = border
        , clickJustFocuses   = myClickJustFocuses
        , focusFollowsMouse  = myFocusFollowsMouse
        , normalBorderColor  = myNormalBorderColor
        , focusedBorderColor = myFocusedBorderColor
        , manageHook         = myManageHook
        , handleEventHook    = myHandleEventHook
        , layoutHook         = myLayoutHook
        , logHook            = myLogHook p >> historyHook
        , modMask            = myModMask
        , mouseBindings      = myMouseBindings
        , startupHook        = myStartupHook
        , terminal           = myTerminal
        , workspaces         = myWorkspaces
        }


---------------------------------------------------------------------------
-- Workspaces
---------------------------------------------------------------------------

wsAV    = "0:mail"
wsBSA   = "BSA"
wsCOM   = "COM"
wsDOM   = "DOM"
wsDMO   = "DMO"
wsFLOAT = "6"
wsGEN   = "1:ter"
wsGCC   = "GCC"
wsMON   = "5"
wsOSS   = "OSS"
wsRAD   = "RAD"
wsRW    = "7"
wsSYS   = "4"
wsTMP   = "8"
wsVIX   = "VIX"
wsWRK   = "2:web"
wsWRK2  = "3"
wsGGC   = "GGC"

myWorkspaces = [wsGEN, wsWRK, wsWRK2, wsSYS, wsMON, wsFLOAT, wsRW, wsTMP, wsGCC, wsAV]

projects :: [Project]
projects =

    [ Project   { projectName       = wsGEN
                , projectDirectory  = "~/"
                , projectStartHook  = Nothing
--                , projectStartHook  = Just $ do spawnOn wsGEN myTerminal
                }


    , Project   { projectName       = wsWRK
                , projectDirectory  = "~/"
                , projectStartHook  = Nothing
--                , projectStartHook  = Just $ do spawn $ myBrowser
                }

    , Project   { projectName       = wsWRK2
                , projectDirectory  = "~/"
                , projectStartHook  = Just $ do spawnOn wsWRK2 myAltTerminal
                }



    , Project   { projectName       = wsSYS
                , projectDirectory  = "~/"
                , projectStartHook  = Nothing
                }

    , Project   { projectName       = wsAV
                , projectDirectory  = "~/"
                , projectStartHook  = Just $ do spawn $ myAltBrowser ++ " https://mail.google.com/mail"

                }

{-
    , Project   { projectName       = wsMON
                , projectDirectory  = "~/"
                , projectStartHook  = Just $ do runInTerm "-name glances" "glances"
                }

    , Project   { projectName       = wsWRK
                , projectDirectory  = "~/wrk"
                , projectStartHook  = Just $ do spawnOn wsWRK myTerminal
                                                spawnOn wsWRK myBrowser
                }

    , Project   { projectName       = wsRAD
                , projectDirectory  = "~/"
                , projectStartHook  = Just $ do spawn myBrowser
                }
-}
--    , Project   { projectName       = wsTMP
--                , projectDirectory  = "~/"
                -- , projectStartHook  = Just $ do spawn $ myBrowser ++ " https://mail.google.com/mail/u/0/#inbox/1599e6883149eeac"
--                , projectStartHook  = Just $ do return ()
--                }
    ]

---------------------------------------------------------------------------
-- Applications
---------------------------------------------------------------------------

-- | Uses supplied function to decide which action to run depending on current workspace name.

myTerminal          = "roxterm"
myAltTerminal       = "xfce4-terminal"
myBrowser           = "google-chrome-stable" -- chrome with WS profile dirs
myBrowserClass      = "Google-chrome-stable"
myAltBrowser        = "firefox"
myStatusBar         = "dzen2 -y 0 -x 0 -w 1000 -ta l "
myIDE               = "./eclipse/java-oxygen/eclipse/eclipse"
myMail              = "/opt/google/chrome/google-chrome --profile-directory=Default --app-id=egddcdhcadfhcbheacnhikllgjokeico"
myKeep              = "/opt/google/chrome/google-chrome --profile-directory=Default --app-id=hcfcmgpnmpinpidjdgejehjchlbglpde"
myTranslate         = "/opt/google/chrome/google-chrome --profile-directory=Default --app-id=fklgpoecafmhpbmoepkbhkhhbahodcdh"

myLauncher          = "rofictl"

---------------------------------------------------------------------------
-- Applications properties
---------------------------------------------------------------------------
spotifyCommand      = "spotify"
spotifyClassName    = "Spotify"
isSpotify           = (className =? spotifyClassName)

wicdGtkCommand      = "wicd-gtk"
wicdGtkClassName    = "wicd-client.py"
isWicdGtk         = (className =? wicdGtkClassName)

wicdCursesCommand      = "roxterm --role wicd-curses -e wicd-curses"
wicdCursesClassName    = "Roxterm"
isWicdCurses         = (className =? wicdCursesClassName)   <&&> (stringProperty "WM_WINDOW_ROLE" =? "wicd-curses")

pavucontrolCommand      = "pavucontrol"
pavucontrolClassName    = "Pavucontrol"
isPavucontrol          = (className =? pavucontrolClassName)

---------------------------------------------------------------------------
-- Scratchpads
---------------------------------------------------------------------------
scratchpads =
    [   (NS "terminal"  "roxterm --role scratchpad" (role =? "scratchpad")  (customFloating $ W.RationalRect (1/40) (1/20) (19/20) (9/10)))
    ,   (NS "htop"  "roxterm --role scratchpad -e htop" (role =? "scratchpad")  (customFloating $ W.RationalRect (1/40) (1/20) (19/20) (9/10)))
    ,   (NS "wicd-curses" wicdCursesCommand isWicdCurses (customFloating $ W.RationalRect (1/40) (1/20) (19/20) (9/10)))
    ,   (NS "wicd" wicdGtkCommand isWicdGtk (customFloating $ W.RationalRect (1/40) (1/20) (19/20) (9/10)))
    ,   (NS "pavucontrol"  pavucontrolCommand isPavucontrol (customFloating $ W.RationalRect (1/40) (1/20) (19/20) (9/10)))
    ,   (NS "spotify"  spotifyCommand  isSpotify  (customFloating $ W.RationalRect (1/40) (1/20) (19/20) (9/10)))
    ]
    where role = stringProperty "WM_WINDOW_ROLE"



---------------------------------------------------------------------------
-- Status Bar
---------------------------------------------------------------------------

myDzenPP = dzenPP
  {
    ppCurrent          = wrap "^fg(#F39C12)[^fg(#F1C40F)" "^fg(#F39C12)]"
  , ppVisible          = wrap "^fg(#E67E22)[^fg(#d3d0c8)" "^fg(#E67E22)]"
  , ppHidden           = wrap " ^fg(#d3d0c8)" " "
  , ppHiddenNoWindows  = wrap " ^fg(#747369)" " "
  , ppUrgent           = wrap "^fg(#8ab3b5)[^fg(#cdc5b3)" "^fg(#8ab3b5)]"
  , ppSep              = "  "
  , ppLayout           = wrap "^fg(#8E44AD)[^fg(#9B59B6)" "^fg(#8E44AD)]"
  , ppTitle            = (" " ++) . dzenColor "#5b709b" "" . dzenEscape
  , ppSort             = fmap (.namedScratchpadFilterOutWorkspace) $ ppSort defaultPP
  }


myDzenXmonad="dzen2 -y 0 -x 0 -w 1000 -ta l " ++ myDzenStyle

myDzenMonitoring="~/.dzen/dzen_xmonad.sh"

myDzenStyle = "-fg '" ++ myFgColor ++
              "' -bg '" ++ myBgColor ++
              "' -fn '" ++ myFont ++
              "' -h 20"

myFgColor = "#E74C3C"
myBgColor = "#1B1B1B"

myFocusedFGColor = "#8ab1c1"
myAlertColor = "#934a5a"

myColorH  = "#999999"
myColorHN = "#686868"




-- I'm using a custom browser launching script (see myBrowser above) that
-- is workspace aware. It launches an instance of Chrome that is unique
-- on specific workspaces. Thus on "GEN" workspace I use my "normal"
-- browser profile, while on "WRK" I use a different profile. This is
-- roughly equivalent to using Chrome's built in profiles, but has the
-- benefit of launching immediately with the correct profile.
--
-- In addition to this, I use per workspace bindings to toggle Hangouts
-- chat windows and Trello windows based on whether I'm on, for example,
-- my personal or work workspace.
--
-- This is particularly useful for Trello since I can launch a project
-- related Trello "app" instance on a project workspace.
--
-- This system utilizes:
-- * my workspace aware browser script
-- * X.U.NamedScratchPads
-- * bindOn via X.A.PerWorkspaceKeys (NO... now using ConditionalKeys custom module)
-- * bindOn via X.A.ConditionalKeys

-- TODO: change this to a lookup for all workspaces



---------------------------------------------------------------------------
-- Theme
---------------------------------------------------------------------------

myFocusFollowsMouse  = True
myClickJustFocuses   = True

baseFgColor = "#E74C3C"
baseBgColor = "#1B1B1B"

base03  = "#002b36"
base02  = "#073642"
base01  = "#586e75"
base00  = "#657b83"
base0   = "#839496"
base1   = "#93a1a1"
base2   = "#eee8d5"
base3   = "#fdf6e3"
yellow  = "#b58900"
orange  = "#cb4b16"
red     = "#dc322f"
magenta = "#d33682"
violet  = "#6c71c4"
blue    = "#268bd2"
cyan    = "#2aa198"
green   = "#859900"

-- sizes
gap         = 9
topbar      = 3
border      = 2
prompt      = 20
status      = 20
tabbar      = 15

myNormalBorderColor     = "#000000"
myFocusedBorderColor    = active

active      = blue
activeWarn  = red
inactive    = base02
focusColor  = cyan
unfocusColor = base02


myFont      ="xft:misc ohsnap-11"
--myFont      ="-ypn-envypn-Medium-R-Normal--13-130-75-75-C-90-ISO8859-1"
myWideFont  = "xft:Eurostar Black Extended:"
            ++ "style=Regular:pixelsize=50:hinting=true"

-- this is a "fake title" used as a highlight bar in lieu of full borders
-- (I find this a cleaner and less visually intrusive solution)

topBarTheme = def
    { fontName              = myFont
    , inactiveBorderColor   = base03
    , inactiveColor         = base03
    , inactiveTextColor     = base03
    , activeBorderColor     = active
    , activeColor           = active
    , activeTextColor       = active
    , urgentBorderColor     = red
    , urgentTextColor       = yellow
    , decoHeight            = topbar
    }

myTabTheme = def
    { fontName              = myFont
    , activeColor           = active
    , inactiveColor         = base02
    , activeBorderColor     = active
    , inactiveBorderColor   = base02
    , activeTextColor       = base03
    , inactiveTextColor     = base00
    , decoHeight            = tabbar
    }

myPromptTheme = def
    { font                  = myFont
    , bgColor               = base03
    , fgColor               = active
    , fgHLight              = base03
    , bgHLight              = active
    , borderColor           = base03
    , promptBorderWidth     = 0
    , height                = prompt
    , position              = Top
    }

warmPromptTheme = myPromptTheme
    { bgColor               = yellow
    , fgColor               = base03
    , position              = Top
    }

hotPromptTheme = myPromptTheme
    { bgColor               = red
    , fgColor               = base3
    , position              = Top
    }

myXPConfig = defaultXPConfig
    {
          position = Top
        , promptBorderWidth = 0
        , defaultText = "test"
        , alwaysHighlight = True
        }



myShowWNameTheme = def
    { swn_font              = myWideFont
    , swn_fade              = 0.5
    , swn_bgcolor           = "#330000"
    , swn_color             = "#ffcc00"
    }

---------------------------------------------------------------------------
-- Layouts
--
-- WARNING: WORK IN PROGRESS AND A LITTLE MESSY
---------------------------------------------------------------------------

-- Tell X.A.Navigation2D about specific layouts and how to handle them

myNav2DConf = def
    { defaultTiledNavigation    = centerNavigation
--    , floatNavigation           = centerNavigation
    , screenNavigation          = lineNavigation
    , layoutNavigation          = [("Full",          centerNavigation)
    -- line/center same results   ,("Simple Tabs", lineNavigation)
    --                            ,("Simple Tabs", centerNavigation)
                                  ]
    , unmappedWindowRect        = [("Full", singleWindowRect)
    -- works but breaks tab deco  ,("Simple Tabs", singleWindowRect)
    -- doesn't work but deco ok   ,("Simple Tabs", fullScreenRect)
                                  ]
    }


data FULLBAR = FULLBAR deriving (Read, Show, Eq, Typeable)
instance Transformer FULLBAR Window where
    transform FULLBAR x k = k barFull (\_ -> x)

--barFull = avoidStruts $ noFrillsDeco shrinkText topBarTheme $ addTabs shrinkText myTabTheme $ Simplest
barFull = avoidStruts $ Simplest

-- cf http://xmonad.org/xmonad-docs/xmonad-contrib/src/XMonad-Config-Droundy.html

myLayoutHook = showWorkspaceName
             $ avoidStruts
             $ onWorkspace wsFLOAT floatWorkSpace
             $ smartBorders
             $ LF.fullscreenFloat -- fixes floating windows going full screen, while retaining "bounded" fullscreen
             $ fullScreenToggle
             $ LF.fullscreenFull
             $ fullBarToggle
             $ mirrorToggle
             $ reflectToggle
             $ tabs ||| flex ||| threeCol
  where

--    testTall = Tall 1 (1/50) (2/3)
--    myTall = subLayout [] Simplest $ trackFloating (Tall 1 (1/20) (1/2))

    floatWorkSpace      = simplestFloat
    fullBarToggle       = mkToggle (single FULLBAR)
    fullScreenToggle    = mkToggle (single FULL)
    mirrorToggle        = mkToggle (single MIRROR)
    reflectToggle       = mkToggle (single REFLECTX)
    smallMonResWidth    = 1920
    showWorkspaceName   = showWName' myShowWNameTheme

    named n             = renamed [(XMonad.Layout.Renamed.Replace n)]
    trimNamed w n       = renamed [(XMonad.Layout.Renamed.CutWordsLeft w),
                                   (XMonad.Layout.Renamed.PrependWords n)]
    suffixed n          = renamed [(XMonad.Layout.Renamed.AppendWords n)]
    trimSuffixed w n    = renamed [(XMonad.Layout.Renamed.CutWordsRight w),
                                   (XMonad.Layout.Renamed.AppendWords n)]

    addTopBar           = noFrillsDeco shrinkText topBarTheme

    mySpacing           = spacing gap
    sGap                = quot gap 2
    myGaps              = gaps [(U, gap),(D, gap),(L, gap),(R, gap)]
    mySmallGaps         = gaps [(U, sGap),(D, sGap),(L, sGap),(R, sGap)]
    myBigGaps           = gaps [(U, gap*2),(D, gap*2),(L, gap*2),(R, gap*2)]
    onlyTopGap          = gaps [(U,20),(D,0),(L,0),(R,0)]


    --------------------------------------------------------------------------
    -- Tabs Layout
    --------------------------------------------------------------------------

    -- --------------------------------------------
    -- |          |                    |          |
    -- |----------|                    |----------|
    -- |          |                    |          |
    -- |----------|       Master       |----------|
    -- |          |                    |          |
    -- |----------|                    |----------|
    -- |          |                    |          |
    -- --------------------------------------------

    threeCol = named "Unflexed"
         $ smartBorders
         $ avoidStruts
         $ onlyTopGap
         $ addTopBar
--          $ myGaps
         $ mySpacing
         $ ThreeColMid 1 (1/10) (1/2)

    --------------------------------------------------------------------------
    -- Tabs Layout
    --------------------------------------------------------------------------

    -- --------------------------------------------
    -- |                                          |
    -- |                                          |
    -- |                                          |
    -- |                  Tabs                    |
    -- |                                          |
    -- |                                          |
    -- |                                          |
    -- --------------------------------------------
    tabs = named "Tabs"
         $ smartBorders
         $ avoidStruts
         $ onlyTopGap
         $ addTopBar
         $ addTabs shrinkText myTabTheme
         $ Simplest

    -----------------------------------------------------------------------
    -- Flexi SubLayouts
    -----------------------------------------------------------------------

    -- Standard:
    -- ---------------------------------
    -- |                    |          |
    -- |                    |          |
    -- |                    |          |
    -- |       Master       |----------|
    -- |                    |          |
    -- |                    |   Tabs   |
    -- |                    |          |
    -- ---------------------------------

    flex = trimNamed 5 "Flex"
              $ avoidStruts
              -- don't forget: even though we are using X.A.Navigation2D
              -- we need windowNavigation for merging to sublayouts
--              $ smartBorders
              $ windowNavigation
              $ addTabs shrinkText myTabTheme
              -- $ subLayout [] (Simplest ||| (mySpacing $ Accordion))
              $ subLayout [] (Simplest ||| Accordion)
              $ ifWider smallMonResWidth wideLayouts standardLayouts
              where
                  wideLayouts = onlyTopGap
                      $ (suffixed "Wide 3Col" $ ThreeColMid 1 (1/20) (1/2))
                    ||| (trimSuffixed 1 "Wide BSP" $ hiddenWindows emptyBSP)
                  --  ||| fullTabs
                  standardLayouts = onlyTopGap
                      $ (suffixed "Std 2/3" $ ResizableTall 1 (1/20) (2/3) [])
                    ||| (suffixed "Std 1/2" $ ResizableTall 1 (1/20) (1/2) [])


---------------------------------------------------------------------------
-- Bindings
---------------------------------------------------------------------------

myModMask = mod4Mask -- super (and on my system, hyper) keys

-- Display keyboard mappings using zenity
-- from https://github.com/thomasf/dotfiles-thomasf-xmonad/
--              blob/master/.xmonad/lib/XMonad/Config/A00001.hs
showKeybindings :: [((KeyMask, KeySym), NamedAction)] -> NamedAction
showKeybindings x = addName "Show Keybindings" $ io $ do
    h <- spawnPipe "zenity --text-info --font=terminus"
    hPutStr h (unlines $ showKm x)
    hClose h
    return ()

wsKeys = map show $ [1..9] ++ [0]

-- any workspace but scratchpad
notSP = (return $ ("NSP" /=) . W.tag) :: X (WindowSpace -> Bool)
shiftAndView dir = findWorkspace getSortByIndex dir (WSIs notSP) 1
        >>= \t -> (windows . W.shift $ t) >> (windows . W.greedyView $ t)

-- hidden, non-empty workspaces less scratchpad
shiftAndView' dir = findWorkspace getSortByIndexNoSP dir HiddenNonEmptyWS 1
        >>= \t -> (windows . W.shift $ t) >> (windows . W.greedyView $ t)
nextNonEmptyWS = findWorkspace getSortByIndexNoSP Next HiddenNonEmptyWS 1
        >>= \t -> (windows . W.view $ t)
prevNonEmptyWS = findWorkspace getSortByIndexNoSP Prev HiddenNonEmptyWS 1
        >>= \t -> (windows . W.view $ t)
getSortByIndexNoSP =
        fmap (.namedScratchpadFilterOutWorkspace) getSortByIndex

-- toggle any workspace but scratchpad
myToggle = windows $ W.view =<< W.tag . head . filter
        ((\x -> x /= "NSP" && x /= "SP") . W.tag) . W.hidden

myKeys conf = let

    subKeys str ks = subtitle str : mkNamedKeymap conf ks
    screenKeys     = ["w","v","z"]
    dirKeys        = ["j","k","h","l"]
    arrowKeys        = ["<D>","<U>","<L>","<R>"]
    dirs           = [ D,  U,  L,  R ]

    --screenAction f        = screenWorkspace >=> flip whenJust (windows . f)

    zipM  m nm ks as f = zipWith (\k d -> (m ++ k, addName nm $ f d)) ks as
    zipM' m nm ks as f b = zipWith (\k d -> (m ++ k, addName nm $ f d b)) ks as

    -- from xmonad.layout.sublayouts
    focusMaster' st = let (f:fs) = W.integrate st
        in W.Stack f [] fs
    swapMaster' (W.Stack f u d) = W.Stack f [] $ reverse u ++ d

    -- try sending one message, fallback if unreceived, then refresh
    tryMsgR x y = sequence_ [(tryMessage_ x y), refresh]

    -- warpCursor = warpToWindow (9/10) (9/10)

    -- cf https://github.com/pjones/xmonadrc
    --switch :: ProjectTable -> ProjectName -> X ()
    --switch ps name = case Map.lookup name ps of
    --  Just p              -> switchProject p
    --  Nothing | null name -> return ()

    -- do something with current X selection
    unsafeWithSelection app = join $ io $ liftM unsafeSpawn $ fmap (\x -> app ++ " " ++ x) getSelection

    toggleFloat w = windows (\s -> if M.member w (W.floating s)
                    then W.sink w s
                    else (W.float w (W.RationalRect (1/3) (1/4) (1/2) (4/5)) s))

    in

    -----------------------------------------------------------------------
    -- System / Utilities
    -----------------------------------------------------------------------
    subKeys "System"
    [ ("M-q"                    , addName "Restart XMonad"                  $ confirmPrompt hotPromptTheme "Restart XMonad" $ restartXmonad)
    , ("M-C-q"                  , addName "Rebuild & restart XMonad"        $ confirmPrompt hotPromptTheme "Recompile and Restart XMonad" $ rebuildXmonad)
    , ("M-S-q"                  , addName "Quit XMonad"                     $ confirmPrompt hotPromptTheme "Quit XMonad" $ io (exitWith ExitSuccess))
    , ("M-x"                    , addName "Lock screen"                     $ spawn "slimlock")  -- "xset s activate"
    , ("M-F1"                   , addName "Show Keybindings"                $ return ())
    , ("M-n"                    , addName "Show Keybindings"                $ nextMatch History (return True))
    ] ^++^


    -----------------------------------------------------------------------
    -- Actions keys https://hackage.haskell.org/package/xmonad-contrib-0.13/docs/XMonad-Util-EZConfig.html
    -----------------------------------------------------------------------

    subKeys "Actions"
    [ ("M-<KP_Insert>"             , addName "Power off"                       $ confirmPrompt hotPromptTheme "Shutdown Linux" $ spawn "shutdown -h now")
    , ("M-<KP_Delete>"             , addName "Power reset"                     $ confirmPrompt hotPromptTheme "Restart Linux" $ spawn "shutdown -r now")
    , ("<XF86PowerOff>"            , addName "Power off"                       $ confirmPrompt hotPromptTheme "Shutdown Linux" $ spawn "shutdown -h now")

    , ("M1-<Right>"                , addName "Up brilho"                       $ spawn "xbacklight -inc 6")
    , ("M1-<Left>"                 , addName "Down brilho"                     $ spawn "xbacklight -dec 6")
    , ("<XF86MonBrightnessUp>"     , addName "Up brilho"                       $ spawn "xbacklight -inc 3")
    , ("<XF86MonBrightnessDown>"   , addName "Down brilho"                     $ spawn "xbacklight -dec 3")
    , ("M1-<Up>"                   , addName "Up audio"                        $ spawn "pamixer -i 10")
    , ("M1-<Down>"                 , addName "Down audio"                      $ spawn "amixer set Master 5%-")
    , ("M1-S-<Up>"                 , addName "Up audio beyond"                 $ spawn "pactl set-sink-volume 0 +10%")
    , ("M1-S-<Down>"               , addName "Down audio beyond"               $ spawn "pactl set-sink-volume 0 -10%")
    , ("M1-m"                      , addName "MUTE audio"                      $ spawn "amixer set Master toggle")
    , ("<XF86AudioRaiseVolume>"    , addName "Up audio"                        $ spawn "amixer set Master 5%+")
    , ("<XF86AudioLowerVolume>"    , addName "Down audio"                      $ spawn "amixer set Master 5%-")
    , ("<XF86AudioMute>"           , addName "MUTE audio"                      $ spawn "amixer set Master toggle")

    , ("M-<KP_Left>"               , addName "Esquerda"                        $ withFocused (keysMoveWindow (-5,0)))
    , ("M-<KP_Right>"              , addName "Direita"                         $ withFocused (keysMoveWindow (5,0)))
    , ("M-<KP_Up>"                 , addName "Levanta"                         $ withFocused (keysMoveWindow (0,-5)))
    , ("M-<KP_Down>"               , addName "Desce"                           $ withFocused (keysMoveWindow (0,5)))

    , ("M-S-<KP_Left>"             , addName "Redim LE esq"                    $ withFocused (keysResizeWindow (5,0) (1,0)))
    , ("M-S-<KP_Right>"            , addName "Redim LE dir"                    $ withFocused (keysResizeWindow (-5,0) (1,0)))
    , ("M-S-<KP_Up>"               , addName "Redim CIMA levanta"              $ withFocused (keysResizeWindow (0,5) (0,1)))
    , ("M-S-<KP_Down>"             , addName "Redim CIMA desce"                $ withFocused (keysResizeWindow (0,-5) (0,1)))

    , ("M-C-<KP_Left>"             , addName "Redim LD esq"                    $ withFocused (keysResizeWindow (-5,0) (0,0)))
    , ("M-C-<KP_Right>"            , addName "Redim LD dir"                    $ withFocused (keysResizeWindow (5,0) (0,0)))
    , ("M-C-<KP_Up>"               , addName "Redim BAIXO levanta"             $ withFocused (keysResizeWindow (0,-5) (0,0)))
    , ("M-C-<KP_Down>"             , addName "Redim BAIXO desce"               $ withFocused (keysResizeWindow (0,5) (0,0)))
    ] ^++^

    -----------------------------------------------------------------------
    -- Launchers
    -----------------------------------------------------------------------
    subKeys "Launchers"
    [ ("M-<Space>"                , addName "Launcher"                        $ spawn myLauncher)
    , ("M-M1-<Space>"             , addName "Windows Launcher"                $ spawn "rofictl window")
    , ("M-<Return>"               , addName "Terminal"                        $ spawn myTerminal)8
    , ("M-r"                      , addName "Ranger"                          $ spawn "urxvt -e ranger")
    , ("<Print>"                  , addName "Print full"                      $ spawn "scrot -e 'mv $f ~/Imagens/ 2>/dev/null'")
    , ("M-<Print>"                , addName "Print por seleção"               $ spawn "sleep 0.2; scrot -s -e 'mv $f ~/Imagens/ 2>/dev/null'")
    , ("M-o"                      , addName "Browser"                         $ spawn myBrowser)
    , ("M-\\"                     , addName "Browser Alternativo"             $ spawn myAltBrowser)
    , ("M-<Home>"                 , addName "E-mail"                          $ spawn myMail)
    , ("M-<Insert>"               , addName "Keep"                            $ spawn myKeep)
    , ("M-<End>"                  , addName "Translate"                       $ spawn myTranslate)
    , ("M-<Delete>"               , addName "IDE"                             $ spawn myIDE)
    ] ^++^

    ---------------------------------------------------------------------
    -- Launchers
    -----------------------------------------------------------------------
    subKeys "Scratchpads"
    [ ("M-<F2>"                   , addName "NSP Terminal"                    $ namedScratchpadAction scratchpads "terminal")
    , ("M-<F3>"                   , addName "NSP Htop"                        $ namedScratchpadAction scratchpads "htop")
    , ("M-<F5>"                   , addName "NSP Rchst"                       $ spawn "/home/marek/projects/personal/rchst/rchst")
    , ("M-<F8>"                   , addName "NSP Wicd"                        $ namedScratchpadAction scratchpads "wicd-curses")
    , ("M-<F4>"                   , addName "NSP Pavucontrol"                 $ namedScratchpadAction scratchpads "pavucontrol")
    , ("M-<F12>"                  , addName "NSP Spotify"                     $ namedScratchpadAction scratchpads "spotify")
    ] ^++^

    -----------------------------------------------------------------------
    -- Windows
    -----------------------------------------------------------------------

    subKeys "Windows"
    (
    [ ("M-<Backspace>"                    , addName "Kill"                            kill1)
    , ("M-S-<Backspace>"                  , addName "Kill all"                        $ confirmPrompt hotPromptTheme "kill all" $ killAll)
    , ("M-d"                    , addName "Duplicate w to all ws"           $ toggleCopyToAll)
    , ("M-b"                    , addName "Promote"                         $ promote)
    , ("M-g"                    , addName "Un-merge from sublayout"         $ withFocused (sendMessage . UnMerge))
    , ("M-S-g"                  , addName "Merge all into sublayout"        $ withFocused (sendMessage . MergeAll))

    , ("M-z m"                  , addName "Focus master"                    $ windows W.focusMaster)


    , ("M-'"                    , addName "Navigate tabs D"                 $ bindOn LD [("Tabs", windows W.focusDown), ("", onGroup W.focusDown')])
    , ("M-;"                    , addName "Navigate tabs U"                 $ bindOn LD [("Tabs", windows W.focusUp), ("", onGroup W.focusUp')])
    , ("C-'"                    , addName "Swap tab D"                      $ windows W.swapDown)
    , ("C-;"                    , addName "Swap tab U"                      $ windows W.swapUp)

    -- ComboP specific (can remove after demo)
    , ("M-C-S-m"                , addName "Combo swap"                      $ sendMessage $ SwapWindow)
    ]

    ++ zipM' "M-"               "Navigate window"                           dirKeys dirs windowGo True
    -- ++ zipM' "M-S-"               "Move window"                               dirKeys dirs windowSwap True
    -- TODO: following may necessitate use of a "passthrough" binding that can send C- values to focused w
    ++ zipM' "M1-"              "Move window"                               dirKeys dirs windowSwap True
    ++ zipM  "M-C-"             "Merge w/sublayout"                         dirKeys dirs (sendMessage . pullGroup)
    ++ zipM' "M-S-"             "Navigate screen"                           arrowKeys dirs screenGo True
    ++ zipM' "M-C-"             "Move window to screen"                     arrowKeys dirs windowToScreen True
    ++ zipM' "M-S-"             "Swap workspace to screen"                  arrowKeys dirs screenSwap True

    ) ^++^

    -----------------------------------------------------------------------
    -- Workspaces & Projects
    -----------------------------------------------------------------------

    -- original version was for dynamic workspaces
    --    subKeys "{a,o,e,u,i,d,...} focus and move window between workspaces"
    --    (  zipMod "View      ws" wsKeys [0..] "M-"      (withNthWorkspace W.greedyView)

    subKeys "Workspaces & Projects"
    (
    [ ("M-w"                    , addName "Switch to Project"           $ switchProjectPrompt warmPromptTheme)
    , ("M-S-w"                  , addName "Shift to Project"            $ shiftToProjectPrompt warmPromptTheme)
    , ("M-<Escape>"             , addName "Next non-empty workspace"    $ nextNonEmptyWS)
    , ("M-S-<Escape>"           , addName "Prev non-empty workspace"    $ prevNonEmptyWS)
    , ("M-`"                    , addName "Next non-empty workspace"    $ nextNonEmptyWS)
    , ("M-S-`"                  , addName "Prev non-empty workspace"    $ prevNonEmptyWS)
    , ("M-a"                    , addName "Toggle last workspace"       $ toggleWS' ["NSP"])
    ]
    ++ zipM "M-"                "View      ws"                          wsKeys [0..] (withNthWorkspace W.greedyView)
    ++ zipM "M-S-"              "Move w to ws"                          wsKeys [0..] (withNthWorkspace W.shift)
    ++ zipM "M-S-C-"            "Copy w to ws"                          wsKeys [0..] (withNthWorkspace copy)
    ) ^++^
    -----------------------------------------------------------------------
    -- Layouts & Sub-layouts
    -----------------------------------------------------------------------

    subKeys "Layout Management"

    [ ("M-<Tab>"                , addName "Cycle all layouts"               $ sendMessage NextLayout)
    , ("M-C-<Tab>"              , addName "Cycle sublayout"                 $ toSubl NextLayout)
    , ("M-S-<Tab>"              , addName "Reset layout"                    $ setLayout $ XMonad.layoutHook conf)

    , ("M-y"                    , addName "Float tiled w"                   $ withFocused toggleFloat)
    , ("M-S-y"                  , addName "Tile all floating w"             $ sinkAll)

    , ("M-,"                    , addName "Decrease master windows"         $ sendMessage (IncMasterN (-1)))
    , ("M-."                    , addName "Increase master windows"         $ sendMessage (IncMasterN 1))

    , ("M-t"                    , addName "Reflect/Rotate"              $ tryMsgR (Rotate) (XMonad.Layout.MultiToggle.Toggle REFLECTX))
    , ("M-S-r"                  , addName "Force Reflect (even on BSP)" $ sendMessage (XMonad.Layout.MultiToggle.Toggle REFLECTX))


    -- If following is run on a floating window, the sequence first tiles it.
    -- Not perfect, but works.
    , ("M-f"                , addName "Fullscreen"                      $ sequence_ [ (withFocused $ windows . W.sink)
                                                                        , (sendMessage $ XMonad.Layout.MultiToggle.Toggle FULL) ])

    -- Fake fullscreen fullscreens into the window rect. The expand/shrink
    -- is a hack to make the full screen paint into the rect properly.
    -- The tryMsgR handles the BSP vs standard resizing functions.
    , ("M-S-f"                  , addName "Fake fullscreen"             $ sequence_ [ (P.sendKey P.noModMask xK_F11)
                                                                                    , (tryMsgR (ExpandTowards L) (Shrink))
                                                                                    , (tryMsgR (ExpandTowards R) (Expand)) ])
    , ("C-S-h"                  , addName "Ctrl-h passthrough"          $ P.sendKey controlMask xK_h)
    , ("C-S-j"                  , addName "Ctrl-j passthrough"          $ P.sendKey controlMask xK_j)
    , ("C-S-k"                  , addName "Ctrl-k passthrough"          $ P.sendKey controlMask xK_k)
    , ("C-S-l"                  , addName "Ctrl-l passthrough"          $ P.sendKey controlMask xK_l)
    ] ^++^


    -----------------------------------------------------------------------
    -- Resizing
    -----------------------------------------------------------------------

    subKeys "Resize"

    [ ("M-["                    , addName "Expand (L on BSP)"           $ tryMsgR (ExpandTowards L) (Shrink))
    , ("M-]"                    , addName "Expand (R on BSP)"           $ tryMsgR (ExpandTowards R) (Expand))
    , ("M-S-["                  , addName "Expand (U on BSP)"           $ tryMsgR (ExpandTowards U) (MirrorShrink))
    , ("M-S-]"                  , addName "Expand (D on BSP)"           $ tryMsgR (ExpandTowards D) (MirrorExpand))

    , ("M-C-["                  , addName "Shrink (L on BSP)"           $ tryMsgR (ShrinkFrom R) (Shrink))
    , ("M-C-]"                  , addName "Shrink (R on BSP)"           $ tryMsgR (ShrinkFrom L) (Expand))
    , ("M-C-S-["                , addName "Shrink (U on BSP)"           $ tryMsgR (ShrinkFrom D) (MirrorShrink))
    , ("M-C-S-]"                , addName "Shrink (D on BSP)"           $ tryMsgR (ShrinkFrom U) (MirrorExpand))
    ]
        where
          toggleCopyToAll = wsContainingCopies >>= \ws -> case ws of
                           [] -> windows copyToAll
                           _ -> killAllOtherCopies

    -----------------------------------------------------------------------
    -- Screens
    -----------------------------------------------------------------------

-- Mouse bindings: default actions bound to mouse events
-- Includes window snapping on move/resize using X.A.FloatSnap
-- Includes window w/h ratio constraint (square) using X.H.ConstrainedResize
myMouseBindings (XConfig {XMonad.modMask = myModMask}) = M.fromList $

    [ ((myModMask,               button1) ,(\w -> focus w
      >> mouseMoveWindow w
      >> ifClick (snapMagicMove (Just 50) (Just 50) w)
      >> windows W.shiftMaster))

    , ((myModMask .|. shiftMask, button1), (\w -> focus w
      >> mouseMoveWindow w
      >> ifClick (snapMagicResize [L,R,U,D] (Just 50) (Just 50) w)
      >> windows W.shiftMaster))

    , ((myModMask,               button3), (\w -> focus w
      >> mouseResizeWindow w
      >> ifClick (snapMagicResize [R,D] (Just 50) (Just 50) w)
      >> windows W.shiftMaster))

    , ((myModMask .|. shiftMask, button3), (\w -> focus w
      >> Sqr.mouseResizeWindow w True
      >> ifClick (snapMagicResize [R,D] (Just 50) (Just 50) w)
      >> windows W.shiftMaster ))


    ]

---------------------------------------------------------------------------
-- Startup
---------------------------------------------------------------------------
myStartupHook = do
    setWMName "LG3D"
    setDefaultCursor xC_left_ptr


quitXmonad :: X ()
quitXmonad = io (exitWith ExitSuccess)

rebuildXmonad :: X ()
rebuildXmonad = do
    spawn "xmonad --recompile && xmonad --restart"

restartXmonad :: X ()
restartXmonad = do
    spawn "xmonad --restart"



---------------------------------------------------------------------------
-- Log
---------------------------------------------------------------------------

myLogHook h = do

    -- following block for copy windows marking
    copies <- wsContainingCopies
    let check ws | ws `elem` copies =
                   pad . xmobarColor yellow red . wrap "*" " "  $ ws
                 | otherwise = pad ws

    fadeWindowsLogHook myFadeHook
    ewmhDesktopsLogHook
    --dynamicLogWithPP $ defaultPP
    dynamicLogWithPP $ def

        { ppCurrent             = wrap "^fg(#F39C12)[^fg(#F1C40F)" "^fg(#F39C12)]"
        , ppTitle               = (" " ++) . dzenColor "#5b709b" "" . dzenEscape
        , ppVisible             = wrap "^fg(#d3d0c8)" "" . wrap "[" "]"
        , ppUrgent              = wrap "^fg(#8ab3b5)[^fg(#cdc5b3)" "^fg(#8ab3b5)]"
        , ppHidden              = check
        , ppHiddenNoWindows     = wrap " ^fg(#d3d0c8)" " "
        , ppSep                 = ""
        , ppWsSep               = ""
        , ppLayout              = wrap "^fg(#8E44AD)[^fg(#9B59B6)" "^fg(#8E44AD)]"
        , ppOrder               = id
        , ppOutput              = hPutStrLn h
        , ppSort                = fmap
                                  (namedScratchpadFilterOutWorkspace.)
                                  (ppSort def)
                                  --(ppSort defaultPP)
        , ppExtras              = [] }

myFadeHook = composeAll
    [ opaque -- default to opaque
    , isUnfocused --> opacity 1.0
    , (className =? "Terminator") <&&> (isUnfocused) --> opacity 0.9
    , (className =? "URxvt") <&&> (isUnfocused) --> opacity 1.0
    , fmap ("Google" `isPrefixOf`) className --> opaque
    , isDialog --> opaque
    --, isUnfocused --> opacity 0.55
    --, isFloating  --> opacity 0.75
    ]

---------------------------------------------------------------------------
-- Actions
---------------------------------------------------------------------------


---------------------------------------------------------------------------
-- Urgency Hook
---------------------------------------------------------------------------
-- from https://pbrisbin.com/posts/using_notify_osd_for_xmonad_notifications/
data LibNotifyUrgencyHook = LibNotifyUrgencyHook deriving (Read, Show)

instance UrgencyHook LibNotifyUrgencyHook where
    urgencyHook LibNotifyUrgencyHook w = do
        name     <- getName w
        Just idx <- fmap (W.findTag w) $ gets windowset

        safeSpawn "notify-send" [show name, "workspace " ++ idx]
-- cf https://github.com/pjones/xmonadrc


---------------------------------------------------------------------------
-- New Window Actions
---------------------------------------------------------------------------

-- https://wiki.haskell.org/Xmonad/General_xmonad.hs_config_tips#ManageHook_examples
-- <+> manageHook defaultConfig

myManageHook :: ManageHook
myManageHook =
        manageSpecific
    <+> manageDocks
    <+> namedScratchpadManageHook scratchpads
    <+> manageHook defaultConfig
    <+> LF.fullscreenManageHook
    <+> manageSpawn
    where
        manageSpecific = composeOne
            [ resource =? "desktop_window" -?> doIgnore
            , resource =? "stalonetray"    -?> doIgnore
            , resource =? "vlc"     -?> doFloat
            , resource =? "google-chrome" -?> doShift "2:web"
            , resource =? "steam"   -?> doFloat
            , transience
            , isDialog -?> doCenterFloat
            , isRole =? "pop-up" -?> doCenterFloat
            , isInProperty "_NET_WM_WINDOW_TYPE"
                           "_NET_WM_WINDOW_TYPE_SPLASH" -?> doCenterFloat
            , resource =? "console" -?> tileBelowNoFocus
            , isFullscreen -?> doFullFloat
            , pure True -?> tileBelow ]
        isBrowserDialog = isDialog <&&> className =? myBrowserClass
        gtkFile = "GtkFileChooserDialog"
        isRole = stringProperty "WM_WINDOW_ROLE"
        -- insert WHERE and focus WHAT
        tileBelow = insertPosition Below Newer
        tileBelowNoFocus = insertPosition Below Older

---------------------------------------------------------------------------
-- Event Actions
---------------------------------------------------------------------------

myHandleEventHook = docksEventHook
                <+> fadeWindowsEventHook
                <+> handleEventHook def
                <+> LF.fullscreenEventHook
                <+> spotifyForceFloatingEventHook


forceCenterFloat :: ManageHook
forceCenterFloat = doFloatDep move
  where
    move :: W.RationalRect -> W.RationalRect
    move _ = W.RationalRect x y w h

    w, h, x, y :: Rational
    w = 1/3
    h = 1/2
    x = (1-w)/2
    y = (1-h)/2


spotifyForceFloatingEventHook :: Event -> X All
spotifyForceFloatingEventHook = dynamicPropertyChange "WM_NAME" (title =? "Spotify" --> floating)
    where floating  = (customFloating $ W.RationalRect (1/40) (1/20) (19/20) (9/10))




