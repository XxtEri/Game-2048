//
//  GameScreenViewModel.swift
//  Game2048
//
//  Created by Елена on 12.07.2023.
//

final class GameScreenViewModel {
	// MARK: - Handlers
	var updateScoreInView: ((Int) -> Void)?
	var updateMaxScoreInView: ((Int) -> Void)?
	
	weak var router: GameScreenRouterProtocol?
	
	private(set) var appearanceCellProvider: AppearanceCellProviderProtocol
	private(set) var scoreManager: ScoreManagerProtocol
	
	private var generateStartCellsUseCase: GenerateStartCellsUseCase
	private var changeCellsOnSwipeUseCase: ChangeCellsOnSwipeUseCase
	private var configureCellUseCase: ConfigureCellUseCase
	private var getMergedIndexCellsUseCase: GetMergeIndexCellsUseCase
	private var getMergeCellsUseCase: GetMergeCellsUseCase
	private var generateCellWithRandomData: GenerateCellWithRandomData
	
	init(appearanceCellProvider: AppearanceCellProviderProtocol,
		 scoreManager: ScoreManagerProtocol,
		 generateStartCellsUseCase: GenerateStartCellsUseCase,
		 changeCellsOnSwipeUseCase: ChangeCellsOnSwipeUseCase,
		 configureCellUseCase: ConfigureCellUseCase,
		 getMergedIndexCellsUseCase: GetMergeIndexCellsUseCase,
		 getMergeCellsUseCase: GetMergeCellsUseCase,
		 generateCellWithRandomData: GenerateCellWithRandomData) {
		self.appearanceCellProvider = appearanceCellProvider
		self.scoreManager = scoreManager
		self.generateStartCellsUseCase = generateStartCellsUseCase
		self.changeCellsOnSwipeUseCase = changeCellsOnSwipeUseCase
		self.configureCellUseCase = configureCellUseCase
		self.getMergedIndexCellsUseCase = getMergedIndexCellsUseCase
		self.getMergeCellsUseCase = getMergeCellsUseCase
		self.generateCellWithRandomData = generateCellWithRandomData
	}
	
	func setRouter(_ router: GameScreenRouterProtocol) {
		self.router = router
	}
	
	func changeCellsOnSwipe(swipeType: SwipeType, cells: inout [CellGameFieldView]) -> Bool {
		changeCellsOnSwipeUseCase.changeCellsOnSwipe(cells: &cells, swipeType: swipeType)
	}
	
	func getMergeIndexCells(cells: [CellGameFieldView]) -> [Int] {
		getMergedIndexCellsUseCase.getMergeIndexCells(cells: cells)
	}
	
	func getMergeCells(cells: [CellGameFieldView]) -> [CellGameFieldView] {
		getMergeCellsUseCase.getMergeCells(cells: cells)
	}
}

extension GameScreenViewModel: ActionGameProtocol {
	func generateStartCells() -> [CellGameFieldView] {
		generateStartCellsUseCase.generate()
	}
	
	func generateNewCellWithRandomData(cells: [CellGameFieldView]) -> CellGameFieldView? {
		generateCellWithRandomData.generate(cells: cells, countCellInRow: 4)
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
		updateScoreInView?(fetchScore())
	}
	
	func saveMaxScore(_ score: Int) {
		scoreManager.saveMaxScore(score)
		updateMaxScoreInView?(fetchMaxScore())
	}
}
