//
//  GameFieldView.swift
//  Game2048
//
//  Created by Елена on 11.07.2023.
//

import UIKit
import SnapKit

class GameFieldView: UIView {
	private var countCell = 4
	private var fieldWidth: CGFloat
	private var fieldHeight: CGFloat
	private var cellWidth: CGFloat
	private var cellHeight: CGFloat
	private var cellsPadding: CGFloat
	
	init(fieldWidth: CGFloat, fieldHeight: CGFloat) {
		self.fieldWidth = fieldWidth
		self.fieldHeight = fieldHeight
		cellsPadding = fieldWidth / CGFloat(countCell + countCell * 8 + 1)
		cellWidth = cellsPadding * 8
		cellHeight = cellWidth
		
		super.init(frame: .zero)
		
		setup()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func createEmptyCellView() -> UIView {
		let view = UIView()
		view.backgroundColor = .systemPink
		view.layer.cornerRadius = 5
		view.layer.masksToBounds = true

		return view
	}
}

// MARK: - Setup extension
private extension GameFieldView {
	func setup() {
		configureUI()
		configureCells()
	}
	
	func configureUI() {
		backgroundColor = .white
		layer.cornerRadius = 5
		layer.masksToBounds = true
	}
	
	func configureCells() {
		for x in 0..<countCell {
			for y in 0..<countCell {
				let emptyCell = createEmptyCellView()

				addSubview(emptyCell)
				emptyCell.snp.makeConstraints { make in
					make.leading.equalToSuperview().inset(CGFloat(x) * (cellsPadding + cellWidth) + cellsPadding)
					make.top.equalToSuperview().inset(CGFloat(y) * (cellsPadding + cellHeight) + cellsPadding)
					make.height.equalTo(cellHeight)
					make.width.equalTo(cellWidth)
				}
			}
		}
	}
}
