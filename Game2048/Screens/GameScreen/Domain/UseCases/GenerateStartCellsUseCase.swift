//
//  GenerateStartCellsUseCase.swift
//  Game2048
//
//  Created by Елена on 12.07.2023.
//

final class GenerateStartCellsUseCase {
	private let appearanceCellProvider: AppearanceCellProviderProtocol
	
	init(appearanceCellProvider: AppearanceCellProviderProtocol) {
		self.appearanceCellProvider = appearanceCellProvider
	}
	
	private func generateRandomCellPosition() -> CellPosition{
		return CellPosition(x: Int.random(in: 0...2), y: Int.random(in: 0...2))
	}
	
	func generate() -> [CellGameFieldView] {
		var startCells = [CellGameFieldView]()
		
		let firstRandomCellPosition = generateRandomCellPosition()
		let firstRandomChange = Int.random(in: 1...100)
		
		var secondRandomCellPosition = generateRandomCellPosition()
		let secondRandomChange = Int.random(in: 1...100)
		
		while firstRandomCellPosition.x == secondRandomCellPosition.x &&
				firstRandomCellPosition.y == secondRandomCellPosition.y {
			secondRandomCellPosition = generateRandomCellPosition()
		}
		
		let firstCell = CellGameFieldView(number: firstRandomChange <= 90 ? ._2 : ._4, position: firstRandomCellPosition)
		firstCell.setAppearanceCellProvider(appearanceCellProvider)
		
		let secondCell = CellGameFieldView(number: secondRandomChange <= 90 ? ._2 : ._4, position: secondRandomCellPosition)
		secondCell.setAppearanceCellProvider(appearanceCellProvider)
		
		startCells.append(firstCell)
		startCells.append(secondCell)
		
		return startCells
	}
}
