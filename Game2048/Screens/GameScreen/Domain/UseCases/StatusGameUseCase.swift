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
			let x = cell.position.x
			let y = cell.position.y
			
			if x > 0 &&
				(cells.first(where: { $0.position.x == x - 1 && $0.position.y == y }) == nil ||
				 cells.contains(where: { $0.number == cell.number && $0.position.x == x - 1 && $0.position.y == y})) {
				return true
			}
		
			if y > 0 &&
				(cells.first(where: { $0.position.x == x && $0.position.y == y - 1 }) == nil ||
				 cells.contains(where: {$0.number == cell.number && $0.position.x == x && $0.position.y == y - 1})) {
				return true
			}
			
			if x < countCellInRow - 1 &&
				(cells.first(where: { $0.position.x == x + 1 && $0.position.y == y }) == nil ||
				cells.contains(where: { $0.number == cell.number && $0.position.x == x + 1 && $0.position.y == y })){
				return true
			}
			
			
			if y < countCellInRow - 1 &&
				(cells.first(where: { $0.position.x == x && $0.position.y == y + 1 }) == nil ||
				 cells.contains(where: { $0.number == cell.number && $0.position.x == x && $0.position.y == y + 1 })) {
				return true
			}
		}
		
		return false
	}
	
	func getGameStatus(cells: [CellGameFieldView]) -> GameStatus {
		if checkPossibileMoves(cells: cells) {
			return .playing
			
		}
		
		if isGameWon(cells: cells) {
			return .won
			
		}
		
		return .lost
	}
}
