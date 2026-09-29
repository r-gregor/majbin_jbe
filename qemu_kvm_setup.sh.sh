#! /usr/bin/env bash
# 20241113 -- jbe

echo "[i] Updating system ..."
sudo apt update
sudo apt upgrade -y

echo "[i] Installing qemu/kvm and virtmanager ..."
sudo apt install qemu-kvm virt-manager virtinst libvirt-clients bridge-utils libvirt-daemon-system -y

echo "[i] Starting libvirtd service ..."
sudo systemctl enable --now libvirtd
sudo systemctl start libvirtd
sudo systemctl status libvirtd

echo "[i] adding $USER to libvirt and kvm groups ..."
sudo usermod -aG kvm $USER
sudo usermod -aG libvirt $USER

read -r -p "[?] If installation went OK -- test run?"
sudo virt-manager

