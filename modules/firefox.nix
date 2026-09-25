{ config, ... }:

{
  programs.firefox = {
    enable = true;
    configPath = "${config.xdg.configHome}/mozilla/firefox";
    languagePacks = [ "en-GB" ];

    policies = {
      AppAutoUpdate = false;
      AutofillCreditCardEnabled = false;
      BackgroundAppUpdate = false;
      DisableFirefoxAccounts = true;
      DisableFirefoxStudies = true;
      DisablePocket = true;
      DisableTelemetry = true;
      EnableTrackingProtection.Value = true;
      EncryptedMediaExtensions.Enabled = true;
      FirefoxHome = {
        SponsoredTopSites = false;
        Stories = false;
        SponsoredStories = false;
      };
      FirefoxSuggest.WebSuggestions = false;
      GenerativeAI.Enabled = false;
      HardwareAcceleration = true;
      HttpsOnlyMode = "enabled";
      OfferToSaveLogins = false;
      Permissions = {
        Autoplay.Default = "block-audio-video";
        Notifications.BlockNewRequests = true;
      };

      ExtensionSettings =
        let
          default = {
            installation_mode = "force_installed";
            default_area = "menupanel";
          };
          private = default // {
            private_browsing = true;
          };
          important = private // {
            default_area = "navbar";
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
          "uBlock0@raymondhill.net" = installExtention "ublock-origin" important;
          "{446900e4-71c2-419f-a6a7-df9c091e268b}" = installExtention "bitwarden-password-manager" important;
          "jid1-xUfzOsOFlzSOXg@jetpack" = installExtention "reddit-enhancement-suite" default;
          "sponsorBlocker@ajay.app" = installExtention "sponsorblock" private;
          "firefox@betterttv.net" = installExtention "betterttv" default;
          "addon@darkreader.org" = installExtention "darkreader" default;
        };
    };

    profiles.default = {
      settings = {
        "browser.aboutConfig.showWarning" = false;
        "browser.ai.control.default" = "blocked";
        "browser.ai.control.translations" = "available";
        "browser.ctrlTab.sortByRecentlyUsed" = true;
        "browser.download.useDownloadDir" = false;
        "browser.ml.linkPreview.enabled" = false;
        "browser.newtabpage.activity-stream.showSponsoredCheckboxes" = false;
        "browser.newtabpage.activity-stream.topSitesRows" = 2;
        "browser.tabs.loadBookmarksInBackground" = true;
        "browser.urlbar.trimURLs" = false;
        "browser.warnOnQuitShortcut" = false;
        "general.smoothScroll" = false;
        "intl.locale.requested" = "en-GB,en-US";
        "privacy.globalprivacycontrol.enabled" = true;
        "privacy.userContext.enabled" = false;
        "privacy.userContext.ui.enabled" = false;
      };

      # Customises nav bar element placement.
      # Doesn't fully work and resets any changes but order is what I want
      # settings."browser.uiCustomization.state" = builtins.toJSON {
      #   placements.nav-bar = [
      #     "back-button"
      #     "forward-button"
      #     "stop-reload-button"
      #     "home-button"
      #     "urlbar-container"
      #     "history-panelmenu"
      #     "downloads-button"
      #     "developer-button"
      #     "ublock0_raymondhill_net-browser-action"
      #     "_446900e4-71c2-419f-a6a7-df9c091e268b_-browser-action"
      #     "unified-extensions-button"
      #     "reset-pbm-toolbar-button"
      #   ];
      # };

      search = {
        force = true;
        default = "ddg";
        privateDefault = "ddg";
      };
    };
  };
}
