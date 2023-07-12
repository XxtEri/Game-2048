//
//  AppearanceProviderRepositoryProtocol.swift
//  Game2048
//
//  Created by Елена on 12.07.2023.
//

import UIKit

protocol AppearanceCellProviderProtocol: AnyObject {
	func getCellBackgroundColor(for value: CellNumber) -> UIColor
	func getCellFontColor(for value: CellNumber) -> UIColor
}
