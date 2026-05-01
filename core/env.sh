#!/bin/bash


var=$(pwd)
color() {
      printf '\033[%sm%s\033[m\n' "$@"
      # usage color "31;5" "string"
      # 0 default
      # 5 blink, 1 strong, 4 underlined
      # fg: 31 red,  32 green, 33 yellow, 34 blue, 35 purple, 36 cyan, 37 white
      # bg: 40 black, 41 red, 44 blue, 45 purple
      }
line(){
      echo ------------------------------------------------------------------
}


p(){
      line
      color '32;1' "pacman install : $@"
      line
      sudo pacman -S --noconfirm $@
      }

pp(){
      line
      color '32;1' "pip install : $@"
      line
      sudo pip install $@
}


y(){
      line
      color '32;1' "yaourt install : $@"
      line
      yaourt -S --noconfirm $@
      }

s(){
      line
      color '34;1' "setup : $1"
      color '35;1' "linking : $var/$1 to ~/$2"
      rm -rf ~/$2
      ln -s $var/$1 ~/$2
      }

info(){
  line
  color '32;1' "info : $@"
  line
}

link(){
      color '36;0' "         $1 -> $2"
      rm -rf $2
      ln -s $1 $2
      }

slink(){
      color '36;0' "         $1 -> $2"
      sudo rm -rf $2
      sudo ln -s $1 $2
      }

_spin() {
      local pid=$1 label=$2 spin='-\|/' i=0
      while kill -0 "$pid" 2>/dev/null; do
            printf "\r  [%s] %s..." "${spin:$((i++ % 4)):1}" "$label"
            sleep 0.1
      done
      printf "\r\033[K"
}

_install_pkg() {
      local package=$1
      if [ "${DRY:-}" = "1" ]; then
            color '33;1' "  [dry] would install: $package"
            return 0
      fi

      if pacman -Ss "$package" | grep "^[^ ]*/$package " > /dev/null 2>&1; then
            sudo pacman -S "$package" --noconfirm >> "$ENV_LOG" 2>&1 &
            _spin $! "$package"
            wait $!
      else
            color '37;1' "  ᗧ̿ not in repos, trying aur: $package"
            yay -S "$package" --noconfirm >> "$ENV_LOG" 2>&1 &
            _spin $! "$package (aur)"
            wait $!
      fi
}

env(){

      fname=$(basename $0)
      fbname=${fname%.*}

      local units=($@)
      local total=${#units[@]}
      local step=0
      local failed=()
      local skipped=()

      ENV_LOG="/tmp/env-${fbname}-$(date +%Y%m%d-%H%M%S).log"
      ENV_STATE=".env-state-${fbname}"

      info "Package check ... for $fbname  [${total} units]  log: $ENV_LOG"

      for package in "${units[@]}"; do
            if pacman -Qs "$package" > /dev/null 2>&1; then
                  color '32;1' "  ✓ ᗧ̿ $package"
            else
                  color '34;1' "  ✗ ᗧ̿ $package"
            fi
      done

      echo
      if [ "${DRY:-}" = "1" ]; then
            color '33;1' "  -- dry run, skipping confirmation --"
      else
            read -p "Continue ? [Y/y] " -n 1 -r
            echo
            if ! [[ $REPLY =~ ^[Yy]$ ]]; then
                  exit 0
            fi
      fi

      line

      for package in "${units[@]}"; do
            step=$((step + 1))

            # resume: skip already completed units
            if grep -qx "$package" "$ENV_STATE" 2>/dev/null; then
                  color '32;1' "  [$step/$total] ✓ skip $package  (state file)"
                  skipped+=("$package")
                  continue
            fi

            color '37;1' "  [$step/$total] ᗧ̿ $package"

            pkg_ok=true
            if [ -f "units/$package/unit.sh" ] && grep -q "NO_PKG=true" "units/$package/unit.sh"; then
                  color '34;1' "         no package needed"
            else
                  _install_pkg "$package"
                  if [ $? -eq 0 ]; then
                        color '32;1' "         ✓ installed"
                  else
                        color '31;1' "         ✗ install failed  (see $ENV_LOG)"
                        failed+=("$package")
                        pkg_ok=false
                  fi
            fi

            if [ -f "units/$package/unit.sh" ]; then
                  color '34;1' "         🤖 configuring..."
                  units/$package/unit.sh
            fi

            if $pkg_ok; then
                  echo "$package" >> "$ENV_STATE"
            fi
      done

      # summary
      line
      color '32;1' "  Done: $fbname  [$total units]"
      color '37;1' "  Log:  $ENV_LOG"
      if [ ${#skipped[@]} -gt 0 ]; then
            color '32;1' "  Skipped (already done): ${skipped[*]}"
      fi
      if [ ${#failed[@]} -gt 0 ]; then
            color '31;1' "  Failed:"
            for f in "${failed[@]}"; do
                  color '31;1' "    ✗ $f"
            done
            color '31;1' "  Re-run to retry failed units (state file preserves successes)"
      else
            color '32;1' "  All units succeeded ✓"
      fi
      line
}
