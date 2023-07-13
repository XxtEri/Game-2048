//
//  AppearanceCellProvider.swift
//  Game2048
//
//  Created by Елена on 13.07.2023.
//

import UIKit

final class AppearanceCellProvider: AppearanceCellProviderProtocol {
	func getCellBackgroundColor(for value: CellNumber) -> UIColor {
		return UIColor()
	}
	
	func getCellFontColor(for value: CellNumber) -> UIColor {
		return UIColor()
	}
}
