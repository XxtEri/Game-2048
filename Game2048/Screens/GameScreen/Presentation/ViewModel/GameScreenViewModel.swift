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
	private var changeCellsOnSwipeUseCase: ChangeCellsOnSwipeUseCase
	
	init(appearanceCellProvider: AppearanceCellProviderProtocol,
		 scoreManager: ScoreManagerProtocol,
		 changeCellsOnSwipeUseCase: ChangeCellsOnSwipeUseCase) {
		self.appearanceCellProvider = appearanceCellProvider
		self.scoreManager = scoreManager
		self.changeCellsOnSwipeUseCase = changeCellsOnSwipeUseCase
	}
	
	func setRouter(_ router: GameScreenRouterProtocol) {
		self.router = router
	}
	
	func changeCellsOnSwipe(swipeType: SwipeType, cells: [CellGameFieldView]) -> Bool{
		changeCellsOnSwipeUseCase.changeCellsOnSwipe(cells: cells, swipeType: swipeType)
	}
}
