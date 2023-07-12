//
//  GameScreenViewModel.swift
//  Game2048
//
//  Created by Елена on 12.07.2023.
//

final class GameScreenViewModel {
	weak var router: GameScreenRouterProtocol?
	
	private var appearanceCellProvider: AppearanceCellProviderProtocol
	private var scoreManager: ScoreManagerProtocol
	
	init(appearanceCellProvider: AppearanceCellProviderProtocol, scoreManager: ScoreManagerProtocol) {
		self.appearanceCellProvider = appearanceCellProvider
		self.scoreManager = scoreManager
	}
	
	func setRouter(_ router: GameScreenRouterProtocol) {
		self.router = router
	}
}
