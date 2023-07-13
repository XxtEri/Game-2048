//
//  ScreenFactory.swift
//  Game2048
//
//  Created by Елена on 13.07.2023.
//

import UIKit

protocol ScreenFactoryProtocol {
	func makeGameScreen() -> UIViewController
}

final class ScreenFactory {
	private let countCellInRow = 4
	private let appearanceCellProvider: AppearanceCellProviderProtocol
	private let scoreManager: ScoreManagerProtocol
	private let generateStartCellsUseCase: GenerateStartCellsUseCase
	private let changeCellsOnSwipeUseCase: ChangeCellsOnSwipeUseCase
	private let getMergedIndexCellsUseCase: GetMergeIndexCellsUseCase
	private let getMergeCellsUseCase: GetMergeCellsUseCase
	private let getCellNumberByNumberUseCase: GetCellNumberByNumberUseCase
	private let configureCellUseCase: ConfigureCellUseCase
	private let generateCellWithRandomData: GenerateCellWithRandomData
	
	init() {
		appearanceCellProvider = AppearanceCellProvider()
		scoreManager = ScoreManager()
		generateStartCellsUseCase = GenerateStartCellsUseCase(appearanceCellProvider: appearanceCellProvider)
		getCellNumberByNumberUseCase = GetCellNumberByNumberUseCase()
		changeCellsOnSwipeUseCase = ChangeCellsOnSwipeUseCase(getCellNumberByNumberUseCase: getCellNumberByNumberUseCase, countCellInRow: countCellInRow)
		getMergedIndexCellsUseCase = GetMergeIndexCellsUseCase()
		getMergeCellsUseCase = GetMergeCellsUseCase()
		configureCellUseCase = ConfigureCellUseCase(appearanceCellProvider: appearanceCellProvider)
		generateCellWithRandomData = GenerateCellWithRandomData(configureCellUseCase: configureCellUseCase)
	}
}

extension ScreenFactory: ScreenFactoryProtocol {
	func makeGameScreen() -> UIViewController {
		let viewModel = GameScreenViewModel(appearanceCellProvider: appearanceCellProvider,
											scoreManager: scoreManager,
											generateStartCellsUseCase: generateStartCellsUseCase,
											changeCellsOnSwipeUseCase: changeCellsOnSwipeUseCase,
											configureCellUseCase: configureCellUseCase,
											getMergedIndexCellsUseCase: getMergedIndexCellsUseCase,
											getMergeCellsUseCase: getMergeCellsUseCase,
											generateCellWithRandomData: generateCellWithRandomData)
		let viewController = GameScreenViewController(viewModel: viewModel)
		
		return viewController
	}
}
