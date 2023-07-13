//
//  SceneDelegate.swift
//  Game2048
//
//  Created by Елена on 09.07.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
	var window: UIWindow?
	
	private var mainRouter: IMainRouter?

	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		guard let windowScene = (scene as? UIWindowScene) else { return }
		let window = UIWindow(windowScene: windowScene)
		
		let screenFactory = ScreenFactory()
		
		mainRouter = MainRouter(screenFactory: screenFactory)
		
		let navigationController = mainRouter?.start()
		
		window.rootViewController = navigationController
		
		self.window = window
		self.window?.makeKeyAndVisible()
	}
}
