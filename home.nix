{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: let
  neovim-custom = import ./nvim/neovim.nix {
    inherit (pkgs) symlinkJoin neovim-unwrapped makeWrapper runCommandLocal vimPlugins lib;
  };
in {
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
  };
  home.username = "fqian";
  home.homeDirectory = "/home/fqian";
  home.stateVersion = "25.05";
  home.packages = with pkgs; [
    firefox
    tree
    vim
    ripgrep
    neovim-custom
    rust-analyzer
    lua-language-server
    clang-tools
    jdt-language-server
    pyright
    nil
    wget
    waybar
    hyprpaper
    alejandra
    nerd-fonts.fira-code
  ];

  programs.swaylock = {
    enable = true;
  };

  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      add_newline = false;
      command_timeout = 500;
      continuation_prompt = "[∙](bright-black) ";
      format = ''
        [](color_orange)\
        $os\
        $username\
        [](bg:color_yellow fg:color_orange)\
        $directory\
        [](fg:color_yellow bg:color_aqua)\
        $git_branch\
        $git_status\
        [](fg:color_aqua bg:color_blue)\
        $c\
        $cpp\
        $rust\
        $golang\
        $nodejs\
        $php\
        $java\
        $kotlin\
        $haskell\
        $python\
        [](fg:color_blue bg:color_bg3)\
        $docker_context\
        $conda\
        $pixi\
        [](fg:color_bg3 bg:color_bg1)\
        $time\
        [ ](fg:color_bg1)\
        $line_break$character'';
      scan_timeout = 30;

      aws = {
        format = "[$symbol($profile )(($region) )([$duration] )]($style)";
        symbol = "🅰 ";
        style = "bold yellow";
        disabled = false;
        expiration_symbol = "X";
        force_display = false;
      };
      aws.region_aliases = {};
      aws.profile_aliases = {};
      azure = {
        format = "[$symbol($subscription)([$duration])]($style) ";
        symbol = "ﴃ ";
        style = "blue bold";
        disabled = true;
      };
      battery = {
        format = "[$symbol$percentage]($style) ";
        charging_symbol = " ";
        discharging_symbol = " ";
        empty_symbol = " ";
        full_symbol = " ";
        unknown_symbol = " ";
        disabled = false;
        display = [
          {
            style = "red bold";
            threshold = 10;
          }
        ];
      };
      buf = {
        format = "[$symbol ($version)]($style)";
        version_format = "v$raw";
        symbol = "";
        style = "bold blue";
        disabled = false;
        detect_extensions = [];
        detect_files = [
          "buf.yaml"
          "buf.gen.yaml"
          "buf.work.yaml"
        ];
        detect_folders = [];
      };
      c = {
        format = "[$symbol($version(-$name) )]($style)";
        version_format = "v$raw";
        style = "fg:149 bold bg:0x86BBD8";
        symbol = " ";
        disabled = false;
        detect_extensions = [
          "c"
          "h"
        ];
        detect_files = [];
        detect_folders = [];
        commands = [
          [
            "cc"
            "--version"
          ]
          [
            "gcc"
            "--version"
          ]
          [
            "clang"
            "--version"
          ]
        ];
      };
      character = {
        format = "$symbol ";
        vicmd_symbol = "[❮](bold green)";
        disabled = false;
        success_symbol = "[➜](bold green) ";
        error_symbol = "[✗](bold red) ";
      };
      cmake = {
        format = "[$symbol($version )]($style)";
        version_format = "v$raw";
        symbol = "△ ";
        style = "bold blue";
        disabled = false;
        detect_extensions = [];
        detect_files = [
          "CMakeLists.txt"
          "CMakeCache.txt"
        ];
        detect_folders = [];
      };
      cmd_duration = {
        min_time = 2000;
        format = "⏱ [$duration]($style) ";
        style = "yellow bold";
        show_milliseconds = false;
        disabled = false;
        show_notifications = false;
        min_time_to_notify = 45000;
      };
      cobol = {
        format = "[$symbol($version )]($style)";
        version_format = "v$raw";
        symbol = "⚙️ ";
        style = "bold blue";
        disabled = false;
        detect_extensions = [
          "cbl"
          "cob"
          "CBL"
          "COB"
        ];
        detect_files = [];
        detect_folders = [];
      };
      conda = {
        truncation_length = 1;
        format = "[$symbol$environment]($style) ";
        symbol = " ";
        style = "green bold";
        ignore_base = true;
        disabled = false;
      };
      container = {
        format = "[$symbol [$name]]($style) ";
        symbol = "⬢";
        style = "red bold dimmed";
        disabled = false;
      };
      crystal = {
        format = "[$symbol($version )]($style)";
        version_format = "v$raw";
        symbol = "🔮 ";
        style = "bold red";
        disabled = false;
        detect_extensions = ["cr"];
        detect_files = ["shard.yml"];
        detect_folders = [];
      };
      dart = {
        format = "[$symbol($version )]($style)";
        version_format = "v$raw";
        symbol = "🎯 ";
        style = "bold blue";
        disabled = false;
        detect_extensions = ["dart"];
        detect_files = [
          "pubspec.yaml"
          "pubspec.yml"
          "pubspec.lock"
        ];
        detect_folders = [".dart_tool"];
      };
      deno = {
        format = "[$symbol($version )]($style)";
        version_format = "v$raw";
        symbol = "🦕 ";
        style = "green bold";
        disabled = false;
        detect_extensions = [];
        detect_files = [
          "deno.json"
          "deno.jsonc"
          "mod.ts"
          "deps.ts"
          "mod.js"
          "deps.js"
        ];
        detect_folders = [];
      };
      directory = {
        disabled = false;
        fish_style_pwd_dir_length = 0;
        format = "[$path]($style)[$read_only]($read_only_style) ";
        home_symbol = "~";
        read_only = " ";
        read_only_style = "red";
        repo_root_format = "[$before_root_path]($style)[$repo_root]($repo_root_style)[$path]($style)[$read_only]($read_only_style) ";
        style = "cyan bold bg:0xDA627D";
        truncate_to_repo = true;
        truncation_length = 3;
        truncation_symbol = "…/";
        use_logical_path = true;
        use_os_path_sep = true;
      };
      directory.substitutions = {
        # Here is how you can shorten some long paths by text replacement;
        # similar to mapped_locations in Oh My Posh:;
        "Documents" = " ";
        "Downloads" = " ";
        "Music" = " ";
        "Pictures" = " ";
        # Keep in mind that the order matters. For example:;
        # "Important Documents" = "  ";
        # will not be replaced, because "Documents" was already substituted before.;
        # So either put "Important Documents" before "Documents" or use the substituted version:;
        # "Important  " = "  ";
        "Important " = " ";
      };
      docker_context = {
        format = "[$symbol$context]($style) ";
        style = "blue bold bg:0x06969A";
        symbol = " ";
        only_with_files = true;
        disabled = false;
        detect_extensions = [];
        detect_files = [
          "docker-compose.yml"
          "docker-compose.yaml"
          "Dockerfile"
        ];
        detect_folders = [];
      };
      dotnet = {
        format = "[$symbol($version )(🎯 $tfm )]($style)";
        version_format = "v$raw";
        symbol = "🥅 ";
        style = "blue bold";
        heuristic = true;
        disabled = false;
        detect_extensions = [
          "csproj"
          "fsproj"
          "xproj"
        ];
        detect_files = [
          "global.json"
          "project.json"
          "Directory.Build.props"
          "Directory.Build.targets"
          "Packages.props"
        ];
        detect_folders = [];
      };
      elixir = {
        format = "[$symbol($version (OTP $otp_version) )]($style)";
        version_format = "v$raw";
        style = "bold purple bg:0x86BBD8";
        symbol = " ";
        disabled = false;
        detect_extensions = [];
        detect_files = ["mix.exs"];
        detect_folders = [];
      };
      elm = {
        format = "[$symbol($version )]($style)";
        version_format = "v$raw";
        style = "cyan bold bg:0x86BBD8";
        symbol = " ";
        disabled = false;
        detect_extensions = ["elm"];
        detect_files = [
          "elm.json"
          "elm-package.json"
          ".elm-version"
        ];
        detect_folders = ["elm-stuff"];
      };
      env_var = {};
      env_var.SHELL = {
        format = "[$symbol($env_value )]($style)";
        style = "grey bold italic dimmed";
        symbol = "e:";
        disabled = true;
        variable = "SHELL";
        default = "unknown shell";
      };
      env_var.USER = {
        format = "[$symbol($env_value )]($style)";
        style = "grey bold italic dimmed";
        symbol = "e:";
        disabled = true;
        default = "unknown user";
      };
      erlang = {
        format = "[$symbol($version )]($style)";
        version_format = "v$raw";
        symbol = " ";
        style = "bold red";
        disabled = false;
        detect_extensions = [];
        detect_files = [
          "rebar.config"
          "erlang.mk"
        ];
        detect_folders = [];
      };
      fill = {
        style = "bold black";
        symbol = ".";
        disabled = false;
      };
      gcloud = {
        format = "[$symbol$account(@$domain)(($region))(($project))]($style) ";
        symbol = "☁️ ";
        style = "bold blue";
        disabled = false;
      };
      gcloud.project_aliases = {};
      gcloud.region_aliases = {};
      git_branch = {
        format = "[$symbol$branch(:$remote_branch)]($style) ";
        symbol = " ";
        style = "bold purple bg:0xFCA17D";
        truncation_length = 9223372036854775807;
        truncation_symbol = "…";
        only_attached = false;
        always_show_remote = false;
        ignore_branches = [];
        disabled = false;
      };
      git_commit = {
        commit_hash_length = 7;
        format = "[($hash$tag)]($style) ";
        style = "green bold";
        only_detached = true;
        disabled = false;
        tag_symbol = " 🏷  ";
        tag_disabled = true;
      };
      git_metrics = {
        added_style = "bold green";
        deleted_style = "bold red";
        only_nonzero_diffs = true;
        format = "([+$added]($added_style) )([-$deleted]($deleted_style) )";
        disabled = false;
      };
      git_state = {
        am = "AM";
        am_or_rebase = "AM/REBASE";
        bisect = "BISECTING";
        cherry_pick = "🍒PICKING(bold red)";
        disabled = false;
        format = "([$state( $progress_current/$progress_total)]($style)) ";
        merge = "MERGING";
        rebase = "REBASING";
        revert = "REVERTING";
        style = "bold yellow";
      };
      git_status = {
        ahead = "🏎💨$count";
        behind = "😰$count";
        conflicted = "🏳";
        deleted = "🗑";
        disabled = false;
        diverged = "😵";
        format = "([[$all_status$ahead_behind]]($style) )";
        ignore_submodules = false;
        modified = "📝";
        renamed = "👅";
        staged = "[++($count)](green)";
        stashed = "📦";
        style = "red bold bg:0xFCA17D";
        untracked = "🤷";
        up_to_date = "✓";
      };
      golang = {
        format = "[$symbol($version )]($style)";
        version_format = "v$raw";
        symbol = " ";
        style = "bold cyan bg:0x86BBD8";
        disabled = false;
        detect_extensions = ["go"];
        detect_files = [
          "go.mod"
          "go.sum"
          "glide.yaml"
          "Gopkg.yml"
          "Gopkg.lock"
          ".go-version"
        ];
        detect_folders = ["Godeps"];
      };
      haskell = {
        format = "[$symbol($version )]($style)";
        version_format = "v$raw";
        symbol = "λ ";
        style = "bold purple bg:0x86BBD8";
        disabled = false;
        detect_extensions = [
          "hs"
          "cabal"
          "hs-boot"
        ];
        detect_files = [
          "stack.yaml"
          "cabal.project"
        ];
        detect_folders = [];
      };
      helm = {
        format = "[$symbol($version )]($style)";
        version_format = "v$raw";
        symbol = "⎈ ";
        style = "bold white";
        disabled = false;
        detect_extensions = [];
        detect_files = [
          "helmfile.yaml"
          "Chart.yaml"
        ];
        detect_folders = [];
      };
      hg_branch = {
        symbol = " ";
        style = "bold purple";
        format = "on [$symbol$branch]($style) ";
        truncation_length = 9223372036854775807;
        truncation_symbol = "…";
        disabled = true;
      };
      hostname = {
        disabled = false;
        format = "[$ssh_symbol](blue dimmed bold)[$hostname]($style) ";
        ssh_only = false;
        style = "green dimmed bold";
        trim_at = ".";
      };
      java = {
        disabled = false;
        format = "[$symbol($version )]($style)";
        style = "red dimmed bg:0x86BBD8";
        symbol = " ";
        version_format = "v$raw";
        detect_extensions = [
          "java"
          "class"
          "jar"
          "gradle"
          "clj"
          "cljc"
        ];
        detect_files = [
          "pom.xml"
          "build.gradle.kts"
          "build.sbt"
          ".java-version"
          "deps.edn"
          "project.clj"
          "build.boot"
        ];
        detect_folders = [];
      };
      jobs = {
        threshold = 1;
        symbol_threshold = 0;
        number_threshold = 2;
        format = "[$symbol$number]($style) ";
        symbol = "✦";
        style = "bold blue";
        disabled = false;
      };
      julia = {
        disabled = false;
        format = "[$symbol($version )]($style)";
        style = "bold purple bg:0x86BBD8";
        symbol = " ";
        version_format = "v$raw";
        detect_extensions = ["jl"];
        detect_files = [
          "Project.toml"
          "Manifest.toml"
        ];
        detect_folders = [];
      };
      kotlin = {
        format = "[$symbol($version )]($style)";
        version_format = "v$raw";
        symbol = "🅺 ";
        style = "bold blue";
        kotlin_binary = "kotlin";
        disabled = false;
        detect_extensions = [
          "kt"
          "kts"
        ];
        detect_files = [];
        detect_folders = [];
      };
      kubernetes = {
        disabled = false;
        format = "[$symbol$context( ($namespace))]($style) in ";
        style = "cyan bold";
        symbol = "⛵ ";
      };
      kubernetes.context_aliases = {};
      line_break = {
        disabled = false;
      };
      localip = {
        disabled = false;
        format = "[@$localipv4]($style) ";
        ssh_only = false;
        style = "yellow bold";
      };
      lua = {
        format = "[$symbol($version )]($style)";
        version_format = "v$raw";
        symbol = "🌙 ";
        style = "bold blue";
        lua_binary = "lua";
        disabled = false;
        detect_extensions = ["lua"];
        detect_files = [".lua-version"];
        detect_folders = ["lua"];
      };
      memory_usage = {
        disabled = false;
        format = "$symbol[$ram( | $swap)]($style) ";
        style = "white bold dimmed";
        symbol = " ";
        # threshold = 75;
        threshold = -1;
      };
      nim = {
        format = "[$symbol($version )]($style)";
        style = "yellow bold bg:0x86BBD8";
        symbol = " ";
        version_format = "v$raw";
        disabled = false;
        detect_extensions = [
          "nim"
          "nims"
          "nimble"
        ];
        detect_files = ["nim.cfg"];
        detect_folders = [];
      };
      nix_shell = {
        format = "[$symbol$state( ($name))]($style) ";
        disabled = false;
        impure_msg = "[impure](bold red)";
        pure_msg = "[pure](bold green)";
        style = "bold blue";
        symbol = " ";
      };
      nodejs = {
        format = "[$symbol($version )]($style)";
        not_capable_style = "bold red";
        style = "bold green bg:0x86BBD8";
        symbol = " ";
        version_format = "v$raw";
        disabled = false;
        detect_extensions = [
          "js"
          "mjs"
          "cjs"
          "ts"
          "mts"
          "cts"
        ];
        detect_files = [
          "package.json"
          ".node-version"
          ".nvmrc"
        ];
        detect_folders = ["node_modules"];
      };
      ocaml = {
        format = "[$symbol($version )(($switch_indicator$switch_name) )]($style)";
        global_switch_indicator = "";
        local_switch_indicator = "*";
        style = "bold yellow";
        symbol = "🐫 ";
        version_format = "v$raw";
        disabled = false;
        detect_extensions = [
          "opam"
          "ml"
          "mli"
          "re"
          "rei"
        ];
        detect_files = [
          "dune"
          "dune-project"
          "jbuild"
          "jbuild-ignore"
          ".merlin"
        ];
        detect_folders = [
          "_opam"
          "esy.lock"
        ];
      };
      openstack = {
        format = "[$symbol$cloud(($project))]($style) ";
        symbol = "☁️  ";
        style = "bold yellow";
        disabled = false;
      };
      package = {
        format = "[$symbol$version]($style) ";
        symbol = "📦 ";
        style = "208 bold";
        display_private = false;
        disabled = false;
        version_format = "v$raw";
      };
      perl = {
        format = "[$symbol($version )]($style)";
        version_format = "v$raw";
        symbol = "🐪 ";
        style = "149 bold";
        disabled = false;
        detect_extensions = [
          "pl"
          "pm"
          "pod"
        ];
        detect_files = [
          "Makefile.PL"
          "Build.PL"
          "cpanfile"
          "cpanfile.snapshot"
          "META.json"
          "META.yml"
          ".perl-version"
        ];
        detect_folders = [];
      };
      php = {
        format = "[$symbol($version )]($style)";
        version_format = "v$raw";
        symbol = "🐘 ";
        style = "147 bold";
        disabled = false;
        detect_extensions = ["php"];
        detect_files = [
          "composer.json"
          ".php-version"
        ];
        detect_folders = [];
      };
      pulumi = {
        format = "[$symbol($username@)$stack]($style) ";
        version_format = "v$raw";
        symbol = " ";
        style = "bold 5";
        disabled = false;
      };
      purescript = {
        format = "[$symbol($version )]($style)";
        version_format = "v$raw";
        symbol = "<=> ";
        style = "bold white";
        disabled = false;
        detect_extensions = ["purs"];
        detect_files = ["spago.dhall"];
        detect_folders = [];
      };
      python = {
        format = "[$symbol$pyenv_prefix($version )(($virtualenv) )]($style)";
        python_binary = [
          "python"
          "python3"
          "python2"
        ];
        pyenv_prefix = "pyenv ";
        pyenv_version_name = true;
        style = "yellow bold";
        symbol = "🐍 ";
        version_format = "v$raw";
        disabled = false;
        detect_extensions = ["py"];
        detect_files = [
          "requirements.txt"
          ".python-version"
          "pyproject.toml"
          "Pipfile"
          "tox.ini"
          "setup.py"
          "__init__.py"
        ];
        detect_folders = [];
      };
      red = {
        format = "[$symbol($version )]($style)";
        version_format = "v$raw";
        symbol = "🔺 ";
        style = "red bold";
        disabled = false;
        detect_extensions = [
          "red"
          "reds"
        ];
        detect_files = [];
        detect_folders = [];
      };
      rlang = {
        format = "[$symbol($version )]($style)";
        version_format = "v$raw";
        style = "blue bold";
        symbol = "📐 ";
        disabled = false;
        detect_extensions = [
          "R"
          "Rd"
          "Rmd"
          "Rproj"
          "Rsx"
        ];
        detect_files = [".Rprofile"];
        detect_folders = [".Rproj.user"];
      };
      ruby = {
        format = "[$symbol($version )]($style)";
        version_format = "v$raw";
        symbol = "💎 ";
        style = "bold red";
        disabled = false;
        detect_extensions = ["rb"];
        detect_files = [
          "Gemfile"
          ".ruby-version"
        ];
        detect_folders = [];
        detect_variables = [
          "RUBY_VERSION"
          "RBENV_VERSION"
        ];
      };
      rust = {
        format = "[$symbol($version )]($style)";
        version_format = "v$raw";
        symbol = "🦀 ";
        style = "bold red bg:0x86BBD8";
        disabled = false;
        detect_extensions = ["rs"];
        detect_files = ["Cargo.toml"];
        detect_folders = [];
      };
      scala = {
        format = "[$symbol($version )]($style)";
        version_format = "v$raw";
        disabled = false;
        style = "red bold";
        symbol = "🆂 ";
        detect_extensions = [
          "sbt"
          "scala"
        ];
        detect_files = [
          ".scalaenv"
          ".sbtenv"
          "build.sbt"
        ];
        detect_folders = [".metals"];
      };
      shell = {
        format = "[$indicator]($style) ";
        bash_indicator = "bsh";
        cmd_indicator = "cmd";
        elvish_indicator = "esh";
        fish_indicator = "";
        ion_indicator = "ion";
        nu_indicator = "nu";
        powershell_indicator = "_";
        style = "white bold";
        tcsh_indicator = "tsh";
        unknown_indicator = "mystery shell";
        xonsh_indicator = "xsh";
        zsh_indicator = "zsh";
        disabled = false;
      };
      shlvl = {
        threshold = 2;
        format = "[$symbol$shlvl]($style) ";
        symbol = "↕️  ";
        repeat = false;
        style = "bold yellow";
        disabled = true;
      };
      singularity = {
        format = "[$symbol[$env]]($style) ";
        style = "blue bold dimmed";
        symbol = "📦 ";
        disabled = false;
      };
      spack = {
        truncation_length = 1;
        format = "[$symbol$environment]($style) ";
        symbol = "🅢 ";
        style = "blue bold";
        disabled = false;
      };
      status = {
        format = "[$symbol$status]($style) ";
        map_symbol = true;
        not_executable_symbol = "🚫";
        not_found_symbol = "🔍";
        pipestatus = false;
        pipestatus_format = "[$pipestatus] => [$symbol$common_meaning$signal_name$maybe_int]($style)";
        pipestatus_separator = "|";
        recognize_signal_code = true;
        signal_symbol = "⚡";
        style = "bold red bg:blue";
        success_symbol = "🟢 SUCCESS";
        symbol = "🔴 ";
        disabled = true;
      };
      sudo = {
        format = "[as $symbol]($style)";
        symbol = "🧙 ";
        style = "bold blue";
        allow_windows = false;
        disabled = true;
      };
      swift = {
        format = "[$symbol($version )]($style)";
        version_format = "v$raw";
        symbol = "🐦 ";
        style = "bold 202";
        disabled = false;
        detect_extensions = ["swift"];
        detect_files = ["Package.swift"];
        detect_folders = [];
      };
      terraform = {
        format = "[$symbol$workspace]($style) ";
        version_format = "v$raw";
        symbol = "💠 ";
        style = "bold 105";
        disabled = false;
        detect_extensions = [
          "tf"
          "tfplan"
          "tfstate"
        ];
        detect_files = [];
        detect_folders = [".terraform"];
      };
      time = {
        format = "[$symbol $time]($style) ";
        style = "bold yellow bg:0x33658A";
        use_12hr = false;
        disabled = false;
        utc_time_offset = "local";
        # time_format = "%R"; # Hour:Minute Format;
        time_format = "%T"; # Hour:Minute:Seconds Format;
        time_range = "-";
      };
      username = {
        format = "[$user]($style) ";
        show_always = true;
        style_root = "red bold bg:0x9A348E";
        style_user = "yellow bold bg:0x9A348E";
        disabled = false;
      };
      vagrant = {
        format = "[$symbol($version )]($style)";
        version_format = "v$raw";
        symbol = "⍱ ";
        style = "cyan bold";
        disabled = false;
        detect_extensions = [];
        detect_files = ["Vagrantfile"];
        detect_folders = [];
      };
      vcsh = {
        symbol = "";
        style = "bold yellow";
        format = "[$symbol$repo]($style) ";
        disabled = false;
      };
      vlang = {
        format = "[$symbol($version )]($style)";
        version_format = "v$raw";
        symbol = "V ";
        style = "blue bold";
        disabled = false;
        detect_extensions = ["v"];
        detect_files = [
          "v.mod"
          "vpkg.json"
          ".vpkg-lock.json"
        ];
        detect_folders = [];
      };
      zig = {
        format = "[$symbol($version )]($style)";
        version_format = "v$raw";
        symbol = "↯ ";
        style = "bold yellow";
        disabled = false;
        detect_extensions = ["zig"];
        detect_files = [];
        detect_folders = [];
      };
      custom = {
      };
    };
  };

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set -g fish_greeting ""
    '';
    shellAliases = {
      test = "echo test";
      nrs = "sudo nixos-rebuild switch --flake ~/dotfiles/#nixos";
      gdot = ''cd ~/dotfiles && git add . && git commit -m "auto: $(date +%F_%T)"'';
      lock = "swaylock -c 000000";
      vim = "nvim";
    };
  };

  programs.bash = {
    initExtra = ''
      if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
      then
        shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
        exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
      fi
    '';
  };

  programs.zellij = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.git = {
    enable = true;
    userName = "fqian";
    userEmail = "francois.qian2@gmail.com";
  };

  programs.kitty = {
    enable = true;
    themeFile = "Constant_Perceptual_Luminosity_dark";
    settings = {
      font_family = "FiraCode Nerd Font";
      font_size = 12.0;
      background_opacity = "0.8";
      shell = "${pkgs.fish}/bin/fish";
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      exec-once = [
        "waybar & hyprpaper & mako & hypridle"
      ];
      monitor = [
        "HDMI-A-1,1920x1080@239.96,0x0,1"
        "DP-1,3440x1440@240,auto-right,1"
      ];

      input = {
        kb_layout = "gb";
        kb_variant = "";
        kb_model = "";
        accel_profile = "adaptive";
        follow_mouse = 2;
        touchpad = {
          natural_scroll = "no";
          disable_while_typing = true;
          "tap-to-click" = false;
          scroll_factor = 0.7;
        };
        sensitivity = 0;
      };

      general = {
        gaps_in = 0;
        gaps_out = 0;
        border_size = 3;
        "col.active_border" = "rgba(595959ff)";
        "col.inactive_border" = "rgba(000000ff)";
        no_border_on_floating = true;
        layout = "master";
        allow_tearing = false;
      };

      decoration = {
        rounding = 0;
        active_opacity = 1;
        inactive_opacity = 1;
        fullscreen_opacity = 1;
        blur = {enabled = false;};
      };

      animations = {
        enabled = false;
        first_launch_animation = true;
      };

      master = {
        allow_small_split = true;
        mfact = 0.70;
        inherit_fullscreen = false;
      };

      gestures.workspace_swipe = "off";

      misc = {
        force_default_wallpaper = 1;
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        vfr = true;
      };

      windowrulev2 = ["suppressevent maximize, class:.*"];

      "$mainMod" = "Alt_L";
      "$terminal" = "kitty";
      "$fileManager" = "dolphin";
      "$browser" = "firefox-nightly";
      "$menu" = "wofi --show drun";

      bind = [
        "$mainMod, RETURN, exec, $terminal"
        "$mainMod, Q, killactive,"
        "$mainMod SHIFT, Q, exit,"
        "$mainMod, Space, exec, $menu"
        "$mainMod, E, exec, $browser"
        "$mainMod, F, fullscreen"
        "$mainMod CTRL, L, exec, hyprlock"
        "$mainMod, h, movefocus, l"
        "$mainMod, j, movefocus, d"
        "$mainMod, k, movefocus, u"
        "$mainMod, l, movefocus, r"
        "$mainMod SUPER, h, movewindow, l"
        "$mainMod SUPER, j, movewindow, d"
        "$mainMod SUPER, k, movewindow, u"
        "$mainMod SUPER, l, movewindow, r"
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"
      ];

      binde = [
        "$mainMod SHIFT, h, resizeactive, -20 0"
        "$mainMod SHIFT, j, resizeactive, 0 20"
        "$mainMod SHIFT, k, resizeactive, 0 -20"
        "$mainMod SHIFT, l, resizeactive, 20 0"
      ];
    };
  };

  programs.home-manager.enable = true;
}
