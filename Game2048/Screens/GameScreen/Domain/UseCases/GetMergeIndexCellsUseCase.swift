//
//  GetMergeIndexCellsUseCase.swift
//  Game2048
//
//  Created by Елена on 13.07.2023.
//

class GetMergeIndexCellsUseCase {
	func getMergeIndexCells(cells: [CellGameFieldView]) -> [Int] {
		var mergeIndicies = [Int]()
		var movedIndicies = [Int]()
		
		for i in 0..<cells.count {
			for j in i+1..<cells.count {
				if movedIndicies.contains(j) {
					continue
				}
				
				if cells[i].position.x == cells[j].position.x &&
					cells[i].position.y == cells[j].position.y &&
					cells[i].number == cells[j].number {
					mergeIndicies.append(contentsOf: [i, j])
					
				} else if cells[i].position.x == cells[j].position.x &&
							cells[i].position.y == cells[j].position.y &&
							cells[i].number != cells[j].number {
					movedIndicies.append(j)
				}
			}
			
			movedIndicies.append(i)
		}
		
		return mergeIndicies
	}
}
