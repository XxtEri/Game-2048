//
//  CellGameFieldView.swift
//  Game2048
//
//  Created by Елена on 12.07.2023.
//

import UIKit
import SnapKit

class CellGameFieldView: UIView {
	var position: CellPosition
	var number: CellNumber
	
	private var id: UUID
	private weak var appearanceProvider: AppearanceCellProviderProtocol?
	
	private lazy var numberLabel: UILabel = {
		let view = UILabel()
		view.text = "\(number.rawValue)"
		view.textColor = appearanceProvider?.getCellFontColor(for: number)
		view.textAlignment = .center
		view.font = UIFont.systemFont(ofSize: 40, weight: .medium)
		
		return view
	}()

	init(number: CellNumber, position: CellPosition, appearanceProvider: AppearanceCellProviderProtocol? = nil) {
		self.number = number
		self.position = position
		self.appearanceProvider = appearanceProvider
		id = UUID()
		
		super.init(frame: .zero)
		
		setup()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func setAppearanceCellProvider(_ appearanceProvider: AppearanceCellProviderProtocol) {
		self.appearanceProvider = appearanceProvider
		
		configureTextColor()
		configureBackgroundColor()
	}
}

private extension CellGameFieldView {
	func setup() {
		configureUI()
		configureConstraints()
	}
	
	func configureUI() {
		backgroundColor = appearanceProvider?.getCellBackgroundColor(for: number)
		layer.cornerRadius = 5
		layer.masksToBounds = true
		
		addSubview(numberLabel)
	}
	
	func configureTextColor() {
		numberLabel.textColor = appearanceProvider?.getCellFontColor(for: number)
	}
	
	func configureBackgroundColor() {
		backgroundColor = appearanceProvider?.getCellBackgroundColor(for: number)
	}
	
	func configureConstraints() {
		numberLabel.snp.makeConstraints { make in
			make.center.equalToSuperview()
		}
	}
}
