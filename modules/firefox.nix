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
      EnableTrackingProtection = {
        Value = true;
      };
      FirefoxHome = {
        SponsoredTopSites = false;
        Stories = false;
        SponsoredStories = false;
      };
      GenerativeAI = {
        Enabled = false;
      };
      HardwareAcceleration = true;
      HttpsOnlyMode = "enabled";

      ExtensionSettings =
        let
          default = {
            installation_mode = "force_installed";
            updates_disabled = true;
          };
          private = default // {
            private_browsing = true;
          };
          installExtention =
            name: config:
            {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/${name}/latest.xpi";
            }
            // config;
        in
        {
          "*".installation_mode = "blocked";
          "uBlock0@raymondhill.net" = installExtention "ublock-origin" private;
          "{446900e4-71c2-419f-a6a7-df9c091e268b}" = installExtention "bitwarden-password-manager" default;
          "jid1-xUfzOsOFlzSOXg@jetpack" = installExtention "reddit-enhancement-suite" private;
          "sponsorBlocker@ajay.app" = installExtention "sponsorblock" private;
          "firefox@betterttv.net" = installExtention "betterttv" default;
        };
    };

    profiles.default = {
      settings = {
        "browser.aboutConfig.showWarning" = false;
        "browser.ai.control.default" = "blocked";
        "browser.ai.control.translations" = "available";
        "browser.ctrlTab.sortByRecentlyUsed" = true;
        "browser.download.useDownloadDir" = false;
        "browser.newtabpage.activity-stream.topSitesRows" = 2;
        "browser.newtabpage.activity-stream.showSponsoredCheckboxes" = false;
        "browser.warnOnQuitShortcut" = false;
        "general.smoothScroll" = false;
        "privacy.globalprivacycontrol.enabled" = true;
      };
      # Settings that I can't find a key for:
      # Language: English (GB)
      # DRM Content: true
      # Ask to save passwords: false
      # Save and autofill payment info: false
      # Allow Firefox to improve features, performance and stability between updates: false
      # Notifications: Block new requests
      # Autoplay: Block Audio and Video

      search = {
        force = true;
        default = "ddg";
        privateDefault = "ddg";
      };
    };
  };
}
