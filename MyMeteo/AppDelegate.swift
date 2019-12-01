//
//  AppDelegate.swift
//  MyMeteo
//
//  Created by Sami Benmakhlouf on 30/11/2019.
//  Copyright © 2019 Sami Benmakhlouf. All rights reserved.
//

import UIKit
#if DEBUG
import DBDebugToolkit
#endif

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        #if DEBUG
            DBDebugToolkit.setup()
        #endif

        window = UIWindow(frame: UIScreen.main.bounds)

        let rootViewController = WeatherListModuleFactory().makeView()
        let navigationController = UINavigationController(rootViewController: rootViewController)

        window?.rootViewController = navigationController

        window?.makeKeyAndVisible()

        return true
    }

}

