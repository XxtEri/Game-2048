//
//  ActionGameFactoryProtocol.swift
//  Game2048
//
//  Created by Елена on 12.07.2023.
//

protocol ActionGameProtocol {
	func generateStartCells() -> [CellGameFieldView]
	func generateNewCellWithRandomData(cells: [CellGameFieldView]) -> CellGameFieldView?
	func configureCellWithData(number: CellNumber, position: CellPosition)  -> CellGameFieldView
	
	func fetchScore() -> Int
	func fetchMaxScore() -> Int
	func saveScore(_ score: Int)
	func saveMaxScore(_ score: Int)
	
	func getGameStatus(cells: [CellGameFieldView]) -> GameStatus
}
