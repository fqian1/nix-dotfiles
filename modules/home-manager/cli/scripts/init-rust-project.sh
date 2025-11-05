init-rust-project() {
  # Ensure a project name is provided
  if [ -z "$1" ]; then
    echo "Usage: $0 <project-name>"
    return 1
  fi

  local project_name="$1"

  # Prevent overwriting an existing directory
  if [ -d "$project_name" ]; then
    echo "Error: Directory '$project_name' already exists."
    return 1
  fi

  echo "Creating Rust project '$project_name'..."

  # Create directory and enter it
  mkdir "$project_name"
  cd "$project_name"

  # Flakes require a git repository
  git init &> /dev/null

  # Create the flake.nix file
  cat > flake.nix <<EOF
{
  description = "A simple Rust development flake for ${project_name}";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    crane.url = "github:ipetkov/crane";
    crane.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, flake-utils, crane }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };

        craneLib = crane.lib.\${system};
        rustToolchain = pkgs.rust-bin.stable.latest.default.override {
          extensions = [ "rust-src" ];
        };

        # Add system libraries your crates need here (e.g. pkgs.openssl).
        nativeBuildInputs = with pkgs; [
          pkg-config
        ];

        # Additional tools for the dev shell.
        devTools = with pkgs; [
          rust-analyzer
        ];

      in
      {
        packages.default = craneLib.buildPackage {
          src = craneLib.cleanCargoSource (craneLib.path ./.);
          inherit nativeBuildInputs;
        };

        devShells.default = pkgs.mkShell {
          inputsFrom = [ self.packages.\${system}.default ];
          packages = devTools;
          RUST_SRC_PATH = "\${rustToolchain}/lib/rustlib/src/rust/library";
        };
      }
    );
}
EOF

  # Create .envrc for direnv
  echo "use flake" > .envrc

  # Initialize the Rust project
  cargo init --quiet

  # Add all generated files to Git
  git add .

  # Allow direnv to load the environment
  direnv allow

  echo "Project '$project_name' created and configured."
  echo "You are now in a Nix development shell with the Rust toolchain."
}
