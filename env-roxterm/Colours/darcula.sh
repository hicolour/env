#!/bin/bash


#background=#0e0e0e
echo '[roxterm colour scheme]
background=#3d3f41
foreground=#d2d8d9

0=#25292a           # HOST
1=#f24840           # SYNTAX_STRING
2=#f24840           # COMMAND
3=#b68800           # COMMAND_COLOR2
4=#2075c7           # PATH
5=#797fd4           # SYNTAX_VAR
6=#15968d           # PROMP
7=#d2d8d9           #

8=#25292a            #
9=#f24840           # COMMAND_ERROR
10=#629655           # EXEC
11=#b68800           #
12=#2075c7           # FOLDER
13=#797fd4           #
14=#15968d           #
15=#d2d8d9           #

cursor=#d2d8d9
palette_size=16' |\
sed -r 's/#([0-9a-f]{2})([0-9a-f]{2})([0-9a-f]{2})/#\1\1\2\2\3\3/;s/\s+#\s[^\n]+//' > darcula2
