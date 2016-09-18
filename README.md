# Env! 

Env! is a toolkit for configuration of the efficient work enviroment's for  [ArchLinux](http://xmonad.org/) distribution, based on [Xmonad](http://xmonad.org/)  tiling windows manager.

## Pre-requirements

* Archlinux base base-devel instalaltion 
* Working xorg, you need to be able to launch `startx`
	

## Installation

Clone project:

	git clone https://github.com/hicolour/env.git


Base setup: 

    make base



## Current state


![Screen] (screen.png)


## Packages

Common:

 * `base` - base stack: xmonad, dzen2, dmenu, dunst, roxterm, gtk, slim, ...   : [@install-base](env-utils/install-base.sh)

 * `ext` - extended stack - basic linux componenets: xmonad, dzen2, dmenu, dunst, roxterm, gtk, slim, ...   : [@install-ext](.utils/install-ext.sh)

 * `dev` - developer stack: jdk, java, scala, ...   : [@install-dev](env-utils/install-dev.sh)

Hardware addons:

 * `t440s` - lenovo t440s stack: power-mgt, ...   : [@install-t440s](env-utils/install-t440s.sh)


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



 ### How To:

 Is there any package which shows PID of a window by clicking on it? xprop



### Tools

#### Network scanning
* nmap
* zenmap [G]


# Xmonad setup

### Dzen

#### Dzen icons

Sm4tik icons icons pack
![Sm4tik icons] (meta/sm4tik.png)