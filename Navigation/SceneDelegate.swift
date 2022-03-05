//
//  SceneDelegate.swift
//  Navigation
//
//  Created by Nikita Turgenev on 14.02.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        func createFeedViewController() -> UINavigationController {
            let feedViewController = FeedViewController()
            feedViewController.title = "Лента"
            feedViewController.tabBarItem = UITabBarItem(title: "Лента", image: UIImage(systemName: "doc.richtext"), tag: 0)
            
            return UINavigationController(rootViewController: feedViewController)
        }
        
        func createProfileController() -> UINavigationController {
            
            let profileViewController = ProfileViewController()
            profileViewController.title = "Профиль"
            
            profileViewController.tabBarItem = UITabBarItem(title: "Профиль", image: UIImage(systemName: "person.circle"), tag: 1)
            
            return UINavigationController(rootViewController: profileViewController)
        }
        
        func createPostController() -> UINavigationController {
            
            let postViewController = PostViewController()
            postViewController.title = "Пост"
            
            
            
            return UINavigationController(rootViewController: postViewController)
        }
        
        
        func createTabBarController() -> UITabBarController {
            let tabBarController = UITabBarController()
            UITabBar.appearance().backgroundColor = .systemGreen
            tabBarController.viewControllers = [createFeedViewController(),createProfileController()]
            return tabBarController
        }
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = createTabBarController()
        window?.makeKeyAndVisible()
        
        
        
    }

    func sceneDidDisconnect(_ scene: UIScene) {
       
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        
    }

    func sceneWillResignActive(_ scene: UIScene) {
       
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        
    }


}

