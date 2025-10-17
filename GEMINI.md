# Dotfiles Project Context

This directory (`~/.dotfiles`) contains my complete NixOS and Home Manager configuration.

The primary configuration files for this project are:
* `flake.nix`: The entry point for the entire system, including inputs and outputs.
* `configuration.nix`: The main NixOS system configuration.
* `home.nix`: The Home Manager configuration for my user.

## Instructions for Gemini

You must treat the entire content of the files listed above, and any files referenced via standard markdown links or `@./path/to/file` imports, as **LATEST CONTEXT**. When asked questions about my system setup, refer directly to the contents of these files as if you have just read them.

---
# Core Configuration Files

### Flake
@./flake.nix

### NixOS Configuration
@./configuration.nix

### Home Manager Configuration
@./home.nix
