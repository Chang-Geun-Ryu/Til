# network change swift code

```swift
let notificationName = "com.apple.system.config.network_change"

func onNetworkChange(_ name : String) {
    if (name == notificationName) {
        // Do your stuff
        print("Network was changed")
    }
}

func registerObserver() {
    let observer = UnsafeRawPointer(Unmanaged.passUnretained(self).toOpaque())
    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), observer,
                                    { (nc, observer, name, _, _) -> Swift.Void in
                                        if let observer = observer, let name = name {
                                            let instance = Unmanaged<Reachability>.fromOpaque(observer).takeUnretainedValue()
                                            instance.onNetworkChange(name.rawValue as String)
                                        } },
                                    notificationName as CFString, nil, .deliverImmediately)
}

func removeObserver() {
    let observer = UnsafeRawPointer(Unmanaged.passUnretained(self).toOpaque())
    CFNotificationCenterRemoveObserver(CFNotificationCenterGetDarwinNotifyCenter(), observer, nil, nil)
}
```