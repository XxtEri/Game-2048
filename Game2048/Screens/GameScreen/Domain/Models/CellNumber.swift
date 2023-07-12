//
//  CellNumber.swift
//  Game2048
//
//  Created by Елена on 12.07.2023.
//

enum CellNumber {
	case _2, _4, _8, _16, _32, _64, _128, _256, _512, _1024, _2048
	
	var rawValue: Int {
		switch self {
		case ._2:
			return 2
		case ._4:
			return 4
		case ._8:
			return 8
		case ._16:
			return 16
		case ._32:
			return 32
		case ._64:
			return 64
		case ._128:
			return 128
		case ._256:
			return 256
		case ._512:
			return 512
		case ._1024:
			return 1024
		case ._2048:
			return 2048
		}
	}
}
