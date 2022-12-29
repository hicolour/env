#!/bin/sh

. ./env-utils/utils.sh


line
color '34;1' "setup : locale-pl" 
line



rm -rf ~/.wine WINEARCH=win32 WINEPREFIX=~/.wine winecfg

winetricks -q atmlib gdiplus ie6 vcrun2005sp1 vcrun2008 fontsmooth-rgb corefonts msxml3 msxml6 vcrun2010

cp env-ps/*.dll ~/.wine/drive_c/windows/system32/


winetricks fontsmooth-rgb





