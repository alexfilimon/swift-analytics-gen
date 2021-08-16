TOOL_NAME =AnalyticsGen
BUILD_PATH =.build/release/$(TOOL_NAME)

bump_version:
	sed -i '' 's/pod \x27AnalyticsGen\x27, \x27[0-9]*.[0-9]*.[0-9]*\x27/pod \x27AnalyticsGen\x27, \x27$(V)\x27/g' Docs/integration_guide.md
	sed -i '' 's/static let version = \x22[0-9]*.[0-9]*.[0-9]*\x22/static let version = \x22$(V)\x22/g' Sources/AnalyticsGen/Resources/LibConstants.swift
	sed -i '' 's/s.version        = \x27[0-9]*.[0-9]*.[0-9]*\x27/s.version        = \x27$(V)\x27/g' AnalyticsGen.podspec

commit_bumped_version:
	git add Sources/AnalyticsGen/Resources/LibConstants.swift
	git add Docs/integration_guide.md
	git add AnalyticsGen.podspec
	git commit --allow-empty -m "bumb version $(V)"
	git push origin

add_tag:
	git tag $(V)
	git push origin $(V)

test:
	swift test

executable: test
	bump_version
	commit_bumped_version
	add_tag