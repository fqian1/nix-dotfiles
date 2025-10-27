#!/bin/bash
sudo nix run 'github:nix-community/disko#disko-install' -- --flake .#nixos --disk main /dev/sda
