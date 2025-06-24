{ config, pkgMap, theme, getThemeFile, homedir, lib, ... }: let
  defaultSettings = {
    # General
    ## Startup
    "browser.startup.page"                    = 1;      # Do not open previous windows and tabs
    ## Tabs
    "browser.ctrlTab.sortByRecentlyUsed"      = true;   # Ctrl+Tab cycles through tabs in recently used order
    "browser.link.open_newwindow"             = 3;      # Open links in tabs instead of new windows
    "browser.tabs.loadInBackground"           = true;   # When you open a link, image or media in a new tab, switch to it immediately
    "browser.tabs.warnOnClose"                = false;  # Confirm before closing multiple tabs
    "browser.taskbar.previews.enable"         = false;  # Show tab previews in the Windows taskbar
    "floorp.tabsleep.enabled"                 = false;  # Enable Sleeping Tabs
    "floorp.tabsleep.tabTimeoutMinutes"       = 10;
    "floorp.tabsleep.excludeHosts"            = "youtube.com,emkooz.github.io,synergism.cc,orteil.dashnet.org";
    "toolkit.tabbox.switchByScrolling"        = false;  # Switch tabs by scrolling with your mouse
    "browser.tabs.closeTabByDblclick"         = false;  # Close tabs with a double click
    "floorp.tabs.showPinnedTabsTitle"         = false;  # Show the title of pinned tabs
    "browser.tabs.tabMinWidth"                = 64;     # Minimum width of tabs
    "floorp.browser.tabs.tabMinHeight"        = 30;     # Minimum height of tabs
    "privacy.userContext.enabled"             = false;  # Enable Container Tabs
    ## Browsing
    "general.autoScroll"                      = true;   # Use autoscrolling + enable scrollwheel
    "general.smoothScroll"                    = false;  # Use smooth scrolling
    "ui.osk.enabled"                          = false;  # Show a touch keyboard when necessary
    "accessibility.browsewithcaret"           = false;  # Always use the cursor keys to navigate within pages
    "layout.css.always_underline_links"       = false;  # Always underline links
    "accessibility.typeaheadfind"             = false;  # Search for text when you start typing
    "media.videocontrols.picture-in-picture.video-toggle.enabled" = false;  # Enable picture-in-picture video controls
    "media.hardwaremediakeys.enabled"         = true;   # Control media via keyboard, headset, or virtual interface
    "floorp.search.top.mode"                  = false;  # Display the Find Bar at the top of the page
    "floorp.enable.auto.restart"              = false;  # Restart automatically when settings that require a restart are changed
    "floorp.disable.fullscreen.notification"  = false;  # Do not show a notification when entering full screen
    "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons" = false; # Recommend extensions as you browse
    "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features" = false; # Recommend features as you browse
    # Design
    "floorp.browser.user.interface"           = 3;      # Uses Lepton UI interface
    ## Lepton settings
    "floorp.lepton.interface"                 = 2;      # Uses Lepton design
    ### Browser elements
    "userChrome.autohide.tab"                 = false;  # Automatically hide tabs
    "userChrome.autohide.navbar"              = false;  # Automatically hide Toolbar
    "userChrome.autohide.sidebar"             = false;  # Automatically hide Sidebar
    "userChrome.autohide.back_button"         = false;  # Automatically hide back button
    "userChrome.autohide.forward_button"      = false;  # Automatically hide forward button
    "userChrome.autohide.page_action"         = false;  # Automatically hide buttons on the Address Bar
    "userChrome.hidden.tab_icon"              = false;  # Hide tab icons
    "userChrome.hidden.tabbar"                = false;  # Hide Tab Bar
    "userChrome.hidden.navbar"                = false;  # Hide Toolbar
    "userChrome.hidden.sidebar_header"        = false;  # Hide Sidebar Headers
    "userChrome.hidden.urlbar_iconbox"        = false;  # Hide Address Bar icons
    "userChrome.hidden.bookmarkbar_icon"      = false;  # Hide Bookmarks Bar icons
    "userChrome.hidden.bookmarkbar_label"     = false;  # Hide Bookmarks Bar labels
    "userChrome.hidden.disabled_menu"         = false;  # Hide disabled context menu items
    "userChrome.icon.disabled"                = false;  # Disable Lepton's context menu and panel menu icons
    "userChrome.icon.menu"                    = true;   # Enable Lepton's context menu icons
    ### Position adjustments
    "userChrome.centered.tab"                 = false;  # Center labels in tabs
    "userChrome.centered.urlbar"              = false;  # Center text in the Address Bar
    "userChrome.centered.bookmarkbar"         = false;  # Center Bookmarks Bar items
    ### Address bar
    "userChrome.urlView.move_icon_to_left"    = false;  # Move Address Bar icons to the left side
    "userChrome.urlView.go_button_when_typing" = false; # When typing, show a "Go" button
    "userChrome.urlView.always_show_page_actions" = false; # Always show page actions in the Address Bar
    ### Tab bar
    "userChrome.tabbar.as_titlebar"           = false;  # Tab Bar in the Title Bar
    "userChrome.tabbar.one_liner"             = false;  # Combine Tab Bar and Toolbar
    "userChrome.sidebar.overlap"              = false;  # Show Sidebar over website content
    ## Tab bar style
    "floorp.tabbar.style"                     = 0;      # Uses horizontal tab bar
    "floorp.titlebar.favicon.color"           = false;  # Color the Tab Bar using the current website's favicon color
    ## Theme mode
    "floorp.chrome.theme.mode"                = 1;      # Use dark theme
    "layout.css.prefers-color-scheme.content-override" = 0; # Use dark theme
    # Browser Manager Sidebar
    "floorp.browser.sidebar.enable"           = false;  # Show (enable) the Browser Manager Sidebar
    # Workspaces
    "floorp.browser.workspaces.enabled"       = false;  # Enable Workspaces
    # Files and Applications
    "browser.download.lastDir"                = "${homedir}/downloads"; # Default download location
    "browser.download.useDownloadDir"         = true;   # Disable download location prompt
    "floorp.download.notification"            = 2;      # Notify only when a download finishes
    "browser.download.always_ask_before_handling_new_types" = false; # Ask weather to open or save files
    # Web Apps
    "floorp.browser.ssb.enabled"              = false;  # Enable Web Apps
    # Home
    "browser.newtabpage.activity-stream.floorp.background.type" = 0; # Disable Floorp Home background
    "browser.newtabpage.activity-stream.floorp.newtab.backdrop.blur.disable" = true; # Disable blur effect in Floorp Home
    "browser.newtabpage.activity-stream.floorp.newtab.imagecredit.hide" = true; # Disable Release Note and Support Links in Floorp Home
    "browser.newtabpage.activity-stream.floorp.newtab.releasenote.hide" = true; # Disable image credit (Unsplash) in Floorp Home
    "browser.newtabpage.activity-stream.showSearch" = true; # Show search in Floorp Home
    "browser.newtabpage.activity-stream.feeds.topsites" = true; # Show shortcuts in Floorp Home
    "browser.newtabpage.activity-stream.showSponsoredTopSites" = false; # Show sponsored shortcuts in Floorp Home
    "browser.newtabpage.activity-stream.feeds.section.topstories" = false; # Show recommended stories in Floorp Home
    "browser.newtabpage.activity-stream.feeds.section.highlights" = false; # Show recent activity in Floorp Home
    # Search
    ## Suggestions
    "browser.search.suggest.enabled"          = true;   # Show search suggestions
    "browser.urlbar.showSearchSuggestionsFirst" = true; # Show search suggestions ahead of browsing history in address bar results
    "browser.search.suggest.enabled.private"  = false;  # Show search suggestions in Private Windows
    "browser.urlbar.suggest.trending"         = false;  # Show trending search suggestions
    ## Address bar suggestions
    "browser.urlbar.suggest.history"          = true;   # Browsing history
    "browser.urlbar.suggest.bookmark"         = true;   # Bookmarks
    "browser.urlbar.suggest.clipboard"        = true;   # Clipboard
    "browser.urlbar.suggest.openpage"         = true;   # Open tabs
    "browser.urlbar.suggest.engines"          = false;  # Shortcuts
    "browser.urlbar.suggest.quicksuggest.nonsponsored" = false; # Floorp suggestions
    "browser.urlbar.suggest.quicksuggest.sponsored" = false; # Sponsored suggestions
    "browser.urlbar.quicksuggest.dataCollection.enabled" = false; # Share search query data
    # Privacy & Security
    "privacy.globalprivacycontrol.enabled"    = false;  # Tell websites not to sell or share my data
    "privacy.donottrackheader.enabled"        = false;  # Send websites a “Do Not Track” request
    "privacy.resistFingerprinting"            = false;  # Enable strong protection against fingerprinting
    "privacy.resistFingerprinting.autoDeclineNoUserInputCanvasPrompts" = true; # Automatically dismiss access confirmation prompts for HTML5 image data
    "webgl.disabled"                          = false;  # Disable WebGL
    "media.peerconnection.enabled"            = true;   # Enable WebRTC Connection
    ## Password
    "signon.rememberSignons"                  = false;  # Ask to save passwords
    "signon.management.page.breach-alerts.enabled" = false; # Show alerts about passwords for breached websites
    "network.http.windows-sso.enabled"        = false;  # Allow Windows single sign-on for Microsoft, work, and school accounts
    ## Autofill
    "extensions.formautofill.addresses.enabled" = true; # Save and fill addresses
    "extensions.formautofill.creditCards.enabled" = true; # Save and fill payment methods
    ## History
    "places.history.enabled"                  = true;   # Remember browsing and download history
    "browser.formfill.enable"                 = false;  # Remember search and form history
  };
in {
  programs.floorp = {
    enable        = true;
    package       = pkgMap.floorp;
    profiles.main = {
      id = 0;
      settings = defaultSettings;
      search = {
        default         = "google";
        privateDefault  = "google";
      };
    };
  };
}