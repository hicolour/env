# Env!
__Env!__ is a toolkit for configuration of the efficient work environments's on [ArchLinux](https://www.archlinux.org/) distribution with __Suckless__ philosophy.










###

#### How To

1. Check window props:

```shell
xprop
```

2. Check key codes of pressed keys
```shell
xev | grep 'keycode'
```





###

* entr - Run arbitrary commands when files change
```
echo ~/.bashrc | entr notify-send "hello"
```





==== CLEAN UP =====


## Suckless

Minimalist free software projects with a focus on simplicity, clarity, and frugality. Tiling window managers, console or ncurses programs that are said to adhere strictly to the UNIX philosophy of "doing one thing and doing it well."


## Pre-requirements

Curretnly Env! does not support Archlinux base installaltions phase.

* Archlinux base base-devel instalaltion
* Working xorg, you need to be able to launch `startx`


## Installation

Clone project:
	``git clone https://github.com/hicolour/env.git``


Base setup:
    ``make base``

## Current state

![Screen] (screen.png)

## Packages

Common:

 * `base` - base stack: xmonad, dzen2, dmenu, dunst, roxterm, gtk, slim, ...   : [@install-base](env-utils/install-base.sh)
 ** `neofetch` - A CLI system information tool written in BASH that supports displaying images.

 * `ext` - extended stack - basic linux componenets: xmonad, dzen2, dmenu, dunst, roxterm, gtk, slim, ...   : [@install-ext](.utils/install-ext.sh)

 * `dev` - developer stack: jdk, java, scala, ...   : [@install-dev](env-utils/install-dev.sh)

Hardware addons:

 * `t440s` - lenovo t440s stack: power-mgt, ...   : [@install-t440s](env-utils/install-t440s.sh)


## Suckless programs

### App candidates for mouse-less adventure

 * [xmonad] of course :)

#### Luncher
 * [rofi](https://github.com/DaveDavenport/rofi)
 * [dmenu](https://tools.suckless.org/dmenu/)

### Systems Tools
  * [htop](https://hisham.hm/htop/) Interactive process viewer
	* [glances](https://nicolargo.github.io/glances/) CLI curses-based monitoring tool
  * [ncdu](https://github.com/fabiofalci/sconsify) Disk usage analyzer with an ncurses interface



####
 * [simplenotes](https://github.com/insanum/sncli) `yaourt sncli-git`

#### Browser
 * [qutebrowser](https://www.qutebrowser.org/) A keyboard-driven, vim-like browser based on PyQt5

#### Resources
  - Userscripts: https://github.com/qutebrowser/qutebrowser/tree/master/misc/userscripts


 #### music
 * [sconsify](https://github.com/fabiofalci/sconsify)





 #### lockscreen
 * slimlock
 * consider (https://github.com/i3/i3lock) &  (https://github.com/pavanjadhaw/betterlockscreen)




 ### Guis Tools

 #### Video streaming
 * [obs](https://?/) - `#gui` - Open Broadcast

 #### Photo/ Graphic
 * [krita](https://?/) - `#gui` - Krita


 #### Video editing
 * [kdenlive](https://?/) - `#gui` - Kdenlive

 ### Tools

 Place to collect the best information/tutotrials about tools.

 ### Base

 * [htop](http://hisham.hm/htop/) - ```#console``` - Interactive process viewer
   * [htop explained](https://peteris.rocks/blog/htop/)

 ### Console tools
 * [fzf]() - ```console``` - Command-line fuzzy finder

 #### Network
 * [nmap](https://nmap.org/) - `#Console` - Network Browser
 * [zenmap](https://nmap.org/zenmap/) - `#GUI` - Newtwork Browser


 ### Dev
 * [zeal](https://zealdocs.org/) - `#Console` - API Browser













## Detailed description

#### Base

##### Xmonad - Tiling window manager ...


###### Mod

 * `mod`: windows key

###### Base laout


		 ┌─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┲━━━━━━━━━━┓
		 │  w1 │  w2 │  w3 │  w4 │  w5 │  w6 │  w7 │  w8 │  w9 │  w10│  w11│  w12│  w13┃          ┃
		 │ `   │ 1   │ 2   │ 3   │ 4   │ 5   │ 6   │ 7   │ 8   │ 9   │ 0   │ -   │ =   ┃ ⌫        ┃
		 ┢━────┴━━┱──┴──┬──┴──┬──┴──┬──┴──┬──┴──┬──┴──┬──┴──┬──┴──┬──┴──┬──┴──┬──┴──┬──┺━━┯━━━━━━━┩
		 ┃        ┃close│     │     │     │     │     │     │     │     │dmenu│     │ }   │ |     │
		 ┃ ↹      ┃ q   │ w   │ e   │ r   │ t   │ y   │ u   │ i   │ o   │ p   │ [   │ ]   │ \     │
		 ┣━━━━━━━━┴┱────┴┬────┴┬────┴┬────┴┬────┴┬────┴┬────┴┬────┴┬────┴┬────┴┬────┴┲━━━━┷━━━━━━━┪
		 ┃         ┃     │     │     │ full│     │     │     │     │     │     │     ┃ terminal   ┃
		 ┃ ⇬       ┃ a   │ s   │ d   │ f   │ g   │ h   │ j   │ k   │ l   │ ;   │ '   ┃ ⏎          ┃
		 ┣━━━━━━━━━┻━━┱──┴──┬──┴──┬──┴──┬──┴──┬──┴──┬──┴──┬──┴──┬──┴──┬──┴──┬──┴──┲━━┻━━━━━━━━━━━━┫
		 ┃            ┃     │     │     │     │     │     │     │     │     │     ┃               ┃
		 ┃ ⇧          ┃ z   │ x   │ c   │ v   │ b   │ n   │ m   │ ,   │ .   │ /   ┃ ⇧             ┃
		 ┣━━━━━━━┳━━━━┻━━┳━━┷━━━━┱┴─────┴─────┴─────┴─────┴─────┴─┲━━━┷━━━┳━┷━━━━━╋━━━━━━━┳━━━━━━━┫
		 ┃       ┃ *mod* ┃       ┃         layout                 ┃       ┃       ┃       ┃       ┃
		 ┃ Ctrl  ┃ super ┃ Alt   ┃ Space                          ┃ AltGr ┃ super ┃ menu  ┃ Ctrl  ┃
		 ┗━━━━━━━┻━━━━━━━┻━━━━━━━┹────────────────────────────────┺━━━━━━━┻━━━━━━━┻━━━━━━━┻━━━━━━━┛


 * `mod-` to `mod-=`: workspace w1,w2,...,w13
 * `mod-space`: layout change
 * `mod-f`: window fullscreen




# Xmonad setup

```
xmonad --recompile
xmonad --recstart
```


### Dzen

#### Dzen icons

Sm4tik icons icons pack
![Sm4tik icons] (meta/sm4tik.png)


### How To

1. Check window props:
```xprop ```

2. Check key codes of pressed keys
```shell
xev | grep 'keycode'
```
