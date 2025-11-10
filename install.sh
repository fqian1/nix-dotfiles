#!/bin/sh
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest -- --mode destroy,format,mount hosts/nixos/disk-config.nix
sudo nixos-install --no-write-lock-file --root /mnt --flake .#nixos-laptop
