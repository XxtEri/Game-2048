//
//  MainRouter.swift
//  Game2048
//
//  Created by Елена on 12.07.2023.
//

import UIKit

protocol IMainRouter {
	func start() -> UINavigationController
}

final class MainRouter: IMainRouter {
	private let screenFactory: ScreenFactoryProtocol
	private var navigationViewController: UINavigationController?
	
	init(screenFactory: ScreenFactoryProtocol) {
		self.screenFactory = screenFactory
	}
	
	func start() -> UINavigationController {
		let startViewController = screenFactory.makeGameScreen()
		let navigationViewController = UINavigationController(rootViewController: startViewController)
		
		self.navigationViewController = navigationViewController
		
		return navigationViewController
	}
}
