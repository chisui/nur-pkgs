{ pkgs }:
{
  firefox-addons = pkgs.recurseIntoAttrs (pkgs.callPackage ./pkgs/firefox-addons { }); 
  chromium-extensions = pkgs.callPackage ./pkgs/chromium-extensions { };
}
