{ pkgs }:
with pkgs;
with lib;
with builtins;
let
  plugins = fromJSON (fileContents ./plugins.json);
  
  mkSrc = { type, ... }@src:
    if type == "github"
      then fetchFromGitHub (filterAttrs (n: v: n != "type") src)
    else
      abort "unknown src type ${type}";
  
  mkZshPlugin = name: { src, ... }@args: args // {
    inherit name;
    src = mkSrc ({ inherit name; } // src);
  };
in mapAttrs mkZshPlugin plugins