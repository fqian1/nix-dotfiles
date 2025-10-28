#!/bin/bash
sudo mount -o remount,size=24G,noatime /nix/.rw-store
sudo nix --experimental-features "nix-command flakes" run 'github:nix-community/disko#disko-install' -- --flake .#nixos --disk main /dev/sda
