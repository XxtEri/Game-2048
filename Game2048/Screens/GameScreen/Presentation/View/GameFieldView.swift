//
//  GameFieldView.swift
//  Game2048
//
//  Created by Елена on 11.07.2023.
//

import UIKit
import SnapKit

class GameFieldView: UIView {
	// MARK: - Handlers
	var  updateScoreHandler: ((Int) -> Void)?
	var getAppearanceProvider: (() -> AppearanceCellProviderProtocol?)?
	var getRandomCell: (([CellGameFieldView]) -> CellGameFieldView?)?
	
	var cells = [CellGameFieldView]()
	
	private var countCell = 4
	private var fieldWidth: CGFloat
	private var fieldHeight: CGFloat
	private var cellWidth: CGFloat
	private var cellHeight: CGFloat
	private var cellsPadding: CGFloat
	private var cellsGameField = [CellGameFieldView]()
	private weak var swipeDelegate: SwipeDelegate?
	
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
		view.backgroundColor = R.color.cellGameFieldBackground()
		view.layer.cornerRadius = 5
		view.layer.masksToBounds = true

		return view
	}
	
	func setSwipeDelegate(_ delegate: SwipeDelegate) {
		swipeDelegate = delegate
	}
	
	func addCellToView() {
		setupCells()
	}
	
	func moveCellsWithAnimation(mergeIndicies: [Int], mergeCells: [CellGameFieldView]) {
		self.isUserInteractionEnabled = false
		
		UIView.animate(withDuration: 0.2, animations: { [ self ] in
			for mergeCell in mergeCells {
				addCell(mergeCell)
			}
			
			for i in 0..<cells.count {
				configureCellConstraints(cell: cells[i])
			}
			
			self.layoutIfNeeded()
			
		}) { [ weak self ] _ in
			for i in mergeIndicies.sorted().reversed() {
				self?.cells[i].removeFromSuperview()
				self?.cells.remove(at: i)
			}
			
			self?.setupRandomCell()
		}
		
		self.isUserInteractionEnabled = true
	}
}

// MARK: - Setup extension
private extension GameFieldView {
	func setup() {
		configureUI()
		configureCells()
	}
	
	func setupCells() {
		for cell in cells {
			setupCell(cell)
		}
	}
	
	func setupCell(_ cell: CellGameFieldView) {
		cell.transform = CGAffineTransform(scaleX: 0, y: 0)
		
		addSubview(cell)
		
		UIView.animate(withDuration: 0.27, animations: { [ self ] in
			cell.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
			cell.snp.makeConstraints { make in
				make.top.equalToSuperview().inset(cellsPadding + CGFloat(cell.position.y) * (cellsPadding + cellHeight))
				make.leading.equalToSuperview().inset(cellsPadding + CGFloat(cell.position.x) * (cellsPadding + cellWidth))
				make.width.equalTo(cellWidth)
				make.height.equalTo(cellHeight)
			}
		}) { _ in
			UIView.animate(withDuration: 0.2) {
				cell.transform = .identity
			}
		}
	}
	
	func setupRandomCell() {
		if let newCell = getRandomCell?(cells) {
			cells.append(newCell)
			setupCell(newCell)
		}
	}
	
	func configureUI() {
		backgroundColor = R.color.gameFieldBackground()
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
	
	func configureCellConstraints(cell: CellGameFieldView) {
		cell.removeFromSuperview()
		addSubview(cell)

		cell.snp.makeConstraints { make in
			make.top.equalToSuperview().inset(cellsPadding + CGFloat(cell.position.y) * (cellsPadding + cellHeight))
			make.leading.equalToSuperview().inset(cellsPadding + CGFloat(cell.position.x) * (cellsPadding + cellWidth))
			make.width.equalTo(cellWidth)
			make.height.equalTo(cellHeight)
		}
	}
}

// MARK: Взаимодействие с ячейками игрового поля
extension GameFieldView {
	func addCell(_ cell: CellGameFieldView) {
		updateScoreHandler?(cell.number.rawValue)
		
		if let appearanceProvider = getAppearanceProvider?() {
			cell.setAppearanceCellProvider(appearanceProvider)
			setupCell(cell)
		}
	}
	
	func deleteAllCells() {
		cellsGameField.forEach { cell in
			cell.removeFromSuperview()
		}
	}
}
