#!/bin/bash

#source ~/.private/passwords.sh

# ----------------
# Initial check
# ----------------
(
~/.dzen/status_checks/status_weather.sh
~/.dzen/status_checks/status_net_balance.sh
~/.dzen/status_checks/status_mail.sh
~/.dzen/status_checks/status_rss.sh
~/.dzen/status_checks/status_packages.sh
~/.dzen/status_checks/status_power.sh
~/.dzen/status_checks/status_date.sh
~/.dzen/status_checks/status_clock.sh
~/.dzen/status_checks/status_cpu.sh
~/.dzen/status_checks/status_memory.sh
~/.dzen/status_checks/status_net.sh
) &

#===
(while :; do

~/.dzen/status_checks/status_net_balance.sh &

sleep 30m; done ) &

#===
(while :; do

~/.dzen/status_checks/status_weather.sh &

sleep 15m; done ) &

#===
(while :; do

~/.dzen/status_checks/status_crypto.sh &

sleep 5m; done ) &

#===
(while :; do

~/.dzen/status_checks/status_mail.sh &
~/.dzen/status_checks/status_rss.sh &
~/.dzen/status_checks/status_packages.sh &
~/.dzen/status_checks/status_date.sh &
~/.dzen/status_checks/status_clock.sh &

~/.dzen/status_checks/status_crypto_miner.sh &
~/.dzen/status_checks/status_crypto_market.sh &

sleep 1m; done ) &

#===
(while :; do

~/.dzen/status_checks/status_currency.sh &

sleep 30s; done ) &

#===
(while :; do

~/.dzen/status_checks/status_cpu.sh &
~/.dzen/status_checks/status_memory.sh &
~/.dzen/status_checks/status_power.sh &
~/.dzen/status_checks/status_net.sh &


sleep 10s; done ) &



# #===
# (while :; do

# ~/.dzen/status_checks/status_dropbox.sh &
# ~/.dzen/status_checks/status_power.sh

# sleep 1s; done ) &
