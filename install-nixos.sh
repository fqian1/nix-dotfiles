#!/bin/bash
sudo nix --experimental-features "nix-command flakes" run 'github:nix-community/disko#disko-install' -- --flake .#nixos --disk main /dev/sda
