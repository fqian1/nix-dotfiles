{ ... }:
{
  programs.firefox = {
    enable = true;
    profiles.default = {
      settings = {
        "content.notify.interval" = 100000;

        # /** GFX ***/
        "gfx.canvas.accelerated.cache-size" = 512;
        "gfx.content.skia-font-cache-size" = 20;

        # /** DISK CACHE ***/
        "browser.cache.disk.enable" = false;

        # /** MEMORY CACHE ***/
        "browser.sessionhistory.max_total_viewers" = 4;

        # /** MEDIA CACHE ***/
        "media.memory_cache_max_size" = 65536;
        "media.cache_readahead_limit" = 7200;
        "media.cache_resume_threshold" = 3600;

        # /** IMAGE CACHE ***/
        "image.mem.decode_bytes_at_a_time" = 32768;

        # /** NETWORK ***/
        "network.http.max-connections" = 1800;
        "network.http.max-persistent-connections-per-server" = 10;
        "network.http.max-urgent-start-excessive-connections-per-host" = 5;
        "network.http.pacing.requests.enabled" = false;
        "network.dnsCacheExpiration" = 3600;
        "network.ssl_tokens_cache_capacity" = 10240;

        # /** SPECULATIVE LOADING ***/
        "network.http.speculative-parallel-limit" = 0;
        "network.dns.disablePrefetch" = true;
        "network.dns.disablePrefetchFromHTTPS" = true;
        "browser.urlbar.speculativeConnect.enabled" = false;
        "browser.places.speculativeConnect.enabled" = false;
        "network.prefetch-next" = false;
        "network.predictor.enabled" = false;

        # /** EXPERIMENTAL ***/
        "layout.css.grid-template-masonry-value.enabled" = true;

        # /****************************************************************************
        #  * SECTION: SECUREFOX                                                       *
        # ****************************************************************************/
        # /** TRACKING PROTECTION ***/
        "privacy.trackingprotection.allow_list.baseline.enabled" = true;
        "privacy.trackingprotection.allow_list.convenience.enabled" = true;
        "browser.download.start_downloads_in_tmp_dir" = true;
        "browser.helperApps.deleteTempFileOnExit" = true;
        "browser.uitour.enabled" = false;
        "privacy.globalprivacycontrol.enabled" = true;

        # /** OCSP & CERTS / HPKP ***/
        "security.OCSP.enabled" = 0;
        "security.pki.crlite_mode" = 2;
        "security.csp.reporting.enabled" = false;

        # /** SSL / TLS ***/
        "security.ssl.treat_unsafe_negotiation_as_broken" = true;
        "browser.xul.error_pages.expert_bad_cert" = true;
        "security.tls.enable_0rtt_data" = false;

        # /** DISK AVOIDANCE ***/
        "browser.privatebrowsing.forceMediaMemoryCache" = true;
        "browser.sessionstore.interval" = 60000;

        # /** SHUTDOWN & SANITIZING ***/
        "browser.privatebrowsing.resetPBM.enabled" = true;
        "privacy.history.custom" = true;

        # /** SEARCH / URL BAR ***/
        "browser.urlbar.trimHttps" = true;
        "browser.urlbar.untrimOnUserInteraction.featureGate" = true;
        "browser.search.separatePrivateDefault.ui.enabled" = true;
        "browser.search.suggest.enabled" = false;
        "browser.urlbar.quicksuggest.enabled" = false;
        "browser.urlbar.groupLabels.enabled" = false;
        "browser.formfill.enable" = false;
        "network.IDN_show_punycode" = true;

        # /** PASSWORDS ***/
        "network.auth.subresource-http-auth-allow" = 1;

        # /** MIXED CONTENT + CROSS-SITE ***/
        "security.mixed_content.block_display_content" = true;
        "pdfjs.enableScripting" = false;

        # /** EXTENSIONS ***/
        "extensions.enabledScopes" = 5;

        # /** HEADERS / REFERERS ***/
        "network.http.referer.XOriginTrimmingPolicy" = 2;

        # /** CONTAINERS ***/
        "privacy.userContext.ui.enabled" = true;

        # /** SAFE BROWSING ***/
        "browser.safebrowsing.downloads.remote.enabled" = false;

        # /** MOZILLA ***/
        "permissions.default.desktop-notification" = 2;
        "permissions.default.geo" = 2;
        "geo.provider.network.url" = "https://beacondb.net/v1/geolocate";
        "browser.search.update" = false;
        "permissions.manager.defaultsUrl" = "";
        "extensions.getAddons.cache.enabled" = false;

        # /** TELEMETRY ***/
        "datareporting.policy.dataSubmissionEnabled" = false;
        "datareporting.healthreport.uploadEnabled" = false;
        "toolkit.telemetry.unified" = false;
        "toolkit.telemetry.enabled" = false;
        "toolkit.telemetry.server" = "data:,";
        "toolkit.telemetry.archive.enabled" = false;
        "toolkit.telemetry.newProfilePing.enabled" = false;
        "toolkit.telemetry.shutdownPingSender.enabled" = false;
        "toolkit.telemetry.updatePing.enabled" = false;
        "toolkit.telemetry.bhrPing.enabled" = false;
        "toolkit.telemetry.firstShutdownPing.enabled" = false;
        "toolkit.telemetry.coverage.opt-out" = true;
        "toolkit.coverage.opt-out" = true;
        "toolkit.coverage.endpoint.base" = "";
        "browser.newtabpage.activity-stream.feeds.telemetry" = false;
        "browser.newtabpage.activity-stream.telemetry" = false;
        "datareporting.usage.uploadEnabled" = false;

        # /** EXPERIMENTS ***/
        "app.shield.optoutstudies.enabled" = false;
        "app.normandy.enabled" = false;
        "app.normandy.api_url" = "";

        # /** CRASH REPORTS ***/
        "breakpad.reportURL" = "";
        "browser.tabs.crashReporting.sendReport" = false;

        # /****************************************************************************
        #  * SECTION: PESKYFOX                                                        *
        # ****************************************************************************/
        # /** MOZILLA UI ***/
        "browser.privatebrowsing.vpnpromourl" = "";
        "extensions.getAddons.showPane" = false;
        "extensions.htmlaboutaddons.recommendations.enabled" = false;
        "browser.discovery.enabled" = false;
        "browser.shell.checkDefaultBrowser" = false;
        "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons" = false;
        "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features" = false;
        "browser.preferences.moreFromMozilla" = false;
        "browser.aboutConfig.showWarning" = false;
        "browser.aboutwelcome.enabled" = false;
        "browser.profiles.enabled" = true;

        # /** THEME ADJUSTMENTS ***/
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "browser.compactmode.show" = true;
        "browser.privateWindowSeparation.enabled" = false; # WINDOWS

        # /** AI ***/
        "browser.ml.enable" = false;
        "browser.ml.chat.enabled" = false;

        # /** FULLSCREEN NOTICE ***/
        "full-screen-api.transition-duration.enter" = "0 0";
        "full-screen-api.transition-duration.leave" = "0 0";
        "full-screen-api.warning.timeout" = 0;

        # /** URL BAR ***/
        "browser.urlbar.trending.featureGate" = false;

        # /** NEW TAB PAGE ***/
        "browser.newtabpage.activity-stream.default.sites" = "";
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
        "browser.newtabpage.activity-stream.showSponsored" = false;
        "browser.newtabpage.activity-stream.showSponsoredCheckboxes" = false;

        # /** POCKET ***/
        "extensions.pocket.enabled" = false;

        # /** DOWNLOADS ***/
        "browser.download.manager.addToRecentDocs" = false;

        # /** PDF ***/
        "browser.download.open_pdf_attachments_inline" = true;

        # /** TAB BEHAVIOR ***/
        "browser.bookmarks.openInTabClosesMenu" = false;
        "browser.menu.showViewImageInfo" = true;
        "findbar.highlightAll" = true;
        "layout.word_select.eat_space_to_next_word" = false;
        "browser.tabs.allowTabDetach" = false;

        # /****************************************************************************
        #  * START: MY OVERRIDES                                                      *
        # ****************************************************************************/
        "signon.formlessCapture.enabled" = true;
        "signon.privateBrowsingCapture.enabled" = true;
        "signon.autofillForms" = true;
        "signon.rememberSignons" = true;
        "editor.truncate_user_pastes" = true;
        "browser.contentblocking.category" = "standard";
        # "browser.newtabpage.activity-stream.showSponsoredTopSites" is already false
        # "browser.newtabpage.activity-stream.feeds.section.topstories" is already false
        # "browser.newtabpage.activity-stream.showSponsored" is already false
        "identity.fxaccounts.enabled" = true;

        # /****************************************************************************
        #  * SECTION: SMOOTHFOX                                                       *
        # ****************************************************************************/
        "general.smoothScroll" = true; # DEFAULT
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
      };
    };
  };
}
