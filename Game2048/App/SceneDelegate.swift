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
		
		let appearance = AppearanceCellProvider()
		let navigationController = UINavigationController(rootViewController: GameScreenViewController(viewModel: GameScreenViewModel(appearanceCellProvider: appearance, scoreManager: ScoreManager(), generateStartCellsUseCase: GenerateStartCellsUseCase(appearanceCellProvider: appearance), changeCellsOnSwipeUseCase: ChangeCellsOnSwipeUseCase(getCellNumberByNumberUseCase: GetCellNumberByNumberUseCase(), countCellInRow: 4), configureCellUseCase: ConfigureCellUseCase(appearanceCellProvider: appearance))))
		
		window.rootViewController = navigationController
		
		self.window = window
		self.window?.makeKeyAndVisible()
	}
}
