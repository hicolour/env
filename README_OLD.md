# Env!

__Env!__ is a __zero depdency__ toolkit for configuration of the efficient work environments's that follows  __suckless__ philosophy.

 * To oprate it requires only bash.
 * Currently focused on on [ArchLinux](https://www.archlinux.org/) distribution 

















--------------------------------------------


Rewrite






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





### Pure Gold

#### Terminal

##### Core Utils
* [roxterm](https://github.com/realh/roxterm) - A highly configurable terminal emulator


* [fzf](https://github.com/junegunn/fzf) - Command-line fuzzy finder
```
du -a | awk '{print $2}'  | fzf
```

* [entr](http://eradman.com/entrproject/) - Run arbitrary commands when files change
```
echo ~/.bashrc | entr notify-send "updated"
```

##### SysOps
* [htop](https://hisham.hm/htop/) - Interactive process viewer  / [Htop explianed](https://peteris.rocks/blog/htop/)
* [glances](https://nicolargo.github.io/glances/) -  CLI curses-based monitoring tool
* [ncdu](https://github.com/fabiofalci/sconsify) - Disk usage analyzer with an ncurses interface
* [nmap](https://nmap.org/) - Utility for network discovery and security auditing


* [duf](https://) - Disk Usage/Free Utility

```
 • • •  $ duf
╭────────────────────────────────────────────────────────────────────────────────────────────────╮
│ 5 local devices                                                                                │
├────────────┬─────────┬────────┬────────┬───────────────────────────────┬──────┬────────────────┤
│ MOUNTED ON │    SIZE │   USED │  AVAIL │              USE%             │ TYPE │ FILESYSTEM     │
├────────────┼─────────┼────────┼────────┼───────────────────────────────┼──────┼────────────────┤
│ /          │   88.0G │  15.8G │  67.7G │ [###.................]  18.0% │ ext4 │ /dev/nvme0n1p3 │
│ /boot      │ 1022.0M │  64.2M │ 957.8M │ [#...................]   6.3% │ vfat │ /dev/nvme0n1p1 │
│ /home      │  532.3G │ 445.2G │  60.0G │ [################....]  83.6% │ ext4 │ /dev/nvme0n1p6 │
│ /opt       │   88.0G │   6.6G │  76.9G │ [#...................]   7.5% │ ext4 │ /dev/nvme0n1p5 │
│ /var       │  202.7G │ 126.4G │  65.9G │ [############........]  62.4% │ ext4 │ /dev/nvme0n1p4 │
╰────────────┴─────────┴────────┴────────┴───────────────────────────────┴──────┴────────────────╯
╭─────────────────────────────────────────────────────────────────────────────────────────────────╮
│ 5 special devices                                                                               │
├────────────────┬───────┬────────┬───────┬───────────────────────────────┬──────────┬────────────┤
│ MOUNTED ON     │  SIZE │   USED │ AVAIL │              USE%             │ TYPE     │ FILESYSTEM │
├────────────────┼───────┼────────┼───────┼───────────────────────────────┼──────────┼────────────┤
│ /dev           │ 11.7G │     0B │ 11.7G │                               │ devtmpfs │ dev        │
│ /dev/shm       │ 11.7G │   1.3G │ 10.4G │ [##..................]  10.9% │ tmpfs    │ tmpfs      │
│ /run           │ 11.7G │   2.4M │ 11.7G │ [....................]   0.0% │ tmpfs    │ run        │
│ /run/user/1000 │  2.3G │  56.0K │  2.3G │ [....................]   0.0% │ tmpfs    │ tmpfs      │
│ /tmp           │ 11.7G │ 196.2M │ 11.5G │ [....................]   1.6% │ tmpfs    │ tmpfs      │
╰────────────────┴───────┴────────┴───────┴───────────────────────────────┴──────────┴────────────╯

```



##### Apps

* [joplin](https://joplinapp.org/) - Joplin - a note taking and to-do application with synchronization capabilities



#### X

##### Core
* [xmonad](https://xmonad.org/) - the tilling window manager that rocks

##### Core Utils
* [dmenu](https://tools.suckless.org/dmenu/) - Generic menu for X
* [rofi](https://github.com/DaveDavenport/rofi) - A window switcher, application launcher and dmenu replacement
* [slimlock](https://github.com/dannyn/slimlock) - Unholy screen locker (without SLiM) / consider [i3lock](https://github.com/i3/i3lock), [betterlockscreen](https://github.com/pavanjadhaw/betterlockscreen)

##### Apps
* [qutebrowser](https://www.qutebrowser.org/) A keyboard-driven, vim-like browser based on PyQt5

* [obs](https://?/) - Open Broadcast
* [krita](https://?/) - Edit and paint images
* [kdenlive](https://?/) -  Non-linear video editor for Linux using the MLT video framework

* [zenmap](https://nmap.org/zenmap/) - GUI interface for nmap - network discovery and security auditing

* [zeal](https://zealdocs.org/) - An offline API documentation browser

* [keepassx]() - Password manager

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





####
 * [simplenotes](https://github.com/insanum/sncli) `yaourt sncli-git`


#### Resources
  - Userscripts: https://github.com/qutebrowser/qutebrowser/tree/master/misc/userscripts


 #### music
 * [sconsify](https://github.com/fabiofalci/sconsify)







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
