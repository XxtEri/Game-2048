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
	}
	
	private func moveAnimationCell() {
		var mergeIndicicies = [Int]()
		
		view.isUserInteractionEnabled = false
		
//		UIView.animate(withDuration: 0.2) { [ self ] in
//
//		}
	}
}

private extension GameScreenViewController {
	func setHandlers() {
		ui.onSwipeUp = { [ weak self ] cells in
			if ((self?.viewModel.changeCellsOnSwipe(swipeType: .up, cells: cells)) != nil) {
				print("Up")
				//Animation
			}
		}
	}
}
