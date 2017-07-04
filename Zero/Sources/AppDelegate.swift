//
//  AppDelegate.swift
//  Zero
//
//  Created by Jairo Eli de Leon on 5/8/17.
//  Copyright © 2017 Jairo Eli de León. All rights reserved.
//

import UIKit
import ManualLayout
import RxOptional
import RxReusable
import SnapKit
import UITextView_Placeholder
import RxGesture

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

    let window = UIWindow(frame: UIScreen.main.bounds)
    window.backgroundColor = .snow
    window.makeKeyAndVisible()

    let serviceProvider = ServiceProvider()
    let reactor = HabitListViewReactor(provider: serviceProvider)
    let viewController = TaskListViewController(reactor: reactor)
    let navigationController = UINavigationController(rootViewController: viewController)
    window.rootViewController = navigationController

    self.window = window
    return true
  }

}
