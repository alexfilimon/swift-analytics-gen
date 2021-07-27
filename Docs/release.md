# Release

1. Bump version
    - in file `AnalyticsGen.podspec`
    - in file `Source/AnalyticsGen/Resources/LibConstants` variable `version`
    - in file `Docs/integration_guide.md` in section `Install script via CocoaPods`
2. Run `make executable V={new_version}`
3. Run `make push pods` after release will be processed by the github actions
