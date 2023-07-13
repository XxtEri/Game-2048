//
//  GameScreenViewController.swift
//  Game2048
//
//  Created by Елена on 09.07.2023.
//

import UIKit

class GameScreenViewController: UIViewController {
	private let ui = GameScreenView()
	private let viewModel: GameScreenViewModel
	
	init(viewModel: GameScreenViewModel) {
		self.viewModel = viewModel
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func loadView() {
		view = ui
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setHandlers()
		createStartCells()
	}
	
	private func createStartCells() {
		var cells = ui.gameField.cells
		let startCells = viewModel.generateStartCells()
		
		for cell in startCells {
			let curCell = viewModel.configureCellWithData(number: cell.number, position: cell.position)
			
			cells.append(curCell)
		}
		
		ui.gameField.cells = cells
		ui.gameField.addCellToView()
	}
}

private extension GameScreenViewController {
	func setHandlers() {
		ui.onSwipeUp = { [ weak self ] in
			guard let self = self else { return }
			
			if self.viewModel.changeCellsOnSwipe(swipeType: .up, cells: &ui.gameField.cells) {
				let mergeIndicies = self.viewModel.getMergeIndexCells(cells: ui.gameField.cells)
				let mergeCells = self.viewModel.getMergeCells(cells: ui.gameField.cells)
				
				self.ui.gameField.moveCellsWithAnimation(mergeIndicies: mergeIndicies, mergeCells: mergeCells)
			}
		}
		
		ui.updateScore = { [ weak self ] score in
			guard let self = self else { return }
			
			self.viewModel.saveScore(score)
			self.viewModel.saveMaxScore(score)
		}
		
		ui.gameField.getRandomCell = { [ weak self ] cells in
			self?.viewModel.generateNewCellWithRandomData(cells: cells) ?? nil
		}
		
		ui.gameField.getAppearanceProvider = { [ weak self ] in
			self?.viewModel.appearanceCellProvider ?? nil
		}
		
		viewModel.updateScoreInView = { [ weak self ] score in
			guard let self = self else { return }
			
			self.ui.setScore(score)
		}
		
		viewModel.updateMaxScoreInView = { [ weak self ] score in
			guard let self = self else { return }
			
			self.ui.setMaxScore(score)
		}
	}
}
