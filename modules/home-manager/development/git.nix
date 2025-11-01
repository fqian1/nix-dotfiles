{ ... }:
{
  programs = {
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
}
