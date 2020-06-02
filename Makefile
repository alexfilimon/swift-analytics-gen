TOOL_NAME =AnalyticsGen
BUILD_PATH =.build/release/$(TOOL_NAME)

test:
	swift test

release_build:
	swift build --configuration release

executable: release_build
	cp $(BUILD_PATH) ./bin