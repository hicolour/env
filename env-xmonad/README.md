env-xmonad
==========





----
### Learning
https://xmonadhaskell.wordpress.com/xmonad-layout/


#### inspiration
https://github.com/pjones/xmonadrc
https://github.com/byorgey/dotfiles/blob/master/xmonad.hs
https://github.com/patrickpichler/dotfiles/blob/dfec5161c7f0006937940083716e25ab4a67a9a3/.xmonad/xmonad.hs intellij idea
https://github.com/vinnyA3/dotfileso

#### other

https://www.youtube.com/watch?v=70IxjLEmomg

https://github.com/altercation/dotfiles-tilingwm
https://github.com/altercation/dotfiles-tilingwm/blob/master/.xmonad/xmonad.hs


### Inspiration

Icon arround grid layer
- https://github.com/karetsu/shore
```
logbar h = do
    dynamicLogWithPP $ tryPP h
tryPP :: Handle -> PP
tryPP h = def
    { ppOutput             = hPutStrLn h
    , ppCurrent            = dzenColor (fore) (normBord) . pad
    , ppVisible            = dzenColor (fore) (back) . pad
    , ppHidden             = dzenColor (fore) (back) . pad
    , ppHiddenNoWindows    = dzenColor (fore) (back) . pad
    , ppUrgent             = dzenColor (fore) (focdBord) . pad
    , ppOrder              = \(ws:l:t:_) -> [ws,l]
    , ppSep                = ""
    , ppLayout             = dzenColor (fore) (winType) .
                ( \t -> case t of
                    "Spacing 2 ResizableTall" -> " " ++ i ++ "tile.xbm) TALL "
                    "Full" -> " " ++ i ++ "dice1.xbm) FULL "
                    "Circle" -> " " ++ i ++ "dice2.xbm) CIRC "
                    _ -> " " ++ i ++ "tile.xbm) TALL "
                )
    } where i = "^i(/home/karetsu/.icons/stlarch/"


```
