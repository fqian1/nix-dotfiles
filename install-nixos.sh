#!/bin/bash
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest -- --mode destroy,format,mount /hosts/nixos/disk-config.nix
nixos-install --flake .#nixos
