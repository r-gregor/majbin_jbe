#! /usr/bin/env bash


killall picom 2>/dev/null; picom --experimental-backend --config ~/.config/picom/picom.conf -b

