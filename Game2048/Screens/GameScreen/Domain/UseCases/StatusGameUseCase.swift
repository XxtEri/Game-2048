//
//  StatusGameUseCase.swift
//  Game2048
//
//  Created by Елена on 14.07.2023.
//

final class StatusGameUseCase {
	private let numberWin: Int
	private let countCellInRow: Int
	
	init(numberWin: Int, countCellInRow: Int) {
		self.numberWin = numberWin
		self.countCellInRow = countCellInRow
	}
	
	func isGameWon(cells: [CellGameFieldView]) -> Bool {
		for cell in cells {
			if cell.number.rawValue == numberWin {
				return true
			}
		}
		
		return false
	}
	
	func checkPossibileMoves(cells: [CellGameFieldView]) -> Bool {
		for cell in cells {
			let row = cell.position.x
			let column = cell.position.y
			
			if column < countCellInRow - 1 &&
				(cells.first(where: { $0.position.x == row && $0.position.y == column + 1 }) == nil ||
				 cells.contains(where: { $0.number == cell.number && $0.position.x == row && $0.position.y == column + 1 })) {
				return true
				
			} else if row < countCellInRow - 1 &&
						(cells.first(where: { $0.position.x == row + 1 && $0.position.y == column }) == nil ||
						 cells.contains(where: { $0.number == cell.number && $0.position.x == row + 1 && $0.position.y == column })) {
				return true
				
			} else if column > 0 &&
						(cells.first(where: { $0.position.x == row && $0.position.y == column + 1 }) == nil ||
						 cells.contains(where: { $0.number == cell.number && $0.position.x == row && $0.position.y == column - 1 })) {
				return true
				
			} else if row > 0 &&
						(cells.first(where: { $0.position.x == row - 1 && $0.position.y == column }) == nil ||
						 cells.contains(where: { $0.number == cell.number && $0.position.x == row - 1 && $0.position.y == column })) {
				return true
			}
		}
		
		return false
	}
	
	func getGameStatus(cells: [CellGameFieldView]) -> GameStatus {
		if checkPossibileMoves(cells: cells) {
			return .playing
			
		} else if isGameWon(cells: cells) {
			return .won
			
		} else {
			return .lost
		}
	}
}
