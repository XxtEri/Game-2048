//
//  AppearanceCellProvider.swift
//  Game2048
//
//  Created by Елена on 13.07.2023.
//

import UIKit

final class AppearanceCellProvider: AppearanceCellProviderProtocol {
	func getCellBackgroundColor(for value: CellNumber) -> UIColor {
		switch value {
		case ._2:
			return R.color.backgroundForCell2() ?? .gray
		case ._4:
			return R.color.backgroundForCell4() ?? .gray
		case ._8:
			return R.color.backgroundForCell8() ?? .gray
		case ._16:
			return R.color.backgroundForCell16() ?? .gray
		case ._32:
			return R.color.backgroundForCell32() ?? .gray
		case ._64:
			return R.color.backgroundForCell64() ?? .gray
		case ._128:
			return R.color.backgroundForCell128() ?? .gray
		case ._256:
			return R.color.backgroundForCell256() ?? .gray
		case ._512:
			return R.color.backgroundForCell512() ?? .gray
		case ._1024:
			return R.color.backgroundForCell1024() ?? .gray
		case ._2048:
			return R.color.backgroundForCell2048() ?? .gray
		}
	}
	
	func getCellFontColor(for value: CellNumber) -> UIColor {
		switch value {
		case ._2:
			return R.color.fontColorForCell2() ?? .gray
		case ._4:
			return R.color.fontColorForCell4() ?? .gray
		case ._8:
			return R.color.fontColorForCell8() ?? .gray
		case ._16:
			return R.color.fontColorForCell16() ?? .gray
		case ._32:
			return R.color.fontColorForCell32() ?? .gray
		case ._64:
			return R.color.fontColorForCell64() ?? .gray
		case ._128:
			return R.color.fontColorForCell128() ?? .gray
		case ._256:
			return R.color.fontColorForCell256() ?? .gray
		case ._512:
			return R.color.fontColorForCell512() ?? .gray
		case ._1024:
			return R.color.fontColorForCell1024() ?? .gray
		case ._2048:
			return R.color.fontColorForCell2048() ?? .gray
		}
	}
}
