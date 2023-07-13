//
//  ChangeCellsOnSwipeUseCase.swift
//  Game2048
//
//  Created by Елена on 12.07.2023.
//

final class ChangeCellsOnSwipeUseCase {
	private var getCellNumberByNumberUseCase: GetCellNumberByNumberUseCase
	private var countCellInRow: Int
	
	init(getCellNumberByNumberUseCase: GetCellNumberByNumberUseCase, countCellInRow: Int) {
		self.getCellNumberByNumberUseCase = getCellNumberByNumberUseCase
		self.countCellInRow = countCellInRow
	}
	
	func changeCellsOnSwipe(cells: inout [CellGameFieldView], swipeType: SwipeType) -> [CellGameFieldView] {
		var newCells = [CellGameFieldView]()
		var mergeIndicies = [Int]()
		var sortedCells = cells.sorted { $0.position.y < $1.position.y }
		
		let startedCells = sortedCells.map({ $0.position })
		
		for i in 0..<sortedCells.count {
			for j in i+1..<sortedCells.count {
				if sortedCells[i].position.x == sortedCells[j].position.x &&
					sortedCells[i].number == sortedCells[j].number &&
					!mergeIndicies.contains(i) && !mergeIndicies.contains(j) {
					var thereIsCellsBeetween = false
					
					for n in 0..<sortedCells.count {
						if sortedCells[n].position.x == sortedCells[i].position.x &&
							((sortedCells[n].position.y > sortedCells[i].position.y && sortedCells[n].position.y < sortedCells[j].position.y) ||
							 (sortedCells[n].position.y < sortedCells[i].position.y && sortedCells[n].position.y > sortedCells[j].position.y)) {
							thereIsCellsBeetween = true
						}
					}
					
					if thereIsCellsBeetween {
						break
					}
					
					sortedCells[j].position.y = sortedCells[i].position.y
					
					mergeIndicies.append(contentsOf: [i, j])
					
					let newCell = CellGameFieldView(number: getCellNumberByNumberUseCase.getCellNumber(sortedCells[i].number.rawValue + sortedCells[j].number.rawValue), position: sortedCells[i].position)
					newCells.append(newCell)
					
					break
				}
			}
		}
		
		switch swipeType {
		case .up:
			return moveCellsUp(newCells: newCells, mergeIndicies: mergeIndicies, cells: &sortedCells, startedCells: startedCells)
		case .down:
			return []
		case .left:
			return []
		case .right:
			return []
		}
	}
}

private extension ChangeCellsOnSwipeUseCase {
	func moveCellsUp(newCells: [CellGameFieldView],
					 mergeIndicies: [Int],
					 cells: inout [CellGameFieldView],
					 startedCells: [CellPosition]) -> [CellGameFieldView] {
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
			return cells
		} else {
			for i in 0..<cells.count {
				if cells[i].position.x != startedCells[i].x || cells[i].position.y != startedCells[i].y {
					return cells
				}
			}
		}
		
		return []
	}
	
	//	func moveCellsDown(newCells: [CellGameFieldView],
	//					   mergeIndicies: [Int],
	//					   startedCells: [CellPosition]) -> Bool {
	//		var movedCells = [Int]()
	//
	//		for i in 0..<cells.count {
	//			if movedCells.contains(i) {
	//				continue
	//			}
	//
	//			var nearestCellPositionY: Int? = nil
	//			var minDistance: Int? = nil
	//
	//			for j in 0..<i {
	//				if cells[i].position.x == cells[j].position.x {
	//					if minDistance == nil {
	//						nearestCellPositionY = cells[j].position.y
	//						minDistance = abs(cells[i].position.y - cells[j].position.y)
	//					} else {
	//						if abs(cells[i].position.y - cells[j].position.y) < minDistance! {
	//							nearestCellPositionY = cells[j].position.y
	//							minDistance = abs(cells[i].position.y - cells[j].position.y)
	//						}
	//					}
	//				}
	//			}
	//
	//			if nearestCellPositionY == nil {
	//				if mergeIndicies.contains(i) {
	//					for n in 0..<mergeIndicies.count {
	//						if cells[i].position.x == cells[mergeIndicies[n]].position.x &&
	//							cells[i].position.y == cells[mergeIndicies[n]].position.y &&
	//							i != mergeIndicies[n] {
	//							for m in 0..<newCells.count {
	//								if cells[mergeIndicies[n]].position.x == newCells[m].position.x &&
	//									cells[mergeIndicies[n]].position.y == newCells[m].position.y {
	//									newCells[m].position.y = countCellInRow - 1
	//									break
	//								}
	//							}
	//
	//							movedCells.append(contentsOf: [i, mergeIndicies[n]])
	//
	//							cells[i].position.y = countCellInRow - 1
	//							cells[mergeIndicies[n]].position.y = countCellInRow - 1
	//						}
	//					}
	//				} else {
	//					movedCells.append(i)
	//
	//					cells[i].position.y = countCellInRow - 1
	//				}
	//			} else {
	//				if mergeIndicies.contains(i) {
	//					for n in 0..<mergeIndicies.count {
	//						if cells[i].position.x == cells[mergeIndicies[n]].position.x &&
	//							cells[i].position.y == cells[mergeIndicies[n]].position.y &&
	//							i != mergeIndicies[n] {
	//							for m in 0..<newCells.count {
	//								if cells[mergeIndicies[n]].position.x == newCells[m].position.x &&
	//									cells[mergeIndicies[n]].position.y == newCells[m].position.y {
	//									newCells[m].position.y = nearestCellPositionY! - 1
	//									break
	//								}
	//							}
	//
	//							movedCells.append(contentsOf: [i, mergeIndicies[n]])
	//
	//							cells[i].position.y = nearestCellPositionY! - 1
	//							cells[mergeIndicies[n]].position.y = nearestCellPositionY! - 1
	//						}
	//					}
	//				} else {
	//					movedCells.append(i)
	//					cells[i].position.y = nearestCellPositionY! - 1
	//				}
	//			}
	//		}
	//
	//		cells.append(contentsOf: newCells)
	//
	//		if cells.count != startedCells.count {
	//			return true
	//		} else {
	//			for i in 0..<cells.count {
	//				if cells[i].position.x != startedCells[i].x ||
	//					cells[i].position.y != startedCells[i].y {
	//					return true
	//				}
	//			}
	//		}
	//
	//		return false
	//	}
}

