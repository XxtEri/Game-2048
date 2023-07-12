//
//  ActionGameFactory.swift
//  Game2048
//
//  Created by Елена on 12.07.2023.
//

final class ActionGameFactory {
	private var scoreManager: ScoreManagerProtocol
	
	init(scoreManager: ScoreManagerProtocol) {
		self.scoreManager = scoreManager
	}
}

extension ActionGameFactory: ActionGameFactoryProtocol {
	func generateStartCells() -> [CellGameFieldView] {
		return []
	}
	
	func generateNewCellWithRandomData() -> CellGameFieldView {
		return CellGameFieldView(number: ._1024, position: CellPosition(x: 1, y: 1))
	}
	
	func generateNewCellWithData(number: CellNumber, position: (Int, Int)) {
		
	}
	
	func fetchScore() {
		
	}
	
	func fetchMaxScore() {
		
	}

	func fetchScore() -> Int {
		return 1
	}
	
	func fetchMaxScore() -> Int {
		return 10
	}
	
	func saveScore(_ score: Int) {
		
	}
	
	func saveMaxScore(_ score: Int) {
		
	}
	
	func saveGame(cells: [CellGameFieldView]) {
		
	}
}
