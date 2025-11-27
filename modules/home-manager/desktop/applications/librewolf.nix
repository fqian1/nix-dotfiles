{
  config,
  pkgs,
  ...
}:
{
  programs.librewolf = {
    enable = true;
    profiles.default = {
      isDefault = true;
      settings = {
        # GFX / CACHE / PERFORMANCE
        "gfx.canvas.accelerated.cache-size" = 512;
        "gfx.content.skia-font-cache-size" = 40;
        "browser.sessionhistory.max_total_viewers" = 8;
        "media.memory_cache_max_size" = 65536;
        "media.cache_readahead_limit" = 3600;
        "media.cache_resume_threshold" = 1800;
        "image.mem.decode_bytes_at_a_time" = 32768;

        # NETWORK PERFORMANCE
        "network.http.max-connections" = 1800;
        "network.http.max-persistent-connections-per-server" = 10;
        "network.http.max-urgent-start-excessive-connections-per-host" = 5;
        "network.ssl_tokens_cache_capacity" = 10240;

        # EXPERIMENTAL
        "layout.css.grid-template-masonry-value.enabled" = true;

        # UI / BEHAVIOR
        "browser.urlbar.trimHttps" = true;
        "browser.urlbar.untrimOnUserInteraction.featureGate" = true;
        "browser.aboutConfig.showWarning" = false;
        "browser.profiles.enabled" = true;
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "browser.compactmode.show" = true;
        "browser.privateWindowSeparation.enabled" = false;
        "full-screen-api.transition-duration.enter" = "0 0";
        "full-screen-api.transition-duration.leave" = "0 0";
        "full-screen-api.warning.timeout" = 0;
        "browser.download.open_pdf_attachments_inline" = true;
        "browser.bookmarks.openInTabClosesMenu" = false;
        "browser.menu.showViewImageInfo" = true;
        "browser.tabs.allowTabDetach" = false;
        "findbar.highlightAll" = true;
        "layout.word_select.eat_space_to_next_word" = false;
        "editor.truncate_user_pastes" = true;
        "ui.prefersReducedMotion" = 1;
        "ui.key.menuAccessKeyFocuses" = false;

        # SIDEBAR
        "sidebar.verticalTabs" = true;
        "sidebar.revamp" = true;
        "sidebar.expandOnHover" = true;

        # SMOOTH SCROLLING
        "general.smoothScroll.msdPhysics.continuousMotionMaxDeltaMS" = 12;
        "general.smoothScroll.msdPhysics.enabled" = true;
        "general.smoothScroll.msdPhysics.motionBeginSpringConstant" = 600;
        "general.smoothScroll.msdPhysics.regularSpringConstant" = 650;
        "general.smoothScroll.msdPhysics.slowdownMinDeltaMS" = 25;
        "general.smoothScroll.msdPhysics.slowdownMinDeltaRatio" = 2.0;
        "general.smoothScroll.msdPhysics.slowdownSpringConstant" = 250;
        "general.smoothScroll.currentVelocityWeighting" = 1.0;
        "general.smoothScroll.stopDecelerationWeighting" = 1.0;
        "mousewheel.default.delta_multiplier_y" = 300;

        # FIREFOX SYNC & SAVED LOGINS
        "identity.fxaccounts.enabled" = true;
        "signon.formlessCapture.enabled" = true;
        "signon.privateBrowsingCapture.enabled" = true;
        "signon.autofillForms" = true;
        "signon.rememberSignons" = true;
      };

      userChrome = ''
        #nav-bar, #TabsToolbar, #PersonalToolbar {
          border: none !important;
          box-shadow: none !important;
          border-radius: 0px !important;
        }

        #nav-bar, #TabsToolbar, #PersonalToolbar {
          background-color: transparent !important;
          opacity: 0.8 !important;
        }
      '';
    };
  };
}
