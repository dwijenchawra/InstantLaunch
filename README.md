# InstantLaunch

Opens Things 3 to the Anytime view, maximized, every time your Mac is unlocked.

## How it works

A compiled Swift binary listens for `com.apple.screenIsUnlocked` notifications and runs an AppleScript that activates Things, navigates to Anytime via the menu bar, and maximizes the window to the current screen size.

A launchd agent starts the watcher at login and keeps it alive.

## Files

- `unlock-watcher.swift` — the watcher (compile with `swiftc unlock-watcher.swift -o unlock-watcher`)
- `com.user.unlock-watcher.plist` — launchd agent

## Install

```bash
# Compile
swiftc unlock-watcher.swift -o ~/.unlock-watcher

# Symlink the plist
ln -s "$(pwd)/com.user.unlock-watcher.plist" ~/Library/LaunchAgents/

# Start
launchctl load ~/Library/LaunchAgents/com.user.unlock-watcher.plist
```

Grant Accessibility permissions when prompted.

## Evolution

| Version | Approach | Problem |
|---|---|---|
| v1 | SleepWatcher + bash script on wake | Mac wasn't fully sleeping on lid close, so wake events didn't fire reliably |
| v2 | Swift binary listening for `screenIsUnlocked` | Reliable — fires on every unlock (lid open, Touch ID, password) |

Other iterations: removed `hide all windows` (broke app ordering), replaced Things URL scheme with menu navigation (URL scheme corrupted the window), replaced hardcoded screen bounds with dynamic `NSScreen`, consolidated from 3 files to 2.
