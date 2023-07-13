//
//  SceneDelegate.swift
//  Game2048
//
//  Created by Елена on 09.07.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
	var window: UIWindow?

	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		guard let windowScene = (scene as? UIWindowScene) else { return }
		let window = UIWindow(windowScene: windowScene)
		let navigationController = UINavigationController(rootViewController: GameScreenViewController(viewModel: GameScreenViewModel(appearanceCellProvider: AppearanceCellProvider(), scoreManager: ScoreManager(), changeCellsOnSwipeUseCase: ChangeCellsOnSwipeUseCase(getCellNumberByNumberUseCase: GetCellNumberByNumberUseCase(), countCellInRow: 4))))
		
		window.rootViewController = navigationController
		
		self.window = window
		self.window?.makeKeyAndVisible()
	}
}
