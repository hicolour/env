myFgColor="#dcd5c6"
myBgColor="#0e0e0e"

myFocusedFGColor="#72aca9"

myFont="-*-terminus-medium-*-*-*-16-*-*-*-*-*-iso10646-*"

dmenuOptions=" -b -fn $myFont \
-nf $myFgColor \
-nb $myBgColor \
-sf $myFocusedFGColor \
-sb $myBgColor"

exe=$(yeganesh -x -- $dmenuOptions)

eval "exec $exe"

