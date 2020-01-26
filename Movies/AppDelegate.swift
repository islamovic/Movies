//
//  AppDelegate.swift
//  Movies
//
//  Created by Islam on 1/22/20.
//  Copyright © 2020 App Lineup. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let splitViewController = UISplitViewController()
        let rootViewController = UINavigationController(rootViewController: MoviesSceneConfigurator.configure())
        let infoViewController = UINavigationController(rootViewController: MovieInfoSceneConfigurator.configure())
        splitViewController.viewControllers = [rootViewController, infoViewController]
        splitViewController.delegate = self

        if let moviesViewController = rootViewController.topViewController as? MoviesViewController,
            let infoViewController = infoViewController.topViewController as? MovieInfoViewController {
            moviesViewController.delegate = infoViewController
        }

        splitViewController.preferredDisplayMode = .allVisible

        window?.rootViewController = splitViewController
        window?.makeKeyAndVisible()

        return true
    }

    // MARK: UISceneSession Lifecycle

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

extension AppDelegate: UISplitViewControllerDelegate {

    func splitViewController(_ splitViewController: UISplitViewController,
                             collapseSecondary secondaryViewController:UIViewController,
                             onto primaryViewController:UIViewController) -> Bool {

        guard let secondaryAsNavController = secondaryViewController as? UINavigationController else { return false }
        guard let topAsDetailController = secondaryAsNavController.topViewController as? MovieInfoViewController else { return false }
        if ((topAsDetailController.dataStore?.movie) != nil) {
            // Return true to indicate that we have handled the collapse by doing nothing; the secondary controller will be discarded.
            return true
        }
        return false
    }

}

