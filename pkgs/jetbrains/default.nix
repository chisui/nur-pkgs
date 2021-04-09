{ pkgs
, lib
}: with lib; with builtins; with pkgs.lib;
let
  mkIdea = idea: rec {
    ideaProperties = let name = head (filter (hasPrefix "idea") (attrNames (readDir idea)));
                      in fromJavaProperties (readFile "${idea}/${name}/bin/idea.properties");
    mkIdeaProperties = vals: toFile "jetbrains.idea.properties" (ideaProperties + "\n + toJavaPropertiesStr vals);
    mkConfig = cfg: pkgs.mkDerivation {
    };
    mkPlugins = plugins: plgs.mkDerivation {
    };
    mkIdeaEnv =
      { plugins ? []
      , config ? {}
      , sealConfigDir ? false
      }: let
        preparedConfig = foldl' (cfg: p: (p.configOverlay ? id) cfg) config plugins;
        preparedPlugins = mkPlugins plugins;
        ideaProperties = mkIdeaProperties (recursiveUpdate properties {
          idea = {
            config.path = preparedConfig;
            plugins.path = preparedPlugins;
          };
        });
      in 
  };
in rec {
  idea-ultimate = mkIdea pkgs.jetbrains.idea-ultimate
}

