# Common problems

To fully understand problem you can pass parameter `--should-log=true` to show full log in console.

## 403 while accessing Google API

It seems that user, that authorize app to access to it's google tables doesen't have appropriate permissions to view table.

**Solution:**

1. Share table to that user and try again
2. Change user, that have appropriate permissions (just remove file `~/.googleTokenProvider/<some_hash>.token_info.json`)
