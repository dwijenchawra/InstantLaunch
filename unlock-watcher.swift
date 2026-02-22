import Cocoa

func onUnlock() {
    let script = """
    tell application "Things3" to activate
    delay 0.3
    tell application "System Events"
        tell process "Things3"
            click menu item "Anytime" of menu "Go To" of menu item "Go To" of menu "View" of menu bar 1
        end tell
    end tell
    tell application "Things3" to set bounds of window 1 to {0, 25, \(Int(NSScreen.main!.frame.width)), \(Int(NSScreen.main!.frame.height))}
    """
    let proc = Process()
    proc.executableURL = URL(fileURLWithPath: "/usr/bin/osascript")
    proc.arguments = ["-e", script]
    try? proc.run()
}

DistributedNotificationCenter.default().addObserver(
    forName: NSNotification.Name("com.apple.screenIsUnlocked"),
    object: nil,
    queue: .main
) { _ in
    onUnlock()
}

RunLoop.main.run()
