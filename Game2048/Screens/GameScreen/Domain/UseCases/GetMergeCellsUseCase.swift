//
//  GetMergeCellsUseCase.swift
//  Game2048
//
//  Created by Елена on 13.07.2023.
//

final class GetMergeCellsUseCase {
	func getMergeCells(cells: [CellGameFieldView]) -> [CellGameFieldView] {
		var mergeCells = [CellGameFieldView]()
		var movedIndicies = [Int]()
		
		for i in 0..<cells.count {
			for j in i+1..<cells.count {
				if movedIndicies.contains(i) {
					continue
				}
				
				if cells[i].position.x == cells[j].position.x &&
					cells[i].position.y == cells[j].position.y &&
					cells[i].number != cells[j].number {
					let cell = (cells[i].number.rawValue > cells[j].number.rawValue) ? cells[i] : cells[j]
					
					mergeCells.append(cell)
					movedIndicies.append(j)
				}
			}
			
			movedIndicies.append(i)
		}
		
		return mergeCells
	}
}
