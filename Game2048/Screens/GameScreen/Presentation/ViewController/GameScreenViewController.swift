//
//  GameScreenViewController.swift
//  Game2048
//
//  Created by Елена on 09.07.2023.
//

import UIKit

class GameScreenViewController: UIViewController {
	private let ui = GameScreenView()
	
	override func loadView() {
		view = ui
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}
}
