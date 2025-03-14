//
//  SceneDelegate.swift
//  WeatherMVCIOS
//
//  Created by Evseev George on 13.03.25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }

        let networkProvider = NetworkProvider()
        let weatherService = WeatherService(networkProvider: networkProvider)

        let weatherVC = WeatherViewController(weatherService: weatherService)

        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = weatherVC
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) { }

    func sceneDidBecomeActive(_ scene: UIScene) { }

    func sceneWillResignActive(_ scene: UIScene) { }

    func sceneWillEnterForeground(_ scene: UIScene) { }

    func sceneDidEnterBackground(_ scene: UIScene) { }
}
