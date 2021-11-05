This changelog will be used from now on to document changes in a precise manner, with a list of changes for each setting version.
Setting versions are documented using the pref `librewolf.cfg.version`, available in about:config.

## 3.0

**target commit**: f0a2d5d70657cc87348282d6faaf72edff8bf304 and 4e0895a299ec99066f119d8ce1a2923fc91aa465

**base librewolf version**: 94.x

**References**:
- as reported in #95 and discussed [here](https://gitlab.com/librewolf-community/browser/linux/-/issues/246) we are re-enabling TP by default, setting it to strict.
- the sponsored shortcuts in about:preferences#home were already locked, now they are properly hidden.
- enable fission as it is being [rolled out to stable](https://bugzilla.mozilla.org/show_bug.cgi?id=1732206).

**Notes**: all the removed preferences were either related to disabling TP, or unecessary when using strict mode. as a result of this trimming the tracking protection section of the .cfg file doesn't need to exist anymore.

#### Added preferences
```
defaultPref("browser.topsites.useRemoteSetting", false); // hide sponsored shortcuts button from about:preferences#home
defaultPref("privacy.resistFingerprinting.letterboxing", false); // expose hidden letterboxing pref, but do not enable by default
defaultPref("fission.autostart", true); // enable fission by default
```

#### Removed preferences
```
lockPref("privacy.trackingprotection.enabled", false);
lockPref("privacy.trackingprotection.pbmode.enabled", false);
lockPref("privacy.trackingprotection.annotate_channels", false);
defaultPref("browser.safebrowsing.provider.mozilla.updateURL", "");
defaultPref("browser.safebrowsing.provider.mozilla.gethashURL", "");
defaultPref("privacy.trackingprotection.cryptomining.enabled", false);
defaultPref("privacy.trackingprotection.fingerprinting.enabled", false);
defaultPref("browser.contentblocking.cryptomining.preferences.ui.enabled", false);
defaultPref("browser.contentblocking.fingerprinting.preferences.ui.enabled", false);
```

#### Changed preferences
```
pref("browser.contentblocking.category", "strict");
```

## 2.0

**target commit**: from 6451faa167568313e5ed065fcb3ee2bb76132063 to b17a1ed657e22ac61b4399699223d36724b842e7

**base librewolf version**: 92.x

**References**:
- [web content can no longer access the battery api](https://bugzilla.mozilla.org/show_bug.cgi?id=1313580).
- http alternative services are [isolated by network partitioning and FPI](https://github.com/arkenfox/user.js/blob/269cf965bd51022ca69823f8f66a8e402280d856/user.js#L1350) and they are unchanged even in tor browser. from a security standpoint, the alternate service will need to provide the certificate of the origin in order to be considered trusthworthy.
- let the user decide what to manually clear, including the timespan.
- drm prefs have been trimmed as a quality of life improvement. the end result is the same, with less hassle for users who want to access drm-protected content.
- DNT header has been proved to not work and it is used to fingerprint.
- VR access is behind a prompt and, despite being unlikely, it could be fingerprinted. with all this on the table it's just not worth and overkill.
- vibrator API is so nieche that even tor does not change it. best to trim where possible.
- `extensions.getAddons.link.url"` is showed only when no extension is installed and it's not a bad suggestion to get addons from addons.mozilla.org so we can remove it.
- `browser.safebrowsing.downloads.remote.*` are all controlled by the prefs already in the .cfg, which is the same approach taken by tor browser.
- graphite [is no longer as concerning](https://cve.mitre.org/cgi-bin/cvekey.cgi?keyword=firefox+graphite) and blocking it is likely fingerprintable.
- the pdf prefs and the bookmark backup are not really relevant to librewolf.
- as reported [here](https://bugzilla.mozilla.org/show_bug.cgi?id=1606624) the shared memory pref is no longer needed, so we can switch it back to default.
- new tab page section now includes a new design and no longer an empty page. all the unnecessary preferences have been removed and users can also customize as the most essential ones have been unlocked.
- UI bug in tracking protection section is fixed.
- a bunch of dead links are fixed.
- for screensharing see [testing provided at this link](https://github.com/arkenfox/user.js/issues/1245)
- disable new firefox suggests feature

**Notes**
Recent changes in the category `MISC > set librewolf support and releases urls` require to create a couple header for the landing page.

#### Removed preferences
```
defaultPref("general.warnOnAboutConfig", false); // deprecated
defaultPref("dom.battery.enabled", false);
lockPref("network.http.altsvc.enabled", false);
lockPref("network.http.altsvc.oe", false);
lockPref("signon.storeWhenAutocompleteOff", false); // we do not suggest lockwise in the first place
defaultPref("signon.management.page.breach-alerts.enabled", false); // no harm for lockwise users
defaultPref("signon.management.page.breachAlertUrl", ""); // no harm for lockwise users
defaultPref("privacy.history.custom", true); // redundant
defaultPref("privacy.cpd.cookies", false);
defaultPref("privacy.cpd.offlineApps", false); // default
defaultPref("privacy.sanitize.timeSpan", 0);
defaultPref("media.gmp-widevinecdm.visible", false);
defaultPref("media.gmp-widevinecdm.enabled", false);
defaultPref("privacy.donottrackheader.enabled", true);
defaultPref("dom.vr.enabled", false);
defaultPref("dom.vibrator.enabled", false);
defaultPref("dom.push.connection.enabled", false); // redundant
defaultPref("dom.security.https_only_mode_pbm", true); // redundant
defaultPref("security.tls.version.fallback-limit", 3); // default is for, no need to enforce further
lockPref("extensions.webextensions.identity.redirectDomain", ""); // outdated and unchanged even in tor
defaultPref("extensions.getAddons.link.url", ""); // https://addons.mozilla.org/%LOCALE%/firefox/
defaultPref("extensions.getAddons.get.url", ""); // redundant
lockPref("extensions.getAddons.discovery.api_url", ""); // redundant
lockPref("webextensions.storage.sync.serverURL", ""); // sync not supported
lockPref("extensions.webservice.discoverURL", ""); // deprecated
defaultPref("xpinstall.signatures.devInfoURL", ""); // link to wiki page
lockPref("app.normandy.user_id", ""); // redundant
lockPref("app.normandy.shieldLearnMoreUrl", ""); // redundant
lockPref("security.mixed_content.block_active_content", true); // default
defaultPref("security.insecure_connection_text.pbmode.enabled", true); // redundant
lockPref("browser.safebrowsing.downloads.remote.block_dangerous", false);
lockPref("browser.safebrowsing.downloads.remote.block_dangerous_host", false);
lockPref("gfx.font_rendering.graphite.enabled", false); // consider removing
defaultPref("pdfjs.previousHandler.alwaysAskBeforeHandling", true);
defaultPref("pdfjs.enabledCache.state", false);
lockPref("remote.enabled", false); // removed in FF90
lockPref("browser.shell.didSkipDefaultBrowserCheckOnFirstRun", true); // redundant
defaultPref("browser.bookmarks.max_backups", 2);
defaultPref("devtools.performance.recording.ui-base-url", "http://localhost:55555"); // unharmful
defaultPref("devtools.devices.url", ""); // unharmful
lockPref("media.decoder-doctor.new-issue-endpoint", ""); // redundant
lockPref("identity.sync.tokenserver.uri", ""); // redundant
defaultPref("accessibility.support.url", ""); // redundant
lockPref("browser.dictionaries.download.url", ""); // dictionaries are hidden already
lockPref("browser.uitour.themeOrigin", ""); // redundant
lockPref("toolkit.datacollection.infoURL", ""); // redundant
lockPref("identity.mobilepromo.android", ""); // redundant
lockPref("identity.mobilepromo.ios", ""); // redundant
defaultPref("identity.sendtabpromo.url", ""); // redundant
lockPref("datareporting.healthreport.infoURL", ""); // redundant
lockPref("browser.chrome.errorReporter.infoURL", ""); // redundant
lockPref("datareporting.policy.firstRunURL", ""); // redundant
lockPref("javascript.options.shared_memory", false);
lockPref("app.update.staging.enabled", false); // not relevant
lockPref("app.update.lastUpdateTime.telemetry_modules_ping", 0); // redundant
lockPref("network.connectivity-service.IPv6.url", "http://0.0.0.0"); // redundant
lockPref("network.connectivity-service.IPv4.url", "http://0.0.0.0"); // redundant
lockPref("network.connectivity-service.DNSv6.domain", ""); // redundant
lockPref("network.connectivity-service.DNSv4.domain", ""); // redundant
lockPref("browser.crashReports.unsubmittedCheck.enabled", false); // default
lockPref("browser.crashReports.unsubmittedCheck.autoSubmit2", false); // default
lockPref("browser.newtabpage.activity-stream.feeds.newtabinit", false);
lockPref("browser.newtabpage.activity-stream.feeds.places", false);
lockPref("browser.newtabpage.activity-stream.feeds.systemtick", false);
lockPref("browser.newtabpage.activity-stream.feeds.system.topsites", false);
lockPref("browser.newtabpage.activity-stream.asrouter.providers.messaging-experiments", "");
lockPref("browser.newtabpage.activity-stream.asrouter.providers.message-groups", "");
lockPref("browser.newtabpage.activity-stream.asrouter.providers.cfr-fxa", "");
lockPref("browser.newtabpage.activity-stream.asrouter.providers.cfr", "");
lockPref("browser.newtabpage.activity-stream.asrouter.providers.whats-new-panel", "{\"id\":\"whats-new-panel\",\"enabled\":false}");
lockPref("browser.newtabpage.activity-stream.asrouter.devtoolsEnableds", true);
lockPref("browser.newtabpage.activity-stream.telemetry.structuredIngestion.endpoint", "");
lockPref("browser.newtabpage.activity-stream.improvesearch.topSiteSearchShortcuts", false);
lockPref("browser.newtabpage.activity-stream.improvesearch.handoffToAwesomebar", false);
lockPref("browser.newtabpage.activity-stream.improvesearch.topSiteSearchShortcuts.searchEngines", "");
lockPref("browser.newtabpage.activity-stream.improvesearch.topSiteSearchShortcuts.havePinned", "");
defaultPref("dom.push.userAgentID", ""); // push notifications are already disabled
lockPref("services.settings.server", ""); // redundant with patches
lockPref("webchannel.allowObject.urlWhitelist", ""); // deprecated
defaultPref("media.getusermedia.browser.enabled", false);
defaultPref("media.getusermedia.screensharing.enabled", false);
defaultPref("media.getusermedia.audiocapture.enabled", false);
defaultPref("dom.storage.next_gen", true); // default from v92.0
```

#### Added preferences
```
defaultPref("browser.download.useDownloadDir", false); // force user interaction on downloads, by always asking location
// defaultPref("security.remote_settings.crlite_filters.enabled", true);
// defaultPref("security.pki.crlite_mode", 2);
pref("browser.urlbar.quicksuggest.scenario", ""); // disable firefox suggests and hide its UI
```

#### Commented preferences
```
// pref("network.trr.mode", 2); // previously uncommented defaultPref with value 5 
// pref("network.trr.uri", "https://dns.quad9.net/dns-query"); // previously uncommented defaultPref with empty value
```

#### Changed preferences
previously empty, set to proper value
```
defaultPref("network.trr.confirmationNS", "skip");
defaultPref("browser.search.searchEnginesURL", "https://gitlab.com/librewolf-community/settings/-/wikis/support#search");
defaultPref("browser.geolocation.warning.infoURL", "https://gitlab.com/librewolf-community/settings/-/wikis/support#location");
defaultPref("app.feedback.baseURL", "https://gitlab.com/librewolf-community/settings/-/wikis/support");
defaultPref("app.releaseNotesURL", "https://gitlab.com/librewolf-community/browser");
defaultPref("app.releaseNotesURL.aboutDialog", "https://gitlab.com/librewolf-community/browser");
```

#### Unlocked preferences
```
defaultPref("signon.rememberSignons", false);
defaultPref("signon.autofillForms", false);
defaultPref("signon.formlessCapture.enabled", false);
defaultPref("browser.urlbar.speculativeConnect.enabled", false);
defaultPref("browser.contentblocking.report.lockwise.enabled", false);
defaultPref("browser.contentblocking.report.monitor.enabled", false);
defaultPref("network.dns.disablePrefetch", true);
defaultPref("security.ssl.treat_unsafe_negotiation_as_broken",	true);
defaultPref("browser.startup.blankWindow", false);
defaultPref("extensions.htmlaboutaddons.recommendations.enabled", false);
defaultPref("extensions.systemAddon.update.enabled", false);
defaultPref("extensions.systemAddon.update.url", "");
defaultPref("security.mixed_content.block_display_content", true);
defaultPref("security.insecure_connection_text.enabled", true);
defaultPref("gfx.font_rendering.opentype_svg.enabled", false);
defaultPref("browser.shell.shortcutFavicons", false);
defaultPref("network.gio.supported-protocols", "");
defaultPref("network.IDN_show_punycode", true);
defaultPref("browser.shell.checkDefaultBrowser", false);
defaultPref("middlemouse.contentLoadURL", false);
defaultPref("browser.pagethumbnails.capturing_disabled", true);
defaultPref("browser.privatebrowsing.forceMediaMemoryCache", true);
defaultPref("app.update.url.details", "https://gitlab.com/librewolf-community/browser");
defaultPref("app.update.url.manual", "https://gitlab.com/librewolf-community/browser");
defaultPref("network.protocol-handler.external.ms-windows-store", false);
defaultPref("browser.newtab.preload", false);
defaultPref("browser.newtabpage.activity-stream.section.highlights.includeDownloads", false);
defaultPref("browser.newtabpage.activity-stream.section.highlights.includeVisited", false);
defaultPref("browser.newtabpage.activity-stream.feeds.topsites", false);
defaultPref("browser.safebrowsing.downloads.enabled", false);
```

## 1.6

**target commit**: 192f51abe21e9aeb9b01d396079e9b8533cab7bb

**base librewolf version**: 91.x

**References**:
- [reasoning on webgl2](https://github.com/arkenfox/user.js/commit/41c3c0ec26ef4392169fa1d04fd5783ac03bfc8e) from arkenfox's maintainer, basically disabling webgl is enough for those who don't need it. users who want it have one less pref to change.

#### Removed preferences
```
defaultPref("dom.targetBlankNoOpener.enabled", true); // default since v79.0
defaultPref("webgl.enable-webgl2", false);
lockPref("browser.newtabpage.activity-stream.feeds.section.highlights", false); // default
```

## 1.5

**target commit**: 23d1bff4f4ae3456df8e50e67f657ea6288eef29

**base librewolf version**: 91.x

**References**:
- [comment](https://github.com/arkenfox/user.js/commit/3bb9fc713f141d794fc4adfb38d3fcf86c9307ab#commitcomment-53916786) from arkenfox's maintainer regarding tls version pref
- [mozilla update service](https://support.mozilla.org/en-US/kb/enable-background-updates-firefox-windows)
- extension firewall has been revisited

#### Removed preferences
```
lockPref("security.dialog_enable_delay", 700); // default 1000, no need to enforce this
```

#### Added preferences
```
defaultPref("app.update.background.scheduling.enabled", false); // Win specific update service
defaultPref("security.tls.version.enable-deprecated", false); // default but helps resetting the preference
// defaultPref("extensions.webextensions.base-content-security-policy.v3", "default-src 'none'; script-src 'none'; object-src 'none';");
```

#### Changed preferences
```
// defaultPref("extensions.webextensions.base-content-security-policy", "default-src 'none'; script-src 'none'; object-src 'none';");
```

## 1.4
**target commit**: 2e21db4c3018321a077d9af2ec44b29675c57adf

**base librewolf version**: 90.x

#### Removed preferences
```
lockPref("security.tls.version.enable-deprecated", false); // default
```

## 1.3
**target commit**: 60e75e30c6018a5c909a2f00f40831ed3f1948a6

**base librewolf version**: 90.x

#### Added preferences
```
defaultPref("network.http.windows-sso.enabled", false);
```

#### Removed preferences
```
lockPref("browser.cache.offline.storage.enable", false); // pref does not exist anymore as it became default behavior
```

## 1.2
**target commit**: 294724fae38ffa4ebcf6dfb0854787fb7022d1e6

**base librewolf version**: 89.x

**References**:
- issue [#65](https://gitlab.com/librewolf-community/settings/-/issues/65) from settings
- issue [#22](https://gitlab.com/librewolf-community/browser/common/-/issues/22) from common

#### Removed preferences
```
defaultPref("dom.webaudio.enabled", false);
defaultPref("media.navigator.enabled", false);
```

#### Changed preferences
```
defaultPref("app.support.baseURL", "https://gitlab.com/librewolf-community/settings/-/wikis/support#");
```

## 1.1
**target commit**: cf0a2cc88acdbc51b138228353a0d7c9ea0db7c3

**base librewolf version**: 89.x

**References**:
- issue [#54](https://gitlab.com/librewolf-community/settings/-/issues/54) from settings
- merge request [#5](https://gitlab.com/librewolf-community/browser/common/-/merge_requests/5) from common

#### Removed preferences
```
defaultPref("security.OCSP.require", false); // default value
defaultPref("extensions.update.url", "");
defaultPref("extensions.update.background.url", "");
defaultPref("extensions.getAddons.search.browseURL", "");
```

#### Changed preferences
```
defaultPref("geo.provider.network.url", "https://location.services.mozilla.com/v1/geolocate?key=%MOZILLA_API_KEY%");
```

#### Added preferences
```
lockPref("privacy.override_rfp_for_color_scheme", false);
```


## 1.0
**target commit**: 2b8dc4ac6d7fb6fdf8f172d04c27912098268257

**base librewolf version**: 89.x

This is the initial release from which we start tagging and versioning settings.
