//
//  AppDelegate.swift
//  DiaryPractice
//
//  Created by CHANGGUEN YU on 11/05/2019.
//  Copyright © 2019 유창근. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?


  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.backgroundColor = .white
    
    let navi = UINavigationController(rootViewController: TableViewController())
    
    window?.rootViewController = navi
    window?.makeKeyAndVisible()
    return true
  }

}

