TOOL_NAME =AnalyticsGen
BUILD_PATH =.build/release/$(TOOL_NAME)

test:
	swift test

executable: test
	git add Sources/AnalyticsGen/Resources/LibConstants.swift
	git add Docs/integration_guide.md
	git add AnalyticsGen.podspec
	git commit --allow-empty -m "bumb version $(V)"
	git push origin
	git tag $(V)
	git push origin $(V)

push_pods:
	pod trunk push --allow-warnings