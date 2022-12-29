# Env!

`Env` is a __zero depdency__ toolkit for configuration of the minimalist & efficient work environments's that follows  __suckless__ philosophy.

 * To operate it requires only bash.
 * Currently optimized for [ArchLinux](https://www.archlinux.org/) distribution 


---

`Env` operates on top of two concepts:
  * pkgs	- predefined packages
  * units 	- configurstion units


`Env` is shipped with set of predefined `pkgs` and `units` that are essential for functional enviroment.
  * `base`
  * `desktop` 
  * `dev`
  * `dev-scala`
  
`Env` `pkgs` and `units` that are specific to your enviroment can managed inside private repository that should be cloned and maintained in the same main directory.


Aditionaly following directories should be considered: 

  * `~/.vault` - directory 
  * `~/.private`




Pkg
---

Package contains the list of units that should be installed & configured

`Env` will try install `unit` package using default package menagers and if `unit` will be defined perform `unit` configuration

```
#!/bin/sh

. ./core/env.sh

units=(
    bc                  # Calculate in bash    
)

env "${units[@]}"

```


Unit
---
`unit.sh` - configuration script

`unit.sh` contains all necesssary steps to configure the `unit` and its functions - in most cases by linking `.dotfiles` 

```
#!/bin/sh

. ./core/env.sh

UNIT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

link $UNIT_DIR/.bashrc $HOME/.bashrc
```

-----


