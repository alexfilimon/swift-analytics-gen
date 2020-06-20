TOOL_NAME =AnalyticsGen
BUILD_PATH =.build/release/$(TOOL_NAME)

test:
	swift test

release_build:
	swift build --configuration release

executable: release_build
	cp $(BUILD_PATH) ./bin/
	git add bin/AnalyticsGen
	git commit -m "generated bin $(V)"
	git push
	git tag $(V)
	git push origin $(V)
	pod trunk push --allow-warnings