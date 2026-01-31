{ ... }:

{
  programs.firefox = {
    enable = true;
    languagePacks = [ "en-GB" ];

    policies = {
      AppAutoUpdate = false;
      BackgroundAppUpdate = false; 
      DisableFirefoxAccounts = true;
      DisableFirefoxStudies = true;
      DisablePocket = true;
      DisableTelemetry = true;
      EnableTrackingProtection = true;
      FirefoxHome = {
        SponsoredTopSites = false;
        Stories = false;
        SponsoredStories = false;
      };
      GenerativeAI = false;
      HardwareAcceleration = true;
      HttpsOnlyMode = true;

      ExtensionSettings =
      let
        moz = short: "https://addons.mozilla.org/firefox/downloads/latest/${short}/latest.xpi";
      in {
        "*".installation_mode = "blocked";

        "uBlock0@raymondhill.net" = {
          install_url = moz "ublock-origin";
          installation_mode = "force_installed";
          updates_disabled = true;
        };
      };
    };

    profiles.default = {
      settings = {
        "browser.ctrlTab.sortByRecentlyUsed" = true;
        "browser.download.useDownloadDir" = false;
        "browser.newtabpage.activity-stream.topSitesRows" = 2;
        "browser.warnOnQuitShortcut" = false;
        "general.smoothScroll" = false;
      };

      search = {
        force = true;
        default = "ddg";
        privateDefault = "ddg";
      };
    };
  };
}
