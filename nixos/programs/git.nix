{ pkgs, ... }:
{
  programs.git = {
    enable = true;
    settings = {
      user.name = "dog0sd";
      user.email = "ryhorkanoplich@gmail.com";
      init.defaultBranch = "main";
      core.autocrlf = false;
      core.pager = "less -FX";
      core.quotepath = false;
      branch.sort = "-committerdate";
      advice.skippedCherryPicks = true;
      log.date = "iso";
    };
  };
  programs.gh.enable = true;
}

