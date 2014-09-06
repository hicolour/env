#!/bin/sh

. ./env-utils/utils.sh


# Wicd
sudo systemctl enable wicd.service


# Network time protocol
sudo ntpd -qg
