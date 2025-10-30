#!/bin/sh
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest -- --mode destroy,format,mount /hosts/nixos/disk-config.nix
destination="/mnt/home/.dotfiles/";
sudo cp -a ./. "${destination}/";
sudo nixos-install --flake "${destination}#nixos" --show-trace;
