//
//  GenerateCellWithRandomData.swift
//  Game2048
//
//  Created by Елена on 13.07.2023.
//

final class GenerateCellWithRandomDataUseCase {
	private let configureCellUseCase: ConfigureCellUseCase
	
	init(configureCellUseCase: ConfigureCellUseCase) {
		self.configureCellUseCase = configureCellUseCase
	}
	
	func generate(cells: [CellGameFieldView], countCellInRow: Int) -> CellGameFieldView? {
		if cells.count < countCellInRow * countCellInRow {
			let availablePositions = getAvailablePosition(cells: cells, countCellInRow: countCellInRow)
			let randomAvailablePosition = Int.random(in: 0..<availablePositions.count)
			let chance = Int.random(in: 1...100)
			
			let cell = configureCellUseCase.configureCell(number: chance <= 90 ? ._2 : ._4, position: availablePositions[randomAvailablePosition])
			return cell
		}
		
		return nil
	}
	
	private func getAvailablePosition(cells: [CellGameFieldView], countCellInRow: Int) -> [CellPosition] {
		var availablePositions = [CellPosition]()
		
		for x in 0..<countCellInRow {
			for y in 0..<countCellInRow {
				var thereIsUnique = true
				
				for cell in cells {
					if cell.position.x == x && cell.position.y == y {
						thereIsUnique = false
						break
					}
				}
				
				if thereIsUnique {
					availablePositions.append(CellPosition(x: x, y: y))
				}
			}
		}
		
		return availablePositions
	}
}
