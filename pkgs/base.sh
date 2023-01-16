#!/bin/sh

###########################################################################
# Set of base programs required to provide functional unix enviroment
###########################################################################

. ./core/env.sh

apps=(
    bash
    bc                  # Calculate in bash    
    htop
    nmon                # IO top
    glances
    mc
    unzip
    fzf                 # Command-line fuzzy finder
    duf                 # Disk Usage/Free Utility
    neofetch            # A CLI system information tool written in BASH that supports displaying images.
    displaying          # 
    # dosfstools        # Managment of the DOS filesystem - msotlp mkfs.vfat, mkfs.msdos
    # exfat-utils       # exFat utilities
    # ntfsprogs
    dog                 # Command-line DNS client like dig
    bin                 # personal addons
)


env "${apps[@]}"
