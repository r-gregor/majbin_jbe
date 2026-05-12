#! /usr/bin/env bash
# pripni_spsl.sh

echo "Mounting $HOME/majstaf/fourMeO.img --to-- /mnt/spsl ..."
sudo mkdir -v /mnt/spsl
sudo chattr -i $HOME/majstaf/fourMeO.img
sudo mount -v $HOME/majstaf/fourMeO.img /mnt/spsl

