//
//  SceneDelegate.swift
//  MovieApp
//
//  Created by Admin on 02/04/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var windowScene: UIWindowScene?
    var number = 1

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.windowScene = windowScene
        window = UIWindow(frame: UIScreen.main.bounds)
       
        tabbarScreen()
         
    }
    
    func tabbarScreen() {
        if UserDefaults.standard.integer(forKey: "number") == 0 {
            number = 1
            UserDefaults.standard.setValue(number, forKey: "number")
            
        }else {
            number = UserDefaults.standard.integer(forKey: "number")
            number = number + 1
            UserDefaults.standard.setValue(number, forKey: "number")
        }
        let tab = TabBarController()
        let navi = UINavigationController(rootViewController: tab)
        navi.isNavigationBarHidden = true
        window?.rootViewController = navi
        window?.makeKeyAndVisible()
        window?.windowScene = windowScene
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
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
