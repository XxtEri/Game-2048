//
//  ActionGameFactoryProtocol.swift
//  Game2048
//
//  Created by Елена on 12.07.2023.
//

protocol ActionGameFactoryProtocol {
	func generateStartCells() -> [CellGameFieldView]
	func generateNewCellWithRandomData() -> CellGameFieldView
	func generateNewCellWithData(number: CellNumber, position:(Int, Int))
	
	func fetchScore() -> Int
	func fetchMaxScore() -> Int
	func saveScore(_ score: Int)
	func saveMaxScore(_ score: Int)
	
	func saveGame(cells: [CellGameFieldView])
}
