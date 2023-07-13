//
//  ConfigureCellUseCase.swift
//  Game2048
//
//  Created by Елена on 13.07.2023.
//

final class ConfigureCellUseCase {
	private let appearanceCellProvider: AppearanceCellProviderProtocol
	
	init(appearanceCellProvider: AppearanceCellProviderProtocol) {
		self.appearanceCellProvider = appearanceCellProvider
	}
	
	func configureCell(number: CellNumber, position: CellPosition) -> CellGameFieldView {
		let cell = CellGameFieldView(number: number, position: position)
		cell.setAppearanceCellProvider(appearanceCellProvider)
		
		return cell
	}
}
