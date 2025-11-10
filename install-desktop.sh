#!/bin/sh
sudo mount -o remount,size=24G,noatime /nix/.rw-store
sudo modprobe zram
sudo zramctl /dev/zram0 --algorithm zstd --size 8G
sudo mkswap /dev/zram0
sudo swapon --priority 100 /dev/zram0
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest -- --mode destroy,format,mount hosts/nixos-desktop/disk-config.nix
sudo nixos-install --no-write-lock-file --root /mnt --flake .#nixos-desktop
