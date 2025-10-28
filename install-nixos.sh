#!/bin/bash
sudo mount -o remount,size=24G,noatime /nix/.rw-store
sudo modprobe zram
sudo zramctl /dev/zram0 --algorithm zstd --size 8G
sudo mkswap /dev/zram0
sudo swapon --priority 100 /dev/zram0
sudo nix --experimental-features "nix-command flakes" run 'github:nix-community/disko#disko-install' -- --flake .#nixos --disk main /dev/sda
