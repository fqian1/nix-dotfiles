{ pkgs, ... }:
{
  programs.starship = {
    enable = true;

    settings = {
      add_newline = false;
      format = ''[$os$username](color_orange)[$directory](color_yellow)[$git_branch$git_status](color_aqua)[$c$cpp$rust$golang$nodejs$php$java$kotlin$haskell$python](color_blue)[$docker_context$conda$pixi](color_bg3)[$time](color_bg1)$character'';

      palette = "gruvbox_dark";

      palettes.gruvbox_dark = {
        color_fg0 = "#fbf1c7";
        color_bg1 = "#3c3836";
        color_bg3 = "#665c54";
        color_blue = "#458588";
        color_aqua = "#689d6a";
        color_green = "#98971a";
        color_orange = "#d65d0e";
        color_purple = "#b16286";
        color_red = "#cc241d";
        color_yellow = "#d79921";
      };

      os = {
        disabled = false;
        style = "fg:color_orange";
        symbols = {
          Windows = "󰍲";
          Ubuntu = "󰕈";
          SUSE = "";
          Raspbian = "󰐿";
          Mint = "󰣭";
          Macos = "󰀵";
          Manjaro = "";
          Linux = "󰌽";
          Gentoo = "󰣨";
          Fedora = "󰣛";
          Alpine = "";
          Amazon = "";
          Android = "";
          Arch = "󰣇";
          Artix = "󰣇";
          EndeavourOS = "";
          CentOS = "";
          Debian = "󰣚";
          Redhat = "󱄛";
          RedHatEnterprise = "󱄛";
          Pop = "";
        };
      };

      username = {
        show_always = true;
        style_user = "fg:color_orange";
        style_root = "fg:color_orange";
        format = "\\[[$user]($style)\\]";
      };

      directory = {
        style = "fg:color_yellow";
        format = "\\[[$path]($style)\\]";
        truncation_length = 3;
        truncation_symbol = "…/";
        substitutions = {
          "Documents" = "󰈙 ";
          "Downloads" = " ";
          "Music" = "󰝚 ";
          "Pictures" = " ";
          "Developer" = "󰲋 ";
        };
      };

      git_branch = {
        symbol = "";
        style = "fg:color_aqua";
        format = "\\[[$symbol $branch]($style)";
      };

      git_status = {
        style = "fg:color_aqua";
        format = "[($all_status$ahead_behind )]($style)\\]";
      };

      nodejs = {
        symbol = "";
        style = "fg:color_blue";
        format = "\\[[$symbol($version)]($style)\\]";
      };

      c = {
        symbol = " ";
        style = "fg:color_blue";
        format = "\\[[$symbol($version)]($style)\\]";
      };

      cpp = {
        symbol = " ";
        style = "fg:color_blue";
        format = "\\[[$symbol($version)]($style)\\]";
      };

      rust = {
        symbol = "";
        style = "fg:color_blue";
        format = "\\[[$symbol($version)]($style)\\]";
      };

      golang = {
        symbol = "";
        style = "fg:color_blue";
        format = "\\[[$symbol($version)]($style)\\]";
      };

      php = {
        symbol = "";
        style = "fg:color_blue";
        format = "\\[[$symbol($version)]($style)\\]";
      };

      java = {
        symbol = "";
        style = "fg:color_blue";
        format = "\\[[$symbol($version)]($style)\\]";
      };

      kotlin = {
        symbol = "";
        style = "fg:color_blue";
        format = "\\[[$symbol($version)]($style)\\]";
      };

      haskell = {
        symbol = "";
        style = "fg:color_blue";
        format = "\\[[$symbol($version)]($style)\\]";
      };

      python = {
        symbol = "";
        style = "fg:color_blue";
        format = "\\[[$symbol($version)]($style)\\]";
      };

      docker_context = {
        symbol = "";
        style = "fg:color_blue";
        format = "\\[[$symbol($context)]($style)\\]";
      };

      conda = {
        symbol = "";
        style = "fg:color_blue";
        format = "\\[[$symbol($environment)]($style)\\]";
      };

      pixi = {
        style = "fg:color_blue";
        format = "\\[[$symbol($version)($environment)]($style)\\]";
      };

      time = {
        disabled = false;
        time_format = "%R";
        style = "fg:color_bg3";
        format = "\\[[ $time]($style)\\]";
      };

      line_break = {
        disabled = true;
      };

      character = {
        disabled = false;
        success_symbol = "[](bold fg:color_green)";
        error_symbol = "[](bold fg:color_red)";
        vimcmd_symbol = "[](bold fg:color_green)";
        vimcmd_replace_one_symbol = "[](bold fg:color_purple)";
        vimcmd_replace_symbol = "[](bold fg:color_purple)";
        vimcmd_visual_symbol = "[](bold fg:color_yellow)";
      };
    };
  };
}
