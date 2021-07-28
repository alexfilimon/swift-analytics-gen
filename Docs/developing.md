# How to develop

1. Open `Package.swift` file in xCode.
2. Add code below in `main.swift` to set path for working directory

```swift 
import PathKit
// TODO: remove
Path.current = <your path to project>
```

3. Add `google.json` file in project folder
4. Add argument passeg on launch in edit scheme menu if needed
    - `--config-file-path=<custom path to config>`
    - `--should-log=true` to enable force logging
5. Check `use terminal` while editing scheme
