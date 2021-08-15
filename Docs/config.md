# Config description

Config should be passed as parameter (`--config-file-path`) in script. If it will not be passed, default filePath for config will be used (`config.yaml`).

Config format: YAML.

```yaml
language: "swift" # (required) swift, kotlin or dart (any language could be added by creating another struct, that conforms to Language protocol)
credentials_file_path: "google.json" # (required) path to file, when google creadentials are located
categories_extension_template_path: "Templates/ios/analytics_category_template.stencil" # (optional) path to template file for category extension
categories_extension_output_path: "output" # (optional) category extension output path
events_module_config: # (optional) module for describing generating events properties
  naming_postfix: "event_category" # (required) posfix for name (must be in snack case)
  template_file_path: "Templates/ios/events_category_template.stencil" # (required) path to template file
  output_folder_path: "output/EventCategories" # (required) output folder path
  spreadsheet_config: # (required) spreadsheet config
    id: "1_w6NmTK4Ju3i2PacB4" # (required) page identifier
    page_name: "Version_1.0" # (required) page name (must not contains spaces)
    range: "A2:G100" # (required) working range
user_properties_module_config: # (optional) module for describing generating user properties (specification is the same as events_module_config)
  naming_postfix: "user_properties" # name for user properties entity
  template_file_path: "Templates/ios/user_properties_template.stencil"
  output_folder_path: "output/UserProperties"
  spreadsheet_config:
    id: "1a9UAiDPmVx_5qEv6EIpCzBx-rW64yjxH2Ptpfj6AP3A"
    page_name: "UserProps_1.0"
    range: "A2:C100"
custom_enum_module_config: # (optional) module for describing generating custom enums (specification is the same as events_module_config)
  naming_postfix: "custom_enum"
  template_file_path: "Templates/ios/custom_enums_template.stencil"
  output_folder_path: "output/CustomEnums"
  spreadsheet_config:
    id: "1_w6NmTK4Ju3i2PacB4"
    page_name: "Types"
    range: "A2:D100"
should_remove_old_files_before_generating: true # (optional, default true) should we remove files before generating new files or not
```
