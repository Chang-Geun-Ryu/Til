//
//  ViewController.swift
//  TestNetWorkChangeNotificatoin
//
//  Created by CHANGGUEN YU on 22/08/2019.
//  Copyright © 2019 CHANGGUEN YU. All rights reserved.
//

import UIKit
import Reachability

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }


  
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
                                    { [weak self] (nc, observer, name, _, _) -> Swift.Void in
                                      if let observer = observer, let name = name {
                                        let instance = Unmanaged<Reachability>.fromOpaque(observer).takeUnretainedValue()
                                        self?.onNetworkChange(name.rawValue as String)
                                      } },
                                    notificationName as CFString, nil, .deliverImmediately)
  }
  
  func removeObserver() {
    let observer = UnsafeRawPointer(Unmanaged.passUnretained(self).toOpaque())
    CFNotificationCenterRemoveObserver(CFNotificationCenterGetDarwinNotifyCenter(), observer, nil, nil)
  }
  
}

