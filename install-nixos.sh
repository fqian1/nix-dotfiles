#!/bin/bash
sudo mount -o remount,size=24G,noatime /nix/.rw-store
sudo fallocate -l 16G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
swapon --show
sudo nix --experimental-features "nix-command flakes" run 'github:nix-community/disko#disko-install' -- --flake .#nixos --disk main /dev/sda
