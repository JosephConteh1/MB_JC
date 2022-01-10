//
//  SceneDelegate.swift
//  SampleApp
//
//  Created by Joseph Conteh on 1/4/22.
//  Copyright © 2021 Ebay. All rights reserved.

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let navigationVC = UINavigationController()
        let mainVC = SearchViewController()
        navigationVC.pushViewController(mainVC, animated: false)
        window?.rootViewController = navigationVC
        window?.makeKeyAndVisible()
        
        UINavigationBar.appearance().barStyle = .black
        UINavigationBar.appearance().barTintColor = .systemBlue
        UINavigationBar.appearance().tintColor = .white
    }
}
