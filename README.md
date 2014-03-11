# Env! 

Quick, convenient and efficient worke enviroment setup tool for  [ArchLinux](http://xmonad.org/) distribution, based on [Xmonad](http://xmonad.org/) tiling window manager.  


## Pre-requirements

* Archlinux base base-devel instalaltion 
* Working xorg:
	

## Installation

Clone project:

	git clone https://github.com/hicolour/env.git


Base setup: 

    make base



## Current state


![Screen] (screen.png)


## Packages

Common:

 * `base` - base stack: xmonad, dzen2, dmenu, dunst, roxterm, gtk, slim, ...   : [@install-base](.utils/install-base.sh)

 * `ext` - extended stack - basic linux componenets: xmonad, dzen2, dmenu, dunst, roxterm, gtk, slim, ...   : [@install-ext](.utils/install-ext.sh)

 * `dev` - developer stack: jdk, java, scala, ...   : [@install-dev](.utils/install-dev.sh)

Hardware addons:

 * `t440s` - lenovo t440s stack: power-mgt, ...   : [@install-t440s](.utils/install-t440s.sh)


## Detailed description

#### Base

##### Xmonad - Tiling window manager ...

 * `mod`: windows key




