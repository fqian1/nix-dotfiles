{ ... }:
{
  home-manager.users.fqian = {
    programs = {
      git = {
        enable = true;
        settings = {
          user = {
            Name = "fqian";
            Email = "francois.qian2@gmail.com";
          };
          safe = {
            directory = [
              "~/.dotfiles"
            ];
          };
        };
      };

      lazygit = {
        enable = true;
        settings = {
          git.commit.signOff = true;
        };
      };

      gh = {
        enable = true;
        settings = {
          editor = "nvim";
          git_protocol = "ssh";
        };
      };
    };
  };
}
