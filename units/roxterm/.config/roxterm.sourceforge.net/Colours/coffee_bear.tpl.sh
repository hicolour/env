#!/bin/bash


#background=#0e0e0e
echo '[roxterm colour scheme]
background=#1B1B1B
foreground=#b2a994

0=#353b3e   # black
8=#5a676b   # black-bright

1=#8c414f   # red
9=#ac3f54   # red-bright

2=#678156   # green
10=#839d71  # green-bright

3=#c4a000   # yellow
11=#b8a761  # yellow-bright

4=#6a8a9b   # blue
12=#5b709b  # blue-bright

5=#775681   # magenta
13=#8e5276  # magenta-bright

6=#528e8a   # cyan
14=#72aca9  # cyan-bright

7=#dcd5c6   # white
15=#cdc5b3  # white-bright

cursor=#b2a994
palette_size=16' |\
sed -r 's/#([0-9a-f]{2})([0-9a-f]{2})([0-9a-f]{2})/#\1\1\2\2\3\3/;s/\s+#\s[^\n]+//' \
> coffee_bear
