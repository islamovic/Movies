//
//  SceneDelegate.swift
//  Movies
//
//  Created by Islam on 1/22/20.
//  Copyright © 2020 App Lineup. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        if let windowScene = scene as? UIWindowScene {

            let window = UIWindow(windowScene: windowScene)

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

            self.window = window
            window.rootViewController = splitViewController
            window.makeKeyAndVisible()
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
}

@available(iOS 13.0, *)
extension SceneDelegate: UISplitViewControllerDelegate {

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

