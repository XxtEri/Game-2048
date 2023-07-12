//
//  ChangeCellsOnSwipeUseCase.swift
//  Game2048
//
//  Created by Елена on 12.07.2023.
//

final class ChangeCellsOnSwipeUseCase {
	private var getCellNumberByNumberUseCase: GetCellNumberByNumberUseCase
	
	init(getCellNumberByNumberUseCase: GetCellNumberByNumberUseCase) {
		self.getCellNumberByNumberUseCase = getCellNumberByNumberUseCase
	}
	
	func changeCellsOnSwipe(cells: inout [CellGameFieldView], swipeType: SwipeType) -> Bool {
		var newCells = [CellGameFieldView]()
		var mergeIndicies = [Int]()
		
		cells = cells.sorted { $0.position.y < $1.position.y }
		
		var startedCells = cells.map({ $0.position })
		
		for i in 0..<cells.count {
			for j in i+1..<cells.count {
				if cells[i].position.x == cells[j].position.x &&
					cells[i].number == cells[j].number &&
					mergeIndicies.contains(i) && mergeIndicies.contains(j) {
					var thereIsCellsBeetween = false
					
					for n in 0..<cells.count {
						if cells[n].position.x == cells[i].position.x &&
							((cells[n].position.y > cells[i].position.y && cells[n].position.y < cells[j].position.y) ||
							 (cells[n].position.y < cells[i].position.y && cells[n].position.y > cells[j].position.y)) {
							thereIsCellsBeetween = true
						}
					}
					
					if thereIsCellsBeetween {
						break
					}
					
					cells[j].position.y = cells[i].position.y
					
					mergeIndicies.append(contentsOf: [i, j])
					
					let newCell: CellGameFieldView = CellGameFieldView(number: getCellNumberByNumberUseCase.getCellNumber(cells[i].number.rawValue + cells[j].number.rawValue), position: cells[i].position)
					newCells.append(newCell)
					break
				}
			}
		}
		
		switch swipeType {
		case .up:
			return moveCellsUp(newCells: &newCells, mergeIndicies: &mergeIndicies, cells: &cells, startedCells: &startedCells)
		case .down:
			return false
		case .left:
			return false
		case .right:
			return false
		}
	}
}

extension ChangeCellsOnSwipeUseCase {
	func moveCellsUp(newCells: inout [CellGameFieldView],
							  mergeIndicies: inout [Int],
							  cells: inout [CellGameFieldView],
							  startedCells: inout [CellPosition]) -> Bool {
		var movedCells = [Int]()
		for i in 0..<cells.count {
			if movedCells.contains(i) {
				continue
			}
			
			var nearestCellPositionY: Int? = nil
			var minDistance: Int? = nil
			
			for j in 0..<i {
				if cells[i].position.x == cells[j].position.x {
					if minDistance == nil {
						nearestCellPositionY = cells[j].position.y
						minDistance = abs(cells[i].position.y - cells[j].position.y)
						
					} else {
						if abs(cells[i].position.y - cells[j].position.y)  < minDistance! {
							nearestCellPositionY = cells[j].position.y
							minDistance = abs(cells[i].position.y - cells[j].position.y)
						}
					}
				}
			}
			
			if nearestCellPositionY == nil {
				if mergeIndicies.contains(i) {
					for n in 0..<mergeIndicies.count {
						if cells[i].position.x == cells[mergeIndicies[n]].position.x &&
							cells[i].position.y == cells[mergeIndicies[n]].position.y &&
							i != mergeIndicies[n] {
							
							for m in 0..<newCells.count {
								if cells[mergeIndicies[n]].position.x == newCells[m].position.x &&
									cells[mergeIndicies[n]].position.y == newCells[m].position.y {
									newCells[m].position.y = 0
									break
								}
							}
							
							movedCells.append(contentsOf: [i, mergeIndicies[n]])
							
							cells[i].position.y = 0
							cells[mergeIndicies[n]].position.y = 0
						}
					}
				} else {
					movedCells.append(i)
					cells[i].position.y = 0
				}
			} else {
				if mergeIndicies.contains(i) {
					for n in 0..<mergeIndicies.count {
						if cells[i].position.x == cells[mergeIndicies[n]].position.x &&
							cells[i].position.y == cells[mergeIndicies[n]].position.y &&
							i != mergeIndicies[n] {
							for m in 0..<newCells.count {
								if cells[mergeIndicies[n]].position.x == newCells[m].position.x &&
									cells[mergeIndicies[n]].position.y == newCells[m].position.y {
									newCells[m].position.y = nearestCellPositionY! + 1
									break
								}
							}
							
							movedCells.append(contentsOf: [i, mergeIndicies[n]])
							
							cells[i].position.y = nearestCellPositionY! + 1
							cells[mergeIndicies[n]].position.y = nearestCellPositionY! + 1
						}
					}
				} else {
					movedCells.append(i)
					cells[i].position.y = nearestCellPositionY! + 1
				}
			}
		}
		
		cells.append(contentsOf: newCells)
		
		if cells.count != startedCells.count {
			return true
		} else {
			for i in 0..<cells.count {
				if cells[i].position.x != startedCells[i].x || cells[i].position.y != startedCells[i].y {
					return true
				}
			}
		}
		
		return false
	}
}

