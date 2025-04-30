{ config, pkgMap, theme, getThemeFile, lib, ... }:
if pkgMap ? "discordchatexporter-desktop" then {
  xdg.configFile."discordchatexporter/Settings.dat".text = ''
    {
      "IsUkraineSupportMessageEnabled": false,
      "Theme": 2,
      "IsAutoUpdateEnabled": true,
      "IsTokenPersisted": true,
      "ThreadInclusionMode": 0,
      "Locale": null,
      "IsUtcNormalizationEnabled": false,
      "ParallelLimit": 1,
      "LastToken": null,
      "LastExportFormat": 1,
      "LastPartitionLimitValue": null,
      "LastMessageFilterValue": null,
      "LastShouldFormatMarkdown": true,
      "LastShouldDownloadAssets": false,
      "LastShouldReuseAssets": false,
      "LastAssetsDirPath": null
    }
  '';
} else {}