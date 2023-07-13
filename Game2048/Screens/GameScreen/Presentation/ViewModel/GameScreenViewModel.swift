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
	
	private var generateStartCellsUseCase: GenerateStartCellsUseCase
	private var changeCellsOnSwipeUseCase: ChangeCellsOnSwipeUseCase
	private var configureCellUseCase: ConfigureCellUseCase
	
	init(appearanceCellProvider: AppearanceCellProviderProtocol,
		 scoreManager: ScoreManagerProtocol,
		 generateStartCellsUseCase: GenerateStartCellsUseCase,
		 changeCellsOnSwipeUseCase: ChangeCellsOnSwipeUseCase,
		 configureCellUseCase: ConfigureCellUseCase) {
		self.appearanceCellProvider = appearanceCellProvider
		self.scoreManager = scoreManager
		self.generateStartCellsUseCase = generateStartCellsUseCase
		self.changeCellsOnSwipeUseCase = changeCellsOnSwipeUseCase
		self.configureCellUseCase = configureCellUseCase
	}
	
	func setRouter(_ router: GameScreenRouterProtocol) {
		self.router = router
	}
	
	func changeCellsOnSwipe(swipeType: SwipeType, cells: [CellGameFieldView]) -> Bool{
		changeCellsOnSwipeUseCase.changeCellsOnSwipe(cells: cells, swipeType: swipeType)
	}
}

extension GameScreenViewModel: ActionGameProtocol {
	func generateStartCells() -> [CellGameFieldView] {
		generateStartCellsUseCase.generate()
	}
	
	func configureCellWithData(number: CellNumber, position: CellPosition) -> CellGameFieldView {
		configureCellUseCase.configureCell(number: number, position: position)
	}
	
	func fetchScore() -> Int {
		scoreManager.fetchScore()
	}
	
	func fetchMaxScore() -> Int {
		scoreManager.fetchMaxScore()
	}
	
	func saveScore(_ score: Int) {
		scoreManager.saveScore(score)
	}
	
	func saveMaxScore(_ score: Int) {
		scoreManager.saveMaxScore(score)
	}
}
